Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637590;
	b=A6EHC6DEYqlUrxFx+KvIbx4WPoUjv9Vu9vo5up+sedPYuCTidJMQzSst2qTRKD/nAGIq
	 gaSU757iZwG9yjJbFkbPBNAtvi7CIDBkGo4z5YIj79dflz2rF1dg7kCb60As0pVdeAK78
	 PbrSjMuN+DiQInI1fps3Fj+uiaQte1YaRwT7jV7ZlSR3qg+bgmyML6zuZyCIlxk/Zykzm
	 04rs2Fz8w0cy5fvD3zPFl9giZLPogI/Fbxz8zvKmSrH/1l1QxA/UGzBxhDWAdcAd5+ERn
	 4n4miTGGsmzIKmP4iQBjw/EM5PLZKV7pITGBGca2M5hAzewVQFyorzzgAqHsYVlOSgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637590;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FfiCPPqE+4jaD24MllUFtrQkI3W7O/vpr3m3egGQsaw=;
	b=UZ7oJL+mMCeoKDVd5p7w3u4w4TC3CEU+RaMk3RCnZw1uqeLFKlnkh2mSY/QAfF+C2QZy
	 xpXfL5O6Drl86NjgBTHlJhlFdv6FVuENoPm23zT8cT4yXSRLveO/eOLY6CMRp1RXCOsIQ
	 XUbOWb/MTP1IX72bMO6ie02pmzJnwn8iBbuEDEr+gCHQ506/SubWqWY6XdpMZOWfWghVs
	 qxs8rhWlG77g787ZV2cChnEzqd5rSWaah+d9RUcg4OtuDViJSmx176Pi6T7jnegfuk7OA
	 d7KpNy3rOkrh0tY5Mwbe40A3paPTjxSDOIJGoJIf2/Cwbt2PkKniL7XBFJL6WSKd9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=zwq7rhqoangl3e7ax6fuik2c5q.protonmail2 header.b=zanT60Ed;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D884606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D884606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=zwq7rhqoangl3e7ax6fuik2c5q.protonmail2 header.b=zanT60Ed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zwq7rhqoangl3e7ax6fuik2c5q.protonmail2; t=1795637587;
	x=1795896787; bh=FfiCPPqE+4jaD24MllUFtrQkI3W7O/vpr3m3egGQsaw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=zanT60EdXnnbcgaUU0Z6fg632e53ollMF9ObGUIJF31OzSYh4E9LsMv7lYkoBFH+w
	 hXSzZFnLdPY9Sly6u88QbLzpn47fYlSCGImiO3K2b/VudEELp2C+b5zV24CdHuZdMR
	 m+x5Hkjx4Czw0coGFEhCyxwv5w8yt1+XpfhH+E4MggScDGvoPpTyKmF2AWNZMqstSN
	 tcQ8JTJbqNJ+Hy6PEXA3YwoDbUUlTCD5MtLAyhtg286qVMIUK2y+1lLH7Pnm/zVNv4
	 dSyv3V3ipf77OIe4fZz1h1feAZwcxdbhWb2HfVQKTkpOq4TsZHR/h8sCDA7wcRF+2f
	 M3xm+qvqoGBsA==
Date: Wed, 25 Nov 2026 20:13:01 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Julian Maurin <julian.maurin.dev@proton.me>
Cc: Julian Maurin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] remote-curl: honor --no-thin when pushing
Message-ID: <qE2F9rf_tOQLNozkn9xXkfvNYq_9M7ZGhSqCtUJ_Z3n9YMD-3J28upfMF7XE2D2i5YD0XfCckhs1Lb_7nZ1uOPMXzdRJPzmffOuNdvwmX9Q=@proton.me>
In-Reply-To: <xmqqbj7c6bfx.fsf@gitster.g>
References: <pull.2328.git.1795595886592.gitgitgadget@gmail.com> <xmqqbj7c6bfx.fsf@gitster.g>
Feedback-ID: 50061477:user:proton
X-Pm-Message-ID: 308f738d590bcbe577859faad819120804d04d6c
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> Here is my attempt.
>
>     If one pushes from a shallow, treeless partial clone
>     (--filter=3Dtree:0) to an HTTPS remote, a thin push lazily fetches
>     every advertised tip's missing tree from the promisor one by one,
>     and --no-thin has no effect over HTTP to avoid it.

Thanks, that reads better than what I had. I'll take it as is in v2.

