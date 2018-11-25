Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A61D1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeKYV6D (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:58:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42301 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeKYV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:58:02 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4823477pga.9
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eC44/PyCX2oo2iz2hQ3C2csXOQCFjATNUBd153gcNCg=;
        b=Lqo9YU5r1Hj5guZkupB1gGq5LiBBi0kzjUzAfWJGNMo2LvYSRcBMHD5ZX30XzkeVvp
         tWyyP+lT+56hP6nPtmJJFydRfPUMfw0lfR3LpuwdS6rqU7MbocTVKSG+1m6xEAM8QvC/
         EBEY8pH4aP/DdvlPx7nRhLOcawJl7IUj+CwJ6ITRa1fmgxP7Mi++xpGwRudMShqqUI1W
         svfUct2bfElXXmLQzu66yJfNgYMt+sh3O9baWojaGqEKkjpyYpzFV9gUHYXFBbci4rYZ
         GEjCa0T3mJ/v4ZAvrKnqqfUefjD6+J2VNT44/QeJghEdPrrboecLBcaqODwLVFRxsLta
         rmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eC44/PyCX2oo2iz2hQ3C2csXOQCFjATNUBd153gcNCg=;
        b=X3Z1Z+p2mm6sLc2GGwRndMFUZCjrCEixyfgNQtP4KHBSlT1pPCYpkOiJeYRoCuB3ag
         JYnaObVnZmAzoNXUisUJpyoMNrmhusDqC8Ky9ZM59a7iGM44lyV6uL7VvkctEmvFdTMI
         EL2HcY/PtwSEDGnLlRhkZSC9Z9usqWztvRCA2p/1S55Cn66SXUXZzQMDox2Og4dl01fQ
         HvFuUklfu+qWOUp3mVZlXMavXMj88zSLKQakBZ2tfcQvzPlbyjS5rB9SS+xx03kItHNw
         LOnQzvMKFsn/vjxYTSE4meqqxX0i+ThN1U5TRIvsIhMBBbEFCylazx7sCK/EHAnb8yLa
         aZ6g==
X-Gm-Message-State: AA+aEWaZHuEJA/jxSL56lZk1OIM/19LhLD6Yd2HN3SJH6hhNf0t6Fs26
        8d6EYwXhrXv478LvKgefhWSn/7Oy
X-Google-Smtp-Source: AFSGD/VmKg1w3oiEnAEwgAMVPI7KTgYGLjwEfrhk17KI4MMTtmGrkbXtoLEpFTTELk8GZPUUjwgeRQ==
X-Received: by 2002:a62:33c1:: with SMTP id z184mr17885203pfz.104.1543144031980;
        Sun, 25 Nov 2018 03:07:11 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.11
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:11 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 7/7] config.mak.uname: use pkgsrc perl for NetBSD
Date:   Sun, 25 Nov 2018 03:06:50 -0800
Message-Id: <f7a41204f9c70e3c659877412719f17dc9805589.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

otherwise will default to /usr/bin/perl which wouldn't normally exist

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 59ce03819b..d2edb723f4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -249,6 +249,7 @@ ifeq ($(uname_S),NetBSD)
 	OLD_ICONV = UnfortunatelyYes
 	BASIC_CFLAGS += -I/usr/pkg/include
 	BASIC_LDFLAGS += -L/usr/pkg/lib $(CC_LD_DYNPATH)/usr/pkg/lib
+	PERL_PATH = /usr/pkg/bin/perl
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
-- 
2.20.0.rc1

