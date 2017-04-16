Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D4820D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbdDPWVn (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34909 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id d79so6501219wmi.2
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wCXn2XL4EY83wzLEMBmN68r+uQUilz1KXlCZwZ5wTRs=;
        b=sy6TvEeIDjtmtNG3Ki1Qxsq5S2TQP1ETp08NWK+kkg3nZHiwVIBXljFNzcGIWoBKy8
         gq3zrlZR74CFAWOjyLbrqgTCuQlM+5Q3zN29S+fD2qiOmDP4GAB+Nxs1SRrpLLFL6+RO
         qvgJuq2GjuT/1XZxVnqg6J1al7/aXBe+sbopZ9lR+WYZOQq5PtIvW0g0FdzeDeqWG8TD
         d/yt7AKrHDTV89KdGBwK1XyhgKkw6yDwqlNYgmHcQUFeJT5I8O3RMAPjPDGHKsElXZGr
         AAKbvDkDs3/5L98dEwKQxQ+sApqR/Lb4J2fb5RxadzUCAmP3S0SQWn2YxeU6xMwdrsTf
         jgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wCXn2XL4EY83wzLEMBmN68r+uQUilz1KXlCZwZ5wTRs=;
        b=guWFlILpPlOMF/w3yviKBt1yzC0k4TIghjLHRy+MJp0jUrFfzTWqigEx0XhOH15ucM
         +mkJXYeh5FbQ6m/NAPA3EyHGt0CGxNDmLgLsCO0rfMw6YIRrUETdkeoffRe4E7NboB7n
         mjGOB0+PFWPyU6mZx4HLXKumTC7s8XXaUCobTtkLIt+hX5Uhwir6ZqkZYoxKtv84aZ8D
         EKAvlUYSOUxO5STUxbKdyKigAgOwohPSyEi3pzTINC6xGN1f1MJvIfbIg5gNc7AMvvq6
         tQ8GzqyBqHgutWnOY7eT1qEiumtjRL+/VwO7HgHzHJ18CcCy4HcRqOC49kxWutEX0eIV
         Aryg==
X-Gm-Message-State: AN3rC/5Z1mON3wNLe2UOAjHHzXze4mlSdklPBZ3T9VjszKIupDgRKdq4
        qGzM2eXZKlGjig==
X-Received: by 10.28.125.137 with SMTP id y131mr6636466wmc.141.1492381300144;
        Sun, 16 Apr 2017 15:21:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:39 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] grep: given --threads with NO_PTHREADS=YesPlease, warn
Date:   Sun, 16 Apr 2017 22:21:02 +0000
Message-Id: <20170416222102.2320-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
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
 builtin/grep.c  |  8 ++++++++
 t/t7810-grep.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index cb3323060e..c746cdd33c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -290,6 +290,12 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 		if (num_threads < 0)
 			die(_("invalid number of threads specified (%d) for %s"),
 			    num_threads, var);
+#ifdef NO_PTHREADS
+		else if (num_threads && num_threads != 1) {
+			warning(_("no threads support, ignoring %s"), var);
+			num_threads = 0;
+		}
+#endif
 	}
 
 	return st;
@@ -1228,6 +1234,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (num_threads == 1)
 		num_threads = 0;
 #else
+	if (num_threads)
+		warning(_("no threads support, ignoring --threads"));
 	num_threads = 0;
 #endif
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 4523ca926b..f4c225b410 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -787,6 +787,24 @@ do
 	"
 done
 
+test_expect_success !PTHREADS,!GETTEXT_POISON 'grep --threads=N or pack.threads=N warns when no pthreads' '
+	git grep --threads=2 Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep "no threads support, ignoring --threads" err &&
+	git -c grep.threads=2 grep Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 1 warnings &&
+	grep "no threads support, ignoring grep\.threads" err &&
+	git -c grep.threads=2 grep --threads=4 Hello hello_world 2>err &&
+	grep ^warning: err >warnings &&
+	test_line_count = 2 warnings &&
+	grep "no threads support, ignoring --threads" err &&
+	grep "no threads support, ignoring grep\.threads" err &&
+	git -c grep.threads=0 grep --threads=0 Hello hello_world 2>err &&
+	test_line_count = 0 err
+'
+
 test_expect_success 'grep from a subdirectory to search wider area (1)' '
 	mkdir -p s &&
 	(
-- 
2.11.0

