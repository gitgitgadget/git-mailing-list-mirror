Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126970;
	b=wZnAlWWYmLpSSMT1CMYFoYVqsT9K/BoNzDmvc8iDtj1dlflFuqTf6GCDk+5Xl6Ih4Sq3
	 3rrC7C8B+LkN6Tns+BgZ2khWEwqgeDYCJ+GqUv7KfeSOAaH1oQKli4znalTMHLE6j1Jpv
	 SEF1Ago6xq01mJFIT/DMwrpv9Xi5m6H/CBDTnkYYjYxFkT1T/FUgNp31zh/2Ci2Xhldgf
	 yu+HKiz4EIu7tNqGO47IVCr1jjIOIgHXr+wrJkZTjzS+dtE3fcwfgfh+p49YlB6H/9Y2h
	 +Cay5KuWOKaV2XpebWk+t3P914wt6oY92Vik1nE0HSm1Yw+zjzpoSWGvWiUXzao3kuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126970;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5robEqc6ZCkQ+9o2fsFVe4C1O0JB8IIWa/qKnNq1wLQ=;
	b=ijULJrDkh/jh95iT7rxSfraWm0ENyWC+yaheMQqEZWenfen2gN1f8wgHB9kNkaTDR7V8
	 xd0yGoGt/faT7tv3IJdqtWFq4/kIR+8BECGDttB7Z5kWB2wfHcKqAmP/jaSaRrPtS6Tpt
	 +nsv+0qp9KFq2j2OOQvLocLaMh6j1YDhGuzb4PNb9XYoSit2kkJjAw94VMltu5ZEMYdgk
	 6r0oNKMAL/zNtGfPeJebvaGVnrSdko0cXdeB4siVgkKxyUnqEhvycQLCt10BHR6XMtOcg
	 L28sFSh/lWuLwDl+Izq6aRbr1XSOSkpDAIVoQx3BfH97RNOXS8+y6L5RxtnCxCsisiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLKkhGNJ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEF606A323
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DEF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RLKkhGNJ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a18fc7a38so379900eec.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126969; x=1793731769; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5robEqc6ZCkQ+9o2fsFVe4C1O0JB8IIWa/qKnNq1wLQ=;
        b=RLKkhGNJGD8QJjfqiPUsDDLDJ/Dk9e6QyTriBzWwxxXaDxC3xhe+IgXI3uKzg5f44G
         z/I2ObljPtGHzsHDsMSwSrCMu7ZSzvwUkmUp7wjTbd5fApIVbLEqQOhvh8hd6HWtm6ia
         sTxKg+WX4cJr9oTlZhH0HUvbLbf7Sybvt8ixQYtnBKkMLxfsKYUJk+6xoFSZtA6xp0v0
         P5bWvzrQCCJRc/vNu3AA5lLfENP80MxABRLTHc667Gh1YHRK7Sxp7zkYNpUGSb9p8d+8
         LDuvXwhMlFhnuOPJS+KkIHjY5l504X6pN3Cb57MKsR9GSHJJa/J7YoF9u4F1qFg64kCu
         0Yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126969; x=1793731769;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5robEqc6ZCkQ+9o2fsFVe4C1O0JB8IIWa/qKnNq1wLQ=;
        b=wAOQ781PKB/fYvvcBw1Eek1J6vKb+blmsSwbO+In5eyKtJ6oL7M4qEUQ9Wl4a2NZsF
         3HMHmaCjqnEJFpJZtKHZhS7qoxw7p3TTl/4WOcupcKIqCxG3sAjXw2z3Kkj7RecfZKwe
         u3B9G5NoTko2FDR39jLygYmTdAAGdLy5JS78NbrXCsxgGwoFwB9p5rsKq+RGdZ3ij8P+
         yO1zo/JhVtAVrDE/31X0Ldfq78uTb9+mE7hnngGigg/0jSLesiXM4yYEdXl7SIlZtGQd
         X7sOJ0Ksy+g4ekB3J04CaVGLiHUfCukUcmKyY1uPyT4UCnjaZk62mmDWNqhe4pheOta5
         zv8A==
X-Gm-Message-State: AFq9FYLCfyqE/GhXn0VUdHhDcRP9+raBgDRuV1b48JeLQ+m3LwPEybcn
	1n8RwZArgkWZU6NLYn4Rm1xoXEXOIDylXQXjFTAw2t2pxkwwaOKNigqotAniTea2
X-Gm-Gg: AYBFou0mv+i+8sN4dBJVX4usG2ewT1xSl2Rds17+kJys61r3q3znlR/I2t0HIPMOftG
	GPBHg6qDZ1xvy+kMyNud7yt4JrKDKpnwGEjzSzEO2FFXtET9/utThzGPkgboejpVk+92hdKOoUi
	/+ZNNuu2/iFupvioqhy/UrWECo7aMsEu48wWXMEt/lf9haXVRsgFHfTtFbPuKqrTT+t1c/KVbCJ
	r8cOilR3ZgVU/SanE03BSE3NB5+mtiDlmvwL0lMP9nK9ClX5EbwHlWsZLihbRApB3o8UR2Avj7a
	ezaEgWJBjVjhM/i2dXp2aDiiLRW33C5kgQq4eqAklWdFjlCtUoSx4Fs0mPNymHisNW/F/BUdWfD
	dPrsh94pmzhVgQ9GbVo7Ae7/57bC6dAKehpCNDPUFoSNIble+R1U1sLxqhIAPmDijEk/0Fpm0pb
	KAFTeZ2hXanjTn6IH7MKUo/aN8bb3XwLyVs3XFaM+cTq/V97JEZsvC5I4BcOFZMDlG2D8sQdsTv
	rKxmXqJCXFoxhp8hFejo1REXr88JfIKjp9rDW6AAbvggdkanoB6hgX6tvTB
X-Received: by 2002:a05:693c:2411:b0:358:3426:d601 with SMTP id 5a478bee46e88-36a202e9e62mr535121eec.2.1793126969220;
        Tue, 27 Oct 2026 11:49:29 -0700 (PDT)
Received: from [10.130.94.240] ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm48641814eec.19.2026.10.27.11.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:49:28 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Wed, 28 Oct 2026 00:18:43 +0530
Subject: [PATCH] t/t1467-refs-rename: Use test_must_fail in place of NOT
 operator
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
Message-Id: <20261028-refs-rename-test-fail-v1-1-b7458ca62149@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyML3aLUtGIgkZeYm6pbklpcopuWmJmjm5psnmiRlmhukmpqogTUWwB
 UllkBNjc6trYWACqe2t9nAAAA
X-Change-ID: 20261028-refs-rename-test-fail-ec7a8fa74e54
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793126966; l=1164;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=PrY9+ghVkQiNWZgkBeirwrFvIN2ehp4LIlRqwBQ0YiY=;
 b=CyPl62/gtLGexoWdiHGWnNZr+7yunLbJCQlFglSSWcxgTY+TN95zxLxIi2MaGkPO1jTe2YHcy
 XOkbnOFgdhwDsavTlzsSNDkZO4A5QnC7xlEWJ4F9478YKXB862P8mHy
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

All tests in `t/t1467-refs-rename.sh` use test_must_fail for verifying
when a test or command is expected to fail. `test_must_fail` is used for
all Git commands.

The use of the NOT operator is replaced with `test_must_fail` to ensure
consistency in the unit tests without any functional changes to the
tests themselves.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
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

