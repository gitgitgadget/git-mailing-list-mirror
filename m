Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDA7417BCE
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557449; cv=none; b=UvgJU2fl1JvDnxrT3Ow/xDKdcuZxU4Pic2sOVDIWoXtGFCU+/Oq5Afia3og+Z4eDadr5nhqUU4hMrgwc1X06hx8hLG5ZxRY2oo6qLZ2TWb3ZGZb1ZYX+DCE36JhO6LBY1wVJRmXjtwXI5PqUApUAGqdSqkgDSk294meSWeal1y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557449; c=relaxed/simple;
	bh=oNRYZntGHCYKq3M+4Xv5VsBTJwMvmmPM8s1R/eeOY5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QAEEE60h+emTcgGvB2LDRvSD7VHvwI0dmrsYcy1BRQ7S/vSKo+4TObEDqyoWQTjENmyXxx3YzbRH+fKF/2bLdaBV4NS3+R2zct0vlscWz1qmQ7amyjNYq1W9A+eH7IVUFn1XXkqJgIJAdfdVODcLoghzapeBflnKWYYxgjKOFNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Lt2Ba/A2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Lt2Ba/A2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1784557445; x=1785162245;
	i=johannes.schindelin@gmx.de;
	bh=ULx/pTy1b6HecM+VB7tQJyFyfmrBbknPi0dESyONKos=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Lt2Ba/A2VaOJMm86agDzHnJQfxBfm0SpdktA1+7LXyY2/rIXyntkeChBHA+fvz9Y
	 +F1wmzcZZu3A90U8y3WZSzufTBRcEq1qGm7wTMqZCOTN71q1swKluVYcTr3Xivjer
	 I26Eyn2iOO49z+AauMB/qur5jvvsAAU4sA9nKdZmqA1kiNiRBrsS/wpk/CQEgV0dV
	 hLT75AQVwo6S3FzM2H6dpkdjbk7TwYi8nbq22d8tgUcnqasCiknlDQlYCFP9u4pll
	 kgbejMrUITo6YQcDOP5Fu6hWW8/XCwLzLi54viEMTXxRlM26Jni4l14bTIfWn26CY
	 YBCH8XnUCzgCbrs9Ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MV67o-1wbOoE3cG6-00M5Py; Mon, 20
 Jul 2026 16:24:05 +0200
Date: Mon, 20 Jul 2026 16:24:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
    Derrick Stolee <stolee@gmail.com>, 
    Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <alR9GDNTbdjWB4dq@szeder.dev>
Message-ID: <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de>
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im> <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im> <alR9GDNTbdjWB4dq@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=83233283802565341784557444328980
X-Provags-ID: V03:K1:mePy8pNHgIyHDRyrgKmpcq9GHVuLDyjS/6g6YCQqHgEsW0o0ZUu
 fK9OtFZcjYUvM0T3ECI9qBHq6cVxSIjeMaUaociqdbJYClqATOcJfjpY0rXW49V2BdvV7/T
 XVX5jBzE9rxUyeg2I/QguOm2pXxO4BuTCk60YIOa/A/Ej0Ngq0AcAgVxMn8ANiQEb0Kx40r
 wP8GZde9DSimHaimR7HJw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:axAFlB9rUJ0=;l3bayyiGxb/cXOX9j7dPQf5sY4U
 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
 fLOCPPdGHsfnz2pFpK1GTSdndFi28P

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--83233283802565341784557444328980
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Mon, 13 Jul 2026, SZEDER G=C3=A1bor wrote:

> On Wed, Jul 01, 2026 at 08:59:27AM +0200, Patrick Steinhardt wrote:
> > This move does not come for free though:
> >=20
> >   - The mass rename introduces a cutoff point in the history of every
> >     moved file, as tools like git-log(1) do not follow renames by
> >     default.
> >=20
> >   - Any in-flight or not-yet-submitted topic that touches the moved
> >     files will have to be rebased, and backporting fixes across the
> >     boundary becomes more cumbersome as a patch can no longer apply
> >     cleanly to both the old and the new layout.
> >=20
> > My own (obviously subjective and biased) take is that the tradeoff is
> > worth it, as these issues are a one-time cost while the benefits to
> > discoverability will be permanent.
>=20
> It is not a one-time cost, but will be an ongoing burden.

It is maybe drawn-out, but it is a one-time cost. It's not like we're
going to mass-rename source files to move them to `lib/` every two weeks
from now on.

And this statement neglects to acknowledge that the lack of clean
organization of source code files is an ongoing burden _right now_, and
would be at least partially addressed by the move.

> > Furthermore, especially the first downside is a limitation in Git
> > itself. We're not the first or last project to do such a mass rename. =
So
> > if our provided tools are insufficient, then we should improve them to
> > make the experience better for other projects, as well. Subjecting
> > ourselves to the same pain may even give us more incentive to eventual=
ly
> > improve rename following for everyone.
>=20
> I'm uncertain how that should work, and rather sceptical that it would
> work at all.

I am painfully reminded of all the arguments against migrating certain
repositories to Git. They sounded exactly like this.

> Some have expressed that it is a pain to deal with the fallout of this
> patch.  Should we then come up with those envisioned improvements,
> whatever they might be?  I'm fairly certain that I won't have the time
> for that.  Or should you do those improvements, because, after all,
> you thrust upon us this churn?  Then it would certainly be better to
> come up with those improvements first...
>=20
> Overall, I remain unconvinced, and maintain that this just trades one
> annoyance for the other, and it's not worth it.

In case anyone was waiting for differing opinion, for a vote in favor of a
better structure of Git's source code, and of equipping the Git project
itself with the all-too-common need for improved support for following
mass-renames/moves across criss-cross merges, I am happy to provide.

Ciao,
Johannes

--83233283802565341784557444328980--
