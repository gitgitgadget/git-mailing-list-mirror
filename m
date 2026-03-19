Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033D3BAD94
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959068; cv=none; b=ia8j+jbSHXE3scxRzG7Fq3f/MHF65u6dyhAmHBXBeYwJmRZoeYvlRtxdUCWggUVXDnnBnyNlrPhPhxk3Y+ONWVc5LIp+yYnLE71A3mxGOxIIsA0Y603wv44yFyr1VGdkKwhmw14GIZhkZoF4gqQRyL9MOwOTiYHn0t5/7BzJL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959068; c=relaxed/simple;
	bh=p89KwZu+h3gLtjhCD+Fjr0G3ejoAv0uvl750LaWd+2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNYWmJ1jPn8rCwz6H7I0nXIYWaQxJ7/BZijLI1Y9D1uOWg9IaRUnvwUzP6/07sGN71skFa2YOnofDUAQu11uJFe+COaHEUB+FylVyl26fyr0MfVgfc9t6K6A6otByxjC0E2Fc6h/wV1TlmMqy4nX1bYlguFg2WAdrOoCdLRpWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=elYWZSc/; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="elYWZSc/"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a5ad7cc52so16297177b3.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959064; x=1774563864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lB0R4ToRBKyubW1VyO0e5kaEQYSB9KgN2CJrsRk2sso=;
        b=elYWZSc/dG/pq2v5iMCPlvwSUe0F3U5wAx5vZm5yghJikf3Mpov9h0ggTpebQgOBxL
         Es7oJOdwDJgXXP9gaS1h+ygKpRqWGiEVG88mIVZkxs+OP+sXf4SM/7fDbjY8K5ixrmCb
         HcxrXZgml8bjsXQ1Qvczr5q5htGblOzfcXAFYXZ8CEOKcbGBFzYbbaZNJVfUOhryke9m
         ctievbwgbbY0d8hV2+oLyvtfdYkljot3KbSlxG8a2TfMeaJbK0UPCvfteLPOJfuIoRWt
         6+gch74gbQdLKiBTS9AdDSrn2isgmDJSST5VPs6u3qsyJ3c/142YbpzeSMm3iYDlYASv
         W7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959064; x=1774563864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lB0R4ToRBKyubW1VyO0e5kaEQYSB9KgN2CJrsRk2sso=;
        b=cJTsbC8wx17MC90gE7zr+OCsxnaOfsLtK6uclUA/uFUOL3ZEon9NHm8FNj6hgbn5yR
         O+lrwFsnBA+/Ccv8qq6cwJQ9wHWlOgNdINmFy6vuZQG4NQ87wBt07YErkh2SwqNURXP0
         pFQe5hoShouzi8GK5e42TmlrIqmWVeb03Yam9I65yW++MIGDjzr2KMnY2kPyxB7VeY0/
         /jVWxuFbD4BfkpRLQNJvVsJlbMXUv4Ikdp9z5fyvpS5ESb2dtbrNeaVo3ieuYvtzxIuo
         kkmIoYxM5CvxVkAUbb2KDVpbkaL6ZnwEbyOh6fAEP2gSt/2nXpMzlgdSP41jTZDB7w51
         0BqQ==
X-Gm-Message-State: AOJu0YykMukvvW3YSI5hzxoZHvlDQHNeboJYhksNs6B03bel9Zcc/3yl
	ulCSyLpeASRzmocASv2n98CS7RkOulDdHR5BartxbiKPZC6ke8tlqMgwh97Mq9tiLJmOi60jBTZ
	BZNX2G+Nezg==
X-Gm-Gg: ATEYQzzUgxL+j4yPh6JVHI/1IAFNpGD5+RT35P8WP6+hUpb5vKya9KxIuBEa6J86MdM
	gtXBBRnGh0xTmZxC3JbGZNFmXTkz9Vd9oCKeKaRWPOSh7TntbCp4XYuuS47jX9q583KPABTa6DP
	iUrGruybkirnFfqOXzjXkntgtg0FyMCJyf7LaCRNiOP7lujniNzsM0CbjRlpIBwczk/JeAAc8n2
	Y7+xyl9XTYeRQSeRSwxq/Rqi3oj/0HU/+R4sNW0Rc18y3x33CCfAEnYiwYXNdLrAzZOWrdgz+3N
	on4gOMh/ITGb2PqRFvSgK1AxlPT9uahQFnkGE40/f0XCtw+7Jg+M8C0f41Lk7AaXgfS9LcHeJ0e
	U4icBubH1JEgNuCGWZGTDaME0Zf9QNzTaUNN1z5ObW1z/HEDAUp690xlSFF9mcsFZYuI8hF82rT
	gNztPJ8LStzOnBhCg3ExG4dv1LQbKdOijy6A/YNxBdsOlgRPzpoWUWqGCv+69vr1342vG4N/iUB
	En5HcUlcWCXB/SJiwnuId5DlJvwEg==
X-Received: by 2002:a05:690c:698a:b0:79a:349e:9510 with SMTP id 00721157ae682-79a90ac34a8mr9395407b3.5.1773959063876;
        Thu, 19 Mar 2026 15:24:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903f82e6sm5831587b3.17.2026.03.19.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:23 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/5] t7704: demonstrate failure with once-cruft objects above
 the geometric split
Message-ID: <0ec9bba92ad4ca0bac1f063ad05294f2df12323d.1773959041.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773959041.git.me@ttaylorr.com>

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
2.53.0.614.gc4fd52e751a

