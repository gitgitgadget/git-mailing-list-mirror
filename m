Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE62C433EF
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3590460F57
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhJ3Vey (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbhJ3Vel (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692EC061570;
        Sat, 30 Oct 2021 14:32:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d27so4236889wrb.6;
        Sat, 30 Oct 2021 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYdaFtsEIeuyG23vYPK+bPNi7FjwJK0AP2aMJiyBvqs=;
        b=NxE8Dinjfx6rqH3dadEw3hlGBA4hWkJrp0o6KO2xBpe2eggW/Q2eZd3uK5cXJsyiTj
         7DIzUxCXvrBK+g/9tM3eAalmFpldG/GxeZiPyIFavOF1kptjOzZROwwkRk82fWsrsY4M
         cdG7zgErTIn9xiN2VbIxx93juVTdLMAiAh1E/OiC3VYKVnJD2U3gvTAXc8PNnjWDtZNJ
         s2ndup2Iv9XyLC5tMc1/VzPByJV7miK1WtdtqHLoVLB19a/duF5ou+H6pgb3hJJ+sFsY
         OM7dZkN9fm//xOyLulpBTrXDpfy+0o6JlJjD3+zngLRI0yQiiAhwXTsrUMHezYa57TJq
         ZJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYdaFtsEIeuyG23vYPK+bPNi7FjwJK0AP2aMJiyBvqs=;
        b=nYGG4ntaV0u3NLNy0e8BFOPLesAbo2N67kjZvpB5SC6MVr8hrT1D3Kfy8AKSzq2Plb
         P1WetrYtjZEsN20ChPVO4xNt8/XjDec0LcNaWbgmZaAPVuyLJpkKslJSKP39pJ0jqP9J
         qFmkavXnKKiOtCL8h643LBzofYk8LZu1LYAVwrHIbdfK/qxfJeYV+Y0drlBS1ul1zsxe
         cjjFlg/EpTqf5pP9zAjU6KfDRmGcxEAgR3OfOE6MP/3l4kVBcqYIq0XEgoJLuKYNtWKH
         UpL/lw68YLAXsHuUAkPLUSyaAId9JXWEYrNqbuE2qSONi+hIVRqnZvebI8wHIuDgcwm4
         OgPQ==
X-Gm-Message-State: AOAM532pg50WKyvTWyrloF6vE62sB+j2yB426jifJfX6kXUnivFo2LXg
        JRfcQmzL8+iepAuYUOpRdik=
X-Google-Smtp-Source: ABdhPJzBQjW5H9jJXli9aE6+0JllUQGhLVjSRH5K2r6EgOb4Fmfr4jDcI4wJWvU03Uatq5ojIjMKsw==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr24687410wrs.262.1635629529326;
        Sat, 30 Oct 2021 14:32:09 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:09 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 15/22] tkill.2: SYNOPSIS: Mark tkill() as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:25 +0200
Message-Id: <20211030213131.140429-16-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tkill(2) has been superseeded by tgkill(2).

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/tkill.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/tkill.2 b/man2/tkill.2
index 6e1afcd36..8a6c45380 100644
--- a/man2/tkill.2
+++ b/man2/tkill.2
@@ -35,7 +35,7 @@ tkill, tgkill \- send a signal to a thread
 .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
 .B #include <unistd.h>
 .PP
-.BI "int syscall(SYS_tkill, pid_t " tid ", int " sig );
+.BI "[[deprecated]] int syscall(SYS_tkill, pid_t " tid ", int " sig );
 .PP
 .B #include <signal.h>
 .PP
-- 
2.33.1

