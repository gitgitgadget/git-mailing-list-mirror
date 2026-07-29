Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB741C72
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 00:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284094; cv=none; b=rJJNZEY9Ygz7WVfC9o/2ZJQW72jCPqcHPOGfgHS9U0cLoYCpZk5mhlM654RI16bGPU+N1r1aMvwXnYB5ocTx42OCZ7R15SL1Au67Q8vH96U+s3wAtsWWKX/f1KxhZLm3ttGd1FuR933bP82IXzodfpYmDgZslWVcaacPo2GWuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284094; c=relaxed/simple;
	bh=mJcLeeguwum5fgsWAFFT9ptTokUiFQPedmVDILIB/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvSVWFNZKu62kXSzbbSeFd5vP7nR7QMnFNpR3ptjP0Qnz2rYrOtd8YJ3VZ0oUEnWNE5+VEkzvyUeMguKrsw8dmdk7q6x1+P7SeOstr2f7+LLbGw87OuOaYz3eMvKE3dkh+wwqVDYqnFfLB+PRH8iK1NeZ8tO3IpJLggwVb3Dy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Rqrs7iCD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Rqrs7iCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1785284091;
	bh=mJcLeeguwum5fgsWAFFT9ptTokUiFQPedmVDILIB/FA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Rqrs7iCD6Nw0YdbPhC+Sxs6xw96uO0FpCHFKhW2ZUXnz5rY65QI876+S7hqdyl/F/
	 lcEDkxJBeRiKMc6kKvL6evCyaiKbhBvYs790oqIkGgsXNnh/GPVqs0sWcwBpfsMuzD
	 IlJn3FDrUIWU1IRK/PQZREOCwTd2qq500mu4VjO17bHl0BLIf68SQ0SgpiIQfG5GJS
	 ybcaZRqBBYegduPM0dwTJ9JUymtSx7NaAI1avMX23G1G2Wdn5nmMzBuSb3eXADJG9f
	 OKCHbBH2GwjcTjvgRDoxym2Hj3Jgdd4tDGu60knnE0jrb+kMRxc797EERPRG+Sm8KY
	 e6WDericl5OWQvC/E7fR+waNjHz3E5hM0wnVb1nAbolI6e7kPCARt7xGbmbcTPT/gY
	 4v3HcvZ/d2YHtvj0md3ZzYA6Ijm6xzwq3aqtJsShaE9ZBl85ahfe8WFxCMsYG9X2qS
	 mf7xKRta/pn937chSKjOnCFW0wRohsHhW+SEuyD3ASzVDFYYLMG
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3e63:6e70:6235:fd22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AC76920083;
	Wed, 29 Jul 2026 00:14:51 +0000 (UTC)
Date: Wed, 29 Jul 2026 00:14:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Knop, Ryszard" <ryszard.knop@intel.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Clones with fetch.bundleURI slower than standard, full clone?
Message-ID: <amlF-ZepjtCZz1YE@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Knop, Ryszard" <ryszard.knop@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <008c6f4742d8e20124ed21d191178ce6db29aaa5.camel@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yg3JPT+DEwRW/KVi"
Content-Disposition: inline
In-Reply-To: <008c6f4742d8e20124ed21d191178ce6db29aaa5.camel@intel.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

--Yg3JPT+DEwRW/KVi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-28 at 23:42:03, Knop, Ryszard wrote:
> Hey all,
>=20
> I'm working on a Linux kernel-related CI system where we need to
> perform full clones of the kernel repo in most jobs. Because of some
> jobs in the pipeline, it usually cannot be a shallow clone :( Since the
> kernel repo is large and slow to clone, and I don't want to put undue
> stress on the remote host, I used git bundles, where CI clones the repo
> over a weekend, packages that as a bundle, then in jobs it gets used
> like this (weird, but works for <REF> being a branch, tag or a specific
> commit hash):
>=20
> git init
> git remote add origin <REPO-URL>
> git config set fetch.bundleURI <BUNDLE-URL>
> git fetch origin <REF>
> git reset --hard FETCH_HEAD
>=20
> Cloning a repo this way takes 4-5mins. Unpacking a bundle appears to be
> super slow. Not even faster than just running a full, normal clone from
> the remote server, actually (~3-4mins for a single branch).

You're comparing apples to oranges here.  A clone of a single branch
includes only that line of history and only those objects, but when you
use a bundle with multiple refs, Git has to handle all of the objects in
the bundle's entire pack, not just the ref you've specified.  In order
to compare adequately, you'd have to compare a bundle containing only
that one ref with the single-branch clone or a regular clone of the full
repository with your full bundles.

> On one of the build VMs, with Git 2.53 (stock Ubuntu 26.04), GIT_TRACE
> suggests most of the time is spent in some variation of `/usr/lib/git-
> core/git index-pack --stdin -v --fix-thin '--keep=3Dfetch-pack 39430 on
> build-server' --check-self-contained-and-connected`, and indeed that
> process burns 100% of its single thread for most of that time.

As far as I can tell, the unbundling code just calls index-pack, so it
should honour pack.threads.  Setting that value to 0 causes this code to
be executed:

		/*
		 * Experiments show that going above 20 threads doesn't help,
		 * no matter how many cores you have. Below that, we tend to
		 * max at half the number of online_cpus(), presumably because
		 * half of those are hyperthreads rather than full cores. We'll
		 * never reduce the level below "3", though, to match a
		 * historical value that nobody complained about.
		 */
		if (nr_threads < 4)
			; /* too few cores to consider capping */
		else if (nr_threads < 6)
			nr_threads =3D 3; /* historic cap */
		else if (nr_threads < 40)
			nr_threads /=3D 2;
		else
			nr_threads =3D 20; /* hard cap */

So I would expect this to not be single threaded unless Git was compiled
without pthreads, run on a machine with few cores, or configured to use
only a single thread.  If you can get threading to work here, I expect
it will perform better, although I don't have any experience with bundle
URIs so I can't really say for certain.

> Is it expected that doing it this way is so slow? The alternative is to
> just package and work with the whole bare repo, but bundles appear to
> be an elegant way of dealing with exactly this scenario.

To be clear, it is insecure to do anything with an untrusted repo except
clone or fetch from it, so you will almost certainly not want to
distribute bare repos, since that will encourage people to use them
as-is (which is insecure).  Even if these are internal users who can
trust you, it encourages an anti-pattern which has security problems in
the general case.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Yg3JPT+DEwRW/KVi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmppRfkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0zXM82Pexkkg9aR2JSCOJDStKau6BqcfxIei7rOya9Z
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAPf1AP95/BM8TKVi2AwkdPIDi9jBvyVY
N5NTcZwEUYDdW7u0YQEAlSWifugbBmhK5u/NNx3AtWrjLJKmj6/SJJPhhTeJ6gU=
=28D9
-----END PGP SIGNATURE-----

--Yg3JPT+DEwRW/KVi--
