From: Sam Hocevar <sam@zoy.org>
Subject: [PATCH] git-p4: remove unnecessary semicolons at end of lines
Date: Fri, 6 Mar 2009 16:53:22 +0100
Message-ID: <20090306155322.GC12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 16:55:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfcO5-0007D5-2p
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbZCFPxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZCFPxa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:53:30 -0500
Received: from poulet.zoy.org ([80.65.228.129]:59925 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbZCFPx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 10:53:29 -0500
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id D241B1203FA; Fri,  6 Mar 2009 16:53:22 +0100 (CET)
Content-Disposition: inline
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112453>

   This is a purely cosmetic patch that makes the git-p4 code look more
pythonish by getting rid of end-of-line semicolons.


git-p4: remove unnecessary semicolons at end of lines.

Signed-off-by: Sam Hocevar <sam@zoy.org>
---
 contrib/fast-import/git-p4 |   46 ++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3832f60..7ea5ac6 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -12,7 +12,7 @@ import optparse, sys, os, marshal, popen2, subprocess, shelve
 import tempfile, getopt, sha, os.path, time, platform
 import re

-from sets import Set;
+from sets import Set

 verbose = False

@@ -240,7 +240,7 @@ def p4Cmd(cmd):
     result = {}
     for entry in list:
         result.update(entry)
-    return result;
+    return result

 def p4Where(depotPath):
     if not depotPath.endswith("/"):
@@ -281,7 +281,7 @@ def currentGitBranch():
 def isValidGitDir(path):
     if (os.path.exists(path + "/HEAD")
         and os.path.exists(path + "/refs") and os.path.exists(path + "/objects")):
-        return True;
+        return True
     return False

 def parseRevision(ref):
@@ -328,8 +328,8 @@ def extractSettingsGitLog(log):

 def gitBranchExists(branch):
     proc = subprocess.Popen(["git", "rev-parse", branch],
-                            stderr=subprocess.PIPE, stdout=subprocess.PIPE);
-    return proc.wait() == 0;
+                            stderr=subprocess.PIPE, stdout=subprocess.PIPE)
+    return proc.wait() == 0

 _gitConfig = {}
 def gitConfig(key):
@@ -492,7 +492,7 @@ class P4RollBack(Command):
         maxChange = int(args[0])

         if "p4ExitCode" in p4Cmd("changes -m 1"):
-            die("Problems executing p4");
+            die("Problems executing p4")

         if self.rollbackLocalBranches:
             refPrefix = "refs/heads/"
@@ -663,7 +663,7 @@ class P4Submit(Command):
             if response == "s":
                 print "Skipping! Good luck with the next patches..."
                 for f in editedFiles:
-                    p4_system("revert \"%s\"" % f);
+                    p4_system("revert \"%s\"" % f)
                 for f in filesToAdd:
                     system("rm %s" %f)
                 return
@@ -734,7 +734,7 @@ class P4Submit(Command):
             if os.environ.has_key("P4EDITOR"):
                 editor = os.environ.get("P4EDITOR")
             else:
-                editor = os.environ.get("EDITOR", defaultEditor);
+                editor = os.environ.get("EDITOR", defaultEditor)
             system(editor + " " + fileName)

             response = "y"
@@ -753,9 +753,9 @@ class P4Submit(Command):
                 p4_write_pipe("submit -i", submitTemplate)
             else:
                 for f in editedFiles:
-                    p4_system("revert \"%s\"" % f);
+                    p4_system("revert \"%s\"" % f)
                 for f in filesToAdd:
-                    p4_system("revert \"%s\"" % f);
+                    p4_system("revert \"%s\"" % f)
                     system("rm %s" %f)

             os.remove(fileName)
@@ -977,9 +977,9 @@ class P4Sync(Command):

             if "p4ExitCode" in filedata[0]:
                 die("Problems executing p4. Error: [%d]."
-                    % (filedata[0]['p4ExitCode']));
+                    % (filedata[0]['p4ExitCode']))

-        j = 0;
+        j = 0
         contents = {}
         while j < len(filedata):
             stat = filedata[j]
@@ -1303,8 +1303,8 @@ class P4Sync(Command):
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
@@ -1364,12 +1364,12 @@ class P4Sync(Command):
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
                                     print "parent determined through known branches: %s" % parent
@@ -1485,7 +1485,7 @@ class P4Sync(Command):
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
                 system("git update-ref %s refs/heads/p4" % self.branch)
-                system("git branch -D p4");
+                system("git branch -D p4")
             # create it /after/ importing, when master exists
             if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
@@ -1591,7 +1591,7 @@ class P4Sync(Command):
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-            self.getLabels();
+            self.getLabels()

         if self.detectBranches:
             ## FIXME - what's a P4 projectName ?
@@ -1615,7 +1615,7 @@ class P4Sync(Command):

         importProcess = subprocess.Popen(["git", "fast-import"],
                                          stdin=subprocess.PIPE, stdout=subprocess.PIPE,
-                                         stderr=subprocess.PIPE);
+                                         stderr=subprocess.PIPE)
         self.gitOutput = importProcess.stdout
         self.gitStream = importProcess.stdin
         self.gitError = importProcess.stderr
@@ -1688,9 +1688,9 @@ class P4Rebase(Command):

     def rebase(self):
         if os.system("git update-index --refresh") != 0:
-            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up-to-date or stash away all your changes with git stash.");
+            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up-to-date or stash away all your changes with git stash.")
         if len(read_pipe("git diff-index HEAD --")) > 0:
-            die("You have uncommited changes. Please commit them before rebasing or stash them away with git stash.");
+            die("You have uncommited changes. Please commit them before rebasing or stash them away with git stash.")

         [upstream, settings] = findUpstreamBranchPoint()
         if len(upstream) == 0:
@@ -1866,7 +1866,7 @@ def main():
                                        description = cmd.description,
                                        formatter = HelpFormatter())

-        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
@@ -1877,7 +1877,7 @@ def main():
                 if os.path.exists(cmd.gitdir):
                     cdup = read_pipe("git rev-parse --show-cdup").strip()
                     if len(cdup) > 0:
-                        chdir(cdup);
+                        chdir(cdup)

         if not isValidGitDir(cmd.gitdir):
             if isValidGitDir(cmd.gitdir + "/.git"):

-- 
Sam.
