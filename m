Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525EFC4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiDAPE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349717AbiDAOqp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:46:45 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB6F29E4C3
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:36:25 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIE3-009TW3-SM; Fri, 01 Apr 2022 15:26:07 +0100
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
Subject: [PATCH v5 08/22] git-p4: remove padding from lists, tuples and function arguments
Date:   Fri,  1 Apr 2022 15:24:50 +0100
Message-Id: <20220401142504.58995-9-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages use of extraneous padding inside any parenthesis,
brackets or braces in the "Pet Peeves" section:

https://www.python.org/dev/peps/pep-0008/#pet-peeves

This patch removes all cases of these.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 52c4cac683..f8d07cfd7f 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -952,10 +952,10 @@ def gitDeleteRef(ref):
 
 def gitConfig(key, typeSpecifier=None):
     if key not in _gitConfig:
-        cmd = [ "git", "config" ]
+        cmd = ["git", "config"]
         if typeSpecifier:
-            cmd += [ typeSpecifier ]
-        cmd += [ key ]
+            cmd += [typeSpecifier]
+        cmd += [key]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
@@ -974,7 +974,7 @@ def gitConfigBool(key):
 
 def gitConfigInt(key):
     if key not in _gitConfig:
-        cmd = [ "git", "config", "--int", key ]
+        cmd = ["git", "config", "--int", key]
         s = read_pipe(cmd, ignore_error=True)
         v = s.strip()
         try:
@@ -1030,7 +1030,7 @@ def p4BranchesInGit(branchesAreInRemotes=True):
 def branch_exists(branch):
     """Make sure that the given ref name really exists."""
 
-    cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
+    cmd = ["git", "rev-parse", "--symbolic", "--verify", branch]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
     out = decode_text_stream(out)
@@ -1246,7 +1246,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [k for k in entry.keys() if k.startswith("View")]
 
     # hold this new View
     view = View(client_name)
@@ -1512,8 +1512,8 @@ def processContent(self, git_mode, relPath, contents):
 
 
 class Command:
-    delete_actions = ( "delete", "move/delete", "purge" )
-    add_actions = ( "add", "branch", "move/add" )
+    delete_actions = ("delete", "move/delete", "purge")
+    add_actions = ("add", "branch", "move/add")
 
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -2521,7 +2521,7 @@ def run(self, args):
                     sys.exit(1)
             except Exception as e:
                 print("\nThe p4-pre-submit hook failed, aborting the submit.\n\nThe hook failed "\
-                    "with the error '{0}'".format(e.message) )
+                    "with the error '{0}'".format(e.message))
                 sys.exit(1)
 
         #
@@ -2726,7 +2726,7 @@ def map_in_client(self, depot_path):
         if depot_path in self.client_spec_path_cache:
             return self.client_spec_path_cache[depot_path]
 
-        die( "Error: %s is not found in client spec path" % depot_path )
+        die("Error: %s is not found in client spec path" % depot_path)
         return ""
 
 
@@ -3024,7 +3024,7 @@ def streamOneP4File(self, file, contents):
             else:
                 if p4_version_string().find('/NT') >= 0:
                     text = text.replace(b'\r\n', b'\n')
-                contents = [ text ]
+                contents = [text]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
@@ -3646,7 +3646,7 @@ def importChanges(self, changes, origin_revision=0):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
-                        self.branchPrefixes = [ branchPrefix ]
+                        self.branchPrefixes = [branchPrefix]
 
                         parent = ""
 
@@ -3754,7 +3754,7 @@ def importHeadRevision(self, revision):
             if info["action"] in self.delete_actions:
                 continue
 
-            for prop in ["depotFile", "rev", "action", "type" ]:
+            for prop in ["depotFile", "rev", "action", "type"]:
                 details["%s%s" % (prop, fileCnt)] = info[prop]
 
             fileCnt = fileCnt + 1
@@ -3908,7 +3908,7 @@ def run(self, args):
             if branch_arg_given:
                 short = self.branch.split("/")[-1]
                 if short in branches:
-                    self.p4BranchesInGit = [ short ]
+                    self.p4BranchesInGit = [short]
             else:
                 self.p4BranchesInGit = branches.keys()
 
@@ -4190,7 +4190,7 @@ def run(self, args):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
 
-        init_cmd = [ "git", "init" ]
+        init_cmd = ["git", "init"]
         if self.cloneBare:
             init_cmd.append("--bare")
         retcode = subprocess.call(init_cmd)
@@ -4202,9 +4202,9 @@ def run(self, args):
 
         # create a master branch and check out a work tree
         if gitBranchExists(self.branch):
-            system([ "git", "branch", currentGitBranch(), self.branch ])
+            system(["git", "branch", currentGitBranch(), self.branch])
             if not self.cloneBare:
-                system([ "git", "checkout", "-f" ])
+                system(["git", "checkout", "-f"])
         else:
             print('Not checking out any branch, use ' \
                   '"git checkout -q -b master <branch>"')
@@ -4335,7 +4335,7 @@ def run(self, args):
 class P4Branches(Command):
     def __init__(self):
         Command.__init__(self)
-        self.options = [ ]
+        self.options = []
         self.description = ("Shows the git branches that hold imports and their "
                             + "corresponding perforce depot paths")
         self.verbose = False
-- 
2.35.GIT

