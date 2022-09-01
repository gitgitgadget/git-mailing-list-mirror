Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF09ECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiIAPmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiIAPm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:42:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923170E4B
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:42:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s7so7995531wro.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=kERYURGKCOIx2bAphXD91jz01qm2ikXkG3Gimn803TE=;
        b=RNfRI778RdFYV/dcPloNe/8HPdySNtpq0kKd28YA+vcckMr1fqmGBHypW2+zLDacEg
         lvIIIVmod8BvqxgkkTZKGZS+6MGwLPtDR1rCCz0EG+KSTvRrgVyu+FEv8GlxwgB/siVg
         RrOkq2vHNcivFpfd0uBU0MpkP0m7bWqN2OVRYs3tjBvK5ZRxiqgjNVMyPlU5g2FPjfei
         exruET+UmxbuzNvZTtyeJgRjySegpyuQNO8RyNqVqK6ruWgdC6q9tNFkUhmwpO4WCgbS
         t/N7UxNR44WDpXUtckxgfhzlbRyLYaf0sQke9U/H0raAT6HB6x5+moX3Q7kmBXvfsS4C
         7YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kERYURGKCOIx2bAphXD91jz01qm2ikXkG3Gimn803TE=;
        b=BNd+JklqzcNFzqTltQ+nWfStrIGPvpYybhSBBJ2glHYFGquvZZio4JVAJU12Gx02rg
         GmOQbJRTLqHQc57OMliHiZjZcuX2KSgWQUcommuoh78Gg4tklATW07z6tUFoqVyJ12ZE
         CBOMyq2+XyOtT9YLpFOLR1095kiSWt00WCpG/lFT09XrnZqAkQMfFwaBodRFvLjiOnto
         7BaZcs2Ft3n7PfWwQS8p1s9J0JDC8AtF1h1uqpHByfl5CRC5gP3naur+4KHdBbyDOMsl
         GtoDLKMkOzKzQB7DQZR0cgqQOkvOKNT/XHV+JbvUTkWM5MMse1CPcxaPP3sfiyA6ZSQ+
         3MnA==
X-Gm-Message-State: ACgBeo3zm2F1ndUon+fAURcMqB62Yzers4d6hF9cwN/mF9hDFGJLvqBo
        MoX+db4z1tbO7O45+mZR46n7/7aJpvw=
X-Google-Smtp-Source: AA6agR6k9rdv2znEhYYGCtZbZybATZHuaIZBederf6QGOEMjaLTrQynMLCSdXdluSQUdKNUOW7o1iw==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr14502603wrb.466.1662046944394;
        Thu, 01 Sep 2022 08:42:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c124-20020a1c3582000000b003a2f6367049sm5620651wma.48.2022.09.01.08.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:42:23 -0700 (PDT)
Message-Id: <93d0e3b4d2a3dec5588c6e41d69313385356aa8f.1662046939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
        <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 15:42:18 +0000
Subject: [PATCH v5 2/3] add -p: gracefully handle unparseable hunk headers in
 colored diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com,
Phillipe Blain reported that the built-in `git add -p` command fails
when asked to use [`diff-so-fancy`][diff-so-fancy] to colorize the diff.

The reason is that this tool produces colored diffs with a hunk header
that does not contain any parseable `@@ ... @@` line range information,
and therefore we cannot detect any part in that header that comes after
the line range.

As proposed by Phillip Wood, let's take that for a clear indicator that
we should show the hunk headers verbatim. This is what the Perl version
of the interactive `add` command did, too.

[diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 25 +++++++++++++++++--------
 t/t3701-add-interactive.sh | 10 ++++++++++
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 34f3807ff32..a6bd150de51 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -238,6 +238,7 @@ struct hunk_header {
 	 * include the newline.
 	 */
 	size_t extra_start, extra_end, colored_extra_start, colored_extra_end;
+	unsigned suppress_colored_line_range:1;
 };
 
 struct hunk {
@@ -358,15 +359,14 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	if (!eol)
 		eol = s->colored.buf + s->colored.len;
 	p = memmem(line, eol - line, "@@ -", 4);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
-	p = memmem(p + 4, eol - p - 4, " @@", 3);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3))) {
+		header->colored_extra_start = p + 3 - s->colored.buf;
+	} else {
+		/* could not parse colored hunk header, leave as-is */
+		header->colored_extra_start = hunk->colored_start;
+		header->suppress_colored_line_range = 1;
+	}
 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
-	header->colored_extra_start = p + 3 - s->colored.buf;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
@@ -659,6 +659,15 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
 			len = header->extra_end - header->extra_start;
+		} else if (header->suppress_colored_line_range) {
+			strbuf_add(out,
+				   s->colored.buf + header->colored_extra_start,
+				   header->colored_extra_end -
+				   header->colored_extra_start);
+
+			strbuf_add(out, s->colored.buf + hunk->colored_start,
+				   hunk->colored_end - hunk->colored_start);
+			return;
 		} else {
 			strbuf_addstr(out, s->s.fraginfo_color);
 			p = s->colored.buf + header->colored_extra_start;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 8a594700f7b..a94e7c53c8a 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -767,6 +767,16 @@ test_expect_success 'detect bogus diffFilter output' '
 	grep "mismatched output" output
 '
 
+test_expect_success 'handle iffy colored hunk headers' '
+	git reset --hard &&
+
+	echo content >test &&
+	printf n >n &&
+	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
+		add -p >output 2>&1 <n &&
+	grep "^XX$" output
+'
+
 test_expect_success 'handle very large filtered diff' '
 	git reset --hard &&
 	# The specific number here is not important, but it must
-- 
gitgitgadget

