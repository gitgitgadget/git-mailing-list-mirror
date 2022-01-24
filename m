Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4737C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 19:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348588AbiAXTi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 14:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352222AbiAXT3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 14:29:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D203C02982C
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso65177wms.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4f+I3S+5kXlrq2dgprxTUst4Q5HxOS1EHDxdA1BG70w=;
        b=Si/u+4TPSyEMzc/ap5YZiAeiObHTh99k3NL/Kg68RSu8QGtNJLZtIfuhvrgXSQtf8E
         HPXeH2YGoOnC4e7LEJmVQOvzBjNWkdg8emyk6qAPVDfYUqF/uqUaapF3FK3YHFgNz0j2
         SxqPXVY6wVMWaS4bC2pTCSV6YPiymH3c/xD8/k4sIZWgMYf3fINrHKRRvaQei3f5AOvT
         bNqvFhQBmxe5tm/PE1ar7nXVlXQwJFfH7rvCQ0V8RwoH+MZjpB9Zdb2w5FseQQMCgx6L
         JYrSc2Y5dKP5wCFJGs5vbrzA9Iwn5sG0ZBWQd8/VC7/9J7Lv6SF+LACdQknVApF6fR+p
         qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4f+I3S+5kXlrq2dgprxTUst4Q5HxOS1EHDxdA1BG70w=;
        b=gIowHVUrKZeAIrqvs5NSFcEpwqkUZKYFlJaL5zvbI4Ad58u7019JxxpRBz6a/aro3c
         /w4GGocqEDbB5lJr3cCQ6W1HmgSTNZSuIlFSPLeaLH0nPc8na58bKdYm1fdVRr7Kh8XP
         xNAU0wP4J0kv+fR3nitI97xUme70mDm6UHmJ6+17hiEkky9o//teiX4oRWrKSuORwUg0
         wU6Abe1tfweJivWC5MBzpJvd+Zu3bA+acLW1B8i6SsO7RoOFaPaEta6nurbQ4XdTyBUe
         GRKIrqAucw/LjryrHKZb73r7hKlTfABwU8vYJzzX51K1nCaFMgL6Bnw6RLjn3Q/LweMm
         9TOg==
X-Gm-Message-State: AOAM531Bb1xuMj7Jzg292RCPRuklmQAOhvhltB+EdZ29w2N+5GarlUxz
        GvcFubrtQcGKwM/vRx/BnaH5Kru2rq1rQQ==
X-Google-Smtp-Source: ABdhPJwG17XQ+bpoWxHEFy8cHQ2VtbR+/GNvSXNCwmhnP7RnT/fj5rqsLUvXVnpNiTGx3GKHcC+zcw==
X-Received: by 2002:a1c:c915:: with SMTP id f21mr3026425wmb.39.1643051630895;
        Mon, 24 Jan 2022 11:13:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm8706527wrr.74.2022.01.24.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 11:13:50 -0800 (PST)
Message-Id: <a21d934f37d9951f51ce48bd14e1355f72ba4396.1643051624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
        <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Jan 2022 19:13:34 +0000
Subject: [PATCH v7 06/16] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and
the next available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 56bf5f2d84a..ddbdf1b9c8b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -889,7 +889,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -923,7 +923,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -1031,7 +1031,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1068,9 +1068,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget

