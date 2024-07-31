Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC82C8FF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390098; cv=none; b=ts4ZIYKXYuz60rQu2Z+9WtMQWEgGCOU60Mi9SR88VcSYj5XFah831JCcn7rp5t3jLzYBy/UfqCu/RDm9PIJ9N6ajPuSuyQsvYRfl8mWWdNvxHkKm/PrY9KfYlawYJxdV2Ch0S8070XZMvK02HsxSttnUOD3kBmqIAIU1I5NPSoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390098; c=relaxed/simple;
	bh=uKp73rLGPJCqzgC/JR7yPXZRLR0Vm6vnZSK2GO6J190=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=UzNatJf06cQH4lRvlQyTYuUCgxAeDkm1oS9TyLo3XuJeU3qC5CpowHjfs+/FqKhVPrYVEbwZu0ZOQdhTQXJ4XI8wkVhgeox0KhtSKHKuqUW++yVuJ5iPUg11N865/JrrkNsCdbRijTJnqrN4Tw7y7flxMxU5e0GFtv6FyqoFcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glEXOOqs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glEXOOqs"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70eb73a9f14so3916175b3a.2
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 18:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722390096; x=1722994896; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX7EC5NttR5uOlRmKM3ZIC+zOBeb+9atK44D3xsz+TQ=;
        b=glEXOOqssf1OSLj/ybHLMxT8TEdgi5fEbLTTDXuoDPs64LzO1k+eULnLRp/EzDEU7m
         mhNrkyJ0MIDi/6hJsR2XEvB+Wa6oxwCcxU2JEllBpjXAm9U9JREB4FF4HDOS5VBUe/1s
         FzFTu3J89s5MM+3kipN6jqc8OWWKtsacRpeYwnY2idftbrTvs+ZQ+WOCF9To5oyTGX0s
         13/fpYcBCUX+kPvB8+uRaLzJNKPOhc2kt8efnB9/DkLYeT8pPI8PzN1sAbINLFm/ThWh
         RGjdcbS0sCNSRyQfMS7p7s9+wx8dMu7TyKPOOvKlbexezJT2mIY21tbyjA+sVK/FMjua
         qAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722390096; x=1722994896;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uX7EC5NttR5uOlRmKM3ZIC+zOBeb+9atK44D3xsz+TQ=;
        b=hypaEIFyNzz6Tqeb+NGUmDI1bqFZYDLgwl51Artg4KqiGCbU++Wy9r6LkVr91FafXi
         yvioZHVgCusD6maG0n2Q/ToUJxfXBPYC/pQx8g+/MB/YtKUWgVKK8ENybDmbppGGip69
         4PKWG1hsYShhpKN7vjpY7a5m8bIrfN7oq0UYdJFj6ZCGF7Cue9crO2hkDSKUlGnv5SZ0
         IuPsaoJfp44uz10p2HENblzkRe0UOMRI1yyzPc2+rsSvSpotOkFfedqRtR/yN+bngzls
         EO10NIi4ukbAuolz4m7hLiaWxGt+6qriBYcZ+ofwJJychEaL98KdcnKyxfoEfqdKCyt/
         9pYg==
X-Forwarded-Encrypted: i=1; AJvYcCWbVybXko3/4ocNk9g+ty/TvkOPB3zPCdmqpasYFleUYLwWTEQJKhFWe99auB3iQR2GgKWjODb5K6nf+cQMCgrqKY9U
X-Gm-Message-State: AOJu0YzaT0S8cMkhhujOovSAjSw1WA+SxIB0n5WFqpzN7l4WUAevd9yH
	BbCqmqhuLio3fYS1NkZph2mRplmPjnIs1LDklsm0hqHTMtM7NEpoChlRQcc/
X-Google-Smtp-Source: AGHT+IGcz9gs56KLA5FhrqJDayDZDnLFTuWUap1WqxoDniaOxrVSkJYfbJcGB+GtkvaTjKKiYZOXoA==
X-Received: by 2002:a05:6a00:859b:b0:706:750c:8dda with SMTP id d2e1a72fcca58-70ece9f71a9mr15655318b3a.6.1722390095999;
        Tue, 30 Jul 2024 18:41:35 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8128d0sm9019503b3a.118.2024.07.30.18.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 18:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Jul 2024 07:11:32 +0530
