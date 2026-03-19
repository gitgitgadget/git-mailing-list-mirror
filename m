Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C23ED5DA
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937611; cv=pass; b=ljJai0IjI1WAEKLKcb0ppNqUmzeZWIG9I1X3juZk+X4h9Fil9pl6WM8oB4NCfO/Y9/CWniEWEF4c7ISKVItV1+13qiDpqzBqyI8TwLBMx56kkS8ikI0Bt18NPmVe6hUYVPv5Qdz5bX0Br/5ZKmjIzf3cOUosoc8gddjKYNPYoIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937611; c=relaxed/simple;
	bh=9MM3XONv1dvMwoO21UtoNNLitm+tvxm0AgSApWBEzr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVDHqxH+hC6DNXI2EaYIn3oeixA1n+GjsYoFJ+oEde4sBoV0lFKXQz3P+2S5M/zsUOCFPhTEVrgITxu+YEUp+Vp0EVBimsxoLvG+ZM4/Ht5HCxy+Z/jFsRjbQRg1nachtq+RiQJdc5T8PbS8xEoCNqbtc7MDwwOqo0UlP0kxqd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3SrQR4u; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3SrQR4u"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-798374d0f44so32882587b3.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 09:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773937603; cv=none;
        d=google.com; s=arc-20240605;
        b=WSZHt9ZJSOBH7kTsLrcFQ7aA0Mxxf4yAQTRbhTuF8LnAUcMru/o2ylLbEz9B42b9YG
         7PCVx6OyCg9SikRbxaZGraNomgPfzi3ZOu076/1ZeJ3WrTLvscNY8QmhRWy4LMfcwsvc
         YKr6h9nH7x/gDtg7Lssyizk0KbJfPjHB9j3uyMwkjFWs4guVmJSsk+X1mOo6z9in9m3n
         LJvqspfRBRfhEa+NC6VmyD3+S5ix3tu1jPbMmp6+xjY8XxrAUbJUKrIe9GgNBcwD3mqf
         CWGlUyS2NNs2SMUxxhJSMpCUL/Hjx34WEREV/WDtQenjS/7gSui3c8xmQwJXWtz/85kJ
         ihsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yaowqvGq85D71uI0ozpAq463EZj5sjv2t5LBPBf2yh4=;
        fh=OKYDgHbmqvclOqh/X1I53BzXjvNsxro6EztDs11EBNQ=;
        b=ao0UvZGjryiJrmalqfwCSwXG5pXe6/O9to9s+1SPuK/n6bkYzUNnY5IAC3dGqgr367
         bBlENpZh6p+0R1xGrc4bXAqc48zwSyCud3erB0PyUfW1OaVqjYRZbKnPe47GB2DeQz2j
         OWtNaV2i0sWP96Rg96fitsGOXxYMsgI67B2VORC6urYGkqBXBntfVODTxqlCGi6p2sR7
         45cJJTDaRsaG/u5Lat9mpkGegmd0duvKz/K55npZHAVsm9LLGs4jxsIVYuvuLQtd06dn
         QGjYSf0ufbqnSSXycC5EHF2bwY37LElMIlgZdJVMCLfsTGJPxszdf70xMzpJHrO1ztgG
         8NYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773937603; x=1774542403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaowqvGq85D71uI0ozpAq463EZj5sjv2t5LBPBf2yh4=;
        b=W3SrQR4upZ9XVwYNukAK8UrKkP02dOEb+G8m6sTexemB8pgZSw0mobDDE2W5J9EWRE
         HyI1gkbRQLAjHmpqdgzkoJRUwis3AyGDSq8zXjqCIR5U9AUdGnpjPZ1rPUfMrbrPYaTg
         AntqAlIXhK57s1ZHY3Kif1hvVf0/Vty5gXlH0XFzzY2iys4/KnH3RwR5iYY3Ob5hQu8U
         IKJKjSfT+jgCSTN/KmwVWbBY0uIXuxp4vOnt6aPWhT7rfJERbFAwW711txsHSNnKWs+I
         yf6dIaxaD/SegRT5YlBOYOIAlImQox5rLaXMR/h4WD/CQMGX8FL/hhe41ysCnWz78BVZ
         f5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773937603; x=1774542403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaowqvGq85D71uI0ozpAq463EZj5sjv2t5LBPBf2yh4=;
        b=k2RCXdJbBzSYANZeeLJ3UopKRaUlWIGkIfmqblSD8FvRvOKuczKdNZOqtkE4aVkPUJ
         9RqSReMYSQDEJW0ll//ZQUDAlM8cZUNaeHN1vVKeSAfsFP9TWu0hK0OKhP6LrtKL4qTD
         pYT6kACFxEVQlvgia3uIq9pohwGS9yantcGckLEQcJhy08VJ30Ug5fONLH9j1fc+WRfz
         YHz4MIfTLD8mGJq6wMF3Z5Cf5zgtkpFy4RFiVhxKP4hz7lvNBIu1F7JEc/z+flHP+vlE
         SN5D2HxrTijhJ+jvJauxZWxIrcV+LPSg0YlfcEwK2aTS9XlWIsrmB2+GC07T4roKBrwi
         WExA==