> But we may want to take another look at these uses of strncmp() when
> the dust settles (#leftoverbits).

Agreed, that is for a separate patch.

Thanks for the review.

Julian


On Wednesday, November 25th, 2026 at 18:57, Junio C Hamano <gitster@pobox.c=
om> wrote:

> "Julian Maurin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Julian Maurin <julian.maurin.dev@proton.me>
> >
> > "git push --no-thin" to a smart HTTP remote still sends a thin pack.
> > transport-helper.c does not forward the "thin" option to remote
> > helpers, and remote-curl always runs send-pack with --thin.
> >
> > "thin" was left out of the forwarded options of ef08ef9ea0
> > (remote-helpers: Support custom transport options, 2009-10-30) after
> > review noted that --no-thin did nothing on any transport at the time.
> > f7c815c3ee (push: respect --no-thin, 2013-08-12) made it work again,
> > but only for the native transports.
> >
> > Forward "thin" to helpers and teach remote-curl to honor it. A helper
> > that does not know the option answers "unsupported", which push
> > ignores, so it keeps working as before.
> >
> > Signed-off-by: Julian Maurin <julian.maurin.dev@proton.me>
> > ---
>=20
> Sounds like a clean fix.
>=20
> >    I ran into this in production, pushing from a shallow, treeless part=
ial
> >    clone (--filter=3Dtree:0) to an HTTPS remote. In a shallow repositor=
y a
> >    thin push reads the tree of every advertised tip it has locally, and
> >    each missing tree is lazily fetched from the promisor remote, one fe=
tch
> >    per tree. --no-thin avoids that work, but has no effect over HTTP.
>=20
> Some of the supporting materials under the three-dash line, like the use
> case that benefits from avoiding lazy tree fetches from a shallow,
> treeless partial clone, make the motivation very clear, and may want to
> be included in the commit log message, perhaps in a bit more condensed
> form?  Here is my attempt.
>=20
>     If one pushes from a shallow, treeless partial clone
>     (--filter=3Dtree:0) to an HTTPS remote, a thin push lazily fetches
>     every advertised tip's missing tree from the promisor one by one,
>     and --no-thin has no effect over HTTP to avoid it.
>=20
> > diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitre=
mote-helpers.adoc
> > index 39cdece16e..8203ef497c 100644
> > --- a/Documentation/gitremote-helpers.adoc
> > +++ b/Documentation/gitremote-helpers.adoc
> > @@ -542,6 +542,10 @@ set by Git if the remote helper has the 'option' c=
apability.
> >  =09transaction.  If successful, all refs will be updated, or none will=
.  If the
> >  =09remote side does not support this capability, the push will fail.
> >
> > +'option thin' {'true'|'false'}::
> > +=09When pushing, request the helper to send a thin pack (see
> > +=09`--thin` in linkgit:git-pack-objects[1]).
> > +
> >  'option object-format true'::
> >  =09Indicate that the caller wants hash algorithm information
> >  =09to be passed back from the remote.  This mode is used when fetching
> > diff --git a/remote-curl.c b/remote-curl.c
> > index 2c35dd5240..8309d9d2a4 100644
> > --- a/remote-curl.c
> > +++ b/remote-curl.c
> > @@ -184,6 +184,14 @@ static int set_option(const char *name, size_t nam=
elen, const char *value)
> >  =09=09else
> >  =09=09=09return -1;
> >  =09=09return 0;
> > +=09} else if (!strncmp(name, TRANS_OPT_THIN, namelen)) {
> > +=09=09if (!strcmp(value, "true"))
> > +=09=09=09options.thin =3D 1;
> > +=09=09else if (!strcmp(value, "false"))
> > +=09=09=09options.thin =3D 0;
> > +=09=09else
> > +=09=09=09return -1;
> > +=09=09return 0;
>=20
> The above two hunks match with each other, naturally.
>=20
> In remote-curl.c:cmd_main(), '.thin' of 'options' defaults to 1 (side
> note: I didn't know that ;-)), and push_git() passes "--thin" to send-pac=
k
> only when '.thin' is set.  Honoring 'true' and 'false' here while
> returning -1 for invalid values matches the surrounding boolean options
> in set_option().
>=20
> It is an unrelated tangent, but the use of strncmp() with namelen means
> set_option("t", 1, "true") would allow setting 'thin' to 'true'.  Git
> internally always sends the full option name, so it does not cause any
> problem in practice, and it certainly is the right thing for this patch
> to do to imitate the surrounding code.  But we may want to take another
> look at these uses of strncmp() when the dust settles (#leftoverbits).
>=20
> > diff --git a/transport-helper.c b/transport-helper.c
> > index d5a064d386..6052407b9a 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -275,7 +275,6 @@ static int disconnect_helper(struct transport *tran=
sport)
> >  static const char *unsupported_options[] =3D {
> >  =09TRANS_OPT_UPLOADPACK,
> >  =09TRANS_OPT_RECEIVEPACK,
> > -=09TRANS_OPT_THIN,
> >  =09TRANS_OPT_KEEP
> >  =09};
>=20
> Running 'git grep TRANS_OPT_THIN' tells me that builtin/push.c is the
> only thing that sets TRANS_OPT_THIN via transport_set_option().  We used
> to claim that this was unsupported, but when push asks to use it, we now
> pass it through.
>=20
> set_helper_option() notices that the boolean_options[] array still has
> this token, and sets 'option thin true' or 'option thin false' depending
> on the value and calls strbuf_set_helper_option() to send it out.
>=20
> It is a bit surprising that there is absolutely nothing else that needs
> to be added to support the option, but given that this was about
> resurrecting a feature that already exists but was left castrated due to
> a historical mistake, it is an understandable confusion on the reader's
> side ;-)
>=20
> Looking good.
>=20
> Thanks.
> 
