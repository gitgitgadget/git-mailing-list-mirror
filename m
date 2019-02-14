Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A7C1F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440227AbfBNVdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:33:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33055 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437907AbfBNVdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:33:15 -0500
Received: by mail-ed1-f66.google.com with SMTP id a2so6314530edi.0
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=namBLQPGSq8H7bEcI3jtRa6jtPO7cPuIX21W0Jutibg=;
        b=E+67QCWae9KGjA1J2p767sOig3o9Otobv2KlaHfFPlD47xZrzB9ANRnRpDuuIIWBWD
         xvVqjBr8yxuC4Vq6v6tpEEIiiXS2q04XwcLQd8fMu0HHKY8bGXEqhiQTil/hJmIGGxRW
         QTh1/K1iu3AtgcfNAQmleV7FpTJS3vvC7A+RizOK07NG2zZvNwhlEbrxNQot/DWhe644
         ibNBixFBjhaLaQCEXvHNXcDHXbW1uE1H/pK3e6xYi5INeBuzVsH4XFMbqP08N2S6zNVd
         /9WW+I/7eb6i8h6w2ULK0C35py3BRZo857i8+78w4ziryIHO8LdL0DSKmQIIru1RouD3
         L0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=namBLQPGSq8H7bEcI3jtRa6jtPO7cPuIX21W0Jutibg=;
        b=UZgd81cQtRJkTLv04jJUVdGhU3pUkJyMFUT6/UPXQU2N0XFlT1p3oxto/goUJs+oVh
         /HNOTjLHnxajPhcUtIiS2+R2wpcNrMErkfhkvZnsYDVmFHSMUifxwXsi5ihTsnilbybP
         frYYcb08A837zQHzBN10oRVf4PR/gqI5VSmcRtrwjGJR0OhwAYyyD0NE66RHAnpdvQej
         fB9aMUsBjcjG16tIQhq2IIfU6RjH791z0N+++DIvvJNexp5Q9dpgkwql3I1yXtZ9ATcd
         e2ml8kwbtDTPe3vHu08xOwStVt8LywLPkrJFP00ooStROm17g5+H+3Ufz/1vnPPqsuES
         VtbQ==
X-Gm-Message-State: AHQUAuZ7ctuGucq7CZ1/AqQdu8TZVw3LtC4MQGcwsje36lA/i6pwx/t2
        lmTW/qZMpiEL5FNaxJ8AZQcDQvYa
X-Google-Smtp-Source: AHgI3IZWO/fjm7ZUQDh+Y17q1nm/tFp3oCqCwXBmEn0ODdSUXA38hxXVf590G9SaJtCIlFB5/QL5kQ==
X-Received: by 2002:aa7:d41a:: with SMTP id z26mr4798337edq.224.1550179993177;
        Thu, 14 Feb 2019 13:33:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm952756edq.50.2019.02.14.13.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 13:33:12 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:33:12 -0800 (PST)
X-Google-Original-Date: Thu, 14 Feb 2019 21:33:10 GMT
Message-Id: <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.126.git.gitgitgadget@gmail.com>
References: <pull.126.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] tests: teach the test-tool to generate NUL bytes and use
 it
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Randall Becker <rsbecker@nexbridge.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In cc95bc2025 (t5562: replace /dev/zero with a pipe from
generate_zero_bytes, 2019-02-09), we replaced usage of /dev/zero (which
is not available on NonStop, apparently) by a Perl script snippet to
generate NUL bytes.

Sadly, it does not seem to work on NonStop, as t5562 reportedly hangs.

Worse, this also hangs in the Ubuntu 16.04 agents of the CI builds on
Azure Pipelines: for some reason, the Perl script snippet that is run
via `generate_zero_bytes` in t5562's 'CONTENT_LENGTH overflow ssite_t'
test case tries to write out an infinite amount of NUL bytes unless a
broken pipe is encountered, that snippet never encounters the broken
pipe, and keeps going until the build times out.

Oddly enough, this does not reproduce on the Windows and macOS agents,
nor in a local Ubuntu 18.04.

This developer tried for a day to figure out the exact circumstances
under which this hang happens, to no avail, the details remain a
mystery.

In the end, though, what counts is that this here change incidentally
fixes that hang (maybe also on NonStop?). Even more positively, it gets
rid of yet another unnecessary Perl invocation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                               |  1 +
 t/helper/test-genzeros.c               | 22 ++++++++++++++++++++++
 t/helper/test-tool.c                   |  1 +
 t/helper/test-tool.h                   |  1 +
 t/t5562-http-backend-content-length.sh |  2 +-
 t/test-lib-functions.sh                |  8 +-------
 6 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 t/helper/test-genzeros.c

diff --git a/Makefile b/Makefile
index f0b2299172..c5240942f2 100644
--- a/Makefile
+++ b/Makefile
@@ -740,6 +740,7 @@ TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-dump-untracked-cache.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
 TEST_BUILTINS_OBJS += test-genrandom.o
+TEST_BUILTINS_OBJS += test-genzeros.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
new file mode 100644
index 0000000000..f607f800a9
--- /dev/null
+++ b/t/helper/test-genzeros.c
@@ -0,0 +1,22 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+int cmd__genzeros(int argc, const char **argv)
+{
+	long count;
+
+	if (argc > 2) {
+		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
+		return 1;
+	}
+
+	count = argc > 1 ? strtol(argv[1], NULL, 0) : -1L;
+
+	while (count < 0 || count--) {
+		if (putchar(0) == EOF)
+			return -1;
+	}
+
+	return 0;
+}
+
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 50c55f8b1a..99db7409b8 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -19,6 +19,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-untracked-cache", cmd__dump_untracked_cache },
 	{ "example-decorate", cmd__example_decorate },
 	{ "genrandom", cmd__genrandom },
+	{ "genzeros", cmd__genzeros },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
 	{ "index-version", cmd__index_version },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index a563df49bf..25abed1cf2 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -16,6 +16,7 @@ int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
+int cmd__genzeros(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index bbadde2c6e..c0105423e6 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -143,7 +143,7 @@ test_expect_success GZIP 'push gzipped empty' '
 
 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
-	generate_zero_bytes infinity  | env \
+	generate_zero_bytes | env \
 		CONTENT_TYPE=application/x-git-upload-pack-request \
 		QUERY_STRING=/repo.git/git-upload-pack \
 		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 094c07748a..80402a428f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -120,13 +120,7 @@ remove_cr () {
 # If $1 is 'infinity', output forever or until the receiving pipe stops reading,
 # whichever comes first.
 generate_zero_bytes () {
-	perl -e 'if ($ARGV[0] == "infinity") {
-		while (-1) {
-			print "\0"
-		}
-	} else {
-		print "\0" x $ARGV[0]
-	}' "$@"
+	test-tool genzeros "$@"
 }
 
 # In some bourne shell implementations, the "unset" builtin returns
-- 
gitgitgadget
