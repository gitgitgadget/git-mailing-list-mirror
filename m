Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D06480DC1
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027066; cv=pass; b=te9QpvpBooDrrvMobgwhJziaqQQIHJm6cSyhJbtMNIGtMUos+NYitLzhrjpvJ1S+ny7fe0Pm7fxNguvjWIVtF1NNwoAy6hh/xf4LLTv98ZN6r0o3J4NWzSQn5UIHPrNxvXZm0rRQ4XI44MeWPu+HiOAzw3PRRPYvbKPRj7CyBz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027066; c=relaxed/simple;
	bh=nXGrHK59PKAIzigMxhLKvKZ6ILSlNQ672qAa44Y/g9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBlvETzQGa5K9GXOirm56chjATij3ogp73v8U/C5/JDBaBCyYhYyNPL1WdBQ9+fFiF7E0qSW8JWj31fr25bNIw3o4nOvIB/PUbNKJS/w4WmnI3OqhtvnTD2WJaaNh0m3mnVS/ZwFdsA0r/LdvZMhw0M69kRgAcTNQlPcs2Xigz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si3CJC+f; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si3CJC+f"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-660e9fef1d4so6681287d50.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 10:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027065; cv=none;
        d=google.com; s=arc-20240605;
        b=iFxYXc59zYWxLKMtC6qtdtO+QRZOjBxTR1KeEARy5xjdiczX1/uLxLuWmAybUxaeFO
         HG6iPma5cHwo8QdvtWzwCHX9p2Uu0ShDX2Nne2bgRbGPEAHiIwQoZ6wv0uAEXgbIbW/A
         kgJNHU3zIAaWOmLw1w1EjnqpqUbI/WWxiqAxH8nIeLSnnB4rWl7Nnx9XW9RMPDh2qWmC
         5V5bK2MJaOj2pHA4JqLZt/kQ19v7adqh6nX3X+QzowCrg0fV0tW44z+BoMGRHp5sMqek
         FvfAAktSxpjFiJYqcgbb2iHbkvbBDCWl4ZmmSO7xR8Y3EHmBI8uYsttm97APt69/ON2O
         dTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mjJntTSxKz6m9LCrgy/qyWDtMexWDFWwYgB0V7z3LGw=;
        fh=yU9nYqA+YcftMJZiVl7zKJTOSqT/wbm5uBza6LFGxAo=;
        b=gD9g2hDrO3W0oycXv/GMtJYpei8SU0qZgZNAm5ZBADBeCcbUDaHW3FMRf/74Ok7ogS
         VW2nJVcMK3NzA3fFPHOH0/fkVvAndD3aewO+UMr8KP0M2H/rDRXIdLFCsIEd5uweD+AF
         uulxNUEb+b+h/Cys7Zkt3tJeQQnoD//AWK3oVj45keK+k6Ir0sVSsT33RnkUq1Ssctt/
         Nh9X8kTqiwAOEAsr5N92E0SQUhikCNw159nGihWFGbuczAVEyOWybhwgCud9Ti6UaWNv
         GjPI6uofM6WjqXhCnhuLEcMRGgZD24w7umzgj6akySTW6LePp0RIGhHKrtTxFpPcfsd7
         neyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781027065; x=1781631865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjJntTSxKz6m9LCrgy/qyWDtMexWDFWwYgB0V7z3LGw=;
        b=Si3CJC+fp5RLlICKT3M4u8yLuX2OWNXge875nPav5kiGJgCur+aEJ7NF+0R94bpQI2
         oBoaAsipizNSgqDF3r5tv/RJVRNXhvrFob0qJcllcSEeEKvkKJZ1BH180VtAgV86I48r
         J90unIcjjPDQ1/Kh/PUwdxb8flUnEtFV1bVInijdXOrLPaMAH+yw0Pr/S4YLG6HNwY1A
         DzyOE7dwoyj2eUqauzONUJd1s0UEvULkjTy4S2lP8Pn6iuR1BF/ut/gQxMgoSj1XlOzr
         eLO3kCvApITMqamQjjdoymjih1KiFomrKL5gaKRULIjc6Nx1VXNq5SGO+MlQWyFb/Wpl
         0heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781027065; x=1781631865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mjJntTSxKz6m9LCrgy/qyWDtMexWDFWwYgB0V7z3LGw=;
        b=bsbnv52+v50ZcKbtIfN7naLX7g3SVYeTZAD1+UEpKj/31YBEaJO4qiHJFIWUCliD4k
         qBfFXQLri6x1JxTd1FMIMJMIZh3h6kcGePp14XJK5Sb4RpzHpXOmS5OGENy6d0xaf1T3
         DgPbNsr8FPvWyaaMlhFJ5CUcOsPPBhw9AIFp9mds0iUTs1cPt8/qP9l9v0gJHu3V4Mx1
         891Fju6PaIXwv5V6mZcvypR2kU01VLvw0qXbKXCdi+yW1nGdoyYWzGXPZy5OZr2Nf+fW
         uDLzybiugSoFclwYAubg/YwV8s/MgmuMGcerzIozCZO4ZKqMD7LG6GhIli+efwV4w9/K
         C+mQ==
X-Forwarded-Encrypted: i=1; AFNElJ9INOudWGVGlrox48tkoahw8x+ak+ckeBRjIdwzzcfgR/ibLmL7RBUWlXFI3NikWXrtLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUP/ekLzpgp+ebYF5LBjN1xjCfAlwcqBg3ePolAldNDJXQfgU
	t8DSmGXj0H59XUSd4CSx2dPvhszVP8xEcOc6Z+40d0ZHYpBRxmn5wkujCHX8Wg6Eh7PDB//Tvfe
	tSM2w3FCqmSScjQfEL4LPEcxKwtL7s+Y=
