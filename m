Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455081F42D
	for <e@80x24.org>; Wed, 30 May 2018 21:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932240AbeE3VHO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 17:07:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41086 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932459AbeE3VG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 17:06:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id u12-v6so30856732wrn.8
        for <git@vger.kernel.org>; Wed, 30 May 2018 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u22CFvzJSdWqpZA70UeJBW//PmpMDlRSXBJSpsW5TWw=;
        b=CFvPhcxpbqbpbqQvT/XZ9WzZMvKuH70HqnO7ZF06ZCZySPZvWd21f+FLQ6e2wSmJlT
         1weEj4tp2SUCkKSuColClxQMyZNbhpNegVeMtqAqQG646CJInxwJO6ZMEFxhWRQTDyxr
         QqHsNDkpBS6i0AE5DGmtxb/UvZpCppeZ6U7CTTbBitCTA5ZUFrBfKVvG7i/X1Er2zhC/
         B64TiMbXOA5Nf3KjdDgk/PLIehM1aZQ11BksQ3hcojsQgRgQgOT3/SasCOx5MjsC4d8Z
         SamH/lD2tiGpqmGbrm5bcoGVMeKr+IteZrylK9cLuIfzqpbl6lQh0tYNDsNQ797S3hJM
         zVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u22CFvzJSdWqpZA70UeJBW//PmpMDlRSXBJSpsW5TWw=;
        b=XfD3tRWICnkZfJrlgMG35AWbj0D/4qhW+4Exdb25KBGc9A/JfPrTErDi2xY286u6Hh
         08J+CQfNo7+y83vOM+6ugMiXbiHGq3PQacAKMIIT5mCysWYQ5Up3w3po1P8EcnsZG4Ej
         9EwffBNFUHECeF7GqWo3m+ZLrWKpCj1IijfV8+/IIGD1CoOeKB+h9TDrJOoYaGZ0wpfS
         8ApiCgyKCE++3iY6NPhh7LjVXGDyx1WNMZ1ds8dfYt6dBupRyCNie/fYwhtR89ohGgHD
         LNpku16vNgPV+yalHYKdvEdDKI7+G9zmGq7Qn0kV0KlITIn6nmm3Vax9TWAMbFa0FUpc
         xSjQ==
X-Gm-Message-State: ALKqPwdjEWw6beexmhrM6gFeOlevbB2gJXLq67+A3lIIx8zdJ6eHJOvx
        dh8O8jTsx2pgXVbXJiVtjOXnL/Xn
X-Google-Smtp-Source: ADUXVKLeo0+JDhaHEB2z4KghNs8b05Oj4K3MCVkr3i153Aw1GFSIqV2ebbf3LzWNi7Yw1T1SwUNaDg==
X-Received: by 2002:adf:8d90:: with SMTP id o16-v6mr3201604wrb.81.1527714417780;
        Wed, 30 May 2018 14:06:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o16-v6sm18237097wri.67.2018.05.30.14.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 May 2018 14:06:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/4] config doc: move color.ui documentation to one place
Date:   Wed, 30 May 2018 21:06:38 +0000
Message-Id: <20180530210641.19771-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180530210641.19771-1-avarab@gmail.com>
References: <20180530210641.19771-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since b982592d66 ("git-status: document colorization config
options", 2006-09-11) we've slowly been accumulating more and more
color.* options, where the documentation for each new one has
seemingly been copy/pasted with minor adjustments from the last.

This has resulted in documentation where we're describing what sort of
values color.ui or its overriding variables can take a grand total of
9 times.

This makes for hard and tedious reading, and is going to be a royal
pain if we're ever going to add more color.ui values.

Instead let's briefly describe what each variable is for, and then
copy/paste a new boilerplate saying that this variable takes the exact
same values as color.ui, and if it's unset it'll fallback to whatever
color.ui is set to.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 81 ++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d8383433c..44735dd88e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1103,21 +1103,19 @@ clean.requireForce::
 	-i or -n.   Defaults to true.
 
 color.advice::
-	A boolean to enable/disable color in hints (e.g. when a push
-	failed, see `advice.*` for a list).  May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors
-	are used only when the error output goes to a terminal. If
-	unset, then the value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in hints (e.g. when a push failed,
+	see `advice.*` for a list). See `color.ui` for possible values
+	and the default. If unset, the value of `color.ui` is used as
+	a fallback.
 
 color.advice.hint::
 	Use customized color for hints.
 
 color.branch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in the output of
+	linkgit:git-branch[1]. See `color.ui` for possible values and
+	the default. If unset, the value of `color.ui` is used as a
+	fallback.
 
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
@@ -1127,13 +1125,11 @@ color.branch.<slot>::
 	refs).
 
 color.diff::
