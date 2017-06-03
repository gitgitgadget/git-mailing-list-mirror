Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC659209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 15:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdFCP5O (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 11:57:14 -0400
Received: from 7.mo1.mail-out.ovh.net ([87.98.158.110]:33132 "EHLO
        7.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCP5N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 11:57:13 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jun 2017 11:57:13 EDT
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id 162487A3C9
        for <git@vger.kernel.org>; Sat,  3 Jun 2017 15:31:38 +0200 (CEST)
Received: from jwilk.net (unknown [5.172.255.188])
        (Authenticated sender: jwilk@jwilk.net)
        by player795.ha.ovh.net (Postfix) with ESMTPSA id A436D12007D;
        Sat,  3 Jun 2017 15:31:30 +0200 (CEST)
From:   Jakub Wilk <jwilk@jwilk.net>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: remove obsolete version check
Date:   Sat,  3 Jun 2017 15:31:20 +0200
Message-Id: <20170603133120.715-1-jwilk@jwilk.net>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
X-Ovh-Tracer-Id: 13418756568248080349
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeljedrheefgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file is syntactically correct only in Python >= 2.6, so the
version check never does anything.

Signed-off-by: Jakub Wilk <jwilk@jwilk.net>
---
 git-p4.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91..4278cd9d4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -8,10 +8,6 @@
 # License: MIT <http://www.opensource.org/licenses/mit-license.php>
 #
 import sys
-if sys.hexversion < 0x02040000:
-    # The limiter is the subprocess module
-    sys.stderr.write("git-p4: requires Python 2.4 or later.\n")
-    sys.exit(1)
 import os
 import optparse
 import marshal
-- 
2.13.0.506.g27d5fe0cd

