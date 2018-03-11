Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E4C1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeCKN0c (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:26:32 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:56067 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932138AbeCKN03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:26:29 -0400
Received: by mail-wm0-f53.google.com with SMTP id q83so11604746wme.5
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhTy86cvthAVtOUvE0QPKSyc1SQvavITW/nTh2jd7r8=;
        b=D1FBqNU6PLef/dtoJPb8D4KwBTkx+XQLacI/qlv8+yiQkvkji8axQIGW7WM3Ag5SgU
         qzMn3FruKED+LNAnVelVXlR19uURG+sbDJNok16kV7zDqes9jM58/1pmdduEoDv0uuGJ
         ognwDvhbYIQjm1cv0lgnaEGDd/mtEhAfaZZCQrq7FUa7CLn+WHs2DhMc+Jz9klI4N76B
         Ti+3ruWg7DVF3q1oqvIDT4REoAh3k58BQ6vCz7gMWwN9Xag/Gf6qRymNyoDiuOIJwEUF
         2RtV1OKqxKrWK9Tso70WWX4/1jOMNx+FVYE/PXeRp9g/LEO4RtxMi0N3Uxm8c87aAtOH
         MHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhTy86cvthAVtOUvE0QPKSyc1SQvavITW/nTh2jd7r8=;
        b=uBbofNoiStiYhtfluDS8Vp8b45jXOAzNf5N1WatNAN/GNLt+8hNbBSBfnK6XvnJ58j
         rXa6cd87DFXOb/5rHZdldMm5KKvuona0fomLP1xN6rze730u4GB37TR5+J87gWIJkige
         Ukwlm/lYbC8PPcGr8PET1MYqVyzpxnO9jO9ynh7Te/ddtaC/N0qJ7eGRt+zz/Dacw8he
         xEtBlK+/LwnJuDp1JhCqIdQBFTyITeVAcQ7WJaH7G2rutX4f/LJhbgihSwH5PVVPC1yB
         1oK0kMtzeTqnKoQXOOS+NXBJLwpQ2gpszTXgYv9Ae6V+Fu+9feGTafTXAbx6FKtx0yi8
         xJcQ==
X-Gm-Message-State: AElRT7H4XZyEhQjqX3cnXbE+Ol6I24553Glj9cI4hnN4o8hYa3I+oduR
        wmEfspdTP6QFNI+mv6zOLRqqnyKM
X-Google-Smtp-Source: AG47ELsjRVqKX0ViiygTOQeOsGY7c60SejMrJ3vNqbXrkGzg9mm1tYH0T+emhLv04jxrDhSGT0gJtg==
X-Received: by 10.28.19.206 with SMTP id 197mr3438491wmt.89.1520774787211;
        Sun, 11 Mar 2018 06:26:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d23sm3868563wma.20.2018.03.11.06.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Mar 2018 06:26:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] Makefile: make USE_LIBPCRE=YesPlease mean v2, not v1
Date:   Sun, 11 Mar 2018 13:26:09 +0000
Message-Id: <20180311132609.32154-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180311132609.32154-1-avarab@gmail.com>
References: <20180311132609.32154-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the USE_LIBPCRE flag from being an alias for USE_LIBPCRE1 to
being an alias for USE_LIBPCRE2.

