Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E73DCD8F
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720358; cv=none; b=L3rsx/RyV5RURVDHJmoFhzAmfHV/GzwlWHi24l14pYutli9+f9MxAdJrTqlUGh3wCpNUFkfMviwRwv0FX8mSl8odSrKyh7vvppMily7c+dTO1BcjhU/Po36d15n7DExc2Lcx9zNJjpjuzfpYG3j8UraGhebN6nfCunVrlP6nDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720358; c=relaxed/simple;
	bh=gBW6AcfsYbd4ZAWc4T8DpEE6+k6IoFZsNrCmBUKO8Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBUEFVKKTahL+1YwqoNAK56LmcoZl/IV05FKvTJnh4tf6jFftkR5GnaAcKcXlrAnGRO9t6i3BqQksD9cQwru0QKNUBeKEmeWdFtMdZ7CE1zFaOr5RVCWLzf4JUCf9hcpG/1AQ+Neg9rWOhGNven0dQGjrQ1PQGJqaxJHRUGAtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VfmRSvmE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VfmRSvmE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1790720353;
	bh=gBW6AcfsYbd4ZAWc4T8DpEE6+k6IoFZsNrCmBUKO8Pw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VfmRSvmEKo0x4U841UyofXcXnKWnI8NAy18S+qd+EULwaMrTos/6vDFPKI2rwHCYy
	 H4yLg0234Y6x9hInRaRn11XK7KpJJE6KuO53SRrNfQA4oX6iNewgc5QjxkKwMqzP32
	 Mh8AFDliX0pqutUmd6RUFEQRJOwuC802L/4vzpyhVWBnCwWDE+DzL8B5MQOMTcKzF7
	 MnnDc6AQHM1sl8sxE763p/4L0KtimDwemrDb0tZ92RLMJHGrbNJfi5PliaQx7ccbA+
	 ni1ukufpDclyjpCkiu0eCR6UsAENyZi/90QfrTsuD5iFdHyLdFz6AgeaPaAzKES3of
	 ckUl47ovoy557rQPF7QyjmcmdqatRT0M8Uh+aBN/tMtxKGOFXWDXiXBDsH5BH0tGm6
	 1FZ1m3mbNZSxwXidnE8X0kjBBXdlQbe+ATN1XssOGqAQIGFdxRx7mZpfRReIduoyVF
	 WDclVCJ5gypZaQBvBGjotOV6qRTciLb22WpC7pOOywe6+rX6ELH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:52a1:d982:d7b8:f826])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 9ABE0200FF;
	Tue, 29 Sep 2026 22:19:13 +0000 (UTC)
Date: Tue, 29 Sep 2026 22:19:12 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through
 remotes
Message-ID: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hanan Arshad <hananarshad619@gmail.com>, git@vger.kernel.org
References: <CAKPibBw2XxjGpE_DZrWLZmMHs7kAyvOaP8504kfoh61c4UkGyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h2ONX2jzN9POdTnq"
Content-Disposition: inline
In-Reply-To: <CAKPibBw2XxjGpE_DZrWLZmMHs7kAyvOaP8504kfoh61c4UkGyg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--h2ONX2jzN9POdTnq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-28 at 14:27:23, Hanan Arshad wrote:
> Hi,
>=20
> I'd like to propose adding a small porcelain workflow for sharing
> stashes through a Git remote.
>=20
> git stash export and git stash import already provide a transportable
> representation of stashes. I tested the following workflow using
> existing commands:
>=20
> Alice:
>   git stash export --print stash@{0}
>   git push origin <export-tip>:refs/stashes/alice/wip

You can also use `--to-ref`, which is what I use, and then push that.

> Bob:
>   git fetch origin refs/stashes/alice/wip:refs/shared-stashes/origin/alic=
e/wip
>   git stash import refs/shared-stashes/origin/alice/wip
> The imported stash is a normal local stash and retains the original
> stash object ID. Removing the remote ref afterward does not affect
> Bob's imported stash.
>=20
> I'd like to add porcelain around this existing mechanism for four operati=
ons:
>=20
> 1- publish a selected stash to a remote
> 2- list available shared stashes
> 3- get a shared stash as a normal local stash
> 4- remove a shared stash from the remote

I think that at least 1 is useful here, but you're going to need some
sort of customization.  The name I use for stashes when I am the only
person on the remote is not the same name I use when I'm sharing a
remote with others at my employer.

2 is going to be hard because you don't know whether a ref is a stash
without downloading the data.  3 is also hard because there's no
standard namespacing and it's going to differ based on the context (such
as refs/heads/bk2204/stash or refs/heads/stash).  4 isn't that
difficult.

> This would not introduce a new stash object format, server-side
> service, or synchronization model. It would essentially compose the
> existing export/import mechanism with normal push/fetch operations.
> Before working on an implementation, I'd appreciate feedback on a few
> design points:
> 1- What remote ref namespace would be appropriate?

Again, this is going to depend on the user and environment.

> 2- Should shared stashes use an explicit user-provided name or an
> object-derived identifier?

Names are going to be nicer.  We don't require people to memorize object
IDs and allow them to use branch and tag names.

> 3- Should listing only inspect remote refs, or fetch the export
> commits so stash messages can also be displayed?

Stashes can be large because they (a) can contain untracked files and
(b) contain a reference to history, so inspecting only remote refs is
going to be a lot lighter.

> 4- What command naming would fit best with the existing git stash interfa=
ce?

Probably `git stash push` or something like that.

I think some nicer tooling would be helpful, so I'm in favour of that,
but I'm not sure that standardization is going to be possible.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--h2ONX2jzN9POdTnq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmq8OV8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ9XURJ5xTJlVmm+5WbP2//AzbY8sC3pD1ISkuAZiTJ0y
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANB6AQCpRAoWcNRimlXqDLp9zrdJx55F
gu4l/Y4K7AC0NA5SOwD/Ruuflxjvj0cJHRkhuBLTrmP/LV0e1+eplPmRVaa70AQ=
=S3ZI
-----END PGP SIGNATURE-----

--h2ONX2jzN9POdTnq--
