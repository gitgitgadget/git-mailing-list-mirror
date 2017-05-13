Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBD120188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755458AbdEMXRJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34141 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758876AbdEMXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id u75so12496599qka.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcJYpaWxu8/h3GZ+JCRWJRu6vR9UEy+I9gKjKzuaFPM=;
        b=Y1Fv0oFhzJ4K6Iv/UGvMTzw+LzuoGOzZtRWUTLPD22NCNO9gzGU8oM3OpMW5lNpBG1
         1nF28+J/NKQiN1G+FZ3Dqlf3lBoFW7HPk8Sg2xZSQWlIncFgMNztM+YlbP4J3A9hS3w5
         kt/ChTJX4PcEkzpKWT8HMu8qRINTpakWyvXeMRxMEMLXw2An6ywAMI2a7dfr1T3JKh+J
         d8Q3dJ9tNKub70c2AX5PQ6zR0FxOfbEVgWA/1+pTuCOl52gYt+fXImt8C6EDtG2wt+KT
         rvnO4RQGtXqhlSPocyQW3v64yTYTWEVGwEaUAXVhmbuBcwk/gybaC+Am9PTjDQDyq8hS
         35EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcJYpaWxu8/h3GZ+JCRWJRu6vR9UEy+I9gKjKzuaFPM=;
        b=VBg77OEELjoe+ner34b49JQfFbICc/tXXtuMJdifg0GNFNSRl1QvMvDUPU4kp6O39D
         5Bozj+B/tUbWDta76SFbJgCN8RCWJNzWqZunFTJ1frX4RKwrzs1Wc6D1T0+jtDK6V/oI
         Wdfh2hJDwz/oW6tVoifp3CSIGubkWqgpvqNircCLHY5RqhNSPuaY9OVWviG1wTj4OZ96
         IZyp7wZWitrWQ/pCpQ6zZ5gQmY3kvWCnKzOCjcjTW5FvJf6sBZDUt4+NgcaQr6GLBNLq
         r142MAUBnncGy5NyLiGe115LCK1Th8lexwaH2Vz6uHenS97Kc9f6xzV/Q5MWtRPOXAro
         awiw==
X-Gm-Message-State: AODbwcA9XCD3HHTMwLIMwLxBOZIJtzyEItuFxr0Kc0pdCWNpbDFY7V/c
        YOQgxyMlCR1zug==
X-Received: by 10.55.53.210 with SMTP id c201mr9456761qka.301.1494717423281;
        Sat, 13 May 2017 16:17:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:02 -0700 (PDT)
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
Subject: [PATCH v2 22/29] grep: change the internal PCRE macro names to be PCRE1
Date:   Sat, 13 May 2017 23:15:02 +0000
Message-Id: <20170513231509.7834-23-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
index 6abf1d1918..e5cfbcc36b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1010,7 +1010,7 @@ esac
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
-test -n "$USE_LIBPCRE" && test_set_prereq PCRE
+test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 
 # Can we rely on git's output in the C locale?
-- 
2.11.0

