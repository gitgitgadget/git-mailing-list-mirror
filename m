Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3203920970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbdDHNZv (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:25:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34248 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbdDHNZt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:25:49 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so15463045wrc.1
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HBbFCsErfFGyWcs0XUiWpheZf1BN7vPyg6uNOhxsBAc=;
        b=myIrLNLDOHEp9Ts9uKr34XMe7mcnSvIyhM6L3MSE1NJ7LA5UWxjVeZDwOtnLwtV62U
         814goRLs2ZgP6/2FNZsKMGlxz+Ts8aGkX7aJw8WIVmB/drLTlCvP5pxLvU3I1H623Zd+
         pSUlzGj7JbjYkw6x7ks1curSManChxYrEcHpkIl2rODUxP/mftav4klxWZzbojj0DhQ6
         vYP2j9YItmh9lBdhsfxYqxQ0GSB7nT1lM/GheVnewXJ61GzwF8COAl+IBuCW334SZPYM
         BVwWBYDpiAJx6goNCCmB48+rrFe2WTYqxfYvUcuKl7wUAR+O8rD6rBHMN3lDmNwpvSr0
         zgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HBbFCsErfFGyWcs0XUiWpheZf1BN7vPyg6uNOhxsBAc=;
        b=ONvuo5AinH4ML2EACgyRCiwGDKldWweuHZ1P3PE2wkdPcQRT4RvIeBr7vtZ7FSw6ks
         C9F5XCd0rQr/1TZ+GyiOUKBuAJ7d1Wtu3pPznJhHaJo/a7UfXSZcPH4I8zmJLy9qy6Az
         K9ztVdjaN4gONqYD2KBLL9oOvr5gxAyg4OiQ/8hArqHSSgwaBN7HOIwaRnn6rHZwU8mI
         9TEvcBuoBNrhdpBmtksqKqptBiniv4Prl29Rcro4uVmc6VOIX9Gyos6SiY9ym5laKfdc
         HE9HCqLavRxWKyymqQzCUBnliqI1hfHXW1NID5IQv9L+PW+zKmvBplDupAMYlZLdnD3D
         JkrQ==
X-Gm-Message-State: AFeK/H07JT0ITeed7w8MgqrBH4pgLocZyuiE6XcWVVYLO000XmVbc6uYGwIxy0OROF5F6Q==
X-Received: by 10.223.177.219 with SMTP id r27mr42845328wra.194.1491657947823;
        Sat, 08 Apr 2017 06:25:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:25:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/12] grep: add ability to disable threading with --threads=0 or grep.threads=0
Date:   Sat,  8 Apr 2017 13:24:55 +0000
Message-Id: <20170408132506.5415-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to entirely disable threading by having grep.threads=0
in the config or --threads=0 on the command-line.

This was made configurable in commit 89f09dd34e ("grep: add
--threads=<num> option and grep.threads configuration",
2015-12-15). Before that change there was no way to disable threaded
grep other than to recompile Git.

It's very useful for testing & debugging to be able to entirely
disable threading without recompiling with NO_PTHREADS=YesPlease, so
support setting the value to 0 to disable threading.

There was no reason this wasn't the case already other than an
implementation detail in how OPT_INTEGER() works. When it's used
there's no way to tell the difference between an unset value & the
default value. Use OPT_CALLBACK() instead using the same pattern as in
commit b16a991c1b ("cherry-pick: detect bogus arguments to
--mainline", 2017-03-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-grep.txt |  4 ++--
 builtin/grep.c             | 26 ++++++++++++++++++++++----
 t/t7810-grep.sh            | 10 ++++++++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 71f32f3508..7b52e3fbc4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -56,8 +56,8 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.  If unset (or set to 0),
-	8 threads are used by default (for now).
+	Number of grep worker threads to use.  If unset, 8 threads are
+	used by default (for now). Set to 0 to disable threading.
 
 grep.fullName::
 	If set to true, enable `--full-name` option by default.
diff --git a/builtin/grep.c b/builtin/grep.c
index 65070c52fc..9478ab5dff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -35,7 +35,7 @@ static int grep_submodule_launch(struct grep_opt *opt,
 				 const struct grep_source *gs);
 
 #define GREP_NUM_THREADS_DEFAULT 8
-static int num_threads;
+static int num_threads = -1;
 
 #ifndef NO_PTHREADS
 static pthread_t *threads;
@@ -897,6 +897,24 @@ static int context_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int thread_callback(const struct option *opt,
+			   const char *arg, int unset)
+{
+	int *threads = (int*)opt->value;
+	char *end;
+
+	if (unset) {
+		*threads = GREP_NUM_THREADS_DEFAULT;
+		return 0;
+	}
+
+	*threads = strtol(arg, &end, 10);
+	if (*end || *threads < 0)
+		return opterror(opt, "invalid number of threads specified", 0);
+
+	return 0;
+}
+
 static int file_callback(const struct option *opt, const char *arg, int unset)
 {
 	struct grep_opt *grep_opt = opt->value;
@@ -1049,8 +1067,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines before matches")),
 		OPT_INTEGER('A', "after-context", &opt.post_context,
 			N_("show <n> context lines after matches")),
-		OPT_INTEGER(0, "threads", &num_threads,
-			N_("use <n> worker threads")),
+		OPT_CALLBACK(0, "threads", &num_threads, N_("n"),
+			N_("use <n> worker threads"), thread_callback),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
 		OPT_BOOL('p', "show-function", &opt.funcname,
@@ -1222,7 +1240,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 #ifndef NO_PTHREADS
 	if (list.nr || cached || show_in_pager)
 		num_threads = 0;
-	else if (num_threads == 0)
+	else if (num_threads == -1)
 		num_threads = GREP_NUM_THREADS_DEFAULT;
 	else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index cee42097b0..53c2ca05c4 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1505,4 +1505,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep with thread options' '
+	git -c grep.threads=4 grep st.*dio &&
+	git grep --threads=4 st.*dio &&
+	git -c grep.threads=4 grep --threads=6 st.*dio &&
+	test_must_fail git -c grep.threads=-1 grep st.*dio &&
+	test_must_fail git -c grep.threads=-1 grep --threads=-1 st.*dio &&
+	test_must_fail git -c grep.threads=-1 grep --threads=1 st.*dio &&
+	test_must_fail git -c grep.threads=1 grep --threads=-1 st.*dio
+'
+
 test_done
-- 
2.11.0

