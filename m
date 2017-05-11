Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C625C2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbdEKRvh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:51:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34849 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbdEKRvc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:32 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so3786702qtb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqepUlochIjkXrrnOXyfLxaD1zdKl2+rbg8ORMfx1L8=;
        b=aOjccC232DyyvEdQTLhpb533kjJnB0ZqQzhNwt7xnJyaLaG+daRDDyDimMh5Dhm+Zz
         VVJ1GzQ75POtWo9m3yrs2mcsOIP50cTMSCUyHOuE4ZFYMOjuhJSkF4JVR4pODVnhGgNi
         QWrt/Rr4hOkkKpDbuzMFifv3uNa1KgpUmNMfdThuAHg6dpOjwAcRf3dLXM0fC9B+oRRh
         Eqd2uyLfMUwc/aePgtnmJSwpikOn0qfmDlmGgaxU/djQza5clETP/f6mI10+x059BxlY
         ZnKcxUQC+9AvA7Wgl9wTnPEQWatqByxnXbX2vYVvzSU2a4OzGJCJm9QnG/GeR2fHifwq
         rrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqepUlochIjkXrrnOXyfLxaD1zdKl2+rbg8ORMfx1L8=;
        b=TFLJzyFf0OismSgnvlwWKMfbi71nNZllnRvlXgNpxLAgjU8n4sHzZClJ2geRFJnnQW
         0GPe1rEb6J2Tp6tgRSUbNFsdEoI4Xox0Sk1lgpCan7KpuothoxlMGmgCUGpOdH8aoLsK
         l634iM/IC/fVYm17Ba6JM8F9oONoXNG9Gtx5hCbW1FJ2nlToI1DH7ftAqPnbkNdR4W2M
         Y+sFs4B3ljl5DucKRF7cH1O3HEY+ZoWjUFKxjE9bxCs0IpvUNyLZip/NOeoQqj5yN7om
         AdkvFuw+T4NtL4ChdzWxoRTbcLInYa3p6MmkCUKO6IIfXNcAyUTV/x76y7pqlfy6RKDU
         IRvQ==
X-Gm-Message-State: AODbwcCKb6Y/7TJmgxwizi8Y+bW15oKajbmxQDWXhV7eQFVkV0YLxeR4
        n6PkW7DCiVZwbw==
X-Received: by 10.237.60.207 with SMTP id e15mr66437qtf.106.1494525091711;
        Thu, 11 May 2017 10:51:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:30 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH/RFC 1/6] Makefile & compat/pcre2: add ability to build an embedded PCRE
Date:   Thu, 11 May 2017 17:51:10 +0000
Message-Id: <20170511175115.648-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511175115.648-1-avarab@gmail.com>
References: <20170511175115.648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a USE_LIBPCRE2_BUNDLED=YesIHaveNoPackagedVersion flag to the
Makefile which'll use the PCRE v2 shipped in compat/pcre2 instead of
trying to find it via -lpcre2-8 on the installed system.

As covered in a previous commits ("grep: add support for PCRE v2",
2017-04-08) there are major benefits to using a bleeding edge PCRE v2,
but more importantly I'd like to experiment with making PCRE a
mandatory dependency to power various internal features of grep/log
without the user being aware that they're using the library under the
hood, similar to how we use kwset now for fixed-string searches.

Imposing that hard dependency on everyone using git would bother a lot
of people, whereas if git itself ships PCRE it's no more bothersome
than the code using kwset, i.e. it can be invisible to the builder &
user, and allow git to target newer PCRE APIs without worrying about
versioning.

See [1] for a mostly one-sided pcre-dev mailing list thread discussing
how embed the library.

Implementation details:

 * I configured PCRE v2 with ./configure --enable-jit --enable-utf

 * It sets a lot of -DHAVE_* but these are used by the subset of the
   files I copied, many are either unused or only used by pcre2test.c
   which isn't brought in by the script.

 * These -DHAVE_* flags are something we have already by default &
   assume in other git.git code, so it should be fine to define it.

 * -DPCRE2_CODE_UNIT_WIDTH=8 only compiles the functions linking to
   -lpcre2-8 would have gotten us.

 * All the limits / sizes are the PCRE defaults, the
   MATCH_LIMIT_RECURSION define is a synonym for MATCH_LIMIT_DEPTH in
   older versions, it allows building against older (currently
   release) versions of the library.

 * -DNEWLINE_DEFAULT=2 means only \n is recognized as a newline. This
    corresponds to the --enable-newline-is-lf option. It's also
    possible to set this to CR, CRLF, any of CR, LF, or CRLF, or any
    Unicode newline character being recognized as \n.

    This *might* have to be customized on Windows, but I think the
    grep machinery always splits on newlines for us already, so this
    probably works on Windows as-is, but needs testing.

1. https://lists.exim.org/lurker/thread/20170507.223619.fbee8f00.en.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                  | 52 ++++++++++++++++++++++++++++++++++++
 compat/pcre2/get-pcre2.sh | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100755 compat/pcre2/get-pcre2.sh

diff --git a/Makefile b/Makefile
index d77ca4c1a5..b18867196e 100644
--- a/Makefile
+++ b/Makefile
@@ -34,6 +34,11 @@ all::
 # library. The USE_LIBPCRE flag will likely be changed to mean v2 by
 # default in future releases.
 #
+# Define USE_LIBPCRE2_BUNDLED=YesIHaveNoPackagedVersion in addition to
+# USE_LIBPCRE2=YesPlease if you'd like to use a copy of PCRE version 2
+# bunded with Git. This is for setups where getting a hold of a
+# packaged PCRE is inconvenient.
+#
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -1105,8 +1110,10 @@ endif
 
 ifdef USE_LIBPCRE2
 	BASIC_CFLAGS += -DUSE_LIBPCRE2
