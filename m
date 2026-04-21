Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186CA3DD51E
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801741; cv=none; b=LGdnpUPgSXVakaXk2k+V2/gNrUC2gfZ5loZILSaX6biGwrFaAZJlWryxN2zfPXy5cIznQs8mEKZB8UJYaLTaBgQPrj+Xm0Be5rfG3qKDAzuwXVeQEB0l7end99v2y6Zy9O8LKVhmK0B2XiXvIvIZc9Hq33niLeN2oBiQnccNi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801741; c=relaxed/simple;
	bh=wTMNkCJ9CsTASmuBg/c5lWN4Yhc+9EV6su+6xPC0eUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8BrN5jREQWw9zPhYLLg2r4NcgV5+fmBkzk6EwO6sycyTDiCQWFfVRKsIjcvfFhFYGPN/Obm0Wc4fA1urB6sK9CjcufalsRXBthpLh6HRKr/pqrCVHSKnXy4VjHmG2ITe2DW4dp6VoQ3xvilXATYD1Vuu2cys0NDvjWF6O1xke0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HITTT5qi; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HITTT5qi"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcdd1b492eso765615a34.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801739; x=1777406539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOGCs7bWQp9FnpnMqWhs1p7JroGLs8v785zYB07SflQ=;
        b=HITTT5qifoW71iU22VipFG5ylLzWQDBkXRC1IxLE2a7NjKnGeqTGhZaKF6EuZDz+A/
         RuQJL9ZIV2oE0SGCvVJgXSdK8+Qk+vYx4BIYBA9ktb6MQ1azcWQxJyJN2QZ0V3QegFOi
         btV7lWpa7b9qtrFiiMTkAVr9oluv6Ijh85p01TjFT16fmRNzsR5LKaLet7R2ZrFdcKgd
         XUbX3Cm6iMHOBlO7FFFfaZUJynCTNzCg5HJXS3NozNMVF3pnlFBfKpycpfb5BNNkbcYx
         9HMOqtUehbJDY5Bp4tunWTQtC0RgvHskrM2itZoX1acbGL5//nGgg9IdHkkHxhMVBddZ
         9ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801739; x=1777406539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOGCs7bWQp9FnpnMqWhs1p7JroGLs8v785zYB07SflQ=;
        b=rU2S0E5AOA8sNDy7Gvp+q7TCd+8umNQfEbGcbYgDTFuSHQCUJuZPAqZNcVQjqboWj+
         Fip6OnvjPOHeD4pBka5eTz30NdPt3kkH2w2YLZms3UjhDjBQwFxd1+Z4SJ9e8SiwPKFo
         cE080wAEuuqA0nnEDdxl8xgNf77aPsJzrW2y13ev8M6iDrvKAnW4oX3mmU9oRwE4cD5i
         XioGxQbYQkg/lqEHRzWs5+H1qFn5cMQBHVQQiKHheVniJ/gzHNlKDdbqQQUBaAkyKLEb
         Jk5nIzUgRtD3ob3vTFrIiTtNSWYTwilh/4/rb0q+svuEdPa0RK8yxSfo6W5sdkqN8C1/
         b7yA==
X-Gm-Message-State: AOJu0YwZ/9NZz/hHcpSiWlP4sJMA1p19iGMBMpjuhfLh1A6BrVCwcx/f
	gKqrmLWCmhagy8zYAdgAaHzwlypBHCHa6X6s0WHldgAfSJq8GXSza/aHfAry09DvV54OrFMxUwq
	VZwEizsE=
X-Gm-Gg: AeBDieuEIr/YCXsSVn6ejWgJgrNsX9shzT1d1mr/OXau+mc/ciQWXLlFNyJf1P6SQlA
	5LzFUT+dE/CcdXXg10GGKGZ8Fx7pTXXE+j4n0CqPVXaFH+g7aZiSZgxoAdprFCEd+FdwH6tCYPH
	hWq7EkbVGwdZiuD8yhK5azE6M5652JIoSlmi8Ylr6ZnUGKDMYG7q9OkitBGwwOkF+Vg+Efa6fLz
	CildbXUbZfcUJKm5ERtWhlO/zxyFTztIrjpGXTYSqm9crtw3cx/vebDaPBJOPdeTCHeRrUF33W2
	dgriSFd6RiooFqzIZ68R83/R48W4uqKhxFdZVmhvcdp8i46+sbu2V8jC7WJfzF6RpBBzypb4tJr
	JhSMq5t/ashaFEMEJFE8FNhqreNhB6dsfK3kgc99TecB2bEAT/m91SL2RJl420URHSFCf4wtJj2
	Pzq0ndWYwb+PwH5h9HFQM6tiz6+4XLJW5/+w4oFZcutGTDP8Ow0wI7qi6p/APVu5KTBeyN1IxWc
	GC93dvVrzwg/NmIa9tjuTDr2QOC8tCLS0/tQgr1AtcInNEjlqZeedkxfBDOwTCpjFJklG0Hy9+s
	1B1Sluj+v+Z6cOintdvnf4BT6Bs=
X-Received: by 2002:a05:6830:82c6:b0:7d7:e3d7:e200 with SMTP id 46e09a7af769-7dc95525104mr9666983a34.6.1776801738856;
        Tue, 21 Apr 2026 13:02:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcce5feb25sm4243077a34.26.2026.04.21.13.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:02:18 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 8/9] Documentation: fix broken `sampleRate` in
 gitpacking(7)
Message-ID: <c37156502c006572fd54c2a41a3db9a1553d9a4e.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

The documentation explaining some sample configurations for bitmap
pseudo-merges incorrectly uses a sample rate outside of the allowed
(0,1] range.

This dates back to faf558b23ef (pseudo-merge: implement support for
selecting pseudo-merge commits, 2024-05-23), and was likely written when
the allowable range for this configuration was the integral values
between (0,100].

Fix this to conform to the actual allowable range for this
configuration.

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/gitpacking.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitpacking.adoc b/Documentation/gitpacking.adoc
index a56596e2d1d..e6de6ec8249 100644
--- a/Documentation/gitpacking.adoc
+++ b/Documentation/gitpacking.adoc
@@ -150,7 +150,7 @@ with a configuration like so:
 	pattern = "refs/"
 	threshold = now
 	stableThreshold = never
-	sampleRate = 100
+	sampleRate = 1
 	maxMerges = 64
 ----
 
@@ -177,7 +177,7 @@ like:
 	pattern = "refs/virtual/([0-9]+)/(heads|tags)/"
 	threshold = now
 	stableThreshold = never
-	sampleRate = 100
+	sampleRate = 1
 	maxMerges = 64
 ----
 
-- 
2.54.0.9.gb905fd5d0ae

