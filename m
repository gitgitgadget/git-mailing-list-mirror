Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7703C43217
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE26A60E09
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhJ3Vea (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhJ3Ve1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9584DC061570;
        Sat, 30 Oct 2021 14:31:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o14so22124489wra.12;
        Sat, 30 Oct 2021 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYMnUzbF2ZBNxqQ2X8HTFJrqgjL+Su+63HsWO8FWcfU=;
        b=VIVOgwifu6i/7ImAgOVYe26z9czHOqNIb7pK4BmGSJrEcMCBQvFIPd09GExpWx/vqt
         SiL+AB69gYR+ZcOA420G//R5DuN8R9k+MdMkQNGFioIULkVc6sjAfl48Seq6TSsJGWdJ
         J1KJJ1I2UNklwAMtNRtj7k2MYHTHuwUz/BgimEu6vVfWuo4mxGfsBjC496Ve/j5/+6Zy
         yxnR420Xj1FEH2Ewkh8PeyUEuleAetEv4eb94TcSK1GngThA/9McYgzKj12GOAz77TsJ
         2WvR63MNlvveYkT0u7AvO2JF6bPFWPGNFM4ui5Y3X3uq22RBQkVli25ldmkEXkzwVZq5
         Zkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYMnUzbF2ZBNxqQ2X8HTFJrqgjL+Su+63HsWO8FWcfU=;
        b=2h9QqfOMfJ5X6hqAKr6hnUtaYwM1NIjJc11EWontC3pfpktYKiiv1vQqRWVJ/jN5Gm
         GepvUThH7dgVqMULGBBByt7nXBxbSOSDumTXaqOnghDeIB+GAkZO56+iB8ou2/7YRbIM
         zf1khOYLS35oArIH1Q2d9FGMJZNg69mEiUajvRkxrWWi6cFb6L6RL29IzQdD6U4Tgyvd
         Ei+XBSEDrTyPq4DqlK0ZHjQFW1Xqvxe4PJFlfumtiO6LRNLSdZ186ezbS1WBH52YQ+Ep
         gcKNnqXYVgV7aVbYD2d6n0TL0pEXFOq/N9i1iCrAW8DdTlzFd0K7jqCFgRhLHz/fEFLP
         AlbA==
X-Gm-Message-State: AOAM533S+SLzHR8l6AxXpfWdf0CnAai6kxElNC/KhkKekaloUtYFw/2O
        IPm4ri0nsAyVu2i7VK1Q/q8=
X-Google-Smtp-Source: ABdhPJzmYr5vNHRSjeey8Bmm2ZcK/CLUaTx0acrZoKea/2YuQzQvAsOijeG2MrEdtI0Cig5B4EjzYQ==
X-Received: by 2002:a05:6000:154b:: with SMTP id 11mr24802207wry.422.1635629515233;
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:31:55 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 02/22] create_module.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:12 +0200
Message-Id: <20211030213131.140429-3-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscall was removed in Linux 2.6.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/create_module.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/create_module.2 b/man2/create_module.2
index 81136fe06..a4b0fa603 100644
--- a/man2/create_module.2
+++ b/man2/create_module.2
@@ -14,7 +14,7 @@ create_module \- create a loadable module entry
 .nf
 .B #include <linux/module.h>
 .PP
-.BI "caddr_t create_module(const char *" name ", size_t " size );
+.BI "[[deprecated]] caddr_t create_module(const char *" name ", size_t " size );
 .fi
 .PP
 .IR Note :
-- 
2.33.1

