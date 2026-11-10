Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311416;
	b=KDiTLaYCWlZ7+ULelU4po6COOnx3ALYCwmNyhlJXS47zHBldmOLQibRAZFEdWnRM3q0P
	 JE9uK2LkueOBKoZleG1E+WHFiNbNzCRTWxN65JN1SefQQJoMM/65P6832RIeYfQqLq/+r
	 EcmzN8XbLWUJLmU2JvFoYrBc0lWni4EyQfHWgQcTqvl4RBOb8AqTbnCs8ZosEbkt/7x2N
	 EsYvHxcwDj3wbg/AkC4yrsh0ahcDTUpqE/H+JIqwSzn3maZfto33I1Q03ZMV2P3MxdmDu
	 DdCSecPL3r0lhEyNYd5buct6eIAQPFuFT+0JisF5bfVcZHXFmcp/KtW9LGzNj5szpgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=tfCCjMH9BGezp+gJQWEpFaRqrESYtEZJwXDt9RXFM9w=;
	b=pkPhy62PjESP48Z4rv4AUdNsdNyUC0sf5LClagPhqGZhOr75NZ3K83GTiiKgwlFH78jD
	 2Fn9AUq6c/OxL/4BVyAwByIL/KHBCxLVxJH3pZF8iMKgf+DfliYJQuo8eCOY1YIghL/Qr
	 zW/i2+qypN8lPXkiQtxQORgLkXsHddPIlaDNhaNs11eXV0howDM4oMyQcK0KfWAQrTWGG
	 SGmWyHbEE9SrQfCJCGlH4fwX13eXl47lRShZav3EzJV56yxeRXdXpvYMh4fHaIDNX+2az
	 tGYpEHyynuHClUc3vgZ2wbHKPrspmuQHNkwo+gYFMX/5ZRhAUOjNHbPVoK9oF8xy6Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUW9Pj11;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CFB606B5BC
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 11:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CFB606B5BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lUW9Pj11
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so16181105e9.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 03:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311415; x=1794916215; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfCCjMH9BGezp+gJQWEpFaRqrESYtEZJwXDt9RXFM9w=;
        b=lUW9Pj11G8o22gHxs18Cwv3IlNMqm0YbkvcI1Nv1HqYgyVJwGiuvjyp+SpFEA7CMDz
         m4LjdJgVyVJxHG8YETiFctZKi97UunJhySG07Lflw4RWgce3z1cKeKGWib9R1ZdThas8
         LOgJGUUNMGPMOdeKxuAoTNE9Nc+4J4vwLqdZrxkFM7rtscVJ2J+2K4pAuYPNwd5sZwOw
         G4YWB5gbgXdXlegSj1SQbSfBW633FBXe6kge9Sc5CCTjJ2+c/M7pU30041OyY/0qxhxM
         yihA8FwffA7RhbrKdTUzOgCxrlcnmPBvBp+VG94QIGRGT3SSHtQON2RmCFR479buUOEd
         kHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311415; x=1794916215;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tfCCjMH9BGezp+gJQWEpFaRqrESYtEZJwXDt9RXFM9w=;
        b=P7dnv7j9j8f2+mOjxneVluyojhQtnpNrWi8XwHuGY+uuii6SuWJqgKRgg+FrOkZYMI
         PpibzFZjfSFmHmoiBjsLD1q5xuP2+o35rT/oNTlrQo0tcUWp+ahNZaOvvS8PLgtHCNUT
         ncfvxWhI1let1J6+HJ9TDRTnsLw7021wZm3UPvTcZd2Ssgj+I4yG6UdCkbNY3df/79s0
         mpdfrN+4WWXrNDekONbjbG7qAFWXBKHNR1ltqBQE9qsRrYwMd9544FIEcG+PriiW8+Zi
         jZnRKcF0z8kfOl8CFF4R0E/tN11ybclJaglY/ogR7sAV42yHmLUpYt2ejOYuK9yKlpLF
         tj8g==
X-Gm-Message-State: APuU4Z/71SghQPc39FNksWOTaqABqrDy14XYXZeB2sBfbm8UZou38X4q
	FFP4GmCQGE5WaEAS8suoRLvAuT1dMug2K3puN0+qC1iSu1Md5f0sjPr5k8UQfg==
