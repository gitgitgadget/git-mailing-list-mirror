Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C2370818
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431337; cv=none; b=FKCfvnoSlFqvwhD8AYYcUHc29RysMGUqtKNEdqzpiFYMZdtrSnj2hOf3mDZYncNCC2qQcQmvpDams1ucAFuwYCr4+K1uok72BOVor8GnPtaGTDHoBoLKvKkZ6Z+I2+c/LofN6ya4cOAfzGson1w0AFPySvaz75bLpgujFuAq0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431337; c=relaxed/simple;
	bh=+5a2B+RbfhteY3pHMueztFQFUuGKAs1JBip0IoUqGrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8D0whXImYRQjzGRAxJSltIEE1pYUkjLo3eoz9XABBfp2H7ZAVtu14HWisryAmV1l6YF6CRS0H+cbZJPub07vWjeE0iYVFM7qv5APnMlSfp5U1xlaPPkWliDZGIY5FbWFpzr1OZC3x8BlJYPgULPl1XCoh0PRbqCtlU8eocNH78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkbu4qY4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkbu4qY4"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84236f9b638so1477506b3a.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431335; x=1781036135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odEU2pSYiQ32zMLfw0qi6QdGkCU39ViJn3Xm3vAIBUs=;
        b=fkbu4qY4ye0EGpvYba7xNozWZCcCv+N3Ip7ZebKW8TXsECbwdEXSJVG5bJ8yozLHDT
         PBhzaUEsupVZSqXe5EzCu3cKyjMZIdbgn9+EpQZiY2VbtuA8evHn9CNoE58HZeYtvAEH
         gHgihvv6T0Udh82CoDDXU+BGVRTQAjxBAc5lFsDVHwsfU6BDUg7NvvtCpBZwvfS1Z4yk
         klx6iXP44szjSX1dbJuVkpLsRSUByVqq3mp3V+46YA43TVnoIqfXyrkaSQZYk2WpK5t5
         oY4/lKNHiiukj4n18RRGr8H4RPUah+w8/IGiEG5TyC0LtyRBxX/OpdEWARh71VO/RwEC
         2Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431335; x=1781036135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odEU2pSYiQ32zMLfw0qi6QdGkCU39ViJn3Xm3vAIBUs=;
        b=VB31ztDdzZixnUaMUCqBgcu9Sb9bS65OzxzDNpoLvxxR2PuNpo5+0xH+tzT8jq8pK8
         q/6WWMBGAyc/Rt6Gw7eMUcfNge5QAolRpClwje67/tIKBqfqtMtlErQuQiwn2RgpVFKo
         ghbO9om9zpJOD3xR7MbvEbszkMPOSmlR38PS2dxyr/xRwChbAlZ9mgdk75lwIzpGvSpC
         YZsPKUojROGF1wgTbK8S/DtgUWUtIj/kvpVaLYfA8suT+ioGchvPoL7syNYHoOGmstJA
         NvC/P88UE5z8/Pqvo7nb/b/7X1YQq9Ze5tpoKiKnmgRGrbtBlJoIhQsDiUTbfQZG2FgN
         v2iA==
X-Gm-Message-State: AOJu0YyZiwhCg/GlJ372ymH7CHbC5Bfvbw9069fvSuqGyKdx9ydO3CA3
	hf1DkwD8VptZge6jM3LSeCepExTmvXtuah/JNezJvYFHQhT/u8Xxfi00NYQ/5Q==
X-Gm-Gg: Acq92OEVY23RJTphATDxWEQPXNWZPI/TtFJIsEEi+29SJ0Xy4uXdEyZoGJ1MEMIDh9b
	YMYI0qITBk+z6cFPfLPLDQAwuX4yIhv385UEKkO7gaWvTQric0juCBraEE3ClwrZ56FnpQgFWIz
	NDSYZXwj4S9kqyxbNSKaWz8Fl+amuV+XnSo0arkoOc12Tk2QR14HDXdg2ZISdohioFGU55XpPnW
	zcbKGbqrljh1XFXq0wvqe64cWD/FzOtuR8a60LxxRd/ph7t+Skoy4dUHFic6R3BPE4RtfVT6P7I
	X4nyf0Nay2HklvVfYnN4KrceIj0JUXYoGE9AN9j2clVTa2HoFSg4IAOuFY9Oce0f3yRJEFT9zPB
	b1fNirMaG/1MAkkjXxZy64kmG2sqFQYI7X49ZxYHiNGY3U6VzbPPiY9eu6DYC0ZNUaZmJQlKW2C
	2/6a9KoNqA5YPqUR+wQQMo8jPX36kQSLU9HO7xAe1onMpkCWM5nALvMJI+dA==
X-Received: by 2002:a05:6a00:997:b0:83e:b443:965e with SMTP id d2e1a72fcca58-84284defba5mr379467b3a.3.1780431334910;
        Tue, 02 Jun 2026 13:15:34 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.115.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282880050sm642114b3a.29.2026.06.02.13.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:15:34 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH] transport-helper: fix TSAN race in transfer_debug()
Date: Tue,  2 Jun 2026 20:13:10 +0000
Message-ID: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, transfer_debug() lazily initializes a static variable based
on GIT_TRANSLOOP_DEBUG. Since the function may be called from multiple
worker threads, this initialization is racy and is therefore suppressed
in .tsan-suppressions.

Initialize the variable in bidirectional_transfer_loop() before any
worker threads or processes are created. This patch removes the race and
allows dropping the corresponding TSAN suppression.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 .tsan-suppressions |  1 -
 transport-helper.c | 17 ++++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/.tsan-suppressions b/.tsan-suppressions
index 5ba86d6845..d84883bd90 100644
--- a/.tsan-suppressions
+++ b/.tsan-suppressions
@@ -7,7 +7,6 @@
 # A static variable is written to racily, but we always write the same value, so
 # in practice it (hopefully!) doesn't matter.
 race:^want_color$
-race:^transfer_debug$
 
 # A boolean value, which tells whether the replace_map has been initialized or
 # not, is read racily with an update. As this variable is written to only once,
diff --git a/transport-helper.c b/transport-helper.c
index 04d55572a9..95a7fa7d86 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1361,24 +1361,16 @@ int transport_helper_init(struct transport *transport, const char *name)
 /* This should be enough to hold debugging message. */
 #define PBUFFERSIZE 8192
 
+static int transfer_debug_enabled = -1;
+
 /* Print bidirectional transfer loop debug message. */
 __attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
-	/*
-	 * NEEDSWORK: This function is sometimes used from multiple threads, and
-	 * we end up using debug_enabled racily. That "should not matter" since
-	 * we always write the same value, but it's still wrong. This function
-	 * is listed in .tsan-suppressions for the time being.
-	 */
-
 	va_list args;
 	char msgbuf[PBUFFERSIZE];
-	static int debug_enabled = -1;
 
-	if (debug_enabled < 0)
-		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
-	if (!debug_enabled)
+	if (!transfer_debug_enabled)
 		return;
 
 	va_start(args, fmt);
@@ -1648,6 +1640,9 @@ int bidirectional_transfer_loop(int input, int output)
 {
 	struct bidirectional_transfer_state state;
 
+	if (transfer_debug_enabled < 0)
+		transfer_debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
+
 	/* Fill the state fields. */
 	state.ptg.src = input;
 	state.ptg.dest = 1;
-- 
2.53.0.582.gca1db8a0f7

