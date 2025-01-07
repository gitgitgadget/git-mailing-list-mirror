Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7082156968
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284984; cv=none; b=mNr3TdSTY10QCHwPHBzcoWrmXbvO+ioqZMC3gsiA8Xroj3zOdyiJdzbG1ZWXvro0io8M7/KUgfTiuok2kCwtMBYhSK/APQH6J6yMvjGHqLwclNyk+XhFl74/rqlFeZeC+m6c9vWsc55QApXRpxKK6jtr9cw+EEzN+uAedyJuha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284984; c=relaxed/simple;
	bh=B7pQgoiaKq3nD5d0uNXeRu9M/QyKy6w9HYrNX/Cx29g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyrXoU/PEJBVz6oLHGzjE4Xn1qrv4KD0RFdQur84uaUhLOQwNIMhKLvuGWd1brRXMleZoHwwHcpuZDNP6pBOMddQojxaz1LBUswgLTm+hPPoNq3qaVdL3USTPw9C138uUpZP90dDrnoTCv5525gaQOxb120RwmxzUf2CJA75hYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=qEmAaOV7; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="qEmAaOV7"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:420b:f4aa:dd4f:83c9])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id EAE8E5FFA3;
	Tue,  7 Jan 2025 22:22:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1736284980;
	bh=B7pQgoiaKq3nD5d0uNXeRu9M/QyKy6w9HYrNX/Cx29g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qEmAaOV7Gis1Qkiq/2PwdPs5olyzdNuL/0AfnCCSOadyjBdrbpXo10/2fEn/OWkzv
	 4tSzTs/xtvuq8Xw3NKNlOc4qvI2TqS/xpISDlvbtuMNMexmrZqXYfn+vCLV2h3TuOa
	 9PpJhl7t8+u9EPGeshkqhiDyIFOclusoOMNqKLBXCMQjROe2PYcomUaD1+AQDGNpfI
	 Ar+HxaU3DMQeY1BokcuTqdwemFAWTUpyjM/25sixoQbeQDnLNudmcUXjnZON/9iQ2h
	 wtezGpNXEzkfrgxlA4jMkJy/WG/HnHlLebeykEGkIX4EoICIx3YpQmV+iDNlDxV5UL
	 QvCr+GQFKHohw==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:
 =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget
 <gitgitgadget@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: git-notes.txt: migrate to new documentation format
Date: Tue, 07 Jan 2025 22:22:57 +0100
Message-ID: <3330199.aeNJFYEL58@cayenne>
In-Reply-To: <Z3t_GvqfZL9y-_9p@pks.im>
References:
 <pull.1846.git.1735924216993.gitgitgadget@gmail.com>
 <Z3t_GvqfZL9y-_9p@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 6 January 2025 08:00:01 CET Patrick Steinhardt wrote:
> On Fri, Jan 03, 2025 at 05:10:16PM +0000, Jean-No=EBl Avila via GitGitGad=
get=20
wrote:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > The git-notes manpage files were converted to the new documentation
> > format:
> >=20
> > - switching the synopsis to a synopsis block which will automatically
> >   format placeholders in italics and keywords in monospace
> > - use _<placeholder>_ instead of <placeholder> in the description
> > - use `backticks for keywords and more complex option
> > descriptions`. The new rendering engine will apply synopsis rules to
> > these spans.
>=20
> I think it might be a bit easier to send related changes like this and
> your changes to git-restore(1) in a single patch series going forward.
> It allows the reviewer to bundle related reviews together, which
> requires less context switching. It also allows them to more easily
> refer to similar review feedbacks sent for preceding patches.
>=20

=46or simple manpages, I'll do this from now on.

> Other than that I've got the same comments here regarding the style of
> the commit message as with your git-restore(1) patch. Ah, I also noticed
> that the subject should probably be amended because we don't typically
> specify multiple subsystems with colons. For example:
>=20
>     Documentation: migrate git-restore(1) to new style format
>=20

Will do.

> > diff --git a/Documentation/config/notes.txt b/Documentation/config/note=
s.txt
> > index 43db8e808d7..70859f5c574 100644
> > --- a/Documentation/config/notes.txt
> > +++ b/Documentation/config/notes.txt
> > @@ -26,27 +26,27 @@ globs.
> >  A warning will be issued for refs that do not exist,
> >  but a glob that does not match any refs is silently ignored.
> >  +
> > -This setting can be disabled by the `--no-notes` option to the 'git
> > -log' family of commands, or by the `--notes=3D<ref>` option accepted by
> > +This setting can be disabled by the `--no-notes` option to the `git
> > +log` family of commands, or by the `--notes=3D<ref>` option accepted by
> >  those commands.
>=20
> Should this rather use "to the linkgit:git-log[1] family of commands,
> ..."?
>=20

Nice catch, although not really the primary aim of this patch. Will fix.

> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > index 84022f99d76..02a3495986a 100644
> > --- a/Documentation/git-notes.txt
> > +++ b/Documentation/git-notes.txt
> > @@ -33,34 +33,34 @@ ENVIRONMENT sections below.  If this ref does not=20
exist, it will be
> >  quietly created when it is first needed to store a note.
> > =20
> >  A typical use of notes is to supplement a commit message without
> > -changing the commit itself. Notes can be shown by 'git log' along with
> > +changing the commit itself. Notes can be shown by `git log` along with
> >  the original commit message. To distinguish these notes from the
> >  message stored in the commit object, the notes are indented like the
> > -message, after an unindented line saying "Notes (<refname>):" (or
> > -"Notes:" for `refs/notes/commits`).
> > +message, after an unindented line saying "`Notes (<refname>):`" (or
> > +"`Notes:`" for `refs/notes/commits`).
>=20
> Curious. I'm not familiar with the modern best practices around where to
> apply what kind of quoting, so why is it "`foo`" here and not `"foo"` or
> `foo:`?
>=20

Good question. I usually tend to remove double quotes and replace them by b=
ack=20
quotes when the words are keywords. Here this is a string citation, but I=20
would still prefer to apply the synopsis formatting. Maybe, something light=
er=20
such as "Notes (_<refname>_):", which would just format the placeholder, wo=
uld=20
better fit.

JN



