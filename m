Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064D3EE1C6
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896042; cv=pass; b=HhBuOAbEdhVxW+7BNvsKEDkQEdFhgx/w9l7pmNblC9DgCq/70bdgujAOTvO7ki2BaU3KxEWzKTK0WhsePWCN5fnLRAtX2mxv6KS2kwllg405WUJ1eg1h3kyBZpel8m/l/Q98aInN5kklGJwsseToapQQopmRP5z2eghhUYCcuC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896042; c=relaxed/simple;
	bh=klk9F2xhaLnctgj3nUECYqFz5nyh/wsEAahmBBh0iA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM/5Kg4o9TM+vxFaldGA5/lascjm/5IWYYfMfb7m9apuL0euhjcluFrFXFQQtBPKQgeWRfSjjMcRfZ0xvRh9YxxRHc4/S4V4d/LUKfM0XGIAxJmkW2Ly/sFGA0QTQ/MlBbibFkVlLiV65DimHERmCxLdy6lNeXZNIbH8tYYKxPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifCeQAc1; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifCeQAc1"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1370417c01cso3740745c88.1
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896032; cv=none;
        d=google.com; s=arc-20240605;
        b=Chi5ZbAf5chy2k3mPReOLY28C7evx8qeEqNT7yHSjWGj2Or2noCE/zMjiKKGaUtlnJ
         hsaXSEqD71cFgKDDrWO0viISPCsbxbGmVGTNncATe04T1QlsIa8QEY3KcOEv8PJveQnl
         H8L4Vvf0nuGI4sUvmXVShaUV/7oktBl957BJLkXIodEe+PpvlVczy+pmkbxplgXmsD4k
         nOSVxU1Hpt7m5s0ftxd3qhOkOP5bvRKpDSNOcNR7CIp+t6pToJ5j+lrwbrw0gkGNo3Pq
         qHO9Fw7EvEkmm+2laBURzMr/hImIbCjdHf0nXxTRaHu8gb+/tr29IVFXI9n3Hkl1rPU/
         XKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GSAMenXy6MXJBoY5aLZAq2koMO3dN2FBX28zH3ZkKAM=;
        fh=PdYqjAzhNtme137FEVplszFJFBawqiEcziqE77l/F18=;
        b=jrQahqLAjpZaVM1XhbSteO5zu9ulyRZCTeL+2Yze47TiY6gbDIoZ77+MeCmhrYKuN0
         Unf7/BybX8ndTQBSCPrzZ6irv523G+mub5tFxfh3CJA0KcnhR9T4fNdFJ+oL6Bo88zv0
         huWQsdcgm7tkVbL3b/KJkXER3trl+SkB6fbLBqif/bJtI3YPjs+z3irlyTb1pqMlRSbG
         ImvVlwJeK5ynAleIwLblWLDHLzgtZzJm3t5Fxl8JdsZQj+IuViT5DHBPnk9pTBsqV+6x
         IumxcN3LIsgnhO6oppQ2GlrfOELDMloyAAKcTyQQx/umOFdapdKhrhv1ZnHaaqcSHCEb
         4CVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779896032; x=1780500832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSAMenXy6MXJBoY5aLZAq2koMO3dN2FBX28zH3ZkKAM=;
        b=ifCeQAc1Kl1TGyv9RzxbdL91mCnnvkXN7RiuAIwt03nfRRaJvP6Dg6T2fYBpMV8XzU
         I9POEiri/ph7NOIXFzhMuHUC/aeeVVC+zzyvoTdqszqoPSiJFOWngSsg/4MNhJmeJFCh
         PlmG8viAIBnllToJyZ0qu4MxUYOJrzgdu8xZGG7BotvTmUGa/JDnqE9CUAUxVvYeITz7
         d9IPqQ8v6fdvWoBihkw1ZjKp3seL0GZQnU4PTTdvtyY8v8v7WJzh0JTBu7ZBbOKpQqBD
         SxGMyTdDB8XrjB6ybIGasL+WnZAVuNdGA2Ix4Ii8agSGRmorgHd2688T2X28tNc0u4zo
         f3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896032; x=1780500832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSAMenXy6MXJBoY5aLZAq2koMO3dN2FBX28zH3ZkKAM=;
        b=UbbwNDHz5x0EgGlm0uIa+FO/Qb//Y7ciCmQ73Q3Q4iOhDz1Z1nW93D7aODZkzc/8SV
         eTIOF3xZlXg1sRP8w5XV+6dHA2cr85hd4UNStraPWUOzwCy65C1mb5CU7pNBc6HfydY1
         AqSw2wlQzPhgw9SSn3tiGrls/f8k2sg/R9NL/ZjrmENw79kZT9wB1A2TZt0Z2/U0cRNE
         t3/z2y9G+54jHdMP1OYQT62iLwaq7mLTChwR1Cf/XTmlvseWmvziTJUlCESIsx829SKd
         Y6xN/YddqfHeHU7dTAswP2IhVUJbBSSEKZhpN3QnBO8wr/3z0fzIR9UuREZ9Vm460Ydi
         mAcg==
