Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6174C8FED
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026484; cv=pass; b=daR3dL3YxMrdYZezcVC9AwuYY85ptQm7/+GXNkArqgswMXwPL+JGfeGUpuVVUvmDaNgRwmSqiIeeZz0L4bkJWjTcHVJSZwi/xiPmnHFiPGR+eMM1QDeCGHw1q4F+N3T+GU6HNyKOaUNXHg5RyejP+64JJYhE02+J5I/tXPRL/9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026484; c=relaxed/simple;
	bh=pwgY+CTRi6nYp78tYF1AUbVq2KsTKKAmePL1OH/rxA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fd0cCKRm9Z6jBA5eXV905iOddqFOAklzK0xZlmkz5/WRQqtNTSTnkcCVcyUVuiRMv9MVl4SwUfXbhRjw+i+G3+/w2B+BrL5iCX4DwWARy2LiehYyRLgZDIz/VUfZdsfcGMbhiz+sj+/xybuogjxiZvoHcQFzKGQpmU1Y8NIbRQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+vU7xyT; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+vU7xyT"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66061993294so6132795d50.3
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 10:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781026481; cv=none;
        d=google.com; s=arc-20240605;
        b=gB6Ot0UX/bb68gEh4rtbdjpVLr8ki31kOtHi0TquBk4vTfEopol+fbzZXfgF5IgAEH
         UA/hSfXn+dkcGQ8Gk/DRQy7oMMT2BtUhL44FilakAiBDNDO4A9g5Wg3B+Smm8CoqQ0Bw
         EDqHQtgQ74uhNEFacHzKVFNNGsgJ/5saM1L1l2jvbPtVLrjOEDQWbZReAPjcCzMcTi1X
         fICXQtMAkMLDMoA/Qc4VA4Ych0LmsAXxu9ZHGaa0GWVYxMTjTghmV6svhajoxMuQ1t0m
         hsr7oAuDKdKV9mRcCK4+5/ttNH2hXPpe346nqnRDNQjfoNpQUk5tqz8KZXAJj0pC7Sw+
         T6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VC+aStyLzS8qekwcslhyXfmf0BgQAr1weYRwj18UCRo=;
        fh=iI49RrPwIQ8q1NQ+5MlGCJDDkCZRxLULMWk5W/UY3SM=;
        b=ciieCHeHFm3rdn35OmO7pDBCFd3i7TK7VrCNS9e+8c2Vj4xAZ37d08al/MoXGe2Vt9
         8wF7Qke28q6gC6F5juFZwxScqD9zgX/izYOuZ/5Y5PW2ZCR7RZMP9AneN+jCTCvSZ6aQ
         RDk1s/9jLKFXL/tCvOuzkZ1s30jrC7b9NbFfOMR/v2DPgqjt71JIBZ2VAS0hym4BX4Jr
         4sX5zYzT4+jUHm3hcEWSxQv0yT9vw4wSXY35YHcmyLKy/WbnYjMO2WKa2T9gEZP4vwNQ
         dpYkHpHYIxWWAKPvNJZbVbm+j7wfS7tUf/qf5/XNQFz827tELGSRRT+z7lnfHhtCMno+
         2Muw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781026481; x=1781631281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC+aStyLzS8qekwcslhyXfmf0BgQAr1weYRwj18UCRo=;
        b=p+vU7xyTEssQXTqP0O8AXQaU0bGn2pPObLvz2gr1iocqMDLegt7HysiCo1XwudcJSg
         7Wh498pNa6yei/WiAVYPlAf7qd7P3J6ideIVj8wS/dmuIHUNTJlOLHzFuNd36s0kL8+H
         NBKqKAfc4QGM84UjmmXB4h930bjNf7SQE60i+gz06nIvDBR2NbGcs4MG2wWEyg/CdW/p
         EshW1rQxYu0bk1TWX/QCMxvNrVlUVrxEcy+Ybhy2G34britbu/3yWAzeZ/NjZ8a4UQ+u
         eBdQIXs54MkbXuzmPkL7M6tyrdgxLfsOx6MJLmMzcwBns00RlF+YTOvaYh38MpmSsLwJ
         BPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781026481; x=1781631281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VC+aStyLzS8qekwcslhyXfmf0BgQAr1weYRwj18UCRo=;
        b=DkQ8/KPe+lWQ0ctv0TLT+c2uYTdRzelwidb3O75Vw+TwK1BH9Cp20Uv4KHxG1CPBTx
         mIMf/wEWBaTN+ixPnOuxDQkkE15UElGFbFWa4Ufl35MFx7xvNzeAtrCD9kFvZHHbsLeO
         vYMZ7cgu2JdVzqu9hDrMuIC4bmRIkHHpLIq/16bcEwUjGNjFRoma+T+V2vk1JRcAH5aZ
         Vlg5vHIAhNQ/Ahpimbo6z5vyx4MvkrIetnnGfrwESQJHr1IM/ZtIGkchfWytFCotm+kx
         c7LlBVGdmgetpJdMXyI/BJ41gUCx4PIhqJ7aD/EXt7WTlkB4ffc+WaQiQ3v+sbFLVz/b
         jhlg==
