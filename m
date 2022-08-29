Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F6ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 15:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH2PMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiH2PMF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 11:12:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B88180F49
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv25so3557666wrb.10
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=i2Fz6HL6thdGuveotn37qJfG3xTHh/nY5WVtZxeZ1CI=;
        b=eDhWQFSYj3/2RClXboU9CrMoQdW2kwkKMXmOkLbvbkuPTVdmO7PBuwLrxsnXzJuKf7
         osLuhZoBJXzGOo5fIKORo+1VNarvwDzSRZm7Ye74thNZSAL6AffiYlrqDS1i7iLqyJzW
         JS3IY4cOMxpTwAlXSx1mz4kpaTur+zJJmA66/QXUFuctxVhjGhxm3kfTT0QHrxgfar7/
         OWY+hNFt1IUkFbQfbP8NQrEXHUNXaNHZ9hdlcis6iDWwtat7uW1LSF5lc6KKp5VzuP2d
         6T70F7jHuPdlSoJrPOPbv/i/jEhHi+Rm+hj49NbVpasImLHLehehdZ11eYpQ3m0151Ls
         xHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=i2Fz6HL6thdGuveotn37qJfG3xTHh/nY5WVtZxeZ1CI=;
        b=fjyjXuhlAxzHnr5v2tmia8DSKsY6n9X5iX2Q1JtnSMcEDn4jK/dvLEBuuz4+Eu5Xtp
         bLqshKb719kt+KdvRpZCsm6OJLx+zonCZUo4/2KF74Lqr+J6v4AkC+1FEf4rjJ1EhGgB
         sbkMZt6aFJI8zSCGadkcGJjGUxUj+ktHeOlwaG5wc2F0fp2dMm0vrhT2vtrnzVPQVwmX
         ku1VlwoTAzz2rcjLzBVNca+FybvR/Vp7crrc7coOzp0ZNNgXzP6w/BWy1Gnr03DFq4ag
         IbK9SDg917ujW4+GFOpPx6RAWnnU+orpwXL1CMMA/ttHaBfb0Csdir8UhY/GFjNpzt/U
         J/jQ==
X-Gm-Message-State: ACgBeo15z+LN3cx2eBNo9DRGtjv083xAR13+WEge3/yaMNla5z2ky0KW
        ZLB/Hk26l6McwpRbgiVRc7eUCBOQX6g=
X-Google-Smtp-Source: AA6agR5upIdqWse5qP6XQIzMi6GYvlUny+I2sZZt5o156sibV/DKkfpvNUlnMzC1yd/Ybg75i8J3aw==
X-Received: by 2002:a5d:6f0d:0:b0:226:d1c8:a1 with SMTP id ay13-20020a5d6f0d000000b00226d1c800a1mr5956353wrb.476.1661785921798;
        Mon, 29 Aug 2022 08:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b003a53731f273sm9572277wmq.31.2022.08.29.08.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:12:01 -0700 (PDT)
Message-Id: <cbe833bd141490a897a1647c4fbfc275cebbfa9f.1661785916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
        <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 15:11:53 +0000
Subject: [PATCH v3 2/5] add -p: gracefully ignore unparseable hunk headers in
 colored diffs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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

Let's punt for now and simply show nothing apart from the line range in
that case.

[diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 15 ++++++---------
 t/t3701-add-interactive.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..f2fffe1af02 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -357,16 +357,13 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 	eol = memchr(line, '\n', s->colored.len - hunk->colored_start);
 	if (!eol)
 		eol = s->colored.buf + s->colored.len;
-	p = memmem(line, eol - line, "@@ -", 4);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
-	p = memmem(p + 4, eol - p - 4, " @@", 3);
-	if (!p)
-		return error(_("could not parse colored hunk header '%.*s'"),
-			     (int)(eol - line), line);
 	hunk->colored_start = eol - s->colored.buf + (*eol == '\n');
-	header->colored_extra_start = p + 3 - s->colored.buf;
+	p = memmem(line, eol - line, "@@ -", 4);
+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
+		header->colored_extra_start = p + 3 - s->colored.buf;
+	else
+		/* could not parse colored hunk header, showing nothing */
+		header->colored_extra_start = hunk->colored_start;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 88d8133f38f..c2187f9cec8 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -766,6 +766,15 @@ test_expect_success 'detect bogus diffFilter output' '
 	force_color test_must_fail git add -p <y
 '
 
+test_expect_success 'handle iffy colored hunk headers' '
+	git reset --hard &&
+
+	echo content >test &&
+	printf n >n &&
+	force_color git -c interactive.diffFilter="sed s/@@/XX/g" \
+		add -p <n
+'
+
 test_expect_success 'handle very large filtered diff' '
 	git reset --hard &&
 	# The specific number here is not important, but it must
-- 
gitgitgadget

