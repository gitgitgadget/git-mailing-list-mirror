Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512125;
	b=iDaqDD4j/FeEoDnBW11S/vdz25i7XZq2teT4PbNA9LJazehZNJHJDhcIOvNyNc48nuYm
	 GQR5FU/a4B8dSP5J1pjMz/+oTX3cxEm9DBAway9mB8kAzKdR1juxQUyIXI27F3xL+f4YG
	 DsBi5C+xkEyVJYw8uT2VrlUUHLEUIMb1+waq/kO4VStofEApOezjYeUTM88JvRgzKnRUP
	 cHGj3iv5KHZI5NTWChNBtMcEvGRalBJmJW+RJNfQWgDZ/Km6GLVhqPNfNLxa1S6PAqlh1
	 Cb7zOsIChHCoCUhsMr21uZ93LTZ19DykFrc2MmlMmBtxmg0wGL9+zEfueA15WovAXLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jEQ9yRnlCtcahXqvJtdpM0NFjMP8mp8Ed5zgtVcIH5M=;
	b=djWMRSOL1VjuZk0uowtjVXU53XiKym7DY2onIdftNdpVtO1vFyG7D0D9jybN1H0CmXIS
	 EW/cDY/70jM12059uVY5RSIIZMzQBwabgrLOE1XZLP5vjw/ZJqRLrfla77PCWJx5jxy0V
	 97BmzeDnsYSM8d7CBGXNn4CpLPd2ERjYlcXV3HweLLwBYQOVbNRgWzUSWYMCMo6Z50CjM
	 Tqit7EmtlZV2QsIoaTMm2JzqUrMyOaYIOdXotAKOf1pYcRCVan1l0pdzHh7fzJGJ963Ny
	 azfrb9VWhkTnKUumvoPln9LSbAo9OlpqJp+oCNnnCAwqFsPMNOskheVN9OoKGpUIPUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7RTdC29;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9D606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB9D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U7RTdC29
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so20250325e9.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512123; x=1793116923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEQ9yRnlCtcahXqvJtdpM0NFjMP8mp8Ed5zgtVcIH5M=;
        b=U7RTdC29nYDsKwP/SjYxxuagDU3Ed8Q9yXKf9nJMFFGOvVfx+Pii6BAQ3gnDV/dnm+
         2BiehszijGwPwPLogxJcxv3P6UWSH4sbwGQak+KMs941eey5vHeKvrYwKCN+X6P9GgtC
         mIZ6Nk1MTX/TFX66ofF6zCNHW6qpPZPAwREVKFxuvGeiJ1bbGFgZQuLenGEbB7xapiFc
         Yyh/K0UwWYXbw9J57OgdfKn8KUVAfS45wkAjBR9wF34tu/bm9pGXGVLwPzIrl72j11qw
         thdIfk20Mm9Lqw1XcwcDDuj3mTOlfkwtGih/6cCy9LVoM/wv0ZA3ZVWO5tQRMQeY9qJN
         8QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512123; x=1793116923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jEQ9yRnlCtcahXqvJtdpM0NFjMP8mp8Ed5zgtVcIH5M=;
        b=ey23xOhMt7dYHabqU3gUYfqQnHgqIan5DNRY8iZheTccDcALe4y9Zp5EQyzf9sZlvQ
         ygHR5iHcK3DrGbjmNt7ggng5PanM0SMJoduIu4D0rKI2SN8CJRB+G55uyM8artn3gvVs
         aND+j7dmJGo8I50rLkYWFeIPnCtG/aBH/XqQcBT9JI9w9p+khS2JHzQAIDVHY0sVXzd2
         yHTkgYyLAhd76FQJkKeTPeGPhTwPfF4kUzk/dQOSJmg2xNL1lc4NrGE3t8T4bx312PJd
         pyxIcjHd0Jq5T27YgDZY61sCCngvuJ0Qbp2MOZSqPetBy+B533VZeinBUsYK16wTl+La
         9lCw==
X-Gm-Message-State: AFq9FYI3NZVKXivcf06CeW7yRD2Gpm+zXjMrMs+ul/3IoFU2Ch9CgHpA
	DE9OKbHZsAMPDa5T2R5ZYLa2p/b+uuzr/+2sztU7pLnXZVYCPaqKZRT0A3su/4JQ
X-Gm-Gg: AYBFou1pSuLxf7a+fYrONoDdZGY9FSJ+pzdbVhVPcqejA3s/RIHLLHwEnc1KRW2OWlW
	WrS8KyzKowFWNZqfuzfgt6H7wacG7e+CZZ8pnkTNdGVUWQjC9KdxP0BvXCLVmI/QrGsRhYyZvCo
	hfga5o85evfC3fiU5Y2a58aouxXRNE5ApiRTzuiVdDA5Q9hDnew0GQWhUSOO+ePwlMjrDxWkL3m
	tYQqaEPk5J4oSOjQPloLXHBqRaq68QaF041Uz6qwYnPvkrg9MbOUzLodPthY2sOxCA+Fpd5gOpD
	Csg6mfKq35taCdzQDvUlMkhKYjs1YV9/eept+f+CJ4atwOZ67pEj34xRm444pXSmvTWjMO0XCiV
	ZkLW9s/1osYV4mch1v9LeR/UtdGdoQKgCIOqu/teSbgbVwikxbhif6cuKBM+4T1+9kIa83XbxQ3
	ogmx2uH7NtDT1gNZTugRLH3juZ4mMoQcOt5SROZAZPAlng7w7IUiGAmgG0jmRdLvhDni4l9DB4W
	5VWlB6fxX5YfPWKbqJ8/3ZH04gimpW/YyM9GKUt2c5c
X-Received: by 2002:a05:600d:82c7:b0:4a1:fab3:cf62 with SMTP id 5b1f17b1804b1-4a1fab3d2b2mr24299045e9.28.1792512122942;
        Tue, 20 Oct 2026 09:02:02 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm7157410f8f.54.2026.10.20.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:02:02 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH v2 2/2] t0410: keep git's exit code in test_grep calls
Date: Tue, 20 Oct 2026 19:01:27 +0300
Message-Id: <20261020160127.29096-3-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020160127.29096-1-dorine.a.tipo@gmail.com>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
 <20261020160127.29096-1-dorine.a.tipo@gmail.com>
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

The 'rev-list stops traversal at missing and promised tree' test passes
"$(git -C repo rev-parse ...)" directly to test_grep. t/README says
not to use command substitution in a way that discards git's exit
code: the && chain only sees test_grep's exit code, so a failure in
git is not caught there.

Assign the rev-parse output to variables first and pass those to
test_grep instead.

Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 t/t0410-partial-clone.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index a24b663f73..57da830105 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -413,9 +413,13 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
 	git -C repo rev-list --exclude-promisor-objects --objects HEAD >out &&
-	test_grep $(git -C repo rev-parse foo) out &&
+
+	FOO=$(git -C repo rev-parse foo) &&
+	HEAD_OID=$(git -C repo rev-parse HEAD) &&
+
+	test_grep "$FOO" out &&
 	test_grep ! $TREE out &&
-	test_grep $(git -C repo rev-parse HEAD) out &&
+	test_grep "$HEAD_OID" out &&
 	test_grep ! $TREE2 out
 '
 
-- 
2.34.1

