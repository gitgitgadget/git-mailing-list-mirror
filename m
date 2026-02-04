Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED753ACEED
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203183; cv=pass; b=aBAPfDftMLs5s74E1UWkmN8oRrCe4MD6aZB0or4WW8MJa/u7acqh+1kMz4Wemf/3XmfNDduP0ZneupG1nsZ9aOIbLiZ36SKbOMg0u+VWQdsja5SNcHaNHupxRf7i/y0He3usnGZkLwJ0qVeluvYpR+8UWekso5o7Gr+2eAbZTws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203183; c=relaxed/simple;
	bh=QVSu9HKEpxT8PtpWRHWIWMlLW1Gl0siDkU2NmfQPNAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0OPi1c3/W3HI7cWc8ZLRjmOzQG6tGQmzWfONbbubGxTTXAYh1/VKKZnQ4Pn+hSCAeakqp+yJeFrxdow4r2wIKVVcsHStIVhR4tlSohwvwe59Mg5lF68Zp91nmUUYqbBkbtoQ+Ev151JI7m8FiW8X+76IOaUY0MGoSGS5AOR7lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7psdLEc; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7psdLEc"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1248d27f2b9so8254690c88.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:06:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770203182; cv=none;
        d=google.com; s=arc-20240605;
        b=Qa7yVLsOhDIdhj+6vwqe2CxNSRhfvKD8k7/X8eSYab1rYAS/c50+NaoIW9HwuEgDkW
         DpRu76YvmwzpmTdAHT+Qhoms+CEy5+Dl/oqmfZmZDIlrXRIttanHYBKn9HVjsNuLY706
         llVMwQLYzPkRjQwuVwlmAs/NWatTLrxnihM/mBxwXh/6J/9mivd5bDy3mZByDfPF/axI
         9vnFgQC8uyaODjkWqvQg4/8Aod7sZNCnFlIeF9B4EqyRtDP+Fwv7+B4APnLzaFxgIuQJ
         84d/R5yt5aS4FEDKIOmESlI34tZj48+0NVXhipipMUkE51mfW/uiAYipD1Y0Rk4KJyI5
         jzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXCFcQEHglndombhqhyui6I3qYpP5srlcLz9sqsQH2U=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=Vq6PHMXFbnKzEr4wZTOo04kP8X14+vQ7brv/VcjqkgYB9LHIsPDwEDpke/n/z8jJeQ
         vz5cfofvA8eb1+sy2TPNYji83pgfNoL1wG4wqY8015L24QDXCX/nTHhR93/C5rxcQBvp
         wWB1EwQPL9/WkkNCxqQDTwpfo+Odz34xQO0L2+bYl7gwXhjbnRk80dZhwkLGAAiRrMzu
         CYdI/KaWUIlyXE6ahBXq3qy+bySLq53KdzrLDEEL5YRylEzG2p+5UqFNBGc601yhXJrj
         uSnNUx19b/Mke1eIiBaxDKKf6Lr71cdQQwO7loV5wLwOOWrKo3FEfYCkCt0aHMSh+aWk
         TByw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203182; x=1770807982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXCFcQEHglndombhqhyui6I3qYpP5srlcLz9sqsQH2U=;
        b=U7psdLEcquvCpsHk15E6trlmlgu3zyJC62b5z/GZ16uk/9q+j6xrtlRvpJ/U59MvR0
         tBM0gJ2OL3SvIl6r+b9Ps6+Wnrcxj2uN7pmXQA0rbD2SyRYwFwylE9NEzbjs3AyAGQ5I
         omJZRTl0kSm57IUpLz0Joz+Er4ibWAJ9mN2ZctI0ZKxU2inpt+C1A/azBNn2I1J+BR0n
         Xg5cGCbhVEP3g6JJJgR+uONHN+l75f1TQ+E85pcgE5JsStbQclK6SY6h0ZbtzF5o4A+l
         0iZx93av9gMA8qNfpMC3QsnCC4G/2rLbl0CPjc6KO9dPuDOb3yC37qdRe9Ay2BD34YFD
         NYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203182; x=1770807982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXCFcQEHglndombhqhyui6I3qYpP5srlcLz9sqsQH2U=;
        b=E9eAONNB4kY26XIuEZv0ZaQcoDnH+EpSmtbe1aDT2xAZdVjQ0BkPRcNJnlrfMoinH+
         YPesGvpXchOW/S5q3UAle4sM0Czf9bFIHOumcQ+j345D+HPzkTaXsYkMuh2rQsPdHjZn
         3jOyyUs+LXregWMxQuvWbAXkC7LvHSyvlIKVIMl2TAYVaeij1LRV88f5CXCWhdOMxMul
         GUEwS2IWiH6BeETYUvOBntKkcLcgkR4AnkiKV6nkq4sJ3AGiFuL3gvv5eAZUe3wmKjvE
         NzuuDZRiweB8b8wMOXRi6PN1Dsdtz39N1br+CLFQ+BCUoAdMp5n3R6PdkxudJ2M2EN/A
         YDgQ==
