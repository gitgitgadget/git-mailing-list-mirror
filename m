Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277953;
	b=Q/4fT45t6m+H0h4k0B7Ap9zpvYNk03SedZZA44pu2ouyOAOTJw7ks+0kdTOdSbcz/eDE
	 9bbQxOZ7xyt/AdrpCdmtpXeoredl1TgDQQMkrS74Oi4oY9nLtsVXF0xbGY2f1WPUxtZZW
	 5MTNar9lP8/D0MMhp6IGloBUxIsp9nCHfGZl9zTBslc5RrkCh/LH7U+0SB7ipIv46swa5
	 iu2rJaSwaCZSaHN95YdBOQqH5/eDXxU6PcGHR2qkgN0LgLqLn60VTi/CGWTTj4ILpNfD4
	 e6rCEiZQ4QxkdcdaMb6xDE/Gn3WD78wqiVUx/3HizZ8HPzc37kc4fI9plI4wFRVv7Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=385Sj2vBZyzCoQKTlcXiAjZinAjezEEUEJH5WKUFbyw=;
	b=Td7ia8TGSaKSre3tyeJwPnMkbZhlE4Yn108LK3XAOFY3sPeekcCl5p9lS64gLNxPoJ93
	 gRwQbR7hbEbvzpo0tPSGEG6MHfYqe5RqPtfsmFmRk2/b7djeFa+JnY8V/QJIRNEB2Jd6a
	 DTCfKzUKTis2BauaYYbd4suiicAndSytANcRt0NabY5Ei92KdjYd0Mkw4QKsCET9GTpsq
	 ywBwN9ihySpoa7hXEwQZGxRIWfLvzcuppRwd9njAPGzHyIbiJYA5YYm/MSh+6VPN8TykN
	 bB50kiTmzGwAgU8rmOvEsWwOjD8eA6hIZHfxBFvji9+wO4LB8M59NbY2xJ1X7riQObg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtFblpXI;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2044606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2044606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dtFblpXI
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a215e64962so22238095e9.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277951; x=1793882751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=385Sj2vBZyzCoQKTlcXiAjZinAjezEEUEJH5WKUFbyw=;
        b=dtFblpXIxo1LgTr94cE5mUkR2ex93/wfslzN4qjNIp3bM9JzEK13UKpxUZWB2U5ZnP
         RdULSnbBxYUAxYlanMulQCH6ulRIejXU5Y7jZrxQ8zPDOMzlBXH/KwfPpaQB3Ay8euDk
         8KbTCtLw8ZiqA2M+zrjo3nElOKZL1FD9fp9T2cuwMuK4Qk2wNXPRKyMkUGqVpgiD1e3Y
         gXxr5GO0F6NST4Qg9exnGO2IX1hKMneL1Qp4299gMVzM2ZJfA2iV5B+FLrFRBLFXKBJZ
         XYvLP8h5ohg1eu9AD3QiXcAyLueWMpd2R+Wx8RjAb2sPpFu42htnfQFgPXFZXJ29Pn7r
         3LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277951; x=1793882751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=385Sj2vBZyzCoQKTlcXiAjZinAjezEEUEJH5WKUFbyw=;
        b=ljLRbdYF6s/l/uFYBqM2P99EfeuQP4+wfIUVqbvulksuiufvBwLOFGI5551KphF0y9
         10yNaiHXSNtpCY5JiwTo/6QzWdbAXd5SAno3pqwma1yNVYI5eMk2p7HN3Zzgv0cveoXi
         F7sGQpPEOK2w32kgKgrrA9pz8vzJx3Qon0eJFYig1amXKe5Ap+6hd2tnKdTyszUZStkO
         Egj9Sz1adKWgedas6y5Jm6CIUHYa7psnoeKBLYVDfpEuO2qqDP95NXyuX8WvpC5KTPGe
         NXpb+j5EHa2hpyKpi5IkWHSGU7Mn8SMKHSI/vKD/0FcHt8JrFiXGOOlJeechgdwqguRn
         9jbw==
X-Gm-Message-State: AFq9FYIZqIjgBfP+hcwWpiVR348yvP/mmrRKf5Pir5xQK6ibZFUOjOP2
	I9dRC1lRXPVObXBdp51DLiGUdyMi2Ndg1FvdBRU9Y2twVN6HqFHR5eHX
