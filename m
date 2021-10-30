Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A67C433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AE60E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhJ3Ve3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3Ve0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0415C061714;
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so6066293wmj.5;
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=peorTGqhDd+FbCixcKr0Q6eTtZHCTSKsiHTZ3zkUsWk=;
        b=VFJMdnVVQNwyZ0HekDUwbyv3IMSa6R+7ZFnIl9IMcxtYQKz4yyA8hB2owz8trrPMAd
         DlYh2PuIJoHdCn5TKJ2OdEABzjUFMv3/LjU3PUI9UVQOpDFYRdDRUGDnGhPOgDy+jwd7
         M63y+w1hibHu6VPS6bUdGwGAH4Pf0rINSSu5e7moWYXOM1FFfnaENoXQXK4aSU2VhLUQ
         1EeINupVpG3okrJht/6UxVAvl6Aqi2yy3Wjy93v/W7BmrTb0u50bzdsTT/XqV2CjNmse
         J0+LaEKH09MtTc/iKoyZV7CV2sIWIvgzSIS18Bcssob+befEtcOy2unaS3mpc/EJS53o
         lzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=peorTGqhDd+FbCixcKr0Q6eTtZHCTSKsiHTZ3zkUsWk=;
        b=CT2IQJzYzZjwYs454cU+WoUy8ZaepgXMr3j0XWyl+1DRNN8TEItnB7wOjjY1KvDUwo
         TzHqskuVZFawsCrOBQCqZuM2UPIOEUJcgTSCU1pM/T8dvJyqNuUJPgpxn04ALxidV5Kf
         mMKgcju9EdgpnIVMa4iTV9PXtE7WOgo9/KwC+2Xa+FFNMf6qR3giS42ff/yCVe/Aide+
         p+Q6sKr38TnMItK58iLs/lP2x+n52l8INyrM9tjBUodkxmSmQ4wf88IC3azLe98DOgvR
         Towkvb9ElbULLaOdmwHvo9h3sRGpNWMR3ahhzvLm4jeSLU5XAKwCoDn8zeEWmKDONe0Z
         DC4A==
X-Gm-Message-State: AOAM533kp7ImAmfoBWjJM/8JLksvQyF1WCPI/1LC2jpMw0HPQ17aHvi5
        FJVr8DrrCmHxSXeyFNHaMWc=
X-Google-Smtp-Source: ABdhPJybMDAwhUGQCe/Gn6rSszx7jKKtDAx3FVFpKWdkgZkqRV3wAvV3DdPFyb5kNY6ptepOLIupTA==
X-Received: by 2002:a7b:c5d4:: with SMTP id n20mr28770505wmk.32.1635629514096;
        Sat, 30 Oct 2021 14:31:54 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:53 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 01/22] bdflush.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:11 +0200
Message-Id: <20211030213131.140429-2-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscal is not supported anymore by glibc, and does nothing.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/bdflush.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/bdflush.2 b/man2/bdflush.2
index 710da7b18..8ad5dfc2b 100644
--- a/man2/bdflush.2
+++ b/man2/bdflush.2
@@ -31,8 +31,8 @@ bdflush \- start, flush, or tune buffer-dirty-flush daemon
 .nf
 .B #include <sys/kdaemon.h>
 .PP
-.BI "int bdflush(int "  func ", long *" address );
-.BI "int bdflush(int "  func ", long " data );
+.BI "[[deprecated]] int bdflush(int "  func ", long *" address );
+.BI "[[deprecated]] int bdflush(int "  func ", long " data );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

