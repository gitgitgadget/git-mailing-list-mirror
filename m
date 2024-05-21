Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32620763F1
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324742; cv=none; b=gRbd8RwhoT04hZ9r6436yeOl/Oe51dt+1DofL/JyxS9Gk8bddP5NwegQB5tUGEu6kqy1O1x5oTAuBuXfOcagbK/3Rz21/JRVuauQ9+1SNSrdyZtU6MkPOCeTx+aTamZ5TkvPvHSEp+7AtJHnlgrMOqZC94LIujr1iq7rg7Hsekw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324742; c=relaxed/simple;
	bh=iqBOs8DT9GaSkaqy3g+vIiVlfwVXtXCSUyAmyEaDm+Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NTOe7t3qr9oXs1T8LWK0TU7ALYBWaX7+epa/i2dUYAWltM1vt9y2LZHM3601VLQ4WPooE5nke+EOdbgh3q8VqpjivZIqug4yQwW+aJkwd0K6lXbE4rlYmUrST/57VmNt8woo6YdEl6xF9j0Z+joZi4ifzt89EQGuGsSLKlzZ7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/Iu9i8F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Iu9i8F"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4202959b060so35482985e9.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324739; x=1716929539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gjnudgJGmP4oQDQgLZzorRp/oTK/o7tt7fjnhkD2yds=;
        b=d/Iu9i8F6m9CH+jJZtr8Y3MshfRZh2UJFoHkLgpfZ8ItbqfROUp/LoHdHyAlyuDh4r
         ueQe3DcOFmSRCBt18HfC51z964N7zgVTF2FCLVn14luorh9fKn+nLYewCj9Ovxn/CsM9
         oWqpavxsh5wg/GrfNdI6EKMzDdPvqmNiwYVUurLYDKBu8W7gndZsYZUZem7ISGjo7+Wn
         Uiee27m5Ps58qcV5FKpBqv3Cji4Xr9wGDLe5JUJ4D628JF9HrSidNWg6UWG//gd7QmHu
         3GZvX5GLOdh8VHe+LBMhulIZ11FWYXrOh/qFlum3/8KjypqxBYGN24w5alByX7Zg/JBT
         S4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324739; x=1716929539;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjnudgJGmP4oQDQgLZzorRp/oTK/o7tt7fjnhkD2yds=;
        b=HY/x2qNVFOK/yYisIRPAg0cIY2GH2zn4/iiG+rtOcawYZIhRqgXVWqc+pZxHkQ3x/V
         1Skq7LcI+TfW0LgDoGRxB1uMS9oXSWbLpP1fpdMwAu3ipbMVDcdCzNhizgq5P7GgPBQb
         A8UTkwumdmoyO7QTe3IRzSafjmYch4u6ksfVCgkb+w02gpCQ+VHu4kJpezKRr2jgfcK9
         pFN80WY52q168q10PLHlfWU6RV4lHVxjLTsdbcuNUXn56Sc4Ggu+mTjMixTImIWSQhab
         6UN86O/YigNNYksxXy0MoOcL8m9NdNt+AMRtxpGk1maQp5pn37sXrCDMyZsCFMEwEivr
         Wf7g==
X-Gm-Message-State: AOJu0YwZlHI2LeNSW1bhQBMlMB5WgMltA7PyvyOMToYOVjTlhTl5BasN
	zH+WrrlT5MvaMH9qoTGlAu5yh+hqvtIG1WCpVZohqtRAw9HcSoAZ1qNKRw==
X-Google-Smtp-Source: AGHT+IGYBHZhvNU8y7PY0cI/7jigHzPLNPkdxrZF+f8n0lDruNZ3rc82a+mW47qIVio/3UdCouI8cw==
X-Received: by 2002:a05:600c:35c1:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-420fd33ab20mr210975e9.30.1716324739517;
        Tue, 21 May 2024 13:52:19 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccfe15b6sm461738895e9.47.2024.05.21.13.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:52:19 -0700 (PDT)
Message-ID: <217c246b-2c28-4acf-8614-ce66ad345437@gmail.com>
Date: Tue, 21 May 2024 22:52:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/5] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Language: en-US
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since f67b45f862 (Introduce trivial new pager.c helper infrastructure,
2006-02-28) we have the machinery to send our output to a pager.

That machinery, once set up, does not allow us to regain the original
stdio streams.

In the interactive commands (i.e.: add -p) we want to use the pager for
some output, while maintaining the interaction with the user.

Modify the pager machinery so that we can use setup_pager and, once
we've finished sending the desired output for the pager, wait for the
pager termination using a new function wait_for_pager.   Make this
function reset the pager machinery before returning.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 37 +++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 3ef6798f7e..2fa06c43c4 100644
--- a/pager.c
+++ b/pager.c
@@ -14,12 +14,11 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
-static int old_fd2 = -1;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
 
-
 static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
@@ -30,14 +29,35 @@ static void close_pager_fds(void)
 
 static void wait_for_pager_atexit(void)
 {
+	if (old_fd1 == -1)
+		return;
+
 	fflush(stdout);
 	fflush(stderr);
 	close_pager_fds();
 	finish_command(&pager_process);
 }
 
+void wait_for_pager(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	wait_for_pager_atexit();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
+		old_fd2 = -1;
+	}
+}
+
 static void wait_for_pager_signal(int signo)
 {
+	if (old_fd1 == -1)
+		return;
+
 	close_pager_fds();
 	finish_command_in_signal(&pager_process);
 	sigchain_pop(signo);
@@ -113,11 +133,14 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
 		return;
 
+	assert(old_fd1 == -1);
+
 	/*
 	 * After we redirect standard output, we won't be able to use an ioctl
 	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
@@ -142,16 +165,18 @@ void setup_pager(void)
 		return;
 
 	/* original process continues, but writes to the pipe */
+	old_fd1 = dup(1);
 	dup2(pager_process.in, 1);
 	if (isatty(2)) {
-		old_fd2 = 1;
+		old_fd2 = dup(2);
 		dup2(pager_process.in, 2);
 	}
 	close(pager_process.in);
 
-	/* this makes sure that the parent terminates after the pager */
-	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+	if (!once++) {
+		sigchain_push_common(wait_for_pager_signal);
+		atexit(wait_for_pager_atexit);
+	}
 }
 
 int pager_in_use(void)
diff --git a/pager.h b/pager.h
index b77433026d..103ecac476 100644
--- a/pager.h
+++ b/pager.h
@@ -5,6 +5,7 @@ struct child_process;
 
 const char *git_pager(int stdout_is_tty);
 void setup_pager(void);
+void wait_for_pager(void);
 int pager_in_use(void);
 int term_columns(void);
 void term_clear_line(void);
-- 
2.45.1.221.gd3c11dbb1d
