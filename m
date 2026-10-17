Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F72E719B
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225582; cv=pass; b=oQqiaWcVBDVx0PogTxnswvcQvp5Pc7/WwvS4lSBxkLlcj/ay0IlBEzWF3SjjoyVLBtXnBjsQ7jvh9IaqdQcPLwxkBZaIiYgXMSCFSfnhJyJuK7XEnkPg8vviEbQvjwbLBoSyTA5pJtS3ZZdns7GhIExMR9PUZ4WUefjLAM2Sisw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225582; c=relaxed/simple;
	bh=izUlQx69dqynCWinP95VD44Np2NrF3pijLY/As9nuUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPcabdbzkMVzt6tdZYdUIKFOsyGNkmq55wcaQsCz7zC+f1walPfTi+oRZhUXgrHGkn4NA2h9An0z8ZTQ2bO1mUsXRke7EAjViCU2hT2cOEynJClALDpK28C83Mm9VTQj5u7HDXAbl+z0vMEeLn0mSZzDpOadQEdpB7Lbd8LpcAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpYcJH2C; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpYcJH2C"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-48e94879f02so257398fac.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 01:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792225580; cv=none;
        d=google.com; s=arc-20260327;
        b=T42vt2wsjUXhshfypS/9HQjocQSFJzv8CVvSzMFVYueD6LiP+3UHJMehhVDfxU2Clg
         LrKcclEJL2WjywmN9B5izaNu646ztZalNcs7UeVhYyBcif1jhgCAkiY2Cms7W1MZJZ+W
         eI8ELcG8vKZNC7uNv1+7Chozily4BpGTpgZUbJMZwqSYwMp8ss3pYp18PzfHHd1VxHuU
         PcQjLZIeK1b9FD68ZYlD4vDzRuFdK3TSuuva+OdPMS/fnFGnHcK6DdE+OwG5zhfd/Gnw
         K2VB3LvJw1cKhiN/DcN0uUSCLaP2bDbUVFiiBjYchZ/UNwWoGSTLoYzTk/MP/EmLDiAg
         aeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fuahv2Jv1FWqON75upLC9WD/6OXpxMoyBfEXmZUb2iU=;
        fh=Ue2rKLL0g5cGQZBH7wJs527q2+Eue0fLVtphSGbVI+Y=;
        b=qk8Yas18oVmjNyMMiUYdfFNovmfQrKG09DEog73VR3wM3hJcfIV/Nzt2ajXsgSSL3U
         qq2I6isbfM3FJydIid1JIKWbISYBZO3OkQR0GiAy7R2RSLovdYe4Uj9qjs3szu1z5kFy
         oFJovPSKL9OE1UlCmI2Z8HL1AQOWrMlEC+VfVId01TEYmcjbsCQsRlHSTbxj5r17Jp5R
         F4cc4yeHkyZq3JVdla/v7Dbu5oVps+jgRycgeTsi9Fn3NCskQR2hEiWHWT056gQNhF1Z
         u8OXenYwd0KQi9tedlhp3kHQovsX3jCUkBcoM0MIeXUYgBlHvLrIlB8Y+z63PuP/p/6T
         acoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792225580; x=1792830380; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuahv2Jv1FWqON75upLC9WD/6OXpxMoyBfEXmZUb2iU=;
        b=kpYcJH2CKohi22JiM61z4gW1MPYgPDf7NyyCAKsS5xN6MQaZmot2xvctKyb4IXg35L
         4molH5qQafrS4dsdDjqxBCFjwpsfJoDx1at0j4yj0VX7/H6HzRXu487jmJ8YRL+832xQ
         +1eAcJ8XqaH3ROsASecn7a2kxduld79/DpuC1+GCF9bOm4nSM/rf1TLZYF2xkgeo7ZEb
         NaPkZSjGY/IYE4CXYtk+bT3GTs+kyGJhjAosd4yYw70QJxLzwHpYKt341jNhP/YBJKiE
         nfq6tXl6/fkpr3ypjfawZjXOlNj1zvNmdFEIsVYmvJawC1b8jR+PmzwK9ttkvu5WiVQo
         zGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792225580; x=1792830380;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuahv2Jv1FWqON75upLC9WD/6OXpxMoyBfEXmZUb2iU=;
        b=Nix2+2aY1K1Llfl5bN/ny8mMIzL1AqM50RO5MIwvM5Ckl0bj6+G5qdSifmR7TT9kU8
         9KQU65iRDDtfTZll/MtZeXMO3wJIlQVqh2LwF18ltWcADlVCqgvKE6EhAFFG+XDC0NGs
         /Slai6XapIcAkGJgXUkKIBS9KXLQrTGqltVWjmzYPgREaDQKOPlJxMfxVBtx8twnm1UP
         1JINXMPssoMV8iE8lFPi7IMCqOL64vA+v4ErJmMltWLa6N69VITB+8yrGyJA2DEgM1PF
         DVrx5uNTA9h/YzOdK1MhMQkPsASlDsGzsJvE9gpJ5AsGh5xDieTeNm9Zg4Xp4JDiZGiu
         dtyg==