X-Gm-Message-State: AOJu0YwY/YiFrHXfoQTnKPKXkn2AF4tmqgv0Uo3qgAy6xWY6ogqU1n/x
	Nyjdw6AqkPNeNjbzTcZfljKI/VGpGnwigw9r1ADeSX1wzcNafz3UliS90lhK6C21B2h+UoGO5kS
	1sAO4W2xN+fY/e3CdykSnxurhgyJGT88=
X-Gm-Gg: ATEYQzw4mexlPQ881QD8B/7sXAHWqk0Q68NIlF9aKT/7xIlc8XVBdmtqclux5CsDxj0
	+G4lh5EvXJpE2mVbxVrfwqZVheuTApyuE8CYKx7VwbDVTEsu10znX35Pznoy624KUAWWj5q7RGN
	H68q9t4cc/SEkfjo+mtsGntvWGrQaMPEtj35SeEtFx0VH7QJwH0yP3b8c8wGCGF1Wjx6bMjdNtp
	YhERQ7y4698KNjcdxnb1WLjSNAreQos3Aezaz2bcpMeMl3/GOA4/CwMwlCepKHAY4PmnS1O2XxY
	PjuGNiQmO7GRpFSIJtzN9/lpgV9WweLzPTQIH9EVuvvsV10XmYYhThA+ETRCOi9rqXXYWQ1qaYn
	tGggIhm+8RaPbvDbEUVR6Fnw=
X-Received: by 2002:a05:690c:6d81:b0:798:e281:a518 with SMTP id
 00721157ae682-79a81b51f0dmr40369667b3.19.1773937602825; Thu, 19 Mar 2026
 09:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
In-Reply-To: <20260319160301.98039-1-elkhatabibilal@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Thu, 19 Mar 2026 17:26:31 +0100
X-Gm-Features: AaiRm52WHGUEZtUGVTMYQ7DyQTyJ4nOrJRmFIl8m-uBVbQkSmwf5zRXPxqVSBMY
Message-ID: <CAN5EUNR2mqpCMG0oPsDnzgZr-2yyL+S0A7p_MM62F7d4MjBuSA@mail.gmail.com>
Subject: Re: [PATCH] t5315: use test_path_is_file for loose-object check
To: Bilal El Khatabi <elkhatabibilal@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bilal El Khatabi (<elkhatabibilal@gmail.com>) writes:
>
> From: bilalobe <elkhatabibilal@gmail.com>

I see this is sent from Bilal El Khatabi and From has a different
name, How do you want to be known in the community?
PS: from Documentation/SubmittingPatches:
"It is common, but not required, to use some form of your real name.
We realize that some contributors are not comfortable doing so or
prefer to contribute under a pseudonym or preferred name and we can
accept your patch either way, as long as the name and email you use
are distinctive, identifying, and not misleading."

>
> Replace an assertion-style `test -f` check with `test_path_is_file`
> in `t/t5315-pack-objects-compression.sh`.

Try explaining why is this change needed

> This aligns the test with the path-checking helpers used in Git's test
> suite.

It would help to explain why this is better than what was before, for
example that this helper reports loudly what expectation wasn't met,
therefore makes it easier to debug.

> Found with:
>   git grep "test -[efd]" t/

Many are adding this prob because it is said on the microproject to
add the command you used to find the file, but because this is just
one instance, it's not very useful. It's better to drop it.

Seeing that this is a microproject and the current date, if this is
for GSoC, add to the subject GSoC with PATCH "[GSoC PATCH]" for
example, and CC your possible co mentors.

> Signed-off-by: bilalobe <elkhatabibilal@gmail.com>
> ---
>  t/t5315-pack-objects-compression.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
> index 8bacd96275..d0feab17b4 100755
> --- a/t/t5315-pack-objects-compression.sh
> +++ b/t/t5315-pack-objects-compression.sh
> @@ -10,7 +10,7 @@ test_expect_success setup '
>         # make sure it resulted in a loose object
>         ob=$(sed -e "s/\(..\).*/\1/" object-name) &&
>         ject=$(sed -e "s/..\(.*\)/\1/" object-name) &&
> -       test -f .git/objects/$ob/$ject
> +       test_path_is_file .git/objects/$ob/$ject
>  '
>

Code seems fine

>  while read expect config
> --
> 2.53.0
>
>
