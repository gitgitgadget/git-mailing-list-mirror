Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFDD1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbcIBQXL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:58237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbcIBQXK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mh9cj-1bST602ppx-00MInq; Fri, 02 Sep 2016 18:23:05
 +0200
Date:   Fri, 2 Sep 2016 18:23:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] rebase -i: remove useless indentation
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <675e4059876782b7283913dd53488ed814eed137.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Kla8jRks9aiwyKVZfHcL/Mzki5gkJ8PfGADXwmNqryXL77p3ZNb
 fc/HfVmrXXomkLvcd5PCIAj1QHk5RUlJRzqyyuzTdIVEvWX149+oRgZ65m34ST/oBUgBjK8
 iyuMuN5KbWD13DWvDrsc1Krk67LVlKJOENJskpGAUmChAWEo4SgN/ZOy6ezDfDjINL75UQS
 yUUSM423lHEAzqiZS1Upw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m4k//JRZINA=:8lfSzZyei7ZjJBI7i5gUFt
 7tx3kvO77VgeB873LH6DXtNmldW6Jb5ypyjATGIrbDWk5nKlyNm1I04TFPXgffP/UwuOKxmeG
 UO5Hf3kDJyVHatQO1FLSTK+Fo+/OHJXVWpBZKd4Xmaj98HBd1SuK0pCverKDXRrGehZ8+55Yh
 Z9lJHZ+tZrPYlp52Mdf3EdJ3Er9s0IhQvxeZmOoxQU01T9dKkO33177rEAAM4A5U5RfeMKLm0
 i0U9lHgWf+/EpSGfaiiSIzMAFcT4TRP6kHsfVwPR4bJjQMxnwxiayNCXsTlDydKhcyJBnfIKw
 2wCTZTHslLGgBJGWKztnT0IWY/COk7/t8AqqHWKY2GCMhHdp5FqvpQMq0w/8giZTlslBCSqWz
 40UAT4vj5MEpmUZM3ETVlW4vdRZ+mLRuImmkx2HUVQ7Sc1wxR4lRk6KAJ3wS1PhcD1alnjI50
 2SkTTYhwDMDt/eq8RKA8js2Ib+Idd5zUskT77pAu6TBrys6VMZUqJAF0xgfufbFgTWb9fCREa
 /LAmqINuzzxW5r1FAMsf3m+2D10iVJzDDc3KhPYABh3GH171Ozm6jDd9CAnYv3FZ5fTDKEmL0
 +XphfHTz3V5BVD5+j41dZfLDPOO5dpCYyj1rBBsOLTxiidRSkd+NxDK+nZV+cIPKF5tbQJM5f
 94FXs03wHGe5B36QMz9uA9EYrhqsYly5C7d6mOCQIG+RGyA22occZTnQ7CCwxASIEGgwIgCkb
 PB7T2o6pWZxr19U2SQW1mFSFYzUKkaYb1j045Zsc7nTquzCcZ1biuILP4kryS+H5swaCvyprU
 xErEEc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands used to be indented, and it is nice to look at, but when we
transform the SHA-1s, the indentation is removed. So let's do away with it.

For the moment, at least: when we will use the upcoming rebase--helper
to transform the SHA-1s, we *will* keep the indentation and can
reintroduce it. Yet, to be able to validate the rebase--helper against
the output of the current shell script version, we need to remove the
extra indentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 01c9fec..5df5850 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -146,13 +146,13 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
- p, pick = use commit
- r, reword = use commit, but edit the commit message
- e, edit = use commit, but stop for amending
- s, squash = use commit, but meld into previous commit
- f, fixup = like \"squash\", but discard this commit's log message
- x, exec = run command (the rest of the line) using shell
- d, drop = remove commit
+p, pick = use commit
+r, reword = use commit, but edit the commit message
+e, edit = use commit, but stop for amending
+s, squash = use commit, but meld into previous commit
+f, fixup = like \"squash\", but discard this commit's log message
+x, exec = run command (the rest of the line) using shell
+d, drop = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.9.3.windows.3


