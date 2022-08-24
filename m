Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EDEC3F6B0
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiHXVWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiHXVV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89C165BC
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay12so9331528wmb.1
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=M/2g7wHp52k6Rtik7/3DhHa3bU30ZQdpTtM1UecamjY=;
        b=bvEQEElAKcHJRXCRrGFdVQzHad5rPCqL7tCfukIW/e6V66frQftyKVRK3wEuvzP+fT
         Dkp3zKF4w4CV3gmlhFvintk/BioZ8bpbZUfePRcR07Oq6nTAC8+QwGixRESKEfsYVe0W
         RPt0HlDAhcmvGhnnCeK+KdRR9Vi1lpliPvlRVe3a+JjrFewdXcNUDXJDRy+uf1A03heg
         4y10p16ZwT3+b3mebLUDPzpqcF547cHEaS7psQBM9kvlzF72lSt/jRjgF5VyV/BkaFoz
         Zg/63ClcWE5tEFbz3DASJU/skJplScVmAEbC3siQCbFZvUdB9ktaLKIwSOJ/nvnJQ9Bs
         v4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=M/2g7wHp52k6Rtik7/3DhHa3bU30ZQdpTtM1UecamjY=;
        b=TX8jlyG8GreXh38r6cgEoQu4V+TmRuT8QUI8XYNqVpz8HmWlZPN+E/57QTcSdKGYBs
         QP6qWHEeqXROvNZC7xu7V6SJSw/Tb7RUiXtdDxf0rXr2pUbRxP2qxFRBOB/9axGDhsfA
         /ndrc/9XDi9OENhgojcagK/GkFCqY0Ohpc7UNJwEz2YQ7W1yWs/zHUFyexEUgvOH9DPk
         hYtr5dv5ONir3yrD8Knyl9BzlinispcNQDudQaNHA0g34N5D8S7nISVDNcY/dzAEeDW/
         WiNtjIIT2CWp+NCejplDDL/kRGvqolXRYc6KmR9nJIv8GWUvyVFtW1w0Ve0xZwHaVKRt
         6qjw==
X-Gm-Message-State: ACgBeo3m6jgprnJjBoztHUnSNbtDHjDvm53x+5oKbsalXlFM4bRgroQS
        l1jCt7LDqil0Dmlnglegk0NDF0zpYbo=
X-Google-Smtp-Source: AA6agR4V8C6bAPfOZhPptBzgZtXAognAHBhcy3V/kdkejV41Xbz6hAI25awQJpGpnj3hvW9IcJUGcA==
X-Received: by 2002:a05:600c:26d2:b0:3a6:280c:24a with SMTP id 18-20020a05600c26d200b003a6280c024amr6230249wmv.130.1661376115073;
        Wed, 24 Aug 2022 14:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a603fbad5bsm3123441wmq.45.2022.08.24.14.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:21:54 -0700 (PDT)
Message-Id: <b07f85a035954bb9145a0fe034e6f17aeb128f52.1661376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 21:21:49 +0000
Subject: [PATCH v2 2/4] add -p: gracefully ignore unparseable hunk headers in
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
index b40d1c94d99..7e3c1de71f5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -766,6 +766,15 @@ test_expect_success 'detect bogus diffFilter output' '
 	force_color test_must_fail git add -p <y
 '
 
+test_expect_success 'gracefully fail to parse colored hunk header' '
+	git reset --hard &&
+
+	echo content >test &&
+	test_config interactive.diffFilter "sed s/@@/XX/g" &&
+	printf y >y &&
+	force_color git add -p <y
+'
+
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
 	git reset --hard &&
 
-- 
gitgitgadget

