Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23AAE201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbdETVoB (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:44:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34153 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755033AbdETVny (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so24397626wmf.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9Lvq/vgTaj897O8akPhHsZCIXqEmlI+3msXFcckcNM=;
        b=VoK5R+1G4eyV+6Wdxz1wAKNvmQpDmQh38DKlXu2kc+fPi2gtOKHkiMqDqF4TTWdMuk
         EEpWHWZHLO1RdvDyKwsPDnTOoHCubQp0tWtjTfJMm0RSuP0hnBGJmGsBgb6WgRAt56kv
         Dpfu11m9BmCVZNAphVjl1geuNdjfH4wVir2+CN01KPKNMwe3xyo+icQeb572vBAc/xz9
         dksjZz/L96DsNQNS8p8WqGqbukFkkbEP20RL1WYVb45wimwei3nnuCPqMkUWJb2bgLY/
         zi8rOrpAWtVONFeEnRGMYyR8SrULVuszWXcRQCQqGTjBAVERIAO3o9UP6Yjd+7/71Cqg
         0WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9Lvq/vgTaj897O8akPhHsZCIXqEmlI+3msXFcckcNM=;
        b=qiHqiNfI0GeAuruqd4vTr9UCgmQw4ETFUWmeA0xSFVTpAcsXHxE1TCRgP573qlZ+6H
         DS4qKa6HO+fTxZQuChDDhasX7t7qM+qErA7+bDYZsHBrZYq3e44SxUo4hgjp19j2Q/Av
         PnIh6hNvkJc33fzeQiNoyxr53md9NvAmzKy5pBIVUi3pknBpqhzkxnAUF6mz5XHR4PI9
         V/xsoTEk5PwAsKhMuQKKH67ovLDKaTFLTLaX/7hPPyL9PfsbMcAlqGMvCRPOTmfiFEtk
         GhtAXH7CRmFfvgYpQ/a+VADWM0hXY863mmq/g7UU0j74esz1EmBBTthwrKqK8Fl+AWQZ
         4YvQ==
X-Gm-Message-State: AODbwcDbj0Ib4PI/8nODe3JNqeEnTsfxz1Lav8NTaT4dt79vgicCvFXi
        tDyMLjmTKzDkTmOrzBM=
X-Received: by 10.28.55.16 with SMTP id e16mr16418103wma.141.1495316626962;
        Sat, 20 May 2017 14:43:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:46 -0700 (PDT)
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
Subject: [PATCH v3 23/30] grep: change the internal PCRE macro names to be PCRE1
Date:   Sat, 20 May 2017 21:42:26 +0000
Message-Id: <20170520214233.7183-24-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the internal USE_LIBPCRE define, & build options flag to use a
naming convention ending in PCRE1, without changing the long-standing
USE_LIBPCRE Makefile flag which enables this code.

This is for preparation for libpcre2 support where having things like
USE_LIBPCRE and USE_LIBPCRE2 in any more places than we absolutely
need to for backwards compatibility with old Makefile arguments would
be confusing.

In some ways it would be better to change everything that now uses
USE_LIBPCRE to use USE_LIBPCRE1, and to make specifying
USE_LIBPCRE (or --with-pcre) an error. This would impose a one-time
burden on packagers of git to s/USE_LIBPCRE/USE_LIBPCRE1/ in their
build scripts.

However I'd like to leave the door open to making
USE_LIBPCRE=YesPlease eventually mean USE_LIBPCRE2=YesPlease,
i.e. once PCRE v2 is ubiquitous enough that it makes sense to make it
the default.

This code and the USE_LIBPCRE Makefile argument was added in commit
63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09). At the time there was
no indication that the PCRE project would release an entirely new &
incompatible API around 3 years later.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 4 ++--
 grep.c        | 6 +++---
 grep.h        | 2 +-
 t/test-lib.sh | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index d1587452f1..374fbc7e58 100644
--- a/Makefile
+++ b/Makefile
@@ -1088,7 +1088,7 @@ ifdef NO_LIBGEN_H
 endif
 
 ifdef USE_LIBPCRE
-	BASIC_CFLAGS += -DUSE_LIBPCRE
+	BASIC_CFLAGS += -DUSE_LIBPCRE1
 	ifdef LIBPCREDIR
 		BASIC_CFLAGS += -I$(LIBPCREDIR)/include
 		EXTLIBS += -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib)
@@ -2240,7 +2240,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
-	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
+	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
diff --git a/grep.c b/grep.c
index 79eb681c6e..854f2404be 100644
--- a/grep.c
+++ b/grep.c
@@ -333,7 +333,7 @@ static int has_null(const char *s, size_t len)
 	return 0;
 }
 
-#ifdef USE_LIBPCRE
+#ifdef USE_LIBPCRE1
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	const char *error;
@@ -385,7 +385,7 @@ static void free_pcre_regexp(struct grep_pat *p)
 	pcre_free(p->pcre_extra_info);
 	pcre_free((void *)p->pcre_tables);
 }
-#else /* !USE_LIBPCRE */
+#else /* !USE_LIBPCRE1 */
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
 	die("cannot use Perl-compatible regexes when not compiled with USE_LIBPCRE");
@@ -400,7 +400,7 @@ static int pcrematch(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre_regexp(struct grep_pat *p)
 {
 }
-#endif /* !USE_LIBPCRE */
+#endif /* !USE_LIBPCRE1 */
 
 static int is_fixed(const char *s, size_t len)
 {
diff --git a/grep.h b/grep.h
index 267534ca24..073b0e4c92 100644
--- a/grep.h
+++ b/grep.h
@@ -1,7 +1,7 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
-#ifdef USE_LIBPCRE
+#ifdef USE_LIBPCRE1
 #include <pcre.h>
 #else
 typedef int pcre;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 04d857a42b..1d0f636cbd 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1014,7 +1014,7 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.13.0.303.g4ebf302169

