Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C66C1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755338AbdEKJUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34991 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755325AbdEKJUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id v4so5496096wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIw3tF5QWUbNvobOVPI54JAsML+27d5OleHenH5YPAk=;
        b=A8nX8Pro/Zrfn2qPFBj3/vyacOFidTUDzq2F6pYe98ZOTSsTJvNxEvqR2FYKV9Gh+L
         P+yhGiiK+x5L7ymC48P8+tdsu7T2nariZIrMkWV+CajSX1w5N5pseOzP/6hlPkWzplsZ
         pU5uhwsqmYvIofouAme2364FdY6/h/FQC/kiV/RVHus832A3PI3sSA74cYqOmki/NpTp
         IylLcZazFWsAbR4MiOtx5ZJOiaHxPpUL6XiGsf8unzNauQMJoPMfBwz06kjprHwnbB/l
         5p5ZmoWioMp3/bOgs/J3kL+BEns5aiu+Oob7XfL56UrR/F7N/uW1XgugToBkjssn7rTX
         0TqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIw3tF5QWUbNvobOVPI54JAsML+27d5OleHenH5YPAk=;
        b=X/3fNlmaHibLRNqO8YNct33ZTJM9hMKbfNYcJ/5XZzMwfekfj5kI6LVbRt5ldGvQL5
         Q51nZ1zaPhP9/MZkfV2RCBaCJ/AIKoJo3W91PbU9DcaYHm/8rNQOcoI3wWoAu6PSWfhZ
         YY93Sww7w7PocDtdBwRSeGZBosuX2CMz2ZQcvWY58w9Ogw1NytyjH09WT1gTGEzJwIp9
         +Gl8moFaVCwgn2kR79jR5rkWIo9iwPtfBrAGNfKyr0DorDDqKFRzSVXxeLiQCcybdAAZ
         uCjg/jIOGed9gxiGO4GrKH+VGbwvv68ipLAgk/0WFiwJGDrZ/LNzU71w9UMRdSe/Kg0P
         di3A==
X-Gm-Message-State: AODbwcCb6gf6Je9VvxuyGURYiaGrSeE23xoXodxqbWVIC99Ca//umV/0
        XUUOwza09K0WXQ==
X-Received: by 10.80.194.138 with SMTP id o10mr38578edf.94.1494494415154;
        Thu, 11 May 2017 02:20:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:14 -0700 (PDT)
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
Subject: [PATCH 28/29] grep: given --threads with NO_PTHREADS=YesPlease, warn
Date:   Thu, 11 May 2017 09:18:28 +0000
Message-Id: <20170511091829.5634-29-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
 builtin/grep.c  | 11 +++++++++++
 t/t7810-grep.sh | 18 ++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 1c0adb30f3..f4e08dd2b6 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -289,6 +289,15 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
+#ifdef NO_PTHREADS
+		else if (num_threads && num_threads != 1) {
+			/* TRANSLATORS: %s is the configuration
+			   variable for tweaking threads, currently
+			   grep.threads */
+			warning(_("no threads support, ignoring %s"), var);
+			num_threads = 0;
+		}
+#endif
 	}
 
 	return st;
@@ -1233,6 +1242,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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