+ifndef USE_LIBPCRE2_BUNDLED
 	EXTLIBS += -lpcre2-8
 endif
+endif
 
 ifdef LIBPCREDIR
 	BASIC_CFLAGS += -I$(LIBPCREDIR)/include
@@ -1505,6 +1512,50 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
+ifdef USE_LIBPCRE2_BUNDLED
+ifndef USE_LIBPCRE2
+$(error please set USE_LIBPCRE2=YesPlease when setting \
+USE_LIBPCRE2_BUNDLED=$(USE_LIBPCRE2_BUNDLED))
+endif
+	COMPAT_CFLAGS += \
+		-Icompat/pcre2/src \
+		-DHAVE_BCOPY=1 \
+		-DHAVE_INTTYPES_H=1 \
+		-DHAVE_MEMMOVE=1 \
+		-DHAVE_STDINT_H=1 \
+		-DPCRE2_CODE_UNIT_WIDTH=8 \
+		-DLINK_SIZE=2 \
+		-DHEAP_LIMIT=20000000 \
+		-DMATCH_LIMIT=10000000 \
+		-DMATCH_LIMIT_DEPTH=10000000 \
+		-DMATCH_LIMIT_RECURSION=10000000 \
+		-DMAX_NAME_COUNT=10000 \
+		-DMAX_NAME_SIZE=32 \
+		-DPARENS_NEST_LIMIT=250 \
+		-DNEWLINE_DEFAULT=2 \
+		-DSUPPORT_JIT \
+		-DSUPPORT_UNICODE
+	COMPAT_OBJS += \
+		compat/pcre2/src/pcre2_auto_possess.o \
+		compat/pcre2/src/pcre2_chartables.o \
+		compat/pcre2/src/pcre2_compile.o \
+		compat/pcre2/src/pcre2_config.o \
+		compat/pcre2/src/pcre2_context.o \
+		compat/pcre2/src/pcre2_error.o \
+		compat/pcre2/src/pcre2_find_bracket.o \
+		compat/pcre2/src/pcre2_jit_compile.o \
+		compat/pcre2/src/pcre2_maketables.o \
+		compat/pcre2/src/pcre2_match.o \
+		compat/pcre2/src/pcre2_match_data.o \
+		compat/pcre2/src/pcre2_newline.o \
+		compat/pcre2/src/pcre2_ord2utf.o \
+		compat/pcre2/src/pcre2_string_utils.o \
+		compat/pcre2/src/pcre2_study.o \
+		compat/pcre2/src/pcre2_tables.o \
+		compat/pcre2/src/pcre2_ucd.o \
+		compat/pcre2/src/pcre2_valid_utf.o \
+		compat/pcre2/src/pcre2_xclass.o
+endif
 ifdef NATIVE_CRLF
 	BASIC_CFLAGS += -DNATIVE_CRLF
 endif
@@ -2259,6 +2310,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
 	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
+	@echo USE_LIBPCRE2_BUNDLED=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2_BUNDLED)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
diff --git a/compat/pcre2/get-pcre2.sh b/compat/pcre2/get-pcre2.sh
new file mode 100755
index 0000000000..f1796cb518
--- /dev/null
+++ b/compat/pcre2/get-pcre2.sh
@@ -0,0 +1,67 @@
+#!/bin/sh -e
+
+# Usage:
+# ./get-pcre2.sh '' 'trunk'
+# ./get-pcre2.sh '' 'tags/pcre2-10.23'
+# ./get-pcre2.sh ~/g/pcre2 ''
+
+srcdir=$1
+version=$2
+if test -z "$version"
+then
+	version="tags/pcre2-10.23"
+fi
+
+echo Getting PCRE v2 version $version
+rm -rfv src
+mkdir src src/sljit
+
+for srcfile in \
+	pcre2.h \
+	pcre2_internal.h \
+	pcre2_intmodedep.h \
+	pcre2_ucp.h \
+	pcre2_auto_possess.c \
+	pcre2_chartables.c.dist \
+	pcre2_compile.c \
+	pcre2_config.c \
+	pcre2_context.c \
+	pcre2_error.c \
+	pcre2_find_bracket.c \
+	pcre2_jit_compile.c \
+	pcre2_jit_match.c \
+	pcre2_jit_misc.c \
+	pcre2_maketables.c \
+	pcre2_match.c \
+	pcre2_match_data.c \
+	pcre2_newline.c \
+	pcre2_ord2utf.c \
+	pcre2_string_utils.c \
+	pcre2_study.c \
+	pcre2_tables.c \
+	pcre2_ucd.c \
+	pcre2_valid_utf.c \
+	pcre2_xclass.c
+do
+	if test -z "$srcdir"
+	then
+		svn cat svn://vcs.exim.org/pcre2/code/$version/src/$srcfile >src/$srcfile
+	else
+		cp "$srcdir/src/$srcfile" src/$srcfile
+	fi
+	wc -l src/$srcfile
+done
+
+(cd src && ln -sf pcre2_chartables.c.dist pcre2_chartables.c)
+
+if test -z "$srcdir"
+then
+	for srcfile in $(svn ls svn://vcs.exim.org/pcre2/code/tags/pcre2-10.23/src/sljit)
+	do
+		svn cat svn://vcs.exim.org/pcre2/code/$version/src/sljit/$srcfile >src/sljit/$srcfile
+		wc -l src/sljit/$srcfile
+	done
+else
+	cp -R "$srcdir/src/sljit" src/
+	wc -l src/sljit/*
+fi
-- 
2.11.0

