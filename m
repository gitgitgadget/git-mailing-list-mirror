Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDE520188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758913AbdEMXRk (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33072 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758843AbdEMXRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id a46so11220909qte.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hH+tQYL47gD9RGYSujQSGXt7meJKxExSQ5cypYIa3Rs=;
        b=tVFN7U6kEl9hd4JI5e682E63ETJ37VmrRLi2wrjXv/QN85PshgBD7QirQocxptl4ZH
         w2uY60f5gF/STjdzcLFvW0UR0A7C7BnpSCt2zMhWA5yrQnt4kO9hTik5Oyxa1QbkYTGr
         wnN2a1XoV1gDCngJjmhX67WvYYIgdJgL5znmX+oRMJrIENLMtouHM1Rwy0iBi3yh4yXV
         zj2YSN1sZp6gR6tIRwD+6rJV+Eg2P346NcWi19vFrV+xJum10ePkNUoErTCQj73bnlSF
         H7z4cFt8RoKBUOuBYLge9XkjFnNvePGZejux412jMTNQL6f8fG8CDJ02Gxbdfk37A387
         pLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hH+tQYL47gD9RGYSujQSGXt7meJKxExSQ5cypYIa3Rs=;
        b=ShUgPAwvxE4xcLe/qtWu4IRlJtjbEGRRSVDkACJXQ2BOory2fAjJ976GMC/YDNSz7z
         7YMc3vDuAkfimthmqBsp0e17wdzizPwcVqXfQwVjy5riyN7Or4eHC/hjvxlcVep1uKaX
         eouJHloVKGdS9bzkNVhSTcSVrw54tw2VmcGXZ4sq1+EusmvsJ95dJnC/bSvVZC4KbclH
         EhdApqwOMAPSY3KF6TJ0c+5JIok64wmS9wTJDjB7vlZzZEVGI3EegONdOIzBxr5wXDSe
         X2+WIPtPxhjS6oW/yAUnAomGxTDb2l0d7SjEwt0ogNnuF4CRvSmPMItsPuWdR/HWNPnc
         uoAg==
X-Gm-Message-State: AODbwcC6yf8UcL4ppSWrxA1kgFrNcAtuCMOTunl8KR/OIDC+vC7mgTj2
        9m8ksHFWobnX7A==
X-Received: by 10.200.8.99 with SMTP id x32mr1435185qth.195.1494717452627;
        Sat, 13 May 2017 16:17:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:31 -0700 (PDT)
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
Subject: [PATCH v2 28/29] grep: given --threads with NO_PTHREADS=YesPlease, warn
Date:   Sat, 13 May 2017 23:15:08 +0000
Message-Id: <20170513231509.7834-29-avarab@gmail.com>
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
2.11.0

