Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773942C028F
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302922; cv=pass; b=kO2DBX9NsHoIsiENpFq0VhGkUnLDIurJv3x9VrlIWMjy9+qI92EQt/6HaPPwOnbSmjvAyvCBSMA9gZM+BHK4TFw8iEM8C16opvP4JdDx3BrC7yoUSDpF3OmvWSz/ahs8gZ3JLYud43OsBjnJOpHx3wrRueXsgNRbnLMfM6nZvtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302922; c=relaxed/simple;
	bh=/o5LgVGR9PBz/EZTsKPH6WMm36LZ90S/Oh9u24iiL4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3YCLykH5v+kKPEceX4jJ0YcbTnhVcj1mxM03A9KgjeMk77aI5FAw04rop0iwZmeB5caM2AUunJFAbOILOGKT7bjehyUiBsPcBor9Udo7jWU2sd0B3sONw9rXyzngLA6hvcdpkr1c5gjdbMRFKz+viKZMX8+m8FULcGTYWFeRCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhVkc+eq; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhVkc+eq"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7fd5346b5e2so18623647b3.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 05:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782302920; cv=none;
        d=google.com; s=arc-20260327;
        b=QdbatlBYWxo3mPmFhDO4m2juXaK1aK19bQLDR6Ff36P3zKtBNRgUB2ryrrK4PBtVwY
         +WUDSiHHFfGln/Typ/C5z7fqvooan+w1SmChANFGTmhjAbFUSPCwbR3zpZoo6dblQSti
         maZgKGGR9cp8esWNU3xtaJqTZQUJwe00a6H+jjL+CbxLI2to/worHmvQVIi/UAryVBZa
         PlzPxf6k5c7UVLHFyZNzOR75TvUuElzuCBabixlI79olYzG9OwdfU4gblZTN0b9xhwJn
         /DG+8l6Fb9U2WVybLGnbnD08MbBIMB+7VKWgl4XpCxTiL8EneS4Ndkip5zC8ceDz+clZ
         kNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2LqXX3F/oALvgmOFC5969kJ+nmb6GT6ttXDlPheYFAM=;
        fh=4n2QBqFyfkxAy+4TEwg9DHTGAPY2DcUsdz4KQktWPAg=;
        b=dQXJbnFHoEXsxa/e7uk66YuM5Vx3xY0BGyF8CkfSm/5+n+9gjQ4g7Qg9/cJ331YjfL
         3LMhVwGbT/VemsLr75sHFXnkL6yDAeE275XNjEW8T5JhIqDI9z3/rC9gATtFxQj9EdMz
         8favlNZejF9KtsigrMyLVMJgHcbp53nj8B+WzULfmWhBTciBu5sKbjsJC7oSI8psu/gO
         zuYFhczBDFcNMUH/ArX3lGmsY6LbgwV6P8IKiMMJOBDmjuou0S175riGWK2VRPG8XA6J
         KIO8XQzMhuOZKByYTI3+dgOuIBCQlxPv7I2rd2UVs3y0Dk08qUFrLmcZf3TuZYQfg0E8
         x+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782302920; x=1782907720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LqXX3F/oALvgmOFC5969kJ+nmb6GT6ttXDlPheYFAM=;
        b=MhVkc+eqSS1uaKWGDrMtiBa4PKDW7iDs4Cp9WfcQ9A6M7kTFGoKHH4/aB2uC2ZniHC
         pm2dirqDO66TnznGiEu/Hn5+I0wv+CxGYgsC+CvseyJ2oYmJRqReGIheHvbnk6kSb7Kj
         gdz5AI5jjz2430owQw6j4rG70Lt+wb+O+zVeydDJDmGwdpI/+59jJ5Xw0h79xOYYYrsG
         JUbyR8o1KHVmIlkoN715ACYa+0tFqdvR70U1QOx7zlxi/XAjRRF4ld6hQAEWmDs2Mbt4
         wlYHADXJJV4DuSi1LPFt35kwnCwm8zg5Zmyo7deSdx2zfYJSb9HpusmQqv3Kq+czregD
         x5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782302920; x=1782907720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LqXX3F/oALvgmOFC5969kJ+nmb6GT6ttXDlPheYFAM=;
        b=YYy0gYx5JV5KODiSDZ9hHeWkWURjC9fRFhbQjYlBj4GAnahiZLPl5wSUb8mb/WCZNW
         jiI3Az/EQDz2DggKzvkX0AylSg2JcRW7mQhqUsLYzetBy9AkWxHbxfzDqvXEU0gkRjj5
         Q0DQMJwwLGcjORV9QYUZOYABae4GuBBftVgAi2t5D7E26Zg8f0I5L1lwOtjNSA+ozdrH
         PMAH1fF1DSLmxVKdqRd/ocjGTxbgP4t8HWIXlDjDZocnpYGCLiyTyHG8r9C0wpYhDEMe
         iQikHMvqbvWeK93UBPNAwUQVUoIluEzfWLMVPBmY6EBa1RXROCJ/nPU9D1FGuaug+1Kf
         GxNA==
X-Forwarded-Encrypted: i=1; AHgh+RqKbdBcZ7KXXVSO0SrZiMC3+XxDjCkrDJcEd65LplKC4YVJsoODiFCWcVMqQO8IXIVNYSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGO9gBcwvAGU6HRnU1vRrGRQ/iYwaYES2tEBcskT3r/TwpfMd
	jLjlc4g3btmJ4CDXvXeuP4BEcoAPewMYWUwx8dWiTjJgE9SLT3ik/7v6sIDsarTE7GsMkUOpedB
	fWPXVPxYzOd6CyFtUpcv4+pYuD9imPApHm8Nqwxo=
