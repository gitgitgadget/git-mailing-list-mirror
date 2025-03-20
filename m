Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2391E2852
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487144; cv=none; b=bjfyJSdL51cp7KIG8sydLMs5BeJPMkJKIYlXOCR06sVRMer/YCJ06JAJoq/ES3bGRJU6feopoCZEgBFkH+IQbs8EYe+iuPVyUt7inxlrG5AAEVdDUnCtw6gXod1WMJei3t/iTPsy2/UaFXJYk9n/EEs9zANkQfnDd+ux7YTTxas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487144; c=relaxed/simple;
	bh=Hr2NKvuifIUbsXdmM+QSAFLbt8MpfnSvBzZ67+pvkqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g63ewsmq+35f5Y5IOcac3jItNdxdEHvKA9NcntF86n+7loJjdH66Mz45lF0WoWEbmnt5B0CZW781v5W9SXQKV895IjlcJkjC7H8f2nrZOg13rcsQG27hzEfHJRCs9/OzkFZAT7MJL0ZuzOfpwkzY3zPIsWIiyMnjJ/gbD09nb98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHjAQUFc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHjAQUFc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fd89d036so20081195ad.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487142; x=1743091942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jz8dd9f9Qbcgfq12MPexcwgkAtMCCKbQXWcqeOnxZlU=;
        b=EHjAQUFcavT+a/YUaTphlWh+I0kGEehfH+/AcY3LZ6ieKb73GL0zCW9mIbkFh6WtiH
         9fGXv8a23ApsXqnB5F4ESg88ReXiIRHCs1MuZP5BkeZUETa48oW+rE3ShlGEAUq0H6un
         QGMOH3V5vjJW/ilSreZk4DyeORgKREnCK3eTzW0PJGsgqaOuO7wNMIKq6tcRa0U8QaMV
         s0sdtb4SJ5G8m94MbBC+I7ELrqsuFZaFMbfQl//M71ErD7kaRTQP/DDgntoynt7UVCZ4
         Og3QVeuWilU5DWD+LWXL9ZCtuI8Uo8ZzW77jHQBoPZCuv1soyXVkGbkeeWGhbxs3bpcN
         cPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487142; x=1743091942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jz8dd9f9Qbcgfq12MPexcwgkAtMCCKbQXWcqeOnxZlU=;
        b=mIcAz4RUv4E5svOoGTSefdaOW4H0oaDXKFl4vSy0M8jq+Yc3Z2wtKiZQBGPbfCVt+P
         m6OhSVVVq3+8srD+uAQbz34AP7M21QffDEpTMF4Cp+uvr1lbSlaZ5eeRqQj9qmHcNp32
         Yc4r1NsuU1vb5nMgk2P1DpPn2AuIHeBwz875sTbtT9sfqLwO2T6fWaQbgm+MtwuDo0MP
         miQGTeGlVLom9kuiYY5htu/7Xsm6+QFx145+ovQwd2PkvPBQ3cOJsVvYbChJFk9JBMUe
         OSZDpR1s9dFmX028e1ECgHu+5F/j0eh9vOLGtOycOgRDO/MhhymaObaommcqRjwc4qKb
         p70A==
X-Gm-Message-State: AOJu0Yw4szScjpidW4TS5zLBWcVxKUzxnWTebr4KHe09OU5KY7Z9PEQi
	ByY5f1Cb8gREfKdfPWn6wEVuwrXlyf7i/uMTCnYcSIOaQ0qm9ITeG98zOwpzqCogF9Y18RlxrQL
	rEenI0n7sxErlX0eVt804woTg+uo=
X-Gm-Gg: ASbGncuElH55wU76HnuJBiwPaOmG/zeOQ2CCLJlq6XhSWCj3j5qpzpoVfwiOJe+6wff
	Nxb0YyUMLo4ojiCxp+4Ey7qT5DTP46tgVDeuyl3ktf+X0TRJabUn6QxjfUccZKXau4thl8R+mjo
	jG8wMpE1ksHrqlwgUkHPsQoaO7B80r
X-Google-Smtp-Source: AGHT+IGppBVwsjk58qS6WXxgx0x/8LFQ0gWpPoxrkQFDSEMmFrYpU+KsFLty0FWGagYYQavxgv2VLu7spS6bd74RFK0=
X-Received: by 2002:a17:902:e948:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22649a3047amr112796105ad.15.1742487141832; Thu, 20 Mar 2025
 09:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1742367347.git.martin.agren@gmail.com> <7c96899bb520ab945a650205982f54d65461d5bd.1742367347.git.martin.agren@gmail.com>
 <Z9vdVP4edeaRawsz@pks.im>
In-Reply-To: <Z9vdVP4edeaRawsz@pks.im>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Thu, 20 Mar 2025 17:12:08 +0100
X-Gm-Features: AQ5f1Jotowx5aORBVUSsaTrjmu9eYcGqkUmQOLoXR-GKVVtG7nEMF72DFIsr0Y8
Message-ID: <CAN0heSosT5gVHZ3t7APJ0rGXD_agU8NQBE=t0KNK+C0huY5niw@mail.gmail.com>
Subject: Re: [PATCH 7/8] pretty: refactor parsing of magic
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 at 10:18, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Mar 19, 2025 at 08:23:40AM +0100, Martin =C3=85gren wrote:
> > +enum magic {
> > +     NO_MAGIC,
> > +     ADD_LF_BEFORE_NON_EMPTY,
> > +     DEL_LF_BEFORE_EMPTY,
> > +     ADD_SP_BEFORE_NON_EMPTY
> > +};
> > +
>
> It would be nice to give all of these enums a common prefix, e.g.:
>
>     enum magic {
>             MAGIC_NONE,
>             MAGIC_ADD_LF_BEFORE_NON_EMPTY,
>             MAGIC_DEL_LF_BEFORE_EMPTY,
>             MAGIC_ADD_SP_BEFORE_NON_EMPTY
>     };
>
> Makes it easier to see that things belong together and it provides
> proper namespacing.

Agreed, good point.

> On the other hand you simply retain existing names. I don't insist on
> the refactoring, but still thing it would be nice as the enum has wider
> scope now.

Right. It's only file-scoped, but that's still a bigger scope... I'll
rename them to give them all a common prefix as suggested.

> It took me a bit to figure out why this is equivalent to what we had
> before. But:
>
>   - If `parse_magic()` returns bigger than 1 we'd have exited early, so
>     this return here is never hit.
>
>   - If it returns `0` we have hit `NO_MAGIC`, and we have another early
>     return for this case.
>
> So we only end up here in case `consumed =3D parse_magic(...)` is 1, and
> then we add the result from `format_and_pad_commit()` to that value.
> Which means that the refactoring is true to the original spirit.

If there's anything in particular you think should be called out in the
commit message to assist future readers, just let me know. I'll take
your points above as inspiration for things to highlight better.

There's also the return value "2", which is a bit, well, magic. Or at
least fairly arbitrary. I kind of preferred it over switching to a
signed type in this one spot though.

Thanks for all your very helpful comments.


Martin
