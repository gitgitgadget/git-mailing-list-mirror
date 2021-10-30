Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B9C433F5
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BFA60FC1
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhJ3VfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJ3Veq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E5C061205;
        Sat, 30 Oct 2021 14:32:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so9273816wmz.2;
        Sat, 30 Oct 2021 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dq5aiFru1j8xjxIilDQnaJtay4rsUR4V2oYHaP5oIbQ=;
        b=fIfx5f/gch6EKjC2JuIL+fpDp5de0yXqFVVqeW1Yhf0Jz7EUNRYlZIsk4wRHv+VreM
         OutBG3JlVPsKioy8keAj56Mx0/LMge4cPR2JffoM4ioX9ZF2Nfk4PftBS6Q90wzMyu7u
         uWpFebTGC9a2/O7uMNqN0sr05ygcWTzCoyTRLcyf3YfEYDM/fctjY1iIf0aOjw/FfyAA
         QiMMNmuPXbwCnE+7yaWR7R+0x+QwMUzoCOiR6Bo74Zegb5B0WxmqQde/Go/VMd+DqUnF
         73G574KKQiTU8go7VhLWBrLxp3btdLPoBo7BVu9I+jQ0a2EZfiBfNI/2FxoYqJY/bcih
         laMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dq5aiFru1j8xjxIilDQnaJtay4rsUR4V2oYHaP5oIbQ=;
        b=Ve8OoTHr6+SLHPYq3ltGQRch/HafBfpmviCifEr0R9Z2qntXrElpYrgOgJztL7fTZV
         CkVTJ7bbocE7gaorEjX+SkcKWqs2etbU3wvgPl6dmF9eqtZ7zyVNptIMkOsgdfTPGN+Q
         1V/0aUau8XsO/EXrirXGm3hOKJpjc3AIrXxDheeq8KMmZNlrxaq5yempMKB1mqotlFPo
         EwkRw3v5qlbqxHf+BhPYZrNutNVaz0QKi4VKnBLjS8CR6jzliYDhfoFdXNm4/PAYLHOE
         CTuXRxUP1zPZ2hVB7ImrWs/uS2AbtMobFMwY8eAIgsW5CSY8sfHJZ4J91kwcKma3ecqG
         Mcdw==
X-Gm-Message-State: AOAM531MOY4ZAqBPnihhI489y3vrDMqb1VNYtcjczA3T/scSQVRaUc/Q
        JMlZTL/D6lZeYuM9RFuGW1o=
X-Google-Smtp-Source: ABdhPJzmlPeOtxuxvuJwAPFJ5DcDqBGowe6FzbdCE0bJkoeKNhMFmmZMZOsGv0z4YhnAoj752c/jEA==
X-Received: by 2002:a7b:cb12:: with SMTP id u18mr20978676wmj.109.1635629532447;
        Sat, 30 Oct 2021 14:32:12 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:12 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 18/22] futimesat.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:28 +0200
Message-Id: <20211030213131.140429-19-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use utimensat(2) instead.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/futimesat.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/futimesat.2 b/man2/futimesat.2
index 40d352c56..c1ceb7687 100644
--- a/man2/futimesat.2
+++ b/man2/futimesat.2
@@ -31,8 +31,8 @@ directory file descriptor
 .BR "#include <fcntl.h>" "            /* Definition of " AT_* " constants */"
 .B #include <sys/time.h>
 .PP
-.BI "int futimesat(int " dirfd ", const char *" pathname ,
-.BI "              const struct timeval " times [2]);
+.BI "[[deprecated]] int futimesat(int " dirfd ", const char *" pathname ,
+.BI "                             const struct timeval " times [2]);
 .fi
 .PP
 .RS -4
-- 
2.33.1

