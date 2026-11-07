Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040990;
	b=CduFMWy1OqT5K5KScQ83Z9qV/7+cx6BYL1capmTHdzPKx2dy4Go0ivP3dXIfqu7qyGko
	 d9mpQnZedgBVp3PeomybncOCVM7kEVTAAKoZ/WOQ1Ih8X5yDzXVDBmw1UCRqwcNiAR22Y
	 B89663V1b5SNABZon5+A5GWtjyIthIDV5+m0Spai7rWjZkT/Cj3Iw9bBU92AuTyFwmW9K
	 50deLh078T3FMoGq4baZwVj6wecdTIMPbegIp4m3AjDiXcVddgpYs1Jj3omM5pyTTHKEU
	 QGBLumR/5fuhTWaLK3OQ5LNwoJbGBOgnUbDmXrF24N7u2sMPgmrNJiSlhNNRKiMMinQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040990;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=4uGoMS4v7zsc2j0spSTIR4YtA8dNZ02eHFaYBWCEs8k=;
	b=DyVptmBfE0vcL3Ie1BR9NNPU29PcvguUOmJA1+qMyQcCwoSQna3cAR32dXzRrbSQIpqA
	 JfZ5OIQKOId9mf1yWaLrl47Ezx5dhzMSV5PMd28xR7HHNL4w2Jkwgi6rTSFbyy/LODlCS
	 QhIXMNC8NZoNpXi4ug+loX/EGkTr6Un+ZyK6Jh08thimDGEvFjCb2WovxyluahHG0HBOa
	 rKYnQvoTzk6hWHoUlPvJkKtJ6nzPkK45KW+H6bg9rxFq4xgIOPW3MY4xOtRueK3RA/RBt
	 UfQRvUtT76euQZB08kSMqL/CAVXoiOUwjev+sMGjvZmMtmjEhg7xViV9b2sblFVNpAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg2YzhP4;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E46606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E46606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lg2YzhP4
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-89f639ba307so545427b3a.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040989; x=1794645789; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4uGoMS4v7zsc2j0spSTIR4YtA8dNZ02eHFaYBWCEs8k=;
        b=Lg2YzhP48VuSPpOz87wV5iP7L5lVi4wHr50V+0KJwfkZj26WyhKZ/8QqXkD7gP7PC9
         z4DMLlmWshZS1mEbSCytxSDjwJJofuvKuIxhfWrUnAjDAUifqFK4ow84ieKkEU/ngtaS
         qVQCrcu1HIMhkMgjaW34+SP3bwVSnw9QM2SBHkr2VfciJYznP06Zq9Ngt4SPEkNolaIF
         RGCvefuHLAvG02kNAR3Js8mH5+vJpi845OkLVRbYC6GgErpoJb5KSY7SLvNyk/rf4y8l
         Tkm1tWuavjiOWcBV6ymkSI9zZpaQ4yQrKR3RuOTmtfizNGIIMdGC+Ezci92FEeb20yL8
         AQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040989; x=1794645789;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uGoMS4v7zsc2j0spSTIR4YtA8dNZ02eHFaYBWCEs8k=;
        b=KHOCj/zWA3EW/Vmf3wPRh25r8x4rCNDY+xZTzwchsaQ1BXDFFvWiXG5Nd4/3+kshfU
         QQQBOtVxHCEj3W6obUAuW4QV1xk200GZdLJ/3lCV6Zpvs7X4IkRy2BSVKsDAl3kLMr94
         rgAX4hU7u7pzBgJe/Ig+Q5Yhso0zJo5+uTOyIyUQxX4+l6SwdmOO/K9l1CVT8ymhFIc2
         xVRKXWHYtItFWTMh8ODfKw2I1oIZumR34omT0bZQV6xZGVVHtpqHfccYdD0H/JiKN4YA
         PCMeJovdj1eoRoZzx47T/8UT+ivAGk/fSywcaETX59qkKuwXPlzRtjlQaD9o+UYjE3Hw
         TLFA==