X-Gm-Message-State: AOJu0YwZkQ4japwDl1+QW3XwNAky9occ/lupYmwL3uub09xHqOVpa2uo
	BEspSsWW/qwSjDKyL87YKwwSEEbEDWNeDD0E1iq4UZRqYLx8KHzRy1o3aPuC9fb8v0LGX42lCHB
	+BsfKtcgZj+kIhqBOOxn2op8Oi6/QpXw=
X-Gm-Gg: Acq92OFzNilrNBlTjKZTABcTjpFQxI71hi5ypQPq/rA1ALootFvTrV++GFUpX5j16d0
	cNPOTQ5KLp/NkwqgOxlb3nL06adyk0cHiqGtPQSdt5o+QUuJtcL6y0kRg8JrVSxKqKnUjw+4yUj
	EZopQhr+l132jvCWTK+o6VlyU2m5WNrJFITvx3NUsY8tWcIZoRFODWIEptMdRppYmEg8eYags3f
	2tvvkILl3cftwABT1wvgpPx1/W/K4PE6OY32Gg2bgdTHo0UY3xMlmh/30Rb8sMCb9IKQm3giWXn
	6esTlalxS7lqVkqpgKojwzaW9fMih+hB7uAw99dCbGmUEQsebETntOPPEhJFKSrf9nFDHxY8ujs
	izP8=
X-Received: by 2002:a05:7022:493:b0:134:a6f0:6f08 with SMTP id
 a92af1059eb24-1365fc6e6a8mr8332275c88.39.1779896031683; Wed, 27 May 2026
 08:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com> <20260519153808.494105-5-christian.couder@gmail.com>
 <87a4tvq6pr.fsf@gitster.g>
In-Reply-To: <87a4tvq6pr.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 27 May 2026 17:33:40 +0200
X-Gm-Features: AVHnY4I3sWgE784vNufby_gBWYTQSZfEKcCM9PWL59DeN18NavW1rftqEiurhs8
Message-ID: <CAP8UFD2kYbu09xd=AppjY=xfENRG7ZmGBSNCsxR72bwqXybZzA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] promisor-remote: add 'local_name' to 'struct promisor_info'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, Toon Claes <toon@iotcl.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 2:12=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > +static const char *promisor_info_internal_name(struct promisor_info *p=
)
> > +{
> > +     return p->local_name ? p->local_name : p->name;
> > +}
>
> Hmph.
>
> > @@ -829,7 +836,7 @@ static bool promisor_store_advertised_fields(struct=
 promisor_info *advertised,
> >  {
> >       struct promisor_info *p;
> >       struct string_list_item *item;
> > -     const char *remote_name =3D advertised->name;
> > +     const char *remote_name =3D promisor_info_internal_name(advertise=
d);
>
> Is this really a "remote_name", though?  As ...
>
> > @@ -937,7 +944,8 @@ static void filter_promisor_remote(struct repositor=
y *repo,
> >       /* Apply accepted remotes to the stable repo state */
> >       for_each_string_list_item(item, accepted_remotes) {
> >               struct promisor_info *info =3D item->util;
> > -             struct promisor_remote *r =3D repo_promisor_remote_find(r=
epo, info->name);
> > +             const char *local =3D promisor_info_internal_name(info);
>
> ... this name "local" is "the name the thing is locally known to
> us", promisor_info_local_name() might be a better name?  I dunno.
> I jsut found it odd that the return value of the same function is
> stored in variables named "remote" and "local" at the same time ;-)

In the v4 I just sent, I renamed promisor_info_internal_name() to
promisor_info_local_name(), and "remote_name" is the name of the local
variable in both places to be more consistent.

Thanks.
