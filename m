Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1813959D
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720888186; cv=none; b=IenauaG1zcW/TZQsNBIRI9g805s2PK1PeszdNpNUMtBEgk/YGrJ1uEeJllWp60DNrGXIxoPCvWXIN5ps4WoNFwLtajlcIQ9BfBbSUcKdiWm1k4DmyZfjVUT/iRQZ4L0e/Xg4mZbk3SHn+r79pmtiFuPO9/lm+G9srafM6zxmwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720888186; c=relaxed/simple;
	bh=KEW587wBor73RCDzF+PYRSDfC22OmsaxLQ+CIpeBPxU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A9AVN+xTSdQc/waaCkXLtfp3cnkikwRVBjiK1Yu6LtiVhE5N7kCoDBQ3UkOzsZbuIv7VZfQkIAlLSszN7dJ/oimpY5YTryohvPi3HP5DW+1szhyMh+z7IN4hMOKfcFw1b3sxLQBQfbdoBcqVGt/MQnyogzWyOcbPRLZMArV3CoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcZcEeW9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcZcEeW9"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso18709275ad.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720888184; x=1721492984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wvX/YC8p4IqHeNgNTcojCB8AT7x7NGKf0b7lGRYQZ0=;
        b=RcZcEeW9AlJetAdoRZQFIVx7eCg4IweFhQltCGnY4XUMGznmAct775/AaU619l71RT
         vyf192M+aclog7vNn3ej9wg+VWrtPAlS7LJHv4R8qBWtmE1cGsP0Qvkru/Ipu0WriLu/
         qh5fo+fPX1zz0BxvJXKGFcGRFBgocnNZYJZsSCg0avpDzahZipjxEgqk+jQh6N5hsFqm
         zUmLgJlGNEUZDyHCaaHvAyyEK13gj8MEApXdH4a8PZcipAfgT2BfbHOyO0v6Q5ReVMf0
         VEAo5L7dp+o6zZ7twSGKNDVUx8KwMrPsvqgAg9dSXx/XKHsWGAvwC/JYiyxlYdHXP7nz
         yg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720888184; x=1721492984;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wvX/YC8p4IqHeNgNTcojCB8AT7x7NGKf0b7lGRYQZ0=;
        b=PTgC7IH/RmG1+3o1qcWa2ZwjV9YcbY5xIMGI31aTwzfoy0iGgwLuGQ2qk2uW85LCwU
         QKd6RDVdFnnqGu01yzhIPveiLXYeSf99jj0h+wm8fEzCDDhjzjkWSI5fLcVx90B+O1za
         VSc890QCITLXAQcJ9Ir2chnFMc4eW0yHq+M+yOjK20LMBcML80zgTQTdCvYiMXQMPnv0
         QE2INLs6/qbrv1cPiVIU1PQqRaO2YAjnU8Ev/qjRhiz2orL8jglCVhTk3If/oZN17L/h
         h6Ee410qhgjI2tLHYTt9xa8lsY6bjXtVi9xJufFfO+E/53VoJnBXWWa1nE6BBstd7kr5
         wQeg==
X-Gm-Message-State: AOJu0YzJ14bnNhbvuZl2xg7F1R4npMJ/HI7Zy5OVNx+Suzyvtfl52K1h
	mGT06cMFx2MaUq0OE3Fjz7bgSaolpXg+PlFCWOwJ9xBLZ6T7/+EsU9OFlg==
X-Google-Smtp-Source: AGHT+IG4QOttbU9rg0Lgdw2XYe4ul53Kp2bYgZ6qshG5tf/cezlNH8m2Mu0NdLrLwc4NB4gMdhUTtg==
X-Received: by 2002:a17:902:d50e:b0:1f7:167d:e291 with SMTP id d9443c01a7336-1fbb6d5ff5emr133721735ad.47.1720888184217;
        Sat, 13 Jul 2024 09:29:44 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2b92csm12135145ad.179.2024.07.13.09.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jul 2024 09:29:43 -0700 (PDT)
Message-ID: <205b0e27-7507-4a95-b239-818bd018c846@gmail.com>
Date: Sun, 14 Jul 2024 01:29:41 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/4] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
 <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
Content-Language: en-US
In-Reply-To: <ebcba08f-3fbb-4130-93eb-d0e62bfe0a8a@gmail.com>
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
 pager.c | 43 +++++++++++++++++++++++++++++++++++++------
 pager.h |  1 +
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/pager.c b/pager.c
index 251adfc2ad..bea4345f6f 100644
--- a/pager.c
+++ b/pager.c
@@ -14,7 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static char *pager_program;
-static int close_fd2;
+static int old_fd1 = -1, old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -24,11 +24,11 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	if (close_fd2)
+	if (old_fd2 != -1)
 		close(2);
 }
 
-static void wait_for_pager_atexit(void)
+static void finish_pager(void)
 {
 	fflush(stdout);
 	fflush(stderr);
@@ -36,8 +36,34 @@ static void wait_for_pager_atexit(void)
 	finish_command(&pager_process);
 }
 
+static void wait_for_pager_atexit(void)
+{
+	if (old_fd1 == -1)
+		return;
+
+	finish_pager();
+}
+
+void wait_for_pager(void)
+{
+	finish_pager();
+	sigchain_pop_common();
+	unsetenv("GIT_PAGER_IN_USE");
+	dup2(old_fd1, 1);
+	close(old_fd1);
+	old_fd1 = -1;
+	if (old_fd2 != -1) {
+		dup2(old_fd2, 2);
+		close(old_fd2);
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
@@ -113,6 +139,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 
 void setup_pager(void)
 {
+	static int once = 0;
 	const char *pager = git_pager(isatty(1));
 
 	if (!pager)
@@ -142,16 +169,20 @@ void setup_pager(void)
 		die("unable to execute pager '%s'", pager);
 
 	/* original process continues, but writes to the pipe */
+	old_fd1 = dup(1);
 	dup2(pager_process.in, 1);
 	if (isatty(2)) {
-		close_fd2 = 1;
+		old_fd2 = dup(2);
 		dup2(pager_process.in, 2);
 	}
 	close(pager_process.in);
 
-	/* this makes sure that the parent terminates after the pager */
 	sigchain_push_common(wait_for_pager_signal);
-	atexit(wait_for_pager_atexit);
+
+	if (!once) {
+		once++;
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
2.45.2.831.g9e4974e3d4
