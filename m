Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500C11F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfGKAAC (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:00:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41583 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKAAC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:00:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so4444366qtj.8
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqQHOlwlfENkwc05/cG9Y2S77go+PAKki+Y1xBT2URM=;
        b=RRWyFdCd2a82Hp4pLzXPS0wiDaKzGQOzgx16pqvmGkF9djkP50Ugxp8K5DnczETPsv
         hF4wfFUfYas7/MIK9ByZwdKoAJ+4zPwJMMTNa9Z1zbmxnEy721iCO06vjfM1nTvPt+g4
         tbaA3iGeQUUDlrUgAH8wWK1tkeA+DV6aiJWtfIOOmmQH8mwrultXF99ca0KzNkaPBPrD
         Y4BdhKr2r0vQT9FuGjCpIY1zAGYQt2SiUE8BbCy6M45ekrMYzYtw2GY0l+mAbTtwIs1e
         QPh2D/VIGyL+L3gozJwDW4Z4XtdcYWGOQwTOKWMtOKjXV/wbWFdlL1NFcrra0PVexkPp
         XXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqQHOlwlfENkwc05/cG9Y2S77go+PAKki+Y1xBT2URM=;
        b=KZpiVoFDGhnt9LEJViNQHhNTbwIjQTAJBIovPDTRnLfYX8rWUkWH3Pi3kYCtCB+SZ6
         KQ6p5ASDEMkkJOZdZASG2VAp6QVj3Cnxz+lfsuoD5oxsMs1Ro7hLpVxspWCsPoj4Mb8Z
         mmgtiZWuRhQAxuQAt1+7/ljwCBkDDCq8WyYpUa0EY0eNNjMTfSx/Wr3gJSi/h4yZSg5p
         +HB4uCcauIxx6EBZTQa8/2yxEz66/ZNuLjaHUFOnGW9LPr8p5joa9kdr/5AciC9PB/6A
         xTBQfWu4TcNZ+5mSPIOiMlY1bAI7cqrAl845j9qP4GWcbaFWu1RivkVPxwAsQRSLZ8+Q
         XkKg==
X-Gm-Message-State: APjAAAW2U1GLUxrmKJezDHvZAp6I6Aa6ckyun0POmlzeP4i4tHbd+r3J
        89NHKK6dgPO8DVXFza1OB8YiTw==
X-Google-Smtp-Source: APXvYqxNzC9TMZUDGLLFLK5RgAWz8v4oao5YRBO5+nKKJ10bhV3Z5Ko9S3lU47JuaZK7PMuq6iVetQ==
X-Received: by 2002:ac8:2f43:: with SMTP id k3mr605431qta.179.1562803201116;
        Wed, 10 Jul 2019 17:00:01 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id x8sm1714546qkl.27.2019.07.10.16.59.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 17:00:00 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [GSoC][PATCH v8 04/10] dir-iterator: use warning_errno when possible
Date:   Wed, 10 Jul 2019 20:58:58 -0300
Message-Id: <0cc5f1f0b4ea7de4e0508316e861ace50f39de1f.1562801255.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562801254.git.matheus.bernardino@usp.br>
References: <cover.1562801254.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change warning(..., strerror(errno)) by warning_errno(...). This helps
to unify warning display besides simplifying a bit the code. Also,
improve warning messages by surrounding paths with quotation marks and
using more meaningful statements.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir-iterator.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index f2dcd82fde..0c8880868a 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -71,8 +71,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 
 			level->dir = opendir(iter->base.path.buf);
 			if (!level->dir && errno != ENOENT) {
-				warning("error opening directory %s: %s",
-					iter->base.path.buf, strerror(errno));
+				warning_errno("error opening directory '%s'",
+					      iter->base.path.buf);
 				/* Popping the level is handled below */
 			}
 
@@ -122,11 +122,11 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			if (!de) {
 				/* This level is exhausted; pop up a level. */
 				if (errno) {
-					warning("error reading directory %s: %s",
-						iter->base.path.buf, strerror(errno));
+					warning_errno("error reading directory '%s'",
+						      iter->base.path.buf);
 				} else if (closedir(level->dir))
-					warning("error closing directory %s: %s",
-						iter->base.path.buf, strerror(errno));
+					warning_errno("error closing directory '%s'",
+						      iter->base.path.buf);
 
 				level->dir = NULL;
 				if (--iter->levels_nr == 0)
@@ -140,9 +140,8 @@ int dir_iterator_advance(struct dir_iterator *dir_iterator)
 			strbuf_addstr(&iter->base.path, de->d_name);
 			if (lstat(iter->base.path.buf, &iter->base.st) < 0) {
 				if (errno != ENOENT)
-					warning("error reading path '%s': %s",
-						iter->base.path.buf,
-						strerror(errno));
+					warning_errno("failed to stat '%s'",
+						      iter->base.path.buf);
 				continue;
 			}
 
@@ -170,9 +169,11 @@ int dir_iterator_abort(struct dir_iterator *dir_iterator)
 			&iter->levels[iter->levels_nr - 1];
 
 		if (level->dir && closedir(level->dir)) {
+			int saved_errno = errno;
 			strbuf_setlen(&iter->base.path, level->prefix_len);
-			warning("error closing directory %s: %s",
-				iter->base.path.buf, strerror(errno));
+			errno = saved_errno;
+			warning_errno("error closing directory '%s'",
+				      iter->base.path.buf);
 		}
 	}
 
-- 
2.22.0

