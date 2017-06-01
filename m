Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3538A20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdFASVd (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:33 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36808 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdFASVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:31 -0400
Received: by mail-wm0-f47.google.com with SMTP id 7so167883995wmo.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4XQmyU6XhVNySmoiZNmMpC+yFxliTSYaYeSmDV9oYA=;
        b=Fm/itDUm7kBRwxzCXsCvcbQCRnL6lUUhRQSo+QeNv4A9e86SFEdVnzz0CL7keZaGyw
         5mzEZFAlfJoZFouwcoQf91GQCNOfdwK9lk38XiSfDOFSehPnMpGz9ri+yjv3KDsrQH5M
         mUUivJR+2mAoOSJEIu40ITVq5ZAwSiRqO04gz0rOhOm78BfIEWo91yha+2MsKNSCFV/p
         hC8xyUyHuc4C62Mj3OfpQGClUuCj+m5fozBWx66ALIetcw6+nbmPb82gECUjIXCJZA8N
         ni7T89gxt+0QmyQVGQwFAySPLl4ILeGB1mTHnEtWq32HOlq0OW4VFPfgErtI/0/xhVU4
         Lwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4XQmyU6XhVNySmoiZNmMpC+yFxliTSYaYeSmDV9oYA=;
        b=YL5nnU09t4HhCf1jXba4qrs8JedfEyBnzrG0RV15kZcsWczx4of8IFVLBjVh112/X3
         o5c8p4iyfPvpnuz49FoVBg0Am6CC+k0L1vlWkaDduNZxCUJc6PTSJpAjWnCZYJZwovkc
         bg+JFj81M/74PiU3h16NHLDM72xJUoNyExXolqyKqz35bC5yPnyI7rrKn6HvVUTy6qGS
         Whq7V/Mu8zEdWn8epsg2l+PPdI00E239WdugDJfGkwhPYhDadHjjflO/z4Ou3Ce7O8kV
         VmgefRhKPK1u6uE9LNXQNTZT6Oqb81gPfHVqBB++nCq5f898zp0N53H0rV1nFiPwlrP+
         n/cw==
X-Gm-Message-State: AODbwcCUJhDd5TUMkwW5LSvtEvLPe9ADKSU9yrZlrCH0k1VbOWt17qZp
        WH3uGfazr28isqE/gsJ7Aw==
X-Received: by 10.28.144.10 with SMTP id s10mr384242wmd.62.1496341284795;
        Thu, 01 Jun 2017 11:21:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:23 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/8] grep: un-break building with PCRE >= 8.32 without --enable-jit
Date:   Thu,  1 Jun 2017 18:20:55 +0000
Message-Id: <20170601182056.31142-8-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend my change earlier in this series ("grep: add support for the
PCRE v1 JIT API", 2017-04-11) to un-break the build on PCRE v1
versions later than 8.31 compiled without --enable-jit.

As explained in that change and a later compatibility change in this
series ("grep: un-break building with PCRE < 8.32", 2017-05-10) the
pcre_jit_exec() function is a faster path to execute the JIT.

Unfortunately there's no compatibility stub for that function compiled
into the library if pcre_config(PCRE_CONFIG_JIT, &ret) would return 0,
and no macro that can be used to check for it, so the only portable
option to support builds without --enable-jit is via a new
NO_LIBPCRE1_JIT=UnfortunatelyYes Makefile option[1].

Another option would be to make the JIT opt-in via
USE_LIBPCRE1_JIT=YesPlease, after all it's not a default option of
PCRE v1.

I think it makes more sense to make it opt-out since even though it's
not a default option, most packagers of PCRE seem to turn it on by
default, with the notable exception of the MinGW package.

Make the MinGW platform work by default by changing the build defaults
to turn on NO_LIBPCRE1_JIT=UnfortunatelyYes. It is the only platform
that turns on USE_LIBPCRE=YesPlease by default, see commit
df5218b4c3 ("config.mak.uname: support MSys2", 2016-01-13) for that
change.

1. "How do I support pcre1 JIT on all
   versions?"  (https://lists.exim.org/lurker/thread/20170601.103148.10253788.en.html)

2. https://github.com/Alexpux/MINGW-packages/blob/master/mingw-w64-pcre/PKGBUILD
   (referenced from "Re: PCRE v2 compile error, was Re: What's cooking
   in git.git (May 2017, #01; Mon, 1)";
   <alpine.DEB.2.20.1705021756530.3480@virtualbox>)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         | 13 +++++++++++++
 config.mak.uname |  1 +
 grep.h           |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/Makefile b/Makefile
index 7bea912e5a..8f26301e95 100644
--- a/Makefile
+++ b/Makefile
@@ -29,6 +29,14 @@ all::
 # Perl-compatible regular expressions instead of standard or extended
 # POSIX regular expressions.
 #
+# When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
+# library is compiled without --enable-jit. We will auto-detect
+# whether the version of the PCRE v1 library in use has JIT support at
+# all, but we unfortunately can't auto-detect whether JIT support
+# hasn't been compiled in in an otherwise JIT-supporting version. If
+# you have link-time errors about a missing `pcre_jit_exec` define
+# this, or recompile PCRE v1 with --enable-jit.
+#
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
 #
@@ -1095,6 +1103,10 @@ ifdef USE_LIBPCRE
 		EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
 	endif
 	EXTLIBS += -lpcre
+
+ifdef NO_LIBPCRE1_JIT
+	BASIC_CFLAGS += -DNO_LIBPCRE1_JIT
+endif
 endif
 
 ifdef HAVE_ALLOCA_H
@@ -2242,6 +2254,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo NO_LIBPCRE1_JIT=\''$(subst ','\'',$(subst ','\'',$(NO_LIBPCRE1_JIT)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
diff --git a/config.mak.uname b/config.mak.uname
index 192629f143..8ee62478e2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -551,6 +551,7 @@ else
 		NO_GETTEXT =
 		USE_GETTEXT_SCHEME = fallthrough
 		USE_LIBPCRE= YesPlease
+		NO_LIBPCRE1_JIT = UnfortunatelyYes
 		NO_CURL =
 		USE_NED_ALLOCATOR = YesPlease
 	else
diff --git a/grep.h b/grep.h
index ce90969736..3bff0870b2 100644
--- a/grep.h
+++ b/grep.h
@@ -5,9 +5,11 @@
 #include <pcre.h>
 #ifdef PCRE_CONFIG_JIT
 #if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
+#ifndef NO_LIBPCRE1_JIT
 #define GIT_PCRE1_USE_JIT
 #endif
 #endif
+#endif
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.13.0.303.g4ebf302169

