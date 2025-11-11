Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F932AAB1
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890159; cv=none; b=YQ/yRkf+FE1ulbU+HN3HqTnqSS1U+vHb6G8lRWyU6fQHMdlyx8QY6NrgJCdOx2MMVYnwVkt/Jwv6O2n93LTKvnV9DzBpbP/BWPw+hxpbBpi5PSiA9QngxzPhXfoNz3FhswerVBcTnLQ6NJwfWUKeRn67yfR1r2YzjDeVNH1uPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890159; c=relaxed/simple;
	bh=Fy08C7VU69bFZWBA/AAzfde8yHLW9BVgmZ5dvNkD4hQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=r62rmxHwYzk+B6TjPXYw2aeXwP0P+KaJHoCKwfPTLLlJ2EWsQkufzLaFHvSxcwtTFk0/EkGKSpOR6a5t2oRtf/BOKTNrsM28wiO1QT13W1AKjlmikDuV85qW7R5K7tOQvBTefcGFMlbzTQGddcfF4TQ1klEflsiu5zhh8mQYRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2kCeQUA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2kCeQUA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2148ca40eso17808185a.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 11:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890156; x=1763494956; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CHp1ex/KPjnIUDm6CqshgHSB9pcfqpO7iEEm8REdWA=;
        b=M2kCeQUAiVkxjakkzNZgHS6abIGsT7783VoPea92DWOlwJDgyeAlRctsepY6LSriGa
         p4Yc4ILgSF/rEvKygCF5QMIfnKF3cqIGhE3EcQwl9Crs5+52iSNpAP0Xn/cyOdcn96dQ
         6cx/Fg3aQbVv+d+Eu2lmIqM+3O/nm25/wiwyCNbG0J10dGHBRNe4q+RXXIL9pNXbTcU2
         ARubFOMMOTub0vkhaKDvIaccCOKnugp/oIhK6Fs6xVD/aHYcQmhsEvkMn0qZyOulf1Kn
         Os+NKv+tLI9IECZJ6QWvw3YHVZJrFvOPQ+MkAgiai6oFGPKrH9uwswUGOcaTRnzlCK28
         VahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890156; x=1763494956;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1CHp1ex/KPjnIUDm6CqshgHSB9pcfqpO7iEEm8REdWA=;
        b=NNlQzuJjnmJvnDHzGZnLYBXyyv8o5vaOU2ScMNeUt2xj2XjqgsmVAvnpbBisAk+I10
         GW0STZJCedgbcMME6YATzMOFRzwuEplwVXb4WI+gRilnopmLSEhYRg79X/RRoe4fc/Ud
         8ZrslD8oq25OjQ17gT9NG3PZgTrUhj/oY73bbhk9GLGmuU9wmKbgeKqUUDnmAKTT+dV9
         qc0RnaWbEwJFldZA1LOK7f3YS+16UdPvcL/KvCFc8AZZPouB3BQs/IofWpxg1nFxkvVt
         rwxXau9/dKqOcB38V8O5onhc9x7XXUvGjotGypUrFRY9toHEyfuzyj7apfJ5vQ7+YuX5
         ldaA==
X-Gm-Message-State: AOJu0Ywy9naCs5QJUNZ4o10YMPvbN3XdLREphhNMFAuyIa+S4AfeeESn
	OHp61cMD8OrbxJ7CJDXrfcZXrendpodNAUNo8dSUOkemC298PXk5+/hvfucV/w==
X-Gm-Gg: ASbGncvqzU3mkwSOmIm3Q8voSIvDqIoQexRyLT7k+1cDoCKegQC+pJm8JXYN/nEHbEl
	ZhjKQBkybZviKpxxrMKKcexqz1ox6QRYUhgalz7XDLJarZ/2YIagpjfaY+KLyppT07Ssa/gH9vV
	DuASx/ljcnD+NdXAlKfAgKSzr+ZxYIgnjg/8oxSxPxhxPw7dZXnwoBCh5WSsWB6tKX1aMOZGkcf
	Su/7FTEK+Z1kwnNQaSFBYTaIbuH4FW2BNZjRx29S+vdannFw3YALPN/wyXbkECvp7NNr/gUadcb
	8pfS1kS4T2qFw007hM6KdVRO3XuRdZ0xUYiikQtKwyFuwzMQvLevelVP9LHrZQBpgARP5/Fs8f8
	1dkjzZfUrYsivKCgP6c4MDSD3OnPUJOFG0EZD+8opZBeNxJOkD5KhFgU4iJ8wRn7+NMvNCN3sGq
	VP+3CbBayg1HAvTA==
X-Google-Smtp-Source: AGHT+IHPMtcAXofw3Ds7Ld+hmZMwd259XOmKxUdRN0DEsoYab6Na4nMrMdhNSNDh4QtTPKJF3GzmgQ==
X-Received: by 2002:a05:620a:1982:b0:8a1:21a6:e040 with SMTP id af79cd13be357-8b29b8491f9mr54211485a.77.1762890156399;
        Tue, 11 Nov 2025 11:42:36 -0800 (PST)
Received: from [127.0.0.1] ([172.208.127.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a84ae06sm44831185a.12.2025.11.11.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:42:35 -0800 (PST)
Message-Id: <52e3f589b1ce25085921453eea14b9c9d7c8f362.1762890152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 19:42:24 +0000
Subject: [PATCH v3 02/10] xdiff: use ptrdiff_t for dstart/dend
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

ptrdiff_t is appropriate for dstart and dend because they both describe
positive or negative offsets relative to a pointer.

A future patch will move these fields to a different struct. Moving
them to the end of xdfile_t now, means the field order of xdfile_t will
be disturbed less.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f145abba3e..7c8c057bca 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,10 +47,10 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
-	long dstart, dend;
 	bool *changed;
 	long *rindex;
 	long nreff;
+	ptrdiff_t dstart, dend;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

