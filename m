Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D32C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 19:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiJFTna (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiJFTnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 15:43:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B43E319F
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 12:43:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so4244897wrr.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joOIf5y1TlPqrhNMiSzaXmom0S+kqc5lnXmlHF0kZw0=;
        b=PFfxTrVyLhCRMDvawi57VwiyXKvdlfGxllvPCZNEfyJVjWTeKKPsrQBSXXT+S7Tty3
         L4K6wKmPpH3YssmBhCjMGbUsWsmn/icUA8i/x4QQvi0fTAuMDMkak19Hk6eWXbOzcejO
         rjROR5DPUd2W6zjbcab19+boeLXNH0pa6FSIE8kJTJDQCdLfp/NDTA0FjuxPKu2Jo/TW
         DXjy08iIFw0onNGdJLNvgKdL510cXkH62xlmBuU0aQGYXds04xyQ30Lv2kOwSFO0uXgG
         dYUclAeqYjRnuAxg9ZzSxKzc+wP8rKEovH9OAHaSMYEQGqGv4SfiIfwsth8SW8X0v5wr
         RqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joOIf5y1TlPqrhNMiSzaXmom0S+kqc5lnXmlHF0kZw0=;
        b=5ZW/xeVh6ImyDzAnxTE3ZlzWTgAWXReVATp140sooaCPHiSfJWIAb3k1WuPSXxWv5N
         m+jVNXumWL52cRp1OmgZT4pLCjrbxGjN2/UqPoiip04y31hmLXPAwRYGKC2kYpTmIIlh
         kdQ9pwQ86AX5iknpFqLD82Qom2iqTKSUjih5ttUPfxu+Xz13jr7bY3eQD/QfOTOmDMGW
         GL/sCWWTgXPXorpCYfN/hRI9poqWdY4snFIxQeM4yxkEXFE4ED1+2VIodcmhmB74z57u
         rvZiV0o6yjnunyyVdic3mJP2K1veV9l/pqBGNC3jgbxxV27iOwrJok0OcJoEzv/FnVm4
         U/hQ==
X-Gm-Message-State: ACrzQf1boY1L60a7DilTqO+PAZnkIlmh8a8nXca1jQ6cNZRJKtlHaS0i
        YkrPbtyjOAKoLDsHnH+2UoF8yDxmr38=
X-Google-Smtp-Source: AMsMyM4/lST/iO16VVPOnwKv82ca0tVnIhB44JqmOX4RziJRh7vmbCXt9b/H45AuY4ZebaIxLWsn1w==
X-Received: by 2002:adf:ef43:0:b0:22d:c507:dd48 with SMTP id c3-20020adfef43000000b0022dc507dd48mr1011383wrp.416.1665085398699;
        Thu, 06 Oct 2022 12:43:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11-20020adfdc4b000000b0022e6da05e43sm158056wrj.89.2022.10.06.12.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:43:18 -0700 (PDT)
Message-Id: <e5009a325f234eef7e80335e458fbe11a2ccf5f4.1665085395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Oct 2022 19:43:15 +0000
Subject: [PATCH 2/2] builtin/unpack-objects.c: fix compiler error on MacOS
 with clang 11.0.0
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add an extra set of braces around zero initialization of the `zstream`
variable to resolve compiler error/warning from clang 11.0.0 on MacOS.
This is not needed on clang 14.0.

$ make builtin/unpack-objects.o
    CC builtin/unpack-objects.o
builtin/unpack-objects.c:388:26: error: suggest braces around \
		initialization of subobject [-Werror,-Wmissing-braces]
        git_zstream zstream = { 0 };
                                ^
                                {}
1 error generated.
make: *** [builtin/unpack-objects.o] Error 1

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..4b16f1592ba 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 
 static void stream_blob(unsigned long size, unsigned nr)
 {
-	git_zstream zstream = { 0 };
+	git_zstream zstream = { { 0 } };
 	struct input_zstream_data data = { 0 };
 	struct input_stream in_stream = {
 		.read = feed_input_zstream,
-- 
gitgitgadget
