Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2E153BF8
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736016898; cv=none; b=kUt670kW5a+SX6Hjk/50iuidRvOSVU+7oAfKOarG5o/ZEX9VQyKcQpDDd2N/6phAeapGP+cYE6h69UBGC0Ej2P6nIV3tH8IfmqgAwokNowZTBrsBzfKxus7Ol7VVFcyDZFolTCtf+88mjqQ0TQXu5/fmkW5rcUl2ss6aIFkRfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736016898; c=relaxed/simple;
	bh=faU/EzuJKx1pGmHWPlC01rv8XFUn/HO2024c+GaIT+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGMEqncL2Obd5ByYlVwx0eOVstNlqo1cwc8ZN5/gsjjIufj12nLvjDc37UmANQmEGxUOMmCk6gLBW5S8JXpwgLzpKlesQ5MFEGYGxcfynHgCboIxdKSphDXSYVGNiNsSwofJSdzCh3l+xNRdXjhVcAHyEhTWv7R2reaPzektbho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/85RZVd; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/85RZVd"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-844cd85f5ebso1095881539f.3
        for <git@vger.kernel.org>; Sat, 04 Jan 2025 10:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736016896; x=1736621696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aun7ATzaFfOL6KEHuCUzIQH7L6mSP/WYI7ZlJPBZW1E=;
        b=B/85RZVd7eAp5t8gAXjFT/A9zeMXUSsrDKbFtCmtyUxPPSOgBy/T600vmtLicKvmaT
         NTlL4MelZVFLRl5lVnuHnuRdhw43AB3MjlwdeNADBUZf86cN8fsMeeJ8T1ZCIJns42Wa
         bW+3eNyRl8FOtnHYCkIPyxgrjhvbpzOu+9uvfdHH3WgK4t73WSsRDLvT55KuasBFe+Il
         Dnlv82zC7ZdNmWU0bqAHPL0VZASt6Y4kXHZ46xRUwh9y1qV4MtzOD6Q6eVdWk5xqryq/
         V4x3xFVJ9gAwHXiKZIIczxp67+fGAr9AFmbBQC48a7ixPxKLe2aRFS/RngwFLSOk9nTd
         cyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736016896; x=1736621696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aun7ATzaFfOL6KEHuCUzIQH7L6mSP/WYI7ZlJPBZW1E=;
        b=STtxDSNyP1bjtz5e/63lOHvQUFG0aqvIpnAgeExGt9goZpisL+jDtEN4iDzrjC5kck
         hKX1RT3YWMhOeFGU2TFZcxp8D+a2uoLPTrRXdoQoCdmWsQRyDFEERKHrmFLQsx5oG7gE
         1oWHvhAWcFUzZQi3fJ+wORuH/ndN1w6fd/7v5N36vlOpCiSYavGgrOiRMPfn6j474KOC
         d8hU+l3kJwQaJfn+f9CVv9oR/TtqdpUTJ0BbKDYAkBu6FYVs8ZD/wQf6lgt+peaUjkza
         uCIp166wO2F5FIBO7LOSPaNQVIdoFHIc5ecuQ/qtyFGvULunh8HkLV8a0q4Mh4OvRJtW
         vgSA==
X-Forwarded-Encrypted: i=1; AJvYcCWAiVNTTnzJwdX8XA1OQANDvsNvOAa1Gt6sHQI8C5yOPqAvMc8bLHPg2fwOO5NI7vJCr2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7b+9jS1Jm/9phQxRXaapCF9EZC52lwEzpQBENSNrJ/HwlLdb
	fqyOnlN1Cwb+aWDFWQJyPn6gd2dBEbVyNduYoVzN1XGa3loc6fBelJwZ8tCawtAROtqTBZMecFE
	Gj/piHTnEUu0XiLGI1A2ZV2ZMqqE=
X-Gm-Gg: ASbGnctySDLETvK/sGZPYyvNscuPIW4tQzihUenVbgauxfchxUv+YMuw9LoJu9mb2qt
	b6/qy0L3NdvzJmt2mrR+yDYKIbeFDzAz32YEwx76aN1s1dSVazhgKjlGjXg99xpXI5v86g80=
X-Google-Smtp-Source: AGHT+IGqdOEI5otdvUD9KQ8QeK5GCnexZTu6FCoxkzD5GoYYLUqe0CqkWwZziJA21PFq4/noo8UsU+O7uHMTOoFwDQk=
X-Received: by 2002:a05:6e02:12cb:b0:3a7:4826:b057 with SMTP id
 e9e14a558f8ab-3c2d591996emr470604675ab.21.1736016895700; Sat, 04 Jan 2025
 10:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
 <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com> <13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
 <xmqq34hy4hii.fsf@gitster.g>
In-Reply-To: <xmqq34hy4hii.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 4 Jan 2025 10:54:44 -0800
Message-ID: <CABPp-BHACrtkMJAKpOsPw5bw8Fvnhe_wFLMNntsPifmg8yomfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] object-name: fix resolution of object names
 containing curly braces
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:26=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >       for (cp =3D name, bracket_depth =3D 0; *cp; cp++) {
> > -             if (*cp =3D=3D '{')
> > +             if (*(cp+1) =3D=3D '{' && (*cp =3D=3D '@' || *cp =3D=3D '=
^')) {
> > +                     cp++;
> >                       bracket_depth++;
>
> Checking cp[1] before even knowing if cp[0] is the end of the string
> (hence cp[1] is an out of bounds access) smells fishy.

We checked *cp in the loop already, so we know cp[0] !=3D '\0'.
Combined with the fact that this is a NUL-terminated string, we
therefore also know that cp[1] is not an out-of-bounds access.

> If it were
> something like ...
>
>         if (cp[0] && strchr("@^", cp[0]) && cp[1] =3D=3D '{')

Since we know cp[0] !=3D '\0' already, couldn't this be simplified to

    if (strchr("@^", *cp) && cp[1] =3D=3D '{')

?

I do like this form better though, yes.

> ... it may be a bit more palatable, perhaps?  At least writing it
> this way we can easily scale when we find the third character we
> need to special case, hopefully, but again, I do prefer if we can
> find a solution that does not have such an intimate knowledge about
> "@^", which I just failed to do here X-<.

Yeah, I have failed to come up with an alternative as well.  If I and
others can't come up with something better in a few days, I'll
resubmit with the above change and a comment in the commit message
that we'd prefer something better but were unable to come up with
anything.
