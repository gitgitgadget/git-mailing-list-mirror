Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A75C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343552AbiDAPFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbiDAOpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:45:05 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E42986E9
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:35:13 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDi-009TW3-PN; Fri, 01 Apr 2022 15:25:46 +0100
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
Subject: [PATCH v5 03/22] git-p4: indent with 4-spaces
Date:   Fri,  1 Apr 2022 15:24:45 +0100
Message-Id: <20220401142504.58995-4-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that all code should be indented in 4-space units. This
guideline is described here:

https://www.python.org/dev/peps/pep-0008/#indentation

Previously git-p4 had multiple cases where code was indented with a
non-multiple of 4-spaces. This patch fixes each of these.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index aabf657a57..a9be9ab13c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -877,12 +877,12 @@ def extractLogMessageFromGitCommit(commit):
     ## fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
     for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
-       if not foundTitle:
-           if len(log) == 1:
-               foundTitle = True
-           continue
+        if not foundTitle:
+            if len(log) == 1:
+                foundTitle = True
+            continue
 
-       logMessage += log
+        logMessage += log
     return logMessage
 
 
@@ -1094,7 +1094,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
 
 
 def originP4BranchesExist():
-        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+    return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
 
 
 def p4ParseNumericChangeRange(parts):
@@ -2116,7 +2116,7 @@ def applyCommit(self, id):
         submitTemplate = self.prepareLogMessage(template, logMessage, jobs)
 
         if self.preserveUser:
-           submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
+            submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
 
         if self.checkAuthorship and not self.p4UserIsMe(p4User):
             submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
@@ -2565,7 +2565,7 @@ def run(self, args):
 
         # exit with error unless everything applied perfectly
         if len(commits) != len(applied):
-                sys.exit(1)
+            sys.exit(1)
 
         return True
 
@@ -3401,7 +3401,7 @@ def guessProjectName(self):
                 p = p[:-1]
             p = p[p.strip().rfind("/") + 1:]
             if not p.endswith("/"):
-               p += "/"
+                p += "/"
             return p
 
     def getBranchMapping(self):
-- 
2.35.GIT