Message-Id: <D33CBWZJZSRS.1V3U16NM91BOA@gmail.com>
Subject: Re: [PATCH] t-example-decorate: remove test messages
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, "Git List"
 <git@vger.kernel.org>
References: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>
In-Reply-To: <5c838884-b606-465a-8f7e-ab760ddadef8@web.de>

Hi Ren=C3=A9,

Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> The test_msg() calls only repeat information already present in test
> descriptions and check definitions, which are shown automatically if
> the checks fail. Remove the redundant messages to simplify the tests
> and their output. Here it is with all of them failing before:
>
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:18
> # when adding a brand-new object, NULL should be returned
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:21
> # when adding a brand-new object, NULL should be returned
> not ok 1 - Add 2 objects, one with a non-NULL decoration and one with a
> NULL decoration.
> # check "ret =3D=3D &vars->decoration_a" failed at
> t/unit-tests/t-example-decorate.c:29
> # when readding an already existing object, existing decoration should
> be returned
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:32
> # when readding an already existing object, existing decoration should
> be returned
> not ok 2 - When re-adding an already existing object, the old decoration
> is returned.
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:40
> # lookup should return added declaration
> # check "ret =3D=3D &vars->decoration_b" failed at
> t/unit-tests/t-example-decorate.c:43
> # lookup should return added declaration
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:46
> # lookup for unknown object should return NULL
> not ok 3 - Lookup returns the added declarations, or NULL if the object
> was never added.
> # check "objects_noticed =3D=3D 2" failed at
> t/unit-tests/t-example-decorate.c:58
> # left: 1
> # right: 2
> # should have 2 objects
> not ok 4 - The user can also loop through all entries.
> 1..4
>
> ... and here with the patch applied:
>
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:18
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:20
> not ok 1 - Add 2 objects, one with a non-NULL decoration and one with a
> NULL decoration.
> # check "ret =3D=3D &vars->decoration_a" failed at
> t/unit-tests/t-example-decorate.c:27
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:29
> not ok 2 - When re-adding an already existing object, the old decoration
> is returned.
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:36
> # check "ret =3D=3D &vars->decoration_b" failed at
> t/unit-tests/t-example-decorate.c:38
> # check "ret =3D=3D NULL" failed at t/unit-tests/t-example-decorate.c:40
> not ok 3 - Lookup returns the added declarations, or NULL if the object
> was never added.
> # check "objects_noticed =3D=3D 2" failed at
> t/unit-tests/t-example-decorate.c:51
> # left: 1
> # right: 2
> not ok 4 - The user can also loop through all entries.
> 1..4
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> t/unit-tests/t-example-decorate.c | 24 ++++++++----------------
> 1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/t/unit-tests/t-example-decorate.c
> b/t/unit-tests/t-example-decorate.c
> index a4a75db735..8bf0709c41 100644
> --- a/t/unit-tests/t-example-decorate.c
> +++ b/t/unit-tests/t-example-decorate.c
> @@ -15,36 +15,29 @@ static void t_add(struct test_vars *vars)
> {
> void *ret =3D add_decoration(&vars->n, vars->one, &vars->decoration_a);
>
> - if (!check(ret =3D=3D NULL))
> - test_msg("when adding a brand-new object, NULL should be returned");
> + check(ret =3D=3D NULL);
> ret =3D add_decoration(&vars->n, vars->two, NULL);
> - if (!check(ret =3D=3D NULL))
> - test_msg("when adding a brand-new object, NULL should be returned");
> + check(ret =3D=3D NULL);

If we want to further simplify, I don't see any need for having 'ret'
either and to just call the methods in check():

    check(add_decoration(&vars->n, vars->two, NULL), =3D=3D, NULL);

which would also provide more context in the stdout rather than printing
'check(ret =3D=3D NULL)'. But, I believe you would have already considered
that but kept 'ret' in favor of code readability, so I am also fine with
it. Thanks for patch.

