Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C3B1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbdBBIu0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:26 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35970 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdBBIuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so1250487pgf.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2TNRjAuw6bpu7RTrbKp3SRIL6H0bKt8OaB/7vV2Gq2w=;
        b=B9wikLubcHNLwLJJFJ0U+w7Mn4f0XJJd59rkEQkfgScSUCv6yVboZ8uYJ54Rk91LXw
         QpZAeZqlR5jOTxR5fpEi9YFOy6cA31ONCCxG/3ahqSRT2pZQ96XyIZq0jrFFhZSbyO6l
         NWYMWgEjWgb//fnCUQ6S+vkOWN5F/yatfRybCwrTg5fKJXe1zpbJHF2QaNEhPUZJxE+O
         /a2RmI6tIgbydZjZwXo3MYn+tBzdXZrzC2mfnO+mCRR8sb4la8OkppkD9uRGnzTqaMuU
         y74cwTxkJdwvh3Ck4JEGalsXnIun892beaI8puS3tgBOZK64QKZtHg7IX/xxn+iYMASE
         uNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2TNRjAuw6bpu7RTrbKp3SRIL6H0bKt8OaB/7vV2Gq2w=;
        b=dw6n+O89M+FHf0xdgwKX/rIsBR7d9zTEPhSyoIB3zB2YK0mnd9Zq1KYrVEwBVkGWWd
         EnkY59wZCq2zVCBzQkA4IcQJBwqoWrqInWwihjA0HtHT5U5WynbmV+5Hs0g5SaYuMnN6
         Ijx5iRhYBfiYskqEIWvdBVbGTX7cXxU0DF5EnUaaCFqvLGtB0vvNVGxTJDmIWTqgxyUt
         d3Rz8bb+ZPUW1GAJyiJ7c0V8iqe+OIRRVfld7+jPyv1dtn6tg7+XBwTwusgQC4DX2221
         fnR1IOYy07CE1SRhpLAdky4A9uMyAjEjYtZhDbZ/EixO5PhmxxNwEj41M4P5W7csxdFb
         +UrA==
X-Gm-Message-State: AIkVDXIZnw4xoAcojJQpfKxIaWyYbLruakpNiT9XqjB3D0Jp02xt29ho1ERDSxqY0npGuA==
X-Received: by 10.98.33.66 with SMTP id h63mr9068877pfh.142.1486025424904;
        Thu, 02 Feb 2017 00:50:24 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t15sm56523392pgn.18.2017.02.02.00.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/11] worktree: reorder an if statement
Date:   Thu,  2 Feb 2017 15:49:58 +0700
Message-Id: <20170202085007.21418-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is no-op. But it helps reduce diff noise in the next patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5c4854d3e4..8a654e4ad3 100644
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
2.11.0.157.gd943d85