X-Gm-Message-State: APuU4Z8DS26vlZKgf7HAXsMVglcK1Zeau1tXsGSIJLLoBd0uqSHmQq92
	a3jjhjNb7ptzGQo5aZvA9O6minf8uZaOSu6EWoqSDXJohIax8fDzFEfJlDZgyTmE
X-Gm-Gg: AYBFou204oOBFscoFJnUBPeAbBcV/1AvoaiIj9UNMhvFpNwBcdlJvQK5nvzqyWWf6kH
	fGSKMefzui22mpHbE833wRTxHhm+IsyOHKW5fRBv8khFglDSdzFHv0ldJ68HFwjhrXA9lDUwBNH
	op72GCKjFzMfc++2akodsUUlwYgwAKVC4gXOPvzgd8P8UV3Kbssp2XeCXQ/JredH14h706lie2q
	SGUFLP4kxilk18eXSWEtw1Poq58wU2C4bYZOUIwORMPhJ+pQckT68HkokeB/aiF0q1Nicm+gk0P
	CID7o3YWUs7Ih7QFxq64OYzCoKSadsBoLNWk/Qh/UfhXDAGuw/2z99CAUuqduZQTwiqCVVidE7q
	zcScMQi/WUFRufJGASw5jQDxIhzAeVwv2eWBbigLvDOJSFTBUzEnU+4YSjFtX7iiKqps2fRE25Z
	urUvIMv5dSdOut8hJPY23nyrabs26LVOtJTUeOIAYDk5m/xOj/bqFGynucf8W/g35clDCCvCTr0
	vR77JNjty+zcHEJYIzDvoIaxYwGSBhnkWg5AV9PiRcGSe3bsk4sh9D4xfCDXrDL4KEn5pD09ay2
	LIr10LcUGauc02/rsaz+xUph/TfMGY56YA==
X-Received: by 2002:a05:6a20:a109:b0:3eb:a628:10ea with SMTP id adf61e73a8af0-3ebb2aab0bbmr5105288637.58.1794040989448;
        Sat, 07 Nov 2026 00:43:09 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35a3b3a1asm1213415b3a.43.2026.11.07.00.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:07 -0800 (PST)
Message-Id: <0991a1b80cdecc1db4ac59bbec3744cdf24c019e.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:42 +0000
Subject: [PATCH 10/15] setup: handle NULL value for safe.bareRepository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

A safe.bareRepository without a value makes git segfault in every
bare repository it discovers, as in "git -C repo.git log":
allowed_bare_repo_cb() passes the NULL value to strcmp().

Reject a missing value with config_error_nonbool(). The callback
already fails for any value other than "explicit" and "all".

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 setup.c                         | 2 ++
 t/t0035-safe-bare-repository.sh | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/setup.c b/setup.c
index 29474fc292..567a44bcb7 100644
--- a/setup.c
+++ b/setup.c
@@ -1472,6 +1472,8 @@ static int allowed_bare_repo_cb(const char *key, const char *value,
 	if (strcasecmp(key, "safe.bareRepository"))
 		return 0;
 
+	if (!value)
+		return config_error_nonbool(key);
 	if (!strcmp(value, "explicit")) {
 		*allowed_bare_repo = ALLOWED_BARE_REPO_EXPLICIT;
 		return 0;
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index 1d3d19f5b4..a0e0c48d7d 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -80,6 +80,12 @@ test_expect_success 'safe.bareRepository on the command line' '
 		-c safe.bareRepository=all
 '
 
+test_expect_success 'safe.bareRepository without a value is rejected' '
+	test_must_fail git -C outer-repo/bare-repo -c safe.bareRepository \
+		rev-parse --git-dir 2>err &&
+	test_grep "missing value for .safe.barerepository." err
+'
+
 test_expect_success 'safe.bareRepository in included file' '
 	cat >gitconfig-include <<-\EOF &&
 	[safe]
-- 
gitgitgadget

