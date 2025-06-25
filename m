Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9F211479
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836936; cv=none; b=mwzyrPx9MyaAtx/o1U2bCYSKN5pW9C9VFDLvwt5C4U6mFDbJbB4EUHGwaqa96lI7Ta0NTKQ+jOD8huU6VwbUAKD/Qe35KIVRTfD7y+ysZtbJ8ib/kQumr3zwqOOyS6x5bZfrc1Ota1V9gNTK1cQ67MefO5QgA5s/bv2tznrc1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836936; c=relaxed/simple;
	bh=uKxbz5gBOpZeYy0WArC/xup5CQ7cHsyWSUK4K7ol5M4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Nk8nfAjyyJfmuQnVfqIb8JFTtUlLipkakwc2qMfcTeP3SJqKnANGR92Yw2uwS9rKGCk44MGD6ACHcalClZ98z6fLp+WN4vWuj3+PxJoDkkkwSds40IJ7tCdEwffpxoCH1xC/HU99jMJwZs/ozfSLxZVN+/CWvbSz0mSnZisDH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgtBx+mj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgtBx+mj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4536b8c183cso3433835e9.0
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750836932; x=1751441732; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asV/j5p+vfYpjfIZMedrpRtOB2DjLt5g2ZgBEHC3/Ew=;
        b=TgtBx+mjc74HrgIiCY37GgBdwJloBhgNXCf8U93lzN0qCCS8h85IjQMCH9aKIemLHG
         NgwCeuyvqflZpPUK1tryv3WWPBgb9DkjXxgG5mRh0uOikslaSKFv0AXwkwqgK0aTVB0u
         a6roRRdJbt1OwfWfpy8JewySdjt2qTI58uJBJ5nWgR2Tp/gTuVJMq25WbEEf71au82T4
         bAeTqGqIDlvjFgX18xAsfDReLVxsrDsHR28Ptr557Mn/43fRxdLt/ySzlY29H9M1f1dD
         IYhV1YwxdKsluJsNE6iMbG6fC3hZgfwsUT9bQghcrFwsuhNfPrW8zda6BzacoM8LX9ov
         e3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836932; x=1751441732;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asV/j5p+vfYpjfIZMedrpRtOB2DjLt5g2ZgBEHC3/Ew=;
        b=rccsvxplK45acD97DBH/ESZmCgKMrat9ggVrDcD8MLXozU5OxdGHc90ggYO5w2DXQ8
         x26sCoBDe0RZLpXwE5tbz1KWblqCxYwqgv+14NdXUdThsY7ONsDCfUL9HUyKYgwlSgxk
         Z6p+ebbIADn2XE4QeO0sn/a9nqg3da4oQBP+CH1EKfRXZdde4jAH2z9Im8wSdf7ug9qx
         FNXLwwOKDICjRhS8JTdnQssFkQEIHMn1KFem37oqy6+9Dvbx8gyXjbDWd7+UVvvmf3cw
         bKh7tpnXThfIRF1rp+i4d4rAU6gtc8H5tuKPCYI3w0cl6FTXezi3qsJDutxmsu2L0uKf
         TajA==
X-Gm-Message-State: AOJu0YwAG8U5ygZwdrN7s9Z+VBQEzTfgUkA1FGnDoXgN+v+vkNLybUEA
	neTv5zoBsP4zi/9lhFxYGkpzJc7kUVd3qBug6kpzvXUW3ihsdXr50HxwtOs9+g==
X-Gm-Gg: ASbGncvquF3QAH7nJeUOsybguAC2EL1kGxbnFuM+ddCALfU9ff4cITVf13Swa/OL2b6
	lBWrsF8wc9CVJ7PfklxdmpuVvIC7nDpRVsTD5gn99VrGFXus7alC0QNmi+XhbaYmDontEHa/FN2
	Rq7HKwaktrPu9IjkxN1Yd4FGFKJwsB60G4zlonaOpAPvwFr/IrFnnCnyaqCMYemt2INQg02L0pm
	VqjLMaOSk3uI6ghvlaC1zdk255mmttO4JkP7RFBIhn+OXkKTJoSFsz4yPLBxh48VWD/Y/wg1zFi
	RxMFLrihurrmr1vGnUrlvqtz6HIq5JZB5oOl4/NMnAZIRvI9qqKfiKiLyqIyY8I=
X-Google-Smtp-Source: AGHT+IEzcVuscae0f6WeLMjHdVOU0EUj7GLwyP9S0eI+dOKm8JN5VG2RH4HB9syQKBkAdfda8e04gg==
X-Received: by 2002:a05:600c:1c1f:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-4537b784539mr59663255e9.11.1750836932160;
        Wed, 25 Jun 2025 00:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6fa2sm11188645e9.27.2025.06.25.00.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:35:31 -0700 (PDT)
Message-Id: <05d945aa1e546bcc028e215c8e4d174b5e0c32ad.1750836928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 07:35:27 +0000
Subject: [PATCH v2 2/3] daemon: use sigaction() to install child_handler()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

In a future change, the flags used for processing SIGCHLD will need to
be updated, which is only possible by using sigaction().

Factor out the call to set the signal handler and use sigaction instead
of signal for the systems that allow that, which has the added benefit
of using BSD semantics reliably and therefore not needing the rearming
call.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd5789..8133bd902157 100644
--- a/daemon.c
+++ b/daemon.c
@@ -912,14 +912,19 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo UNUSED)
+static void child_handler(int signo MAYBE_UNUSED)
 {
 	/*
-	 * Otherwise empty handler because systemcalls will get interrupted
-	 * upon signal receipt
-	 * SysV needs the handler to be rearmed
+	 * Otherwise empty handler because systemcalls should get interrupted
+	 * upon signal receipt.
 	 */
-	signal(SIGCHLD, child_handler);
+#ifdef USE_NON_POSIX_SIGNAL
+	/*
+	 * SysV needs the handler to be rearmed, but this is known
+	 * to trigger infinite recursion crashes at least in AIX.
+	 */
+	signal(signo, child_handler);
+#endif
 }
 
 static int set_reuse_addr(int sockfd)
@@ -1118,8 +1123,26 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	}
 }
 
+#ifndef USE_NON_POSIX_SIGNAL
+
+static void set_signal_handler(struct sigaction *psa)
+{
+	sigemptyset(&psa->sa_mask);
+	psa->sa_flags = SA_NOCLDSTOP | SA_RESTART;
+	psa->sa_handler = child_handler;
+	sigaction(SIGCHLD, psa, NULL);
+}
+
+#else
+
+static void set_signal_handler(struct sigaction *psa UNUSED)
+{
+	signal(SIGCHLD, child_handler);
+}
+
 static int service_loop(struct socketlist *socklist)
 {
+	struct sigaction sa;
 	struct pollfd *pfd;
 
 	CALLOC_ARRAY(pfd, socklist->nr);
@@ -1129,7 +1152,7 @@ static int service_loop(struct socketlist *socklist)
 		pfd[i].events = POLLIN;
 	}
 
-	signal(SIGCHLD, child_handler);
+	set_signal_handler(&sa);
 
 	for (;;) {
 		check_dead_children();
-- 
gitgitgadget

