Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183030;
	b=q+YlK0aEyr1QJtR2GounD9j0chcjnwiqAMF/CLOc+71Z//JQzXKSqfe7u/+Eve+Iagy+
	 ChkpkZQM6VJA2BNeImsCqDMI2ZJXdiX4eDamkF+6Ln7KJGcBq+0pvoUwDKrdgStAwao9R
	 KmmsQ4riCMCqcywfRcpJwVUwls3cAIozdBRx2jbwZ8h22wo8YE1Zw+EzC0/uHCEJLoYT6
	 a1fKJiX3rq39lOUoueOoM7dN6mxuUbog7h0goF1XMDKt4CSlho7LoOThfK/goTU39OKvt
	 s7NMcPk82UVPep1QazqUZ9j8NnrDCH092YqDSO595ovy5WGmA4xL4s0SUhala0Agnmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eQXzFofY/kkxUd24uwM0+4leGNqLne6NUcuIUFQiDT4=;
	b=UzYrHwx4nzMAHoflDWO/haaO1cvTuvRBy7/OnMEeQi91eyJ6jmLVteWdoR6LecWPQKZn
	 ME29CPSI3owec6SM4okN74QdtdyTRJ5I1bb044RUTG17UpqMoiK5KVr6Z8eZNUmzaShlF
	 gLgJ3D6uylLR4y75L73mz3xliDNbt/y3m2+/DdONvpnRcxyOt+M/vzKA9aokJwr1sBetF
	 PRKdVvdGg+HFsNqW9Up12vkhK+hHLSYN25cxA49OjRSFQfQSw9fnsOmRfB2k+oDQLVjnb
	 /4sz/hlqTx+he2dT8zi0a7I1ONC/g/mqq5zG0XMG2RAdL+lLDoBQ00bEvJx4Q6eTHYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fD7krubC;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C07606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 10:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fD7krubC
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a1947498bso2362677eec.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793183029; x=1793787829; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eQXzFofY/kkxUd24uwM0+4leGNqLne6NUcuIUFQiDT4=;
        b=fD7krubCjFRNrl0q5E8WhdPD0vQFefRmm4gXYy64mt6JG412/J99j3tIRkEX30NbBW
         k32hqR1h9YxqsUcGXV3dZwH8ZAaYj6RoUBMwpWrZengdxEIR8yfO5KJdQTmDTcjtaJvv
         kc2xvKLI/sm/55DHBc7XTDfpGHKriAfKyWCB2AuJFFG7IH75CP5Ik7346z198g/hyISP
         DgOCpZMdiqUlBT7QxYZ4qPotRtz5eb0dDDsrFUlFOR57lhJmneW2FUq18qpWK6kPZh4o
         SKYpRb16hvtxQniLUXUQA4OZdLrFjqs0qCobqLe13dDHTvmozNAAJP82b/BH5j99/b1A
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793183029; x=1793787829;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eQXzFofY/kkxUd24uwM0+4leGNqLne6NUcuIUFQiDT4=;
        b=XQOnOlnx2T5fY6qaW1G6nDeC+z6JqS9NyD3VC/vRfkkDdpUukQ0Uoli7oIzxXJp9Ag
         Xg9SXN+DVoD/U+R2Vo3d8PBuYBUGmJuIuPCtLDXLL2a7qKYconOEVfV+A+Pm3RYQMtyF
         FUocLdL2MRtg5T/h+vMMFEirHVOBsVTsSnaxv4WKdnyPbp4U0xj/cdVB6qupW3D8Pu3L
         OfnaJQQW3YZtd9HSuuLDmoeNx7HadNgSqbxcjLbZJocDsJ6nYrhGYbEiHqJxP6xVMnKS
         50lk/m1zWZiXF6rxDQ18BRcf4ij2XssH5jUVJteOPoWqcJ1mOL/giOn8Q8C+nkVYVEOi
         ifKg==
X-Gm-Message-State: AFq9FYKk6cKgFKI5a9p3swcBiqEC9+o7GM3RH5He86TA24iL35z94JxV
	a31M7x+aEjunyyNfOZfefAKJaJJZYJShYthvQGAGSrXXIXOXbXg+XQunU+H3DbbP