X-Gm-Message-State: AFq9FYJtNoIZXEMk6pgJG/hUQcbdIjE0WePBCh2K6lvJ2vR9euYtn2Nw
	0ino7Il7lBUdR0MX3Neq2XgtW7j3eMkbuOWacRitBnbG8mYPiyr76adDK0wJrzO+ly+08nZEeBG
	15itt6TjmvLC1SqlDggFcCrhuM/7WoZk=
X-Gm-Gg: AYBFou32m/RBb3Zb9/HpB6u7qClVCwYOGicgRe3YUOY55vWS9PgKcmQDy85R+ZkREDv
	+eVA0lQZfZYd3tbMuGqTU7uoTeibwR1y2BX9NRy9b7OQYRporvsoDlDMh6YIUbruFZlqxnzw/gS
	uHbsyTeNqi+ed0k/GBOGpa4JykB2+Nypk3SR+XRDKmpIGu9Z8fwqvzo5QofUZ5KbWmDaxW6AWQl
	ZIPyKqBlyF2efA33STIKONz0MxiQIi8fl1OzBJmtYb/luwsc7V6hyvtnFEiMWF2qdVaudRxPz9h
	+4CbeCV/sw/D+pLg1xeeb7BbCSMEUFt83tCFhR+xfIDBD7gk1fGUTw==
X-Received: by 2002:a05:6870:c2a5:b0:48f:e0f6:c45f with SMTP id
 586e51a60fabf-4a757a180a6mr1837836fac.45.1792225579835; Sat, 17 Oct 2026
 01:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014172333.2224123-1-andy.koppe@gmail.com> <fc0dabfb-3dda-4b12-a1fb-184d1e553623@web.de>
In-Reply-To: <fc0dabfb-3dda-4b12-a1fb-184d1e553623@web.de>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Sat, 17 Oct 2026 09:26:07 +0100
X-Gm-Features: AclHuK-TyHg_sTSoDMwcBUZVFVYFz4oUtHn6Lzi1GJ0Y1zmRLtN2WI7T_9VSQM0
Message-ID: <CAHWeT-Z1C5V8jud=_jK6QByt6DxoFLFk0LYcgbjnGhunzA7-Lg@mail.gmail.com>
Subject: Re: [PATCH] pretty: fix lost indent after newline in %w()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 at 21:42, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> On 10/14/26 7:23 PM, Andy Koppe wrote:
> > When strbuf_add_wrapped_text() meets a newline followed by a
> > non-alphanumeric character, it treats it as a hard line break and jumps
> > to the new_line label.
>
> I assume you're referring to ae0b270230 (print_wrapped_text(): allow
> hard newlines, 2007-11-11), which started to replace single newlines
> preceding alphanumeric characters with a space, and to keep double
> newlines and calling them hard.
>
> E.g. the following format pairs are equivalent:
>
>    - hard newline:                    "%w(9)%n%nA" =3D=3D "%n%nA"
>    - replace newline before alpha:    "%w(9)%nA"   =3D=3D " A"
>    - keep newline before punctuation: "%w(9)%n-A"  =3D=3D "%n-A"
>
> > That code was written for the case where a line
> > gets too long. It moves past the space where the line was broken by
> > setting the next line's start to 'space + isspace(*space)'.
> >
> > After a hard line break, 'space' already points to the first character
> > of the next line. If that character is whitespace, it was wrongly
> > skipped, so the line lost one column of indentation. For example,
> >
> >   git log --format=3D"%w(11) This is%n  the %s%n  commit."
> >
> > printed " the ..." and " commit." rather than "  the ..." and
> > "  commit.".
>
> So currently a newline before whitespace is kept, but that whitespace
> gets eaten, and you want to keep it instead:
>
>   - now:   "%w(9)%n A" =3D=3D "%nA"
>   - patch: "%w(9)%n A" =3D=3D "%n A"

Correct.

> The commit message of ae0b270230 doesn't mention this case specifically.
> I also get the impression that this consumption of the first whitespace
> character was not intended.

I agree.

> > Fix this by skipping the space only in the line-too-long case. In the
> > double-newline case, skip the second newline explicitly, because that
> > case relied on the old skipping.
> >
> > Add a test for this, and update the expected output of the "magical
> > wrapping directives" test in t4205. There, %+d emits a newline followed
> > by " (tag: ...)", and that leading space is no longer lost. With a wrap
> > width of 1, the space now causes an extra line break.
>
> This behavior stood for more than 18 years.  Someone might be relying
> on it -- this test is one example.  And you can easily work around it
> by adding one more space to the format.

True, but that isn't the actual use case. In v2 I've amended the commit mes=
sage:
"This affected things like code examples or multi-line list items
starting with "- "
and continuing with two spaces of indentation."

> On the other hand this hard newline concept is not explained in the
> docs as far as I can see.  That makes it fair game for change in my
> book (within reason), as long as that doc gap is filled.  My 2ct..

Very good point. I've added dedicated documentation for %w in v2.

Btw, the detection of paragraph continuations by looking for an
alphanumeric ASCII character at the start of the next line could be
improved by looking for quotes and opening parentheses too and by
supporting Unicode. But I haven't attempted that here.

Andy
