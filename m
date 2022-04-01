Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5D5C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349322AbiDAPE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbiDAOpl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:45:41 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804DA29A542
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:35:36 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDf-009TW3-56; Fri, 01 Apr 2022 15:25:42 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 02/22] git-p4: remove unneeded semicolons from statements
Date:   Fri,  1 Apr 2022 15:24:44 +0100
Message-Id: <20220401142504.58995-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python allows the usage of compound statements where multiple statements
are written on a single line separared by semicolons. It is also
possible to add a semicolon after a single statement, however this is
generally considered to be untidy, and is unnecessary.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 265182b088..aabf657a57 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -813,7 +813,7 @@ def p4Cmd(cmd, *k, **kw):
     result = {}
     for entry in list:
         result.update(entry)
-    return result;
+    return result
 
 
 def p4Where(depotPath):
@@ -914,8 +914,8 @@ def extractSettingsGitLog(log):
 
 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
-                            stderr=subprocess.PIPE, stdout=subprocess.PIPE);
-    return proc.wait() == 0;
+                            stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+    return proc.wait() == 0
 
 
 def gitUpdateRef(ref, newvalue):
@@ -3530,8 +3530,8 @@ def gitCommitByP4Change(self, ref, change):
     def importNewBranch(self, branch, maxChange):
         # make fast-import flush all changes to disk and update the refs using the checkpoint
         # command so that we can try to find the branch parent in the git history
-        self.gitStream.write("checkpoint\n\n");
-        self.gitStream.flush();
+        self.gitStream.write("checkpoint\n\n")
+        self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
         #print "prefix" + branchPrefix
@@ -3607,12 +3607,12 @@ def importChanges(self, changes, origin_revision=0):
                                 fullBranch = self.projectName + branch
                                 if fullBranch not in self.p4BranchesInGit:
                                     if not self.silent:
-                                        print("\n    Importing new branch %s" % fullBranch);
+                                        print("\n    Importing new branch %s" % fullBranch)
                                     if self.importNewBranch(branch, change - 1):
                                         parent = ""
                                         self.p4BranchesInGit.append(fullBranch)
                                     if not self.silent:
-                                        print("\n    Resuming with change %s" % change);
+                                        print("\n    Resuming with change %s" % change)
 
                                 if self.verbose:
                                     print("parent determined through known branches: %s" % parent)
@@ -3680,7 +3680,7 @@ def importHeadRevision(self, revision):
                                  % info['data'])
                 if info['data'].find("must refer to client") >= 0:
                     sys.stderr.write("This particular p4 error is misleading.\n")
-                    sys.stderr.write("Perhaps the depot path was misspelled.\n");
+                    sys.stderr.write("Perhaps the depot path was misspelled.\n")
                     sys.stderr.write("Depot path:  %s\n" % " ".join(self.depotPaths))
                 sys.exit(1)
             if 'p4ExitCode' in info:
@@ -3789,7 +3789,7 @@ def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
                                               stdout=subprocess.PIPE,
-                                              stderr=subprocess.PIPE);
+                                              stderr=subprocess.PIPE)
         self.gitOutput = self.importProcess.stdout
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
@@ -3975,7 +3975,7 @@ def run(self, args):
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-            self.getLabels();
+            self.getLabels()
 
         if self.detectBranches:
             ## FIXME - what's a P4 projectName ?
@@ -4061,9 +4061,9 @@ def run(self, args):
 
     def rebase(self):
         if os.system("git update-index --refresh") != 0:
-            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
+            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
         if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
-            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
+            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
 
         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
@@ -4362,7 +4362,7 @@ def main():
                                    formatter = HelpFormatter())
 
     try:
-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
     except:
         parser.print_help()
         raise
@@ -4378,7 +4378,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe(["git", "rev-parse", "--show-cdup"]).strip()
                     if len(cdup) > 0:
-                        chdir(cdup);
+                        chdir(cdup)
 
         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):
-- 
2.35.GIT

