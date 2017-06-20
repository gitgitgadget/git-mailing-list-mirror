Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C5E20D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdFTCtC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:02 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33884 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbdFTCs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:57 -0400
Received: by mail-pf0-f181.google.com with SMTP id s66so62713852pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FPmEjDk4KvB2oMWXCwJ4B8zkiUXZ7tx/zHDm5xO2Pc=;
        b=R7HwP9rVuinY1dikQjvxZ+KRidzACncUn7e+SUWtCVmY0xJ44K7lbewZETncdWqIcN
         Ry683ifV1+ol7EoY+PLc3Ajl0aRAlsPXRJ5Xvwi1uvFNLf7f+Lv0UMI0X7/XZPkSUV+/
         K0iCB+zFamSILFb7rVcP4H99jaVuMvoYPFQJHMLXnCMjbvlyZdmKwbrt4dtvJb+LVjIe
         wrrBnvmBeHj9RUuPaOk8e63XAth9PHfUqYZJDXbyX0TmphnFlZsDSEnyM9DY7tt8LITy
         GhCXcoeFMslPvPCblNoN/5fUleSBzHwtPtGpi32V905qJE0uTlpD4i3SB3D2kgoYEjzr
         TZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1FPmEjDk4KvB2oMWXCwJ4B8zkiUXZ7tx/zHDm5xO2Pc=;
        b=QFt0V78bzQlUYjV1CRqhfK2OV7gKNErC7Tfebi2p2hlCjpgzIdTtr6yZVbEVw5ap4s
         rEAI9byRaYIKiDMQuWu4bv2bYzJZ2EiQCbgDj07EToiksRNkyJCDuo7BcLZKn30GGDwY
         ZhCHAWHIiMTugKiH/tlh4HFIfeFtpx/Kh9moNsW0ORelcgzVZeS/jqR+YLLJWyrxq9W3
         A7v7SO0Zt/3rmtWInmwm41Ysamna/emhVOW2lIDPhUFqmjkAzaEzYgLuQUDBH1xB5btn
         DDOVkSilSh47uZmwV9EDORecbyhXvK225dFI/uUqn9zl2ucpvVM3W0ucPZYw0QRdsJ1V
         MmyQ==
X-Gm-Message-State: AKS2vOyq+N70dnKpVvu1WSulTzEngxHScdcmUpaORlCs86BJzc7PuQDN
        JfFPm6/4ZrtLir0M
X-Received: by 10.98.26.76 with SMTP id a73mr3202896pfa.165.1497926936415;
        Mon, 19 Jun 2017 19:48:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id 204sm22989773pfu.23.2017.06.19.19.48.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 25/26] diff: document the new --color-moved setting
Date:   Mon, 19 Jun 2017 19:48:15 -0700
Message-Id: <20170620024816.20021-26-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
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

