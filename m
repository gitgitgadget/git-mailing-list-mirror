Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9D3CE4BF
	for <git@vger.kernel.org>; Mon,  4 May 2026 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896814; cv=none; b=gq7Y/51h9aG+HGolUeSYazVeVRS9mz7ozXVxa02nMeLHslqIMSn5Y1FFTFEOOl9jSaroMpsmdY1GUSotc+xAn3Vn/YniIUoB4VrqKtBfSne4qqD+2zTAv/LGU54nGyHE9nG6AgEeS/5qE4e++BI3NtUVSVAFPRTJPZaG/NKtkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896814; c=relaxed/simple;
	bh=CvWLUza6lOUrXDEwIMbdbdYrQW3lu3QDhuFWRkG+lqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofyLrTsuMu8HKWxKGEGW0wXSbz64F+8zKlIlyWTQY/Fjopp5j1l2hjb6CH80aW58VAp1+tbekMmY59H5O98uX2YTmmXz/kERbYeu/0cfWW3q2nphaegt8p6QgRUfO6umZlQGs+hol9ezH/fnmAPbWN/fIA5hWBmvTuBr34u6e/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6dsAwjm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6dsAwjm"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e594413c2so24540781cf.0
        for <git@vger.kernel.org>; Mon, 04 May 2026 05:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896812; x=1778501612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uhlk7RQj/S+BSOj1JC1QUntkQLSjsm4078i0cnI8IZE=;
        b=I6dsAwjmTaYS21qgKiS1HZ5bSTLF5YYyndxzIBhXhgPU3ndxa+QKw29An7SgfWfMCI
         McDlPpdgqyN4bCL2aYadDSo6hqxIOp8zBij9suJG3rqH9+vLfV8auvY4sqXV2CUFNpof
         /YSXqYZfx5D3ZKuqs1l/YgWMYMosbYhrNsh0yKw0ZAuRNWt8Tm+dwRVIGtIediLut7wt
         RqQVW/8ciGCa5k29eFYIwfFdvAHK7ZwOWG03Ax69ntMd9jnjZ0caQyPKYfqgpaSVmTdZ
         RYxbfUEU9UnfX4UvkJCyghVBy9dLm2crmeU8PJyAIliiNKKdhCO/iCGGBxKahxtMHqla
         Tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896812; x=1778501612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhlk7RQj/S+BSOj1JC1QUntkQLSjsm4078i0cnI8IZE=;
        b=QB0JmKdYoSt4fH3brj23/jEamHqCvu3/55Dr98QZaS3lOdWpYZRBYGngdK7oFzDbxQ
         1g+LaYWLiRQIU/R9UKtd1O7lNvRHdkaLVgYCoDZQ9nR7iTiBEWMF4o1G08clODkBmB6E
         DNQe1Io0On/kV6rHQwDjqmJellUG1dradsscO8xh4tTL4TkLPxbCvOcf1N0ZuJJGrzt5
         HXW4BjCfZarC0TNLj0qB6d9a5nFsmgFppDs7P5zKtu/j+QVspYGxShzmii0GbuQBAM3n
         dk9LDbQp1rPcNtspRRRkrNsN37ALKXD8iV969cOIV9goHLRXrceWmk0H0/8NckTVCAc+
         UpAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DTS6LKK2G1ZVnnqMUNfmIVSixFU5RlTgABAT5t/V/2rUo9fftNTjRm3+mfXVyg161GfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59OGdvrLMV47dm2QbNYIqjtg0UPpTjVRfq1A1ZCo0JUNfYNWw
	yfSKg8VPUnCg7ikL4giM6QNvLOnjvfGSkL6h30fwLvI54hEbnZwX0N9ttbVNb2/h
