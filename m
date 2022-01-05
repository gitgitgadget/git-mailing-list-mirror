Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C1BC43217
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiAEUCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiAEUCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936ABC061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d9so572504wrb.0
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=UqrPiexJlwSXjhukLCSF8VCSMW03ug7SeuRvita02zd13Vu2J/g7ZfnVFl/Mplzwty
         lKtml0c2WiE0i/mkbe3J8SfF5ghhNuMvQ9ybFdDURZOFz4pxA2dS2Tu7oAcji2jWwSfy
         UoK342H9xjjiCO2HzyyU/lLadGmHxovnVbJHhtpGgw3OsKgKRLhvIoHLk2p8190ohsEl
         IRM5BCo53tn82IYQXlU0zyX5BzYWQSj98nwzZ0f0pt5l1WCMYe/5oBfhaGnCGj/I3xza
         aaFn4u8WVJbpodXcRgFnWtnxHYBsdNrsbW2APncFxqthZZUUK81ZPUTr/3i1I8+iL+y6
         igcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2i7GcNJ78FgiIt8YPh4wnGl4jPlfW6qzCRzbbzfKR7A=;
        b=C1dzUHBenk2FChhNfO7Q4kRaK0pkH9Eyh+to775gl55PT5Pis/hoXvc8wjH3VRfshW
         msTYaz4zC5achzme3bZvPxc9EviXZnHTWHmqCIiJ4AmfYjbxLq9M3xHhmuWjnN8w6cLD
         9r/rkIXhcM8tiYYP/N96XEN3P4BVCD7v4wg3cG+tsdFQjlJwtkzROJ+Nk4PWXFM6ydkR
         x/Jd5ldlPq7fltnKeqUjIK4tH9lXBWQ2pbbDRSni0CD6G1dkDUK6hFi0yRKqOx488o4J
         mzs4uk9oV1qh2afXBt58imPdgrNDnwcyaqoKQXrim2Omqg2ptYDDXcIsx/l9iM0UTBUo
         ykSA==
X-Gm-Message-State: AOAM533lv/zRtYEcs9Lkq4QgwzAxoMlFKsd26TIuzmbXv6SFcA5Vj8ZS
        aKx5z4WZocn4p+x3hl9PPt+JfVsQATs=
X-Google-Smtp-Source: ABdhPJzqOW73jKE9FFVMNeFm0WPyLXZwTLczLIrNgRAIzm7RAhBoeZDoJuC24gNqQRckKuMT+a4lcA==
X-Received: by 2002:a5d:6da3:: with SMTP id u3mr45196395wrs.712.1641412948896;
        Wed, 05 Jan 2022 12:02:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm47367008wri.21.2022.01.05.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:28 -0800 (PST)
Message-Id: <49e41dc136fd28a0054176754ef8941acd63ab82.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:17 +0000
Subject: [PATCH v5 04/11] i18n: standardize "cannot open" and "cannot read"
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

