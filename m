Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90597C3F6B0
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiG2Plc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiG2PlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:41:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B23DEF1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so6475049wrh.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gi7eQE4bphs3GvKkhd9KoO0LlbN4b6qLPf3k7p/Di7w=;
        b=evS6pT1SPp6dUeBqeZ6+hkbtqi7YdPg3FRuOcry/tLM1mbEpS4N1Q2OyvwftR214YX
         GtfzA6Z52Yye4SogFwZAG38TavOs+eEqsnz69quJTy4/EJlbIs8krmq4uNOkdNqudTq+
         uMm6i0wE85Rjm6JMQfpI83mCxZr/QlVXycTuqjY65QouaMTYg6ZXYwexkM8t6CNBdpCi
         AvYe39mDn+g5MASQjaMt2iXpfvKdGLtiCs4J5hmq/R+dNI+rTApPxtMMwEWnO1La1Xat
         UDFBL72NZ2m0Ssprboujozu7PvQYRC2M1vG1+MOQ0J/JGXtjhVBeizGaccJs0akJ7Dif
         z9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gi7eQE4bphs3GvKkhd9KoO0LlbN4b6qLPf3k7p/Di7w=;
        b=RusXXLR9slUpAjbZEQ5V3tAS8ClqW1hB04wyd2qYnqF1kTMkk1k4tnI7NgakiBe/iR
         UvsoQaCxlqm+/P7l5V7llAsjhp3fbjrq4lZcdgG7Bh5mywp3n9FPwX1YOgaBAz5o2OUL
         iXTie38JwebTipFvxXkDUZArYTUWDACaVjohEpQ2E4V7G50Zue3bM7/8peNF/77JeREG
         qWfDHSEM0qyKl/XrwRJvTY5a2KxGtw6eWGwQbIqdcVF9VeyXCvhe5R4xcrMOxjlpdWx9
         /2w+X30yeiLW3l0CDaooP5UlJdk/1U/q+VE+DEyXExpOCFj29AIYmSU7hqnjjf/nZBJ5
         +uKA==
X-Gm-Message-State: ACgBeo19WHDItFSJtd/ed44/KbaFDuBJiKe3RXJeCYMD96x4k7PM/bm8
        kxYRy8JwIREKztx6kehFJi/w139DXrk=
X-Google-Smtp-Source: AA6agR6fShHq9ExSidelVM0ZNknoKRTZ7BY5NF0dKTC8t+l/cI6YOYn+CNQT2TtSE/yU1AToHVYzGQ==
X-Received: by 2002:a05:6000:1d90:b0:21e:b665:d90c with SMTP id bk16-20020a0560001d9000b0021eb665d90cmr2841689wrb.273.1659109276042;
        Fri, 29 Jul 2022 08:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19-20020adfb613000000b0021e13efa17esm3847632wre.70.2022.07.29.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:41:15 -0700 (PDT)
Message-Id: <5d9b087625a454ad3b505bb968bb72ce3d54140c.1659109272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
        <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 15:41:09 +0000
Subject: [PATCH v2 1/3] windows: include the Python bits when building Git for
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

While Git for Windows does not _ship_ Python (in order to save on
bandwidth), MSYS2 provides very fine Python interpreters that users can
easily take advantage of, by using Git for Windows within its SDK.

Previously, we excluded the Python bits, mostly due to historical
reasons: In the Git for Windows v1.x days, we built Git using
MSys/MinGW, without support for any Python scripts.

Therefore, let's move out the `NO_PYTHON` definition from the generic
part of the MINGW section (which includes special handling for MSYS2/Git
for Windows, for the long-superseded msysGit environment, as well as for
the setup of probably just one developer remaining with their MSys1)
into the two sections that cover different environments than Git for
Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index ce83cad47a2..fd7b6a90429 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -656,7 +656,6 @@ ifeq ($(uname_S),MINGW)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
-	NO_PYTHON = YesPlease
 	ETAGS_TARGET = ETAGS
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
@@ -686,6 +685,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
+	NO_PYTHON = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS
 else
 	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
@@ -730,6 +730,7 @@ else
 	else
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO
 		NO_CURL = YesPlease
+		NO_PYTHON = YesPlease
 	endif
 endif
 endif
-- 
gitgitgadget

