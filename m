Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1470DC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhL2SzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhL2SzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3343C06173E
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:13 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso12150799wmk.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=LK2jeV0zXC/FDkAXHFL2ZXMDg0YWKOxDvBKP9KXwImqAduliVuBxh4nHi+JSQM3Mkv
         RPphsTbFKXn8ugrwyFIeIQsLXaoWtBC8pSZUjglEIFbUsUIJ06ICDkkht505mqQqqp6C
         tyr7cGeVmoqKmg26h4QTWZRWRzKrkjuSZILLFzlhEl5u60j68VhyXch6zUU4jkMrJSs+
         jnB3P1uiVnlLZodJrC7UipuJmQYwRlqDMzxQ+Nlla0opuCwvihbUdUcFZo3BHJl3Lct7
         vpt0yRyjQTx6qPmwIo3dwIawwXcC3dDNcEdW8pVFvK76o7k9Vtk3/1BC0oonIVav1bGh
         c09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=dRoS/HwHQFFFt2AA1bAN1r4aoVR5fV2Q98LzCAd6PTKfrVKgOzN9vGn4rTsy5/n5+y
         rMHKfykwuutoMLjXl3FdJWYdqQTeQ0nJS3FRWGNgd8Fzu9shGC+EJ3unz01+lGQW2I63
         LrrdKuciIpVLQQE1RZSY2Bs6op2VsHVfnLKCDDBKQnHwi/UUhE8UkC8HWuI1uh2I5iIM
         Hgyt5lYXXm8QSyo7Nz6Fh/cFW8WdFsJ9pRpR40TYoDNX2kP21bgCBh02HNeXosgJmq/c
         7MCf1cpO0qGq9p26Ha0gmD0Qdw5FQf6RD5hHJKWOgKYxsgE+Zot6HnMqHG0qPzufx92U
         zzUA==
X-Gm-Message-State: AOAM533VxqPVH1Irx0+k5uinoNx0XJ8XtxYColUbPs2T062P2qOKu8cF
        Vm+V7pm5Ef0UDAFdWN7ACoQATwQMvb8=
X-Google-Smtp-Source: ABdhPJwOgz16o116rCpEpG4qjpS4syjk5XB2tXVDmke7FIs2iB2TT/CkINMY1NJBBZNrr9E4w0rpvQ==
X-Received: by 2002:a1c:1b15:: with SMTP id b21mr23018964wmb.174.1640804112152;
        Wed, 29 Dec 2021 10:55:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13sm22213275wrh.32.2021.12.29.10.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:11 -0800 (PST)
Message-Id: <a2b42087342060b270c2149c552c8d4967360211.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:00 +0000
Subject: [PATCH v3 04/11] i18n: standardize "cannot open" and "cannot read"
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

