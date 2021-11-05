Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30CFC433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1AB611EE
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbhKEV7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbhKEV7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 17:59:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189AEC061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 14:56:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r8so15828904wra.7
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ue8zd+YmaRB3vmi67R97EfU4ma9kx4Wcq6E/c+/N0pU=;
        b=OA/uPWz5mlPQ/nopqiGQhJxpnqgkRWgu6ArqxofMZaCKoWCDUpcy5y7OBlLjOd89iZ
         N7N0NIUNP+zvVltkufSo3EG+g2B7VDW043XlNFTeoz0danAQq/RQILX8bFm6B8/HtwYQ
         FHmM606w2qll7Mdtjr0XH9LUdl8+gZUVtSjalmLnsPor3D1CAjyWN9ww/PaBU6IKxRBE
         PKz4XvP6M5rRMDCUmiXCVprYZQXEj1YGoEXJ2IXO3A1rkQZ567z1o57p2lny4n1MiOv9
         XlJEWjsXcfXPKnIE4jrB1kOf1FfoR/TjLVX+qQCnCpaGh2yDAf4Aia3F4owPOaB3pYMj
         z7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ue8zd+YmaRB3vmi67R97EfU4ma9kx4Wcq6E/c+/N0pU=;
        b=PneaXKG3LVthcHhIvHsK9HTHtuPPLyuRfx02lw9dzlQ0cH7ieAKsCKjv2X+uUBAu+Z
         SZWcUiXS0CiMR6xw6j7uhS68lXdOeddj2jW2b8LLlMBi3DWjpTkdUc5+gHwfx70fbG3n
         rwcFLkDMSC9PTc798jgRUdVOwCHDOED7NzCAWzsahBCvq2DZ0nugl0SrueUQBl/vqeMC
         +PEqrlyETkuK07rVJ1F3m0L+DesYL4owopBmHPZGkHqSDy90noZ03aeAz0CY/rw8xQNR
         MH08jFXGBiRZJWB9scUwTqJDI7gnRmq41c3m7LMz5eH7AHn8sdDqJNU26n3JILjuix8H
         koFg==
X-Gm-Message-State: AOAM531sF7RR4aR7YWuvtLnG0kMGPLUY0PX9csha0NpJdJ1auviMmjyh
        J2TGF+DoetiRLcxJomjIoQfA7yhKhh8=
X-Google-Smtp-Source: ABdhPJwmAOufj4OS5G8x1LOE9WdBeZyGbqSe8DGWYPhw1O0/IBAVvMiRHufL3Kgst1Rm1sZbMSKJxw==
X-Received: by 2002:adf:c40f:: with SMTP id v15mr68188309wrf.302.1636149402593;
        Fri, 05 Nov 2021 14:56:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4sm8842894wro.12.2021.11.05.14.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:56:42 -0700 (PDT)
Message-Id: <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Nov 2021 21:56:39 +0000
Subject: [PATCH 1/2] cat-file: force flush of stdout on empty string
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

When in --buffer mode, it is very useful for the caller to have control
over when the buffer is flushed. Currently there is no convenient way to
signal for the buffer to be flushed. One workaround is to provide any
nonexisting commit to git-cat-file's stdin, in which case the buffer
will be flushed and a "$FOO missing" message will be displayed. However,
this is not an ideal workaround.

Instead, this commit teaches git-cat-file to look for an empty string in
stdin, which will trigger a flush of stdout.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 86fc03242b8..4d17f30f24e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -405,6 +405,11 @@ static void batch_one_object(const char *obj_name,
 	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum get_oid_result result;
 
+	if (opt->buffer_output && obj_name[0] == '\0') {
+		fflush(stdout);
+		return;
+	}
+
 	result = get_oid_with_context(the_repository, obj_name,
 				      flags, &data->oid, &ctx);
 	if (result != FOUND) {
@@ -609,7 +614,11 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		batch_one_object(input.buf, &output, opt, &data);
+		 /*
+		  * When in buffer mode and input.buf is an empty string,
+		  * flush to stdout.
+		  */
+		 batch_one_object(input.buf, &output, opt, &data);
 	}
 
 	strbuf_release(&input);
-- 
gitgitgadget

