Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651C22422A
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753912184; cv=none; b=P/9eNLA+QoYC547xSWhBc7gCxQF2h4cFG9ARBG32KsJImDZCbtBaRuN5BBI1nj8h97zug7EOYT3Px62pb2E4pylXlUz5NM3V5xCWNm1/oGRARLqaWh1LtRlMNRFuy/0BA1r7zM6TFdsjsL35jAa/ChZcVKk6JvcW4EgpLNfSb5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753912184; c=relaxed/simple;
	bh=914DgVBOd1PR2LOZ4/DKyK9pgbOsI6HzeKi2+/R/3MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpGHRL66xBU3dQHztWw4+ALhRCaAWswj0LE4hikQYxxIOSEkGIc1Xkl+Ndpk9A8Mhdo0qxyYV1PL3Y0h8P4vIBALUez0whbyjv/Hmzddh4yQTiuZ3Gmgjn8bOnW1RayrfE9drqEjbJHdKpzhEeS4JMmwrDALX0D/ViEsVm1oBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKBB8HKx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKBB8HKx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so40481566b.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753912180; x=1754516980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxSJ6C4A4JYKnTvpECp/OZWhKzoprZmTYw+rdaeGrOc=;
        b=KKBB8HKxKtVCm70Ka5mlofLXJaCgBMBK9x3g/u81SVUTce+9Td92/EhhAxXtrfxikI
         t7k2CdGV6bODIcR/4X8qyzrb9egAnr/RODTTd4wKIf0FqnKRFSjI9TKtolUu4osZOJYs
         lLMRbuOU6RXjLydJeWfGJ3hrtUmxQY4KQycKZVdus7VdJk+EzgRqW68D6NJe9be4it6C
         dD/7C7WeqzK5Z/Iy28jw6m9nrZIdTcaAjPtL6eDCGJ8Wylo0zoJmi9lS/z2p7GMrzI/5
         z2UAEW2AmbxP2aQuxJ29jfT/3DFEblv9YKVBngT7/R+iaB7HM6h0pr6eybiQNXQeRNeP
         efpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753912180; x=1754516980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxSJ6C4A4JYKnTvpECp/OZWhKzoprZmTYw+rdaeGrOc=;
        b=Tc3Hyvff49ViRFKiKLwQ7cCN3Xsyg+lI3De7bIkMG/HKkUAoQvbRysr5D9P1LgRlt6
         Rjwv5JWjb7iAw9i9ZiDPl1+F10pmXOVqhX6WRMRs8/Bn0Z2hO19pY+XG9j0JhbGnTo8V
         /kUi4UmCrGdjk/2ULiA03uCICrptKjCIE2x4bIxYfBslnfHdLZvAIeAxrcc/JiZUrTVD
         A1FUILGSU5wgubRBBr6CHXnWv9K/OV1tP4D1pKe8VqunhGOGZ5eEUDAXjufi4355qi2I
         xCnSUlsnt3eHytgoP4uYkESJ4ngO6Jk03BuK1WPq84o42maaa9TCrgS7dxAllsr/Rz37
         1Rfg==
X-Gm-Message-State: AOJu0YzpAVm5d8AoxVIsFpcATJitlfU9ByC4FO+E7ooR4BSXswdq+X6X
	Noj0IR1eaFoO/IxY+BPbQBWhJA8uI3dykLE5tFNT4ZQkYsPkdp+GvXsvXAdTYufqhUAwcR0pK7S
	aTZGQnHAURgP3Szy5tWEK/IhSARVLxph7xfIN
X-Gm-Gg: ASbGncuONkyrfMoKA1ycmhdZBvgbJFxCdxyUqj2smlX+Np98+rt/ab7i6jOvJRkQpc3
	mIO8aE8aTYlIzKYr6JoWJIYzXe6etNhTbgt9QpJrIuyAs2ebHGACyyAu0g/6+at9Kkqir9OS/Ow
	lyu0szcNs62yAzqEq5fc37Bt4Io89IWlpIuxt34oyAEHPgNzQESUwx5RepDF+c9Vmi0Qf8h8mNN
	aSQ/UEA0XeUH+Ko4FVfPo0bwi1Ohs0lRASLvPXLXA==
X-Google-Smtp-Source: AGHT+IGU5jaWQUP9wIn5B+MIPGc3nX2yxx3BK9WWDU+pnQ2UhG91gmJ0iuN+JbCCO536PJEzGSDMaN3KbeROxcXB+gg=
X-Received: by 2002:a17:907:6ea2:b0:ae3:5e70:32fb with SMTP id
 a640c23a62f3a-af8fd69d655mr582069866b.4.1753912180496; Wed, 30 Jul 2025
 14:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
 <xmqqv7nezdw2.fsf@gitster.g>
In-Reply-To: <xmqqv7nezdw2.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 30 Jul 2025 17:49:29 -0400
X-Gm-Features: Ac12FXxS5DhmG_bBMmMhZL3qyN_cUFmr22ZTmG7oAT7WjatnK9JtCVe0PO11uuM
Message-ID: <CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
To: Junio C Hamano <gitster@pobox.com>
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 8:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > With Git 2.48.1, I observe the following behavior:
> >
> > - "git ls-files :^:Documentation/RelNotes | grep Rel" yields
> > "RelNotes", as expected
>
> It is deliberately confusing to spell ":(exclude)" as ":^:".

What makes you say that? It's documented in "git help revisions":

           A pathspec that begins with a colon : has special meaning. In th=
e
           short form, the leading colon : is followed by zero or more "mag=
ic
           signature" letters (which optionally is terminated by another co=
lon
           :), and the remainder is the pattern to match against the path.

and

           exclude
               After a path matches any non-exclude pathspec, it will be ru=
n
               through all exclude pathspecs (magic signature: ! or its syn=
onym
               ^).

>
> > - "git grep squash :^:Documentation/RelNotes" yields the error
> >
> > fatal: ambiguous argument ':^:Documentation/RelNotes': unknown
> > revision or path not in the working tree.
>
> I think if you write it in longhand,
>
>     $ git grep squash ':(exclude)Documentation/RelNotes'
>
> you would not see such an error.

Indeed, I left this syntax out of my original, but it works.

> The error message comes from setup.c:die_verify_filename(), I think,
> and setup.c:looks_like_pathspec() allows the control flow to avoid
> calling that filename verification code path.  It knows to let the
> longhand magic pathspec go, and it may be trivial to teach it a
> shorthand magic too, but I offhand do not know the implications of
> such a change---there might be unintended consequences.

Hm. Running a debugger, this looks accurate. We are in the
"!seen_dashdash" case of builtin/grep.c, with the call

    verify_filename(prefix=3D0x0000000000000000,
arg=3D":^:Documentation/RelNotes", diagnose_misspelt_rev=3D1)

which eventually dies as noted. However:

- looks_like_pathspec() only checks for long magic, as you noted
- setup.c:check_filename() looks for short-magic, too, but only
considers ":^" to work like a pathname if we're excluding everything?

I think what I find confusing is that, while this is definitely a DWIM
case for git-grep, it doesn't seem to do DWIM :) We are verifying that
the remaining arguments are filenames, but couldn't they really be
full pathspecs, as long as they aren't revisions?

The difference for "^:<path>" from ":^:<path>", just to complete the
story, is that in setup.c:check_filename() we try to stat whatever
comes after ":^":
- for the former, that's <path> and we are ok
- for the latter, that's :<path>, fail.

So it seems like the places that check for short-magic should also
consider the optional trailing colon?

--=20
D. Ben Knoble
