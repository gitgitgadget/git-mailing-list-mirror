Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD412E47
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894969; cv=none; b=YEqIla7OEKMAiHCUxn4HcAAQMRvBVY8+FgjQz0qvmtWHy4kuX2jlwHinq2/BLzv9nCk+tHQz3QAz/GpZQ5+m4xvyHmCY3lClg0jY2SuianBkWfXXpGHn9lqaM27mlIl0h4gtQqw0iS5YZicyHLcByx7kqz6auV3XmEvS1yYJgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894969; c=relaxed/simple;
	bh=jO39zLd6qWWE6Zd0dO3DVLPon6uL/d7mLruDxZDQEKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYRvqknD6nPrTuvQMZMUvis3gGglDesdfc67P/KMhSRFhLdMLE6rLenVEwxZHVrLbZS6eDZ0XoQ6397SenDKYN61FiicXhnIdhzV/d35kKKOo97iDy0XGubUMIWl4KFuL7oLAIO8PuqZo9AOwv5FCKussbhaHTliGk3UrDD3iMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787cb2ef657so47090685a.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 13:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708894966; x=1709499766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpPT54g7B6Cb41tYwDa2xkcAAuzaUiO4LSLJmxuw7Mo=;
        b=RLJU8x3O9zNHrfpsWfQE7cl8tScRC6+vxjBQ1F5LFumJx4U5gsx89OGpZORW+cbtGP
         /UVLS4ZK0KXA+cAKPulmTXzTimCrF0a/kvzstVwS5eZWEvV/p7Vngp3W5jJeWxJ2YVvD
         Yg7SK+jw/XPKUpoMLxbJuhFUiUuKNgLoXOS8Ap0gICP0aP40YAhdKPS1OGwI6j4NY2OU
         G8MgGCPK5PSDHy2Q1ySjZgAtmU7KMHr4aSeFT6UbYF9PNBsLSAg5Eo6wX8DSGdmQQq00
         2n8NouYx/dDKIWsRiOxVZihA7VUIEqpmuA0t6DkmXa2iK4ndLAML3ojK75B52vDtgy6Y
         IaRw==
X-Forwarded-Encrypted: i=1; AJvYcCW1DiQ5nYJ+DS2aJeZGJRzW5AzgmOkqliNy/ex5smXypkwOn03h3Tm8OdZQZ9104LsItAJhRnmjXYeVaP9B4kGNvYLp
X-Gm-Message-State: AOJu0Yz/N60/cxayTJg9gZZapYjNi/eyWBY8Pl+3iMCFw1zn73EduhJ2
	uXn6QkgqjnNjC25AiqvnCyyYx2p8IVI1iN4UY40qybxxx4+los+Gpti42GGbQGL7KamFKbFsbH5
	y2U+lmoEwCL7Mdg6W8XTHlOuLwLw=
X-Google-Smtp-Source: AGHT+IEAPr/0QJoz0n3J1XnAGghrC/ygwzC2+Bia83CI3LHMcXBzgNl7OaUq3J/z0gic9OFmom8peE7uAfGuJTB1KWw=
X-Received: by 2002:a0c:b552:0:b0:68f:6be:9f94 with SMTP id
 w18-20020a0cb552000000b0068f06be9f94mr4689790qvd.12.1708894966159; Sun, 25
 Feb 2024 13:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225112722.89221-1-l.s.r@web.de> <20240225112722.89221-2-l.s.r@web.de>
 <CAPig+cTvs7Ckg=k1T+N3N=yT840xM2DYf3LV9NZhii8+c1nkbw@mail.gmail.com>
 <5dea0535-4b21-483a-a10a-bfa8e9e85650@web.de> <CAPig+cThAYjf4DU40dY9jCnjL0FsVpYFhcsj9YdvW2Q=c=ZDBg@mail.gmail.com>
 <20240225210038.GA3368483@coredump.intra.peff.net>
In-Reply-To: <20240225210038.GA3368483@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 25 Feb 2024 16:02:35 -0500
Message-ID: <CAPig+cRtXHJL76ZUg8bqwpVa48-rOOxB8wNrSDJwJkQyfUYDTg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t-ctype: allow NUL anywhere in the specification string
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, Josh Steadmon <steadmon@google.com>, 
	Achu Luma <ach.lumap@gmail.com>, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 4:00=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Sun, Feb 25, 2024 at 01:41:30PM -0500, Eric Sunshine wrote:
> > On Sun, Feb 25, 2024 at 1:28=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de=
> wrote:
> > > Am 25.02.24 um 19:05 schrieb Eric Sunshine:
> > > > Taking into consideration the commit message warning about string
> > > > constants, would it make sense to update the comment to mention tha=
t
> > > > limitation?
> > >
> > > I think the temptation to pass a string pointer is low -- if only
> > > because there aren't any in this file.  But adding such a warning
> > > can't hurt, so yeah, why not?
> >
> > The patch just posted[1] by SZEDER reminded me that, on this project,
> > we assume that the compiler is smart enough to replace
> > `strlen("string-literal")` with the constant `15`, so rather than
> > worrying about updating comment to mention the sizeof() limitation,
> > you could perhaps just use `strlen(string)` instead of
> > `sizeof(string)-1`?
>
> That would defeat the advertised purpose that we can handle embedded
> NULs, though. Whereas with sizeof(), I think a literal like "foo\0bar"
> would still have length 8.

True. Sorry for the noise.
