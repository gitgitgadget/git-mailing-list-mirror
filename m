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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D95201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbdETVoN (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:44:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36682 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932377AbdETVoK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:44:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so5741889wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZ6hA7jZWwq8nGDirM5J+yCglYW1lCb+6oIjgOHxcQ8=;
        b=oBa1WE2NhKkxh6yKBrSnVbd0XBi3H2lWs9gp50QZpOoEX5JTryn4NaUXEqUciRceSY
         +qp+WDAvFoZur8ExGPrDtqX1hAkNJSqRzLLGLJ6zT6qu8ZrzyqceEbqwQU+aR9YdflX6
         RrdGaocZpxxcg14fN5c4ktfesDA8Mv/ZfFuh/OADeqwXNW3knnp97WNO5Kq/D9+UAlKo
         2f0NXMLNinxt/C0SnbfJuvz+tEMelEDRSI484j6MpqS92xMFaTUmLFSulkLgqXN4NTT6
         9O+T/mrYqXTy5C3zkdtSe22WK1N7RhPKVd+lyxWunOMkFelDCZ05HVwds/hvQjsivcza
         yIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZ6hA7jZWwq8nGDirM5J+yCglYW1lCb+6oIjgOHxcQ8=;
        b=NMnNIjQFbxTAuUY4J1j6lUJo0ENFLUAfGufj4MBK7eV6X/BdwqHtEgDoJEkLE44HWA
         5xrRXg6Bh4EFYHZLHSMp59TAmDCM+vSEBVTIuFxRpx+tLZk1TTRkKxZE7AgOVN4lg3xO
         qp8zv0YIQlAb/px37B4usim4X/aB9mWPBrUpyZjFTi4YdnsB4w75nF/P0ygQs7HPiOLo
         4J0dp89+kJOU9karMCcHcRPv/9uHNhLd1F1pOkNy7y9NETry3oeAHgLO0BOWKk/4uYNo
         ctc8E5mzpsewrd089NgPVeiVgyeqQ+KBWrCcL0p1pFVd2kIJ/NuX3lTTIGzsCyIALE++
         DxfQ==
X-Gm-Message-State: AODbwcC1OHLTtzJjxbGBy6TsvsOVKKllBySKkr1vSnsAQEc3nUAkRtEz
        Fv4nyaaGVZEn8A==
X-Received: by 10.223.145.162 with SMTP id 31mr7434818wri.43.1495316643903;
        Sat, 20 May 2017 14:44:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:44:03 -0700 (PDT)
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
Subject: [PATCH v3 29/30] grep: given --threads with NO_PTHREADS=YesPlease, warn
Date:   Sat, 20 May 2017 21:42:32 +0000
Message-Id: <20170520214233.7183-30-avarab@gmail.com>
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

Add a warning about missing thread support when grep.threads or
--threads is set to a non 0 (default) or 1 (no parallelism) value
under NO_PTHREADS=YesPlease.

This is for consistency with the index-pack & pack-objects commands,
which also take a --threads option & are configurable via
pack.threads, and have long warned about the same under
NO_PTHREADS=YesPlease.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c  | 13 +++++++++++++
 t/t7810-grep.sh | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index a191e2976b..3c721b75a5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -289,6 +289,17 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
+#ifdef NO_PTHREADS
+		else if (num_threads && num_threads != 1) {
+			/*
+			 * TRANSLATORS: %s is the configuration
+			 * variable for tweaking threads, currently
+			 * grep.threads
+			 */
+			warning(_("no threads support, ignoring %s"), var);
+			num_threads = 0;
+		}
+#endif
 	}
 
 	return st;
@@ -1229,6 +1240,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
 #else
+	if (num_threads)
+		warning(_("no threads support, ignoring --threads"));
 	num_threads = 0;
 #endif
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 561709ef6a..f106387820 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -791,6 +791,24 @@ do
 	"
 done
 
+test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=N or pack.threads=N warns when no pthreads' '
+	git grep --threads=2 Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	git -c grep.threads=2 grep Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep -F "no threads support, ignoring grep.threads" err &&
+	git -c grep.threads=2 grep --threads=4 Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep -F "no threads support, ignoring --threads" err &&
+	grep -F "no threads support, ignoring grep.threads" err &&
+	git -c grep.threads=0 grep --threads=0 Hello hello_world 2>err &&
+	test_line_count = 0 err
+'
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
2.13.0.303.g4ebf302169

