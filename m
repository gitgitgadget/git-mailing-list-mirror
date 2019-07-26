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
	by dcvr.yhbt.net (Postfix) with ESMTP id 431EC1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfGZPJO (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55545 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387757AbfGZPJK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so48296999wmj.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBkWT95Uwgo8haPGhHLiGW0JxysHkMuA1iAqHf/Uss4=;
        b=Yug0/bi2t+3fsWAQEvKsS4SULX26Ms3WxmdMXf5Bdm3FnapFuy7aCEsS7D4sQXquMW
         MxYm6OzZbctyQbfEe3+CmgJhKtOd6GqD3XU3vnmLpfFLfpKY4FlzDXXS3liyzoKspCri
         TpUDlx1X4GlYxcpR8RdQhXzvCtVWGu/uMFkYAPppxz5ICxly1jqv5zF2qHmWSWLZvsct
         ZpWCvarMg2WQKfOdVRNmXy16YYI70bbKhmmysFWEZvudyPA0Ps6TlJ3TBKXnSdsYmZr5
         Mh+uuwQ9IBCAkFu8zs6iycIRZFXr4zZ4ywCv3ft/BKTKzqdF2mY4nKLdrKLHnvlytf4Z
         XUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBkWT95Uwgo8haPGhHLiGW0JxysHkMuA1iAqHf/Uss4=;
        b=rHGK5dcZHw+Qkg/lUmgVZ8Kr1NHdsKZP/NxmWuIb52ym8RJqbDhUJngQ/NtE/iwa0z
         5hx2lk8nP6HXP5I2BCNXL3VCMfebjNNhWuP/puoB/FghzG7bkYRBbrmwQTApn6hmlHIf
         muhYxghmuB6l7XFkJ9EiU4ojPBpN8ZpW+TJKT3HUrGVIx3ruboET+bZ497Z6mSLQNBi3
         aCvtqiUc01KhDPF3WgjDdEk06T+AyFGbgzmaUm5u6jrrLK6+8lD/0uoGLy1b4CmYxNDT
         I28GDfU4SLnoEaKUXyy+V+81MWOCtM2Xq+J2txSi5eW3cpzuDSz1pcUdw2fm9GMwI7RH
         BhrA==
X-Gm-Message-State: APjAAAVTi9fFvMNDuYFPhxwI53UndD8E2XCFbPRpx2/BvaRaxNWNxt4V
        8+Q6noQxQ5eyz6VVbFe1EJG5E/cWexc=
X-Google-Smtp-Source: APXvYqzI2fVsqaJWCpzpnFX6Kr5zgigMPaSv8EkyXkVAiPvY2VJOpaSeOlIche6f0DERHXEEzaFivg==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr79718213wmk.136.1564153746982;
        Fri, 26 Jul 2019 08:09:06 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.09.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:09:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] grep: optimistically use PCRE2_MATCH_INVALID_UTF
Date:   Fri, 26 Jul 2019 17:08:18 +0200
Message-Id: <20190726150818.6373-9-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in the "grep: stess test PCRE v2 on invalid UTF-8 data"
commit leading up to this one there's a regression in
b65abcafc7 ("grep: use PCRE v2 for optimized fixed-string search",
2019-07-01) when matching UTF-8 data.

