Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445B2DF128
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508635; cv=pass; b=fzoBs+veJ95tisvzrPPTCom8Cq6PYFSP1IDZFPcUscdE3Djo9/0X3I1YFWrI7k9ZwiiaIsZgIiGBfez04hsYLZYOs/QMN6lVpmYWF8v+LwRA/WhWZmNKuJXc7b4xmy3ylwglbSy9IhK6wQAxJU6GD3LT/BLsu+acRd9BM3XAexs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508635; c=relaxed/simple;
	bh=qWI57nZUPEWzI5ypuKWRc2X+yfwKWGvuf07KTGgwkvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1tqbxD1P4nebdTLZSntdW4RTfxlWpoX6dXb9FYaUQ1IE2r2Vrxca0ILmfiFk50VS6T69p9EX+Mq+1uPWu2lkmEw/V9P+m/7rkoCQRDM5XBwBAs9kQx1qnwF2o33ufzRA2qR0Kg9MErk4DfvcB5ZpK3VhoESq/Zc1heniS3Ppsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Raat40Dd; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Raat40Dd"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dcdc955a1so334715a12.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:43:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771508634; cv=none;
        d=google.com; s=arc-20240605;
        b=N+5F4XW9QQgajvOw5NuzblvZ9v1BSgNFV3ZmQDUSOUw6Ns2XE3UJRTmEC8gAW+eEXY
         uzXEU8/S+kGTVGMOGsUi7UwupbrkFE6dPJRE9+qbC0IcHCBTFnBpRL7A6ejmaWof+p3O
         EsujStZ1etDalS9DgZJTKA1xmtlMUj9/tdwHI5ny7vaQwLQdrtcOl918cifkLiMkzMe+
         ouTvCmMejJGMFC9ExRfw070dTfRvC5x7bTmjQpnC6HqReGRhXdyOsYM2X9sWu8tWdN2O
         /bZwLHnPY5XJ7RFOMi6vgtk63Kc7KLtqBB404TFKpPoA6wFt0133BlIYjU/0rrgJRc9d
         fDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV0t+FQb2ToQgTzg+v5EGmCVeqWTxkipHQM3I2LykGs=;
        fh=H4pakTtv8qOzKIZOV7fagyl+3G3RXHNGpHk8w47Sabs=;
        b=T0m+GnA+PQeVzHEfMSI6Ye4RAZlSpDj3bYk31FPiSgGD3vrIWmwYOoMSAW+ufu/emr
         B6zMm8AGZTN990CPsSuaoChqqHuYDuAmghAFz3kGqZ0kL2tT3x0oajZ0SXZUPQ55oEO8
         aF1qlnjeAAybSYpAG9JRovYLeDnkvkBw4VGowaWowBhObt0lSpw9yTOAhJNmpnX2KyPR
         HGZC/PgHHz+yIbl3OlYTSQh6O2xAlf0IF973TVQb0Jqswe/YBVui6FiaOoKD0XRAoZdX
         3LItxwgubtgiTvPdNE4X861Z8jlBpQ+W1ecsM1YXN0ZIG6Y+qCT2wGWIsMb64CYwI8N3
         MXXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771508634; x=1772113434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV0t+FQb2ToQgTzg+v5EGmCVeqWTxkipHQM3I2LykGs=;
        b=Raat40Dd+xFhySMfNy9g+smjqzWAnQO1Kjome+1IgHEK/ytelGwyI0XOb1ZitXF/+T
         edDh5rmgK0Tu6EAmEictTxKbMIP3CLvXMROaev0NENu7xPw8AFSRv9w6xnXj2nNh8TwE
         O4OYXoz7xuT9HkGyA8xEKGiEotxPxwwL9nlMdlU7nJUn4C17Ex7pR+qyM7/Siwwv7gwT
         m8FI1VLm6nOi5rfGR2oOONA+14b1iC+LhVfzsCIgk9UPGKGBIKkNkbol6jBp0VPxUcC6
         vrKN2mGbBVrX6XY7qP/+ioG0h0b5G+dmhPSl71QIiHYv7YUtrrJXcxOcu9mnAKpoov1k
         4E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508634; x=1772113434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV0t+FQb2ToQgTzg+v5EGmCVeqWTxkipHQM3I2LykGs=;
        b=n39LqEXzhYIaoddWO1zO2NKwDbbp+viHFtccg+F9Wy3xZz3CZqJuRJWlbW0bsbqoiL
         0oTc0WYKtGXcuq03GVTLI4Ok/BYJa3RaI9sEDoTgPTFbPreaPtBMCI32qq2r3aAExBQE
         jaQnLejkoJScVFeByq2U58VSLXHlbc6o2EBfEWqEz18YmgrBXKDHFvu6U3mL7c6aWOX0
         ZoKJfrBAZFmM+tFjA4Bxwz3PrzEPAJbcW1mrU+9BQmQU7uldoFf86j5mx5xse+fr8irL
         mYBWpVLfZewB7Fp9dlslR4M6qPNPHQ28GPuw41vYARkpBaL+eSYxN3Ws77JZCtoCj9Rw
         5g/w==
