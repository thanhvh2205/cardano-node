module Parsers.Version
  ( VersionOptions(..)
  , cmdVersion
  , runVersionOptions
  ) where

import           Cardano.Git.Rev (gitRev)
import           Data.Version (showVersion)
import           Options.Applicative
import           Paths_cardano_testnet (version)
import           System.Info (arch, compilerName, compilerVersion, os)

import qualified Data.Text as T
import qualified System.IO as IO

data VersionOptions = VersionOptions deriving (Eq, Show)

optsVersion :: Parser VersionOptions
optsVersion = pure VersionOptions

runVersionOptions :: VersionOptions -> IO ()
runVersionOptions VersionOptions = do
  IO.putStrLn $ mconcat
    [ "cardano-node ", showVersion version
    , " - ", os, "-", arch
    , " - ", compilerName, "-", showVersion compilerVersion
    , "\ngit rev ", T.unpack gitRev
    ]

cmdVersion :: Mod CommandFields (IO ())
cmdVersion = command "version" $ flip info idm $ runVersionOptions <$> optsVersion
