Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B3CC433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7135660E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhJ3Veu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhJ3Vej (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EB7C061714;
        Sat, 30 Oct 2021 14:32:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so22178556wrv.9;
        Sat, 30 Oct 2021 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QA9ZJiR049DZpp+DDkn5uUUrCmEh1LL+eBEyfvOQ8d4=;
        b=kXtZSqOwtWOWnx+sCg4qoG1Pnw+tpC4qvlrFLa7x2+zbb6pUUb5Yb5lCAIzOBQbAKX
         2O2lb8mNgyN9kM24ijherqyG0Yx406cTjB81Lo4+hAXwYdK3rIAV9Dw6cZqhWiM1PSJd
         hHjOo9P1lwbZb0PAupN6hYfzuV0dkx/oC9AEKXFkTfJSwXF9j77kKF9uC6hiP0heyEJZ
         osQAICfQpXIneCtuHe07x/bFryIsSC89KM2d9sIRbXNXm1UUa3RyZJW7483clv+e2Vr1
         nUZLQVzFyCiXKKma5zIdNpy+sOWb5WDRI+9LecwEZ/ty3uXZPKKlq1WwDDnGa7wna1gz
         52LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QA9ZJiR049DZpp+DDkn5uUUrCmEh1LL+eBEyfvOQ8d4=;
        b=MQ+DXSzC23VkBPcAzHHAiP4YAVGA2dBERNrMj7NsWUzGY95iXJX0SuBQ1ePFmP1gEW
         vU5X3OlpLJoT/7B4t41Z9krqoWtQVDgU+v3a5QMRf1UqZ87thAPJIl9A/n/Yi+rbsDq/
         J7iW9PnKvPNjtjG+WaNALrrU7UInIWNLLRsfq4IDMFLAVgMV0f6enKulm3jD6UAPDjqr
         fPWxvOQgyTy8ccBSZ/7SVMr1E804kxcybW49zpUwip+LjXg+1aic8H59WhiwhyOBH9AL
         U+5mrznVLXc2lGtViZJ73XgPio6Ye2QEOMHpk0JmEos7ehnA6ed3UrFqHrbY2YJjBs6Z
         sJxw==
X-Gm-Message-State: AOAM532It+RHaiSW6+D/TR7C/AiPbnFftvUpgIvMCQYj4FthbLsbLa8f
        nJI7cmofQUOqVEDXzd0dmFI=
X-Google-Smtp-Source: ABdhPJxuac5AjZtj96wFI5eY2Ia3NMLApA+3kPCJ1z+SMg6vh8AGNGAnzTd+rrpFMSyT24Pda2qzGA==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr23951220wrw.25.1635629527181;
        Sat, 30 Oct 2021 14:32:07 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:06 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 13/22] sysctl.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:23 +0200
Message-Id: <20211030213131.140429-14-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscall no longer exists!

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/sysctl.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/sysctl.2 b/man2/sysctl.2
index 2188389dc..46b189243 100644
--- a/man2/sysctl.2
+++ b/man2/sysctl.2
@@ -35,7 +35,7 @@ sysctl \- read/write system parameters
 .B #include <unistd.h>
 .B #include <linux/sysctl.h>
 .PP
-.BI "int _sysctl(struct __sysctl_args *" args );
+.BI "[[deprecated]] int _sysctl(struct __sysctl_args *" args );
 .fi
 .SH DESCRIPTION
 .B This system call no longer exists on current kernels!
-- 
2.33.1

