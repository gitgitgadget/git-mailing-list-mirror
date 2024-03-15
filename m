Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9C9481BA
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539255; cv=none; b=hQVVSf9iUIqyskf2s3gGd+7j0LKLh/BsOrTILBu58SlumQKwljQwlhs7o2IPJUD9d0FXA3srCLTShkjy5LOrMM5edfe8ayPnCDzUu4rL7oME7vXRNXggn2sZEG3ku+6yb3kuCed1y5SwVKSkCGOeTND4+H/sI1e9foUbfY41oHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539255; c=relaxed/simple;
	bh=ibtXyIx3iZQCFnSg1CDHQa8ax2cpNAU+JKb12FjPzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSSsTFrdKslVdqhoVJ33rF27fGgK8+m1PeoO9mdOHcCuN3HpAthKgak38RWGOiiwXzq4Y4zTwLScQE51iJsgft7njMfF5tks3p5St75VeQXKLNEBr5iJ6sMyjf9u43v7PYaB/WZN/xqXH0OyzFvqGaRfdmgQ2P5cv2AHpZNLaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uTdQmN3u; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uTdQmN3u"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id EA4DE5B3E1;
	Fri, 15 Mar 2024 21:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1710539245;
	bh=ibtXyIx3iZQCFnSg1CDHQa8ax2cpNAU+JKb12FjPzgo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uTdQmN3uF0obcbdshULoGKkwmmGjxUJvbXSu/czPD3cEOHzNs/Dcs5clon/YADkK0
	 JAfGOiC3QG4dRUmDZru/QoHCYUoLCsFO/bWwmqXwZEiznQ/0b4v5CIkjtnP7/CICPy
	 ix/ATZH53+8xZrY1vhIb4jTVUO7F9JhbNlYjTRhcviN7O+ij97HQ3Wh+/TcIvq2Mq5
	 CHKlCDrrrLfYFFMd683nNT49MmNlsSB/Qce/b/PsOYcwyAtgNcF+uFcmeIgsPTQzKs
	 ts2SQetLaIoU9c3l0LbQWgfE6MYqH9gpdPVlLl6pTkfPCfJXApMucl5/YZOgIAZQPp
	 OPclyobuu8f2H1xTQN5NHHclR6+lWspKVmb6XLeeqLBFtxe2WGqz+fLjJvA5otXCLy
	 zT5e12aPCx86D12UD9MnJx5Lsg2fPVz1xsk9KpWawji+I9aqHGIsh5m8ykYnLVf6Qn
	 5LxqGtu0hphO6j+xKvJzza0k+k3reNdRX3uf7Ak+haAn3ks/4hO
Date: Fri, 15 Mar 2024 21:47:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Kai <k.vongrambusch@googlemail.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
Message-ID: <ZfTB7NNtyYzv_6-t@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kai <k.vongrambusch@googlemail.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
 <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
 <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P396A0n14nIoHhzs"
Content-Disposition: inline
In-Reply-To: <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--P396A0n14nIoHhzs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-03-15 at 13:22:52, Kai wrote:
> Ok, I was assuming that having the whole files may be better to
> reproduce the problem, but if just the relevant parts are enough, let
> me do that.
>=20
> Here is an example from all three files:
>=20
> ### BASE FILE (I used git merge-base master hook-form to show the
> ancestor commit)
> export const AddListingForm =3D (active: number) =3D> {
>=20
>=20
>   const form =3D useForm({
>=20
>     defaultValues: {
>       city: { name: '', lat: 0, lon: 0 },
>       neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },
>=20
>=20
>=20
> ### MASTER BRANCH (THEIR VERSION):
> export const AddListingForm =3D (active: number) =3D> {
>   const form =3D useForm({
>     name: "add-listing-form",
>     initialValues: {
>       city: { name: "", lat: 0, lon: 0 },
>       neighborhood: { name: "", lat: 0, lon: 0, neighborhood: "" },
>=20
>=20
>=20
> ### HOOK-FORM BRANCH (OUR VERSION):
> export const AddListingForm =3D (active: number) =3D> {
>=20
>=20
>   const form =3D useForm({
>=20
>     defaultValues: {
>       city: { name: '', lat: 0, lon: 0 },
>       neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },
>=20
>=20
> ### GIT DIFF MASTER TO BASE FILE (git diff
> 12545fa846fb0d042a4ed29ee0699d89f1621bc2 master --
> components/add-listing/forms/AddListingForm.ts)
>    const form =3D useForm({
> -
> -    defaultValues: {
> -      city: { name: '', lat: 0, lon: 0 },
> -      neighborhood: { name: '', lat: 0, lon: 0, neighborhood: '' },
> +    name: "add-listing-form",
> +    initialValues: {
>=20
> ### GIT DIFF BASE FILE TO HOOK-FORM (git diff
> 12545fa846fb0d042a4ed29ee0699d89f1621bc2 hook-form --
> components/add-listing/forms/AddListingForm.ts)
> No diff in relevant part
>=20
>=20
> So as you can see, in this case Master has changes to the base file at
> the relevant part, while in the hook form branch we continued to use
> the base file version of that part. Now maybe I misunderstand how
> merge conflicts are supposed to work, but shouldn't I expect git
> marking the changes master made as a conflict? Because in master parts
> of the file were changed that I did not change in the new branch? When
> I now merge, the code is not working, because masters code is applied
> and it breaks other parts of the code in the same file.

I think you may misunderstand how a three-way merge works.  Git
considers exactly three points: the merge base and the two heads.  If,
in a particular region of code, there is a difference between the merge
base and one of the heads, and no difference between the merge base and
the other head, then Git adopts the difference.  This is the fundamental
idea of a three-way merge: to include the changes made from both sides.

This is true even if the side that has no changes between the merge base
and one of the heads has had multiple changes and reverts in between.
The intermediate states of the two branches are not considered.

It is also irrelevant what happens to other parts of the file as long as
they are not directly adjacent to the parts that the merge is working
on.

So in this case, it looks like Git is functioning as expected.

> If this is expected behavior, this is a big issue in this case, as I
> cannot trust that after sorting all conflicts that my code will work.
> In that case I would need to manually review every diff. Or is there
> maybe a stricter mode for merge conflicts, to also highlight these
> types of differences?

This is called a semantic conflict, and it can occur.  Git typically
operates on lines for diffs and merges, and that doesn't intrinsically
line up with functional units of code, as you've seen.  It's possible
that a three-way merge produces broken or even syntactically invalid
code.

This is why you need tests, so that people can run the tests on the
merged value and verify that the result is functional.  Usually this can
be done via a CI system.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--P396A0n14nIoHhzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZfTB6wAKCRB8DEliiIei
gZBnAQClHN+goK8WvL/TDO/+3pFoak+lj8qC+tIQqJwemHCREQEA8KJmvhT889E7
b2N084FzcrEBoIAz237QW2KqTcCofgo=
=h4uS
-----END PGP SIGNATURE-----

--P396A0n14nIoHhzs--
