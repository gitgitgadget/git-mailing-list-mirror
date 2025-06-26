Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946B78F2F
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958554; cv=none; b=LY+d1nXSSSKDVGEy2qTgBh7EVlIJ6vu3dRWOp+fjLoNOXSnhG9WUV6zsaWH/JT+fNZN907bVDv32BIROqy+FqUOefbDA+Zybky7ZPK+lXbWdm5NpAEiV9XVKuah6BVbYB5Iizx2DvNH2g0Ldyk0Yxm9Sg/uFHG8g24V6XmVbTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958554; c=relaxed/simple;
	bh=56mz38yYjnLqRlYHtzRCfPosZtPm1GulJ2FPrrcoyps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcQfwaOdryOrpCv13JadUcC54zELLa2Gw4gN80K51743tEbLShpkced1UiXTTZxvJmbQwbVrv7FIZl1iqcauWiumQ/aTJwIqr0+BS/HSk4awluvNn776xcuhPGUH7TWfm40uS/+kocMEU52+5AzsbIsm5nw7rcrgz8HuymJe59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEkv7pr7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEkv7pr7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23633a6ac50so18372225ad.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750958552; x=1751563352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+tNOPi9yf230fIIHcBoOaj7xztKptCQXRM5CaJENWE=;
        b=OEkv7pr7rre6EnXyVYEy3UQznwGAbq2HlkbZlzpomNVevW5pZTObZjFQ4W9LoLpkCX
         +oQQneNpjMKDeVE4m7bgTXZz20BD9fvqEjVQuRnv7M2SfL0mrLGwmFBjz6jNxUAdtYWh
         9VqRoYX5YoOV8QBcE5CE2NNB8IfcgMP6uKJoxt9CSqnuw1F/JXLW/ly2fb3kn6BTXTtr
         mSSwFvqLvdc7mORtcWSLE0Vg8oZAD36zTlho2Rn+vYpV++0aWqOFhvfa5cxgTWEaoPDH
         M3jNo49CxyJLNOFaaucEQSbpKcxm2Cpqy51OdU12pDnAcC4sGMONFnX5IrfFgOM2rL3j
         1dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958552; x=1751563352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+tNOPi9yf230fIIHcBoOaj7xztKptCQXRM5CaJENWE=;
        b=oSuvoSfr0burN9XgaF3DiSnTh6YB4MrOnYObP+dbNT6a05I0Z2qpcOCNv2i/01FGVN
         ZL2+PpHq9MXALyHnEA8SyDKSsSDzCoLpuP+lUnc/g1u20Fc0ycAM9Vw33Tav1+A3/OHa
         xsemeeKiK/NrvuqRfFpf8ZUWdjKEkFfkMRttlnLoLh0deArW9VBwimwTnseelo2k8LCp
         EzTaFINGJNX+PTLkljHhKWvsBIIbeb0zYDh5oBdGPMurYDJXPZxDzr/oryxCmatCx82K
         zX+mefkAQsHAPDOs19D9BjVS6ORwOE0SKpc04A0sBj5p6K3DLWnM362uclVq2K1rC+Sc
         rzBA==
X-Gm-Message-State: AOJu0YzuYp8mEcozVnHbfRgS0ub94FBf5dj+EpqiYK67OabnOzrEM17J
	qJMi+8mNPquHUA9MToA8s0C5P0FD7Zvv6VX9ftoipCNeVQYPrXk4fAJOjXyh+Q==
X-Gm-Gg: ASbGncuA4i2uk5yL1uY22WFijMuwPBQZxTrIVuW8ArMFTCoSLCyObb1N/ZnbkWDMK8v
	aW/q/2VNBc9+uBmBIj81T56oKPrbIPFISsM13ZiAmfOiERagkbfOaknzd2Xl16bcyfFoISIxyeQ
	xqJ6JJca+VjOGDtN4J4IP4rqYRCs1d9HEpLBdV8cJtracXBG+BRV+BseUTeCdwHxR1T5leE10CI
	4tCCzJRksbEJYT4nTZsgLAX7r67nq/DN4ekqzjPGj6qnjJMVwO8/oVn18RxTlOCpiFxwQOMENkn
	XbJzC2YiSrqiBv347DFdBdwZBsN6TiMDaZnIN4U22zBifkhzzdlWur5yz/FCVYYmJgkD5PwkByc
	JALzIt35B/VsiPR9Gj71/vhtlLng=
X-Google-Smtp-Source: AGHT+IGS/gdV6/VnkXS9+bJv1XIRWg7yGe4N0Hy4mbbCZkXkUv+JJMNuVp2UECVC1WOWWLP+9Ps6sA==
X-Received: by 2002:a17:902:db10:b0:236:8db5:7e50 with SMTP id d9443c01a7336-23ac3bffb10mr2104885ad.9.1750958551646;
        Thu, 26 Jun 2025 10:22:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c4445c4bsm2177442a12.42.2025.06.26.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:22:31 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: yoshfuji@linux-ipv6.org,
	kristofferhaugsbakk@fastmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2] daemon: correctly handle soft accept() errors in service_loop
Date: Thu, 26 Jun 2025 10:21:59 -0700
Message-ID: <20250626172159.87204-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.132.g195eec4876
In-Reply-To: <20250626161038.85966-1-carenas@gmail.com>
References: <20250626161038.85966-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
2005-07-23), the original error checking was included in an inner loop
unchanged, where its effect was different.

Instead of retrying, after a EINTR during accept() in the listening
socket, it will advance to the next one and try with that instead,
leaving the client waiting for another round.

Make sure that the loop doesn't advance and while at it, make sure
that any possible completed children get reaped earlier. To avoid an
unlikely busy loop, fallback to the old behaviour after a couple
of attempts.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..f113839781 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1145,6 +1145,7 @@ static int service_loop(struct socketlist *socklist)
 
 		for (size_t i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
+				int incoming;
 				union {
 					struct sockaddr sa;
 					struct sockaddr_in sai;
@@ -1153,11 +1154,19 @@ static int service_loop(struct socketlist *socklist)
 #endif
 				} ss;
 				socklen_t sslen = sizeof(ss);
-				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+				int retry = 3;
+
+			redo:
+				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-					case EAGAIN:
 					case EINTR:
+						if (--retry) {
+							check_dead_children();
+							goto redo;
+						}
+						/* fallthrough */
+					case EAGAIN:
 					case ECONNABORTED:
 						continue;
 					default:
-- 
2.50.0.132.g195eec4876