X-Gm-Gg: Acq92OFzql3QluCbI3RxYFLKmoQBDBFKaGCDUR4N4dyH7NytDcXRBoLCG3hWHJZmPHD
	C5PwtliCk+AdxV6yv4r4e4pS4DWr60rf4NUMEZKFi+vqiBZQE2pQ01a+0EfkGZnjEQdvTlRFnIb
	BY6wMmt4fx1qsWfbxjusAQ/FsUHh/z/i0qg81lg874+tYWYaI65nJMo+BD1RPj46BA7fL6kGUq1
	g57Sw/qCCzhioFRylcOH2FC991gpJ7IDIVRwB9JlsZZ/MGlMleTtFEb0cWpMEX+b1Jp1vQJGt8t
	nS7r826JvM8PsOCRth2Krx20aH+bUHTMv8+MUoOyAx29e+33cvC1kvR73hJm0qvaquTWWvQz+PB
	JwxroFPAaAnL69GEJ/cWlrCw56W/KWW9LBH0jjblIRnkTnO7iAgiNmO1SXMz4fgrgXY/IF54p04
	8t3G8EkuR9vJQyHnq74OGHwgg=
X-Received: by 2002:a05:690e:12cf:b0:65e:5d9c:2860 with SMTP id
 956f58d0204a3-661213e841amr12803648d50.50.1781027064431; Tue, 09 Jun 2026
 10:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221190451.12536-1-eric.peijian@gmail.com>
 <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260608-ps-eric-work-rebase-v12-4-5338b766e658@gmail.com> <CA+J6zkQe=K80QUOH8LwXCRw9nxv3tHBg+FtfDsYedY5xdHW79A@mail.gmail.com>
In-Reply-To: <CA+J6zkQe=K80QUOH8LwXCRw9nxv3tHBg+FtfDsYedY5xdHW79A@mail.gmail.com>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Tue, 9 Jun 2026 19:44:13 +0200
X-Gm-Features: AVVi8CcOZ_ytnThu9BHykJHQRHce42Ph4zk0gPs1fSxPV86HGfyLOSk4Gb33JJI
Message-ID: <CAN5EUNQs5aJb54JmvGfKB=NrLFOQzx=3C-CA9m0PJAFRNWsU2A@mail.gmail.com>
Subject: Re: [PATCH GSoC RFC v12 04/12] t1006: split test utility functions
 into new "lib-cat-file.sh"
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: eric.peijian@gmail.com, calvinwan@google.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 9 jun 2026 a las 8:29, Chandra Pratap
(<chandrapratap3519@gmail.com>) escribi=C3=B3:
>
> On Mon, 8 Jun 2026 at 15:44, Pablo Sabater <pabloosabaterr@gmail.com> wro=
te:
> >
> > From: Eric Ju <eric.peijian@gmail.com>
> >
> > This refactor extracts utility functions from the cat-file's test
> > script "t1006-cat-file.sh" into a new "lib-cat-file.sh" dedicated
> > library file. The goal is to improve code reuse and readability,
> > enabling future tests to leverage these utilities without duplicating
> > code.
>
> Hmm, seems like a premature change to me. Do any of the subsequent
> commits require this refactor? Maybe the follow-up series that enables
> %objecttype support needs it? Did someone request this change in v11's
> feedback?
>
> If any of those are true, I think it's worthwhile mentioning it here. Tha=
t will
> make it easier to determine whether this change is truly necessary.

Yes, these functions are needed for "t1017" which is created later in
the series [1] for the remote object info tests, so they are both used
in "t1006" (where they were originally) and "t1017".

>
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  t/lib-cat-file.sh   | 16 ++++++++++++++++
> >  t/t1006-cat-file.sh | 13 +------------
> >  2 files changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> > new file mode 100644
> > index 0000000000..44af232d74
> > --- /dev/null
> > +++ b/t/lib-cat-file.sh
> > @@ -0,0 +1,16 @@
> > +# Library of git-cat-file related test functions.
> > +
> > +# Print a string without a trailing newline.
> > +echo_without_newline () {
> > +       printf '%s' "$*"
> > +}
> > +
> > +# Print a string without newlines and replace them with a NULL charact=
er (\0).
> > +echo_without_newline_nul () {
> > +       echo_without_newline "$@" | tr '\n' '\0'
> > +}
> > +
> > +# Calculate the length of a string.
> > +strlen () {
> > +       echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > +}
> > diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> > index 8e2c52652c..8360f3bbd9 100755
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -4,6 +4,7 @@ test_description=3D'git cat-file'
> >
> >  . ./test-lib.sh
> >  . "$TEST_DIRECTORY/lib-loose.sh"
> > +. "$TEST_DIRECTORY"/lib-cat-file.sh
> >
> >  test_cmdmode_usage () {
> >         test_expect_code 129 "$@" 2>err &&
> > @@ -99,18 +100,6 @@ do
> >         '
> >  done
> >
> > -echo_without_newline () {
> > -    printf '%s' "$*"
> > -}
> > -
> > -echo_without_newline_nul () {
> > -       echo_without_newline "$@" | tr '\n' '\0'
> > -}
> > -
> > -strlen () {
> > -    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> > -}
> > -
> >  run_tests () {
> >      type=3D$1
> >      object_name=3D"$2"
> >
> > --
> > 2.54.0

[1]: https://lore.kernel.org/git/20260608-ps-eric-work-rebase-v12-10-5338b7=
66e658@gmail.com/

Thanks,

Pablo.
