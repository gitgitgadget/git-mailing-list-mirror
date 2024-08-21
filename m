Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341FC15B
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204015; cv=none; b=XGnN7TDhih/HMvDPB9O4oTtGCrzaO1LPkdyS1u2bkx2oOc+m9F/lyehcKC7muq53CRMBtMukpKQOoQDnzzayIf0pIBEdj+9Dxnswpn7imCwkLGxVU5g+nXTSBSlHSQJh5GfZpzYuVh9yZ3BVfT14+ll3cuprWOgv2eJ6S2HrO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204015; c=relaxed/simple;
	bh=T2bwCi2V1Xi8Z249ncJ0wGdO1TqFr6AQAVvlIjYOBao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKL/aq/yt74atYX7nwKNC4uIzA9SlQK7B/kRqre/cbNppCUek9YKNwAHVr2wwe210w4woI84CIsIldesKLWmHqr71oQXJdAejSNKuOHUCAIs74aU+UW+hbJAo7UGcjY3iG+WTMJlbIXBqW6Ie7pszylHvS6yro88/bq9qS0+11s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/oqrog/; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/oqrog/"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5b850d969so3835714eaf.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724204013; x=1724808813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr2cFFbuoXqD1yTGzw9hhePS7Clw+15+f62Cmn14uwY=;
        b=B/oqrog/eRfb4ovN/OK11YjXMXV2sTPRAuqsPyOrC+MwLfVPu2q+ahua8QFwoQygw1
         RoHt0MqffYKsTIsNGn0X5808KPuzuAF+TY4crVJqNcF4l2a9LM8buPqaje8qNi2L3nFA
         vaLeQseUKzV5qPsIbMMUKIc6PczdWbHClKmhqhpUNeNbofkaxZOg17zAaEXjE8yuPdDS
         WF3K414tgYBdZqe0+rHze89Quu8RL27CPv4wCv4ClEtFov68qdbGBhCluT8pP9lo/+ia
         TOGmFt0Je0T3yG8u7NCsYJroMShQGOPPynFEaRENBuUuH8eDL/KT/tHss1p7UMRGhF9W
         0/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724204013; x=1724808813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr2cFFbuoXqD1yTGzw9hhePS7Clw+15+f62Cmn14uwY=;
        b=TAsRFvjQ7SFQ9k8FDUA5NkK2nxwMU3xXBWAxuZ5eK9nvJrEPTPr5IcGLSbhkRRYZWF
         Mj3DyAUWe8IgFZTWxKbC6hUVMv3RI+pOeSmTEAR3C8ayOQU8OiuwBMXkS6oBmS26qCgG
         xb+ir0dRlNDLjxsDFPxBXIAmgggJC7wezcb3cFjM1AZS4NLXfRVOMdiTF4W8aA13spWi
         qYrJXIngym1DW8cGdQ+FEYwXr+Ys9hXLesShvaF7rqumfXnpxk5Y4XgVTB7SWydHRO4v
         KCeoVACENHNS9ID2W+fqSX0D7w0x5tlnedDax8W/fglTHSVHGV8Hd/1zqGWGEXzqR60h
         MFjA==
X-Gm-Message-State: AOJu0YzxyJg02bW5QYDgJsd1daAsNmQyFm107O7NQetIK5d+CAW+a5P8
	V+0cxks6cLEMs2mMpiZHJxY8clfgBhbE9JDZgyMjFyl/4vuRH2Xiq3CFJbD+
X-Google-Smtp-Source: AGHT+IE0tp1q1TkUtswDtOfkirid+Yeg5WXaMaB/G1pCbR/lxCU2EZeJ7KZmfVCzLp6E/q+ncoH/Hg==
X-Received: by 2002:a05:6358:d28:b0:1b3:9413:fa6f with SMTP id e5c5f4694b2df-1b5a264c579mr89319755d.3.1724204012672;
        Tue, 20 Aug 2024 18:33:32 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714269a1c6csm61807b3a.166.2024.08.20.18.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 18:33:32 -0700 (PDT)
From: Matheus Tavares <matheus.tavb@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	johannes.schindelin@gmx.de,
	newren@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com,
	Lincoln Yuji <lincolnyuji@hotmail.com>,
	Rodrigo Siqueira <siqueirajordao@riseup.net>
Subject: [PATCH v3] rebase --exec: respect --quiet
Date: Tue, 20 Aug 2024 22:31:52 -0300
Message-ID: <f105b34b8e6b33448f4d0ef07d51b7bbf4e71aaa.1724203912.git.matheus.tavb@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
References: <be3c968b0d9085843cd9ce67e85aadfaaafa69c8.1723848510.git.matheus.tavb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rebase --exec doesn't obey --quiet and ends up printing messages about
the command being executed:

  git rebase HEAD~3 --quiet --exec true
  Executing: true
  Executing: true
  Executing: true

Let's fix that by omitting the "Executing" messages when using --quiet.

Furthermore, the sequencer code includes a few calls to
term_clear_line(), which prints a special character sequence to erase
the previous line displayed on stderr (even when nothing was printed
yet). For an user running the command interactively, the net effect of
calling this function with or without --quiet is the same as the
characters are invisible in the terminal. However, when redirecting the
output to a file or piping to another command, the presence of these
invisible characters is noticeable, and it may break user expectation as
--quiet is not being respected.

We could skip the term_clear_line() calls when --quiet is used, like we
are doing with the "Executing" messages, but it makes much more sense to
condition the line cleaning upon stderr being TTY, since these
characters are really only useful for TTY outputs.

The added test checks for both these two changes.

Reported-by: Lincoln Yuji <lincolnyuji@hotmail.com>
Reported-by: Rodrigo Siqueira <siqueirajordao@riseup.net>
Signed-off-by: Matheus Tavares <matheus.tavb@gmail.com>
---

Changes in v3:
- Skipped term_clean_line() when stderr is not a TTY.
- Removed the !opts->quiet condition when calling term_clean_line().
- Reworded commit message to better explain the proposed changes.

 pager.c           | 2 ++
 sequencer.c       | 7 ++++---
 t/t3400-rebase.sh | 6 ++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/pager.c b/pager.c
index 896f40fcd2..9c24ce6263 100644
--- a/pager.c
+++ b/pager.c
@@ -234,6 +234,8 @@ int term_columns(void)
  */
 void term_clear_line(void)
 {
+	if (!isatty(2))
+		return;
 	if (is_terminal_dumb())
 		/*
 		 * Fall back to print a terminal width worth of space
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..65c485d783 100644
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
@@ -5013,7 +5014,7 @@ static int pick_commits(struct repository *r,
 			if (!opts->verbose)
 				term_clear_line();
 			*end_of_arg = '\0';
-			res = do_exec(r, arg);
+			res = do_exec(r, arg, opts->quiet);
 			*end_of_arg = saved;
 
 			if (res) {
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index ae34bfad60..bd8bcc381a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -235,6 +235,12 @@ test_expect_success 'rebase --merge -q is quiet' '
 	test_must_be_empty output.out
 '
 
+test_expect_success 'rebase --exec -q is quiet' '
+	git checkout -B quiet topic &&
+	git rebase --exec true -q main >output.out 2>&1 &&
+	test_must_be_empty output.out
+'
+
 test_expect_success 'Rebase a commit that sprinkles CRs in' '
 	(
 		echo "One" &&
-- 
2.46.0

