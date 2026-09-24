Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311934751B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790279757; cv=none; b=pLNw/0qFT6Er6umDoC+eb4/jnpCTilL+uJm1uStj/80b7JCzyPU3P9ktHe9o/2+LE8ywjrjiLkDjlcPNszoEiWQGeXWcLllJHCGo3SKF8KonrpeCGVnIlryOQL+q3RKHHwu2KAj//PRPwDrDkCs6ZH/yNlsDuXNItD/56Nh3Des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790279757; c=relaxed/simple;
	bh=BLGZf3xaAUGVzJNCSnzJx0gH8/BrLjOegcR6TO3TTHc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QtPwjzETzAUFphLNtTIvTvc7Glnp/DlU05jGGSV5BgdNjlLKrdikxJeRLtoahZ7dAABB8Zyzx7fbB+mT6yTmq+C0efRZ3idzz8yLvd2/S43iDoJmrXYTDYAqyEDFjHRXSHhTNsvZ9RRwP79tUTc/0hrYfOhW/cZl2cuYaXe/2nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VCRwwnYE; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VCRwwnYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790279753; x=1790884553;
	i=johannes.schindelin@gmx.de;
	bh=o2dCoL1ydcMaxg6bzWoDEaUHc7rvJ3ZBNZYDXqhiDXc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VCRwwnYEt4IQTw7mHF/wrdaDeRKwDVhX06eJa3GdvEN/V9TBnHyyLLjlDBoD/a73
	 0Mfwqvuk7goznyNArU8bMb0LY+cR3O88GQvQ60ncWfZcbWz2FPrbWy691aMiDOTG3
	 O/4m+gHh7kD1Bcq4+d2NW1dMh4k/PQFq0aSiy/LdTicqXHetEwDxn6LYV0VZUVXzT
	 Vg29DftzectZT2njbXeReEOMfZjbKr1zvBb+jNUvQDStkjSKezc5Sy3+NO1OcTg8z
	 ZNtaA8TMr9izDO0Ukvn8yRtUmp03OzWZLb06/rN1cLicazGwW1sdUtlpwBIO9mNeV
	 re46bh7nY4SJ6jhgGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5UD-1wvrjC0dyJ-00DocH; Thu, 24
 Sep 2026 21:55:53 +0200
Date: Thu, 24 Sep 2026 21:55:53 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 3/4] ci(gitlab,windows): fix Rust setup for GitLab's
 MinGW build
In-Reply-To: <arUH2KM2rHQwhmpf@pks.im>
Message-ID: <1c829af9-1923-a6ff-78a1-b738cc6bf5a6@gmx.de>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com> <57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com> <arUH2KM2rHQwhmpf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:ktXY1nTinjZCzLAbJYSARO9zFrf64miqz3S4maGo4iaYOdP/J1+
 ZbX1YY8SS9iQLpN/wDahgGYoIX7g3SmSsYAMkdWtjg8LdVzHQvkFE6gCz0ULhD80odaeybK
 TyKbvgRkXYj6G9r3Ecci3fu3IvWEh8RZnhozlQANSgabuG++fCGrPPO4iX4AFSTWMwZb4Us
 04/vaFQFjufG+xOhaG9Pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KO/ZKXOt3xY=;rCeYWRruXTnSN8ppNotuj/yObxL
 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
 hai/MnMOS0U+AUCsXsvy796CCw==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 24 Sep 2026, Patrick Steinhardt wrote:

> On Sat, Sep 19, 2026 at 12:12:12PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index cd6fd4a504..3f24835500 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -133,8 +133,11 @@ build:mingw64:
> >    before_script:
> >      - *windows_before_script
> >      - ./ci/install-sdk.ps1 -directory "git-sdk"
> > +    - ./ci/install-dependencies.ps1 -Mingw
>=20
> I wonder whether it would now make sense to also hoist "install-sdk.ps1"
> into "install-dependencies.ps1" now.

Honestly, I wouldn't. It is conceptually a different thing, the SDK brings
a ready-configured environment (which _partially_ ships dependencies,
that's right, but it's a Venn diagram, not a strict super set
relationship).

> >    script:
> > -    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artif=
acts'
> > +    # The minimal SDK's profile resets PATH.
> > +    - git-sdk/usr/bin/bash.exe -l -c
> > +        'PATH=3D$PATH:/c/Rust/bin ci/make-test-artifacts.sh artifacts=
'
>=20
> Are we sure that PATH cannot ever contain spaces or should we rather
> quote here?

Ah, quoting in shell, what a wonderfully magical world. While you would be
correct that passing an unquoted `$PATH` as an _argument_ would cause
unwanted misinterpretation as multiple arguments instead of a single one,
_assigning variables_ is a completely different issue. Observe:

  $ x=3D"Patrick Steinhardt"; x=3D$x=3Dhello env | grep ^x=3D
  x=3DPatrick Steinhardt=3Dhello

Wha...? It did _not_ split the $x at whitespace? No. In what must have
occurred as quite logical to the inventors of the Unix shell syntax,
interpolating unquoted variables in assignments does *not* split at
whitespace, unlike in other instances where unquoted variables are very
much split at whitespace.

Ciao,
Johannes
