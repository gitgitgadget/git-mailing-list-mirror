Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD61422C6
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405098; cv=none; b=Xd1TFp+hVXBinejqv2lvIKNrJfUpwNjBq1TTd1F/wQTQCxfIa+ArIOERQeuih85tJ2gv1oBaREF2PvElEaW3hYLpra3E0tbSVzXx15ioe7XTnqVQip20/DRHd+NCWBYDWHPKuLsqufqYDFqLkY5XbpHC4UIuMEBP2fR88F79Zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405098; c=relaxed/simple;
	bh=SYi0mmyifcsbe2cBlzJam4aAuZUyOZVS/SAIjl1w3pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8CLRHnS93UCTcg3NjEEdHIIOJlt3tfRCngi0mezQlF6AmKhkfDeLXA4EYDuOIGMDdd87jMkDYItX9qAVcqHxdDI4f0+L88dBjjOI+lXGHA5EiHOymdObOF2UxlvcotM/1Yt8HRghXmaBrfbDaT56KMYWSUeNqSGNO4MCzMOqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c9cc681ee4so2650113b6e.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 12:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716405095; x=1717009895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3YmbXk1U2BO+AmAGNC8WsoFSyKBHrjicOxrNxgtsF8=;
        b=a3xWlOl1hVeZr8fEe089JOC1b935mGokm/C9fo3AMOiMxDDHjpfcl6ztSJgzQFoZZ0
         NbgoTqodo8mV8VTIqfIOv6nHVpKZH+v1sY/EnyRhhxysidOsAa9992+yrLZk6y7W/dff
         RfjRPKMnuhzn1+LPCm8I9Gk1/Won9HCck5KGwsui8LSMSQ/mVvGFKS2MyN0YIV1EiHqO
         Fb85v81NnNAByttaZKlxEKputtlrV3I6xV1Ky/lbaBgaR1UDknRuk6MsFG4utF63SMe4
         bzSYqwD2KDLLDXxc8pJI05r9oLY38fH506CB3UNCF4V246LQQvhGOrqcYmcZpUCynVUA
         ertw==
X-Forwarded-Encrypted: i=1; AJvYcCUCfQ8xW0bVjGO3njABGihuBERcFnN5SZQuw1T5VOrNaI3eOHLIvFgVFTU7XulGK4SOTA9uR5TmUN5CuKIAN3sMnmJ3
X-Gm-Message-State: AOJu0Yw2uoZh0Vo/R/4rSdBX9X6vwckTY4ZDz06Oc7gsNR8W2DnI99F4
	8QQblwYXV0hZLMhnjEN90dtpAak3NXprEsY5/BEgXcSs6lXeFqcnBCcT3d9lrUH1dfutmWtAgMH
	CheNdODVjEEKjS/t1yIiHbiRFgQ76B0Mo
X-Google-Smtp-Source: AGHT+IFRIjT3NXysyTMYx2Bd1NQXzbtBvLd27Eb+SykPsoavOVxV9rkVb1pEFpymLgtRzEy3pAZdOvINq68yjPcjauA=
X-Received: by 2002:a05:6808:10c7:b0:3c9:93f1:c787 with SMTP id
 5614622812f47-3cdb1cda151mr4094491b6e.3.1716405095250; Wed, 22 May 2024
 12:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520111109.99882-1-glaubitz@physik.fu-berlin.de>
 <20240520190131.94904-1-ericsunshine@charter.net> <20240520190131.94904-3-ericsunshine@charter.net>
 <m4xqop5u2a4okzr2svg7j57ey5x5fyfqrqitwwzhh4uansuu7v@uy4tznnci6dy>
 <d655399efccfa6219cd982035c0408f9f084e344.camel@physik.fu-berlin.de>
 <CAPig+cTfqk+tbTAVyPj8YP1uHx1D1swL84h-4p6OKBV=dDRX_Q@mail.gmail.com> <xmqqh6ep4qoy.fsf@gitster.g>
In-Reply-To: <xmqqh6ep4qoy.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 22 May 2024 15:11:23 -0400
Message-ID: <CAPig+cTxMTAf85Gyi5eEYAM4pOTq2UTD1=oCVBy1q8aSF3cn6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] chainlint.pl: fix incorrect CPU count on Linux SPARC
To: Junio C Hamano <gitster@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	=?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>, 
	Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> > > "CPUnn:" in /proc/cpuinfo instead of the usual "processor NN:".
> >> >
> >> > not sure if worth a reroll, but the "usual" syntax is "processor  : =
NN"
> > ...
> > Inclusion of the word "usual" is such a minor flaw in the commit
> > message that I doubt it warrants a reroll and the associated cost on
> > reviewers and on the maintainer (Junio), especially since it does not
> > negatively impact the intent conveyed by the commit messages nor the
> > correctness of the actual patch.
> >
> > As such, I'm not worried about it. Whether Junio reads this and wants
> > to correct it in his tree is up to him, of course.
>
> I think "usual" is not what was pointed out. The order between the
> colon and NN is.

Yes, I understood that, but it is the word "usual" which makes the
text "processor NN:" questionable since "processor NN:" is not
typical. Without the word "usual", stating "processor NN:" is not
especially problematic since the existing regex (which is being
changed by this patch) _does_ match "processor NN:" (among others such
as "processor:").

If we want to be more accurate, better wording might be:

    On SPARC systems running Linux, individual processors are denoted
    with "CPUnn:" in /proc/cpuinfo, however, the regexp in ncores()
    matches only "processor:" or "processor NN:". As a result, no
    processors are found on SPARC. Address this shortcoming by
    extending the regexp to also match lines with "CPUnn:".

but I doubt it is worth a reroll.
