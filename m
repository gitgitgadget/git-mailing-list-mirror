Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188221F4168
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954278; cv=none; b=qgzMBFei2uflBvM7nu/LQJvT0vzfrzGln5nZx3NRfbCeYqsa/Tdb+fVhRosG4m3nKM6x9D1tv6b6m6d6GTKzLrQmZDuG1FoWXn+ObYsYeJJE4nQMSLS2ZkJdQzF7mkUS00fdM/lQD2k0W4CxNMCoNxQY8kgl1tLgi1uHqKpBY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954278; c=relaxed/simple;
	bh=fiuAenledDYX8yzIn7bD+/Z/EJrEecZq1tll4beCPHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s0m7afA33MdhSrmjTZ4kf4RJPmvDxVKQJ4xhzivEPE5o7hkcCSwa1M9T7vZwLXuk1YC+50F20s6EL3SIHsP16P0EIBlSLqCSySaZENLdvXLQBCvf1NNy8XmpR6Ja//f4b0xqbzE/rDGOD1uwEwPOTVxK3eRJscGAggs08xuOxA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV7voCZp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV7voCZp"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3226307787so975373a12.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750954276; x=1751559076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikmB7ijF5g0wrro+Bw6mEpbcoh1CnD0uYe+GihZ/a6M=;
        b=VV7voCZpvSpbcEXGt2Wl0pDxxxk88OtGGJPF44Wdt+9KRXmGCTe6T9p3pN6QxCFs0F
         3uCBRVB/OQJhupBGbkA2K1bI57HMjP06eoXc+zm6vCj6bA0vAcUN6QhUAqwJ9I1zzQdz
         L5jymX4oJgLHqOurk2J/DDLQ8ehOcUnxisKSZlkw3fTapp2y6C4RCf9hWTcVZPoz/R60
         BJImGCmArgO5PdpNLt/q/d93oSLws25nl2pOfx9JWxS4dP4YCO/H/PeNULylbwhgw7qb
         Z9B7QulMwaPBjaqm1zMu6moLPxf7RtFELUHuPDF2xJNDf9mZu3vOY3KvP2G3knnXsqDI
         VtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954276; x=1751559076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikmB7ijF5g0wrro+Bw6mEpbcoh1CnD0uYe+GihZ/a6M=;
        b=OGUyJviiWcYC6sfIcbFR8fe46TGJaW0xa4VOXveQSsTasRbjTMOqVGPi7s9RzvxiUC
         Jd4nFPgd2YSOceC6oTCGknBfovFcYEJSG7EwieKchbFOZnOi0R6+3e7nKIrrYIA/Lff/
         JR2DewnR32xjzG9ZrU2QD50qjkW3BMW7zLDq6q4jt5kmxMvZN8grVuA1DRcAvc7cbAiq
         CanOr+Xl0DkYH5IZvmIW1j0dbZ2u9oRZxYq/LsLwHfArfymAyiuVq/o5AB9Ch0+drvyV
         6IHAAKnWwlKPMtWOipTFg8TVFI4mLmF01qwfzLethrhHloZTecCUwVYKG3Kn42vShlWP
         E72A==
X-Gm-Message-State: AOJu0YzsrgtjagyH5ldGutRqnIdKENnNQQtwQvfoS3DtIUGm6aX+Vore
	O3dO5TihYJfU8IZW6QulYS3IZN0ZBJlovRz0ocCTvNdx//XSO18no25oFC7P3w==
X-Gm-Gg: ASbGncu+YpVgbDH8/Ui63bkV7nlHYTyjHxXFCG6zDSDo1tDgzJUvEPqPRuIWQSu5jBP
	3CPI4lkIhDjdEj79fvVDROzpuJIuyWN3bbYxWKb9sVo2wKuR6FhBDvDz5EElCA5v3wTd5A8mDke
	5qzqclIs9jmQVP0nxtRL72qDkzeGoQa2SyLzwxhZh3MAfF5E6HgwAkYbtKJhRrL1LAAzt4lDR3B
	+RDRliqY8Mj5j7DP6KfgchwBixoOuNbrrBY5axBsNLh25fEiIAvwmqIqzVFqN5V0wUcG6fLsTSS
	hlNik4UBNoZ3ow1X66+yYrm54AkNiDjgpPQwK9YOfI0kwHgeQWkLJ7ALWJ4oCquWN0kw3FXtTYv
	5lpuMTf3JVCVIpFtY
X-Google-Smtp-Source: AGHT+IFuwn9kQ3/mflQ9XukDlymCjKVyRApiFtljQi8FxLFBM/wZ2g73IXpLJknWTCvsS0aMdFKtYA==
X-Received: by 2002:a05:6a21:999b:b0:220:e5e:5909 with SMTP id adf61e73a8af0-2207f2f166fmr11192992637.20.1750954275929;
        Thu, 26 Jun 2025 09:11:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:3061:f32d:ab3f:87dd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557441asm88509b3a.95.2025.06.26.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:11:15 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] daemon: correctly handle soft accept() errors
Date: Thu, 26 Jun 2025 09:10:38 -0700
Message-ID: <20250626161038.85966-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.132.gb7f585ac00
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
that any possible completed childs get reaped earlier. To avoid an
unlilely busy loop, fallback to the old behaviour after a couple
of attempts.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..8d02099a4e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1153,11 +1153,21 @@ static int service_loop(struct socketlist *socklist)
 #endif
 				} ss;
 				socklen_t sslen = sizeof(ss);
-				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
+				int incoming;
+
+redo:
+				incoming = accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
+					int retry = 2;
+
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
2.50.0.132.gb7f585ac00