X-Gm-Message-State: AOJu0Yxa+LwWcN8rrfXmpmznQAgjOAOJZGsPhTFe7mpNTtnlTOWatd1x
	fumQD/9Wt2i7MoMbYBjW2rWvUmRbyHkbEobt+VUyOOfqgMsQIB+aZk0aJccCLA5j27sE1xKzJ4t
	BpZ0rhFg/a1bgZFeLBLJQRWH9dNfxgoQ=
X-Gm-Gg: AZuq6aKyoh6asEf3CINoQ9l9NBclRnKC0vp4yUKqeyHbmixTpbKLplakt/5u+YC000b
	oAzRLWYMPMnG76aaDvVf3VezLCwew3LAeF7Q10ps59N76MXrDYX8fIcm90546l4g28FLtq4d0yJ
	576IFIqPeJg8tY4cwvCznFE5PRArDz0JM4I7C6F1S/z78NZAfTAawPWTWqsOnrmZgSxQfyHsN6x
	8bE+/rSiMtq2wACcgwwOMn25a2Yt7ZEh4qSt1PWn/TfilNDg5NYSAbLU+4bCO2h0MP54KqsNJiO
	CNiAy1BQGaeHAM4GshldCRC1C83MuV9LPL3/GVmDQtPnBbfjz/DrvZIz
X-Received: by 2002:a05:7022:ef0b:b0:123:3488:89a3 with SMTP id
 a92af1059eb24-126f47c31cdmr1128040c88.24.1770203182199; Wed, 04 Feb 2026
 03:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-10-christian.couder@gmail.com> <aV4v--FYaHCLLrPz@pks.im>
In-Reply-To: <aV4v--FYaHCLLrPz@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Feb 2026 12:06:10 +0100
X-Gm-Features: AZwV_QgvDWGbEqoi1KRmDBNjw2ijMyqzqAvkPkn0x4Lv2W19uklG3UyXmsazPSc
Message-ID: <CAP8UFD0kLyLCSXYA1Zw8BvBDTxYmTZeo0L44dz7_HC6uY683sg@mail.gmail.com>
Subject: Re: [PATCH 9/9] fetch-pack: wire up and enable auto filter logic
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:05=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 23, 2025 at 12:11:13PM +0100, Christian Couder wrote:
> > diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-opt=
ions.adoc
> > index 70a9818331..f7432d4b29 100644
> > --- a/Documentation/fetch-options.adoc
> > +++ b/Documentation/fetch-options.adoc
> > @@ -92,11 +92,20 @@ precedence over the `fetch.output` config option.
> >       Use the partial clone feature and request that the server sends
> >       a subset of reachable objects according to a given object filter.
> >       When using `--filter`, the supplied _<filter-spec>_ is used for
> > -     the partial fetch. For example, `--filter=3Dblob:none` will filte=
r
> > -     out all blobs (file contents) until needed by Git. Also,
> > -     `--filter=3Dblob:limit=3D<size>` will filter out all blobs of siz=
e
> > -     at least _<size>_. For more details on filter specifications, see
> > -     the `--filter` option in linkgit:git-rev-list[1].
> > +     the partial fetch.
> > ++
> > +If `--filter=3Dauto` is used, the filter specification is determined
> > +automatically by combining the filter specifications advertised by
> > +the server for the promisor remotes that the client accepts (see
> > +linkgit:gitprotocol-v2[5] and the `promisor.acceptFromServer`
> > +configuration option in linkgit:git-config[1]).
>
> Okay, so if "promisor.acceptFromServer" enables a subset of advertised
> promisors we will automatically use their advertised filters. But what
> about the case where we already have a set of local promisors with their
> own filters, would those also honored by "--filter=3Dauto"?

No, they wouldn't be honored. 'auto' means that the client fully
accepts the filters advertised by the server. Maybe we could add a new
mode for using the locally configured filter by default and only using
the advertised filter if there is no locally configured filter for the
remote, but we can do that later.

> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 40316c9a34..12ccea0dab 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1661,6 +1662,25 @@ static struct ref *do_fetch_pack_v2(struct fetch=
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
> > +
> > +     if (args->filter_options.choice =3D=3D LOFC_AUTO) {
> > +             struct strbuf errbuf =3D STRBUF_INIT;
> > +             char *constructed_filter =3D promisor_remote_construct_fi=
lter(r);
> > +
> > +             list_objects_filter_resolve_auto(&args->filter_options,
> > +                                              constructed_filter, &err=
buf);
> > +             if (errbuf.len > 0)
> > +                     die(_("couldn't resolve 'auto' filter: %s"), errb=
uf.buf);
>
> Now that I see it being used I think that the calling convention of this
> function is a bit weird. I would've expected the function to return an
> error code that the caller can consult instead of having to check for
> `errbuf.len`.

Right, anyway I have removed that `list_objects_filter_resolve_auto()`
function altogether by removing the patch that introduced it in v2.

Thanks!
