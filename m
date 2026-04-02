Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525572F5321
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111750; cv=pass; b=S/3YLqxhbnIc+fT2zRnRhtk1BcAbCEzgU+vJhb6fw+L+rdov0lpRCS5ccyDrggv9TFx/A1VA8Aoiw3MUzhKOdtMSAZIqtkcLLOOpIw/hQNWW8kGhFcgzlG4LR7Xtr22YxXR93m9gQq7iTB34t4RXIKWmC9+S9f61yueZkv8Bjis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111750; c=relaxed/simple;
	bh=TXP1gWKbidsgyKmEKWxPB/z429P9BUK67BEatC9oKYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5mfmuTY/l08diMLQmaktO7GyyW7oY6RCGtKlRvJv/+LlBgO6ggz0eqD7YD7wQFmHlevXu2240RkVK5T46sHXDe5yQ0z6nd+rcOiJbo5MdeZdCAiPbFEuLFPoCFWB5UQtpAyzxHsS2sEV8GTQhZij2j9BF2LMkhff9dTm1dKoYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRXJyOBT; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRXJyOBT"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso761872c88.0
        for <git@vger.kernel.org>; Wed, 01 Apr 2026 23:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775111748; cv=none;
        d=google.com; s=arc-20240605;
        b=G/xQWkMysGpEmTcnCXTwbJuvilmsMLRRFWjZc0/KtOB09ACQBuZ9ED9gv8GWn81rCU
         BN1MwItdb8FCQ3i56PBmXxAVrCT/gXCTvhTzd2Ay0xOzxLsID9Q+TN/j6QsZsHuU4qwd
         5YcxFy9auG9WrnhNr0PDJG7DJkR4qrQS3R2s7j1hX2DX2Dw+FD8o7oW80A8ESoxk2DSq
         UeIY2GCfj4oo6BrkIIXnNXO/uSSQpmRdPFF/33t9dEoLjmC41fyFqLj6dgYv2YDgsEWX
         OEMSUa4ALOpxp9Ei61gZhDVxlLhG7Jq0Xzh6E/rfgd2Lp42bUxzAOD8IteMB79OWnoz3
         sLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PQis70yJNRyKwekCWsgfyi0Z3T6CN513Nr+aICtMh64=;
        fh=aY+RodnsZwaVQgtho/D2F/LrJl8TcIGRGapA9S/T9w8=;
        b=J7RNp9zlJI6qyN7eakIJzS5o5PyYVmgqR3BCuooH0fnFa3/f+7IxiyrG/AgxlZTyl7
         AVfiFZEN1Uukq9vaFDSY/sRq3Dp8Mcw07G1i5EWfaM3r3QpjYzR49zxVvScQ6UoOzPGS
         j1cJ54YIPoejTCCR/dyIP5OtcoUmYUUzj7nNJIlVm5ngT+s2CwG/Qg6v2QDKvmVhMUEJ
         c2Va6MVjrXkxC5aXTM+d1pwsdOEXrXU3edBJbzai3GFhgmgotLugSJEzPQCLbk6KbKBp
         XLmUBSmdhi4osq75M1lY28kHsGe7tfNeIC0BMm2wz3tVP4wayiLzTmPAN9tEiNgSkd2l
         3GXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775111748; x=1775716548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQis70yJNRyKwekCWsgfyi0Z3T6CN513Nr+aICtMh64=;
        b=XRXJyOBTtTQpuL6NDnaiJ+ao2s7m0i4HvxyREy9clEGHTPrjqW6kbpDyKdRJwLuTfj
         whRpV4hHmFr3An7P/fmxhqzC26QVxmCChPfUSr6GSi7kQ61Wqsu901begTdcrvzlVbee
         /lkUpsyNwWerO8wDRE9go2DYUMJ+x7eKSk67l0Ttn+wYG7+RZibCaeo2k431aYeYifj+
         AORCf61bou1mKLtmsL4tTQj3BxntANEjJ2fYDuIMQ5k5oip5e9p9oJq9NMJM3IWdkWx4
         CY/Hh6FuBCX9MYakkLvdVU8K6nqvonqdyAb7wM/Zv05oV4phXAeaRIHYs1/yutj1FfFX
         fkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111748; x=1775716548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQis70yJNRyKwekCWsgfyi0Z3T6CN513Nr+aICtMh64=;
        b=k1TnVXoIxt71bElGl8HPpEV1JqzCxzVjN0a/r/L+pKQefamku9t4Uxwexdxri/Q6MB
         MPebq3I4ENjJKNJQX31AMMO/ANf0UPVe9qmj9DESYYEhYOQHBt4EWG5i3fVSYkVYqA12
         dHV7KtKbvz7gwpUzdM3LVtq8NHwrlJNwYwTb+YWHgqIqqRw/anmtBPwlEZB9hhQR6Xce
         uPP/Cf9o/iHjcdjZs0XgubzG8hyMucWZCMyPGasy9rgXq3XFCT71byykgsVTTOL4rLD2
         ljrKaAIkW3UshNdBOOd6HIi08BkzSvBPouoOUwNZPu1d3cC4clecrDPpYKSceuJJc6Tr
         j2pw==
