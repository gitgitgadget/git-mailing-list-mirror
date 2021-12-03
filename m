Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05736C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378766AbhLCHFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378758AbhLCHFU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09494C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d9so3679234wrw.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3NIj3RGET4+cxqJiOuqdUckWmvKtMttcb0xrR2p7udo=;
        b=dhHhJZCpkbDyD90lNxtcjeAbHIV6BCKJxMVuJl6IpHCyh32Nh9XuoJk1DX8WGQ7VqH
         z0YU1hzWPoKHgdmoAU4aiUQ+0vstoCq1k553u4u223alLLHFhmP2PULBR6NslNz2yXST
         ImIrcfgGNzR3FlPjn8SWMc5tRztEdd1QQZ4oov0iNTCjgbntwRn4uMlEojP/qDXvkliR
         h8CfNtkYcB4tqSPU+2h+2/pMdMVCKVzIldDrRvQ9dEgrXB6V5DTudacSdj5FAOwADmz+
         Psg1xf2AkhqO9tzZ0Pu7rqXF6jQkVOEjAXd86QTCC4/tvdDTtJbyeJtFtiAT3Xh/alkw
         7YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3NIj3RGET4+cxqJiOuqdUckWmvKtMttcb0xrR2p7udo=;
        b=jy2ktxe/0HUAn97e2Q+GTqDPtC8fOELa5CAV1A392OBP0DQ/s18nFjJeFSYRPXYF5m
         pm3Gp3/guYaNc+UOcPaOUCj/B7wAo7CW43SLxiu/gh5Jjd+qchhH4RDzxVB+IkzvhFjF
         biW/7I4ZJ73fSUtHjGB5DpUOwcmSQuui8m0rcH3RhvTV8yBSwfR1X8AK13dNioce2vyz
         3uDlWob9w+6QjKX3we09M3Bjv29IfxQX1QXd+cjmsHlOY+xEZelEYJTPEpnG6Jd0rWhk
         htTieI2Mceu+JraR28FHgFH7oj9S8xDAa83Ezlvf/9iACvldK0nnMLskXsqVCWcM8l7z
         LgEQ==
X-Gm-Message-State: AOAM531WxGIrbv7pT9vPG94LHQjPavcU3Ni0rIff104+m1FMOMjRdT+u
        e1mbwCJ8wweo5ywVEXXcjYb+Bia1j7U=
X-Google-Smtp-Source: ABdhPJzZVrncVDeQpkvk8tIG4bbzFGV2EKhKqfwsgGevpDtUbQL5mD/o1cwVOzfXD32RW0rT7ReNhg==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr19788144wrs.272.1638514915486;
        Thu, 02 Dec 2021 23:01:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m36sm1784132wms.25.2021.12.02.23.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:55 -0800 (PST)
Message-Id: <d408cecc85fad1177676c1cb404c0dd0b0a8fbb6.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:43 +0000
Subject: [PATCH 04/10] i18n: standardize "cannot open" and "cannot read"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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
index 10376be7161..f1208beacff 100644
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
index bec3cc7535e..b0d63149388 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -995,7 +995,7 @@ static int open_fetch_head(struct fetch_head *fetch_head)
 	if (write_fetch_head) {
 		fetch_head->fp = fopen(filename, "a");
 		if (!fetch_head->fp)
-			return error_errno(_("cannot open %s"), filename);
+			return error_errno(_("cannot open '%s'"), filename);
 		strbuf_init(&fetch_head->buf, 0);
 	} else {
 		fetch_head->fp = NULL;
@@ -1405,7 +1405,7 @@ static int truncate_fetch_head(void)
 	FILE *fp = fopen_for_writing(filename);
 
 	if (!fp)
-		return error_errno(_("cannot open %s"), filename);
+		return error_errno(_("cannot open '%s'"), filename);
 	fclose(fp);
 	return 0;
 }
-- 
gitgitgadget

