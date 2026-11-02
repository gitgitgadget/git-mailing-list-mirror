Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644180;
	b=5oT8S1XokV8F6TEfYcETrH8nBns6FLb84NUPey4VZhZagrHCsMjQxJFvSYDRSNLtk7bG
	 zOhBhcrk33D45jEMJPT346fp2qefbJMF4ei1IP5ksMKPTYP/e3ROAQy22y/pbQxqnJpow
	 PdmbvWUmTxSJdviHqOSyGHhRNPPqxxB4c5oXFq+vvTRzaLn6xDRmexu7p+Jj7isqqW8a9
	 fo5bKYOkCPw44pRTno+UUJpdMT5Ep09yeCPMu1dYQQfoXi4M32bWZ+hhweo9LP7pmjYM0
	 ueoXTzdc5dQOQeUcj9VfiZ0gH3Dv8wiiSZ+BwxybaXlMyTyySDgJyIlYwcZbFOJWnzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
	b=e28abtrv6ga4n4Br/qgY37YCF2WPr7lKnlh6ecnvMIbvcAqDjkHUXg4S3FMPkA0MLhXI
	 wuG4fB5xyL4QqgvmhfGpellaLZAmKiinlu6U0CrI5X5mbq8eijcpNBZfY1Tphs9OPCXTb
	 1euURvW+6xs7eA7vTiq7DpDIVYKNUTBgqLI5d0OGBYrSi5rUc01OOGLMkxUso1z89EwK5
	 VcfNZMQlNWMJRKWkQOTkjPy5uv78Gl0QDNOG1XUQn6J9q3RlvkbfKw+WCMBxGHdsjmea3
	 TxWmxPnPa8YfQipm6Sx2ydSDU8g9x0GtYSY5VbPfmHlNBKcw7t0MrzwgoK51MZSPyZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=InSedJJZ;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D6606A338
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704D6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=InSedJJZ
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5361e313e63so38845631cf.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 10:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793644179; x=1794248979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
        b=InSedJJZfw4qmXyvdq7MLpilqT9t3O16z3oGh1I+8lVZU7KQ885CcmI9e67y1ZfobY
         UioVhHQIVcCakDf4cZFpaRLjOFXVU/+Ep+tAZuuuYZ8PHAV6YKDGSoiTETPVWYm8RuJl
         TDtYwoRu01QSo91OVuj1l+WhNXmH7Q8cCHjPqdnWS3tK2QmqkRhnBk76uBB/pbksCOpW
         D08eyGRlwF5UIMTsZm5nw2brCQiwedMRmEEw3BlDCvw5T3ca8B8WYPjkaQi27Fbrbo42
         FgRLOQ10edrB4NbM2QUThDVVvcsQRpV3WQI3R98teiD1M2VNPn2r8NYa2jfFIJbp93Qx
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793644179; x=1794248979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ha1iS5MVJtTrl7n+2rsqliKQJHQul1FVZ/YwsQu8eSc=;
        b=F20sEwmeldBhYHS9qAw3M+1YG7oo6YUb8YWRbAujTnJFXPa9qKxHawNDxB5aW3nECU
         10sUTc3XlT/GSOAcQcB1a4lsx9ph7cHBTC2nu9hbOiDV8MuZiev0cJqofCSEVBEjPdwW
         0KSkig7KTHC9NVLBD1bgkEyuxHae9VaKj7yNXNRukLX3gkhdTNgBYApoFR67ByQUV8zj
         1k59h5AflbqBRTdU1lkr/NeumGEr2a9osHdc1ZlLmXKMMufEY2BpdOtQwxDYpiD/x56/
         NZPf9QdChdu3saG+N1RWpZIP+S2E4uO4T++kKVPnS7BvIyE5JlegVCBKmXYaiK+f4Wwi
         DKPw==
