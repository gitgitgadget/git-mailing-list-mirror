Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66620207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 21:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993570AbdDYVHL (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 17:07:11 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36687 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2993567AbdDYVHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 17:07:08 -0400
Received: by mail-wm0-f52.google.com with SMTP id u65so33539598wmu.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zschuoCtqXuViQLO61KBfX9B6tZh1WCiZC9PhFIG2TE=;
        b=neWUVGdpnpW8MgguU/GYkRJ2pMzrvnSBoA4aH7ucxS8qIr9arahIMoCdUOi7BWG0Tb
         mALjNhPNX1UxRlRwUP0+k7UDRiVdps+m1pM2nrt3O9kX4Pidfqh5y8Pn8C6TIie0EWyr
         HQYNQRTUBXtcLazuC+3gW1J0fYK9783CBeEF9BPKhS1U7tZFhdwn7EzPFmfnwmQ24OWi
         ze7grVyX+xdLnjHNLLI/dKVlB99RWfSL9auY3L95RFraBiUFUD34UD2Tzm6xZr2Sw2SV
         J97QTpnJPYVtxDOi3UxgVdYlGu7yJaPxhDTuxiAKG3mUlNZfIRdg9NyubFzW/9kbrWyX
         gv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zschuoCtqXuViQLO61KBfX9B6tZh1WCiZC9PhFIG2TE=;
        b=dSJw3Xq9ehmsXDQxOJNKc+QOmdqnoO2irHbcEmnO7v4C7oWAtDmwCy1PMXyOfyBo5n
         zZTH6Hs+kGQyBbm/IjirTjc8Z/8+VmYP2EYbOiLHzFVH6CRxPdaIdQcdrI9DVL2Zs2uK
         BiCd1ghTdbcfTryuO1osYSVxtf16Flxy/2AePxxqKfEnAPLUtLKe8iUWUhYf1JLqFir6
         lfHui6jKMGexlg0OHDgfWqT1TAMI5+5KcUuD5DpZG2lhS5EjstA1RIRHYQ8R0aQ3DjGl
         jyIdPFZ5umpuJLF7lIxT1o7KzkyubyjHn2VOHgktZD4e751jkkHo/dRqeyginmaDS3UN
         gErg==
X-Gm-Message-State: AN3rC/6p0hKFelskU00m2iYtI5UQYrxwxFBE2L0iSYCgoX6Kl4fLX3qC
        +3Tgw2eXhA+HxA==
X-Received: by 10.28.22.78 with SMTP id 75mr14754696wmw.85.1493154417145;
        Tue, 25 Apr 2017 14:06:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i71sm27519917wri.0.2017.04.25.14.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Apr 2017 14:06:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/19] Makefile & configure: make PCRE v2 the default PCRE implementation
Date:   Tue, 25 Apr 2017 21:05:48 +0000
Message-Id: <20170425210548.24612-20-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170425210548.24612-1-avarab@gmail.com>
References: <20170425210548.24612-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the USE_LIBPCRE=YesPlease & --with-libpcre flags to the
Makefile & configure script, respectively, to mean use PCRE v2, not
PCRE v1.

The legacy library previously available via those options is still
available on request via USE_LIBPCRE1=YesPlease or
--with-libpcre1. The existing USE_LIBPCRE2=YesPlease & --with-libpcre2
still explicitly ask for v2.

The v2 PCRE is stable & end-user compatible, all this change does is
change the default. Someone building a new git is likely to also have
packaged PCRE v2 sometime in the last 2 years since it was released.
If not they can choose to use the legacy v2 library by making the
trivial s/USE_LIBPCRE/USE_LIBPCRE1/ change, or package up PCRE v2.

New releases of PCRE v2 are already faster than PCRE v1, and not only
is all significant development is happening on v2, but bugs in
reported against v1 have started getting WONTFIX'd asking users to
just upgrade to v2.

So it makes sense to give our downstream distributors a nudge to
switch over to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     | 21 ++++++++++-----------
 configure.ac | 18 +++++++++---------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/Makefile b/Makefile
index a792f206b9..42b09f9632 100644
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
+# The USE_LIBPCRE flag is a synonym for USE_LIBPCRE2, in previous
+# versions it meant the same thing USE_LIBPCRE1 does now. Define
+# USE_LIBPCRE1 instead if you'd like to use the legacy version 1 of
+# the PCRE library.
 #
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
@@ -1090,18 +1090,17 @@ ifdef NO_LIBGEN_H
 	COMPAT_OBJS += compat/basename.o
 endif
 
-USE_LIBPCRE1 ?= $(USE_LIBPCRE)
-
-ifneq (,$(USE_LIBPCRE1))
-	ifdef USE_LIBPCRE2
-$(error Only set USE_LIBPCRE1 (or its alias USE_LIBPCRE) or USE_LIBPCRE2, not both!)
-	endif
+USE_LIBPCRE2 ?= $(USE_LIBPCRE)
 
+ifdef USE_LIBPCRE1
 	BASIC_CFLAGS += -DUSE_LIBPCRE1
 	EXTLIBS += -lpcre
 endif
 
-ifdef USE_LIBPCRE2
+ifneq (,$(USE_LIBPCRE2))
+	ifdef USE_LIBPCRE1
+$(error Only set USE_LIBPCRE2 (or its alias USE_LIBPCRE) or USE_LIBPCRE1, not both!)
+	endif
 	BASIC_CFLAGS += -DUSE_LIBPCRE2
 	EXTLIBS += -lpcre2-8
 endif
diff --git a/configure.ac b/configure.ac
index 11d083fbe0..f9659daeb7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -255,25 +255,25 @@ GIT_PARSE_WITH([openssl]))
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
-# Currently USE_LIBPCRE is a synonym for USE_LIBPCRE1, define
-# USE_LIBPCRE2 instead if you'd like to use version 2 of the PCRE
-# library. The USE_LIBPCRE flag will likely be changed to mean v2 by
-# default in future releases.
+# The USE_LIBPCRE flag is a synonym for USE_LIBPCRE2, in previous
+# versions it meant the same thing USE_LIBPCRE1 does now. Define
+# USE_LIBPCRE1 instead if you'd like to use the legacy version 1 of
+# the PCRE library.
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
-- 
2.11.0

