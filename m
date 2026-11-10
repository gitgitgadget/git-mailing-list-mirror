Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296235;
	b=BD/cYHKpkpWkw5XHAGcp5PWsoxEBpl16sGNOx4gUQMWTKLGxtpscyY4NKqqw+NGRws9v
	 6RWs9299Pt4A1QHp52o0u9D/DdLSYyhU9ZddsX92M2k8RIyTFUvC9LDhYsCF8JW3CnSWB
	 pSc1gPWx8M3yXOZK1h10ZmluZuP+2Txjvp9BDXUWnGQw4R2zYEVQO+F7bAOpcZ7romckB
	 bLbXIDQ9dGpoiqXCT9QCnQq5RT8ragmyLbQAZt0zAnSBwWyv3iFPfkY1zp4zj1gbCnzyg
	 iLkrlc/biN98qVJmtCbJaX2P/tc+xOAq5VIQBv9aIwXJzSaUwsqKRR8TiXNSjsuydkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
	b=cGdwW9u2QLsg0Vgm5fEXYuAhybboLuDt+zaOCH35ECd8PUMz/ycgVE+WvpoUrm+lMubt
	 Vd5R1wJW790yMAe9ZiiSWu7GAYspg09NR2K/SxmgNc7Tycz9dqcm7tPHXrlqRfTRFkq4c
	 uM4GiPvxvFTY3CMuPZZ0c8TIBP2WkSl8mezMuKIY1KQEc0Gc7cXFdzZOjdVak8e0tLP5n
	 XcBOPQB2tdR4LxCWZscaapeDB0eKpkaK24Om2hb+cvUgA4l8IlSwEReuXO3cwAZKA3dyQ
	 KY9HCMpY4na1UE6izEaR2nsn+40uDWuT78kimlv3mX9WX8LEo2SJn0a3kpBQsmYhcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoJOhs6H;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F017760A6F5B
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F017760A6F5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoJOhs6H
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8479f46ecd8so857586a34.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296234; x=1794901034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
        b=qoJOhs6HK5qZzefW9fgcR8ndRsqLJzhEw8MuxnTT0ugUPMbMI05hVkM2qgSYvwqg1E
         v6b/WEtw0HY4ASzWN57zg+ykcHl6nGr7SMZy+x1sJ5ztUBtZ4P6gNcROVfSmjGJ0e4PB
         MxBOTmHkg5jpJT0onCWzh1EkcCrvrTkp1dI3Uqn0+spVdExJy9tEogp5ton8b0HOjGV9
         UIwdAw8AtrapWmYapKgeLZgX+Op8b9JsP4VpFLR4/L1VPQvIQZwNtyTlz04oKQgL8g3G
         /XrkMoolJ9Uytj4HT3Z01kppnA/7NZsiWzG8I0RRlzZ9XvqH2iIlatJBG9PEfFzPoqCN
         /MBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296234; x=1794901034;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YpL/o/lHDlBUGpuOY5VMYUzhkcxIyJQod981OJk+oDs=;
        b=AnRgqWXnLD3SQiHWBokjcq3BaWy3y7RnYrA6/QhePNQof7YDaK7MGNJ/pl+DuPlZFf
         BasAgXt/k5MKWBFDxn7xszudNHyGFUDsWTUOlLYnH83pbZjhSM1E924dT568SQga+uVb
         JUTlm/Hxk5Rc2lvsCtvsAXF+KZxKDRCY4jy1zGTz84RAo0dW11MqrG6b8VIz2ns6xl/M
         iXc1IdQA0eSU7T+ciUNwysy6RqUe4I2r6akFZ+QzsDLSfS7DoHKqqMCxxUHBEWbHqU80
         WZPxR7GmQX603DyQRpDfkuv03S7JjcGBf44XcBX3p7Me9mjE2SqqkPa9WcehEVr0mQwQ
         xI8Q==
X-Gm-Message-State: APuU4Z9SKeEStenc++YWo14Wi27jeaDyjbku/vY1EME7bUdJR1ud6AQ0
	UQSnaB53JIei5l125c6RWW0OOjE3JTHSBpfVizoXNM9N2yiwYl6mBL2rjMf2DWRC
X-Gm-Gg: AYBFou3+k2SN4TP6x+AK41KKcwXOTRh+d6YxnpUejE6lu9m56cc3dEsNAuLyBaUxIPU
	yXP+DmOBSy5rOVn7qvCEo14NYjnniUpiipRAsQdchyHzhhOn7h8DUSG9CCGYQINgkaOxBtAamfX
	xQE9Ki80cVh37v4obsHgPng2ZDLZBamHI4N9Osw9xtQsYWEyN+EO3vVzlQUWPbGfCiUOYM9rqwP
	XmsFBR2bOVDURf0vnLr+ph5CLBQUTnoR8lk1+aLGiPa74sKRaGI1HBy4Cujs1x1X0mnmyMIzlZJ
	F9UWiUw+7UFDkEDjAx0UF2cbvsT2Fmggi9FhlvuU0MtWCRP72zSk/Zy6x0/dfLf6oNky4bGXKAW
	zUZqmDbjSxpuhUFdbCm7RsgSRKtSO6Dgn+52X+0FjvbkkD4YpKR9hcbbTPWD36KmzE1zjWj5nSD
	dZbia1NEqe44FzVw0/rwQgj3Z0yOjldPwKI9bOIRkiSzzu7B5uYyqOKGy/xR+UDTe9DSB0E1xjO
	idhx0ZDuoPL71oLbPteujlcLOV9/5OlRsDvIa4Bx5QpzQe0yyoBzCfRyBQIcUjxItE3Da5cvoW6
	HjgEZPjiRLTf2VznIgy6fWPkeCpKItcwXsTEAMohDK2+Cfu+GvOzdXqf
X-Received: by 2002:a05:6808:6f98:b0:567:c40e:c79e with SMTP id 5614622812f47-5683ca0028amr1501461b6e.24.1794296233888;
        Mon, 09 Nov 2026 23:37:13 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905735edasm1452821b6e.7.2026.11.09.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:13 -0800 (PST)
Message-Id: <a5b6436943d4d0c9fdf4015106dd1bb89d006979.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:40 +0000
Subject: [PATCH v2 10/15] setup: handle NULL value for safe.bareRepository
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