X-Forwarded-Encrypted: i=1; AJvYcCXS9zXVWy+s8i9qga0y2AnOXWFToB9pohjbFREK8wqMnRs6wpb2nylWHDsCRoDEUoHC7JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS8ZrAS921FgpLRW5ZpCSR7kMDKMvYmG5zE6KAOZadDAWdRrOZ
	Hm/KObQebNkhCkhAbacjMkXhxcjHg6U+wIwIpCsRQ6dFRZCMub41SRN3rH2LKNVL3B/j4v3x8ob
	3EplWb4B9Uh0ftCfH3i8vlLGefqiD6dY=
X-Gm-Gg: AZuq6aLTioq8AOLM2EPDVOuIl1BvS91kKuzj3LYS09J315e4j6k4n18yxwxO64vR4vP
	ucm7tgKxtcfFXim1WLZPZXxNW6wTLhrZHOCcoQG4hx4KmH/wz7mHSWpSQbLSdSfzBiNM6/ndJi/
	yDSXdq+hsA1bz/Engtpm3kNyJnUatlQJ1rDml0wF6hkTjdF2dGptcNMJlPo1S9atxcM1FXeM2zm
	NCAnxZDA86Yaksy9UTjwPPEeqSUm6cvNQOy8J8msubu+AwGHfgahz6LmrtKChG5G1pixgUq9qqX
	aQWxHGCpMnZwESMwyyVxxJqoDRbCBimyhOAlASBwSem+x9PfWttgXKvGGnd9sUjZdkwrIZQQjpN
	ZTbPq
X-Received: by 2002:a17:90b:1d0c:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-358937a4bdcmr2857115a91.24.1771508633704; Thu, 19 Feb 2026
 05:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZAMr6XOwKkTa55q@exploit> <20260216152730.37478-1-mroik@delayed.space>
 <aZQJEDyUyMv4_c1l@pks.im> <20260217063400.GA101988@coredump.intra.peff.net>
 <CALnO6CD6c36ur4cxqNAB=Jy=m6yxVfoSzAAekewQZr2vjjKn2w@mail.gmail.com> <20260219112918.GB3529@coredump.intra.peff.net>
In-Reply-To: <20260219112918.GB3529@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 19 Feb 2026 08:43:42 -0500
X-Gm-Features: AaiRm53XyKmHIy0fYlstQxNXX41l31Lmwds_jvlep5rXxv47tMu2hGIeiwexj5Y
Message-ID: <CALnO6CAszmGM7uA5zJXaUkK4PMnyQGeWWBk+OwDU=AfDh4GbPA@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: fix From header in cover letter
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Mirko Faina <mroik@delayed.space>, Junio C Hamano <gitster@pobox.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 6:29=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 17, 2026 at 08:21:32AM -0500, D. Ben Knoble wrote:
>
> > > I think that wording comes from me back in 2013, and I just never gav=
e
> > > any thought to cover-letter generation by format-patch itself. I neve=
r
> > > use it (and I probably forgot it even existed, given that most people
> > > would use send-email's cover letter generation, and I do my own thing
> > > with mutt).
> >
> > Funny: the send-email manual's main mention of cover letters apart
> > from setting Cc/To fields is in an example=E2=80=A6
> >
> >            $ git format-patch --cover-letter -M origin/master -o outgoi=
ng/
> >            $ edit outgoing/0000-*
> >            $ git send-email outgoing/*
> >
> > =E2=80=A6using format-patch! (Which is how I generate cover letters, an=
d
> > probably part of why.)
>
> I think I may be showing my clueless-ness about send-email here. I
> thought it had its own cover-letter code, but looking at it briefly, I
> may just be wrong. I don't see any code, so I guess people generate the
> cover-letter independently with format-patch.

Yeah, maybe=E2=80=94send-email takes format-patch options, so send-email
--cover--letter should also work?

> Maybe nobody noticed because most people do not use "--from=3D<foo>" with
> a <foo> that does not match the committer ident in the first place. I'm
> not really sure why you'd want the two to differ. Which makes me wonder
> why I added that feature in the first place (as opposed to just "--from"
> with no options).
>
> Mysteries of the cosmos, I guess.
>
> -Peff

:shrug: :)

--=20
D. Ben Knoble
