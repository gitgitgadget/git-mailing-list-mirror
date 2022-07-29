Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF611C19F2A
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiG2Plg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbiG2PlX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:41:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389A12081
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v3so5525398wrp.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+6FtO0/+05uguURs6ak9Gq3aZzCBnSVJ8wOIFP3buLg=;
        b=p7zfWGjdgB8HqjDKZod7rh3tlfO/KyW7xlFv3nt7nLq++4mGmJIBUudtrTaFF4tiLp
         JroPPNBRFCAf+KKCJ3DKGthL2PjD1wfH87fPptgueBIr/bjjS7A1tkhPuwJ/nckZvmKT
         IE4LAVxBm6Mt0ZOxKGA6kGp6LTreMKoYNJDt6G+tSYeQcP692E+djpIX/IZrefRDtwg+
         XOPzdE/HfllNq/fvyEJxReWjz4agdJ9YXv3TxAHzFpBRiFNiG68d8BlwmYs/rOmdLtnr
         tHbKr+amhZ5/uunjgqoWWJMWZIPGIGOUbtez1CF/dgahnj0gESTYHbZrNLbgAXtHokpl
         L92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+6FtO0/+05uguURs6ak9Gq3aZzCBnSVJ8wOIFP3buLg=;
        b=pZGSWSlTXSe8DHj6GXKZqOcb6OY71N9A3l3F2n8zwDMYWPAiBsVdLNheMZAA8UOlss
         Msv8OOqe4/M/btBZ6XGPSmvvFxDABRccQ/iYQm6Hl8t1RE/ZB4vyK3nRLTr7iPUrjM71
         9NA6/6msq5mO5QNZhiA1kDWT6b4HzNVu1ZYwUM5dSDNvjaSkfvhuQfBsjHnu3012pxdW
         qbcCf2fBwv44lIZdhoRHrArxtPGHIUMiFQRU4oPV8JS8AD3Ucqz8txzsPMf6nrzV29Ag
         bJsvvjFvzJGgt9VY17COHmN+zoGIqRhD4Zqwo0zZCKtJl7S3m67vSrFheRwWmsPVIC5f
         Lujg==
X-Gm-Message-State: ACgBeo1/Q4+Bs+XMi3bK7OlbII7eXjj8yLeyqdm52z1UWVON5+rgegPl
        JVEakplKp1uRoeRM1JGZF42z+pGcG8k=
X-Google-Smtp-Source: AA6agR4odNrlWs6ilIlcpVIck+uh+a+PodtJp9pabpN9htfrrBVSu4wDnXSCaxrla0s5u23sc1EUTQ==
X-Received: by 2002:a05:6000:18a6:b0:21e:8737:45ec with SMTP id b6-20020a05600018a600b0021e873745ecmr2915123wri.335.1659109280041;
        Fri, 29 Jul 2022 08:41:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6b06000000b0021e5adb92desm3922092wrw.60.2022.07.29.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:41:18 -0700 (PDT)
Message-Id: <7dc0a1a9aa81fcd5c464c48995a61492fb97db1a.1659109272.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com>
        <pull.1306.v2.git.1659109272.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 15:41:11 +0000
Subject: [PATCH v2 3/3] mingw: remove unneeded `NO_CURL` directive
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

In df5218b4c30 (config.mak.uname: support MSys2, 2016-01-13), we
introduced support for building Git for Windows in the then-brand new
Git for Windows v2.x build environment that was based off of MSYS2.

To do that, we split the non-msysGit part (that targeted MSys1) in two,
and instead of sharing the `NO_CURL = YesPlease` setting with MSys1, we
overrode it for MSYS2 with the empty value because we very much want to
build Git for Windows with libcurl.

But that was unnecessary: we never set that variable beforehand,
therefore there is no need to override it.

Let's just remove that unnecessary line.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index e897b80b3a7..d63629fe807 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -719,7 +719,6 @@ else
 		HAVE_LIBCHARSET_H = YesPlease
 		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE = YesPlease
-		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
 		ifeq (/mingw64,$(subst 32,64,$(prefix)))
 			# Move system config into top-level /etc/
-- 
gitgitgadget
