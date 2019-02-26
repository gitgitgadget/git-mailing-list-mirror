Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F215520248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfBZA0y (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39021 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA0v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so11955745wrw.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0YQwzEt1WN9Hjju18SV/huk2vsIYdBsYKe2jpwGovI=;
        b=Y2hqQroSrXya+dLqdPlJVsgVqmAJ0jyBEPHY0FJRFZcellIojdFNehus1IiscqU3l1
         N/ASkbVJhSfKVE9FO7xqR6aczyQ2x94M8IhHLSOGCMb2HvQ09nrLdjNlC21GBgMvE5n+
         P744rzxxbX/OwrxUXoSRRM+E+1WCyPuZmcSN4u8Hl/idqn515jDagqbRyvXcVi5VmICP
         P0V71JH4mZi4b+3/vfYRJqtfxS13s5zYipLbJFNwJutDZ8xkFoMwk1w+qaepA2Sns/T2
         KrgxB9SA+TyDxlRwjzihBvcq5N0Y7ZhhViHZVOl7Ev55UH3yHKxxLmhXtn7J0d3kSuQT
         iqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0YQwzEt1WN9Hjju18SV/huk2vsIYdBsYKe2jpwGovI=;
        b=YjDWu0fbxnF8t/hohUhLBtyY7oIXtdbcOMXglIXqRmpMXnIspoDlEj/HVokvWif/iy
         OuUyLz8Fcd0DN7SjC5Ctyqlr4L4TbkNiAqeb56E1ipTLfi+aoxTj/ASOIDpYfTHAstnV
         UOXSG6ivySiTCyX3gb4tNbJcRW2u8LCRcefkw82NANoB+q6ccVf0f82j2Zk5zQzdQQFG
         uBfzNgkkRlnyf0kDQry73yOgIYT5UI4mnVE1u/AaScUS+BUshaST35YPXhpqGecUNXl2
         B/lPMRKgXgqHQiLLhJw5Jp42+UAMVS7wziQlGH4w63N2zZH1sfM8urYLK4KC+QWz1uho
         X/pw==
X-Gm-Message-State: AHQUAuYVXanLhA2u2I6F9y7juAI3XzaBu8uDbLRKQQMkPvUi/VKJhVP0
        p1gqcbt1fCwPaWGrybqSHfRrLjSJugY=
X-Google-Smtp-Source: AHgI3IbXBI1XqSa/6mldsyMNiUJ0XvUkWIlxiYl1i3pGEZeRhy7jxVinyaASy5zMJ7HxCDtt1yLSlg==
X-Received: by 2002:adf:f4c8:: with SMTP id h8mr15455541wrp.6.1551140809315;
        Mon, 25 Feb 2019 16:26:49 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [WIP RFC PATCH 3/7] clone: extract function from copy_or_link_directory
Date:   Tue, 26 Feb 2019 01:26:21 +0100
Message-Id: <20190226002625.13022-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Tavares <matheus.bernardino@usp.br>

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help removing
copy_or_link_directory's explicit recursion, which will be done in a
following patch. Also makes code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..862d2ea69c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	/*
+	 * Create a dir at pathname unless there's already one.
+	 */
+	struct stat st;
+
+	if (mkdir(pathname, mode)) {
+		if (errno != EEXIST)
+			die_errno(_("failed to create directory '%s'"),
+				  pathname);
+		else if (stat(pathname, &st))
+			die_errno(_("failed to stat '%s'"), pathname);
+		else if (!S_ISDIR(st.st_mode))
+			die(_("%s exists and is not a directory"), pathname);
+	}
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.21.0.rc2.1.g2d5e20a900.dirty

