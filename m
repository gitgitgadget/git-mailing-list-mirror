Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5393B2FF6
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183628; cv=none; b=RaVzAxmQPp8Nz0npelTf87MaVEzihc+Uk9PaKHBL1/z1QzGxLrHcDoT0uSXY8zfCLgAcSwsjOkWXp7u8/G6FkykXwSMUD6sTiJVemEG8K4IaKP+wqn/DmxpEw/RAQ/+4oh+j/BSQCcvWlzCkD5XaqlzMuzrBQxJMnbMpPL+9T0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183628; c=relaxed/simple;
	bh=tmevsH4kA5k1UtupWoP98QGIg5xvD/JRQKTOQspt4Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=umGQksfV6FKv12EP9rxw/loKydjFgUOOkXlayX+0SoddqCF9e/1olPC9KQ3WYcswlEffPJh3J6oF5PQfmco2eJ2+cKTM8E3bIkiZuLZn7CCmAbvNoop5hTFblx4Tf5yCGR34Og0oT5wokaRcwEsaOgeewYKb6HfsD8NCiZOgPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duTn3wqC; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duTn3wqC"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae721872so616186eaf.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183625; x=1790788425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUfsgV3ws3Fn0Zt39QKlIxxRv1T1cAtpjNvZi6lbk1Y=;
        b=duTn3wqCgbuMauKVZ15B42dpUuZ75HTRLiXi4821JxHCqCzOjBE3UCfAGJWFRlLV7x
         GmY5QNRCxdZBNd8RQEors00jLcsVlLxJN/W7v+rLENC302z8i69rPgaqYSCp+cFdgvsD
         NDwo5aj9+D0yJdd4ZpJk+adY6QyJRKvdoZ8Gk93c0QixhyenzFmMT8ogkpcjx7okrdxW
         Ug6PJphHCYp1TvbBgbY3i10cyloO7DWpqp9jESAbqXyLojy2yRwBAU6pw48JTvVWNB8x
         HCxDC5NNJcne7qp8p+TCzpvg4HS1HWSGGsxt+ZankgRpyhVNqEs15slg2OP/3MHEh+B8
         z0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183625; x=1790788425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FUfsgV3ws3Fn0Zt39QKlIxxRv1T1cAtpjNvZi6lbk1Y=;
        b=1vLHXbBlEIkepgZNvu8ZZwFoqFBSZJr+BOqnPkIH8mnnsegx5cgmDz/vtUjYrU9YlC
         J81ZRwT71eqhDC+2KkzkXq1Sk9XXpp5LLJnKhu+cWNbsM+oJHXsdTHrP2f4ckVuQglKG
         v/VGa+hk8BcQlOCkB1l1vpLGtP0Cspvc15HMgIQ+ysvTKqpPVeBWw/OgypQAJ2qyBCvS
         u6YdipGdmsB3/gI4zcYp4gC1FWU5nK+XMy5sE4nYybXOvljf6D7OA4e2a3U25CUFpdzJ
         Enaqbchl7jgGbxbY+ssdi6lqR2nGiZx+Df+g7d44/2khiqI9NQUtqs04jqg+RMI5qe2i
         6fAA==
X-Gm-Message-State: AFuF++me1RLr6QqdMfQg+0c2wzgyH55XDUC5utaiWpMZlPmC9C6mg2hM
	R6jGDuIm4nAD4zI3Hgy/You0FkMMhaWRL9ihhLCy19YgthzuZc8LjozGVujnKaKJ
X-Gm-Gg: AYBFou1uldKe/VZg/rmApOjWcbw3b4EMB2gMFyAztx9toMuG6QUAmfE3989Ds+gdeQc
	zglhvppxpc62tSF0Xq2uIgR+ChQEDW29dr1o+bHRkxkXObsLRlUZ4FlXp/5ybtIKXi363uWSO1M
	8ETItTyvkr79VDSbyLW6+hjo++7H0VY90Nu4szDLJ6lXbTlHeTxINNDv6zws+43gzr83brgn5Jh
	vKqgBd9c50bKKXi3LINW0nrlvtoDA8ABQnrmlyXlnPr7rJ8zHafm4UtnSwJu0O5WNaL5xKzOE4G
	lZWWhAxV0OCFg/Wt8k+zLxn18G/fSoX11G9EdbBykvUuZlmTNs/u2w0tiiDpueaobLWEBgvqq9O
	yiGaR53s6Dk2IINvD3L0EWphJDhIsTbpQhmiC01TVXVfgDVPjXbZm+tWhA4YQotr5PoKV5uLVFF
	r2hQM6T0Qr19XKPqn+8HMYj9ACq6sroXSurk8YlGMIhiKUeZxkYQCjck0QbcZH/QKnfodumarMr
	Q/PD+VH+PX/3xcvMqX6rk+4CqvePaqRIrMZOL1EYm4vh8Oqya/6v05zK2hLv2jvwzYuym6xGvPe
	xZsECILOhg5Ynkaswus6BdIrYJrlHHHJEE4QKOthZ3A4zbOW1UosKFq4pyADjx7UpIEh4SMfHEa
	w73UmiFosqaVhWn7/pmsvAnvEk3CjTa3tnZaJAVdGkoNZZ6E9/etk/OexIolr6KXRgaMQxQ==
X-Received: by 2002:a05:6820:4df3:b0:6c7:7668:a27e with SMTP id 006d021491bc7-6d2d092f302mr2712094eaf.28.1790183625508;
        Wed, 23 Sep 2026 10:13:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2ce763f94sm2972392eaf.8.2026.09.23.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:13:45 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Sep 2026 13:13:28 -0400
Subject: [PATCH 1/2] t4205: compare huge output without diff
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com>
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
In-Reply-To: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

The huge-commit test compares two files with a line larger than 2 GiB.
In Linux GitHub Actions jobs, git log produces its huge output but
its subsequent diff process is killed with SIGKILL.

Use test_cmp_bin to compare the output byte for byte without constructing
a line-oriented diff. Remove the two large files after a successful
comparison, releasing more than 4 GiB before subsequent tests.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..6279a7e9bc 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1189,7 +1189,8 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message' '
 	git log -1 --format="%B%<(1)%x30" $huge_commit >actual &&
 	echo 0 >>expect &&
-	test_cmp expect actual
+	test_cmp_bin expect actual &&
+	rm expect actual
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge commit message does not cause allocation failure' '

-- 
2.56.0.rc0.807.ga0c0929ce1.frankengit

