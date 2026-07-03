Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D93C98BE
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086148; cv=none; b=rGgAKwdN8SEC50a89UhBLzW3Z5Eg+BXqrURTY/DBUiTfgAutvf4XFCcPXMFUpijUBMfxlhQaw7OZuAxmSotGlNAQrqOXqpjZyHk4YBQTk6zlbjnXCs507NyzKBmVVdadUK8i+CB2GYyeBpzLqlebqFz22m9fvErW+mDkTc4fKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086148; c=relaxed/simple;
	bh=0yrDV5cyWm7rnJAgqwnrVJAOCVm7c2qa8aABXBSPz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYrO1bxy+4bIhDyF9lZggvE3/lpcFZA7LcHDsMBzbaNcpqKyVw7xf9sUucQ3AAIsRIkbbXzTs8veNseEDSUSGWgQ7IlweiQhAZi6dS3QYQp3RXnbdytUeZz2YE4nxTagfRGvSW4G/1Ydg1LpzTUZuAuYY9Sij07lE6JLadWsXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=GL6xs6tF; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="GL6xs6tF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1783086138;
	bh=0yrDV5cyWm7rnJAgqwnrVJAOCVm7c2qa8aABXBSPz3Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=GL6xs6tF+SoiGuiBkFwyaL5uuaK4m24XTSj9cWGGU4OBkFyciTPNdSU+jQPj+Zp9C
	 3bXLMPw+n/KRtS+JHo/Zing9rZgooAHoqcDmcn/5fvQknJ+T5KzVAN/MH9yp8ZeI0Q
	 YWdufoZgwN1+T1OcC3fWcbi/s3efin8dYhxH5wFkorzzobb9GcLNxAL6jQS6oer4FA
	 UFjG7yWnGTVRSSySpFPxuTiM8CAce63niL5DMfe/i6aiz1RPLerXqXXHuxwy9Ivq1r
	 TeMEAjTFXLkoWlYJxeNJPEwZaAqL0Syn3hPmlemQZwGoWFvKdLV+qj0F9Sedd2IXfA
	 lPXCmUBR4mTHvKqOUu/pr6xPUG4uSvUVOfxO6YUsqZYJZ7Xn5iVoZWv6ckCMBiEFs9
	 McrAZPN4mJBdc3sB8DI6iWYJ8sjPUGJ4sT7lyoREEviWM91hvYTBWifNR44YmOHfU9
	 Nn/cKnz+0SWRhzCI68MeCJYLiNxBxHXpB87ndHFRNRLvRhbuwZC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4c68:467a:f157:4800])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AD27520074;
	Fri,  3 Jul 2026 13:42:18 +0000 (UTC)
Date: Fri, 3 Jul 2026 13:42:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthias Beyer <mail@beyermatthias.de>
Cc: git@vger.kernel.org, neikos@neikos.email
Subject: Re: Programmatically edit the git rebase sequence?
Message-ID: <ake8OAIyK-ELs-fU@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org,
	neikos@neikos.email
References: <akei64goQf3nFhX4@hikari>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZDUgjlwIlkdAkRwv"
Content-Disposition: inline
In-Reply-To: <akei64goQf3nFhX4@hikari>
User-Agent: Mutt/2.4.0 (2026-06-19)

--ZDUgjlwIlkdAkRwv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-03 at 12:02:33, Matthias Beyer wrote:
> Hi git people,
>=20
> in a recent conversation at work, the question of how to
> programmatically edit the git-rebase sequence came up.
>=20
> Example use case:
>=20
> I have a branch that touches a number of files, adds some files and
> removes some files.
> When rebasing, I want to split all commits that touched a certain subset
> of files, for the clearity of the history.
>=20
> I look at the output of
>=20
>     git log master..mybranch --oneline --diff-filter=3DM -- "./subdir/*.r=
s"
>=20
> to find all commits in that subdir that only touched the files. All of
> these commits are to be "edit"ed.
>=20
> Now I fire up `git rebase -i master` and manually(!) match the list from
> above `git-log` call and find the respective commits to edit them.
>=20
> Is there a way I am not aware of to do that manual step programatically?
> Something like
>=20
>     git rebase -i master --edit-commits=3D"$(git log master..mybranch --d=
iff-filter=3DM --format=3D"%H" -- "./subdir/*.rs")"
>=20
> would be convenient here, although I would understand if that is too
> much clutter for the already very heavy git CLI interface :-)

Yes, such a thing exists.  You want `GIT_SEQUENCE_EDITOR`, which is an
`EDITOR`-like command that edits the rebase list in place.  So tools
like `ed`, `ex`, `sed -i`, `perl -i`, or `ruby -i` would be useful here.

So you might want something like this (untested):

    GIT_SEQUENCE_EDITOR=3D"perl -pi -e 's/^pick ($(git log master..mybranch=
 --diff-filter=3DM --format=3D"%h" -- "./subdir/*.rs" | paste -d '\''|'\'' =
-s -))/edit \$1/'" \
    git rebase -i master

Note the use of `%h`, since by default the object IDs are abbreviated.

If you want something simpler, you can also write a shell script which
edits the first argument in place and specify that.  Arbitrary shell is
allowed in `GIT_SEQUENCE_EDITOR`, much like in `EDITOR` and `VISUAL`.

I personally use this alias, which explicitly does not edit the sequence
list, to automatically squash in all squash and fixup commits without
prompting:

    srebase =3D "!f() { GIT_SEQUENCE_EDITOR=3Dtrue git rebase -m -i --autos=
quash \"$@\"; };f"
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ZDUgjlwIlkdAkRwv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpHvDgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZymqZnk6HSFhAGQY7ovSwpUz3ZQ7PmF6UE864NIbataJ
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKfMAQCOBhLla6tHG/kvNxZptMi3tTzn
Z+DpV2tnLge6dSCcdgEAhFmI2bIK8ck0YCKMe6YZvXWB38WwcaERICCPm4Dm7A8=
=sJzy
-----END PGP SIGNATURE-----

--ZDUgjlwIlkdAkRwv--
