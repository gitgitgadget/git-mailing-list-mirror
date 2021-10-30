Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A50C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7560E8C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbhJ3VfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhJ3Vem (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A4C061766;
        Sat, 30 Oct 2021 14:32:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g13so2428165wmg.2;
        Sat, 30 Oct 2021 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CftjFeIb9ryCOjZwQ+pnl19SuRn50Z4Eq7p/Os8Pkg8=;
        b=eIINrlooyQE3Q4epd7qFWEkP9CbPTBsclQTj2uMrbOyiffBpUPa4huvUfOzMrH7gPO
         lTyTtwF0mYdDwjinpBx8ONoGk4H7mQdpcY29q4qidv0ycAxxDN9s7xAweoqwIs7xTXRO
         +2OlcCJonDPS5h1NLrTQBIeO4YIPqEzAgh8eTRO4AFdfJgixOMVXlfrKt+YJkytiw8QO
         AeRmrpFkCHjQJ6drJDL4gGVnNJhRMcJleNjjvGhp8nYidWbKxZ3YuyIRJGxIiKhRY8rN
         33lYa4wGisbt/WXr5PvyU6Zijt+AveICCoO4t2JKmVCva9b5hzZI9p4gwFZ3+1dLVQMO
         +M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CftjFeIb9ryCOjZwQ+pnl19SuRn50Z4Eq7p/Os8Pkg8=;
        b=w+67Gtxl8qmqD0OokGTnCcEAQy0kHkKXsxQRkTfE93eFvG2RUBzED6GYKRIxQjoEbB
         fm1WXomaWfJJ5yBwAhnLXWe4zpdv8aDYs8dtiY0NgA7vsJr6suOlbxtj0a4/hQVrdGHx
         oSG+Vrysb8NlAkNPcOygutr+TqnP8ksocEqhqasGFvdN+2xvtFn66FLidKsZ8SW/37cu
         s9hTyyy5kuOcQ8jlEuu6FdvTLdLUEFwxJx1hdj3mnuNKvIY/5JNtiyM2afw4wo7wtxr8
         qEr4L3bAhZitMtdR/Z3oyaX7zh97sP84znsjDQqVvDgEhuPj70RajDhq5JOkP2rRLu3b
         Z5KA==
X-Gm-Message-State: AOAM531N18QDmElLRHZ1TLGYkbp4i86Oc8SeCYgAoAgdY7lp9NAaq/2I
        Jn6pkt9wAHcb8vku68S/5zc=
X-Google-Smtp-Source: ABdhPJyL3rBnyp3uknTsXRG4d2bjrysL+b0VDWIugWweUrmvPnuC2Mlkva6Q86vJGqj/XhivSIFCRg==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr20120581wmc.24.1635629530369;
        Sat, 30 Oct 2021 14:32:10 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:10 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 16/22] sgetmask.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:26 +0200
Message-Id: <20211030213131.140429-17-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use sigprocmask(2) instead.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/sgetmask.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/sgetmask.2 b/man2/sgetmask.2
index 59b58ceaf..37452ec05 100644
--- a/man2/sgetmask.2
+++ b/man2/sgetmask.2
@@ -30,8 +30,8 @@ sgetmask, ssetmask \- manipulation of signal mask (obsolete)
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
-.B "long syscall(SYS_sgetmask, void);"
-.BI "long syscall(SYS_ssetmask, long " newmask );
+.B [[deprecated]] long syscall(SYS_sgetmask, void);
+.BI "[[deprecated]] long syscall(SYS_ssetmask, long " newmask );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