X-Forwarded-Encrypted: i=1; AFNElJ+g7Rj6cS40EVb6HgPIk3F0hbb1ka2OjOGTZTKoi1AxHGp61DeqtkHgggQ0L9XYHpHL8zU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4K+ImhiUHa2uiGuu79gkgpPH9Pe0da7hxe21dIZr4hig5xgkc
	5bjn0wwP2NA8Hl/bB/xapW3yaozZ84ZQjIQwRzhEgngWHzAJDW3+xqVyuGBW6N+7UTdOapcgCi2
	pwJhcv1NTrUsRHbPH9yT9oBC2I+2Fd6g=
X-Gm-Gg: Acq92OG2qhnF7X9o6bCXwyXm1NJ3tOiyzX14IqNzRczKKU+DitnVHk2aVKQ0Jv0TYLG
	4Vfh2dj0eSHsjvxlGu9Uwt/gT7XegaAxnfoLoT/lJ3kl2K2XJFpgnrw+beAug+bGpT5J3QJio7r
	HQ3lz+mwN84zddaB+etGZg9oqwhQB7hY99m6QXqsWXV8N6m4WaKj7QQc+K1mc4fhu6QHA/HDLI3
	m1f7+L14d4QLCVq8hkoM/uTQIVh1aOEZgxvS7iFiWnjWWHQJBmH72/6773v3d4w7UWN6s1eTO9q
	jJ3coY3O2jRKGD77iqpmWOt0Hi2qCZxCIDaenZsSntvSyBMzZnl4IdzLgsbhF0t1d4NNKV97MJ/
	vbrl2iTLEw2aE2CrRv/WjUeKl00KtYZAVtyFTE+0ftutyToXkAB5AuASHJk9Oh5dKrc1YVDX6Ri
	cG0krEG3zFWOlh
X-Received: by 2002:a53:d006:0:b0:65c:25e7:bffc with SMTP id
 956f58d0204a3-66106dcf67fmr17906966d50.7.1781026481218; Tue, 09 Jun 2026
 10:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260608-ps-eric-work-rebase-v12-12-5338b766e658@gmail.com> <CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com>
