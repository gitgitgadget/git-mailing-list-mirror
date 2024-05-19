Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DE10A3E
	for <git@vger.kernel.org>; Sun, 19 May 2024 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716102758; cv=none; b=Vx9TjuYuRNMFWpr+xQSk4aoVIWArf4Ai2go9YB4dtN7UsrJmB9UK2Ra7yqqCCHqpSuYW+IbO6daKTdEVtGFKdeMSZFH8TMbhmBo0k7tL5raIj1LLRhnZxls1YTg0w//v9zJcjzuhxHJxFqNipeqMTj+uyB6Lam5W6Uig69ROHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716102758; c=relaxed/simple;
	bh=MThN82jGPvVBcMbCdAeC0pnrXPLIq90/5d9qXG5ROak=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HRxAqH1nz3U7xTim8BXBif15W7DQuA4PAI2AxOzxc3+NuxThG77nSgz/Kbtc8gbJbjvAWBzErPehtz5Uy1CPgxQVHoyqM4fxgIv+pmt+85rIwVmbfJ8HdRhaAGOlh7Hq5kmHrDXFCuCUYs4lugZK6rnZO36wgT+N/SuPRiW4wMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwiDc6hN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwiDc6hN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so18221421fa.0
        for <git@vger.kernel.org>; Sun, 19 May 2024 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716102755; x=1716707555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLh0Fn5AMsWBbc6wowRLpxqUz0egA0e0qnfAPxFQup8=;
        b=XwiDc6hNRIPZWeFE7dgpxWiJcrUeDuTx1MpBxYHnBXece99bOrbY1Eo02PaA3Nvn8n
         kQWMxik8SM2lozHs8xU98tE7THYWpmD5p/ewLED50abt9+xaRTFOVHh6fafF8j3Qb4Wj
         XIL/ly86WG3535RIyAyz4/JceU7227Y6z0Kpbbb/+DyotFaaRpL3rh4ZDFyGRO357M8X
         Pfi3qsHo7P8BTO0LVImqOdnCMRBEIWfEg6+MlozBoOer/rQFC4mMJWyyIO/B4OXnj70v
         6YkUdoZNtrM6qDLuc10ytFb90hjAGBeEv/MBpMIVqUP4swfYw44kC0V90Lkbe9B0V0iA
         I8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716102755; x=1716707555;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLh0Fn5AMsWBbc6wowRLpxqUz0egA0e0qnfAPxFQup8=;
        b=u0jrR8LIsol7tqdxUfwOZqnbb0KbrvXB7TUgjXesTDzchF6VN/1VXrjfilM06qQsXP
         +WEExDO6WQ1tNe0SOYnLiUfkodp/y9gwDkc2NZ+dFJpHATDGd2aLIUUVA0qav+bYloLl
         WLVIa5k1MNunfeWJiDzRS590CNd1znyrLsWb8eEx9NOWNxd8AGoA2qF5tVQnkJHX7oQu
         aHGOfzJcy5sWtSGVIHcMN+6hj7MbUTLoJ9Jj2vExz8uHM3d42mggdFyh/WyHN1ww7pmD
         I+WncNZvc1UETpHbDQAkkIwmShd6uu3W9Wl7zt1/+krjLf94tThG0d8ZEqWiDCFgpZgX
         Q0sg==
X-Gm-Message-State: AOJu0YzLH/WwTo5vjA/KcUXzQZNC/f7jOw40vJsWVZu1Gmv7i8MTG/E4
	XXHlXSy84MsH0GBfTllq0YPaTNh0galkuODx2UixDW8L9AgTQyug0ADzeA==
X-Google-Smtp-Source: AGHT+IHFzqM9rmgsPX2A4HLeN8FbiXQZ8jFK/r4b7ng5R+Z6HSpR3jDyUkXTDWW3BJmhWQ5F7PAXpg==
X-Received: by 2002:a2e:8255:0:b0:2db:4f3f:55a7 with SMTP id 38308e7fff4ca-2e5204cc8d2mr155694091fa.45.1716102754978;
        Sun, 19 May 2024 00:12:34 -0700 (PDT)
Received: from gmail.com (173.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201c3f8032sm223886475e9.28.2024.05.19.00.12.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 00:12:34 -0700 (PDT)
Message-ID: <80f15223-246e-4cfb-a139-e47af829c938@gmail.com>
Date: Sun, 19 May 2024 09:12:31 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/5] pager: do not close fd 2 unnecessarily
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We send errors to the pager since 61b80509e3 (sending errors to stdout
under $PAGER, 2008-02-16).

In a8335024c2 (pager: do not dup2 stderr if it is already redirected,
2008-12-15) an exception was introduced to avoid redirecting stderr if
it is not connected to a terminal.

In such exceptional cases, the close(STDERR_FILENO) we're doing in
close_pager_fds, is unnecessary.

Furthermore, in a subsequent commit we're going to introduce changes
that might call close_pager_fds multiple times.  With this in mind,
unconditionally closing stderr will become undesirable.

Let's close(STDERR_FILENO) only when necessary, and pave the way for
the coming changes.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 pager.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/pager.c b/pager.c
index b8822a9381..3ef6798f7e 100644
--- a/pager.c
+++ b/pager.c
@@ -14,6 +14,7 @@ int pager_use_color = 1;
 
 static struct child_process pager_process;
 static const char *pager_program;
+static int old_fd2 = -1;
 
 /* Is the value coming back from term_columns() just a guess? */
 static int term_columns_guessed;
@@ -23,7 +24,8 @@ static void close_pager_fds(void)
 {
 	/* signal EOF to pager */
 	close(1);
-	close(2);
+	if (old_fd2 != -1)
+		close(2);
 }
 
 static void wait_for_pager_atexit(void)
@@ -141,8 +143,10 @@ void setup_pager(void)
 
 	/* original process continues, but writes to the pipe */
 	dup2(pager_process.in, 1);
-	if (isatty(2))
+	if (isatty(2)) {
+		old_fd2 = 1;
 		dup2(pager_process.in, 2);
+	}
 	close(pager_process.in);
 
 	/* this makes sure that the parent terminates after the pager */
-- 
2.45.1.209.gd5886bf9cd
