Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C4134AB
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764374186; cv=none; b=NgUzbrfr7GCPdV6qHeKLDA3bzEHOfytNZ8sVDOIwyNp5HKOJxRLSy3QoUdpo35JDLwbMjknPNsTqMAlLPT6Ol7/kWfqn9Z770xJ8m6wgzUGLkLsQYMiAYCSbQ3kl17/dXUrYtO2P/aJvn7wSZw6dWjdxlQePDqpCiwwq/WN52tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764374186; c=relaxed/simple;
	bh=IZQ3o6VqrgbExZYowed9t3nr8cN7GVBHiwkKF8Ua96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys3+EqMdHnKreFqOtX+ZABjn1Dw0WpwZxsP6J14qnu4PUMe7nlRhaCu3Ru8UYm0qFDzWVsdyFb2U8UrzDmP1J2o5MVitXfvlO2NyupA2S5JNo7cdJkWIAEKQL23dJ3ofO6+HttXG3Z30eHX2DRw590nkh9sw3zebsMTllMb8ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ctxx3ksZ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ctxx3ksZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764374176;
	bh=IZQ3o6VqrgbExZYowed9t3nr8cN7GVBHiwkKF8Ua96Q=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ctxx3ksZpYja/8uDxY4xQDnO8TNGrRf+DgP+/JP9FHSdFx3LAOkYCcDyydQs3nLkU
	 iXtp8o37ezE6ee7Zgek9x7l5rYJcHscNUHdlISSpp6xY9yE6b6fmEPnNoybskoUkCK
	 MmwHMYPVNQIOnLHJRKTMZj/t0jg0jaFkjgi4FEe2AU3FF599Ism6psy5hfqNJCzMUx
	 UHPcww+2DQmXAbVAZLPv5FW2YnzLDOTEl25TxwncN8F7nqIGtSsCmcqcKl2behV0U/
	 cFQsGF5kdZ3t1zZ7CTQa6V5h7Sz1BQaEJa8ytzGoI8iHAUGNsSWKJaWM+Lglp4rOwH
	 YzTlX8dPg8EuSekH18AllkUjdRD2jRSz9hYyfMCq0guAsvuYPp0ZHfsemrCLlBnEla
	 vvpbaZmRusZidcqmnNLr1/FyCcNZByxXU3P06XqzxKsMvzKR45J4qOAMxxljGASZ7t
	 kpCBn4adJ66sZ8pB7lzBLAKGsCkccoO8nohkTqPRx4I2244Wbel
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f543:96b1:e4f:3f91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E1D5B2003B;
	Fri, 28 Nov 2025 23:56:16 +0000 (UTC)
Date: Fri, 28 Nov 2025 23:56:15 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Justin Su <injustsu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: SIGSEGV when running git fetch
Message-ID: <aSo2n2dhEoZd3nZW@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Su <injustsu@gmail.com>, git@vger.kernel.org
References: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8n3usyn3uXlm1tXj"
Content-Disposition: inline
In-Reply-To: <CAB=S_8JufSGCOBjCQJ6R1Lq-GumJXTPzWGv2JCZK2SPw_XuGPA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--8n3usyn3uXlm1tXj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-28 at 22:56:19, Justin Su wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? `git fetch`
>=20
> What did you expect to happen? `git fetch` works normally
>=20
> What happened instead?
>=20
> ```
> $ git fetch
> Fetching submodule catppuccin/bat
> Fetching submodule catppuccin/btop
> Fetching submodule catppuccin/micro
> Fetching submodule catppuccin/delta
> fatal: Unable to create
> '/home/ubuntu/.config/.git/objects/info/commit-graphs/commit-graph-chain.=
lock':
> File exists.
>=20
> Another git process seems to be running in this repository, e.g.
> an editor opened by 'git commit'. Please make sure all processes
> are terminated then try again. If it still fails, a git process
> may have crashed in this repository earlier:
> remove the file manually to continue.
>=20
> $ rm -f .git/objects/info/commit-graphs/commit-graph-chain.lock
>=20
> $ git fetch
> Fetching submodule catppuccin/bat
> Fetching submodule catppuccin/delta
> Fetching submodule catppuccin/btop
> Fetching submodule catppuccin/micro
> fish: Job 1, 'git fetch' terminated by signal SIGSEGV (Address boundary e=
rror)
> ```
>=20
> What's different between what you expected and what actually happened?
> `git fetch` almost always results in a SIGSEGV, however the fetch
> appears to work

I went ahead and looked at the repository you provided in the embedded
archive and I think it's corrupt.  First, you're missing the `.git/refs`
directory, so my version of Git (2.51.0.338.gd7d06c2dae8) didn't even
think it was a valid Git directory.  I then ran `git fsck` and found a
wide variety of missing blobs in your repository.

When running `git fetch`, I did not get a segfault, but I did get this
messsage:

----
% git fetch
error: unable to load config blob object 'd38cf93d707c01ca18ed0233bcebb7aa1=
72f0edd'
fatal: You are attempting to fetch 06c0fdfd73559275c8d0423ddff0d3bcfd7e7f3f=
, which is in the commit graph file but not in the object database.
This is probably due to repo corruption.
If you are attempting to repair this repo corruption by refetching the miss=
ing object, use 'git fetch --refetch' with the missing object.
----

`git fetch --refetch` downloaded several objects, but I still have four
missing blobs afterwards.

So I would recommend running `git fsck` on your repository and see if
it's corrupt and if you're missing objects.  I agree that Git should not
segfault, even with corruption, but I don't see it doing that (granted,
on a Debian unstable amd64 system, not an Ubuntu arm64 system).  We may
have fixed the bug you're seeing in a newer version, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--8n3usyn3uXlm1tXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaSo2ngAKCRB8DEliiIei
gW7wAQCgM9d28zRW7cFejJ9kWNd/0/jEgjX1ITxP3qMWCub7fAEAzaRCEBoPM9Ai
vSJvt3xxBZ+oAREar6Sb1pAjmZJRKAE=
=5cQW
-----END PGP SIGNATURE-----

--8n3usyn3uXlm1tXj--
