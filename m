Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FD128373
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 05:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781500; cv=none; b=gkRoAkNYUTfXsgFG3DItXfsGWfZxj8vHbOIxnzqjs6OPJ17pDLtnFUJ/n41jGGN5IWWpdoa70UF+TNCvyhHth4j2tOX3cZyPi7OKTdwoY/jbih2atQa1MlwzRJB3FEkT3IDX3rf5PhC5n/2F08OzhLeQSbgRJtynD3hxBhuvQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781500; c=relaxed/simple;
	bh=RTeA1DqXmBwGWqUWZguwnGsMZfExHf1XeW/P/DD0tmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWb3BI+F35E+N1DUbUDpQGZrVvZAVnRHMtxW4exQOjhZ8ADlpfv8XYQZ7jIT4XdtVKfv1B9egIkbQfptNKsrbzj2cCsKsOACn8K8QoU9HC3jE7dlNeX0kyrkP7oVjOV5+7KF3AgO4EBxiEod9IbIuMhCgtQBVwoQDhTVEYSzGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsjKOa3l; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsjKOa3l"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso530599439f.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744781498; x=1745386298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmSrYUWVDPwtnkq7GrbXNHEs9xbNmgdA+d6N/3VjLFk=;
        b=fsjKOa3lp4pF7sKLtZEVhE/ZWZf07BoYiwfqznPyyGbXjKOj6N1Lc71zZYPUC/IdX3
         mBzLBen4IxR9RhPvntVdfV2KU+mIxhEPe4Jr+Mco6ZMlgf6yecyhgG3AbpTSiFuvdnuw
         oYXDT5kcpm8k2bOYhB2BSqv96otsFV3K0X6lqttPenBTVvrMPjOy1opI3Etus+CBeJeN
         BIYJWwy0wIpq85ElUp6FqITRw5DmumT/7r0eb/Vco6A7SQXQK70x3qk8IH6YGwflWbM2
         ohavvDie/kbiVD0r1dH30hPOtLSqS3psLKUgZcCOuEJVD9hUedYp94RISRVeGiz0I6gQ
         hh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744781498; x=1745386298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmSrYUWVDPwtnkq7GrbXNHEs9xbNmgdA+d6N/3VjLFk=;
        b=r6oL+8pKUZPl2jlW8v32VKXafBwRHWL7eUgrzrg9q2VJYH428doMwYJosX0rahknpJ
         2JndWqphbxAwf5g8rd4UVabA4hRQROzb3wh7jCktMnMP7NzCYhKeOilWAJshygF6Ceq8
         upozag3h7vKMnxbjqjekcKt1gFkIwiKkrURJk+iu+k5CsAHilqmgqBj9D55aVVG43qHN
         uJfLAINguXmToNPY48FmH6/AUa7AOPZH2P5ZHXJJB5QndefsF4V79gORTIzFWz1YNnE1
         iz85Y7mz4UZU+uG36lmnNw8wwuR06df9//yPuFzOt4Q3CQP5DmQ4a8qxjeHEAJtQRaBh
         Ab0Q==
X-Gm-Message-State: AOJu0YylaftAsW4hPbnISjV+SYWfu21P1Tyl1+XHNrxlXAlP8wANUDo/
	0LhQ3povc1nblNkynJ3cy02uA6LoNdPqz87a3ieJatNSdDZdBBua9QIgddq4ib2QcUO/qwrfSIQ
	mkk96jd4ZShOw4x5vI6Ia0jJ0tT1Y31xg
X-Gm-Gg: ASbGncvhBTpTAzj3RpEYKMZImu9jUYxOgMuMewgtcWQSX1q/FV0jJJo2MXUNgYoMNGZ
	F1CjlqXALpElQ80CUfIG/XUVmsBNaUd1sJLUT9s9Jw+2gEtfRwEgCLM6wwjO76c614vXARtit2A
	6l7mwjUg+gFMsybQbLv91pwgh4Dv8spInTogn9QCdQjfsaobRu5s9oz5A3e3K47Cnknw==
X-Google-Smtp-Source: AGHT+IGn8e3W3750hfgyXFdQs4IHqezJbkrCWX7ui/Qckjl7v6aWLiMUJClSY7lf8Tdaa4TxI6TNhWdKPchLc9AQmoQ=
X-Received: by 2002:a05:6602:2c15:b0:861:c230:4a76 with SMTP id
 ca18e2360f4ac-861c50961d7mr50913939f.4.1744781498057; Tue, 15 Apr 2025
 22:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744757204.git.me@ttaylorr.com>
 <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
In-Reply-To: <986bef29b5f33d32fd366aa9370d439175a9b605.1744757204.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 15 Apr 2025 22:31:26 -0700
X-Gm-Features: ATxdqUFM6ZIHGUBlH7QA8-hcVipO5t_MUTChAcph3MOrRl5hR52SLWXfzhuiIWU
Message-ID: <CABPp-BG-=6uRtHXrzSOMw=J2Shg_vfXhLzwWDREy7OAQg_Ak6w@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] pack-objects: limit scope in 'add_object_entry_from_pack()'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 3:46=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> In add_object_entry_from_pack() we declare 'revs' (given to us through
> the miscellaneous context argument) earlier in the "if (p)" conditional
> than is necessary.  Move it down as far as it can go to reduce its
> scope.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 20dd870bbf..4ab695a3aa 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3490,14 +3490,14 @@ static int add_object_entry_from_pack(const struc=
t object_id *oid,
>                 return 0;
>
>         if (p) {
> -               struct rev_info *revs =3D _data;

This change is half of what you mention in your commit message.

>                 struct object_info oi =3D OBJECT_INFO_INIT;
> -
>                 oi.typep =3D &type;
> +

This is an unrelated, distracting change that I think was accidental
and came from trying to back out the other change that was part of
v1/v2 but not quite backing it out completely.

>                 if (packed_object_info(the_repository, p, ofs, &oi) < 0) =
{
>                         die(_("could not get type of object %s in pack %s=
"),
>                             oid_to_hex(oid), p->pack_name);
>                 } else if (type =3D=3D OBJ_COMMIT) {
> +                       struct rev_info *revs =3D _data;

This is the other half of what you mention in the commit message.

>                         /*
>                          * commits in included packs are used as starting=
 points for the
>                          * subsequent revision walk
> --
> 2.49.0.230.ga662d77f78
