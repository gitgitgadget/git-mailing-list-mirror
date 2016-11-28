Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DA21FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932390AbcK1Jhk (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:37:40 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35291 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbcK1Jhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:37:32 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so12677890pga.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRGujtVxkFrK2WytaQeTCsSM4LNQopodfxcOpLbDkXU=;
        b=S2IkRiw90C2wo+HpSnRtCD8z/7VY8tnn0dt7AN2ipQuXXOljemXnq6wth/8AizPc5t
         7yvV8EaC1g6gMfSZ951l/KlPPpJeigdK3zuMS+xOn4UQ5bIQkNPA5sPxiZ+DQytnehyR
         o1RYmKpJVHwD6GFhpTvPno9VFu3TWce63r8MXSWtWqxfArVTbeMZR69juyDf3uJecTv8
         oN0kLtfQF4JdR4eKUFs1gdfbYjEt3TqipSyEgRi9+PghVrlVuGSs9PRziTN/q7Iv0vui
         ETy3KALlTWNN+0UGaVd/eadW9tv/GfCcey/gKz2v0wKVqzVMqo4IofHsajDXmTMKtXTA
         DPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRGujtVxkFrK2WytaQeTCsSM4LNQopodfxcOpLbDkXU=;
        b=fVtFFqwc8FoY0oAhCimEZpzPh6R9VzGo8ZvKDfA2ke11V5DqIBeOMLQ+O79c6D/mTF
         dwvLlM2cWOl88jwyIkEqgUFjHYQTuY9PUW/Xer3lqis0NqDgt3hyU+qZTk5VxrLDyFc8
         OtLwjThauQjTP45XomXOPQBwBqf9ZNRA+da+IL2ixTDDdUIB11Tn9JHd8O7JaRAzAnbw
         dWwARdjptKTlS/7XVHwITzjuS14gz/sBFiBvU0GRFJu0ikvTycrr9HAElwFkEGWoOQDK
         Ebadcv05vQ0OFxoFri+TbZQBgDiumOe3/EOKFkcavBNRx7cYTcmmcBpsiRv5hYzlVFx3
         XjEw==
X-Gm-Message-State: AKaTC01B9FxsGQ+hvfKS/2g2qGiTHEWGfOeha9iDXS9RR/yydR5LFO7WnNYKKpiU+LMa5A==
X-Received: by 10.99.127.16 with SMTP id a16mr9879165pgd.60.1480325849619;
        Mon, 28 Nov 2016 01:37:29 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id 72sm82367850pfw.37.2016.11.28.01.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:37:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:37:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 2/5] worktree: reorder an if statement
Date:   Mon, 28 Nov 2016 16:36:53 +0700
Message-Id: <20161128093656.15744-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128093656.15744-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
 <20161128093656.15744-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is no-op. But it helps reduce diff noise in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5c4854d..8a654e4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -406,10 +406,10 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 	else {
 		strbuf_addf(&sb, "%-*s ", abbrev_len,
 				find_unique_abbrev(wt->head_sha1, DEFAULT_ABBREV));
-		if (!wt->is_detached)
-			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
-		else
+		if (wt->is_detached)
 			strbuf_addstr(&sb, "(detached HEAD)");
+		else
+			strbuf_addf(&sb, "[%s]", shorten_unambiguous_ref(wt->head_ref, 0));
 	}
 	printf("%s\n", sb.buf);
 
-- 
2.8.2.524.g6ff3d78