X-Gm-Gg: AfdE7cm5qbgn8W24P5j5dnGlqyL40sPqomhh+70dnuz9aH4FAH+Mfrv2UzW0C7BK7UO
	4pQIcGluKaX62V4kmzB11IRROcQ2r2mDy9c9vlHsXw8DEl2FlCwQxq+/1rqauhFmyhDfl2ZiagR
	D29jOFq8Qu76z0/+kyP7Pc6mqLkK3IR5lsoxzE98aZVFB4/yBjPR1MT6nZloXucp9hxOVcNgCV9
	HvLBaLy2UBfvwMwqfFFzP52RnVfPrbvGWD/p822ZuuI9StcT7Z4PXXp+Sw1EyfzbojGQP8402gX
	+6n20aL++SBCr2jKwx729z5b8wA7BiJSrvGk89hvfOm2su/xYrLaBvyemPRS1s2zJBkoSK/i0T0
	xQhI3ns/P/VWqVfGXCTkMRqmG4FVEPadEhwSUpvyisQwS35KMcHNIgdK1fdiZh+9QreH0wJo=
X-Received: by 2002:a05:690e:4382:b0:660:431b:8a5c with SMTP id
 956f58d0204a3-66355446729mr5201671d50.4.1782302920546; Wed, 24 Jun 2026
 05:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260619-ps-eric-work-rebase-v13-6-3d4c7315d2f8@gmail.com> <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com>
In-Reply-To: <CAOLa=ZSvxXuf_bSzKMvViNQ5MuDAqxnQdo4asF9vfMhJaDQcVw@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 24 Jun 2026 14:08:29 +0200
X-Gm-Features: AVVi8CeFo4h9HujDearfZNHPKfLToouAid6dXhcjGJIfpcW9ge2yAigBexsfH7c
Message-ID: <CAN5EUNRN4_5PS3cbQtQfpyRuwByvV=qvAVKnVbgT-pirKGnnTg@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v13 06/12] connect: refactor packet writing
To: Karthik Nayak <karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, eric.peijian@gmail.com, 
	chriscool@tuxfamily.org, git@vger.kernel.org, jltobler@gmail.com, 
	toon@iotcl.com, chandrapratap3519@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 22 jun 2026 a las 22:43, Karthik Nayak
(<karthik.188@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> [snip]
>
> > diff --git a/connect.c b/connect.c
> > index 1dced8e632..78c69d4485 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -700,16 +700,16 @@ int server_supports(const char *feature)
> >       return !!server_feature_value(feature, NULL);
> >  }
> >
> > -void write_fetch_command_and_capabilities(struct strbuf *req_buf,
> > -                                       const struct string_list *serve=
r_options)
> > +void write_command_and_capabilities(struct strbuf *req_buf, const char=
 *command,
> > +                                 const struct string_list *server_opti=
ons)
> >  {
> >       const char *hash_name;
> >       int advertise_sid;
> >
> >       repo_config_get_bool(the_repository, "transfer.advertisesid", &ad=
vertise_sid);
> >
> > -     ensure_server_supports_v2("fetch");
> > -     packet_buf_write(req_buf, "command=3Dfetch");
> > +     ensure_server_supports_v2(command);
> > +     packet_buf_write(req_buf, "command=3D%s", command);
> >       if (server_supports_v2("agent"))
> >               packet_buf_write(req_buf, "agent=3D%s", git_user_agent_sa=
nitized());
> >       if (advertise_sid && server_supports_v2("session-id"))
> > @@ -727,7 +727,7 @@ void write_fetch_command_and_capabilities(struct st=
rbuf *req_buf,
> >                       die(_("mismatched algorithms: client %s; server %=
s"),
> >                           the_hash_algo->name, hash_name);
> >               packet_buf_write(req_buf, "object-format=3D%s", the_hash_=
algo->name);
> > -     } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1_LEG=
ACY) {
> > +     } else if (hash_algo_by_ptr(the_hash_algo) !=3D GIT_HASH_SHA1) {
> >               die(_("the server does not support algorithm '%s'"),
> >                   the_hash_algo->name);
> >       }
>
> Why did we make this change? If the server doesn't support v2, then the
> object format should be `GIT_HASH_SHA1_LEGACY`. While the value of it is
> indeed `GIT_HASH_SHA1`, it indicates a scenario where there was no
> option to select object hash, which is the scenario here.
>
> If there is a reason to make such a change, perhaps we should highlight
> this in the commit message.

Hi!
There should be no diff related to that line, In some point between
Eric's last version (v11) and mine's firs (v12) the original code
changed. On the diff from v11 [1] the object format is the same, i
didn't notice this change and it's wrong, I'll fix it for v14, Thanks!

>
> > diff --git a/connect.h b/connect.h
> > index c4f6ea4b0a..8f4c523892 100644
> > --- a/connect.h
> > +++ b/connect.h
> > @@ -34,8 +34,12 @@ void check_stateless_delimiter(int stateless_rpc,
> >                              struct packet_reader *reader,
> >                              const char *error);
> >
> > +/*
> > + * Writes a command along with the requested server capabilities/featu=
res into a
> > + * request buffer.
> > + */
> >  struct string_list;
>
> The comment should be above the function and not the forward
> declaration.

True, I'll fix it for v14.

>
> While we're here, why not `#include "string-list.h"` and remove the
> forward declaration, is there a circular dependency?

I believe this was right because from what I know forward declarations
are prefered in headers when in this case, the struct is only used as
a pointer. Investigating, this came from a review from patrick [2].

[snip]

[1]: https://lore.kernel.org/git/20250221190451.12536-5-eric.peijian@gmail.=
com/
[2]: https://lore.kernel.org/git/Z0RIqUAoEob8lGfM@pks.im/

Thanks for the review,
Pablo.
