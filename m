Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBB32B9A9
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730184; cv=none; b=T9Yvyck0j9kFSIgERJ4kC5sPuSI0CNNgTvJ8xSrcbTE4OPGdTwthBTwC3drbpmLbzJppcnXSk5/d0Ar4KsOtMY9443UywTMsx989fyUYmNmMdBZv7FeBwZw+GWR/Vh6/GaEokfsNO2AGwxDMC2UQ8JLpsDUHHZ5nFnOgvBG21Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730184; c=relaxed/simple;
	bh=IFjp7EqOhXy871eIhRwKZ06SMnVpBwdOAsqmnLij9r0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWYhcl4AOsZwJsCMKcwyGX3dUR7UPw1GM0L9MxanIQw0Hb149k0tn+E8PStVSRUZpTmK1EioztlZgT3QThr6J9T9sid6sEx1bqmKp8HjB6cGrO/u4/A2JOhxiFbX1dAb3IVtObScIUY4Cnwmy0hVaUuwG/dzueEDTRklNl7YZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbKOZdA1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbKOZdA1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35d90833cacso671461a91.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774730182; x=1775334982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhiJAhBPVMepi9cF4m/v5lNwz8sHwjpRLG5guGx2/lE=;
        b=NbKOZdA1ybpn2QTwJkHt5fGxaDOWxt4XgiJlN+Buc7AyfhTEcWcNcgnC5C3JX9aI1P
         q2GbCJCTltYZ9S9x4XWCmeqvquabBd5bUzlL/lcfT2LyQJuE3SqoiHgjoWe42P5+uQC7
         36JmaEhx5feJfDEbYqKFaEc9GnC9e/iWupuyLtwl7FgHhQuojEEpyxBitn+ErRQpWRB6
         HLPD8ZcBKrL6WB9MvLYqs9Xtl5lX1+Ba8fWlu5wBe2qu/uIQ69/Yf2xR9/as5LgHJiOx
         xUMFVIoKbo2sjXqoo0OA6yhCpwrMJuBGDLhX5XdEamg/R6u0WhHfhPoedY8u4fCjLX1N
         uw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774730182; x=1775334982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhiJAhBPVMepi9cF4m/v5lNwz8sHwjpRLG5guGx2/lE=;
        b=YFh91Fx73DQvphsywsO9lll29aqOwsvsZ6YDwl9UQRjGudm7OdeW2rypekW6UJ718e
         tEQoEHhWpaD2ZSthc+QEG/nocJCqPt7WCvXHL4MmWHtvhJaSUSwq6Ox9Wf6+loxs4rz2
         rxoAoNeKRy0kXD3GdpmhgR013fSrk9kONVTPRxWPShexe5sPM/xYAlsG4+iN67qCPWDQ
         r8QwUZfzkZk4AnGgvg3rijd85xR0wFBTvaK941hZmaEdFKOpG9PlQ4jAZGCfD8qsK/C3
         FuqcPaRLl9SdYlAhVcl0nyGtywb1pd4OIJxnl1OPf9+ERGNMaRucJk1UhLdUDWOUk0mc
         c2Hw==
X-Gm-Message-State: AOJu0YwciVWNBNgglD7uvK2d09IhehDeEBE5T3KuCE9EeqVJpR6UyUFf
	slJlfXbHEYahUXzBaTBtXfPsW08wPkqj1oA2vKKQi2DMo62MMvzXatAhqkQupQ==
X-Gm-Gg: ATEYQzxhpI3kRdZsJfC3Ivys88TD/0cv5Qov9iE8Y2IzUIYagl89CbxfZiSBJklS/Dv
	Tx6Uxek1eitfZJV+DNEu5DWHh4UpmpRxZ+UjKn8nfK1jEt1lCjyNuAfd1wbi6uhStR17CNl+ugK
	L0kejc9UsLw8mX3cWBKAjLxd6myB4WlfWrhemo7fJ/WPi1/plw4mZH/hQKXlygY9zccYn0ZxOT8
	fXBwf6B0Q3s2aZ8CH9kn65jXetDMHnyRb39yNaMkNd/htlXoiDjMlCXlbRao2yp2gYZOWvX8ZN2
	qaEEBbRyhbdX8iAqhQYlr01fESyJT2GbSstP78nJsZUkNAQdyrtPkfZGDwtymTTlInClcYv05uV
	4wvdx4jHPyBmhQihyfvZTlHFoUHIp3pIgaVpzklbsi4xnkQN7V69ChQ3NiRm8sOe1b8Vn6YuCBG
	Edq6m+yW9bYyrNISEEdnZs54DBmiAG12tPB72gR0WEKsRLJeNfWO/TLk7ZVnvRuuhxlsB9
X-Received: by 2002:a17:90b:2d81:b0:359:f0e1:f8c0 with SMTP id 98e67ed59e1d1-35c2ff263f9mr7425887a91.6.1774730181921;
        Sat, 28 Mar 2026 13:36:21 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:a0a6:2ae9:64a5:8a64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9507dc3bsm2735334a91.9.2026.03.28.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:36:21 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v1 1/1] cat-file: add use-mailmap/no-use-mailmap to --batch-command
Date: Sun, 29 Mar 2026 02:06:15 +0530
Message-ID: <20260328203615.60402-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-cat-file(1)'s --batch-command works with the --use-mailmap option,
but this option needs to be set when the process is created. This means
we cannot change this option mid-operation.

