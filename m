Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40AC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbiDAO2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346907AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D18284E50
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:23 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEI-009TW3-EH; Fri, 01 Apr 2022 15:26:21 +0100
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
Subject: [PATCH v5 11/22] git-p4: place a single space after every comma
Date:   Fri,  1 Apr 2022 15:24:53 +0100
Message-Id: <20220401142504.58995-12-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves consistency across git-p4 by ensuring all command
separated arguments to function invocations, tuples and lists are
separated by commas with a single space following.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0d444d2aa4..c9081d79ac 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -99,7 +99,7 @@ def p4_build_cmd(cmd):
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += ["-u",user]
+        real_cmd += ["-u", user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
@@ -1766,7 +1766,7 @@ def patchRCSKeywords(self, file, regexp):
 
         print("Patched up RCS keywords in %s" % file)
 
-    def p4UserForCommit(self,id):
+    def p4UserForCommit(self, id):
         """Return the tuple (perforce user,git email) for a given git commit
            id.
            """
@@ -1775,11 +1775,11 @@ def p4UserForCommit(self,id):
                               "--format=%ae", id])
         gitEmail = gitEmail.strip()
         if gitEmail not in self.emails:
-            return (None,gitEmail)
+            return (None, gitEmail)
         else:
-            return (self.emails[gitEmail],gitEmail)
+            return (self.emails[gitEmail], gitEmail)
 
-    def checkValidP4Users(self,commits):
+    def checkValidP4Users(self, commits):
         """Check if any git authors cannot be mapped to p4 users."""
         for id in commits:
             user, email = self.p4UserForCommit(id)
@@ -3203,7 +3203,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print("labelDetails=", labelDetails)
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3409,7 +3409,7 @@ def importP4Labels(self, stream, p4Labels):
 
             if not m.match(name):
                 if verbose:
-                    print("label %s does not match regexp %s" % (name,validLabelRegexp))
+                    print("label %s does not match regexp %s" % (name, validLabelRegexp))
                 continue
 
             if name in ignoredP4Labels:
@@ -3730,7 +3730,7 @@ def importHeadRevision(self, revision):
         newestRevision = 0
 
         fileCnt = 0
-        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+        fileArgs = ["%s...%s" % (p, revision) for p in self.depotPaths]
 
         for info in p4CmdList(["files"] + fileArgs):
 
@@ -4235,7 +4235,7 @@ def renameBranch(self, branch_name):
         """Rename the existing branch to branch_name.N ."""
 
         found = True
-        for i in range(0,1000):
+        for i in range(0, 1000):
             backup_branch_name = "{0}.{1}".format(branch_name, i)
             if not gitBranchExists(backup_branch_name):
                 gitUpdateRef(backup_branch_name, branch_name) # copy ref to backup
-- 
2.35.GIT

