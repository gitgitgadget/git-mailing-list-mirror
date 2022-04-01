Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA0DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347024AbiDAO2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346912AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C926B391
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:27 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEM-009TW3-MH; Fri, 01 Apr 2022 15:26:26 +0100
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
Subject: [PATCH v5 16/22] git-p4: ensure there is a single space around all operators
Date:   Fri,  1 Apr 2022 15:24:58 +0100
Message-Id: <20220401142504.58995-17-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 requires that binary operators such as assignment and comparison
operators should always be surrounded by a pair of single spaces, and
recommends that all other binary operators should typically be surround
by single spaces.

The recommendation is given here in the "Other Recommendations"
section

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 88c2b5213e..97c2f82ee8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -67,7 +67,7 @@
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
 # The block size is reduced automatically if required
-defaultBlockSize = 1<<20
+defaultBlockSize = 1 << 20
 
 p4_access_checked = False
 
@@ -201,7 +201,7 @@ def prompt(prompt_text):
         sys.stderr.flush()
         sys.stdout.write(prompt_text)
         sys.stdout.flush()
-        response=sys.stdin.readline().strip().lower()
+        response = sys.stdin.readline().strip().lower()
         if not response:
             continue
         response = response[0]
@@ -2339,7 +2339,7 @@ def exportGitTags(self, gitTags):
             # Create the label - use the same view as the client spec we are using
             clientSpec = getClientSpec()
 
-            labelTemplate  = "Label: %s\n" % name
+            labelTemplate = "Label: %s\n" % name
             labelTemplate += "Description:\n"
             for b in body:
                 labelTemplate += "\t" + b + "\n"
@@ -2842,7 +2842,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            path = commit["depotFile%s" % fnum]
             found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
@@ -3925,7 +3925,7 @@ def run(self, args):
 
             p4Change = 0
             for branch in self.p4BranchesInGit:
-                logMsg =  extractLogMessageFromGitCommit(self.refPrefix + branch)
+                logMsg = extractLogMessageFromGitCommit(self.refPrefix + branch)
 
                 settings = extractSettingsGitLog(logMsg)
 
-- 
2.35.GIT

