Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AC30E827
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860340; cv=pass; b=Ge9gFVsn2w7kgMzLhxB3WosnyTBNsF9b8PQnGh3VhCtFC5oLHVBZMGIT1YL+3cNBByma5y44Tzed3ecHrFa5HW5hAzY7qUnfdMFFmRLws+k1Faa8SgNdaKZklN/ioE0qapF79lnSTmRUi0x03CZePl3g9C3DH2qSeQMWfdgF6Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860340; c=relaxed/simple;
	bh=nwm+6+QBIxaA/X1EQIKFb5LacJwYAz2lQeveHIig3uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqwOVUUxu6+4r0bv4F0KAFtJxmb7/Uo9GnsBubDthB0iSamf9lz/9255ldH+KwSMyWYq0UxEwCPVzvRMfVXyZXpgPwZY+HevV3Tb46jpUuwHe3ZtBthKBiaXAAAIDU3YINdxknxC74Gwm8rdAHIf/kMWjBrnEbCQYVsV8+kY0BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8KHw7SF; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8KHw7SF"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79a62a2bb8cso2818867b3.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 11:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860338; cv=none;
        d=google.com; s=arc-20240605;
        b=BdmOrGqvafpj/s5QTq7De/ubyKSR0h2dZu00Zu2Eq6EKFOCFhG9hcHMFxpJWOSWVT7
         3Rayl+eRckztGw5Z1Ei4z30pTVGhTxsfT2AqCt3Z7vkehqoDRFCRkpVw6VvyEQJUtwI4
         oMDxYDL3Tr919Y9avWVa6ONIg7yLiwRZPbrVjbJMEYh/miWgSLm7DovlW+QbSERbIDBQ
         WJFfLZPiYUb2+NnEh0YijfDYdHWt/cUuzg0k38pEx8iY+CCL1sqvwWo0rNf4TEjoP23v
         M2oXWPcXQhooqhvvfytAlyp4j3lMTjWfqCKW2r5R9rykN6ivAoDcHQs+VQelU4KUejoR
         xlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CKIwg1IT23wgCtt7gbwKuBTMr5iZu0txbbBqNFUOGiw=;
        fh=FhDaD3HtDHXXFQZv7uo0Kt1Je0PoJl/Q70GifPcXmco=;
        b=heiZSCnYWpZ7xN+KYoif0WiDeZFWyZC2kXfJ6tqYy0vUS89QKuRdVlficeKLc7guGk
         B3BRllTgRHmsdZgBJtDKHT8ZhosYNwiGvPLH1OqQpT+VTM9lcecp0tYl3OKcsnEPt6dg
         RHLtK4VH9oTIF/r4O/v+5gPB4oH39HUSTQHqkaSBC7MASdHbCTrRxJ/PQJqaq/akSd5h
         eZu49shkiTMSFQl0wWHrfldXlrdHGerW5n2KlITLJycGL5qT/X7nrg4hncdxBPf698Or
         IFTEuB8Q4w60ySV9qRGJYif1emqweac4qexMGjHxWXQ4c4sPANnqoY+sC6+5MLEG/Uxc
         G9VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773860338; x=1774465138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CKIwg1IT23wgCtt7gbwKuBTMr5iZu0txbbBqNFUOGiw=;
        b=e8KHw7SFNf6rQp7OOkFMsv6ca6aglETsbTNaPmX+I0uVRgREs/fOoJ7po7IUvhiSqF
         Ck8WNwRySJPbPXY6PYWKM9rspkG8svirn+JI8b0nBf4L17ct+Jgzok+mov3NmPJCl7vy
         lO0fPyf369uYFMccRLuajTlsBij7zzKmZbLXaWzJatNNhSE448NtY0E2008DVDaoZGT3
         3J1MCyv8fdVxaWuQvMq/mwUTRLTBWOmIjRsPPiMxfI6b3JAerZ4ZfoeuNa3iQFrNVJEo
         0M5CklS7+DhGkvlnEzO8m42+RI7s0zzRgznifqsDMNMEl7nQZcGadagYdQFh95/SGMNl
         NTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860338; x=1774465138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKIwg1IT23wgCtt7gbwKuBTMr5iZu0txbbBqNFUOGiw=;
        b=R7a1bugiq3XYGs9xGZNyljNfkqn36mKB1SVpoD1cePsPuuabWGEDNt8OKcz1Ub6fOu
         SMX44quKiy4ogQC9Hssm2Cm0EAxlIhnjVWG38z5MrxJS7AeNfQrE9wXwaY9z8eOuQ99Q
         VCK8FpXykJwg9KgxKm0xqHoUwTkyXPihZc1pRjvYBCRnz30DtkzuhJ8cLG5Q9zfNxqzz
         RNKjMrkBQaWsNbdzE2vh0u5BYL+70d+3smJlYvUlLwEXpVDlXWj+K+jr1L0/JZ29CXBH
         H5LY0spXUu06F70EjdPp0Q552mKFsAJHtZ8tI7DMPyxRCPUetL0U60VhLs8Yl/m1lVLx
         Ahkw==