X-Gm-Message-State: APuU4Z/S4GtKpSPGZSAwizTODwGT5UfKTAUYwjF4CkZ3LZYXl2pl7e62
	XT4hGOawn/GN8nZugmLUB8ahe83XS6UDUTekG/rja3Vi9ID2mRXF0sFk2FBb0M6ulzqudNJFFfX
	4SA1Fpyt/4VnGawc8y/Y8tjcQwDFb3iZgGxtM3wmgiQzLwKZ8t52fMMi5/hZD8gWLhV4uuYlM9a
	JrKfhWZ2wBHKqhw7a0uZ0qYvt0fLhfCFgL/GokJ5H8FX8w8/fTEqnQj40JWAq7GbH/LmiMN0d8a
	YRbuXBQ7fywE2b8dwS+whg54q43l75GdhLaEkFg5GA=
X-Gm-Gg: AYBFou2i9i7gYKeuMlcmgnoSyGR3t5M6w/SWRd8XdT8P543LcGcaoKhLxjVwmju5Jkh
	caYbq9kVyEgQgPoiMTqTbYcfHiaapSTObeNqHX7DzDePwy1DNV7lV588Hx8dDn5tqjyLd1aLxdi
	ksvHM4Y+v/D6BG62InwksFNqiTzEZLOehyScG0f6O/3Om4/uWPt3J03qdypz07aOZZBNd5ksDSZ
	EYEgjlEeoNVHNaiKqhRKv91vvw96ulyi07k8E9P3PODoXrMs23DjxX83Ecgqnn0Q1x44B9Kd/wn
	p81ZgRUMKMv0Gqt7IRHz7dyxxMdz3HzwA7P/2FZa9jYr4fDNaqN0xzUFQVFXBd1AmHlVdGkBi1k
	a9n0Cn/g+zQT3RmoLWEDvyiBmLbO6oW6wPBW8kCRDF4FZqKzsMyucjSHiiWTozaie+C5pR43RHH
	WNBjJKjOzbv1yOWa24B6DiYg5MTmjHB7VHuSMup4F1Bd2x7vYBdyNCorTWr+kovbzZlFEDU8+9S
	zWl8DxDFPxkxyJMoVK7woZTzy40oe/vmi42CjJx3ncsOI60pbkyQLWf3N7e4aDl6eNqaui/YPmD
	Yzx7jENdmpgLzkWEykQMuki8UQHayYBKq4W3az4dKpjO2QIhrVtFrF5L3/I4gxYy9SfBwsesBZT
	2MS6u0OFHw0FaRa0fo86cRCmpBF1zt9/qNCYAE0b2B39hFStXA27I1Fj1QhSgSCN2Py4qw8khDo
	5gPr+9YBJwMr+i66QSHaEX7zac6/xc9Trv+Q5dFTFChtRDZpsBh65XOuVQ+CRZnxSKXJF6q5aBJ
	8N8LHsV/djhVwHm8ARRiPS1MQgUHKaIg16/902x53IAG+A=
X-Received: by 2002:a05:622a:394:b0:536:699d:9a1c with SMTP id d75a77b69052e-542b3979709mr186445301cf.2.1793644179303;
        Mon, 02 Nov 2026 10:29:39 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce29sm4346221cf.4.2026.11.02.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:29:38 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v4 2/4] doc: for-each-ref: say how to read %(worktreepath) safely
Date: Mon,  2 Nov 2026 13:29:28 -0500
Message-ID: <20261102182930.3511-3-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102182930.3511-1-me@jaspermayone.com>
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path that %(worktreepath) gives can contain a newline, which
breaks a script that reads one record per line. Say how to avoid
that: use a quoting option, or end the atom with %00 and look for the
NUL before the LF that ends the record.

Also say that only one worktree is shown when a branch is checked out
in more than one worktree.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-for-each-ref.adoc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index a7b31e8aaf..9247737aa7 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -183,7 +183,12 @@ but if used together the last option is selected.
 `worktreepath`::
 	The absolute path to the worktree in which the ref is checked
 	out, if it is checked out in any linked worktree. Empty string
-	otherwise.
+	otherwise. If the ref is checked out in more than one worktree,
+	only one of them is shown. The path can contain a newline, so
+	use one of the quoting options such as `--shell`, or follow
+	`%(worktreepath)` with `%00` and parse the output by looking for
+	the `NUL` after the path and then for the `LF` that ends each
+	record.
 
 `ahead-behind:<commit-ish>`::
 	Two integers, separated by a space, demonstrating the number of
-- 
2.56.0

