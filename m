Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C35391E61
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319597; cv=pass; b=p/yFjRPCINGrWc9o5MvZHo+tgX0SHXm67vj+ls5I97vkx9Frtr7Z/DajYovxNXX1q8gDvmgY4utaJ5ahBJjocCat01pRTzRVkFLW3IEU8pP51P60p74Df43Wk2cZQ4vDwF1tAdoee287f90/5GslNStwFW/DbnbDjcfCsQVPFe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319597; c=relaxed/simple;
	bh=iK47JyloY1FHzTfz1vLRFn57D/C5xK8YF3xgCDhrBGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSTz7+fXVPiwKzEf3POfnpsjP1Gzv8FVQH9HBfrPFdgf1+A0RfkPWxBCLrkoZQoZqBSsaI7CtsfjWewWCwLNR7IkkBc8CWUA5TTs5yw/aJ/WSAO5oz7C3xjEMhW8FdTib95jPrrs8+C7oS2Gg3LPVBCRm4WwBGgOFerNDJToBo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6ZzJp9p; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6ZzJp9p"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-126ea4e9694so2401246c88.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 05:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773319596; cv=none;
        d=google.com; s=arc-20240605;
        b=emrHCdKKxLyCA7CRPlLp/lyJImB8zB8vyTrgsyDTkR9TZiPwcQIzYIHBT1/7x95Zbx
         +zzRx5us8rQ/JyV+lBUfJvcvM0eabbTB/VNHG+FassVboEV43LHyiXOUNGeRQP90kykd
         ghbDZmVNAv6l2IbM1x089DUv7kRidtoyws6xfOEz7Czjw4GwUPJuO+75GEfq/RgnIexT
         ZsbqzxAbPqo3JpgMZWoCaHhXzX1kXuSa1QD95LQF3C4AHGGj+SWdfslCggdFibaZF9m0
         IkOKECxDrUcLQ6dq/ZDYRd7UaiUNNqfa+0xY5Omj8sOMC7j6K+tWQlNcd90mdDpwEB+O
         vwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U1swvYhRDc6oMCuMbGw0JhbR4bur7F282SOT53ZXexA=;
        fh=GCEUApHpIhxEfCfJ7RbGtLoDV6uTTpHqLmIEC/rGufk=;
        b=TxLzuNc/FXsbCwLujWYJkAPZNo2ALYs5K20i4DTm5WtW4ZaWtRwHgx7FllAQougM32
         aEZJgO678mSJSznTkaslAQqpZQKvrTo308nE35afdqRM6rmqoH97ZJb94bXeyCKUa9Fg
         RYX8/PcvQ8gZr3L1pa5DMZ8daSTReB2tNnaRAnWwS8sbEBIpRkavOzMM8gwqjMTRtSGT
         NOQL2+jQUEYqLmOfnFBU7xNc8/S/PxHiLrX5K/8uBBcbi4ojb4nMUuyYYWDuNf4bXbPt
         zx67uwrXeL7Zs9zSAPH9COdn+y4OWqu47bm3VOo05RPWgbjd7f+3gsagj601PyuO0V6t
         /tGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773319596; x=1773924396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1swvYhRDc6oMCuMbGw0JhbR4bur7F282SOT53ZXexA=;
        b=h6ZzJp9pBNsmxIbljK82kqXbPfF3qW/QOzX/U1MdDsYMVpkXvAXWfkRb74R5Kp62Tj
         NqtiezrVeyKgwZT+aqfYuUtO39j2kZpvn80EU+GksTjCXiHjqhrqGLihqNOxHQnwSTlf
         LqIpj++V1UZJaYTuNtoMZCpkB76XOFakkX9HiC2nleFx6rWLGji+x7UStz2rZ3W2E1PE
         BwFeK3PxGDfQclqzCqQb2PDFhvvbLAy0qTU1fnoG0G0QKEOxmuqVZoAcAor5/tsR7tHo
         mSnPyRXjdmh3Ef7SGwOLYivCcn7Ucf7CQGC5qb5ZJVkwjCeLZIJCapgMKs6J1PegWHlR
         e1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319596; x=1773924396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U1swvYhRDc6oMCuMbGw0JhbR4bur7F282SOT53ZXexA=;
        b=wUvaumhS3XOd/GDql8WXE3+q8VGa9m+6dK9ycmuZsn54utRDAPv/WdQWRIjl6CUQAK
         r1aySWxb4mw/hPfEgKl0uiY2qC8cMX+ho/Hcal4ClYW5dC+vILB8g/uJQLwLpEZboxrO
         c0NjIQlh6LijNLn4oKXkOpXBGVx3sBmAk2VlILrB0xGzwCEiDbdVcfMibPvvPMCqy22K
         p0oS3ytbrO8SxJio4YBmb4Bw0LJZ6Cdha7ZCSFwb2+GACJYaRppzsX3PdC6Pw43PX6d1
         820HPDFb3JH0UV2wBtD/7CJ+EWfGLFB83rTkQ4sjAIuX9PgOF5qO2RwdSwFwWEje2fEt
         Wi8g==
