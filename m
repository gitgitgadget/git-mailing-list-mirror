Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1074CC43217
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9F260E8B
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhJ3Ver (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhJ3Veg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BEFC061714;
        Sat, 30 Oct 2021 14:32:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r8so9409285wra.7;
        Sat, 30 Oct 2021 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2OWif9ZBdV0J5vEXEOznTzTaenIuinqzzNALe3bBP0=;
        b=D+9pX1qu+VjmAQ+Pym6FSyWIBWDofzkQ/tj4VJfvCvoJFNuwQQ+RLJLfGmAcduVtJy
         LpaDgQWxrvMJQHemoWdHPG8tPRZf0DDt2AZt7PkAjdqckVtFoOL7L6I1Y1qJy8PgAlce
         GPYUuUJaTMRTcrO4T6WxIuAFM8NqqN7XtJGbtzswCP1/Q+xwt3v3YsjyjVl2mHjpAWKs
         ZQ27fK9f83srhu44H7kO/X7N2kojLi8zEGgAQX+3f/yY2GgJ+XufsKnSP5pezSL/pZ3u
         K1Yp6IfBtBgpp9bIfUw6F3P9DE/gH2KtXCzjKVV9A8JulggmA3x8peJ7a49oJ36sJ051
         tMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2OWif9ZBdV0J5vEXEOznTzTaenIuinqzzNALe3bBP0=;
        b=sY+uP9XlIifp5dyU0POMAasBkcHj3jpXo0Eex46n59VpJBl7GK01pR1ehodHpW9M6p
         6TKcaXM2YpXbn9mrnhulK3d/EbmCsXCz44S7TSsBQSTPqTciGi/j+ngHbiiFGNt8berQ
         TlfCPe59oMmRrVH8/gJltrniLwva78Oa0d4TVJ9XosAkk53P1AdE+1Il1v4foKSzprFL
         3R5iUonyd5gf1tpaM4LrrnpEBA9QENAIMmAUUThzJEcQnrP2NTRr/qALmLBuntLZSXK5
         j15e9uK+2BhWHDE5OsQGfwgXpxKBgjgzDolqHFVhLEhStfBfUxeSAV4KKPbojOdqAEft
         cBQw==
X-Gm-Message-State: AOAM532k9JjJqOXIipychg+fziMdHsrBmmW9Xafi/r6WJBsOx7l6JeVd
        /4Oo/1feMblcmuzm1tLOcXeg6wwV+Xw=
X-Google-Smtp-Source: ABdhPJzZxQJIIboyHKN7rp1cvPXVhGtj5cvOW6BlwdiYL+FvOi9LklcO61NRgCauZXTQqy1ZUnQwlg==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr3396358wrn.423.1635629524116;
        Sat, 30 Oct 2021 14:32:04 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:03 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 10/22] stime.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:20 +0200
Message-Id: <20211030213131.140429-11-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This syscall was removed from glibc 2.31 for newly linked
programs.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/stime.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/stime.2 b/man2/stime.2
index 4aaa6c775..5d40495d0 100644
--- a/man2/stime.2
+++ b/man2/stime.2
@@ -34,7 +34,7 @@ stime \- set time
 .nf
 .B #include <time.h>
 .PP
-.BI "int stime(const time_t *" t );
+.BI "[[deprecated]] int stime(const time_t *" t );
 .fi
 .PP
 .RS -4
-- 
2.33.1

