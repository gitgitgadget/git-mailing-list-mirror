Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A17F2F1FE2
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050075; cv=none; b=Y4y3dj5jDSXm4PIt9VfeH1UN9FFaGnssWrCl10ZfFpO+3NxU3Yw3hmpo4V91bVPOq4l95mxSmbygcCyT3BWs2Xu/hMvTjJYkMTd7yroJrN+6bQO15zCwO/5QJPOWjiUUhBYsxmayVHst0UDTxcuSo4V7UuVBReWWpAazAJmsXc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050075; c=relaxed/simple;
	bh=vlB/8tBBdB4RcHCVmSfF7jKZO83q45FBAD6z8YBUyH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIX+k/OLuUSWf18054+mL6HvXFSip2Z2rA41F7G8+/rDFN1n8l3yjr7y1Gx6CKLHSItGwl5g5OTzpwyBtFJoUcilMgMcmsLAT6ctYNHsFuYRSTG3mX/zmIocCeUN5jyR8N3k4J9cN+JZZfu2R5A/ntvV8fJ3KAcYWoZU4pdvweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=UKCU17UL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="UKCU17UL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751050064;
	bh=vlB/8tBBdB4RcHCVmSfF7jKZO83q45FBAD6z8YBUyH8=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=UKCU17ULN1e6QCw3lLR7scetFf8cyvzzbrmDnvtmz8ANoghpDTZSh4hFZuoKJJ4w1
	 jMa8FLwUzhEAG+aYmHJboHtgZ5clqnC+fi3peXj35abtSNUylXCfMzU6qpF1oZ05rl
	 FOEBN3H5AkT39kS2I+/czWlbC93sJnMDqRYMdxpg2sMZHtC0WwUhjxKvv1UMefnoB6
	 vSG/SOFEBP9E7XnwzxyyANQAvDMbAtJrQeJvjAzMVWEHiBjQvyL2ss50ZH39ArpsJ+
	 p04mSpH04W6dIHK9yI+lqvjzvil04OIZX51KjHjjFMDNz+ANlE7rSbvVoyYQx/376p
	 kxI1t41O7HLNO5D7tTCsAAZWB/kTlUj7FwvoN98fOI0733Mlm6Wuwgs7HaNZ0M39zY
	 tMEA6PIxR+1l+rW1T4FHdcxBgE33kaN3R/ZWkD5dyAxeRXhXcRqfP7+eUgMNWy0Mge
	 i80TZ1VDiOTL3J3hTE054P11nAW0iiaJRBYy7WJy9EozDEhMARR
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:93fe:8e7:9f14:b8a7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C60172003B;
	Fri, 27 Jun 2025 18:47:44 +0000 (UTC)
Date: Fri, 27 Jun 2025 18:47:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Erwan Leroy <erwan@erwanleroy.com>
Cc: git@vger.kernel.org
Subject: Re: Git "Permission Denied" errors on DFS path only with newer
 versions
Message-ID: <aF7nTwI6dufVZLr9@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Erwan Leroy <erwan@erwanleroy.com>, git@vger.kernel.org
References: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PLyuPvc6QUb/4Jg7"
Content-Disposition: inline
In-Reply-To: <CADT1yYmQGG5mQnWk=+19UOEvcDyiUQmWsib9jUJsPDc=A27vMw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--PLyuPvc6QUb/4Jg7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-27 at 00:14:02, Erwan Leroy wrote:
> Hello.
>=20
> I'm writing to see if maybe this is a known issue, or if there is a
> possible known workaround. I've not been part of this mailing list
> before so I hope the format I'm using for reporting is going to be
> correct/helpful (this is attempt #2, I did not set plain text the
> first time).
>=20
> A bit of context:
> At work, we are fully Windows-based, and mount our network drives
> through DFS. We are fully cut-off from the internet so everything we
> run is local to the internal network, which makes certain tests a bit
> more time-consuming than they should be.
> We have been working for years with Git and a self-hosted gitlab
> server, and have had no issues.
> Recently, some of the new hires started reporting lots of Git errors,
> mostly apparent permission denied errors.
>=20
> One of the errors:
> PS Y:\Users\xx\Public\dev\test_for_it> git remote add origin
> git@gitlab.xx.local:xx/test.git
> Rename from '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/c=
onfig.lock'
> to '//atl-xx/Basecamp_Atl/Users/xx/Public/dev/test_for_it/.git/config'
> failed. Should I try again? (y/n) n
> error: could not write config file .git/config: Permission denied
> fatal: could not set 'remote.origin.url' to 'git@gitlab.xx.local:xx/test.=
git'
>=20
>=20
> What we found out:
> - The first thing we found out was that only network drives were affected.
> - The second thing we noticed was that not only new employees after a
> certain date were getting issues, but also longer employees getting
> new workstations. This started to make an actual permission issue less
> likely, as there was no change to their user permissions.
> - Then we noticed that the delimiting factor was the Git version:
> Users on Git 2.21 and older had no problems. Users on Git 2.36 and
> newer (we also had some users on 2.47, and today downloaded and tested
> the latest 2.50). I would have tested every version in the range 2.21
> to 2.36 to help narrow exactly where it breaks, but I can't find
> pre-compiled versions for old versions and I'm not currently set up
> for compiling from source.
> - We also recently found out it only breaks when accessing through
> DFS, if we directly access the corresponding UNC path (what DFS
> resolves to), we do not get the same error.

I would suggest looking at the Git for Windows issue tracker.  There are
a couple of DFS-related issues, including
https://github.com/git-for-windows/git/issues/3825, which seems
potentially relevant.

Unfortunately, I don't use Windows, so I'm afraid I can't be of more
help, but this definitely seems like a Windows-specific issue, so the
Git for Windows issue tracker would be the best place to discuss it.
Dscho, the maintainer, is very capable and will likely know how to
handle this problem.

If you need a workaround and the one in that issue doesn't work, you may
wish to try using the Windows Subsystem for Linux for accessing the
repository after configuring it for Unix metadata support as outlined in
[0].  In that case, it will be Windows itself that will be doing the
conversion to POSIX-style path handling and it's likely that it will be
perhaps a little less brittle than MSYS2 in handling some of the more
esoteric Windows file system features (such as DFS).

Best of luck in getting this to work.

[0] https://stackoverflow.com/questions/78997348/git-shows-all-files-change=
d-when-git-init-was-used-in-wsl-and-git-diff-in-wi
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--PLyuPvc6QUb/4Jg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaF7nTgAKCRB8DEliiIei
gfd0AP9H/aqIFRJuVZNueLvezay4c2oBzPjvaRH9ZxDRLoiiIAEAiM31e6uI+sCl
XTSWFbekJJU6SKQeH62f1DyWP/cE9Q4=
=2YnS
-----END PGP SIGNATURE-----

--PLyuPvc6QUb/4Jg7--
