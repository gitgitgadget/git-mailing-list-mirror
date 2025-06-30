Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D034C6C
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256815; cv=none; b=EONQq5gBGDfJhzBxZz5e90urEVYnF/YyiGp/9+Fe9x5+KEvLWMbIeDyt0p0XGGyHmVd/+A+siHCdMCArVCvZfMYAOT0OivNjpSf5NH9ff6glpo+8p/MqSTk6BHCbNJYeId1w8I2s2MOY+OZdOR4/fyy8bQVAvU1Mioo/z6UTVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256815; c=relaxed/simple;
	bh=t82ww5hDUjEDhSOmz/87n45GKt4afbY7jDUlsFa2suw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ej8Ccv4mP6IrQTKZB6SAg7UWJy7YFiRrXwwqJieBXBdR91qEum3Q8n+dkc6XZrn7OYnZk8HSRRtYMlf/CTxFdPoPNsvSB8Iska92SbZkvTWgo4/CiDXYOAK/UtQftr9k23Pts4rg+8k2ms+Palev/vUbuTWN0DvkRDBd8g8dcmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3SsKy43; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3SsKy43"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-747ef5996edso1454211b3a.0
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 21:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751256813; x=1751861613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJeUpC/EewOXJr/+DNMDuvf67dqpZvINHb9WmIk+vz4=;
        b=F3SsKy435408dlA4eL9Ci3MaL23uj8J6q1dDMM46ytsW9yr5x7JEs3av8ogTJ3f07M
         8SJXf4tCrPR6uZ5t14u9kYZRrJWNvTaGrhQ6ep7RnyySYUpla0v6tq7/Xwf/Wc5NbWmw
         cdjucdZKstQeQ/Xh9Ypi2u8SHkzGYvfrXrozvfVBIpPBYbTdnvEy9vwlY62ALJqVHk58
         ROSaadD45x8AqXDLpy4uZUJGVGlmPDf3RWZOf0uY6VoCns3vVz2sgtSia0uIjTiJJD+5
         HSKj8kZYXRwhw7q1Ga7NflGa4cix6hIUpTCFuLx6jJZKfTbU8qeNI39+fzBnIWrswrLn
         0qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751256813; x=1751861613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJeUpC/EewOXJr/+DNMDuvf67dqpZvINHb9WmIk+vz4=;
        b=td7+fJSRkezxHyg64Bl6NdkkG6ocE3X3SjKtU05FfOvfgouGm05ER6XhXS+30x6Vk/
         Cvq9/53hJM0DJ6mWwcDrcI9suVsyI8a9d8qOpT3C0yJvkzdVUt/JDCgEtGk+Yjqx+dEJ
         VCx8//d1mbPhaqp+NyYx3Y3t/FAXcNiXqONQQEtpTgJ2FvaEfmDyF/6wxvLz5BUAscH8
         8wx3B832N9pLN4L1OnGKGXLICKi+9jU6y1XnMuFf288l9zap1yaJNEISPFlSfrVCp+lA
         UofGjwJSPVrRSwIk/SJ6I4YRi39ORPOwnH9h6c/PLXujadf+XVB67L9IDQCARdi+7yFi
         dkTQ==
X-Gm-Message-State: AOJu0YzcKoioxVWkY7RKnKEl0PrDN72wyOdn8NylQ/ceMcL68N9RtyOP
	3C/B5viUPy6CMyIF0k0Ce50XqpT0qnbgLGTcls1aTCl/f+O6biMrJ3KDiqTvQw==
X-Gm-Gg: ASbGncsSn0+jE+ei2dGHSkFO0oGKgmNUs58bYdZW/wA4FjevbLrKGUyhudFWoP+H3v9
	9RYb0SN+mw6ITRlWBEaZ995lchdUSdamUhVLbYt2vZRScWxB0tjzqUy/Dmu1VBN0kUCIChHn3si
	bPboejkwLYy/3G7ftJNJjciKVMVXqQS8+I3p1fOVC2Z2ouFBvdmFbIwD4UZ5LJHt6IwbDxsCwQ/
	iUU2boLHj4TVBevczn6zSNnOto8T0bbDfGd2dX0TnUWrhjcgKfY+DA01vZExbUlpanXYMoC+SY5
	5YO0L+zcXEsyphrgQejJ+fgnOk+mbHBNmuB2UXjtkeu/JwLp58z2057/OxQfr9+PsPaK0Q1Qqnn
	5TQuyFlPaVTF39ARQXHiiBXo42G0=
X-Google-Smtp-Source: AGHT+IFDCcqUtaZJeUQ+Jx19BNLTaSFeWLh0obqzLSLgnMLbD730xpXyyAAfc6zlt+X2q9F7VSOM8w==
X-Received: by 2002:a05:6a21:498c:b0:220:b340:92f6 with SMTP id adf61e73a8af0-220b34093e9mr6392239637.21.1751256813266;
        Sun, 29 Jun 2025 21:13:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:edb3:4a4e:9234:fe40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5574604sm8128672b3a.86.2025.06.29.21.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 21:13:32 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: "Stephen R . van den Berg" <srb@cuci.nl>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH] daemon: handle EINTR failures from waitpid()
Date: Sun, 29 Jun 2025 21:13:03 -0700
Message-ID: <20250630041303.93370-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.132.g32f443f09a.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 695605b508 (git-daemon: Simplify dead-children reaping logic,
2008-08-14), the logic to check for zombie children was moved out of
the SIGCHLD signal handler, but adding checks for a failed waitpid()
were missed, with the possibility that a badly timed signal could
prevent the promptly reaping of those defunct processes.

After the refactoring of 30e1560230 (daemon: use run-command api for
async serving, 2010-11-04), that reproduced that bug, a single
process could be skipped from reaping, so prevent that by adding the
missing error handling, and while at it make sure that ECHILD (or
other errors) are correctly reported as a BUG().

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 daemon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/daemon.c b/daemon.c
index d1be61fd57..16ae66a2da 100644
--- a/daemon.c
+++ b/daemon.c
@@ -864,8 +864,11 @@ static void check_dead_children(void)
 			live_children--;
 			child_process_clear(&blanket->cld);
 			free(blanket);
-		} else
+		} else if (!pid)
 			cradle = &blanket->next;
+		else if (errno != EINTR)
+			BUG("invalid child '%" PRIuMAX "'",
+			    (uintmax_t)blanket->cld.pid);
 }
 
 static struct strvec cld_argv = STRVEC_INIT;
-- 
2.50.0.132.g32f443f09a.dirty

