Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3AC433FE
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CC960E09
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhJ3Vew (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhJ3Vek (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4ECC061570;
        Sat, 30 Oct 2021 14:32:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v17so22178579wrv.9;
        Sat, 30 Oct 2021 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3X8N7uYv7lkrEmRWAm9GGjT0uIsYL/tOkxoLoX3P/uE=;
        b=Tc9yI0VqM8eRu1JYFJDmWP7Cleh50veczeCvfKV5GdzU5RlnVzi3rchvEJLZ139gkc
         028GOjaAS+4WH5jynL335rmUa8sYtoVvN3jZhXo6SMW0eSmCUKos09qgi8v5Tx2LCI3j
         kda9v1wHAjwda3d4l0oK5Pqh6gXfRLhB1FDSGIc0CeVs0+goPfVVqdL8TKOdY198VFhL
         OlwW8NfTt9W7tX0fSvIxz7Y0PfPhcDTu6iorLQjb0VaVdmafixR2CZVnn6ouUHzRcCRN
         z7qsDAIhRUUEVza82nAF3VrX32cov/e3RPIQvbIhjYifVR4y9MZar8ofkuuflIjj2Hud
         Ut0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3X8N7uYv7lkrEmRWAm9GGjT0uIsYL/tOkxoLoX3P/uE=;
        b=Z9jih5CpLjoens9g9c40vAsrVGMSL3bxilXLPWTpssEnD6+q0qTCR+SsXAaNHSe9i0
         /voH/g6/pafixet515H3wuyjdNZjZ72DJcWZBZb//bVy1gSdwAtUru/CIdDJWsBoA+Xx
         nT6BxThd6sYzErRMd8HJ6hUnTG7OTkO5u5QKzpOE6ra5YxsMrkoxJNzTdVBLAvvuVief
         QY/NFT5BeOw4Q2d9shlqo+i1XDIJjV/nttwDpSAXlD5kjgroE2Kbp8CiXwgiRFU+wwtJ
         5xXDiTBNgWDHLsDxgz/Xr3lCOfwp0mVgcyxkbJqjYOrxpa62Y8c8GSRz3mU1Ajy4XQIX
         hlig==
X-Gm-Message-State: AOAM5320siJSmS76aYMXtU9E28t06IVE11bIvCK2cv5Lpua+dOSSX4iM
        isDCTPUO3H5lldCktD/QFO8=
X-Google-Smtp-Source: ABdhPJyYs1ex2SIKnYa01bwy2MW9QaqEt7C+N2eqohibA5kWJRgHAiEFgvPUOh0qR50o4go2lcLoOA==
X-Received: by 2002:a05:6000:2c9:: with SMTP id o9mr25592958wry.92.1635629528276;
        Sat, 30 Oct 2021 14:32:08 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:08 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 14/22] vfork.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:24 +0200
Message-Id: <20211030213131.140429-15-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4.2BSD this syscall was called to be eliminated.
POSIX removed it.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/vfork.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/vfork.2 b/man2/vfork.2
index cd59a374f..655781c1d 100644
--- a/man2/vfork.2
+++ b/man2/vfork.2
@@ -33,7 +33,7 @@ vfork \- create a child process and block parent
 .nf
 .B #include <unistd.h>
 .PP
-.B pid_t vfork(void);
+.B [[deprecated]] pid_t vfork(void);
 .fi
 .PP
 .RS -4
-- 
2.33.1

