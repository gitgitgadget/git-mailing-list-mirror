Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118773196
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196831; cv=none; b=j0UjewY/B1C/rmfMs3BO87f6fK0PCXsR7hx5fVdoIn00Py5CAYSEQRSwxgwLQ/JqzQlA6dPCv6IVMXBw0u+dJ3BwRQavxeXjkFjDlS/j+4W5mZfQPEPaomdbY+9kvIho5fTERFe75FaLd7ybVrXwzL+1jFJBRki4Vkwq0YnHlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196831; c=relaxed/simple;
	bh=u4dHo94i6OYUxoJVJJI9q865TGXHRrGtuBZD9QPj4CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pejjt+AsyMjjeQ7AQ5FBJfVL16BJd+YrHAoSnpPLymfczVkQkDUlhGkVrhTzgIaaMzvg1BfpjYf7RlbB9ztm6S0JHTG8BD1C19yjqY3WTUHRq8jJ/y9R4ebTHZAjTAyXCtSrcWmJmi6r7NtjhR1MiFrZvyYFaFrCfFIvTuT9kpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G9VlwBbu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDqCjVYI; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G9VlwBbu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDqCjVYI"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C1855C01A1;
	Tue,  6 Feb 2024 00:20:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 00:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707196828; x=1707283228; bh=QH7Elah3vF
	7xyMwv30sP7Qi3tAN3w8ShyDvYp2ZfVp0=; b=G9VlwBbueQqPUB/+GewiS3AeCO
	BtGNTGgp4nPXsHhk/SYQLf+I+iKJRS7scuAMYJH1ooOFr+cZgpWKzRj6zcAfzeGq
	0g+co0k/3oFlrvRvRHEBTNL0zA6u5tlAuXzCBgiOMRhWMQVCqvmUGCR6w+pOjL99
	4S8IGnUv4/CDDVZ83GahBtBG5sacuVd2Xpb+iRvEj2OVsTMCelEwpnGWP/XMnYa7
	adDimxcyjg4Rv1eakVge85+x8+aVBm/QDzqLYeQsH0ctchnCmvZsmPL5OeVUvDhd
	p7ZWTrY6i8P8TRoh7+b3ug3uscXwki6Kz1XALSR6Dv7uYHvJnMg38WOZnhXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707196828; x=1707283228; bh=QH7Elah3vF7xyMwv30sP7Qi3tAN3
	w8ShyDvYp2ZfVp0=; b=gDqCjVYItJAL6LGmSIlSyzixogAM3R7ahVl1gKtApP2i
	gAgFOBVeyPVgLYJ8EEmu1siEfK2MbleJYG6thgSVwZR5zneP6yru/w2Id7TS6U7j
	JQ8PU9RKq+21GELERZa2P15wgV+1B8DdL/B1h4fCxwPAwQVJ+/qI96vVna4CzZ6Q
	H7YviF2rMM9PpsGTuJpIgGt2NYIKknYmboIElofsdrVTxV5OJ47n5ZWe3Obnqs7G
	KVpBb4oOB1QQVqX8Vy4J8Hjd0YSM5KCv7iE/QpDgmcQisl8hQD4iH2v/tfw6xKmJ
	PwWENLhUuh+DgnH/CuK+qyNn8H1DpbaftruQaPoFSw==
X-ME-Sender: <xms:nMHBZb53c_V3oB6LsZ8AHOXmhB0KDN2WjNHXJ-XcTwgUAVZIIP9qSQ>
    <xme:nMHBZQ7M3K5Qte5sOcUyX_NYDs9wwhHf1F1NOSEIo5c-JUS4yWqifN2FFGuYRzMJ3
    sE7QfWYOZPlL3ybZQ>
X-ME-Received: <xmr:nMHBZSfOnwuH0msccStHvx7EGGIXVWjHDFvGLiSF8RA-rqy9y3KTdH2dbS7StDDxCedHCNJlRuWbG6DGWtwGORnr77mIUIdx6V3lXtaE9w77A5Eu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nMHBZcI8Ganx2G0FUxl7NYHVyBUxwpL3NR13OhtX3xpwXtznc_HRtw>
    <xmx:nMHBZfLucCevnafQ8y5w0s_TsjeKk9MsBGjIlWllECXUsIuxOmtFYg>
    <xmx:nMHBZVzFweVTqGG-kFlfs4TfsedyhYF7-hTU8vWUQ7A4Va6b-Wf5-g>
    <xmx:nMHBZWUovM0N9_LkkxkHhKL_TXnNaJW-uj7eJI5TU0owH78hXcVQNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:20:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3105f690 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:16:56 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:20:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, moti sd <motisd8@gmail.com>
