Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A94195CD
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683596; cv=none; b=I9hn965WvsyCgA42FTOOycknuENOEaAcv07g/41JTmoLfeOBBv2QNzZmn2J1FFtA5ta4xbi+IiNR1fqN7kNIKW5pjOBx+cb9HgUouRIRucw8a/YAGbLz1ow5W9U95Uf4svfI9wPAlxW5GGoqWJVrSRUqo5SIXuCKCm/FKOYKusw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683596; c=relaxed/simple;
	bh=F9FKv4Sug4MR8YFk8q2j3Sc+RifXOvgg/r96fLHomRI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uMsf46bIMESmemAFKtRJxF+FZBecht4s+Juc6EwxNc7UTl7o+W6fDpv4ugRyAvOuHJqj2EbZiqF8ZY7VZxE8+0VEOAIfK4jP/a/o0gRwn3nSJ267wwJ3nMq5tmkGRXH87Wx0vBbqT3Wj0l9hYOVtl9DR6mVwimjc3hGeCzK5MMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDuTd2eD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDuTd2eD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc84e77e78so5999575ad.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683587; x=1784288387; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7bpdeu3Lcqh0T9DjCdXFsMirShsTwvNQvJpBnRRWklA=;
        b=IDuTd2eD9GgQeC9rcF3VXTdXqkVYOorrmk2Fl+vEcmovyJ3i8pepl/Z4zwpqrkJS4o
         ZfXzFG6KnnlQFPvW/5bHJ70pdlPyQiLy+xffC+HAUA+P2/vi9SF4qJ1cMOoScYoQAQXo
         929mRt0LRySPEnTRDpem7nPvdCUpEs2dy0Q23fcBf6yPNghO0k6UG2Xk6sjUfxNId0Yz
         77Lf82Qtt6OMmi9+UGxbwO4ETFCDWRrzQsZTZHMx6UJ3xs2mk8xMk8DSfjwnpDpNRSa/
         /C7sF7MEc02QijlGJ7fAHn1u7kELJ7FNU5EpNbgMpV4jFcLBm5EG9JbKcBeApykNm4+6
         J69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683587; x=1784288387;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7bpdeu3Lcqh0T9DjCdXFsMirShsTwvNQvJpBnRRWklA=;
        b=KmsMtX7RGkqH3+JrBdfQsAi4i2xM2h7KeE06hohq97BGMSwqr8aNIWHHDQTrvzF6Hl
         Kr0mJvj3NI2lWjqTISx0Jd8AumcFS60T42lRG/GPPcjIALN4viZWf69GQzAiQP5DEghE
         YHNQTUAT4BPDczgP0F7XmUSLoAc8+sX4sGrKSEYpoGYAIRDxmLpCsUTZNR1LvFGZ28Vh
         QwrzWKFNQkjoQXdyh5VYNanpaXvYHjJF6d/VlVCTUBymZ1i1HmYEzl23n5Xn2FIJgOVn
         V9jKV0pjEWABRS9vPMyowyNXmqzEVr9cCTmYEsAuLDNTzSvA20vXfvNFkG9pNwCgbSXh
         Jv1A==
X-Gm-Message-State: AOJu0Yx6WWbFMaESDood/gvkytg0FkVzwk5MSg4+u/AU7q9eTI9OeApi
	fOfWFvWKSel1xLUMQ8eqYICq7lG5+Jlbb1yML9zxu/uamcgnAEEu23OHAq41bAH6
X-Gm-Gg: AfdE7clqbKeRDRiZAityZ9+WOEfxZuFfxrcTipkQp9MvflNaGMrrMJBYXWZu4anV50C
	jo8ACXvyNq+iTBu0j6ELEHQZEsz7DHpmMrf1CHCoS4JWczvGCUI3n8gxg+SPYMMu6akIiw1C3Pk
	cwabEKqGZLRGOOE7X6HboN24AMOr8oytnQgC781B+gIeuy8TFI5w/xFa9R2pxrVAi/Ml/2STwhp
	SBs8titt7ZTbOXCdhoQpp0/A6rFTf3l6wLK/XmoiYWkVUHsN8bNMjQSc/pwpg3YLyBfv3Um0NDT
	fscxT4SgWQxdPYfeXDeeZMYpj/WzocGKutIJJe1Es4muZ99uwAdCNKeeimAfB4vjPRvcvX4cc4y
	aMPwMEJMzjvPAHy1vwQUDK0tWaSi+wibIcREIbwNQT5jOSpnnYKikP6L2QBYBHtU2T+FzpDAn+C
	dZS8+ahampgN5fCdwC
X-Received: by 2002:a17:902:cec2:b0:2ca:ea56:7a58 with SMTP id d9443c01a7336-2ccea58039amr117750145ad.37.1783683587495;
        Fri, 10 Jul 2026 04:39:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm58229705ad.18.2026.07.10.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:46 -0700 (PDT)
Message-Id: <12c2c8450e0f0ee71cc6beefe6186e0ededdf806.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:29 +0000
Subject: [PATCH v2 05/12] mailsplit: move NULL check before first use of file
 handle
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `split_mbox()` function calls fileno(f) to check whether the input
is a terminal, but the NULL check for f (from `fopen()`) does not happen
until later. When the file cannot be opened, f is NULL, and
`fileno(NULL)` is undefined behavior, typically crashing with a
segmentation fault.

Move the NULL check above the `isatty()`/`fileno()` call so the error
path is taken before any use of the potentially-NULL handle.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mailsplit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 264df6259a..0993418e63 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -225,14 +225,14 @@ static int split_mbox(const char *file, const char *dir, int allow_bare,
 	FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
 	int file_done = 0;
 
-	if (isatty(fileno(f)))
-		warning(_("reading patches from stdin/tty..."));
-
 	if (!f) {
 		error_errno("cannot open mbox %s", file);
 		goto out;
 	}
 
+	if (isatty(fileno(f)))
+		warning(_("reading patches from stdin/tty..."));
+
 	do {
 		peek = fgetc(f);
 		if (peek == EOF) {
-- 
gitgitgadget

