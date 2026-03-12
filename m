Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56073C554B
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321549; cv=pass; b=SoEZZ77W5OtYFsiBIcixJzEYl4DLJ7qrPP5QEmT66Tno/Fu0g9JoLjKdks38K0Ng0KgHNTTa3KRf+64zrtfKPnUVXP7tZzM/XVyDJTfaxZHF54fiKkpU5tuzprwSq/WQpHcBmMD+1s+F/KXeKiIkU7XAL78phXEr8rsj0uUYC0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321549; c=relaxed/simple;
	bh=S/TAPGoGRV8G4nRxYkGumJqxUZCFEGqenqQEUFl7j+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bgo3jhsRDQiu8lJ0edw5BitIdv8wKTHyMdz0N54qnTTR0tHi9yRPH1RYWjwiEdHlDVAM2eEjSl7TmxoxN3L8xWjGl1R6sIj4+Zc9Ltelok0Ahmc7FLirbdPGiEC6KiNmnWpQddNVEA4/ichFXwrx8lRj2bLeYrSVi0CWvoEmH7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSAdrtvC; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSAdrtvC"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so2509076c88.1
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 06:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773321544; cv=none;
        d=google.com; s=arc-20240605;
        b=U8pRAOT/yA+JeuAV5FHqydnghWXThhHQ0T+PNIfHGrtQpTFKbRrFVabAM5dqtt0r9U
         69ieyeO26ElslQky5glYQwKwuO5UIeLW6ooTiXypeQtgPIXaeRXh/r7UaNbxY9IJP0oF
         Fe3l0peOeGWpNOmV1g+F4c+4xZQIiMv+CwHmFXsOYicxjU6DEpOJSIw2yNPFyz1jRlJ3
         Q6nbxouxUcJy6iBR6xpsQvtmwqb7sNfUyOZxCUtlPurCAxZv7yomThV67Db76RvO+w3s
         UE8xemNxftDGGHmPMe9nzZT8KdhFFxrdddjjiQ36kkPZMeqR5vsAk8HVytri+/ZwqDhF
         vW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qWZBLtUU7eRscXXWH0VQ3l2GrrKa+EtSjUO9/3CfOPs=;
        fh=GCEUApHpIhxEfCfJ7RbGtLoDV6uTTpHqLmIEC/rGufk=;
        b=lyfjiYyU2Z2XuGfj8rBCoHf5M1IWtpqvePJhq7k2bOD0mCq7KQcVSZdctfcWAUFwjM
         IHwa7yRx8qrdX4jpxIen9bOEskMlopStUB4SrshW3WbJqQr1e0gpQsw69uxJ/2YVd4z9
         MeUMVYocKXzuPwxn8HXgBGe3nIUi1XAxMV3beaVRGKu5jkRqSvEaXPj7xRV1FLe8yRA5
         znmetdxP+2A0EFLCPuTd9Pq2H3ihggxiS+BlJh7xi2PozasSaiVBW6Z4yENEO7H2PElP
         fjheLCcreHfqF9f5Qa39qL00GNd+oOhBxBZEcWI4Kc6wLcTo1b5IuPGPL/8ey2tpXey7
         Dydg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773321544; x=1773926344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWZBLtUU7eRscXXWH0VQ3l2GrrKa+EtSjUO9/3CfOPs=;
        b=MSAdrtvCm5N/zoabI1GFDhXX6jfQDDzhNsuoQpnNp81z9/qcyaNg9D4UvO6HyMxXEw
         0cexrTqqUn/pshcUiz4PuTSprEVswfkTQw4nqcST/Lle9exu/Da0b10xEAkXnZuslkQ9
         BeE5si6iyH1pE+FcG+IgCGUohRtCAfjwUHHZH4MKP27TwIrIaGaaqBv2jhE0h65By76u
         HYwnL1CdmfXuPPCAgAUtoJRav62lKuI/Vf8Sd/+iirC7PpjLsaEYYC00qo+R2KpGtkkX
         hr6EXaNi1BFvcItcM4II1yzuYLk3l9IHVy8WebReYRyLDGkScadgeicIqqmhsAWeOGpb
         M7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773321544; x=1773926344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWZBLtUU7eRscXXWH0VQ3l2GrrKa+EtSjUO9/3CfOPs=;
        b=go8TbgTc4wdm2565ZspVrzJOnI8lgBeLhuhRm0hyVuTO8BaxnbC/LeM/r/eUZc8i0A
         oxCQ9HwU5apqrkngFQl/0u9lyJZgGDDT0LKdL4C+6xm9LSRCkOq2X5dLuCQbC07v8wCA
         o/JIQF/FqAZ6yTNTY78GWJWobMKKRammYJkdr9XhEeAlbVkf8hPS2JaCxhNcHiDYM9MY
         it8vf7I0M5V6YkF6eHZxG6aQf6fir4ih00H4OQzLtAeY1x+fAWhXuhm8tWA90W5YYU4I
         yBNg5TCgCn7tqrMZehX2fienTzcjOHopwnKg8CdOEafNpahzBFh+lxXA6HdUs0SBCwD/
         xaog==
X-Gm-Message-State: AOJu0Ywbyvk837rYOVbq813jj8WFY1FS8Jo0eJYAZh6BBO4liLnXK15t
	itdi3RNQkv6N+E9dMEMGWE/v8cPtR9MFbtFqozhNiKjtM0EZDZ3idxc3CgoFIa4mhht/Ghv0K1Q
	4DAtjCPPtI6W7zSsOBsFmswmfi+5zF8E=
X-Gm-Gg: ATEYQzxBzesscVcpcSXeFP0FFPtw336cXce4LDv7sH1gG4QvN6n8P6kvAoX0LZj9HD1
	2wIbDdHFdr/1+7KzbXblEJKAwEv9KYQburlJRotfNfmdXLWAYFoZxo2gw0SI47iWV06kM34PhGe
	T3jr5oqo9cK9m4agLrQLzX/jb/YaexgnEvw3GrhgW/NZ9w/hZ7jC/q3Dg4rrSIy0Yo8zgFpxXt6
	owAuMGfPCioHBZugPPoYHTOV4psXplJVjcC36wBk2Z48y0z30j5ZnsQq0HWRZArTXExUiekXjtm
	JWFO/YpzWumy/3hq4hPcJecGtMCVhdmAJRsVwkQS0LEk
X-Received: by 2002:a05:701a:c94e:b0:128:d51a:5144 with SMTP id
 a92af1059eb24-128e7882da1mr3284786c88.45.1773321543642; Thu, 12 Mar 2026
 06:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773127785.git.belkid98@gmail.com> <9f9a2e8e-6db7-4105-ba2b-7e42bff2ad1a@gmail.com>
In-Reply-To: <9f9a2e8e-6db7-4105-ba2b-7e42bff2ad1a@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 12 Mar 2026 14:18:51 +0100
X-Gm-Features: AaiRm52JkMththUIM3cyQ4MV7v1oE10alh9pkxmv0VXAP4S9-rt_CRcqNCvpPWk
Message-ID: <CAD=f0L9V14gdTgYzQ6aXqq9U8vmi-BozhmHAPVCaSR+2VYythw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] repo_config_values: migrate more globals
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, phillip.wood123@gmail.com, 
	gitster@pobox.com, christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Best regards,
Olamide Caleb Bello