X-Gm-Gg: AYBFou3BumKlCEvZTKsj4qbzKmpZrLZNSMcO2mJBjtw4MIitsg3anleoPh4tGcAEARZ
	BwE19Fj0GbX6QWdSkvtM/etw+XpQA+j+R9pTXM9SpuG7ZHEC0lqQHafNOYu9n60AdRUJM3HX8TT
	npNotsxBvcTu6GBOkmDkZz6dSoZGY6AslYm8hWFPVEGE741z2f/2CRXJ6E9bqxFw+z+KmOPsmRG
	qPILXEfve5h6pRObdEKX8vVuXjBX1l2aO5m3QYzuyxPqc1RuTOTGCyZ6hHR7SU7nHUQLrS0W0t5
	JERFemprgDU5uaoCxTKL78yvEbPpCgQgmpW7Pty4q0fW5TUw7qEVBhtm3qLYFXx4ovrH4J02sls
	MlpQtbdXxNhpOdpKqZ3IdA51RybEXS2tgUgZpxOLFiaPlpUOtPz4eM2bbNNOkp6cAnebYzXVYQF
	aHBjQj2J81+n+XWA/HxrIaLxtT7E08goAAw4yjPF8XC9X//ZLeQUTd13B/cW93+MyqGDiB4GlaE
	m1/8s3PI4WWDrm5AXUcHcxSvZK2ZThYA5/89CI1lhY3QHGxMjjMjpOoFNntcFRjN5T04IDXTsPY
	w30MB2q7UgEeyiNWnaxrInNlBT6P8UdYLUfvscfaUjWZQsi7ZvCO7ybJUmi0YLBC4hQ5
X-Received: by 2002:a05:600c:4504:b0:4a2:883:4adb with SMTP id 5b1f17b1804b1-4ba02349e09mr37555525e9.22.1794311414464;
        Tue, 10 Nov 2026 03:50:14 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1917:82b:d709:897d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm60715995e9.2.2026.11.10.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:50:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 10 Nov 2026 12:49:59 +0100
Subject: [PATCH 14/20] t9300: make the series Y tests self-contained
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-kn-fast-import-tests-1-v1-14-dbd9ee502aae@gmail.com>
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
In-Reply-To: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NebtHMIgdCZYe3yGiof7KRk2uRZRGyIOIJxXS9RSQiw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrzBOjizmTuYJkH5R9l/pgizwmmSKSRSnQyV
 KwbKmI0RP9caYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq8wToAAoJED7VnySO
 Rox/gbUMAIytc+/Npu7EbblUpsPK4ro5TRm3rFj1gLjWFg38H5fIK5zapUGlO+8Ph80LlbbRfwj
 LukmYIsxEZ48CluJ2D/FcbiE+YZY57IQyOVSQ8lc4ieTODkyzk+sbyn3V4lV2LlBNro0rw2dbve
 jZNc8mkwB0ZoMWDr54NLzRCJbI9I2iMD0RArzac5M/AOTF6HyOx2BMco1o56F9jvUiiY2AKem4V
 DhzkWX/m1QztmbcOL7GHguIDC21EUXJRzLYFFxzrLJhdfhvPEIJJczsk7YLq0HOnAPGWGkwD3Ec
 B/3Gi1aoPUfn5NQ++9M8ZqXNQHbZGbB0R66IDaeDWCkxVhwicBc/5A1aIsj5W/BIiq5reMrDbN9
 m72cz5Kbh9fHsoHHp4zKk8GB8OZ18GOkMIHKd6dpVT8KLxrb0XUoZFryseHaYbAEsWMNPi80B9J
 D6P5H8XPzODfDAf9Jq/aA7VDQ3x0Zj4sP3Di4YMkOih4U1E4K0hgFUMlK9szSaeX0CQvffIbsq6
 Uk=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Similar to the previous commits, modify the 'series Y' tests to make
them independent of state from previous tests.

The 'Y: setup' test only fills the OID cache for 'Y: rewrite
submodules', so merge it into that test. Also clean up the
repositories created by the tests.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t9300-fast-import.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 82348c65cc..04c3bfe0c1 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4498,14 +4498,12 @@ cat >Y-marks <<\Y_INPUT_END
 :4 ff729f5e62f72c0c3978207d9a80e5f3a65f14d7
 Y_INPUT_END
 
-test_expect_success 'Y: setup' '
-	test_oid_cache <<-EOF
+test_expect_success 'Y: rewrite submodules' '
+	test_when_finished "rm -rf main1" &&
+	test_oid_cache <<-EOF &&
 	Ymain sha1:9afed2f9161ddf416c0a1863b8b0725b00070504
 	Ymain sha256:c0a1010da1df187b2e287654793df01b464bd6f8e3f17fc1481a7dadf84caee3
 	EOF
-'
-
-test_expect_success 'Y: rewrite submodules' '
 	git init main1 &&
 	(
 		cd main1 &&
@@ -4525,6 +4523,7 @@ test_expect_success 'Y: reference pending tag or commit' '
 	pending_tag sha256:85edc5eac315bc680677b2fc71622bd77476f057eb8dc8ed6a497803a24f1f46
 	EOF
 
+	test_when_finished "rm -rf reference-pending" &&
 	git init reference-pending &&
 	(
 		cd reference-pending &&

-- 
2.56.GIT

