Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6022D7E105
	for <git@vger.kernel.org>; Sun, 11 May 2025 23:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747007370; cv=none; b=pCrrvQ30QsTRqgzfnai8/wpnf/pgnj1ztF2NgDOA+GsWecqc3cClv3TnYrpvnHMcgf75AGcSuPHouE/MCvHqvbvVW0bMmWIGPxexoz5yQ56oBOZshuTk82jQ7cmbkTVq0VhsDext+SdsIA8nhpAGkZLSqIgAFW9wo1xgT8z6c+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747007370; c=relaxed/simple;
	bh=g78G52qGAozVDtqv2vx6WSLIA+BJYcECkHa+hLTLYf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN5/eMXS6dS8S4rRDp/pAH3aBo2wJV/8062PSHbB9c1rrZfKOk39NtuG5yLyzSpjAdsO2dwOpvbla4Lr7QZ3Tf2HNqrDggB3DsEUNponkbWSr1Swp7IfW/Ujm481suXU0cZrAaNo8tSQeIkPasOdA73rMtjMdRsjStB3ZS/O6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=sdhD16R9; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="sdhD16R9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747007051;
	bh=g78G52qGAozVDtqv2vx6WSLIA+BJYcECkHa+hLTLYf4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=sdhD16R9jQm9HtfqLYQyfoWZA1AeMEPUuUvf0lfuw0xmx4X7P33YZWdg0AyXkpphX
	 pqtOqYqtZx9ZYodBGMW83MqeaIE1nc57LHiwxYohRXNTUNm5PUt967ebgjkAb0m5CV
	 9UxHY5PSn9ZrGhz4fJ8LtJAVLOOtIPQn0DIz1wapm8+Q+ra2+jHaArD2Tnxjc5tpDz
	 5m3d1U6KjIV7O0Ar5VwSaaxBuWcafblwvAh63T81Hp+r/SZup4brGF+c/W7F6uDAi5
	 IJDTvkvONCDwb1hdKqSwQuzRBGiC9xlvuZqpCiQycNwUQeB38u9A6ar7NWfth8Ugdq
	 gor6tK6sHfsBj8QtDvpGhsTJ1qQIjkq8LSOK5mO5imyuayVyQH9kDyMvP97FayMdMw
	 Du7NsxjXm/+SZUMYdo+KGHtBklJV+wp/GRaAFYIMkWCNs4DqjHr0eZNHVkYqyYyGAC
	 +Us/xTYn2aBvXvSP2/ogJBs3idfqmL55LHs+aGQfSFsrfNEuXtD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A3E7E200BA;
	Sun, 11 May 2025 23:44:11 +0000 (UTC)
Date: Sun, 11 May 2025 23:44:10 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <aCE2SjpCu5qlwyoK@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-5-sandals@crustytoothpaste.net>
 <xmqqzfflzhjv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HX6oaZTBprRua5L3"
Content-Disposition: inline
In-Reply-To: <xmqqzfflzhjv.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--HX6oaZTBprRua5L3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-09 at 19:54:12, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > +static int do_import_stash(struct repository *r, const char *rev)
> > +{
> > +	struct object_id chain;
> > +	struct oid_array items =3D OID_ARRAY_INIT;
> > +	int res =3D 0;
> > +	int i;
> > +	const char *buffer =3D NULL;
> > +	struct commit *this =3D NULL;
> > +	char *msg =3D NULL;
> > +
> > +	if (repo_get_oid(r, rev, &chain))
> > +		return error(_("not a valid revision: %s"), rev);
> > +
> > +	/*
> > +	 * Walk the commit history, finding each stash entry, and load data i=
nto
> > +	 * the array.
> > +	 */
> > +	for (i =3D 0;; i++) {
> > +		struct object_id tree, oid;
> > +		char revision[GIT_MAX_HEXSZ + 1];
> > +
> > +		oid_to_hex_r(revision, &chain);
> > +
> > +		if (get_oidf(&tree, "%s:", revision) ||
> > +		    !oideq(&tree, r->hash_algo->empty_tree)) {
> > +			res =3D error(_("%s is not a valid exported stash commit"), revisio=
n);
> > +			goto out;
> > +		}
> > +		if (get_oidf(&chain, "%s^1", revision) ||
> > +		    get_oidf(&oid, "%s^2", revision))
> > +			break;
>=20
> This is to stop at the sentinel commit at the end.  Don't we want to
> make sure that it actually has the expected shape of the sentinel?
>=20
> IOW, how robust do we try to be against being fed a random mergy
> commit history (e.g., our 'master') and mistakenly adding nonsense
> stash entries as refs/stash@{<n>}?

I'll try to make this more robust.  The advantage of the current
approach is that we don't have to parse the buffer, but once we need to
do that, we might as well do the entire thing.

> > +	/*
> > +	 * Now, walk each entry, adding it to the stash as a normal stash
> > +	 * commit.
> > +	 */
> > +	for (i =3D items.nr - 1; i >=3D 0; i--) {
> > +		unsigned long bufsize;
> > +		const char *p;
> > +		const struct object_id *oid =3D items.oid + i;
> > +
> > +		this =3D lookup_commit_reference(r, oid);
> > +		buffer =3D repo_get_commit_buffer(r, this, &bufsize);
> > +		if (!buffer) {
> > +			res =3D error(_("cannot read commit buffer for %s"), oid_to_hex(oid=
));
> > +			goto out;
> > +		}
> > +
> > +		p =3D strstr(buffer, "\n\n");
> > +		if (!p) {
> > +			res =3D error(_("cannot parse commit %s"), oid_to_hex(oid));
> > +			goto out;
> > +		}
> > +
> > +		p +=3D 2;
> > +		msg =3D xmemdupz(p, bufsize - (p - buffer));
>=20
> Here, we could check "git stash: " string to make sure that it is as
> expected in an exported stash we previously made, and abort, just
> like the above "cannot parse" case.

This part doesn't have the prefix.  That's the part above, but I'll add
the check there.  This part instead is the actual stash commit and we're
extracting the message to put into the reflog.

> Should we be making sure that the object named by "oid" does look
> like a stash, like what is done in builtin/stash.c:get_stash_info(),
> or is assert_stash_like() called from do_store_stash() sufficient?

I think `assert_stash_like` should be fine.  I don't have any better
checking to do than that, since we don't have any more checks to do.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--HX6oaZTBprRua5L3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmghNkkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4zg6E07X9a28zUli9D0/0dA9K4s647dLrW8XWorzTQy
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAFuFAP4h7V6GWuEtwTpClupR7lZd7NUS
5TQQ04jmDnz78zO5jgD7BLCyCZhzrWZw7jwLHHSQ/4PsyRVJauBIWvSZcg7kdQI=
=XRtX
-----END PGP SIGNATURE-----

--HX6oaZTBprRua5L3--
