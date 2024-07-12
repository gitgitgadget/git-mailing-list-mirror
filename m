Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B903646
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746043; cv=none; b=N0zFms/u7AFeEfjpFKfAslJhj4OCNQjMJDtqcHYv8CZASizXlaF8jkXG+nDRHYma+oO8zng9wrL/F9jg0nNasqFt4GaDsid9ljdeMprc8NczNjidIhW1Mn7o8VajCjRp6abJXk6uSiR4Dw13fVqP1gzyUxetZF2JVw/l7MXYVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746043; c=relaxed/simple;
	bh=K2qQ4YxVn4IcZ6zjYncqGH51QLHRQj3SNWIzA/2G3WQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=phCtpzPt2Jc75nCQ0EUA95XKQv3yh6Xwwvl6fvWqpw8TV9qcqhGr2aTDVn7V3W3J6Tm2hJedkfYF7SvdQVSuqLtU4V/BLCaiVl11IgheYvDBQsX8z8lZtyr1NRDdlXAciCTselk7CDiuGznciJcvaahh7nVBvTpehbnaxywLugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS/ghc+V; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS/ghc+V"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c661e75ff6so706240eaf.2
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720746040; x=1721350840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QSt/KlFZjITo82bf+j4HAf/SX8KZJF5mpo/JA5V78xA=;
        b=QS/ghc+VXBCLN2yFYaNDd16R0y9iQB9BQJGXvXAY+zlnigbt6d/9N0LQzw80okzmMj
         wfA9UKyLxHarRkRRfGR1CNsBgkMkhliKjrJ4rYykO990AKMIztuI3vIcH7EKMe075xzN
         AfANtYdGEBcRV40fORJL3L1mU1MBxoWamlWyuseywCUxkOYJsswhzqgOEYYJEQDekhwr
         0i+ulxIMfo6UdONvHrxc34ZXNQT8gW+MKSXAPUgMPlJwwIEfBPVHzT0HCkPv/q4VGOlA
         xImQRqrk5j2tfkvxgQCH85AE69jDB/H5v9eauDztPeMA+Y9TV2i/hFHVHRD1aU1XAlsJ
         Unvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746040; x=1721350840;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSt/KlFZjITo82bf+j4HAf/SX8KZJF5mpo/JA5V78xA=;
        b=DIoXR+RjKm2zlFVZSfdUD5E7RG9JNOTzpNT5Otnp4PBChE+8KwwXdh4mr38xFsf5/x
         uz2iI8dRPhc90eJxiiyTxwxWoqTkM8oLTRqbxnn8lke0X4BIjyvLdVg+3unK4/dtZHEz
         cuiQm1W2HNRWgWo/L7E5KjD3UvhkI5/PGiWiSVy7lgTR2WaoRmMGcZqNPL48AoDvIeMX
         U4khO+oz3Ms/exLBLLi3iz42KRY6B1C/QnoLJaENOKcQJw8zcmJ+gP5PZtxl14zozw1Q
         HsjhA2MXercZWT1l8bWWz+RvfihGH2f4Czjh14LET5qofi6jZjmCEwuJZ8OSrALaDBwp
         NHSg==
X-Gm-Message-State: AOJu0YyGfue5WCYPxyPzNTMA3LiHZme+A8Kgs1Ie1CGQ+kp04MUk6rnD
	442Bd005SLGMlL7Apn1zENNJI5Hu8fFn/cWH+EzivoenDMGHpM74cF8w5Q==
X-Google-Smtp-Source: AGHT+IFdmuy4RXnPn3utpzcodrKd+Cr9y0YDQL0f36TwKpPt71DE1IDZLMW+0qOl1dkOl9mFGEqHuA==
X-Received: by 2002:a05:6870:fba2:b0:25e:27bd:885 with SMTP id 586e51a60fabf-25eaec56995mr9069860fac.57.1720746040510;
        Thu, 11 Jul 2024 18:00:40 -0700 (PDT)
Received: from gmail.com (p4357013-ipoe.ipoe.ocn.ne.jp. [123.222.98.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438e6d4fsm6494111b3a.91.2024.07.11.18.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 18:00:39 -0700 (PDT)
Message-ID: <4b5d0e7c-9492-4495-9bc1-40ebea850fde@gmail.com>
Date: Fri, 12 Jul 2024 10:00:37 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] pager: introduce wait_for_pager
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
Content-Language: en-US
In-Reply-To: <2653fb37-c8a8-49b1-a804-4be6654a2cad@gmail.com>
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
2.45.1
