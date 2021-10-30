Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A3C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274D160E8C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhJ3VfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJ3Vey (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25F6C06122B;
        Sat, 30 Oct 2021 14:32:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so9273863wmz.2;
        Sat, 30 Oct 2021 14:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bHhK0ZD61B9ZJ57BR0XAE37YZfQpUb2fDNd7FOBcgDg=;
        b=ElmAba4vI1Y9zHJBu5or9aMazqitFFeG/MMzA6vZ61FnLhe9h0N7s02ga4MNDbQZOr
         HgDFbwl6R5jPF8GkjF3zURLpKze1zqessZjh0hNYzChezsS+4XTyB015xSY8pMQbmFUq
         vH6mr0iqWZ/wrmdE1TTPAamokWjNGqybNyExqOI0Aj8t20fb4kHYQMl30zS6fPH2pN5e
         jEY+lTwed+Oa0V3I4aYDGMfq1Rra2aOoNDMEDcmaudgeCrOLgMRFn2Qo9xJcyXWa6WHa
         yCmS2Q08JZwIobnS3J+VENQ23DR41SY+Va76/sR70KFz3te+cfrOTgFsD7sT7ujlQU4g
         wNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bHhK0ZD61B9ZJ57BR0XAE37YZfQpUb2fDNd7FOBcgDg=;
        b=vGuYiYNLe85Gw1zMObzZGBFRHkRqggjAOuv6zJOfPYIOjzCwz7lbkIXjoGkddb7y/S
         pFl97SnicUh2hze6uDfgfGBmAsXsKPa8oS99QOjYbwDGD/1OKpPkZeZRVCdjVJJnTZ/Y
         RqKDS+0vlRTlgJYWUTY5hHUjZFnvJajsD+ARp8IV/SKSi1JV0Cw1nL+pp2MpLLB7Ckis
         KfSeIVnpxZeroRK+5nCNFnEmzCzbVmMqNgu/yfcD7MTS1qALcHakS+l5ncvqM1pqE50w
         0gqpy3U2uxP9p+syrxTeQsTsv9d2WRlrbeODp5PgKbbvKF/z3I5T5EK8GCE2c36WkTNN
         T+Mg==
X-Gm-Message-State: AOAM533WviaMiHXRGXZbqP+zhPGnnOPMdVnwKV6RRF5kN5AcX9+glPIe
        9ktFzXJNkKtOvd7GpKa/60I=
X-Google-Smtp-Source: ABdhPJzIXYy9HIlkbtZDdD/5DgzaY/OoMghF2QiqDRrQwN3fIhHjQdHyTpweN9yJDZeAbqjykStpGA==
X-Received: by 2002:a1c:2386:: with SMTP id j128mr18506781wmj.8.1635629536530;
        Sat, 30 Oct 2021 14:32:16 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:16 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 22/22] uselib.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:32 +0200
Message-Id: <20211030213131.140429-23-alx.manpages@gmail.com>
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
 man2/uselib.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/uselib.2 b/man2/uselib.2
index f6feca9f0..32417c9d2 100644
--- a/man2/uselib.2
+++ b/man2/uselib.2
@@ -35,7 +35,7 @@ uselib \- load shared library
 .nf
 .B #include <unistd.h>
 .PP
-.BI "int uselib(const char *" library );
+.BI "[[deprecated]] int uselib(const char *" library );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

