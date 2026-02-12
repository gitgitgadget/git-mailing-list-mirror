Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33A7246BA7
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890890; cv=pass; b=Rg0lgzoWbLc1CU6cRNYQWI3dbXtInqrEyJijzScZOC5sAK+Wgcv1f5ML3tVXx27kGZ8u8OJ3udY2LsFrbrRanJBqo4uushmA1owGmCwufQ9/L8frK9oQBddauFMcsOjsLa03zMm4yiqd2ZPwKBpsBH+oWCTb6bKqVXQsym4WPB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890890; c=relaxed/simple;
	bh=8ROc9pTJ6wG2k/L2NvtuIBgKsqVMcVOMP9ZaXGnLaLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFljtqLoBfSuLu1LzZV4WYseF6MYeImKAzsaOSkBGnI2GzE1V3zOf9QTcGYD3EDBJ1ue7oBBQuIBpPxZHIhsHKAU70cqaTNQqu2keX0HbQ3HIMWfCAyFcqINE/xaHXMpfA6T0mfqrz8VLv0TLR6flWVNgE7jMGuz7dkiYuFoxPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb3N6Da7; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb3N6Da7"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270adc5121so3661568c88.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:08:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890888; cv=none;
        d=google.com; s=arc-20240605;
        b=UNWMDtfhvVoFnSg+ffSQQR9e4efDNWRvfqB3m6v3OaLkzUoUygaRVj5l7RUrTYohBH
         VSAQEK0JmBB9LXlG3xutbrr0esclfKWSvY63ERGyij2bsJfbcAVGtPK134TLbSbXjGno
         laqpxw8kIFClemyt6iY84ubX5mdN7gbm+IoexnZkxULrsW3jpRrYNEvLbYfWPl/NkKke
         Dxf+4kTD7v5qkPFDw5RbyEYqk/Ho/8rh59Yefr1RPcAW+cHpzsIDn4YpA7+O39EXqllP
         mPzD0o5XdmWc6LwSucNQNWyk8gpJK7K5lLnQv2M+P3iu48etv7LCiKsigYJjA231oJBH
         18Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fpyVabdfZYC95fZrpjqas51GXto+j9BcXosokuaaOaw=;
        fh=sFUv2Yk7W28jKwKk93FUOHba1Fh+s4Z1esNWzfg8X+w=;
        b=eg656uI/ATWwsX8rOEUatxzk9a8ut2WK95jCKWNeeMAYUy3/+bWLo5RARJmZZmDopD
         fgUPONchitc/NIirBKIcvgxxgL/KsR7FH77D6aCSrfmbEl8aammVMYw9ZSWqxoiOlBQ2
         C2hoWdUlq9OXHAGwH1oEe+VEZVdrcF/JnOUuv1KW+b+mzfbUkwYGvno3mhsLDR+fyDjv
         SjeKvjY7slQUmSzwISJzCwSW7msq+3kn2bSZhFo4l+ohPC2l0szandvXxF9nVPtiYluP
         qyqtKEq/5IfSy0MXkU3KPp/Wl40YxFBmCbzOYxaAlp+TEnoJWq4WcvuCmRWvkF1muiii
         9+nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890888; x=1771495688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpyVabdfZYC95fZrpjqas51GXto+j9BcXosokuaaOaw=;
        b=lb3N6Da7Li5fLQCavTztUepH3TrEb4iz47G5a4Co30PHPRkL5ICRDCnv80zmrLwWXG
         XPkiI9HSihg1gbYYkcriQ8lgBaNojDob4pFBETTPLaiiNTN3HS7caZS7TQt1eIuNZHNR
         f/pXHLF87Ngr9JjbysXOSNJv4Af1xpuz+WRhzmnIXJpOHXQMGN/C8hCBtctDn4YYseVH
         0DjJPqk5X+9fNrdUkhY/ZCMJ9Ao7oxgHC+oZZ6xTL1znZbjmGZGSYsd/MWvR8oo4YPvC
         epxPEeTC2Z9233VhGDX/En+Gu2QVhr5ByVVSFn6k8WP8+rKFJQJaUMBwmR/Oe+xhA1X1
         Wkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890888; x=1771495688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpyVabdfZYC95fZrpjqas51GXto+j9BcXosokuaaOaw=;
        b=qMp8dkJjWZQLY811sdtI+olnUr0HweuaBrgN/UzuH9CZWfW8+prQCVmxFuBrNGVj4U
         goJlnliN8/Y0rhYKBnYHRblflx1AbBtLFhd6rG9rMIw4V1mhbAthi1ftT4WnRPxJf9c1
         qtrzwrx1h5ZE1ulPBDtuexpT0Flw8vncqBGLmZgrE2hDzxQqlyF48yMcZWt3953/Kh+d
         Oxnfo/67P0twFZun71vQXhm65Hw7d4IBE8aXXcCmQ7OGBjTpTPO5NmhFmS0/VNLm8CUA
         4MYSIgvU4xkyGOHS2RZFB+3we5NY3S0lia8dOK7TVBOAAh/t8BKsDzQBR3QBFwNMrW+h
         pBig==
