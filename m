Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C4C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbiDAO3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiDAO2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:20 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087E1DEC11
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:29 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEO-009TW3-UW; Fri, 01 Apr 2022 15:26:28 +0100
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
Subject: [PATCH v5 21/22] git-p4: seperate multiple statements onto seperate lines
Date:   Fri,  1 Apr 2022 15:25:03 +0100
Message-Id: <20220401142504.58995-22-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 discourages the use of compound statements where there are multiple
statements on a single line in the "Other Recommendations" section:

https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 524a7a5c99..c3239cdabc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1191,7 +1191,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
             else:
                 block_size = max(2, block_size // 2)
 
-            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            if verbose:
+                print("block size error, retrying with block size {0}".format(block_size))
             continue
         except P4Exception as e:
             die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
@@ -1818,7 +1819,9 @@ def modifyChangelistUser(self, changelist, newUser):
                 (changelist, newUser))
 
         c = changes[0]
-        if c['User'] == newUser: return   # nothing to do
+        if c['User'] == newUser:
+            # Nothing to do
+            return
         c['User'] = newUser
         # p4 does not understand format version 3 and above
         input = marshal.dumps(c, 2)
-- 
2.35.GIT

