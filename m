Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2438F25F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482716; cv=none; b=k6Ej6MKNXYAKoUXUwMkH1ghieSVhPOh5xyy+Ucyxhhj19fh0EVf5QGhQZPOwAMQncL3lasLTpk8gETD5cO5CcxEdpneKGseI39Rw1kijGl6bn5NZJVKE4Z68JnZkNMCUFxtguX2vPphVffvIOfSwMrt1LLLrI3lrfbJ7nQD9sbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482716; c=relaxed/simple;
	bh=PJklPySNPlOS/BGQodlOZjoZ5DU8yk1ZYfVuCV/zcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8qGbHiN6ErZzrRDW3CEkFcm+rcShxDrytkh3juE86PENmyKZgT7kw6hNxTl0TixH9otQqr4vNTHwy6kK12Fg5IMsI0Xj2O8UL5QzMCrfICdga16nb1w6PS9ooc+ugk/D+rviwoEWLw4rq9bmK/DgZN3o2c8Gx7kPPFfYXZaPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MDE9HsPA; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MDE9HsPA"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad79df972so641341d50.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774482714; x=1775087514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t46Kl92p3KCfdZzNOQztO0lFrATwUqMnh0pSMRns2+s=;
        b=MDE9HsPArm1KTeRDPq1k6wyiD6Q6v8ItY7ItEt1xISGlZsvKIso49SQNTyNyqCLNxI
         khm9/mGX3YajiaAyVaJyUNgQP0aTATGfGZ7rF4xvkGUgnSBsuMnOwW2lAi8CCdvqlIo8
         sXIvq/Sx+FDSovIu5K0zMzUgMLAxZEZ2XKXH0uc9D3Hmxiwe652VDGBcpT4j3aq4AdFe
         ESiMnqlA1Am3NJjewC+Bm0bu1b/oMxixPCb8Jw75GIuZpKo0EDQbEGA75jZ6uI7XqwvV
         hxMbyz6c4fxvE7wpHWaYl9oWuTREq8UeYcxdU2FUpuJcNW3ksmQ8ZkGF7FHdfsyMFxFZ
         pBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774482714; x=1775087514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t46Kl92p3KCfdZzNOQztO0lFrATwUqMnh0pSMRns2+s=;
        b=PAp7Qx6GRtnKWM8Xh3CnnGsL6m2bRUH9+LYuMGrCSAWcn11bD4EnQqiAFeOC/xCz1+
         c2Di5sVvfO906Z8MqNM6Z57tCaHXLTshplUFdzL1KQP3yJ63/8//SniiGi4s0wZ7+CBp
         WoBuC2Whr8lZhDfMhP22gpaAMBg091TAHWoMyJFRmMQJBls4PF+iQ+Ex7SYJzTNEjsBY
         tzUOSGkUonmrE4eyGRFGVR+D1etToq/6KL/cJNPWqwLrQ8Y2I3cAVuLLse1dwgKUwOsu
         W9Jlzr+Eyb++Odficouk5G8Qwg1lddcRLdLh4x3ytm84003VKFyUXS0HKGmFWF280t/I
         Johg==
X-Gm-Message-State: AOJu0YyG2uoxiLvEoQb7RSJADCWSgDsicSbA6SZv5V/UGQ6prfsHPKJl
	VYJy3fucQ/VlGb3nTEsNytxX+tIvqmUYjvf9z5Kfm/TqACKwRwzeHf2Fu5pC57Y781NehHaH3Kw
	Poytgqtp/Kg==
X-Gm-Gg: ATEYQzzeCgOzo8k2o+4uDWpPHQzH27dGe/vDuGEV/Yk2k9n8J8e71w/iKq+VgUMAB4t
	e53rM+sZ3yorLEowTXQTH6xfDWSI/D/ln2lGaM49em0wCQrF7V4A/PipsJz6v/9krDdFHC6cw2t
	5KUjr11rVrAkWkL6x604a+cqlriArZbMLWndYLY50IhWKNB52oAXnknHj/90amLl9pSh7l3mpdi
	DrzXzgTanGokI1lLQSKlBEt2oJOM8At3qwrbUOmc0qk2B2uM3WpNFh0CuWufCLUFFy7ddIBEdSY
	xmjMnQ0894yUJ8y5lPSECNN8p922TFEyOO/RDmMbjPvJEn6Nl0jrXUO7Fe4yIcAJ1VEYS41Pied
	9FRKSQz+LxNnCxfikptFw/HwTk29Lwfo2rfbo2IfmCLLIsHAwdbeB+oFqLpNKW50qLjtyWdL3Qk
	q/yPQFjqIGSPc8Ya5YqsF+6FDwyMqkwSXEzF+ULFYfGUVzeXjZt6TncRmXchWywGxBZuKm44m6l
	ifKk5p3mWlCNaycwO4N7nPgInrnVE1RxUqmBj+N
X-Received: by 2002:a05:690c:89:b0:79a:bc1e:a399 with SMTP id 00721157ae682-79acf67cfb1mr60693547b3.35.1774482714432;
        Wed, 25 Mar 2026 16:51:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e187ebsm5645467b3.11.2026.03.25.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 16:51:54 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:51:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] t7704: demonstrate failure with once-cruft objects
 above the geometric split
Message-ID: <d8f0577077cf699032292b7f49c7636c43ca3af1.1774482701.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
 <cover.1774482700.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774482700.git.me@ttaylorr.com>

Add a test demonstrating a case where geometric repacking fails to
produce a pack with full object closure, thus making it impossible to
write a reachability bitmap.

Mark the test with 'test_expect_failure' for now. The subsequent commit
will explain the precise failure mode, and implement a fix.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index aa2e2e6ad88..77133395b5d 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -869,4 +869,26 @@ test_expect_success 'repack --write-midx includes cruft when already geometric'
 	)
 '
 
+test_expect_failure 'repack rescues once-cruft objects above geometric split' '
+	git config repack.midxMustContainCruft false &&
+
+	test_commit reachable &&
+	test_commit unreachable &&
+
+	unreachable="$(git rev-parse HEAD)" &&
+
+	git reset --hard HEAD^ &&
+	git tag -d unreachable &&
+	git reflog expire --all --expire=all &&
+
+	git repack --cruft -d &&
+
+	echo $unreachable | git pack-objects .git/objects/pack/pack &&
+
+	test_commit new &&
+
+	git update-ref refs/heads/other $unreachable &&
+	git repack --geometric=2 -d --write-midx --write-bitmap-index
+'
+
 test_done
-- 
2.53.0.614.g164f3b634ec

