Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134CC433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347020AbiDAO2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346983AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3972856B2
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:26 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEM-009TW3-7r; Fri, 01 Apr 2022 15:26:25 +0100
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
Subject: [PATCH v5 15/22] git-p4: ensure every comment has a single #
Date:   Fri,  1 Apr 2022 15:24:57 +0100
Message-Id: <20220401142504.58995-16-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that every comment should begin with a single '#'
character.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#comments

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 167bc19775..88c2b5213e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -895,7 +895,7 @@ def branchExists(ref):
 def extractLogMessageFromGitCommit(commit):
     logMessage = ""
 
-    ## fixme: title is first line of commit, not 1st paragraph.
+    # fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
         if not foundTitle:
@@ -3485,7 +3485,7 @@ def getBranchMapping(self):
                     continue
                 source = paths[0]
                 destination = paths[1]
-                ## HACK
+                # HACK
                 if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
@@ -3644,7 +3644,7 @@ def importChanges(self, changes, origin_revision=0):
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
                     for branch in branches.keys():
-                        ## HACK  --hwn
+                        # HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [branchPrefix]
 
@@ -4035,7 +4035,7 @@ def run(self, args):
             self.getLabels()
 
         if self.detectBranches:
-            ## FIXME - what's a P4 projectName ?
+            # FIXME - what's a P4 projectName ?
             self.projectName = self.guessProjectName()
 
             if self.hasOrigin:
@@ -4048,7 +4048,7 @@ def run(self, args):
             for b in self.p4BranchesInGit:
                 if b != "master":
 
-                    ## FIXME
+                    # FIXME
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
@@ -4154,7 +4154,7 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
-        ## TODO: use common prefix of args?
+        # TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
-- 
2.35.GIT

