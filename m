Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07486C433F5
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiABRP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiABRPy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30941C061784
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s1so65742341wra.6
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=DtsVOHxCCG+f7NbKIQXav4xFiBqoHwnJWJtC+EUOaEFuphgjM8ffavy9pVmCZGnt9B
         fv8GfiVrP8xhKxi0f4tXn3vFOMS/cupx/LpmLDCLlhrOaTd5yrzJTCZik3vPOua7il8o
         d1AXxmIprn7E0iHsUM6BU63kyizwAdM48gDc4vUkFRmmqdy4D/TiY5TpGo18lveAOcAJ
         15u8Uj8ZMfHgQ7afbt5+rlQ9Pq99MVA6IxUq9ErCoAm3EjskG+gadedQIZtjK3aQQTvw
         IHjAK99hreEtSEwSrrSXOuOzz/GA7YYAquhvA1L6YAXWH9z+D/00rXaFyR5ra12DfjoK
         tfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=Xxq/MKRutjaQft4vbqrpiN+HLLEc5lNX3f+ZY8WR5nS+9nlYlaOVxi3LL00nRCpuLB
         TY/ymdbcE/Z/KfKqk4kADm4Zw0bzMMeBrrlEUN1TCowqxyrVNAlu+L3a6Hcw3mqCFO2k
         ALRw7QkRulXLTqXwv2AA3UAjvhABD3ut8H9SOunhy43IgLGEUuC1qvw5bt/wh/dNM3mc
         MlmFo8dCdXBL9MDybFkm4XWJqdK7+Y8Kx7yIH4OanaAAFNbwlD2kG+GjNvDZrJ45Xmb/
         FaimvJwv4vhGsey8usXTV2TfjRxlFcLFRYImugB9IDGZdghx/dGt9M8elNqtY42DW0SZ
         6vjg==
X-Gm-Message-State: AOAM5310DLOs5YvQnMc7m3bm+HOQ4dRZ1r5Hpd786U0ZxZeBu7P099pV
        fgQs4sGJuPF7+5Cyif6atCKHc8bPzP8=
X-Google-Smtp-Source: ABdhPJwoGSC2PhMcg/2/Mcjex3etjBb2wugxM/SP3bL7rxe7/iKKbbqCKit/6qTCkrJdZNTnHixueQ==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr35671489wrp.263.1641143751597;
        Sun, 02 Jan 2022 09:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j3sm32693104wro.22.2022.01.02.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:50 -0800 (PST)
Message-Id: <51c53f01dd821d119de5015b42684e4805be0d0c.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:38 +0000
Subject: [PATCH v4 04/11] i18n: standardize "cannot open" and "cannot read"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 archive.c       | 4 ++--
 builtin/fetch.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index e85ba169088..78d35467008 100644
--- a/archive.c
+++ b/archive.c
@@ -185,7 +185,7 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
 	if (!buffer)
-		return error(_("cannot read %s"), oid_to_hex(oid));
+		return error(_("cannot read '%s'"), oid_to_hex(oid));
 	err = write_entry(args, oid, path.buf, path.len, mode, buffer, size);
 	free(buffer);
 	return err;
@@ -338,7 +338,7 @@ int write_archive_entries(struct archiver_args *args,
 
 		strbuf_reset(&content);
 		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
-			err = error_errno(_("could not read '%s'"), path);
+			err = error_errno(_("cannot read '%s'"), path);
 		else
 			err = write_entry(args, &fake_oid, path_in_archive.buf,
 					  path_in_archive.len,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2c584c85812..c0855c363fd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -996,7 +996,7 @@ static int open_fetch_head(struct fetch_head *fetch_head)
 	if (write_fetch_head) {
 		fetch_head->fp = fopen(filename, "a");
 		if (!fetch_head->fp)
-			return error_errno(_("cannot open %s"), filename);
+			return error_errno(_("cannot open '%s'"), filename);
 		strbuf_init(&fetch_head->buf, 0);
 	} else {
 		fetch_head->fp = NULL;
@@ -1408,7 +1408,7 @@ static int truncate_fetch_head(void)
 	FILE *fp = fopen_for_writing(filename);
 
 	if (!fp)
-		return error_errno(_("cannot open %s"), filename);
+		return error_errno(_("cannot open '%s'"), filename);
 	fclose(fp);
 	return 0;
 }
-- 
gitgitgadget

