Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2D23B52F8
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889494; cv=none; b=YAQXvYAhYGKWPlpZ+2fWFRJQWivmAzSRYUiXsL1SSeWlKUQ974+E0VSttsplwrO0IzRYtuBvTFdMojkFBjysBPkmKhBWpZx2Tkcjb7JclUHeJj5/IDlO4rwEc9wCD4MeRlSjJsRVWKTbfxuTiwpv37beaGbkjuq6WGI1B7NWENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889494; c=relaxed/simple;
	bh=mrBcuP5uqIYjQ75rlD36u0b9wt/y08coG9Knk8FjDLo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nNVRV7NldmT2QXxRChwCUPeDmExy2df/Mg0cVroBMnjqOHFvw4XcspzlSock7V2xWVAVe8FjRfhTGlkFknWZ/GZmMcP/DFK2WR5x2IPskcH757PJ+IzPTH3+hClXm4RAnimFS5Ftqz8FRjVSnLSjahJf6HSK3wcgRYH9nUebijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1hAWk+w; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1hAWk+w"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5cb052edso28201485a.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889491; x=1783494291; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tDKq041CEXhPpuz8LfGlSSIJN7u8oShSF1f6hHy0Lfg=;
        b=D1hAWk+w9iDDGYM4uU1S5tsLtnXJRyXVx9cp0ilD/rb07jqOZFiRecxcTcbnaYp5Ol
         R0CQ0SGlBZ8zIw2+gFalcdXvOHj6Rx57txaGFxmcYBG56VMz4XD2Zqx5pXb1armer3v+
         E9mvJi4VI07GP2CpV7urAZpGvks0RlLyw3JUpmB7Cy1yQNVvg2jAT9DmzGSR6j4RSyej
         hxceD09OMopYnEl5jXvkUr1whV/QMc3UnG3ykVn8O87ALmcQgLJj6HgqRXd/VxnRVUpJ
         NF5QCzC11g2XT3iAE46+gS3n16hWBvnu4YeXliorGIcn/yvAs/vj2/M+f/qrRpneRjRG
         8kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889491; x=1783494291;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDKq041CEXhPpuz8LfGlSSIJN7u8oShSF1f6hHy0Lfg=;
        b=RK9uz9Ttu/pHs5hylrQNshwfrHeEjzr5Uv+QQv+82MWJO+SZKUyEogBi+qEusfN8Fv
         6k0CN4qq+Gil/PWPAqXK8zMUTldl7gYte0Nb7fMesFV0xVE1e2mwDEXWh+9nU7fAL8sK
         FDFJWiv1vM+YqWmE3QNqD3TlKp2NUIBcbMQaHcHdll0NI1yEq2VSYExp9+yEhZj2xkZ1
         jyUTQ4ZZ35o1nJeSGkHkb3v+YN0lmaFDft9AwEBKG0+E8tsWdu8ReTOsnFvjx87eoCkn
         pZIMzMBQYF8kk21sBvUp4uFA69f6GB4gsGzjjCWR26yN1XLPf5qIzkGXDrJXXDPoEVgj
         9nfg==
X-Gm-Message-State: AOJu0YyQbEQ57lmR5bFwjBocm83Pfbj4Xs6bmz79QrPZDQF7iknaSnU3
	b7xkhovEd27U0twm0cQCsEcq/ui8zmyi7xjUHLdlpxY3E3eCHEjN6UyWkTn4Zw==
X-Gm-Gg: AfdE7ckgpcfPDq2Pz/o+IJoOLBgVaLuEJF4v6CDjPgl5ScwGr6qGVGD3VmXIeVYf7kW
	+r+LeN3ibLJYA3oZYdH0TxR9wW61y9X4RZThwTWvs9Jd1zre+B3PBURyal4CzAaieAQqB4mINmn
	4qbxvRLQpmA13m+H58e2paaIKz98/0FhTXEQ2ADU6ryHZkUxMYSc8qyh/hQwqsbc/E4zHTmEr9v
	N7rwGrss3sNcJSuBGGEprC6ba+ZPoHARwPsC0OafFNfgIOlzSuCkqc4U53Zt5ouAzB6pz2G1H0P
	roHsNXC1yfbtyaAi/NB77Qc1U4dbnLH6bPE2Nkwx7QOaggB8gSMyedaMrxfZvXDQc2Aqi+l0+rq
	r5ehxG+SkYiLzLRwUhCUhlJW3mhJwBRaKMq28bBPt6A/DzhRV2j5caBBU5y6Nf3S6Clj6avrWlS
	HHZ8TufVXi3SjF2Ovn
X-Received: by 2002:a05:620a:19a6:b0:92e:5444:9274 with SMTP id af79cd13be357-92e7825c336mr58685985a.30.1782889491514;
        Wed, 01 Jul 2026 00:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3611d7ea8sm13676686d6.31.2026.07.01.00.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:50 -0700 (PDT)
Message-Id: <8ad6b220e9ef58cf90c3bf40b80fc96b6d8bf55d.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:30 +0000
Subject: [PATCH 12/13] fsmonitor: plug token-data leak on early daemon-startup
 failures
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

`fsmonitor_run_daemon()` allocates `state.current_token_data`
before any subordinate setup step that may fail (alias resolution,
listener/health constructors, asynchronous IPC server init). On
the successful path the listener thread takes ownership and clears
the field during its teardown, so the `done:` cleanup block sees a
NULL pointer. On every early-error path, however, control jumps
straight to `done:` with the freshly allocated token data still
referenced, and it is never freed, as Coverity flagged.

Free it at the top of `done:` and clear the pointer. The success
path is a no-op (the pointer is already NULL there); the error
paths now drop the otherwise-leaked allocation.
`fsmonitor_free_token_data()` is NULL-safe and asserts
`client_ref_count == 0`, which holds trivially here because the
IPC server has not yet begun accepting clients when these failures
occur.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsmonitor--daemon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f920cf3a82..4161dd8282 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1418,6 +1418,8 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	fsmonitor_free_token_data(state.current_token_data);
+	state.current_token_data = NULL;
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	{
-- 
gitgitgadget

