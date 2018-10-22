Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1F21F454
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeJWEng (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40626 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbeJWEnf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so39231431edd.7
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yor/xvYCFqsusn7AH2IBYEgikd2httNufrUhiNDaZfY=;
        b=bVrRmUqJE0PomMNxL6fGKeqtvHwjekcy/6cEf+n0uIw99JnXxpdqfIigDI+vjUSZio
         tyTKS9gWLtWdrPEiX2VTGGd/CtNYGpKjlw8Q4fzNphOpKvk2QjuslZFOTqj0Z0Lpl6Hr
         JAMtroKoEk+ffNHfMKWbT8EPAt3sO/JtY26ab8QV74ruC/8HLF/djsTzp00/Fj2eMFX7
         vlZwBHfNXM4U4ad9jZyiVzDKvsXIxhs9ET1LoCyFuhsil8dxv8kx/7L0uVYBKf2uJOVn
         JhX8Uzr2jVIi0wKr9bk23OSsjKUi+SKjyOu3ME4rfMajtHZcoRSSdMIAqVH8+d0Dm/K6
         DpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yor/xvYCFqsusn7AH2IBYEgikd2httNufrUhiNDaZfY=;
        b=HhGAJ3qPxThsYQrIDMYt8O7eIEJAqX/dtVQ4eWTxDRzhbsHpEvNZ9ALs4JTpKNNvuT
         iKSEpzgkkk+5MZPRdyD/S38U260YcJ/AaMiBA0MbuCLkUqfKs6gnPKJqP3otgdMEIwGW
         CIOBi/Y3Ql9kvaaf+HPUjB5oypBOvLDeL38qY2Vd3WKNhsAlwQ6pAIwL8W602CxIVQjq
         jZVSwh6pZE1ATWAdVa24hWMOztoofwH8oYQe22IgNC4RFfAUOSPJA2IREEdBxPM/dOsq
         kDUQTuDfIfsXEI8n7sHK4oZT0gsACsbpUVzVFTG3hX06mWVRjMdU6HBdddC9ugDC8Pe3
         +pxQ==
X-Gm-Message-State: ABuFfog43IY5YHT9UYh7lvFwo1J7eIkiDEtjQ+ozfCZMoni4ZTIKjdP7
        SITR72/VYQu5Kphiyh0dN04iy/Ay
X-Google-Smtp-Source: ACcGV63Nazn/q+BXkNBHiR5jvBRcA9jMREzx820YJ+8aC329sV9T5rIovDYapBNT+9uXwO1QJkFj9Q==
X-Received: by 2002:aa7:d889:: with SMTP id u9-v6mr13419646edq.29.1540239814183;
        Mon, 22 Oct 2018 13:23:34 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:33 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 5/8] gettext: put "# GETTEXT POISON #" string literal into a macro
Date:   Mon, 22 Oct 2018 22:22:38 +0200
Message-Id: <20181022202241.18629-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "# GETTEXT POISON #" string literal is currently used in two
functions in 'gettext.h'.  A later patch will add a function to
'gettext.c' using this string literal as well.

Avoid this duplication and put that string literal into a macro which
is only available in GETTEXT POISON builds.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 gettext.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gettext.h b/gettext.h
index c658942f7d..8e279622f6 100644
--- a/gettext.h
+++ b/gettext.h
@@ -43,6 +43,8 @@ static inline int gettext_width(const char *s)
 
 #ifdef GETTEXT_POISON
 extern int use_gettext_poison(void);
+
+#define GETTEXT_POISON_MAGIC "# GETTEXT POISON #"
 #endif
 
 static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
@@ -51,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
 		return "";
 #ifdef GETTEXT_POISON
 	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
+		return GETTEXT_POISON_MAGIC;
 #endif
 	return gettext(msgid);
 }
@@ -61,7 +63,7 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 {
 #ifdef GETTEXT_POISON
 	if (use_gettext_poison())
-		return "# GETTEXT POISON #";
+		return GETTEXT_POISON_MAGIC;
 #endif
 	return ngettext(msgid, plu, n);
 }
-- 
2.19.1.681.g6bd79da3f5