At GitLab, Gitaly caches git-cat-file processes and it would be useful
if --batch-command supported toggling mailmap dynamically with existing
processes.

Add `use-mailmap` and `no-use-mailmap` as new subcommands to
--batch-command. `use-mailmap` enables the mailmap mechanism for
subsequent `contents` and `info` commands, lazily loading the mailmap
data from disk on first invocation. `no-use-mailmap` disables it but
keeps the data in memory so re-enabling doesn't require reloading.

The subcommand names mirror the existing --use-mailmap/--no-use-mailmap
CLI options to keep the interface consistent.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
CI: https://gitlab.com/gitlab-org/git/-/pipelines/2415084557

 Documentation/git-cat-file.adoc |  9 +++++++
 builtin/cat-file.c              | 33 ++++++++++++++++++++---
 t/t4203-mailmap.sh              | 48 +++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index c139f55a16..03aadbbe89 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -174,6 +174,15 @@ flush::
 	since the beginning or since the last flush was issued. When `--buffer`
 	is used, no output will come until a `flush` is issued. When `--buffer`
 	is not used, commands are flushed each time without issuing `flush`.
+
+use-mailmap::
+	Enable mailmap for subsequent `contents` and `info` commands. If the
+	mailmap has not been loaded yet, it is read from disk at this point.
+
+no-use-mailmap::
+	Disable mailmap for subsequent `contents` and `info` commands. The
+	mailmap data is kept in memory so that a later `use-mailmap` command
+	does not need to reload it from disk.
 --
 +
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b6f12f41d6..7772d4d41b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -54,6 +54,7 @@ static const char *force_path;
 
 static struct string_list mailmap = STRING_LIST_INIT_NODUP;
 static int use_mailmap;
+static int mailmap_loaded;
 
 static char *replace_idents_using_mailmap(char *, size_t *);
 
@@ -692,6 +693,26 @@ static void parse_cmd_info(struct batch_options *opt,
 	batch_one_object(line, output, opt, data);
 }
 
+static void parse_cmd_use_mailmap(struct batch_options *opt UNUSED,
+				  const char *line UNUSED,
+				  struct strbuf *output UNUSED,
+				  struct expand_data *data UNUSED)
+{
+	if (!mailmap_loaded) {
+		read_mailmap(the_repository, &mailmap);
+		mailmap_loaded = 1;
+	}
+	use_mailmap = 1;
+}
+
+static void parse_cmd_disable_mailmap(struct batch_options *opt UNUSED,
+				      const char *line UNUSED,
+				      struct strbuf *output UNUSED,
+				      struct expand_data *data UNUSED)
+{
+	use_mailmap = 0;
+}
+
 static void dispatch_calls(struct batch_options *opt,
 		struct strbuf *output,
 		struct expand_data *data,
@@ -725,9 +746,11 @@ static const struct parse_cmd {
 	parse_cmd_fn_t fn;
 	unsigned takes_args;
 } commands[] = {
-	{ "contents", parse_cmd_contents, 1},
-	{ "info", parse_cmd_info, 1},
-	{ "flush", NULL, 0},
+	{ "contents", parse_cmd_contents, 1 },
+	{ "info", parse_cmd_info, 1 },
+	{ "flush", NULL, 0 },
+	{ "use-mailmap", parse_cmd_use_mailmap, 0 },
+	{ "no-use-mailmap", parse_cmd_disable_mailmap, 0 },
 };
 
 static void batch_objects_command(struct batch_options *opt,
@@ -1127,8 +1150,10 @@ int cmd_cat_file(int argc,
 	opt_cw = (opt == 'c' || opt == 'w');
 	opt_epts = (opt == 'e' || opt == 'p' || opt == 't' || opt == 's');
 
-	if (use_mailmap)
+	if (use_mailmap) {
 		read_mailmap(the_repository, &mailmap);
+		mailmap_loaded = 1;
+	}
 
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 74b7ddccb2..2ae063e5c3 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1133,6 +1133,54 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-command use-mailmap enables mailmap mid-stream' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "info HEAD\nuse-mailmap\ninfo HEAD\n" | git cat-file --batch-command >actual &&
+	echo $commit_sha commit $size_no_mailmap >expect &&
+	echo $commit_sha commit $size_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command no-use-mailmap disables mailmap mid-stream' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "use-mailmap\ninfo HEAD\nno-use-mailmap\ninfo HEAD\n" | git cat-file --batch-command >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command use-mailmap works in --buffer mode' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	commit_sha=$(git rev-parse HEAD) &&
+	git cat-file commit HEAD >commit_no_mailmap.out &&
+	git cat-file --use-mailmap commit HEAD >commit_mailmap.out &&
+	size_no_mailmap=$(wc -c <commit_no_mailmap.out) &&
+	size_mailmap=$(wc -c <commit_mailmap.out) &&
+	printf "use-mailmap\ninfo HEAD\nno-use-mailmap\ninfo HEAD\nflush\n" | git cat-file --batch-command --buffer >actual &&
+	echo $commit_sha commit $size_mailmap >expect &&
+	echo $commit_sha commit $size_no_mailmap >>expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git cat-file --mailmap works with different author and committer' '
 	test_when_finished "rm .mailmap" &&
 	cat >.mailmap <<-\EOF &&
-- 
2.51.0