X-Gm-Message-State: AOJu0Yz0FozlOmNddedTds8NevPGpM486swXzjdkXnQ0TYhk7ewQJoiL
	YC/6JyMuh4BCjxRyVPL7lk9WkGjU2qwb9IDmt9uS8faFJhEv7cnUfond+gQq/XUrXMtjOJkmcam
	5ghBit1MOoiyr5daszEQpj2S5i9ccN+o=
X-Gm-Gg: ATEYQzwd3nO6lJqyzCzvy9KbVSC2JXVyc1ljRp5MFo3FXtlA2Kw3+v70D/tTT9rZ7Gx
	SreQN+5ASvSNHniXInb9gkJCLXAflglIEgB0T0I3KbA6KU1J43TWPp1YYj4WDLRp3UEqiIsB6ZM
	XXeYNe6roK7TOCo3cmf9bqoduV+gqS0PdBB+oMjzRabNdg6JgMGubZOAcSfFtfZpaaZ8qxfT3Zw
	VU3z70Al0+hqTb/2H3yj2jPPiH3S1r6YCii0+fMWhzLYqQYzRfy3VdeRBa0+tAKdrYBBGMXmLf5
	26Kl7Wpli2WTfz4zz+JLYpAr43DODbARMp7mfPjcnwa9l31JIYceweLkxt93tPtMOUjjWq1j/yw
	mOGI=
X-Received: by 2002:a05:7022:660b:b0:128:d51a:5157 with SMTP id
 a92af1059eb24-12be6535b50mr3290417c88.33.1775111748350; Wed, 01 Apr 2026
 23:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-11-christian.couder@gmail.com> <acUkvkLYiO0wkCfm@pks.im>
In-Reply-To: <acUkvkLYiO0wkCfm@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 2 Apr 2026 08:35:35 +0200
X-Gm-Features: AQROBzB9YeSNbTwIEXAKxW61EghpfQ-yUR7Z3-k7dMBCl2Zl2AHNHW7dwDiX25A
Message-ID: <CAP8UFD2Pp3vg=NtfYrpn=UEzpiPvu5F8nYiFrv+94tXh2LABPw@mail.gmail.com>
Subject: Re: [PATCH 10/16] promisor-remote: pass config entry to
 all_fields_match() directly
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:21=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Mar 23, 2026 at 09:05:13AM +0100, Christian Couder wrote:
> > The `in_list =3D=3D 0` path of all_fields_match() re-looks up the
>
> This reads a bit weird. How about "looks up the remote in config_info by
> advertised->name repeatedly" instead?

Yeah, this is better. It's now used in the next version.

> > diff --git a/promisor-remote.c b/promisor-remote.c
> > index da347fa2dc..8f2c1280c3 100644
> > --- a/promisor-remote.c
> > +++ b/promisor-remote.c
> > @@ -619,7 +627,11 @@ static int all_fields_match(struct promisor_info *=
advertised,
> >               if (!value)
> >                       return 0;
> >
> > -             if (in_list) {
> > +             if (config_entry) {
> > +                     match =3D match_field_against_config(field, value=
,
> > +                                                        config_entry);
> > +             } else {
> > +                     struct string_list_item *item;
> >                       for_each_string_list_item(item, config_info) {
> >                               struct promisor_info *p =3D item->util;
> >                               if (match_field_against_config(field, val=
ue, p)) {
> > @@ -627,12 +639,6 @@ static int all_fields_match(struct promisor_info *=
advertised,
> >                                       break;
> >                               }
> >                       }
> > -             } else {
> > -                     item =3D string_list_lookup(config_info, advertis=
ed->name);
> > -                     if (item) {
> > -                             struct promisor_info *p =3D item->util;
> > -                             match =3D match_field_against_config(fiel=
d, value, p);
> > -                     }
> >               }
> >
> >               if (!match)
>
> Okay, the logic is reversed now, which makes sense as we now pass `NULL`
> instead of `1`, and the promisor info instead of `0`.
>
> The change itself makes sense, but other than that I have a very hard
> time understanding these two functions. I think they would strongly
> benefit from some comments explaining what's going on, what the input is
> and what we're trying to do. Of course that doesn't have to be part of
> this commit here, but I would appreciate a preparatory commit that helps
> guide the reader a bit.

The patch already added a comment in front of all_fields_match() but
not in front of match_field_against_config(). Now it adds comments in
front of both.

Thanks.
