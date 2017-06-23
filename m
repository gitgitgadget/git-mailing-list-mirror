Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5947F2083B
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbdFWBaI (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:08 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34094 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbdFWBaG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:30:06 -0400
Received: by mail-pg0-f42.google.com with SMTP id e187so15009384pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7WSkAiDJOmUoMX3pH/ElahVx/H1ulcdCKtsc22fYfB8=;
        b=GKDeHAadH1qoZgwzwA0cWzaYP26XWumD87mteUwgQoiA6hVsRUYU6Xx3IxQZjwc8FI
         h6OvSqpGzjbaq8p1FriDGgibZnbJiv4zGwoimdpkKqfci+mYQ21fuUKYBmtZ+2fxjo4C
         kSPj+/cqgVj1Kvw9qxUhsr5UQepg5LPCnJKyctfg5ktgZS+P/Zbfl3Xor7/UKoIRQYif
         Nw1Fd3JCrCXaPdNFjhFEAYdBu+RMc67RZmd8nIkA70Bgea0O33ezomqq2kjHi7ve9csC
         GHWcWYWHvgbvmiM9MrjPISW9ti7Z/QIF3TsUItdHPywI+GyoRgzk64qSDL+A5AFvgf7p
         KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7WSkAiDJOmUoMX3pH/ElahVx/H1ulcdCKtsc22fYfB8=;
        b=eNfQrbirJ1umzRmk0jz9/0UFuYL0C1g6sI1F3awslsNYdhCuncGrPwOvJPQk8ze+W8
         Yj+FxRW8pAacX3oHCbw4DUsLuOcg0yW2sj2L2ZHw4eGF/w/HteTroHjq36LvsJsYARWw
         ocRIzwcs3Y7Uqr3MF60ukLyEAR9L+Q6Z3+tGtt6VGX2/hTUVr+E1JEn50FPxUdBGxdqa
         mLXLmPKX8LkVAb4zt3q3s35B9xCVvCy4HMKkPSl4upw2bQFCg/f08c2Fru3Nkx1fzKTy
         u4KogHNisMDKbsK6IWGq0lxY7TZKofIbu8AsS8I+PgtbKJL91IhZBmqBo8baLgp1wL3z
         drtg==
X-Gm-Message-State: AKS2vOys5pGI9/I4Ky9DHpE28bKW7A65o5ziX8tjFEhL4+TlDjXVqaon
        BRK9v9/0p5H2mKhr
X-Received: by 10.99.2.78 with SMTP id 75mr5692229pgc.120.1498181400933;
        Thu, 22 Jun 2017 18:30:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id j6sm6920275pgc.1.2017.06.22.18.30.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:30:00 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 25/25] diff: document the new --color-moved setting
Date:   Thu, 22 Jun 2017 18:29:19 -0700
Message-Id: <20170623012919.28693-26-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt       | 12 ++++++++++--
 Documentation/diff-options.txt | 27 +++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..29e0b9fa69 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1051,14 +1051,22 @@ This does not affect linkgit:git-format-patch[1] or the
 'git-diff-{asterisk}' plumbing commands.  Can be overridden on the
 command line with the `--color[=<when>]` option.
 
+diff.colorMoved::
+	If set moved lines in a diff are colored differently,
+	for details see '--color-moved' in linkgit:git-diff[1].
+
 color.diff.<slot>::
 	Use customized color for diff colorization.  `<slot>` specifies
 	which part of the patch to use the specified color, and is one
 	of `context` (context text - `plain` is a historical synonym),
 	`meta` (metainformation), `frag`
 	(hunk header), 'func' (function in hunk header), `old` (removed lines),
-	`new` (added lines), `commit` (commit headers), or `whitespace`
-	(highlighting whitespace errors).
+	`new` (added lines), `commit` (commit headers), `whitespace`
+	(highlighting whitespace errors), `oldMoved` (deleted lines),
+	`newMoved` (added lines), `oldMovedDimmed`, `oldMovedAlternative`,
+	`oldMovedAlternativeDimmed`, `newMovedDimmed`, `newMovedAlternative`
+	and `newMovedAlternativeDimmed` (See the '<mode>'
+	setting of '--color-moved' in linkgit:git-diff[1] for details).
 
 color.decorate.<slot>::
 	Use customized color for 'git log --decorate' output.  `<slot>` is one
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 89cc0f48de..058c8014ed 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -231,6 +231,33 @@ ifdef::git-diff[]
 endif::git-diff[]
 	It is the same as `--color=never`.
 
+--color-moved[=<mode>]::
+	Moved lines of code are colored differently.
+ifdef::git-diff[]
+	It can be changed by the `diff.colorMoved` configuration setting.
+endif::git-diff[]
+	The <mode> defaults to 'no' if the option is not given
+	and to 'dimmed_zebra' if the option with no mode is given.
+	The mode must be one of:
++
+--
+no::
+	Moved lines are not highlighted.
+plain::
+	Any line that is added in one location and was removed
+	in another location will be colored with 'color.diff.newMoved'.
+	Similarly 'color.diff.oldMoved' will be used for removed lines
+	that are added somewhere else in the diff.
+zebra::
+	Blocks of moved code are detected. The detected blocks are
+	painted using the 'color.diff.{old,new}Moved' alternating with
+	'color.diff.{old,new}MovedAlternative'.
+dimmed_zebra::
+	Similar to 'zebra', but additional dimming of uninteresting parts
+	of moved code is performed. The bordering lines of two adjacent
+	blocks are considered interesting, the rest is uninteresting.
+--
+
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
 	By default, words are delimited by whitespace; see
-- 
2.12.2.575.gb14f27f917