X-Gm-Message-State: AOJu0YyUwV2GDKfO2zh47jjN0XPfMKbgtRBmO5JhBSGyefLO8axXlHh5
	uJaNL/aXIzF4e/16VM56u4cvAJiYAPQ6mvFv9cDhIX9C61/rLDTCi+gSNW+GPdlEUIfKd2BTADm
	FMpcoVI+0zk/ugXcU2waSoXwbXPOKFK4=
X-Gm-Gg: ATEYQzxEV2+juuBUIGCffjlUyWY/yxGN1xz+seAQDArlUZdN61LJBMEiu6n7KavftZE
	PJMct/ZA9jXtTWEIiUrgXnLAqsjFjOS3MoUtifSlo8kpzD/pvGwoO2HKTggSQqdEY7pAZs7LCYa
	KQ9TJxyKg7Eh15uMxywnmVNrzVKtlU9exbbrhAwQ6CJ77YKzd2xgY3XlfdqlKikmGRFygwg3nGo
	BXhMenSt0qD2MFUEK2QyOehw5a83Mgo3HHSndzcJFMwKicDRQNJYodHZ3VKeBrI23rT+qut2sSS
	gQXAtNPhvXNgL9UYYoCBH/KHvLvu2kBJpA3if3xnQ73A
X-Received: by 2002:a05:7022:e14:b0:128:d4be:7428 with SMTP id
 a92af1059eb24-128e77c2066mr3341651c88.19.1773319595501; Thu, 12 Mar 2026
 05:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773127785.git.belkid98@gmail.com> <9f9a2e8e-6db7-4105-ba2b-7e42bff2ad1a@gmail.com>
In-Reply-To: <9f9a2e8e-6db7-4105-ba2b-7e42bff2ad1a@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 12 Mar 2026 13:46:23 +0100
X-Gm-Features: AaiRm50i4hSSBi-tnFNotDZCBnz2HJdxgNa7DGDYJ6pdt2o1jugtWIl57K7O4uU
Message-ID: <CAD=f0L_HkyRNYk07Laq77gr8+JLaHeVxTwFN5eqC9-rLjgNRvA@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] repo_config_values: migrate more globals
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	gitster@pobox.com, christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuchen,

Thanks for taking a close look.

My intention here was mainly to avoid repeating `cfg->pack_compression_leve=
l`
multiple times in the function, so I introduced a local
`pack_compression_level` initialized from `cfg->pack_compression_level`.

But you are right to point out the interaction with the CLI option. The
--compression option currently writes to the local variable via
OPT_INTEGER, and the value is not propagated back to
`cfg->pack_compression_level`.

I took a second look at it and will change the option to write
directly into `cfg->pack_compression_level instead` in upcoming versions.

Thanks for pointing this out.

Best,
Olamide

On Thu, 12 Mar 2026 at 06:03, Tian Yuchen <a3205153416@gmail.com> wrote:
>
> Hi Olamide,
>
> On 3/10/26 20:06, Olamide Caleb Bello wrote:
> >       int status =3D Z_OK;
> >       int write_object =3D (flags & INDEX_WRITE_OBJECT);
> >       off_t offset =3D 0;
> > +     struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> >
> > -     git_deflate_init(&s, pack_compression_level);
> > +     git_deflate_init(&s, cfg->pack_compression_level);
> >
> >       hdrlen =3D encode_in_pack_object_header(obuf, sizeof(obuf), OBJ_B=
LOB, size);
> >       s.next_out =3D obuf + hdrlen;
>
> I didn't look closely at the other parts, but I have a small question
> about this section.
>
> pack_compression_level before this patch is a global variable:
>
>         int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
>
> and struct option  in cmd_pack_objects contains its pointer:
>
> struct option pack_objects_options[] =3D {
>         ...
>         OPT_INTEGER(0, "compression", &pack_compression_level, ...),
>         ...
> };
>
> The reason why functions such as do_compress, write_large_blob_data can
> work properly is beacuse they all read the same global variable, right?
>
>
> However, in this patch,
>
> > +     struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> > +     int pack_compression_level =3D cfg->pack_compression_level;
>
> Here, a local variable with the same name was created via value
> assignment (I also find the naming a bit odd).
>
> > @@ -383,8 +383,9 @@ static unsigned long do_compress(void **pptr, unsig=
ned long size)
> >       git_zstream stream;
> >       void *in, *out;
> >       unsigned long maxsize;
> > +     struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> >
> > -     git_deflate_init(&stream, pack_compression_level);
> > +     git_deflate_init(&stream, cfg->pack_compression_level);
> >       maxsize =3D git_deflate_bound(&stream, size);
>
> But then in the do_compress() function, the variable being read is still
> that pointer, cfg->pack_compression_level. The expected input wasn't
> *written back* to this pointer, right? If I understand correctly, after
> parsing CLI, the output is written to the local variable rather than the
> cfg. And that's why the naming is a bit confusing to me.
>
> struct option pack_objects_options[] =3D {
>         ...
>         OPT_INTEGER(0, "compression", &cfg->pack_compression_level, ...),
>         ...
> };
>
> I think change like this is needed. Of course, you'll need to
> double-check it. _(:3 =E3=80=8D=E2=88=A0 )_
>
> Regards,
>
> Yuchen