When support for v2 was added in my 94da9193a6 ("grep: add support for
PCRE v2", 2017-06-01) the existing USE_LIBPCRE flag was left as
meaning v1, with a note that this would likely change in a future
release. That optional support for v2 first made it into Git version
2.14.0.

The PCRE v2 support has been shown to be stable, and the upstream PCRE
project is highly encouraging downstream users to move to v2, so it
makes sense to give packagers of Git who haven't heard the news about
PCRE v2 a further nudge to move to v2.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 26 +++++++++++++-------------
 configure.ac | 26 +++++++++++++-------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index de4b8f0c02..449ff71f45 100644
--- a/Makefile
+++ b/Makefile
@@ -29,10 +29,10 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
-# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
-# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
-# default in future releases.
+# USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
+# instead if you'd like to use the legacy version 1 of the PCRE
+# library. Support for version 1 will likely be removed in some future
+# release of Git, as upstream has all but abandoned it.
 #
 # When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
 # library is compiled without --enable-jit. We will auto-detect
@@ -1164,13 +1164,18 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
-USE_LIBPCRE1 ?= $(USE_LIBPCRE)
+USE_LIBPCRE2 ?= $(USE_LIBPCRE)
 
-ifneq (,$(USE_LIBPCRE1))
-	ifdef USE_LIBPCRE2
-$(error Only set USE_LIBPCRE1 (or its alias USE_LIBPCRE) or USE_LIBPCRE2, not both!)
+ifneq (,$(USE_LIBPCRE2))
+	ifdef USE_LIBPCRE1
+$(error Only set USE_LIBPCRE2 (or its alias USE_LIBPCRE) or USE_LIBPCRE1, not both!)
 	endif
 
+	BASIC_CFLAGS += -DUSE_LIBPCRE2
+	EXTLIBS += -lpcre2-8
+endif
+
+ifdef USE_LIBPCRE1
 	BASIC_CFLAGS += -DUSE_LIBPCRE1
 	EXTLIBS += -lpcre
 
@@ -1179,11 +1184,6 @@ ifdef NO_LIBPCRE1_JIT
 endif
 endif
 
-ifdef USE_LIBPCRE2
-	BASIC_CFLAGS += -DUSE_LIBPCRE2
-	EXTLIBS += -lpcre2-8
-endif
-
 ifdef LIBPCREDIR
 	BASIC_CFLAGS += -I$(LIBPCREDIR)/include
 	EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
diff --git a/configure.ac b/configure.ac
index d1b3b143c4..6f1fd9df35 100644
--- a/configure.ac
+++ b/configure.ac
@@ -254,25 +254,25 @@ GIT_PARSE_WITH([openssl]))
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
-# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
-# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
-# default in future releases.
+# USE_LIBPCRE is a synonym for USE_LIBPCRE2, define USE_LIBPCRE1
+# instead if you'd like to use the legacy version 1 of the PCRE
+# library. Support for version 1 will likely be removed in some future
+# release of Git, as upstream has all but abandoned it.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
 AC_ARG_WITH(libpcre,
-AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
+AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre2]),
     if test "$withval" = "no"; then
-	USE_LIBPCRE1=
+	USE_LIBPCRE2=
     elif test "$withval" = "yes"; then
-	USE_LIBPCRE1=YesPlease
+	USE_LIBPCRE2=YesPlease
     else
-	USE_LIBPCRE1=YesPlease
+	USE_LIBPCRE2=YesPlease
 	LIBPCREDIR=$withval
 	AC_MSG_NOTICE([Setting LIBPCREDIR to $LIBPCREDIR])
-        dnl USE_LIBPCRE1 can still be modified below, so don't substitute
+        dnl USE_LIBPCRE2 can still be modified below, so don't substitute
         dnl it yet.
 	GIT_CONF_SUBST([LIBPCREDIR])
     fi)
@@ -280,10 +280,6 @@ AS_HELP_STRING([--with-libpcre],[synonym for --with-libpcre1]),
 AC_ARG_WITH(libpcre1,
 AS_HELP_STRING([--with-libpcre1],[support Perl-compatible regexes via libpcre1 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
-    if test -n "$USE_LIBPCRE1"; then
-        AC_MSG_ERROR([Only supply one of --with-libpcre or its synonym --with-libpcre1!])
-    fi
-
     if test "$withval" = "no"; then
 	USE_LIBPCRE1=
     elif test "$withval" = "yes"; then
@@ -300,6 +296,10 @@ AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and hea
 AC_ARG_WITH(libpcre2,
 AS_HELP_STRING([--with-libpcre2],[support Perl-compatible regexes via libpcre2 (default is NO)])
 AS_HELP_STRING([],           [ARG can be also prefix for libpcre library and headers]),
+    if test -n "$USE_LIBPCRE2"; then
+        AC_MSG_ERROR([Only supply one of --with-libpcre or its synonym --with-libpcre2!])
+    fi
+
     if test -n "$USE_LIBPCRE1"; then
         AC_MSG_ERROR([Only supply one of --with-libpcre1 or --with-libpcre2!])
     fi
-- 
2.15.1.424.g9478a66081

