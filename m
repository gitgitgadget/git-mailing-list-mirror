Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A262713FD84
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848694; cv=none; b=pTA8NIkelkfwucjejNXAeXJqfZ6qn3nz/7ntW4w/T5dk0610m2vr6x4Ntuhi02O6Eso6YYrEM9UX0KQ48SThZLF2rstRFj4RlXxh5ZqD1W3ZMUsdNyJ5GAwb0GU5igEdZM9dM13vMkHMeLh6ZJ4AgFCmpNJNI5HQ87Iebqe43RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848694; c=relaxed/simple;
	bh=Feowbj5v/BtTESMhkt4OfojVMCkUovrwe8MwQMAyRmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIKAToaCeUkgGFIh7b6jQhX7Fglpv4PHimmwP6UcIzLOhRkztO+FFl6EkNL34elmjt20x8Ls80opwvyIWcmJyil5HP5uRfD/46U4P0ok03amtn0FiAIxbO79AxGMbWR//NJdq/Ilx0Rt3KsDDDgOcD/vWipVa/enUBDSUAUHj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b927Lwyv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b927Lwyv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fec34f94abso24544315ad.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723848690; x=1724453490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VcODOGt07b8AMASSLj6onrA1EheBLLlI8m747MQ6zY=;
        b=b927LwyvgCPtmUeIPiMxF1twgURqhvLkpfRfwSNHZ+bvr9r2Z0d3dmitiDzD5CJcwf
         TB7h+E5oIiv1IH9WFklwk2GS1ZECfp07X8+IyY8dsKUJY51oxNltNx4X+I8SrdkHhHUU
         8KtSah2Ht3fsumRijQQ/UyxJtR7AIbO9PBk7hfIxH/bjIUVSZjjOSq7nycEKuiirGmuT
         tsfe8tq8UWAxWItnvDQ0nVrZfAud5dgjky5T2u8eCliP07ZlEfzvGS+fkppUiEZ5U8VG
         E8RueDoh/s1K/tRTbPqsVr+G59BgnbLJXta+ZAky8Ozw8z8YcvmgKA7RlYfwn74uOptd
         QOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723848690; x=1724453490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VcODOGt07b8AMASSLj6onrA1EheBLLlI8m747MQ6zY=;
        b=cuHIlURifcOooBxf9D/CjArv/ss6NFPAYfgiGCJB6vPqS1YCXZzygrkaFdDG5QKeVu
         VwTJIwKZT/cq+lAeHLV3WeRi8bUqwPS+hdBw+SZnqFCPpuU2fg0MqeCdmFpYKf6YkdJ4
         jTkEGuKxAlMbTi0aco7ozqPjBaBSZkrPCxDaQhitkBK279QmRfyfb8k/E6sglEdKFtWK
         ywBf/FTBof2wc128GcF2jM83uVHI454fzwA+NqgIKfgd5/qhxiZAyJKoSAstpgC19ghd
         wEJq6JZfRnmeByKMyY8MtaFcdCUVxKE/DlJnQfr3mJrKbPKGSIV7PijMizf40b/RWXaM
         Yf3w==
X-Gm-Message-State: AOJu0Yw+9ODXFR1FBIhUn015bVy2illAN/OCJk/8fGo8ozfBoGGSa/Xo
	F6XXcY4RbzyI+VNUBRF4HP5k5NT7yK9Bpid5V3X7mQipmvMFOoEBLRaYQgWA
X-Google-Smtp-Source: AGHT+IG3UgJlSB/C+f25HGGe/ZSYCzm3w6y+23mnc5c1ir2JipBIxc6V2nqrKE5TqOh2hd+bWLqqpA==
X-Received: by 2002:a17:903:360e:b0:1fb:8419:8384 with SMTP id d9443c01a7336-20203e4c4b0mr52812515ad.13.1723848690463;
        Fri, 16 Aug 2024 15:51:30 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037903csm30013165ad.125.2024.08.16.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 15:51:30 -0700 (PDT)
From: Matheus Tavares <matheus.tavb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	johannes.schindelin@gmx.de,
	newren@gmail.com,
	ps@pks.im,
	Lincoln Yuji <lincolnyuji@hotmail.com>,
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Subject: [PATCH v2] rebase -x: don't print "Executing:" msgs with --quiet
Date: Fri, 16 Aug 2024 19:48:30 -0300
Message-ID: <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
References: <767ea219e3365303535c8b5f0d8eadb28b5e872e.1723778779.git.matheus.tavb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`rebase --exec` doesn't obey --quiet and ends up printing a few messages
about the command being executed:

  git rebase HEAD~3 --quiet --exec "printf foo >/dev/null"
  Executing: printf foo >/dev/null
  Executing: printf foo >/dev/null
  Executing: printf foo >/dev/null

Let's fix that.

Reported-by: Lincoln Yuji <lincolnyuji@hotmail.com>
Reported-by: Rodrigo Siqueira <siqueirajordao@riseup.net>
Signed-off-by: Matheus Tavares <matheus.tavb@gmail.com>
---
Changes in v2:
- Applied commit message fixes by Patrick.
- Fixed codestyle.
- Added regression test.
- Also checked "!opt->quiet" before calling term_clear_line() (this
  would only print whitspaces, so no direct impact for users, but the
  bytes are still there when the output is captured by scripts, like the
  test script :)
- Added Lincoln as one of the reporters.

 sequencer.c       | 13 +++++++------
 t/t3400-rebase.sh |  7 +++++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..79d577e676 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3793,12 +3793,13 @@ static int error_failed_squash(struct repository *r,
 	return error_with_patch(r, commit, subject, subject_len, opts, 1, 0);
 }
 
-static int do_exec(struct repository *r, const char *command_line)
+static int do_exec(struct repository *r, const char *command_line, int quiet)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int dirty, status;
 
-	fprintf(stderr, _("Executing: %s\n"), command_line);
+	if (!quiet)
+		fprintf(stderr, _("Executing: %s\n"), command_line);
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
@@ -4902,7 +4903,7 @@ static int pick_one_commit(struct repository *r,
 	if (item->command == TODO_EDIT) {
 		struct commit *commit = item->commit;
 		if (!res) {
-			if (!opts->verbose)
+			if (!opts->quiet && !opts->verbose)
 				term_clear_line();
 			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
 				short_commit_name(r, commit), item->arg_len, arg);
@@ -4994,7 +4995,7 @@ static int pick_commits(struct repository *r,
 					NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK) {
-				if (!opts->verbose)
+				if (!opts->quiet && !opts->verbose)
 					term_clear_line();
 				return stopped_at_head(r);
 			}
@@ -5010,10 +5011,10 @@ static int pick_commits(struct repository *r,
 			char *end_of_arg = (char *)(arg + item->arg_len);
 			int saved = *end_of_arg;
 
-			if (!opts->verbose)
+			if (!opts->quiet && !opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg);
+			res = do_exec(r, arg, opts->quiet);
 			*end_of_arg = saved;
 
 			if (res) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ae34bfad60..15b3228c6e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -235,6 +235,13 @@ test_expect_success 'rebase --merge -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'rebase --exec -q is quiet' '
+	git checkout -B quiet topic &&
+	git rebase --exec true -q main >output.out 2>&1 &&
+	test_must_be_empty output.out
+	
+'
+
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
 		echo "One" &&
-- 
2.46.0