X-Gm-Message-State: AOJu0Yw4u1BJ2weGIso1r4z3A26hRk86ydQxWGz1yc6HL7baLtDBGweK
	lwTJPYMBcqZvWIjsdk4zNsftGSbRzCqrHjaDN5wH+g1/LxU/eInTxpc+QTc08oKCViCWnMjhYOD
	OgrKXeY9m0du17aGz7aWRczkLxynOlMI=
X-Gm-Gg: AZuq6aJgG1UPjYTFMpbqCj6uez+FSzAzLYKMD+BunQQPpO08UO7L0q2Vpyyae0o7nnt
	jzgWKRClMtSsHLqLN1ezMGHrk5+ltbaSWOeJ6sempANW8Vccb3K+7R+sS29X2H/vwaFyBiss2Du
	ME54Q9BJavTqyGd9jLZfDCSKSA+coWmZFOQ0p1mE0CXOiI2Q5hqVzkP8b8oOVr+3zFgVuCwU96g
	o1AaHRkWP2fxx+J8wIr2BcCRKCzQWBfSvE8ekEX/7Le1Xxc1RnURKikQz64ytGBCbFYpxblAbu3
	0X77RiHomdqK/lJeuRFZuuF4xPQdHM95eip77E7msYSIqzMV4YRli+NydK2NYHphfoTW
X-Received: by 2002:a05:7022:30d:b0:119:e56b:989d with SMTP id
 a92af1059eb24-127304ee918mr653823c88.4.1770890888017; Thu, 12 Feb 2026
 02:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com> <20260204110818.2919273-9-christian.couder@gmail.com>
 <aYxsmsQlbm4t2zLY@pks.im>
In-Reply-To: <aYxsmsQlbm4t2zLY@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Feb 2026 11:07:56 +0100
X-Gm-Features: AZwV_QgkgVobH2MRS0tYNuYaRTLDLsdmhArvLxVqD8xPZYJCFodNqmG2ago3H1k
Message-ID: <CAP8UFD3jw0Lz_58ejfwyeE=VOhrZYq67495Gx+7fRKgzakDkkw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] fetch-pack: wire up and enable auto filter logic
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <avila.jn@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 12:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Wed, Feb 04, 2026 at 12:08:13PM +0100, Christian Couder wrote:
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 40316c9a34..5e9a969e31 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1661,6 +1662,33 @@ static struct ref *do_fetch_pack_v2(struct fetch=
_pack_args *args,
> >       struct string_list packfile_uris =3D STRING_LIST_INIT_DUP;
> >       int i;
> >       struct strvec index_pack_args =3D STRVEC_INIT;
> > +     const char *promisor_remote_config;
> > +
> > +     if (server_feature_v2("promisor-remote", &promisor_remote_config)=
) {
> > +             char *remote_name =3D promisor_remote_reply(promisor_remo=
te_config);
> > +             free(remote_name);
> > +     }
>
> Huh. Do we only call this function because it calls
> `filter_promisor_remote()`? We don't seem to care about anything else
> and do some more work to assemble the `remote_name` string that
> ultimately ends up being pointless.
>
> Maybe we should instead expose that function?

Yeah, we could expose that function, but then we would discard the
`struct strvec` that the function requires and populates, so the "huh"
factor might in some way be even bigger.

I think it would be better to change the signature of
promisor_remote_reply() to:

void promisor_remote_reply(const char *info, char **accepted)

This way we could pass NULL as the second argument and the function
would not assemble a string in that case.

> > +     if (args->filter_options.choice =3D=3D LOFC_AUTO) {
> > +             struct strbuf errbuf =3D STRBUF_INIT;
> > +             char *constructed_filter =3D promisor_remote_construct_fi=
lter(r);
> > +
> > +             list_objects_filter_release(&args->filter_options);
> > +             /* The result of resolving an 'auto' filter must not be '=
auto' */
> > +             args->filter_options.allow_auto_filter =3D 0;
>
> We didn't resolve though, we only released it. So the commend doesn't
> seem accurate to me anymore.

What the comment wanted to say is that when we are going to resolve an
auto filter, in gently_parse_list_objects_filter() below, the result
must not be 'auto', so we disallow 'auto'.

So maybe something like /* Disallow 'auto' as a result of the
resolution of this 'auto' filter below */ ?

> > +             if (constructed_filter)
> > +                     gently_parse_list_objects_filter(&args->filter_op=
tions,
> > +                                                      constructed_filt=
er,
> > +                                                      &errbuf);
> > +
> > +             if (errbuf.len > 0)
> > +                     die(_("couldn't resolve 'auto' filter '%s': %s"),
> > +                         constructed_filter, errbuf.buf);
>
> I think `gently_parse_list_objects_filter()` already returns non-zero in
> all failure cases, so shouldn't we rather:
>
>         if (constructed_filter &&
>             gently_parse_list_objects_filter(&args->filter_options,
>                                              constructed_filter,
>                                              &errbuf);
>                 die(_("couldn't resolve 'auto' filter '%s': %s"),
>                     constructed_filter, errbuf.buf);

Yeah, it might be easier to understand. I will use your suggestion.

Thanks.
