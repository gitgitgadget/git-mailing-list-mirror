Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BF1A3166
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767734174; cv=none; b=XDG82+Y44zg6BKeioAR9Gm7+Pmk3f4Z8hL8cepmTIUUq7u/PKnoO5SG6y6/NR2EkdTydK6ogGB8lPzQBBGzltfI+ZTHVGVz3wLMLJcOu3MhvnF4xCSIAerBbz+cghIgVhqIrXpQjXvbercqpR5Kjgl7SftyjQbYciTSHishGeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767734174; c=relaxed/simple;
	bh=vRMULUDlX/PAhUjA7oOou2HafAIOn2b1DJmm7w048wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgGfB90mDDiy65yok8GRsMcy+zEGKX4nxVDxvcN3AjBKuCR/6lAKZ3DND0ST6rkV7gR/OpOAh/0soddhj6H+lU/JqP5bsa46Fb/SJb8IuKpK5C1Xh68B+cGgC09d89fl0BUUSZJXSCEp/tDWTCCdpDCjn1m5cOnOQabjGx+Yjuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz; spf=pass smtp.mailfrom=michael.lyo.nz; dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b=iq9zuo1M; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michael.lyo.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=michael.lyo.nz header.i=@michael.lyo.nz header.b="iq9zuo1M"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dm3qp05cvz9vNQ;
	Tue,  6 Jan 2026 22:16:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=michael.lyo.nz;
	s=MBO0001; t=1767734166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vUVrdw2vEuOnIEXVvm4BMUn/LWiPOew7OfaWUgoVEA=;
	b=iq9zuo1MYx8Y6zB4eEjWRJl+yZTPHLnoX1RbtYIeApamqMPb+tc2gcxcajSZMt+ZoZTQRN
	DcnOPxaBAKwr85AYPLmwGVXUyzro7xrlxs15TWSQi1aO/s5FjwINCzbou+DJPWEURVQvC7
	hpJ3lod7wAphRZgloLwn0sSUfnWvnpKtiu2vtan8DtPOZiupJc80tc2gJEMlTnzcWz1Skt
	J07gbG5QLeZynRNnAD+6BUrkY463w9OtxCFIlEltl9R7bn8bo0etp7JTKILaK6VoTk4Ojv
	0sdaE2w81yVbclwmgCZ47CrHRCALC7VNq5t19vZAoD+SAdjXEr5zt6ZBvf8yAA==
From: Michael Lyons <git@michael.lyo.nz>
To: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <avila.jn@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH] doc: git-blame: convert blame to new doc format
Date: Tue, 06 Jan 2026 16:16:02 -0500
Message-ID: <9123496.T7Z3S40VBb@debian-mbp>
In-Reply-To: <7894506.EvYhyI6sBW@piment-oiseau>
References:
 <20260105230220.519303-1-git@michael.lyo.nz>
 <7894506.EvYhyI6sBW@piment-oiseau>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, January 6, 2026 1:57:27=E2=80=AFPM Eastern Standard Time you wr=
ote:
> Thanks for helping out.

Glad to!

> > --L <start>,<end>::
> > --L :<funcname>::
> > -	Annotate only the line range given by '<start>,<end>',
> > -	or by the function name regex '<funcname>'.
> > +`-L <start>,<end>`::
> > +`-L :<funcname>`::
> > +	Annotate only the line range given by _<start>,<end>_,
>=20
> It would be better to use backticks, so that the comma is formatted as a
> keyword: `<start>,<end>`

Okay. I changed them back and forth a couple times before the first submiss=
ion.=20
I have a question about this further down...

> >=20
> > --S <revs-file>::
> > -	Use revisions from revs-file instead of calling linkgit:git-rev-
> > +`-S <revs-file>`::
> > +	Use revisions from _revs-file_ instead of calling linkgit:git-rev-
>=20
> Placeholders keep their brackets: _<rev-file>_ in prose.

Smart.

> > ---reverse <rev>..<rev>::
> > +`--reverse <rev>..<rev>`::
> Here, I would differentiate the names of the two placeholders,
> <start>..<end> as used below.
>=20
> >  	Walk history forward instead of backward. Instead of showing
> >  	the revision in which a line appeared, this shows the last
> >  	revision in which a line has existed. This requires a range of
> >=20
> > -	revision like START..END where the path to blame exists in
> > -	START.  `git blame --reverse START` is taken as `git blame
> > +	revision like _START..END_ where the path to blame exists in
> > +	_START_.  `git blame --reverse START` is taken as `git blame
> >=20
> >  	--reverse START..HEAD` for convenience.
>=20
> Here, let's transition to the <placeholder> format: <start>..<end> and so
> on.

This is the continuation of my question on `<start>,<end>`: Do these also g=
o=20
to backticks or keep the underscores? My impulse is backticks, but let me=20
know: `<start>..<end>` or _<start>..<end>_?

The start/end change from rev/rev makes sense.

> > ---progress::
> > ---no-progress::
> > +`--progress`::
> >=20
> > +`--no-progress`::
> >  	Progress status is reported on the standard error stream
> >  	by default when it is attached to a terminal. This flag
> >  	enables progress reporting even if not attached to a
> >  	terminal. Can't use `--progress` together with `--porcelain`
> >  	or `--incremental`.
>=20
> Here maybe swap the first two sentences, remove the "This flags" and conv=
ert
> to imperative mood. The first sentence is a bit redundant.
>=20
> As a general rule, I tend to reorder/reword the paragraph to describe the
> effect in the first sentence of the description with an imperative mood.

New commit will reword a couple things here. Fingers crossed. :)

> > -	marked with a '*'. In the porcelain modes, we print 'ignored' and
> > -	'unblamable' on a newline respectively.
> > +	marked with a `*`. In the porcelain modes, we print _ignored_ and
> > +	_unblamable_ on a newline respectively.
>=20
> If the words are printed "verbatim", then the format is backticked:
> `ignored` and `unblamable`.

Another one where I had backticks originally and switched them. I'm not sup=
er-
familiar with the porcelain parts.

> This diff is quite large. If there are no other reasons to split the patch
> according to some semantic reason, then please split file by file.

Okay. Next try will just be blame-options for now.

>=20
> That's very good for a first try. Now, I hope that you will be ok to revi=
ew
> my patches :-)

That's very kind. I'll probably need a couple more rounds before my changes=
=20
pass inspection, let alone be declared competent to review yours. :)

=46or the purposes of re-submission, should I be doing something with sciss=
ors=20
on this thread, or make a new thread?

Thanks again for the help!
ML


