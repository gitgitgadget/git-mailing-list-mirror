Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A964337BBD
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336231; cv=pass; b=BXOZiud90XgiEwiEOKtY8Vsxvc6wHvIzs6XQ3gCnRwviIqfhb2Vh0X/jHXOpG8U/upNeTktSD2ck1Tr5wD0sqm2S07jRu1+QW7AQJpoQ8jf3NuqR7IVg5qXd3BA1gUTOF3Ql7LIJ7v3UrsKAQZVleBB6oEyBwHgROKDsh6+rZDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336231; c=relaxed/simple;
	bh=gtW2iuErxkL8GQrsDSvS7w49dbaySolbLbgUPdbTbFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNQL4mEgxEooK7AwXAOaPxpTYIOfk+80IKTPIs8U/Yu3ctjIvWodaBjMVIWxBL7dSj11k/Kd53hZj2gjXyjl3yPvK5skLjpNGw8oQVr7Zaqo7r9ErI91L4Iue1kWuXE/lqsQCKzIOhALlmoh1svXogEkkzDRane2C6lsQDE+//M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIJQkv7M; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIJQkv7M"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1aa29e06bso2139354a12.2
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 08:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792336228; cv=none;
        d=google.com; s=arc-20260327;
        b=Y23NMkQO22u3wJw5WH+2tKVMX8oNyS4PzNb50r8SQfgEUSjsIF1AkVCklrZl9UjkjH
         w0rWarinsLOm+3OGEOiK7GA4OEYejx8gSX7ZOKjM8v/PMpJyxyX62oGGwK1vcv9ilwgA
         f8nfZikcGCmmUWJVMOBaNWQDVYtBdf1ceEfxhB1Lni6H75NesKFWq+v8/DRYzK9qbDOC
         3re12tDuZV5aCLQXZp7h4UIIYX7wyQ4QRuU0JK6dnbS/Y+xhrz4qMSQQiAPi8/ezv643
         of/p6gx1Wq92d4OetjrfuxggR6EJCnrjAS8MpjdowMcPCLrIqgJ6QTAPRrJjWyoSI32I
         p54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xwlt6/QcW6d9DC6mM7RR9kFOj6+ZpdYFbNeKGcC+WOM=;
        fh=Fv6pr+IvrKmUTBW5O0zdoD28xI0Fkr/BReBrER09lRs=;
        b=dDYd4crv/z5gKLVXSVf4+WN169teSbmFtrLuVOdF1c7Vowry5m2A53axWpDuQt+zYM
         KgUplfDnM68dVc8EVnFyGy1jgpigrCt7uZUKNZwcz1XbouGti1Sb9HjbGHyRPsPtQ0hp
         +rNj2qhqNMA8AT45/QOEn9EgPrvDZYFbv9tK/z1rx5NHsbmXzPy8Axtbkb9S7airqs4b
         iEQeqw3j+iaK0rdz0X/1JvTQtQao6Xgqbsapj/UD7JoPolDHBvN6KarrpDijX660unYJ
         zKY+S3r2PZjUay0PPmJbxU6oqNo4No89XJ4EmTT6WE6YYKJX94Ln0x7Qt1W9dt7pjGig
         uVtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336228; x=1792941028; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xwlt6/QcW6d9DC6mM7RR9kFOj6+ZpdYFbNeKGcC+WOM=;
        b=pIJQkv7MQK2gP1pxbsbixgPZLQC5zAFLSDRB6YJ0VcBXlnxf3kKCgxprWTHhmpGPyb
         eX1OAQZNTjSQgdEoMnqNQ5pe6qgYnmlRFyVxNVyayFybjfxOxwTrsVApJdExL7VgkIqq
         BlwuVtGvS9m4Mp9Gvb8njJm7UEPLULLR3+OoxoKdsrM9R0ud9BajSsbJBE+dOgd/veQK
         9QhBIzGy0K5GRAUicr5OgaibnzqtCbaWVK/pYPEcyPm/4KQXYk+FrJrZbJRybX2Dw1yn
         /fP3Dk7sC/YJjcbXAtNslFgnredtEr+0WND39T8WYq88GkzyRGKshfyTIBQ+h1x3Za90
         /nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336228; x=1792941028;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xwlt6/QcW6d9DC6mM7RR9kFOj6+ZpdYFbNeKGcC+WOM=;
        b=iqvRM+QOrt1hvgwDj9CwbXPbyLBQUDb80dKDR2fOlIYH2eWm0tUtykX6O1UDOMMK/g
         9dxKGFZL+WVwx1XMeQWQKCmUC9e5JYdeah1IZNnQaI1gerT2axJtI60fJ1mgTaBlQv4G
         EETB3cwb0TZvl9aRQTyB0qtb9bf2+kj2Z9PoOvhQiC7dS5T+DyzIgclGif8uSQAb0AUB
         Ul30wn/Wx/NRFqPXeiqh5D2m7a1B3H9uDFzYVokST8+UAOFcEkza/+ZQlG8DftfIKVx4
         IE4Q0o3xJndSdkkGDJMy78HiupegCkIHKSHHcEtqwZ67Dysubw3hVPlxBwQgZHmM5WaA
         HoXA==