X-Gm-Gg: AYBFou3Hz2aHA0gz8796YloijrhODx3TsGkSrRg8K9AgXemFxadymCI9gqOZ5tFNw11
	R7lPcYARIZRZsVXkr0QkwcI52ic7nvgSGVOj+mmgyptSVqzPIX21ewTVcXNih4sqZ9ZHEnsS4bs
	80clf9yT71rVA1jhKC4wgnhEbC1MoNXUVaoI6mpxBQq97WA9w4/x+CQ93sdq7PNtwSwQ2Hzl53C
	6r8iNV/vTAozyGLcv6KleveCwjyBLwCwje0xJCWIuK4YGfwTjHy1ajAQtj070IsNREvLhtxLHve
	6hNu+q2vpOGLeH8m7qYrrBaYi+lU2xVlkztBcYmyPkYm+r7LuPPeodU6pCJJEhZxgg0WUsTbW8z
	yR9ECQU6i9o2IbY48EpqqEykQxi75gPlAbKBllkbNyT7tdItNqndgBjAQlo+n4S4fpjeBgtsCKj
	aXH+0ERP1Xx8o4/WuizaxgrXCqho1I55E/Xe7CuOxUMaNWPLR5u+H85BLi8Zw3fwhOYS5SUVA68
	fBHT2InFMV2ssx/JMneU4t2GozL3bX5H2CmOwrDstRR7y7BVz3OYCWfMqG0NJbdlbiV1TuZZWYS
	ffOJzNCJ+QB+G6Tt0FOT5C7H73zgzdyImyns+aU2Fs0XsGOIunqyqpU=
X-Received: by 2002:a05:7301:183:b0:361:fd60:3cd2 with SMTP id 5a478bee46e88-36a203aab98mr2824627eec.10.1793183029015;
        Wed, 28 Oct 2026 03:23:49 -0700 (PDT)
Received: from [10.130.94.240] ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2399b05dsm5607476eec.25.2026.10.28.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 03:23:48 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Wed, 28 Oct 2026 15:53:45 +0530
Subject: [PATCH v2] t/t1467: use test_must_fail in place of NOT operator
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
Message-Id: <20261028-refs-rename-test-fail-v2-1-505ca9558503@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQrCMBCFr1Jm7UgT0ia68h7SRYzTdsD+kISil
 NzdsRdw8+B7vJ8dEkWmBNdqh0gbJ15mAX2qIIx+Hgj5KQy61q2qtcNIfRKZ/USYKWXsPb+QgvW
 u99ZQY0C6q8T4fezeO+GRU17i57jZ1M/9t7gpVPiwpnHBt1qZy22YxD+HZYKulPIFh/XC7roAA
 AA=
X-Change-ID: 20261028-refs-rename-test-fail-ec7a8fa74e54
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793183027; l=1411;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=M1dcfCpwwtyKfqz4oVyMrcXxiMXU6BYXdRGzBrAAQ0c=;
 b=5G1Jrnsb/8ruEfl0/TWlW7MzWsncgf4Y0hT5m1iF1ocFQ0fDrJ1ycl38boR+WUKfdFl5vDWUe
 ujvwnhd5m0qA/df3gN7rADaq9+VtSh5SWTfWuABBRF+orxReJu77wXq
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

Replace the "not" (!) operator with `test_must_fail` for refs-rename
test.

The use of `test_must_fail` is preferred over not (!) operator because
it ensures that the command fails gracefully. If the command crashes
(e.g. a segfault) or is killed by a signal, the failure is handled
correctly by `test_must_fail` which will fail the test whereas the `!`
operator would silently accept the crash as an expected failure.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
Changes in v2:
- Refactor commit message
- Link to v1: https://lore.kernel.org/r/20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com
---
 t/t1467-refs-rename.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1467-refs-rename.sh b/t/t1467-refs-rename.sh
index 2b28be75c8..b7d290d05b 100755
--- a/t/t1467-refs-rename.sh
+++ b/t/t1467-refs-rename.sh
@@ -88,7 +88,7 @@ test_expect_success 'rename with symbolic ref fails' '
 		A=$(git rev-parse A) &&
 		git refs create refs/heads/target $A &&
 		git symbolic-ref refs/heads/symref refs/heads/target &&
-		! git refs rename refs/heads/symref refs/heads/renamed 2>err &&
+		test_must_fail git refs rename refs/heads/symref refs/heads/renamed 2>err &&
 		test_grep "is a symbolic ref, .* not supported" err
 	)
 '

---
base-commit: 37b3475fb530c14109211faca33716a173db61ed
change-id: 20261028-refs-rename-test-fail-ec7a8fa74e54

