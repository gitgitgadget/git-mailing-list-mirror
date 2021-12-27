Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6665EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhL0XYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhL0XYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:04 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E56CC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:03 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso9086875wme.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=MePD0MLS5MYb7ftBl6VJLbXQ8k9bxDVSQ5ZDwEgsw2AElVWbJsUrQmR1gElo2mc/Cp
         fbYpVcEpODj5ikIke7YtYMYbLGAKLOdNi7RuabvFr8IMjZRZ+2KdtSW53nOTetOhS5/b
         qqUk/jR/z2KlOUo1eGRXbC/N4Nor060kVi7veaa7eNSZZ8/etzz7ONIPgOOijQnJhxom
         hMPp7Z790n7T5z3hQadfdAci2XwF+X9TyxKHG0ylk7nGYNYIA0FK8gFdWFg8qDVmFZL4
         OCXLS6jBcrRa0Gqowwe3RZ8WLEBXoxTz25a4208K08S2exa/2UIKy7d0YowLGVill+No
         rggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=eY5YsBr0q6qr5tmjS6hBMs1tZ0UrucZFDJwiUBLoY/7mK30hr2mC3vbAv/I2B8gYEP
         8m/m7euv/S1+CSgsNEU06gS5OUWMLXJ97k4iCEV9kzze0R9GHxeaiym26vNzd6iDhrMb
         N3g0pbxzBlSC5h1HPnryoHbDrdsIQPGwKVf+VhYDmKB+1Hm3/W0QxHW0roVZBJiN3Brf
         E0BG6gWgnJuCL337VrWJb97e8zmWpfm6XFI9eEFJly5gCM1XlCe3+rZ6S+pKusUcF8i9
         de15SvN87GrXzitPoiGtoXsknlW04soQaw2zkAa8iU98L8TllqARUm+EiDBY0UBKX0xF
         CKSA==
X-Gm-Message-State: AOAM530C63OxLIhHNMdIIqtma3v1pyYVG2KkKjGgxBk7idTSetVJ0Nhd
        eLJ3ONX83IO5nEDiZBGG7idTJHuklB4=
X-Google-Smtp-Source: ABdhPJwvvqRRWdWc+YwnP+g9L4sENIL3OdxPx78+6/WwoNQ4iB9RlZyEp+cFHZgJDJym3Ta4TxSB/g==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr14989284wmj.15.1640647441908;
        Mon, 27 Dec 2021 15:24:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 14sm17947521wry.23.2021.12.27.15.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:01 -0800 (PST)
Message-Id: <88dfde62eda89a9c22194b181166008830aadc77.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:50 +0000
Subject: [PATCH v2 04/11] i18n: standardize "cannot open" and "cannot read"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
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

