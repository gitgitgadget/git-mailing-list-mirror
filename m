Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42C1BB68C
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956692; cv=none; b=m72Sd9tz88ZqGihhK+Q3zei5UkzItbZCQDvs6/uRJzL9e3Tb1qJzYJr+MuWHjY2c49lP2bW/bVWdqPgEiFkfpYCkHEHNeDB/ehkNl5BhEsFCPJObZAoSHZ3XIKKsVU/121/0o9QKcNs/lTvZqR3du0g11X5UcH/MgjGbXYlqcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956692; c=relaxed/simple;
	bh=6JVAXAm0liN/i3pylQsT10z5mdrzrfe9zM64hxEpVJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPChlzOPPXOBG27wgPMUT4QY10tN9rjLGhwFpbfwketGRb8jU0Vrsq5fGCcQQM35DfwsQPt2dF/anfp/iasyR6jUrwVVodai2CMIDgeYVi8no0IJKjV86CP7FXRgNN+cIYDXj07G9+VxYc6HZ4cWjoY0EaE74yCYieZKEb6LGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a80dc52a41so2163785a.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 11:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956688; x=1725561488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3d8RFVplE7YLSWp7+mP5U+YJKol92BW/+glzTffX/6E=;
        b=osbBxqDAxG4/mq/IhakU/m2PeHHgd52IZWEhsjkuKQle1DzWapsoX2u3uaQYi2j6Rh
         VKzbGL+eBUm67rXBxf+IWCNpx4ZI2ep+o+QbkASKTiTpDelo2/ySi7tetrOSDsEQORWp
         4WmhBqTUD5KL477l7UQFuF0/3jQT0RVvtlX/5sVuH/49HcghrUV/FEe07RpMF9wBhoEm
         L4VxdJ2e16FkZy2DqqAB5L80Gl8VtFOaSXmDTfKqm1gTqyj0USRUAmwdMAXeGLI7y8jy
         bNX0LnbhpRagFxzXDkpC0n2xy+aUR6JK/36SomSjU4JMiuNgY3SeSd9+hZo8KMDa+nBH
         pjcg==
X-Forwarded-Encrypted: i=1; AJvYcCVL22IWQh3xoQLK8iU5l8Lsz6X1IMCY4raqU4KlNZ5XjqmkfDYmM1HWWYbj9xSnFpZiVHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF94XEElmbkKgZzf22FinUY5IQlfte3JQ+2jBes2Ac41itqo3v
	ATK98+2E03Jyenw9PD4htgNZrQrSG0s8v8korqLGZycs6rr5A1CsMzv0Ekkg1pMS/EWMvZQTVBG
	NgIA77pXaMSRl/5xkE10oJdPSoHw=
X-Google-Smtp-Source: AGHT+IGj9ljIqeK+iXLJXVsI8kyE0BGGQ6JypGe4vRdkj3uwpuTiZD8IczDsiVLbfGChsbN1tt7lDdHOBaHGt5+tC2o=
X-Received: by 2002:ad4:5d67:0:b0:6b5:38d4:c9c5 with SMTP id
 6a1803df08f44-6c33e6963aemr23876036d6.4.1724956688372; Thu, 29 Aug 2024
 11:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829091625.41297-1-ericsunshine@charter.net>
 <20240829091625.41297-3-ericsunshine@charter.net> <ZtBHecRkFQkSAF6C@tanuki> <20240829171001.GB405209@coredump.intra.peff.net>
In-Reply-To: <20240829171001.GB405209@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Aug 2024 14:37:57 -0400
Message-ID: <CAPig+cRLeQSP6ybfVwo889kMNi8yvRvwLpHNjn-SpU0qWbe=Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] chainlint: reduce annotation noise-factor
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Eric Sunshine <ericsunshine@charter.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:10=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Thu, Aug 29, 2024 at 12:03:37PM +0200, Patrick Steinhardt wrote:
> > Would become this:
> >
> >     t/chainlint/pipe.actual:8: error: expected ampersands (&&)
> >     7         fish |
> >     8         cow
> >             ^
> >     9
> >
> > While this would be neat, I guess it would also be way more work than
> > the current series you have posted. And whether that work is ultimately
> > really worth it may be another question. Probably not.
>
> I think that output is quite readable. One bonus is that it follows the
> usual "quickfix" format, so there's editor support for jumping to the
> problematic spot.

The "quickfix" notation has more appeal (to me) than the "^"
annotation since it is immediately useful in an editor and doesn't
require extra cogitation. A couple concerns which come to mind are
that it makes the output even more noisy (which could be distracting),
and that the path, if relative, might not correspond to the editor's
"cwd" or to a path in the editor's search list, so the promised "jump
to next problem" automation may not materialize.

> It probably is more verbose if you have multiple errors right next to
> each other (since now we just show the annotated source text). But that
> is going to be relatively rare compared to single mistakes, I'd think.

Maybe. Maybe not. A first-draft test by a newcomer might very well
break the &&-chain in many spots.

Nevertheless, I'm not likely to implement this any time soon (or at all).
