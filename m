Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59674DAF9B
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778066; cv=none; b=C1fgRaa1XHiKHkz0YNtkF5z8u1/V53jDHjGr7sonxi+a6hUThdjDKqJzek+E2IUXhdd7nv+L70FbnJ+xZTCEiYJdwLzIDArsWFp1ZpKbAffqu1YeYyVGnhcCQphbm5XzUZNzs5Ll+fwno93Ul7g6VpOuThsrg70Br8XNPR4mbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778066; c=relaxed/simple;
	bh=sjA8gtMO+Pz0Jy+tqETKy+Dd3hlvOae5Khx61MKZmh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFwk6agJib6V9dsctBZFNDkVaWWSKVPUZyZzjjZa+l+9ivqtCafOJdiENbE6OWA1qhAofG4Byo7G+hrmGB0bZ49dT526fEgAdaHEH+kdBxIQBVCYtWMeMOKrrSoUfE/6vrfB2lfDgTKnNe15DuwMWUlubmlm5fm8aA6jIPG2lYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa8Yr1QS; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa8Yr1QS"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5b166b8fso411474185a.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790778048; x=1791382848; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=COlp2PQAi6pC6egT8QJ6v4J2lfxBZ81ICeWnFEptv9w=;
        b=pa8Yr1QSYmVeESgPPozkga+yAHJUp6SC5vUzJTcYWpAVmz/4hbbeDA1UcitHxxngyS
         9QSASXhU2Bjp6+asWmVhh7PqMBri/Db3UpQY4QBVKmrVulZlpqBiHfaTtIQEMBbMTBxw
         I7OEmOMmi7DWFeoIMOv7Tnt9Aw4s0i0G6eNT+iikerqJmKV1D+ubezZ3f+mEsugbWq8a
         ciVlnzeo+1+zX+S7q2ZOGE7wf+k8bJ2WOZjWnbJBzdW5zk899XjOc0l0ioJ/lL4NxvrI
         mjOewuz5g2jQ/Lbfso7pEpH1kZjqcr9vuJNuCCiuK4568TLCg5o0vke1fs7GgodNyuwo
         ATdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790778048; x=1791382848;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COlp2PQAi6pC6egT8QJ6v4J2lfxBZ81ICeWnFEptv9w=;
        b=e2lTJqWtGkYfEU2vtG6PNgVQmnxaQ2DJihUDx/o1WI3n2P7G+wAPSRDJISnOBBR+rM
         8OLjkIC14mwQoGqSh3YrcY+FkzTg3RBI+0kbp5MdRVZWg0gihCVxIkCyYOwrvTMulrSz
         9cJS+zXLRGvBBKC87kzaWxF7gFi4iPApP3PsuiCuFJM3hLrmZwHGE46SSXeuzMQH0rKG
         0UL+yYNu/B3OsUUsldLkXAruUk3lnmJeqhSCY+gB1J2f0luZf5LhlCQhPWFDBq9WcpJJ
         VN+7+6L+DXHVpuYp5CIWwl59elunnVct9yRsIKYyENe7Snenrn5QUc2Pi0v/XOwKM+V7
         QenQ==
X-Gm-Message-State: AFuF++ljhZUFdc9pE2/uzd9yP4FKFHTkyRWBW/xQahxgAURcqG5HcTI9
	O965BEdFiYNQXN5x2pfCnEDfCsmg8FReSi/ZJPHTth9yJ8YGNUW+5EJqYt9cSy4g
X-Gm-Gg: AYBFou3GLo64++ENwRtB0ZfjwaahJJ1rXVG/kbH1AHJJbrmaMK3YqnM8UFhOjUyeiG0
	y1pfJdB+u343eFNNwUel3acqJGNJsbxDXtwWVi4sLCXCdkLL5CEYYm6kWuzbeL+LT6zrjkboUvA
	6UO+6So8h144aAMORRReZM9KpNPXSlBu8Vm9hPcdM4/M/31Mchn0R0b7sbd7HZtaRgqdh/msxa7
	2icj59qBN98RrrEtsSO13P/5pHgOu+o5u5oheUgLsgqVTJu3g9nJI3Ygfrpl/0W/+jI/1YLr8nR
	cLvWqAlEcAJuiDwduSXKyS6BdoCkZwuqHOM+eKIL4JDdsWptUBDFph99/0cPr49LbVh1N6H3qeZ
	CbJaVpbr4PQSnBGqYGj1/2C/pQGA66Tg0VkxXf5oigAQgHR/YtO0z30F6trI8yZC44/PQ+tZtYe
	YOFESh1LuaYLO1vg1ySyl3xGCOxO8ums6tq5R73YD/e7GjyljRixbpEKwRw2IwSMuJZ/CBT7P+d
	BZdCOdzYcVB2978SsIESdLxEVTeA689whyNxWX9oUFFzbnppHmgxRzb2gK151hl4j2yIxoSQ9X2
	bO7CENwdSPDlY2dq8XLW55mj94qHjfpP5Rm9aA6Uyg6KOp7ZgTwr5ifzN0h0MzXmtm1XILAetn7
	tUjLstlrGXkGIkPeDnPXs3LbY0fccH2VLwCQu9JV2aZiiUeVZooAruw6I
X-Received: by 2002:a05:620a:4115:b0:93b:d7a2:dd2c with SMTP id af79cd13be357-93ca97b10demr255706185a.60.1790778047637;
        Wed, 30 Sep 2026 07:20:47 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-eastus-03.tradc-corp.com. [40.76.104.167])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ca808106csm124645685a.9.2026.09.30.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:20:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Sep 2026 10:20:34 -0400
Subject: [PATCH v3 1/2] t4205: compare huge output without diff
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ci-large-test-resources-v3-1-d65ac7c21b5f@gmail.com>
References: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
In-Reply-To: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1790778039; l=1402;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=sjA8gtMO+Pz0Jy+tqETKy+Dd3hlvOae5Khx61MKZmh8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEV8hdxvqEtov7EPuoJyHOl0usYiN9a6iTEjdM6lDPR4afOlbnqVzGwSlrlzrIofp0c6P0zfhKf
 bE0UNrcaCMAE=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The huge-commit test compares output containing a line larger than 2 GiB.
For two identical files containing 2,147,483,649 "1" bytes followed by
"0\n", GNU diffutils 3.8 on Linux arm64 gives these measurements:

  Command               Mean +/- stddev       Maximum RSS (KiB)
  diff -u expect actual  5.276 +/- 0.572 s              4199924
  cmp expect actual      0.506 +/- 0.099 s                 1264

The test needs only an equality check. Use test_cmp_bin, which runs cmp,
to compare the output byte for byte with less time and memory.

Assisted-by: LLM
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..01b97c8888 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1189,7 +1189,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
 	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
 	echo 0 >>expect &&
-	test_cmp expect actual
+	test_cmp_bin expect actual
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message does not cause allocation failure' '

-- 
2.56.0.rc2.851.g50a151a6e9.frankengit