X-Forwarded-Encrypted: i=1; AKwUvBwMbV9hqroA5Cxfw3UUFYukWEk7aF4MAZvmOMSCZiTSnBBtdXjgv1QiiIwfEMsAhlSsS7s=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCHUeEHqbf/6fTQI16UwMsnm2OxE0/npaHm05aM7iWcjaB6Bvm
	WpbWfMn3XjWZvoeCjB+fRHbH+4DJlF3nZFLHCOdGzeNZlu0DNpPnAm5fRdBnsrx45H559OaAL0A
	cx/vWFKJY1zQl7dayyxajxV1IV6Q22EI=
X-Gm-Gg: AYBFou2ssw0WO6tj70y2HKuTAGmQ2RPSda9Qk73D9HRjaDEFuEbOfAm6IhwcG/uLeXu
	ly8Dm0I1IMKxFCWvyd/qqmF5fSOblbpvedztb0nAbVx18gpmiYgAYszvIVfPpTbTxMHlIeuGHvw
	LutIlsyvKLPNt+tBJfmeRdfCeVX2JckIatCdMOY3OGP4QFsPPEYXACxYHRB2jISWT+T5zwl9STO
	OwxU8q62oUsMtdhj/HoHS4bFLPi2Nsrtp0tbUxRZCH+YYK2kDhJChWQRQXm72FlrqC4t7aWPbO2
	7WJFsf4Zr8lS93ULXVdG0gCByEzqWb0N826CdndR8G1TguGetOZW8Q8=
X-Received: by 2002:a05:6402:3217:b0:6ac:765e:def6 with SMTP id
 4fb4d7f45d1cf-6b3a80e3881mr2993962a12.2.1792336227681; Sun, 18 Oct 2026
 08:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com> <xmqq1p9vdalz.fsf@gitster.g>
 <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com> <xmqq4ieqamn0.fsf@gitster.g>
In-Reply-To: <xmqq4ieqamn0.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 18 Oct 2026 17:09:51 +0200
X-Gm-Features: AclHuK8L0GIIX1D0XFMRIOXYXcrbu1oqLavWXaTE2up1__vCXq3obBKE1NS8H6A
Message-ID: <CAHwyqnXNyM+qaxggQOiW+jE5U6B=jOOcv=KGz-2XS7jnB2j-uw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> At least the one-to-one part of the operation should learn from what
> Dscho did in range-diff, especially the part that does take
> similarity of the log messages and authorship information, instead
> of paying attention only to patch IDs.  I am not convinced that
> one-to-one rebase implemented as a subset of squash merge would
> perform sufficiently well, either.  From the user interface angle,
> it also is not clear to me if a single --delete-merged that enables
> all variants by default with individual knob to optionally disable
> one variant (squash) would be a good extensible one, when we may
> need to deal with the third (and other) kinds of ways to integrate
> your work without preserving the commit identity, like selective
> cherry-picks.

I tried a range-diff solution locally, pairing commits with range-diff
for rebases (and moving the squash search behind an opt-in flag). As
far as I can tell range-diff pairs commits on the diff alone, and the
log message and author only show up in its output, so it didn't help
with matching here.

On speed it went the other way. On my clone with 65 branches, v2 takes
about 0.5s and finds 14 branches to delete. The range-diff version
takes about 10s, finds the same.


Harald
