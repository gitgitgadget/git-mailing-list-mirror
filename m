Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892538;
	b=3542FgkIosRHEYMk6vDElEZBrhSMTNv6ah0HeTeZjAG0bGFFcpjS0DLbV5gREcAO9ztR
	 RYGDs4NzWeR4ygkplZ2eS2MKMGfyTjk+uItWnzT4AdOQk1Vp1hpQhbm85cqk5HxojfU/C
	 4dyYNpvkB8tg9UhjtBu5lA4Z9p1bwv2g7P31jIT8hZu9fCYst843Y8r5nV+8w5jv7hYb0
	 KYaZYW6E7/JHE45aQCh+Um4iPZufswlazLsOY3KozTqG1RMv3z68DhWnjgZ1A3DeX0S9Q
	 Ff/tHzwR/g19WtcitlQdasFljGn9LfOMFoZhkiIjsHDt4UTjja9yBa82F1ry4Rg8VKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4bLQBdI7z259atoeN1vilEAiSpS1f4bpFXzDQzTg2k0=;
	b=47c2XZne410Gxk2fQ5MsCKgg5Ds2mK4dmR8+jsSTFZLbjhERNgr5KQCEekDa7/aTv7xb
	 qmTLXybcJj/00PBohGgSD67FwuIh2TYDashs9m8WbwLF4iYa4VQEo7tqsw4RzHoJmq96N
	 JNvMSo12GCJqAZVdz7ueYhYSB884ec6u2E66UoKTlhMNfHmGWZXn/mfDPn5oTaUvZLcDQ
	 9ImVT7is/dmwxB1fZVuVddXwEY4mm/W3xmZOi3HN3jJoEepEnX97adGuF4bzNfJg8ajMu
	 nYqSEaNhNjDnaPAPNaaVoJibN7F5rNTkVSNFA1pIqogwshQCN2IX2x/JV56q/Ssy/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCTlJVHH;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37945606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37945606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCTlJVHH
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535a54bed9so2644543eec.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 07:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793892537; x=1794497337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bLQBdI7z259atoeN1vilEAiSpS1f4bpFXzDQzTg2k0=;
        b=XCTlJVHHLUoJTFnfLTJfDR8NM2w5mB9TxIpfVvWqXmyEhzREYL0zpWcZmTy8aCTQnH
         fretLg4dmTxHxdewXAUs2+EQb+LT0tkyfUYfXgeWO/fErS0Xh/fJI0/IVVKlbJqgKHRn
         Xt2lQwNosYQVschhZ30j96X6u6tQd41bJVmprZ3lfdH8Se2QBQva66r+csFk30f96ys6
         YbS1Tl9CYDlukzxF6r/LTaYEiMJ2NoRhy6cJoy5JLMO/cxgYyrbdcpjwadoWdPUAObo6
         01hFmxlPQz7vae58tRs91DnLtl8F0/G9ryVj8sn2VqhGBDmc31JH24hst6BWrD9exKzl
         Jthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892537; x=1794497337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4bLQBdI7z259atoeN1vilEAiSpS1f4bpFXzDQzTg2k0=;
        b=Hxo6etfOz5FxrcEQXJg3fB4fV4dFggslXnxgiLU7p2dF1fNJB2pPOOaAjuQEFAwZHu
         MWbnaByPTna3oDsK2wG+GckVeSpvXc8VGx60aW/eA009F+4URHIey+DWFXojwkJbHIbE
         y7h3bhGUUpHZ3DxIxHGhNcakbY7GSeHYFFpjsfKFAcu0J5ZA1QQtz3WNG7UllW4mU3Nd
         ISGL5/8Kqtue064dM5lIMAjNkzgY1yWXnNFIo4VYKYEMpXd6Ka8W8ixPCJtN5zFe+BUS
         m4fBcGJkZ6I/b8c0TP6e7jgU3bRjL01TF4pqtdyMP5lxK9ufJChRu3Skn+KhRRoYOczX
         ENWQ==
X-Gm-Message-State: APuU4Z8dNA9cYCi4WG10ZKq5RAexxSa3X2cm7PWmk+rD1tlZe7FHZ48m
	kCuuECeugXpgSfcD3GytvRgqGy/mLnc0WrT/2FP9188vU7+3UWIuHxmkIjVLs2C8JdA=
