Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED1C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7634660E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhJ3Veh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhJ3Ve3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:29 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C03C061570;
        Sat, 30 Oct 2021 14:31:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p14so22161529wrd.10;
        Sat, 30 Oct 2021 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IizQo2+E2LOsZJAioF4St0WYNavxVQ5WV3WQglcONL0=;
        b=aIhgiw8gmrUvBanIQO8s2j3ES/5sssVOFiTB8ixY5DagGUvaYXKzQTqH42CHxe2tqi
         LY4nO+/umhZ5tAUmJzHngBM+1NyFFm2ex3xmM5HuuVE2OWbWXOmVfK8zC9r4+oKS8sMZ
         57fE1rDhZoZchrdsijPEW5HiFmxTFKjSXgocP8ua8Rs95/Q1hNPuaGmimN7r0QemwqD0
         MO0rkwjvfyZC8PA/q6dPOnjdt8ElC03DhNbp8XzxsjB1tP21U++GVcFd7it6vPKXpzEQ
         bTHulbeJ8x9RgcmiFmHLJfP07IpqefDv8c99BEMWcS3hV1A77J1gy16P5AflpEfbAe6z
         t0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IizQo2+E2LOsZJAioF4St0WYNavxVQ5WV3WQglcONL0=;
        b=T8xKSUma5IHJ4/n3JXCk8/OIzhV840DM6sUpFQgBuybUwfX28UDGKUKyGeg60Hp7zx
         gVNjL2ZOZ+Oft6mEiJ2RAlulpMcnehmL7tBQsTDscmCbeXvJ/hoJWq0dOhKDHxp18app
         Y91CW1T2XL4+I2v5u53uq0nZLKQqgg0LT8ymmi8mwWwH/tj/4/OMteNcb9ba/F+We1sx
         i6Xod2u/lILlGROMGMIuvIvjvEGHNODLep0CZF7MIvG3QHGA8AHJAolDFvQwGP03QjOo
         Eu2ty8Mel0S62qiNdh/Q423ZTAAXpYJXxoU07bUNQesY4EJ25AxUOCYnOHNyn/I/xSWf
         RrWA==
X-Gm-Message-State: AOAM532bkeZfDZ0XDqwNfSu31tvNQdM3LQasYCpDLKSdho4pWxe3vHph
        GKuE60WO/TtNEBtLqAL46zfOqkOT11k=
X-Google-Smtp-Source: ABdhPJzJO/DVzqfL1yRa+DxvV/qSkDegDL8YxM/XXEf948KtPUdDFt1IushpdQGcE+pXbRIs6EtRWg==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr21812341wrq.44.1635629517338;
        Sat, 30 Oct 2021 14:31:57 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:57 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 04/22] getunwind.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:14 +0200
Message-Id: <20211030213131.140429-5-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/getunwind.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/getunwind.2 b/man2/getunwind.2
index 0935497c6..68b9efc36 100644
--- a/man2/getunwind.2
+++ b/man2/getunwind.2
@@ -33,7 +33,8 @@ getunwind \- copy the unwind data to caller's buffer
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
-.BI "long syscall(SYS_getunwind, void " *buf ", size_t " buf_size );
+.BI "[[deprecated]] long syscall(SYS_getunwind, void " *buf \
+", size_t " buf_size );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

