Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746D1C8610
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927996; cv=none; b=gUg1MHicAmhWRbqs6IX7TMsbDiUKKkNSI0DTZYVY7ZtTrZVDgI+maf8xrB4P4hC++HHMi2glxMzgk5rVM01eNJfnkrXx0Sj7P1a3NrvPp6E+0lEQG+FE3pWVx+GWRk9unRAujvYqGi98zHd4QEUaGmSMpdtbHLpPoZ2pucZjHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927996; c=relaxed/simple;
	bh=UwNe/BXaM03U8WWVe95ed4jGL8/R5eGUt6cU+ggKydA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=QeZsBY8j4axW63H1kGpUDcjvYrJk+B1iUE+paOIOe3Q/kcyOh1xrtsAcvvsHWDjHrEg5zRICTbjt4cJngbwphbBfaJm4fWemO1uU2BAgwvWxM+SMG7OWEyJ7U0qa/p2o2yKnyjQkOO0Axk9yp49dyYPzzRX0Cs8vllxlAQx8N0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp3D+RpB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp3D+RpB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so562138f8f.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 01:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750927993; x=1751532793; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psfQEfNOZQLPjNtg6orsARBvoo6fi2sjOtI8ERQLqjg=;
        b=Qp3D+RpBuQcZoyJD0PiUL32RaU2pjuUBUTKcHV0bidSBHDpau16niQAOg1fZPru951
         vTj0icEY4/9oaQB6PrzqmfUZKB+ld5sI5netesDtzjUIqUauhJkEE3PX4t7hGjN+D5XE
         vFS/NqUb4X2m71hSOr/+mMTM6gsIFdShgcO5vnD0jdGM0ObFB1xBOGyXM0E/l9APdBQX
         NuTdk1z2L22aXoMBAMrM0F1/MSXc7t+Vb275/F55/aY1aAEOEUPGPQ4Shbjuvg/ur8rs
         XL8/1RS9Yb9gKOlgtl2DGx4ak9da3xQl2jFaEj4GuH3XZpIiFoDMCMUBnOqU1NMDloWo
         38Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927993; x=1751532793;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psfQEfNOZQLPjNtg6orsARBvoo6fi2sjOtI8ERQLqjg=;
        b=RjvgOXcdVnS2LsLTHE/X+87KcegoQA+dYG6BklsJtbqmEYXQxuLkyarsNun2GcqcNf
         MYtxBJDT0d9FRa9YBRHCDwZjAkLq9mh0i554fAqCmqlfw9RHR+i/m2yN9JyQvHV5fKsS
         ujuNsvaWutfX34YvQ7hrJ6kadNOI3Dz6sNDryyllzuqk420Vd3RRAg40DQSxcwt5i4ZN
         Cw7MJ8vvfh8NcP5HQ+Tizgbg6dsKQ3ndb33gnt/3plLanhn+oVECWPn+rVB6otZnHK+C
         HF7d0b3pP7uWwm44kcrwMHybUXIbXDrd0Ek6jETs8Toqs4vl/5eYI5C3Ct3doij2oLFO
         XWvQ==
X-Gm-Message-State: AOJu0YxjBK+3TXCg7+xpt1SgVsuRim5urJDeFVZ4aGd3dfFmQ15eeuZm
	aDZZTaTw9NgZwG6KLTz7MKJsh/lLbkvg+ze+EKnglVdarxPMEWqUSRaRtuDdKQ==
X-Gm-Gg: ASbGncuiVd49YDy4G6voUxbajnxzcT2RXCbmsRKAnfnmrbSiSHHQkYA4zR7pvEHLTje
	+VJfB+8v8AYxGCcD8ZqgtaP46hV9v9+OZM2AmipzEo3mgRisg+3FMcAiNs5IA9iEIDXjLNiZHPl
	LXolq4CCdJtbNydMMmcmwIHFSIk3mpVBaIpnqJDOaW7bv6df73obbIE49LUEs2m5OrVs3r2e+AU
	Mc0NaH3hI7sG2R+TxtkGyXqD95lfUrBS3N9MqROqGJRMQqX8+QhswZhnJ6pSqwjKbIvf2iQ9RrD
	jTyFWsxscn4yDkrFvaK7EJ9mCOvg+CLI9EwayJV6yGft8gOxHLGLBAOZ56YG55M=
X-Google-Smtp-Source: AGHT+IGLawHvrwRgwqq7PRQqTPXMLAOp6lLL69wMJGArTG3NlwBS5GvwPXbXnT4PC3YIeAeDmzl4gA==
X-Received: by 2002:a05:6000:2210:b0:3a6:d2ae:1503 with SMTP id ffacd0b85a97d-3a6ed637b3amr5244012f8f.34.1750927992585;
        Thu, 26 Jun 2025 01:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f67c4sm6873931f8f.62.2025.06.26.01.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 01:53:11 -0700 (PDT)
Message-Id: <3f63479119ffe6fdcf694dac3cb47cd7838564b7.1750927989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
References: <pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Jun 2025 08:53:06 +0000
Subject: [PATCH v3 2/4] compat/mingw: allow sigaction(SIGCHLD)
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

A future change will start using sigaction to setup a SIGCHLD signal
handler.

The current code uses signal() which returns SIG_ERR (but doesn't
seem to set errno) so instruct sigaction() to do the same.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 compat/mingw-posix.h | 1 +
 compat/mingw.c       | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index a0dca756d104..847d558c9b2d 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -95,6 +95,7 @@ struct sigaction {
 	sig_handler_t sa_handler;
 	unsigned sa_flags;
 };
+#define SA_NOCLDSTOP 1
 
 struct itimerval {
 	struct timeval it_value, it_interval;
diff --git a/compat/mingw.c b/compat/mingw.c
index 8a9972a1ca19..5d69ae32f4b9 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2561,7 +2561,9 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 
 int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
-	if (sig != SIGALRM)
+	if (sig == SIGCHLD)
+		return -1;
+	else if (sig != SIGALRM)
 		return errno = EINVAL,
 			error("sigaction only implemented for SIGALRM");
 	if (out)
-- 
gitgitgadget