Subject: Re: [PATCH] builtin/stash: report failure to write to index
Message-ID: <ZcHBmGAuOBEUBcKU@tanuki>
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
 <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
 <xmqqo7cul1fi.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25gpW02lIIn7YZ/O"
Content-Disposition: inline
In-Reply-To: <xmqqo7cul1fi.fsf@gitster.g>


--25gpW02lIIn7YZ/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 07:24:49PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The git-stash(1) command needs to write to the index for many of its
> > operations. When the index is locked by a concurrent writer it will thus
> > fail to operate, which is expected. What is not expected though is that
> > we do not print any error message at all in this case. The user can thus
> > easily miss the fact that the command didn't do what they expected it to
> > do and would be left wondering why that is.
>=20
> Hopefully, they know they notice the exit status of the command, or
> do we throw the error away and exit(0) from the program?

We do return a proper exit code as demonstrated by the tests. But if you
interactively use those commands in the shell then you're quite likely
to not notice error codes at all -- my shell certainly doesn't highlight
failed commands in any special way.

> In any case, telling the users what did (and did not) happen is a
> good idea.
>=20
> > Fix this bug and report failures to write to the index. Add tests for
> > the subcommands which hit the respective code paths.
> >
> > Note that the chosen error message ("Cannot write to the index") does
> > not match our guidelines as it starts with a capitalized letter. This is
> > intentional though and matches the style of all the other messages used
> > in git-stash(1).
>=20
> Style may be OK, but I wonder if they should say different things,
> to hint what failed.  For example:
>=20
> > @@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struc=
t stash_info *info,
> >  	repo_read_index_preload(the_repository, NULL, 0);
> >  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
> >  					 NULL, NULL, NULL))
> > -		return -1;
> > +		return error(_("Cannot write to the index"));
> >
> >  	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
> >  				NULL))
>=20
> This failure and message comes before anything interesting happens.
> We attempted to refresh the current index and failed to write out
> the result, meaning that whatever index we had on disk did not get
> overwritten.  Is this new message enough to tell the user that we
> didn't touch the working tree or the index, which would happen if
> even some part of "stash apply" happened?  Or is it obvious that we
> did not do anything?

As a user, my expectation is that if a command failed, it didn't do
anything. If it did something before failing and wasn't able to clean it
up, then it is the responsibility of the command to tell me that it
might have screwed up and left behind some partially-applied changes.

It could certainly be that my expectation is way off. But personally, I
don't think it's useful to say "We didn't do anything" in every case
where we failed without doing anything -- I'd rather feel that it is
quite spammy.

But anyway, I know that my UX skills are severely lacking. So in case
you or anybody else has a specific suggestion for how to make it better
then I'm certainly happy to adapt.

Patrick

--25gpW02lIIn7YZ/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXBwZcACgkQVbJhu7ck
PpS9qxAAmgkHDnDg8HQp7s+NBDX626RqS0EGMmcehzyuWZNQITJZ9LW2qQo6GOza
tzapsThwNnyF0j81DQXoMLMGzqN1V4gIvu4NvkZzXUFsqQkpd47gJG5nOQ1726i+
bTgTExQx3VhXMFXq/JnOEYUdcViwlPxR68N+rWtrDbBGRaOn+JJAb4PPN5Xg8tqQ
umObPOJE3rQkX6YIdsa9Aq5Z30YkUjiHkWnsUYMJ+VbD+jK8Q08HJNb7jGXl6kzl
2EiUqhvz42zRuIw8luI5TbHdxQSGG/KpeGXlzMLJnSVEb2jFEsMOYyih/ZNNT+/p
aoFu4oUhHHOaKabkxpCRODKbRGY+wogKGcrEbn70pZ7kFDfZ3x6GAn4nqNsElpSe
JBUNYUkvOldNdVrL+/ghxhYDEqeJfula11xVEKo2R4YGeDX5ztxAjqBvhxtrGuQB
hnr3FHLboaMxJROnVuR/ex22fRmivPSFjvtZJbAVxgp0k+JZq0WBsNwaDBp9Nc49
1CubBCyzrOu0zGSrojCXMsdpfe/Ke1M/bwsNKbY+UGxMlk/chcHnsGWS5+GIU2mh
SLXRP4hvBtwTXhztlSDZk0N7jK0LUaMsDxxWjXNLhzW1SMTQDbAicLzGwPVx/xpG
SeNLO+z1t6yFli0ZaWra46FzsmIrXekfLGgPpyXKicpe35DG96c=
=awVD
-----END PGP SIGNATURE-----

--25gpW02lIIn7YZ/O--