X-Gm-Gg: AeBDievi73FtYICrLd1xFbAQs73HTEvIgcMxBUa8dbv37hqp13KjJ2QV2XDS8BSxsME
	/DdAGJ9N2SyxPt+Kikw2XzSNGesMAMsV+7RjdtMQiWqqoaIOTRO9RxU9Yn0o3+LqXUsbTa4/REi
	rQJJ69moUt4u+2Pr5aU4uTHU51PjZ+8/yTPK7A6odQTjkWXs3QPvSfVK+nO8eN6Mp/PrBA4NSy9
	gE3K/rcf6CvlahFdP9UGwChUMhyBbIjOwPjrOF8CuWp0qWNMwZ7S4Au6WK7p0oPyQwrhCcxem8+
	B2Z4kt4nSfIWl8Zpv7zeI6hg6XLGt5UXnsSs6FVmJl3TcuobeP/tYc+fxGf/wgrMhyVAFbHMPKT
	bisfGwVxgIKeV35DK+vqUxxfSJJQaKZfunAfa12jy/AQY54ugtLV3YfU4n/Zz1OlF6BTBe3us++
	de/rMLPM5ik9dw4QiMrS9YI2biaOw+yJy7rYMLeWGYW5990q7FQL/Ex050+fNxroOdR0XCvzanF
	zgOyfRH
X-Received: by 2002:a05:622a:4a8f:b0:50d:7ca3:379a with SMTP id d75a77b69052e-5104b442bf4mr120547081cf.3.1777896811942;
        Mon, 04 May 2026 05:13:31 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b33248sm95312051cf.18.2026.05.04.05.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 05:13:31 -0700 (PDT)
Message-ID: <e70eefe6-9c18-4643-a995-69fe99edd1e3@gmail.com>
Date: Mon, 4 May 2026 08:13:30 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] pack-bitmap: resolve various `--path-walk`
 incompatibilities
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Elijah Newren <newren@gmail.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/2026 8:11 PM, Taylor Blau wrote:
> (Note to the maintainer, this is built on top of 'ds/path-walk-filters').
> 
> Between other tasks, I have been working on trying to integrate
> `--path-walk` within GitHub's infrastructure. In order to do this,
> `--path-walk` must work with features that GitHub depends on, such as
> reachability bitmaps and delta-islands (along with filters, shallow,
> etc., though more on that below).
> 
> I had been sitting on these patches for a few days in my fork before
> Stolee sent his series in [1] which resolves incompatibilities between
> the `--path-walk` option and various filter types. Since I figured that
> others are working in this area I wanted to send a reworked version of
> my series for a couple of reasons:
> 
>  1. Since reviewers are already looking at this area as a consequence of
>     Stolee's series, this topic should be slightly easier to review
>     while the area is fresh.

I agree that we should review both series together. It's been a while
since the original path-walk API series, so it may require some refresh
of all its nuances.
 
>  2. In case Stolee (or others) are working on resolving the
>     incompatibility between `--path-walk` and either delta-islands or
>     reachability bitmaps, this series can either combine with those (if
>     any) or serve as inspiration (if others are in the process of
>     writing such series).

I was _not_ working on bitmap compatibility, but I'm grateful to see it!
> When writing this originally, I had borrowed the same filter-application
> mechanism from bitmaps, which supports trivial filters (e.g., blob:none,
> tree:0, and combinations therein). Stolee's series is a strict
> improvement on that approach supporting sparse:<oid> filters as well, so
> I reworked my filtering-related patches based on that.

You have some new filters that I had not considered, so they are welcome
additions. If you don't mind, I could add them into my series, as they
may be more appropriate grouped with the other filter changes. 
> The patches surrounding bitmaps and delta-islands are largely
> unchanged from when I had originally written them:
> 
>  * Supporting bitmaps with `--path-walk` is mostly straightforward, and
>    boils down to ensuring that the path-walk-specific object callback
>    indexes any commit(s) it sees for bitmapping.
> 
>  * Supporting delta-islands with `--path-walk` required a bit more
>    surgery, and involves propagating island marks for commits in the
>    path-walk-specific callback, as well as recording tree depth
>    information in the same spot.
> 
> I'm submitting these patches as an RFC, since (a) I haven't thought
> deeply about the approach taken here and could very well be on the wrong
> track, and (b) in case Stolee or others want to combine forces here
> and/or coordinate around each other.

I'll definitely take a very close read of these patches, as there are
some interesting interactions here.

Thanks,
-Stolee

