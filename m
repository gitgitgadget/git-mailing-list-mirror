Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D61621146C
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836936; cv=none; b=DdvW6ATAuGp2OG8Uo3VQnQrXxQYgoV6tFQYdGGwAnNdgVoVrD0le0XJ2opvP1PZnayjcjWdmvrURtRyKXtIQa/k6lhKUZfqoCRKuC3KeutRaZ4DcDNMfqdGq8aBmIWbQqlkbs42BUzaGjPfNljpUYnuylIXL/uKMHM6tjGqp4zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836936; c=relaxed/simple;
	bh=UCjPLR2Syj2i17oViD/WjzPbCrXVZNbyi5mulqpJafE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=PWyEaSENnE0ynlNM3ZyIkBn8cRKeILzxAKiR7A6ol8eILisBgNgCtKQluA8fg7BnZJLID7tbi9ORajM88YHzJd2qoqpRwESnwx/uXV9awtIczzKFLQeRcO+z5JC6qpvsEgE2NxuunejPISsnmRP7Ps+DrTdheQsPamrfrMIk5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGZKMxfG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGZKMxfG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so5230591f8f.2
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 00:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750836933; x=1751441733; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4wOaTu0Wtu5F/NLHAYgB90YNj5UFypolkZKCfc7Jik=;
        b=bGZKMxfG57ubraNsMQREv0xYb7GXzDt61eNaga5gPMx5PJE9nflqoLox+2A2hXTAhc
         5jlB2hp8Ylo9tJ2P7N3j6nXRl5zb33h7xOVrAIBVFEzTfH59qUSAGWVzFRsdxJJqx0t9
         czwlhNL+oiPCQglMzEKkKFCHKyrBN4Q/VrcgbGwH0wM9zgQNGuoO0bsancz2jmq1oN+i
         vMRD7hwLYemuzlABw4qkUo5F9YpsmLb8mMUme65xeISeDoJPRkvH54vomYoXzG8SXPFz
         9QUjfydvBl+bqL/TpTcKbe/9B3vmwZeyF9jrGXuPGz1wROSfwR3MzClkXewM4i/BW3sf
         /1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836933; x=1751441733;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4wOaTu0Wtu5F/NLHAYgB90YNj5UFypolkZKCfc7Jik=;
        b=JhlXjJIuNIOP08FtGX0AIU7mu6VPTgkP5QEeK7T5YpGOEm+TqqTk+C6brsngy0NJLU
         VORpbPD8SKdN1qF0uoEauSQ5+7cg2yK2nmv7Fzs31VJt6CeKA9MDJ1P9ZzrUM49wQRab
         PaLxQRHWlH2DiNTeG8lbEI9pTqLaXQrfs4fy6sI3AdxfcMn7hRIWrpFsXco8rUEVol8b
         dg5riOvmA7mkIToO6eDe0canCzgyDhhG70mWi6FKifsW6z9CKn9AaMX0w2Wga3L/k6qO
         srRcQIhVWKH3CQ+0aWMNjP7ssDQetqZ2o7yvUtoEOxAzRuGW1W1Wl86gQJQ2TmB7vSdO
         S3/A==
X-Gm-Message-State: AOJu0Ywkqxg6d1wG2oDnwkD10dI/oJFjyVAnnuHRfMsJBrAw4T47Tu9q
	QBLtqYOU+nqJYUVOcxuHpFdyV1Z5e1ENOAhPcZTbF/Y9oNYxzaiXqACzRNQjQQ==
X-Gm-Gg: ASbGncsXUH83bNkx3VHgavuHWnyQN2SZ3hu6uSH564SjqnQx8DF9JRJ7p1dyTjJWQIx
	vK43jlcFooZ4GKUthhKUeTuTOKGZOVlOgGJvabQN6oe3W/PMZ5FUwkY4LbRRri7JTb1Id1phxqA
	rkYlu/Yg9cLAj0MKmACyP0eGp+KAVs7XCwvN0JwWSS1pF9lPxCA2PjV2rKcPcrpf6jclTklCmDC
	+WTzQgNesoNWTRatFDha7DlWIw+R7kzMit2OJYpDqRTneLvoW5jFb468hrOwZq4ztJadIvycwrx
	XbGeEQbXvi+99fNIOQ/jAAr0h+MymOU3L8Z/v+lNHSQnIh9Mp0wU7gHirUX5hkQ=
X-Google-Smtp-Source: AGHT+IE5keF8bamRcC+qL3R5Udarohx/HuxoWnPgV9uQTn0FKaUgK1yP5Tg/kLVRHVtrGHRR7UaW7Q==
X-Received: by 2002:a05:6000:230c:b0:3a5:2cb5:63fd with SMTP id ffacd0b85a97d-3a6ed5d64b7mr1292146f8f.10.1750836932938;
        Wed, 25 Jun 2025 00:35:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8114697sm3889880f8f.98.2025.06.25.00.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 00:35:32 -0700 (PDT)
Message-Id: <b737e0389dfc280994e118736bf4452ed80ebcd6.1750836928.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 07:35:28 +0000
Subject: [PATCH v2 3/3] daemon: explicitly allow EINTR during poll()
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

If the setup for the SIGCHLD signal handler sets SA_RESTART, poll()
might not return with -1 and set errno to EINTR when a signal is
received.

Since the logic to reap zombie childs relies on those interruptions
make sure to explicitly disable SA_RESTART around this function.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/daemon.c b/daemon.c
index 8133bd902157..01337fcfedab 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1133,6 +1133,15 @@ static void set_signal_handler(struct sigaction *psa)
 	sigaction(SIGCHLD, psa, NULL);
 }
 
+static void set_sa_restart(struct sigaction *psa, int enable)
+{
+	if (enable)
+		psa->sa_flags |= SA_RESTART;
+	else
+		psa->sa_flags &= ~SA_RESTART;
+	sigaction(SIGCHLD, psa, NULL);
+}
+
 #else
 
 static void set_signal_handler(struct sigaction *psa UNUSED)
@@ -1140,6 +1149,12 @@ static void set_signal_handler(struct sigaction *psa UNUSED)
 	signal(SIGCHLD, child_handler);
 }
 
+static void set_sa_restart(struct sigaction *psa UNUSED, int enable UNUSED)
+{
+}
+
+#endif
+
 static int service_loop(struct socketlist *socklist)
 {
 	struct sigaction sa;
@@ -1157,6 +1172,7 @@ static int service_loop(struct socketlist *socklist)
 	for (;;) {
 		check_dead_children();
 
+		set_sa_restart(&sa, 0);
 		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
@@ -1165,6 +1181,7 @@ static int service_loop(struct socketlist *socklist)
 			}
 			continue;
 		}
+		set_sa_restart(&sa, 1);
 
 		for (size_t i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
-- 
gitgitgadget