This ultimately isn't straightforward to just "fix", because the kwset
backend was so dumb about icase matching that we'd skip it entirely on
non-ASCII. See the code removed in 48de2a768c ("grep: remove the kwset
optimization", 2019-07-01).

Just going back to the C library for those isn't ideal, since it's
likely to be even dumber about these mixed-encoding cases.

So let's support this "properly" using the PCRE2_MATCH_INVALID_UTF
flag. This is new code that's not in any released PCRE v2 version, so
we might need a fix that emulates it somehow. I figure that the case
that with the non-icase bug out of the way this is obscure enough to
tell people "upgrade your PCRE v2 too!'. It'll likely be released by
the time we release the git version this commit is part of.

We can't just use PCRE2_NO_UTF_CHECK instead for the reasons discussed
in [1].

1. https://public-inbox.org/git/87lfwn70nb.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                        |  1 +
 grep.c                          |  2 +-
 grep.h                          |  3 +++
 t/helper/test-pcre2-config.c    | 12 ++++++++++++
 t/helper/test-tool.c            |  1 +
 t/helper/test-tool.h            |  1 +
 t/t7812-grep-icase-non-ascii.sh | 13 ++++++++++++-
 7 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-pcre2-config.c

diff --git a/Makefile b/Makefile
index bd246f2989..dd38d5e527 100644
--- a/Makefile
+++ b/Makefile
@@ -726,6 +726,7 @@ TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-path-utils.o
+TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
 TEST_BUILTINS_OBJS += test-prio-queue.o
 TEST_BUILTINS_OBJS += test-reach.o
diff --git a/grep.c b/grep.c
index c7c06ae08d..8b8b9efe12 100644
--- a/grep.c
+++ b/grep.c
@@ -474,7 +474,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
 	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
-		options |= PCRE2_UTF;
+		options |= (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
 					 p->patternlen, options, &error, &erroffset,
diff --git a/grep.h b/grep.h
index c0c71eb4a9..506f05b97b 100644
--- a/grep.h
+++ b/grep.h
@@ -21,6 +21,9 @@ typedef int pcre_extra;
 #ifdef USE_LIBPCRE2
 #define PCRE2_CODE_UNIT_WIDTH 8
 #include <pcre2.h>
+#ifndef PCRE2_MATCH_INVALID_UTF
+#define PCRE2_MATCH_INVALID_UTF 0
+#endif
 #else
 typedef int pcre2_code;
 typedef int pcre2_match_data;
diff --git a/t/helper/test-pcre2-config.c b/t/helper/test-pcre2-config.c
new file mode 100644
index 0000000000..5258fdddba
--- /dev/null
+++ b/t/helper/test-pcre2-config.c
@@ -0,0 +1,12 @@
+#include "test-tool.h"
+#include "cache.h"
+#include "grep.h"
+
+int cmd__pcre2_config(int argc, const char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], "has-PCRE2_MATCH_INVALID_UTF")) {
+		int value = PCRE2_MATCH_INVALID_UTF;
+		return !value;
+	}
+	return 1;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index ce7e89028c..e022ce0e48 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -40,6 +40,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
 	{ "path-utils", cmd__path_utils },
+	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
 	{ "prio-queue", cmd__prio_queue },
 	{ "reach", cmd__reach },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f805bb39ae..acd8af2a9d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -30,6 +30,7 @@ int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
+int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
 int cmd__prio_queue(int argc, const char **argv);
 int cmd__reach(int argc, const char **argv);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 531eb59d57..848d46e4f9 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -74,11 +74,22 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invali
 	test_cmp expected actual
 '
 
-test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
+test_lazy_prereq PCRE2_MATCH_INVALID_UTF '
+	test-tool pcre2-config has-PCRE2_MATCH_INVALID_UTF
+'
+
+test_expect_success GETTEXT_LOCALE,LIBPCRE2,!PCRE2_MATCH_INVALID_UTF 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
 	test_might_fail git grep -hi "Æ" invalid-0x80 >actual &&
 	test_cmp expected actual &&
 	test_must_fail git grep -hi "(*NO_JIT)Æ" invalid-0x80 &&
 	test_cmp expected actual
 '
 
+test_expect_success GETTEXT_LOCALE,LIBPCRE2,PCRE2_MATCH_INVALID_UTF 'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' '
+	git grep -hi "Æ" invalid-0x80 >actual &&
+	test_cmp expected actual &&
+	git grep -hi "(*NO_JIT)Æ" invalid-0x80 &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.22.0.455.g172b71a6c5

