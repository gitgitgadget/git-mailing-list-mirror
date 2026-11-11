Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437381;
	b=sKZthmh6npE9kU1F++NFoqTf24MrzlleBS60gH4kQeRukNNQWOxa4X5Ia1QcWlPS+/kP
	 J0681QGv/ZZftkFmIHp0EUeS7rBzfjuHr5t5bTs2lfg+Uw+Gmn4McnxgQmC+MUQjEElPh
	 iGpX/a1rriD+zjD3cQpEpI48vj0ja7hh2PXVYNFTxXfUALFqY7GLacFP4gb1V6f60vVaW
	 0XPX4V6q+M1/1uNF3BHj2JTtLSehd57D2iSZxnyR7pdi9yAcdor986MMHJwsYc9U9NEgB
	 NjTmeiLuwrBcl3t0EncJmCVcQ5SQW0hRS+gDMwAcERqV10UYzMEcacCSNe3fvx7d0QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
	b=dGRLR1CGcUt4MOIQbbgzkjuLfv4oxGIZgJlZ/3IsF1jqXjbya+DCHcVNYcpAihIM7c2Q
	 iUOGN68fRYdj8F9O1Nt4X4rPxDVdCiqG2VmrU6L4mWC89GJeum/HUqVope+q0xYMK67TU
	 d+dStnStKyJZviHcg5Z1U5Llwl3v6Ty9v5guYNP8/LuwBa/PUDM2wnkUoltgGTerByvDh
	 udKsJDeW5FC0V6j0bAGJxy2iHQxzaX7H1auTp74PpzkyOJ6bLmAW2Bnfl8O2jm6jZQzdi
	 rFqAjtFjRiP4BelE52LYVdAdr1ybISilQGCLPUixhKU0NV0qWp+y0cZxXiLryDTT5PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="So14qje/";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294760A2633
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5294760A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=So14qje/
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-84e513877a3so271692a34.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437380; x=1795042180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
        b=So14qje/+q15KJc1ISZw1qJlyM+uhw6tRvEIXMN3DNeHgQzcSRyEQKgU19jcgcljvA
         mZODxDcbyJMv7hzhruBFznLWizAv7lEwM9KCrO2XKU/nUxbyyhBYv9KBqeMj8UsdOsZP
         DPLXgJJ5tia3VP5wG8EYLz2v+n72U9m1kjBV+7k9pkOwHRDZIbdLCNtFWFK0hgWA79ai
         KwOgcoYF7dCUYGDqu9tKAEr/X/67i+9tnpf2wf86DNoVW1mJmQyLf4V6pPhTf8ndPF3b
         gW6ZvyGauuevtrv0eHR8fyvFXUQARnIt9oWB5fhyMaegm3nNB2LH1g0brhoeiVsbG66b
         A5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437380; x=1795042180;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
        b=qbWnxgZq+5ctrXn1wJauGCtSJXb7WeMGb/aaMDJwd+Shhrc+uKIpXthVWyZe11tTNi
         mDvRqGQkD8ClscbwlLmKT2shCiqa5m3WkGUf7sTXJgwlZaqpgYcI23HLZ9cpwtSlUQPq
         +Zke02uCpzMPFCq/jNZ/1Sb9jFsPJZuCcZwQ3ySGVr0NJkwGs+UPj9FQGVq/cHlsnaCb
         veSevMMiZ/MbWU5m+ZTUP9HcQo63jMT8qO3YiIzG8teOeN3qNBTrfzmzNK9pg1fymXUI
         wTBrwS1WKa+GckcdsdfDwF9J3ligM7UNY6jbWkLXDycsZwxOc+i5yCvdUhx4ANLBrScZ
         YV1w==
X-Gm-Message-State: APuU4Z8ELA29iwxuw2hJ9YrCoRIYpWxBzaY7GTb95piI8xPWuPmMcAQF
	YNVBAXnm2TUewH9FnF0P/TEzDRTZRWijkyYbSs5irWh4PeaVIAMTdtLY4oPZC8Ty
X-Gm-Gg: AYBFou3oGV/sxsuqyBy863tpIqVGKU31c9pY/6qNcOL28ZiwHf6BKI1zW6gyfN6G608
	hXICriJ7JY07wpzm43qwtRgfihiIA4J/kuQcs/Gmbp1q6wdPF2+f8XkLgtQ8sMwitftbvGW0fC3
	eI5gZfucoOMGPpvfENBYYycCNVIGwlA2U+USi4c1LpQxPGNTAhpyMr9B5A4WIAhW1Ay1mOgxY9T
	ZhyEIFjrH0uD0eksK7cVzctH7NhcY5UIMi0PpP7mgnSbmZH/YTGCikhBarz0HCtt40B0RDxwg6L
	uvjGg7dq2P6AB6zTYAxiHqjedJ7vYaCknzyedKMqsAP1CrQuYtXlqIFb4H/dZTlsDUNKsq42y9m
	8XEruIhkWFgSPlDYcf6e3820Ah3pelttt+OPLWyNoAlXxPui18p6uS4YdvJYStcj1Fva4Hq4/Ut
	gErKcJxC930VIIubyZhZfAvRJc+KuyCrXRRMNSw/2sYfj5JxznmNhSXKopzTAdLUqtrOL2W/Axt
	2XmPvLoaoafuV65LzaIX1/1TNOK4hA2uMQujG/Vm+ky8MECMxWsXix06k9Q9IKQ3uPFYYWKR22x
	FNTu8yx94qEtEq1/k/3s1sT1IwLawJNSoQI=
X-Received: by 2002:a05:6830:2543:b0:804:e0e8:1a86 with SMTP id 46e09a7af769-861524ead79mr761193a34.1.1794437379084;
        Wed, 11 Nov 2026 14:49:39 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860e5978892sm4384665a34.12.2026.11.11.14.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:37 -0800 (PST)
Message-Id: <bb6eecd20c6c823d0fabe8441aa010cc150d2bf1.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:10 +0000
Subject: [PATCH v3 10/15] setup: handle NULL value for safe.bareRepository
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
index 186815c780..e9a1bdbb50 100644
--- a/setup.c
+++ b/setup.c
@@ -1531,6 +1531,8 @@ static int allowed_bare_repo_cb(const char *key, const char *value,
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

