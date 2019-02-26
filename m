Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C382120248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfBZA0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40782 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbfBZA0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id t15so636591wmi.5
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5fANClE8AMQfIJDXXjZsBHKE7PLkV25MTsKozomZAg=;
        b=X/bGZpUdxrYy2bo7/aS68Ka7u55JDIOSoX8ZUtQ1+Q5w173vYCWVQmqLluhy9Z99x6
         9VQ8xMfLhJROZBPQVJfMRadlImPn2c1+VbxVZV9iGWukc7KALppp745d0fnk9dd0ETor
         6cWF8d44xTKStV9QJSTho2nnPj9pvtso+PEOC1TQEekliyVrINluD5TiMVH/QOYQoF4f
         iqBAX5zD+TvQpalUeo+bUyhBIz90ohbmLsjUm1vrnZR/bd9/NPLcEBW0KUg2HXHpf8r4
         Yj37fQd+7vapj1NLyj/BnI5lTr6HYvZ+ngKfysePdWR887izBEoVcic146aGpXWnooQx
         5LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5fANClE8AMQfIJDXXjZsBHKE7PLkV25MTsKozomZAg=;
        b=Q4mxy5cNuJT+CasY1+7Thyg/btvcVW/PpBpi32xOM6tcHcnit/urqYnkS6O8gWzTIw
         0DpKCdlU/AIRXE5XS0UGPXvQMQF58C4FOP0lynkwYWv4V9Teyttvx8JTMCnNsG7Sy8sW
         uEFcpt28yQft+9xyY4NojOvZu4IvCSjLc76rtyseq7CpMK+XYoo9FJNbcFCYQVKDwOxl
         1tKoirs2VikVIL/0qnsXMM2i0AuclqnUTP4YQ7khc8nQ/VtVq7e75aMIJxA7ef2xmouV
         HsBOTwzZiKA/bNZKAyw3sZPQ/cs8uWbi0rLnH7rJofHzycmP8n30qD+JFncq9xFct8HQ
         U1Og==
X-Gm-Message-State: AHQUAuYDVGWKjedvc5niwKWpJskkjhOa+FwOV+wyltZEvOL9z1BaF8zJ
        SEMxNiDbEmXSX+Oy74g3NUKjomqkbZ4=
X-Google-Smtp-Source: AHgI3IbpVAxo3SpDzSpD7HKzYVbAX9MOHKPM3m7R4GHZ2td09yrB/eHzzQ53FAQTJfWG0fKAEW6PbQ==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr825490wme.106.1551140807961;
        Mon, 25 Feb 2019 16:26:47 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP RFC PATCH 2/7] dir-iterator: use stat() instead of lstat()
Date:   Tue, 26 Feb 2019 01:26:20 +0100
Message-Id: <20190226002625.13022-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is surely a horrible idea, but all tests pass with this (not that
I trust them much). Doing this for later WIP use in clone.c.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 dir-iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 070a656555..6a9c0c4d08 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -149,7 +149,7 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 				continue;
 
 			strbuf_addstr(&iter->base.path, de->d_name);
-			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
+			if (stat(iter->base.path.buf, &iter->base.st) < 0) {
 				if (errno != ENOENT) {
 					if (iter->pedantic)
 						goto error_out;
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