X-Gm-Gg: AYBFou3IicX0GMBAv5wiVZPj/04oYLVBaIztPnM7tl1sVrDBvAECQrayISWXLVHMryM
	HwNig0raoy8jJ7E2Zr8+TywiWf6Nxi/Mp9AwQRVtnMJC4PNqhVberm2gDQICCzWen9lZ1Tb1zuC
	JrrLzkRmHL2hdhnWEh2DszXiIlHDH+gQkZ0Or5aNLfjjAPwC+45Du4oUf8ljX7OtUAeV5LLej+O
	bseAL0TenNp78AGe0wyOXdNkv/iklfbd9DtmOlbtCS+pGhGgauMNENxEBHMi0Ux5H4R3ZehBmcW
	bULsL2brr8Egj8Mg1GECon56Wr25f1VtvolAyJNG/z3SggR+H2/Re/Alc3Rn1Gu//LSZd7Yvv3z
	V7erKhNSMcK/CRJ1KmZtVDoNnuyU4T2Z3vgemRcqsldUJ2ad0hjeuKMTH5ngqWiMp8zEWvKSWVu
	ijcor17hZWlHcSq8bZv08LhEz2LIzUJrlD4Po3H1khLNbWh+VN1XeqmmYPoDjdTJf4LSih5/6Mg
	8C4sQHqUH2oCfN2O9MpA2WbzYbBFdUS+T5CTSEQobqbHywx2qwEfhVWeuNeFJfFJ7q7ynpY4EPB
	b4mNZW6yWjTclaUb3TKWNjgnn6bDeDkZWlJ/W9hI/04FA7BvM4nkjp9gACTCt759zc1I0naQsg=
	=
X-Received: by 2002:a05:7301:4e8a:b0:36d:9322:b7fe with SMTP id 5a478bee46e88-36d9331fd06mr7802252eec.29.1793892537016;
        Thu, 05 Nov 2026 07:28:57 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39972d4sm32391113eec.26.2026.11.05.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:56 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 3/3] bundle-uri: do not die on unresolvable relative URIs
Date: Thu,  5 Nov 2026 15:28:42 +0000
Message-ID: <20261105152842.566318-4-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <20261105152842.566318-1-aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com>
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

A bundle list, either advertised by a server or given to "git clone
--bundle-uri", may contain relative URIs. They are resolved with
relative_url(), which calls die() when there are more "../" components
than the base can absorb, so one bad entry aborts the whole clone.

Resolve them with relative_url_gently() instead. When that fails,
bundle_list_update() reports the problem as an error and leaves the
bundle without a URI. The download code already skips such a bundle,
so the clone carries on with the others.

This resolves the TODO in t5750, so update the test to match.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 bundle-uri.c                | 10 +++++++++-
 t/t5750-bundle-uri-parse.sh | 15 +++++++--------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 2bb2eb99e4..1f198ef9a9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -210,9 +210,17 @@ static int bundle_list_update(const char *key, const char *value,
 	strbuf_release(&id);
 
 	if (!strcmp(subkey, "uri")) {
+		struct strbuf err = STRBUF_INIT;
+
 		if (bundle->uri)
 			return -1;
-		bundle->uri = relative_url(list->baseURI, value, NULL);
+		bundle->uri = relative_url_gently(list->baseURI, value, NULL,
+						  &err);
+		if (!bundle->uri) {
+			error("%s", err.buf);
+			strbuf_release(&err);
+			return -1;
+		}
 		return 0;
 	}
 
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 70ae94c4d0..8abf8f31ae 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -68,17 +68,16 @@ test_expect_success 'bundle_uri_parse_line(): relative URIs and parent paths' '
 		uri = <uri>/bundle.bdl
 	[bundle "two"]
 		uri = bundle.bdl
-	[bundle "three"]
-		uri = <uri>/../bundle.bdl
 	EOF
 
-	# TODO: We would prefer if parsing a bundle list would not cause
-	# a die() and instead would give a warning and allow the rest of
-	# a Git command to continue. This test_must_fail is necessary for
-	# now until the interface for relative_url() allows for reporting
-	# an error instead of die()ing.
+	cat >err.expect <<-\EOF &&
+	error: cannot strip one component off url '\''<uri>'\''
+	error: bad line: '\''bundle.three.uri=../../bundle.bdl'\''
+	EOF
+
 	test_must_fail test-tool bundle-uri parse-key-values in >actual 2>err &&
-	test_grep "fatal: cannot strip one component off url" err
+	test_cmp err.expect err &&
+	test_cmp_config_output expect actual
 '
 
 test_expect_success 'bundle_uri_parse_line() parsing edge cases: empty key or value' '
-- 
2.43.0

