Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F81E209FD
	for <e@80x24.org>; Thu, 25 May 2017 19:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036749AbdEYTrp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35498 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970191AbdEYTrf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so35876324wmc.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZ6hA7jZWwq8nGDirM5J+yCglYW1lCb+6oIjgOHxcQ8=;
        b=OYs0Lx5O/uzGWwlJ1ws/5cJ9lsb5JMwVSEud3LAj7YKMWX7iZg32wMtGRMVKDM6+eB
         b0uZsHNojQDhSuraLi/dLDdxHVg4ZhyA8glHxjVn0lzefFMBWincpZbKAKALRdnZEUd+
         GnsqzkVJGwKexTFMXC/NGz1Tp6C/YfAzAevuAtsW2WQ49vSAUG1HpTwBTji8LP0i3fuo
         22942eoSQBa8r24cXewFJMsEADjJ71isczgIV2hBq3UaXravfSw9mv7qFq1W5HYSf6SC
         POocTGl/7RkG80oBDI1RFvpKIssWcWLvahhymrCCx4s9fUI6We6aFgEcWRIO4rv/90Qz
         wK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZ6hA7jZWwq8nGDirM5J+yCglYW1lCb+6oIjgOHxcQ8=;
        b=leTp17UeK9iWAE1OV1oVzvTUwdAvxu5MGMtjXZ85qIAxCLAJxXu/hCdelzDp0VBNYy
         1LsdyrbBetxXuQ7BWSFdEgT1eXLYOIgISGa6MBN9j6EDbZ8IMg599Uqt+kIxnsXaY//P
         r6Dht363ZsphxknPcHzi7Va7qzdsmX8/mgDKG+C0U80d6ltsALd8D4JIQg0cLwoQv6iT
         gfnQCrjIPNurI8U52198nqCVxnl21Kzr7kHpOj9lT8X9xcDUqEdLz/D374yRPLkRchR8
         IjqnuQnJbkTbAbxcb8BgIBe8Udi8bPhNbSk7W7R0HIY+0sVy0fhDg7tN9kETlf6fMbRH
         VZaw==
X-Gm-Message-State: AODbwcBEAFfbz0baNzrTps9JWMEO4H5jVlmYrcNTQz6eir3PwS7vklZq
        DTqERiB6ICGpcQ==
X-Received: by 10.223.160.240 with SMTP id n45mr28910875wrn.198.1495741653794;
        Thu, 25 May 2017 12:47:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:32 -0700 (PDT)
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
Subject: [PATCH v4 30/31] grep: given --threads with NO_PTHREADS=YesPlease, warn
Date:   Thu, 25 May 2017 19:45:34 +0000
Message-Id: <20170525194535.9324-31-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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