X-Gm-Gg: AYBFou0cAQahDyNfncWhZ3BHD8Xy0MooZw3VkeuZ2HAl/qIwOXjTC9dgpCQVMcQAXAp
	P+AFu2zlF6NaoeNWlXcOOWK4IkJl/vkYHWcL5g00U/aaUOrgEpKbqhvFt3ipoiJXv9KWL9wu8Zr
	TlLVj0h5PRpg/qE9/v0XPA2pY0dGi1bQ+c9uCj9iAv0rfK5AqymS/BUc50siXpVd7+AaLbqIBqH
	mzqnm8k2lEcVKxgmYPjfLvbXOa32/yw1BpmagVvTdNilR9gbigp5J3cWbLycEvSLMHmDA5d+FgZ
	0LHRJLC59isrtKtI0956h7Bu9CBk5hrlW5N6kYe6Bs02+gyzyD2nSEZEUa+5yhq/NMwGNXJRlYL
	NZ8KNLpWTekbgMLzu+5aJJ/I05x6fiKxZieL02F9tETY4VEuNorDjY/StF41MBE98eGqlPgBvUL
	dx6E+PqLEGeABFH503J9f1wDHuAUMpg529VHAV43CShcMEGnE+hmmi87F6zfGHb1ivaa7WzZxq9
	gSGFuX+W1RJYqzTkDiP1McoxJPIJtw0nsWjYE7Jo9MeRQJdVw/0M3dzuOLE98EPMApn1nOA0NEP
	bs7D7pwf8Q6dp15tgO2wymwlhm42KJgs0d+S5BD/W/f8UXnEdyvAdaNFZ6u7Mxa5/ejr7g==
X-Received: by 2002:a05:600c:34cc:b0:49f:e8bf:8f9b with SMTP id 5b1f17b1804b1-4a963ffd2b9mr136953155e9.4.1793277950137;
        Thu, 29 Oct 2026 05:45:50 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:7938:fafa:2306:bf7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a930a63eb3sm106593635e9.1.2026.10.29.05.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:45:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 29 Oct 2026 13:45:37 +0100
Subject: [PATCH v6 1/3] t5510: cover upstream info update on fetch failure
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
Message-Id: <20261029-799-shallow-fetch-with-tags-v6-1-e6ddd5201def@gmail.com>
References: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
In-Reply-To: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=k5ptcp4CjzItV1dQQD4Vf0RYo2cmbih0ECPAueeUzwA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGrjP/ZjyjLWqS+mdAXDYdQunBAz5uq/LVhiM
 s2Z+wtU881YD4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4z/2AAoJED7VnySO
 Rox/DmUMAI3b4giwO1sQCqEhTdXvEun26nHXOqO7m2eFqZh8khnja2USfvHI81hd1U9LR3DSINE
 bx9skuqc40cd0z3LlEt4YoiWB7VAeJyEQPWIiYAc9PbvlggkrhY1yo2sOdXMSX86em1sdbjJ8iS
 +8Elcy2FXN3M8i1VV047Z9P4b6JSTsH8G23rEBCVSYsW15srXnzyAFwspeQKKE1CQ6bLPVNmN0O
 dcJkk5Rsow9FBq9hphZVdqIFhQyc6DLx38CdcJxhamGQtXBqLRhaRTH2L1nRb5K17+4aRfJIKcM
 G2+YfQmbM3eqbbY4EpnilWN60aoRK6WBmVRO7natYBN+vyj51uFCQie/sb8wJG3MH7s/hG6I9Yx
 QkGHIyGnnvZNXryjVLLIrw6zIGqQ8jazp0voWY+kvCuFTjUhufKG+fmGlR45SYriEdeHlsZhExt
 mlzWBAkxJRX10heBJubGvG1FnHlSDuGPzAzje7vrgOFR+iBvI16Keinsp3neXkb74QwH0TmBLl5
 8U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

git-fetch(1) performs reference updates in a single batched transaction,
so individual updates can be rejected while the rest succeed. Even in
that partial-failure case the command still performs the remainder of
its work, such as writing the upstream tracking configuration and
backfilling tags.

We have no test asserting that the upstream tracking information is
written when one of the reference updates is rejected. Add one.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t5510-fetch.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 300bd5396d..30871617f9 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -2005,6 +2005,31 @@ test_expect_success REFFILES "upstream tracking info is added even with conflict
 	)
 '
 
+test_expect_success REFFILES "upstream tracking info is added with conflicts and backfilled tags" '
+	test_when_finished rm -rf base repo &&
+
+	git init --initial-branch=main base &&
+	test_commit -C base one &&
+	test_commit -C base two &&
+	git -C base branch foo &&
+	# Backfilling only takes place for tags which are not pointing at tips.
+	git -C base tag -a annotated -m annotated HEAD~1 &&
+
+	git init --bare --initial-branch=main repo &&
+	(
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir -p refs/remotes/origin &&
+		>refs/remotes/origin/foo.lock &&
+		test_must_fail git fetch origin --set-upstream main \
+			"+refs/heads/*:refs/remotes/origin/*" &&
+		git config get branch.main.remote >actual &&
+		echo "origin" >expect &&
+		test_cmp expect actual &&
+		git rev-parse --verify refs/tags/annotated
+	)
+'
+
 test_expect_success REFFILES "HEAD is updated even with conflicts" '
 	test_when_finished rm -rf base repo &&
 

-- 
2.56.GIT

