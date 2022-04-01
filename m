Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B3C4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348910AbiDAPFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350137AbiDAOrM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:47:12 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2D2A047D
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:37:12 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIE0-009TW3-6O; Fri, 01 Apr 2022 15:26:03 +0100
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
Subject: [PATCH v5 07/22] git-p4: sort and de-duplcate pylint disable list
Date:   Fri,  1 Apr 2022 15:24:49 +0100
Message-Id: <20220401142504.58995-8-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains configuration commands for pylint embedded in the header
comment.

Previously, these were combined onto single lines and not alphabetically
sorted. This patch breaks each disable command onto a separate line to
give cleaner diffs, removed duplicate entries, and sorts the list
alphabetically.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 53e99f81b7..52c4cac683 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -7,13 +7,28 @@
 #            2007 Trolltech ASA
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
-# pylint: disable=invalid-name,missing-docstring,too-many-arguments,broad-except
-# pylint: disable=no-self-use,wrong-import-position,consider-iterating-dictionary
-# pylint: disable=wrong-import-order,unused-import,too-few-public-methods
-# pylint: disable=too-many-lines,ungrouped-imports,fixme,too-many-locals
-# pylint: disable=line-too-long,bad-whitespace,superfluous-parens
-# pylint: disable=too-many-statements,too-many-instance-attributes
-# pylint: disable=too-many-branches,too-many-nested-blocks
+# pylint: disable=bad-whitespace
+# pylint: disable=broad-except
+# pylint: disable=consider-iterating-dictionary
+# pylint: disable=disable
+# pylint: disable=fixme
+# pylint: disable=invalid-name
+# pylint: disable=line-too-long
+# pylint: disable=missing-docstring
+# pylint: disable=no-self-use
+# pylint: disable=superfluous-parens
+# pylint: disable=too-few-public-methods
+# pylint: disable=too-many-arguments
+# pylint: disable=too-many-branches
+# pylint: disable=too-many-instance-attributes
+# pylint: disable=too-many-lines
+# pylint: disable=too-many-locals
+# pylint: disable=too-many-nested-blocks
+# pylint: disable=too-many-statements
+# pylint: disable=ungrouped-imports
+# pylint: disable=unused-import
+# pylint: disable=wrong-import-order
+# pylint: disable=wrong-import-position
 #
 import sys
 if sys.version_info.major < 3 and sys.version_info.minor < 7:
-- 
2.35.GIT