X-Gm-Message-State: AOJu0YzlLgjUnO8I/SteaKSPjvih0n0OfXhNifjXh7qn3R4ZnBydDo2L
	NNBA6BX+mkzA8ExBXI+Y4IItmRuYtoojHzowQH316Ypt7+0Y/+iqs1vRn8JGerKHknav27jpjnq
	hEmVKg/eTrbX8QBBdeImA8mGQ15MsLWI=
X-Gm-Gg: ATEYQzyQns9A3RWHM3xTfrQ0y88wCe+KBzvcPWSt5RS+WQI6ldV+4Xd5ySvDdM70sQ6
	yX6Sh6wDAea10oTIXlSk6IM8c7maWTR4JjGTwzzwuqD1AbeAAfVgbV9t1bFcJZdBPrHkuureKlZ
	DMU7SNiTBG9cya4g21X8Y7XrOUiys6DlQcRDZFJXQqRMdy0WHFZlrKBXNk2a69T0LkBqwRbaMsI
	ixTtf2Bvkz5cXsh9HdCpGHo+YjSWnRnWAUBjwBLprNp3pMI8DNAcoJimcOMBbTXITBjFKHt0NQ9
	N+qz/VY/jWZQd+LBXh/YN7St4nC4AQKkk+TfzIJAKcG4JihKWP2scAy4TwySkAVocfzVEzsOjyP
	Za6dsGOELpvZaCWKPO8ISS06af5te85965g==
X-Received: by 2002:a05:690c:d8d:b0:79a:6f11:3ac8 with SMTP id
 00721157ae682-79a71acbf46mr47260237b3.29.1773860338252; Wed, 18 Mar 2026
 11:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
In-Reply-To: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 18 Mar 2026 19:58:41 +0100
X-Gm-Features: AaiRm518s22I9HhWY1WiaIiQbGj2RQCV5TzEMYfW1vldkPutdlG42IQ64l5OOdk
Message-ID: <CAN5EUNTNqC6+FPjKafoFfgaEzWdpXEV0QNwumF8CaxBEUOmA6Q@mail.gmail.com>
Subject: Re: [PATCH] t2107: modernize path existence check
To: QUANTUM via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, QUANTUM <adityabnw07@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Aditya <adityabnw07@gmail.com> writes:

> Replace '! test -f' with 'test_path_is_missing' for better
> debugging information when the assertion fails.

This seems fine but it could add more about why it is better,
something like: by reporting loudly what expectation was not met.
Also, If this is for GSoC when submitting the patches or anything
relevant to GSoC contributions add to the prefix with PATCH something
like: [GSoC PATCH] and CC your possible co-mentors. Read [1].

> Found using: git grep "test -[efd]" t/t????-*.sh

As Junio said in other microprojects reviews, including the search
command it's not very useful when you only address one instance.

[1]: https://git.github.io/General-Microproject-Information/ "about
microprojects information"

> Signed-off-by: Aditya <adityabnw07@gmail.com>
> ---
>     [GSoC] t2107: modernize path existence check
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2071%2FQuantumDev-CERN%2Fgsoc-microproject-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2071/QuantumDev-CERN/gsoc-microproject-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2071
>
>  t/t2107-update-index-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index cc72ead79f..3bffe5da8a 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
>         # the_index.cache_changed is zero, rollback_lock_file fails
>         git update-index --refresh --verbose >out &&
>         test_must_be_empty out &&
> -       ! test -f .git/index.lock
> +       test_path_is_missing .git/index.lock
>         )
>  '

Looks fine to me.

>
>
> base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
> --
> gitgitgadget
>
