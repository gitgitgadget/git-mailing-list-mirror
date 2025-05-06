Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5392820CB
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549541; cv=none; b=aDsuJNIyHV5KhUABPdNXo+E8EbyqUuMUnVnB5dpSLx97sQHJs8aaq5615km/7WXgIr360PXBGxN3/mIPM+8P1Eh0e5yYGY8oxv3/GsWA7UCj7xtokSVQdPvVUUoaNAavjRANb58z5bCkK7KNq2O0mdj1qxw5xPCJ55+gVMY2x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549541; c=relaxed/simple;
	bh=GEAaXlATV2MsoukTVJp4GQ/d54RwBgiW7dLaTb8dloQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G1294ESA8bEu8OxhRjDU//BNNzpBB/mAz4kmpndeCnkde1b3O5J4FxEUW+aoaNV8ikX7PEumalkeTwN56PCOOjp3LWOzql7tKOADEW7mKpp9AYkjrLAgR6a99GiG8AB6s9Az6ZiPS4ejJn/1ljDskOf22XMmWhshkbuJFcp9XI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOxxFEAx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOxxFEAx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso70898245ad.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746549538; x=1747154338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2htmNvaWYTGWl++hRiNSafawvyQ8IleMqDBwSNE0Vc=;
        b=KOxxFEAxmh4JzUe37LqcYC9bVhfynjImLxMaCHnUizIKvc7MvgoW11Tyl+rmvRoJAs
         NPhci9IKWG7jkhLZSsZOOPX12OshI/PKdfqIWOqGP/m1nLgDGjzD7Dx2lMF3juBbvZdh
         Sr0c97h0b/krDSCeK3z04qQAp/fONagqS/01PAEYc6ZbgsC79BzfeLhFZMmQi96ulJpd
         rR8BDrvHm5pomZe6TksYUpLIelpQ26anKueCflOHNMC11C5lvuV4g6fPlalhNCNTjlnT
         DhUMqSSF+8rP4IUZzAE/KqEHLfoOn6Iy6fkCJlRA+Istuu0uVTcf3FXI02T72226GEky
         9+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746549538; x=1747154338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2htmNvaWYTGWl++hRiNSafawvyQ8IleMqDBwSNE0Vc=;
        b=GF6ur+ktHG2+TITMTIza5gQ7IhmFsljaWIAdl0j8DHHpSi8g/TR851nBWbCdCXjJfe
         1CEgc9YzN9tXcUtVN7VvrYX4CUrk4haQUCSWiJMs/mnkbmfkbqi77ah73EiXthA4edBN
         i/9ieqfUUq835JO/21zYRB6K2L9LUpyze2C+VGg8gpWV9d+aq48WiEHurlgllDIwUkuB
         NGES+fI0nTGlmlhpfx0wllboSc4HnxlYtF6c79zQ+ULfrQUIyFqHKbGB96xglJhzmRMt
         oGsRfvGmBL3GgXl0w6lbS0ToKPh2dHyTTYmVbHMbcrmqh0okMoEgKxzwjRTKlMsFJjCq
         E2Vw==
X-Gm-Message-State: AOJu0YyjhX6Q7byaY795jaqSz1zjP1NcAAI1SDOXPQ88TaFgaSr867Wl
	Q9jESilea463l57jnmFJ77jfUYyTUjJZM1ZYG1dIlEyxGM6CclJ+dk7mkw0n
X-Gm-Gg: ASbGnctsor6VdQx+W4wnOdrEOvVkemy6VU4nKUN6fSH3OmCm+6jUgoLH7t66VPJlY7j
	JLO9AMzFPtINXgIhIfcO5qXeDEWja68ToUVpE7bHv/CxSZlBn24tjfNiQvydL9YZr7kkCI+3Iq2
	I3RL3g3ZvghWvp+TevNwfNxZUgqus3UXwylio8Ky8+n0CuVFqAZDt/NHjrjfuoiOIbojRpvcmf9
	G5bw5+5kRMI3GNDdeqG4lW7jZNdr9B7p032yBObnuteFoZ65SIsg69zoavhgDcsazUXzq0VGpU0
	KCNFm7Yt/N4wLSiiUcGfvdr7nCMIf0v8QwIT
X-Google-Smtp-Source: AGHT+IHfyAg5E0JAOyuRy5pQF9jcWpskPjY4iBKU4P1MhrRjLAJvFKh27qiUEGhhToLw/XmOCwzfig==
X-Received: by 2002:a17:902:db10:b0:223:653e:eb09 with SMTP id d9443c01a7336-22e102b8537mr216613375ad.7.1746549538561;
        Tue, 06 May 2025 09:38:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22e1522fb26sm75683075ad.247.2025.05.06.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 09:38:57 -0700 (PDT)
Date: Wed, 7 May 2025 00:39:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] align the behavior when opening "packed-refs"
Message-ID: <aBo7OiCKHTyT4DzH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All:

As discussed in [1], we need to use mmap mechanism to open large
"packed_refs" file to save the memory usage. This patch mainly does the
following things:

1: Fix an issue that we would report an error when the "packed-refs"
file is empty, which does not align with the runtime behavior.
2-4: Extract some logic from the existing code and then use these
created helper functions to let fsck code to use mmap necessarily

[1] https://lore.kernel.org/git/20250503133158.GA4450@coredump.intra.peff.net

Really thank Peff and Patrick to suggest me to do above change.

Thanks,
Jialuo

shejialuo (4):
  packed-backend: skip checking consistency of empty packed-refs file
  packed-backend: extract snapshot allocation in `load_contents`
  packed-backend: extract munmap operation for `MMAP_TEMPORARY`
  packed-backend: use mmap when opening large "packed-refs" file

 refs/packed-backend.c    | 106 +++++++++++++++++++++++----------------
 t/t0602-reffiles-fsck.sh |  13 +++++
 2 files changed, 75 insertions(+), 44 deletions(-)

-- 
2.49.0

