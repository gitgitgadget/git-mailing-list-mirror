Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922AD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfF0IoZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 04:44:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45004 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0IoY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 04:44:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so6234824edr.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 01:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wMrDrAwg3L8uOeclgj+vIFprliVJ11sKLIoxQdvAqI=;
        b=CNz9bWz86OBY0RPsq+zQD5NuWDdbQ2sfsbj4t5g7wejtcb4K8uGf9tYHDexwAFi8cF
         ttkhijHhhF5/9SJqXACTfWaCYugs2eAL1O2h9zLtrbEAFVlBzMFWAU1toEyi27/c+4nx
         Zpov98PM19qxbu+sVGcmF4e6QPCHJoRJYX5ZHn1qpApZc6EzMg4SxgjzJoXcj5+pFjzV
         PzBJowGVh1rp8bBYlfcy8G1h+SBaq+Xo64k/l4wo0I5GzdCPBn3+gTdxxH5lh4V9a9DH
         h0/KEn7ATimyPJnDodjLyZxHTc10SGTPaxhyRw1IpRQvmXLkNrQLiatZUXPXbY6BduD1
         Q8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wMrDrAwg3L8uOeclgj+vIFprliVJ11sKLIoxQdvAqI=;
        b=POS42mUUi1VQ8KzssO49wfyoB7k3kk4c17gvp8g3iXxpo7hbyr2imL26emMywEKSUM
         GqQ4Me1l4+6PryAxedHdIkcgc18kGq2vPM0dobyShttaTaO+yTytd+dRT712Dglewxlq
         IqQ6YcEF3rl2kNohpmPbTI2IWrhnXCmTHBiM2DKtkDt/QIIlMpswIUJZqeeX5o79BLYp
         GZrXEu5Wrq9PJaeHwNAx9rZ05IivHqPIfYgzmIvJmnNIshDnp6ggFxRJ71VnHTsPTaVh
         wEE/j7jFW8sJ1QjkK9Jg2+cDI0f6tfOoPyFTSCgZSmSHWpTwo+Cazmu8JAU/MbjztR61
         hW/g==
X-Gm-Message-State: APjAAAVvVzPriflfE0GAGOJza4M+fPLingN2gZ0zRHpA4l5gdyXGZI6S
        U8yKww5TGq0sPvrmEQc6araUFua/
X-Google-Smtp-Source: APXvYqzLDrTG8wzdUOG8oA6SyRs7aA+JJZIBB9l5NBruNr8RghuQpoRwd6z4DYOEXdjM/9GP7cVwEA==
X-Received: by 2002:a50:9422:: with SMTP id p31mr2610622eda.127.1561625062704;
        Thu, 27 Jun 2019 01:44:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f36sm519083ede.47.2019.06.27.01.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:44:22 -0700 (PDT)
Date:   Thu, 27 Jun 2019 01:44:22 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 08:44:20 GMT
Message-Id: <ff37a2646a848e3eca8d02a001844986a3fa366b.1561625060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.217.git.gitgitgadget@gmail.com>
References: <pull.217.git.gitgitgadget@gmail.com>
From:   "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] gettext: always use UTF-8 on native Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Karsten Blees <blees@dcon.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karsten Blees <blees@dcon.de>

Git on native Windows exclusively uses UTF-8 for console output (both with
MinTTY and native Console windows). Gettext uses setlocale() to determine
the output encoding for translated text, however, MSVCRT's setlocale()
doesn't support UTF-8. As a result, translated text is encoded in system
encoding (GetAPC()), and non-ASCII chars are mangled in console output.

Use gettext's bind_textdomain_codeset() to force the encoding to UTF-8 on
native Windows.

In this developers' setup, HAVE_LIBCHARSET_H is apparently defined, but
we *really* want to override the locale_charset() here.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gettext.c b/gettext.c
index d4021d690c..d8423e5c41 100644
--- a/gettext.c
+++ b/gettext.c
@@ -12,7 +12,9 @@
 #ifndef NO_GETTEXT
 #	include <locale.h>
 #	include <libintl.h>
-#	ifdef HAVE_LIBCHARSET_H
+#	ifdef GIT_WINDOWS_NATIVE
+#		define locale_charset() "UTF-8"
+#	elif defined HAVE_LIBCHARSET_H
 #		include <libcharset.h>
 #	else
 #		include <langinfo.h>
-- 
gitgitgadget