-	Whether to use ANSI escape sequences to add color to patches.
-	If this is set to `always`, linkgit:git-diff[1],
-	linkgit:git-log[1], and linkgit:git-show[1] will use color
-	for all patches.  If it is set to `true` or `auto`, those
-	commands will only use color when output is to the terminal.
-	If unset, then the value of `color.ui` is used (`auto` by
-	default).
+	Enables or disables colors when patches are emitted
+	(e.g. linkgit:git-diff[1], linkgit:git-log[1], and
+	linkgit:git-show[1]). See `color.ui` for possible values and
+	the default. If unset, the value of `color.ui` is used as a
+	fallback.
 +
 This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
@@ -1165,10 +1161,10 @@ color.decorate.<slot>::
 	branches, remote-tracking branches, tags, stash and HEAD, respectively.
 
 color.grep::
-	When set to `always`, always highlight matches.  When `false` (or
-	`never`), never.  When set to `true` or `auto`, use color only
-	when the output is written to the terminal.  If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in the output of
+	linkgit:git-grep[1]. See `color.ui` for possible values and
+	the default. If unset, the value of `color.ui` is used as a
+	fallback.
 
 color.grep.<slot>::
 	Use customized color for grep colorization.  `<slot>` specifies which
@@ -1197,12 +1193,11 @@ color.grep.<slot>::
 --
 
 color.interactive::
-	When set to `always`, always use colors for interactive prompts
-	and displays (such as those used by "git-add --interactive" and
-	"git-clean --interactive"). When false (or `never`), never.
-	When set to `true` or `auto`, use colors only when the output is
-	to the terminal. If unset, then the value of `color.ui` is
-	used (`auto` by default).
+	Enables or disables colors in interactive prompts and displays
+	(such as those used by "git-add --interactive" and "git-clean
+	--interactive"). See `color.ui` for possible values and the
+	default. If unset, the value of `color.ui` is used as a
+	fallback.
 
 color.interactive.<slot>::
 	Use customized color for 'git add --interactive' and 'git clean
@@ -1215,27 +1210,24 @@ color.pager::
 	use (default is true).
 
 color.push::
-	A boolean to enable/disable color in push errors. May be set to
-	`always`, `false` (or `never`) or `auto` (or `true`), in which
-	case colors are used only when the error output goes to a terminal.
-	If unset, then the value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in push errors. See `color.ui` for
+	possible values and the default. If unset, the value of
+	`color.ui` is used as a fallback.
 
 color.push.error::
 	Use customized color for push errors.
 
 color.showBranch::
-	A boolean to enable/disable color in the output of
-	linkgit:git-show-branch[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in the output of
+	linkgit:git-show-branch[1]. See `color.ui` for possible values
+	and the default. If unset, the value of `color.ui` is used as
+	a fallback.
 
 color.status::
-	A boolean to enable/disable color in the output of
-	linkgit:git-status[1]. May be set to `always`,
-	`false` (or `never`) or `auto` (or `true`), in which case colors are used
-	only when the output is to a terminal. If unset, then the
-	value of `color.ui` is used (`auto` by default).
+	Enables or disables colors in the output of
+	linkgit:git-status[1]. See `color.ui` for possible values
+	and the default. If unset, the value of `color.ui` is used as
+	a fallback.
 
 color.status.<slot>::
 	Use customized color for status colorization. `<slot>` is
@@ -1279,10 +1271,9 @@ blame.coloring::
 	or 'none' which is the default.
 
 color.transport::
-	A boolean to enable/disable color when pushes are rejected. May be
-	set to `always`, `false` (or `never`) or `auto` (or `true`), in which
-	case colors are used only when the error output goes to a terminal.
-	If unset, then the value of `color.ui` is used (`auto` by default).
+	Enables or disables colors when pushes are rejected. See
+	`color.ui` for possible values and the default. If unset, the
+	value of `color.ui` is used as a fallback.
 
 color.transport.rejected::
 	Use customized color when a push was rejected.
-- 
2.17.0.290.gded63e768a