In-Reply-To: <CA+J6zkQ22en2HgH03EedKOfC+jLcHH2UbwpH0h_bDEAHR6B2pg@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 19:34:29 +0200
X-Gm-Features: AVVi8CfIzaJLHgWmdtCIBA1wZ6YlcPwzHViELLFzMjieK_XrbBs4YXu0qT8Fb_E
Message-ID: <CAN5EUNQHSd=0z26iG0gk24TEtgg1n8CC+H9bkqRACyErNgLxEA@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 12/12] cat-file: make remote-object-info
 allow-list dynamic
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 9 jun 2026 a las 17:32, Chandra Pratap
(<chandrapratap3519@gmail.com>) escribi=C3=B3:
>
> On Mon, 8 Jun 2026 at 15:45, Pablo Sabater <pabloosabaterr@gmail.com> wro=
te:
> >
> > The static allow-list in expand_atom() is hardcoded to only allow
> > "objectname" and "objectsize" for remote queries. This works because
> > up to this point all servers will either support object-info with name
> > and size or they do not support them at all, but we cannot expect that
> > in a future different servers with different git versions to have the
> > same object-info capabilities. Therefore, the allow_list needs to be
> > dynamic depending on what does the server advertise.
> >
> > The client will now:
> >
> > 1. Request the protocol option that the placeholder refers to (i.e.
> >    "size" when "%(objectsize)").
> >
> > 2. Filters the request in fetch_object_info() dropping any option that
> >    the server does not advertise.
> >
> > 3. After the fetching, the options that haven't been dropped are the on=
es
> >    fetched and supported by the server, these supported options are
> >    mapped and remote_allowed_atoms is populated with the placeholders.
> >
> > 4. expand_atom() checks remote_allowed_atoms with the same behaviour as
> >    the static allow_list had.
> >
> > Move object_info_options out of get_remote_info so the caller which has
> > data can select what options will be requested instead of requesting
> > always size.
> > Move batch_object_write() out so there will always be an output even if
> > all the placeholders are not supported by the server (returns an empty
> > line).
> >
> > Include "type" in the object_info_options so once the server supports
> > it, the clients know already how to request it.
> >
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  builtin/cat-file.c  | 85 ++++++++++++++++++++++++++++++++-------------=
--------
> >  fetch-object-info.c |  6 ++++
> >  2 files changed, 58 insertions(+), 33 deletions(-)
> >
[snip]
> > diff --git a/fetch-object-info.c b/fetch-object-info.c
> > index 51a898430d..425929a269 100644
> > --- a/fetch-object-info.c
> > +++ b/fetch-object-info.c
> > @@ -39,6 +39,12 @@ int fetch_object_info(const enum protocol_version ve=
rsion, struct object_info_ar
> >         case protocol_v2:
> >                 if (!server_supports_v2("object-info"))
> >                         die(_("object-info capability is not enabled on=
 the server"));
> > +
> > +               for (int i =3D args->object_info_options->nr - 1; i >=
=3D 0; i--)
>
> Isn't args->object_info_options->nr of type size_t? We should probably
> do something
> like:
>
> for (size_t i =3D 0; i < args->args->object_info_options->nr; i++)
>
> instead.

Hi!

void unsorted_string_list_delete_item(struct string_list *list, int i,
int free_util)
{
        if (list->strdup_strings)
                free(list->items[i].string);
        if (free_util)
                free(list->items[i].util);
        list->items[i] =3D list->items[list->nr-1];
        list->nr--;
}


I made it backwards because of "list->items[i] =3D list->items[list->nr
- 1];" If we made it from 0..nr and we delete the first element, for
the next iteration, the last element is at [0] but we are on [1] and
that swapped element never gets evaluated.

About size_t, yes, it is size_t but because we go backwards 0 - 1
would fail, also unsorted_string_list_delete_item() signature has "int
i". The options that can be on that list will be a small number so
there should be no problem, should I cast it explicitly?

>
> > +                       if (!server_supports_feature("object-info",
> > +                                                    args->object_info_=
options->items[i].string, 0))
> > +                               unsorted_string_list_delete_item(args->=
object_info_options, i, 0);
> > +
> >                 send_object_info_request(fd_out, args);
> >                 break;
> >         case protocol_v1:
> >
> > --
> > 2.54.0
>
> Other than these, the patch series LGTM for now.
>
> Thanks,
> Chandra.

Thanks,

Pablo.
