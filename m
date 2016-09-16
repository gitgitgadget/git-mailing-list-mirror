Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931671FCA9
	for <e@80x24.org>; Fri, 16 Sep 2016 07:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757143AbcIPHdL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 03:33:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49195 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756931AbcIPHdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 03:33:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8G7X2Nn015017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 16 Sep 2016 09:33:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8G7X3hw003583;
        Fri, 16 Sep 2016 09:33:03 +0200
From:   Matthieu Moy <Matthieu.Moy@imag.fr>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Anatoly Borodin <anatoly.borodin@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Documentation/config: default for color.* is color.ui
Date:   Fri, 16 Sep 2016 09:32:48 +0200
Message-Id: <20160916073248.30285-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.10.0.rc0.1.g07c9292
In-Reply-To: <nrfihd@blaine.gmane.org>
References: <nrfihd@blaine.gmane.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 16 Sep 2016 09:33:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8G7X2Nn015017
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1474615984.20272@77rLB2haDAGSr2pAI3V+rQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4c7f181 (make color.ui default to 'auto', 2013-06-10), the
default for color.* when nothing is set is 'auto' and we still claimed
that the default was 'false'. Be more precise by saying explicitly
that the default is to follow color.ui, and recall that the default is
'auto' to avoid one indirection for the reader.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 32f065c..66429fb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -953,7 +953,8 @@ color.branch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-branch[1]. May be set to `always`,
 	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. Defaults to false.
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -968,7 +969,8 @@ color.diff::
 	linkgit:git-log[1], and linkgit:git-show[1] will use color
 	for all patches.  If it is set to `true` or `auto`, those
 	commands will only use color when output is to the terminal.
-	Defaults to false.
+	If unset, then the value of `color.ui` is used (`auto` by
+	default).
 +
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
@@ -991,7 +993,8 @@ color.decorate.<slot>::
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
 	`never`), never.  When set to `true` or `auto`, use color only
-	when the output is written to the terminal.  Defaults to `false`.
+	when the output is written to the terminal.  If unset, then the
+	value of `color.ui` is used (`auto` by default).
 
 color.grep.<slot>::
 	Use customized color for grep colorization.  `<slot>` specifies which
@@ -1024,7 +1027,8 @@ color.interactive::
 	and displays (such as those used by "git-add --interactive" and
 	"git-clean --interactive"). When false (or `never`), never.
 	When set to `true` or `auto`, use colors only when the output is
-	to the terminal. Defaults to false.
+	to the terminal. If unset, then the value of `color.ui` is
+	used (`auto` by default).
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1040,13 +1044,15 @@ color.showBranch::
 	A boolean to enable/disable color in the output of
 	linkgit:git-show-branch[1]. May be set to `always`,
 	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. Defaults to false.
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
 
 color.status::
 	A boolean to enable/disable color in the output of
 	linkgit:git-status[1]. May be set to `always`,
 	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. Defaults to false.
+	only when the output is to a terminal. If unset, then the
+	value of `color.ui` is used (`auto` by default).
 
 color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
-- 
2.10.0.rc0.1.g07c9292

