Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040991;
	b=NGHvXtj9ibMMXSVhVI87+huOyj8Ri5eRK/E11tB4AbfgFgneFxvSV1vY71/QEgC7+dq5
	 29cmWASXIIrmprEQuagCPDW2cGCHvVXMAcX1EwB4B5pzHYseDSQezQVHVDSbrCDA3VqnF
	 aNbf8hPhnbsmF+22Yr2ZoXZFpGquYZwiN+G9WUFbPlriGBjw31DdPfQSF2F8N/M+iMrq/
	 BwlwMV7ZCSBVrV7mxsXY7izFCHPO6HNjYXE+zplNbw0L80FPdddCUVrZtESOUqZXcuRqH
	 nzwpxJqnBYw+WeXcrcNBzsr3PtwAHBwxRdCwyxfnY+5i3UWfc6HtnEn8exvtn7hM5QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
	b=Ji6W/gl5bGMPNJzCP2NniANkEtVnYVa6CLFPdYBycsZ7hmoWK0COcQbKmF+GHE3a8dov
	 7BjruITmHdFV1p8jMdNiaag07G19kc4OTQNK9oPrl/YxlMFAVL5BSqoolDZ0KZQHKf3VD
	 OazLVSaOFkBER213lXrJlsZT1J0gRoXXt44h8bnTDGsokEpOH+iCfJ4oYnAYHs2kOToFI
	 xKMof9JCBMpvrItZujKmkV7Gx4cuhYIFNVUTfEXoS/Kp6mjNy7l/ifmqP1DsjeAfiwCbD
	 jpNgcR30LW/T1FvTzZavC/pRYPWG3JWYpb8RZKywpWL3KlK1hbIhktzU845QgyiUdTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="iQM/ZFAD";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF0606A32D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DF0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iQM/ZFAD
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b0a2a44a0cso1102787a91.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040990; x=1794645790; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=iQM/ZFADpMw1rVQfgUASt7XkSW/4fG6jix7Js7D/E7Bs4lXKjorPzxcEbHuHZMsqIE
         SJOHXN0N2505oaMPgBhqf1odOmENNTpahy4EFtkh2fbOwdTrNDxmQ1THHZsJdfUUdJ9p
         OrIuHNEordgrn/9qlaeEq07jVx+muMBG5P1MP0OQ/vA8Kk36no2OrN9hkv/OQ2K6nO6B
         KeZuw9xxF6hpDxsWu0EmjK5/9LYqqrzxoQoHgCEaE+HyBEPWp/778eASLViGEr/g6AuA
         7UyaMDocE8rxl8CAn6C9dF5EK52iUPTv5m3e7IRVqU7JrzPxLnGfwUnGdkF1bAwO7sLo
         Yx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040990; x=1794645790;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MpQibAg8X4msOndVvsdNzuZUbPprPXfZAwJh5lqCkR8=;
        b=N+juAHWWxsnuQGNJIv8KF1E2WWQhWOYG7WfWq/lUqBNEYa7BvYOgpcmBX0J9tvX3UM
         vZgY3u+NHEoNOs47nqcRDu0t0s7BngoRyajhczmn6LnOjALzWXtNSzb5a1PCDItKgtdp
         O1vXDTGeMqv2i/Qw6NkKN6pqJvC/56hVkuBIICQ/GnuDqzump4Puwv1/jbt8nQMx1HND
         6snd/jj+40vBawdX1/zfquetNoe7F5SeI6dtjWHIu1IePfxRQ3jaV3nl3wnVzqKv0yFw
         zazEJrYoQPRd5qQnrF3PU63+d1XhThDkjgqHoQOu6xvTPqlPHdEZiIuLJhHpghJwpDHT
         JRPw==
X-Gm-Message-State: APuU4Z/CM/JhLPm+vKqEiA65Zpx8n4rASFn3qbl5ZAEHgNIrweo4Ggo0
	SfPSXHTLMd/+Vk9OZ762LioAjNfojYwAILeMAuRIDn9gO9eIm/VYjo43rSnkLQ==
X-Gm-Gg: AYBFou03LiHgwWCDHUTsUe//9n3UKCtDCwL9fKwepnCXRQhEjzHvvcnJ9eu9vv3I/W8
	KEBbCqkvweBI66ZPOH8/FoueqLrxkBCMsWbPY/1U0Fnt3sQz5PV1BAazp5p/wxyjuvDOKcRLJIt
	cXqvZTnEkhc5EmR3SAsc6UlUlm17Wql4vEGf4+qUf+zs9iOkDHLxfHGHNvjugDrDNpzfi2Z1PWT
	0itVUTVjdg0c4IPViX/pqz30NDeYWlZYoG6uLeFo4JYh3zcFRCakQkItlF+lTvD1B4I2WizNUfv
	sN6U/Lyva6ifSD/eVNbGljxrhGhWGWNbeKPgOOUYsVin+P2rKi5jqj4MIKl3tx/7vqybSmSdRuC
	B22vyBRZaLiS1C/oKx9+WUa6GhYhaHBH12uuANB+hbS/5wdXfcCih9Lti4gE9WhkY6WghZrSAh9
	4unN61YUsevMlxEcT5pR43V4A1h1HFhgq2iACO0GcMKdogLekouD8FEdTaAFkwn+Lcgq5tTzhZ1
	KKqzSaz/m7nZ89Up46MxNUFsjsUFSjWIe+0z1qHRGDqC+bdoCUKD1uLZaiTiZ85f1DEpUBKPvNK
	0yh65HGeB5ZT0RlpntByLiUBFEDhP6Yavw==
X-Received: by 2002:a17:90b:2749:b0:3ad:a17d:f46c with SMTP id 98e67ed59e1d1-3b0db738a04mr4308661a91.62.1794040990544;
        Sat, 07 Nov 2026 00:43:10 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105854fa9sm2909402a91.15.2026.11.07.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:10 -0800 (PST)
Message-Id: <3f4cbf44948afaf9c2010fafbeab3c04ed4cb442.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:43 +0000
Subject: [PATCH 11/15] pseudo-merge: handle NULL value for
 bitmapPseudoMerge.<name>.pattern
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

A bitmapPseudoMerge.<name>.pattern without a value makes
"git pack-objects" segfault while it writes a bitmap, e.g. during
"git repack -adb": pseudo_merge_config() dereferences the NULL value
to see whether the pattern starts with "^".

Reject a missing value with config_error_nonbool(), as the callback
already does through git_config_expiry_date() for the threshold keys.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 pseudo-merge.c                  | 4 ++++
 t/t5333-pseudo-merge-bitmaps.sh | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index 22b8600d68..19fae9233a 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -150,6 +150,10 @@ static int pseudo_merge_config(const char *var, const char *value,
 	if (!strcmp(key, "pattern")) {
 		struct strbuf re = STRBUF_INIT;
 
+		if (!value) {
+			ret = config_error_nonbool(var);
+			goto done;
+		}
 		if (group->pattern) {
 			regfree(group->pattern);
 			free(group->pattern);
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 5b2a17f90a..e7e6b2f8a8 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -233,6 +233,11 @@ test_expect_success 'out of order thresholds are rejected' '
 	test_cmp expect err
 '
 
+test_expect_success 'pseudo-merge pattern without a value is rejected' '
+	test_must_fail git -c bitmapPseudoMerge.test.pattern repack -adb 2>err &&
+	test_grep "missing value for .bitmappseudomerge.test.pattern." err
+'
+
 test_expect_success 'pseudo-merge pattern with capture groups' '
 	git init pseudo-merge-captures &&
 	(
-- 
gitgitgadget

