Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A86943F092
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236115; cv=none; b=bCVlJaAcQpRLhVUR3bxsze1riLUL4KQdYy1KaYlijLCuWMm5XxNRg9poqMw+K7oqRrIR3cIsSxBcD9rwV1IY5OpnA4v5nJXohbQEX4gYArDR69dnqdKdkwDsvdqNiQIZh8pSkzN/GMjSPZUAzxO73/7tc++VX2HN93fLyv7KQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236115; c=relaxed/simple;
	bh=mt6mjrBsagnytxs0dB6DuWyfswWutTSMZU8sRDnYwAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue1MepRx1pMJjCDTh2qvTgcgO696P1QSuNQMSzpzksYh41g0r5DynIDrO24k3rkOqJSzkidEjfmXhjD9R4A0gvUBNv1zrbsU27Wc/pg3sGbOihecFL1gsQFCk1fL80C61iaqPIcOOrD0TscIbSuqkyQZEQi9rkgyrogFyewy0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=DuY8gcSs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="DuY8gcSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1784236106;
	bh=mt6mjrBsagnytxs0dB6DuWyfswWutTSMZU8sRDnYwAI=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=DuY8gcSsb2xQZWuuBHDPIE7vSQiV7QeLvRoDPHqYIPFQgCgHdf/CO7yLjQW3EMZsD
	 Ex0rhgDZIygdCUyeP2QcHUyxXRiJy04JlBa6cFmzoZGxL+yA1PSzz9unYwQhLnoQ4H
	 koJBLe28QiiZ77mM3Br4Qgrhm2ap8domsZobRydCeblFKxXLTZYMwO70eXS7MqfwyI
	 xg8Zu2MHTBFs6jNq/hzA5VQwv7gwirr94ipqFWiNKUOVJ4kBECDGdUm73ERBJ6Dze6
	 VF4KwQP+vZIhNHaNCvP7f5GzlL1TEcpRLOweoT+bNBfpFVirNbgIeJOcywfpn5YMs4
	 wHs1zqAEaUx/w/99hobeWoCMtqkH44H6ccbtMa0s2emh3dhvS/z9YJd4ouTwymBhxd
	 IIOUFnzKtivXe8IxKKmtJIiovlFScbD68FIO8ruYiOGMbrHJdikVOxwjc6pmo9zTWG
	 pw3NL3w3udcIXIznwpEgBfqEm16qd7Dz7kIJtNWd2kLgEZaZNlD
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:437e:72d3:194:4004])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 29BAE200B0;
	Thu, 16 Jul 2026 21:08:26 +0000 (UTC)
Date: Thu, 16 Jul 2026 21:08:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Emin =?utf-8?B?w5Z6YXRh?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Greg Hewgill <greg@hewgill.com>,
	Micheil Smith <micheil@brandedcode.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Emin =?utf-8?B?w5Z6YXRh?= <eminozata@proton.me>
Subject: Re: [PATCH] stash: add 'rename' subcommand
Message-ID: <allISNh-b6Sc6y5-@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Emin =?utf-8?B?w5Z6YXRh?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Greg Hewgill <greg@hewgill.com>,
	Micheil Smith <micheil@brandedcode.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Emin =?utf-8?B?w5Z6YXRh?= <eminozata@proton.me>
References: <pull.2180.git.1784190706028.gitgitgadget@gmail.com>
 <alitkCsplW_DIaRw@pks.im>
 <xmqqh5lyhlp6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r96HGVJunnCiJ1t5"
Content-Disposition: inline
In-Reply-To: <xmqqh5lyhlp6.fsf@gitster.g>
User-Agent: Mutt/2.4.0 (2026-06-19)

--r96HGVJunnCiJ1t5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-07-16 at 17:46:13, Junio C Hamano wrote:
> Asking for the actual use case is indeed very useful, and I highly
> appreciate the nudge.
>=20
> "I cannot reword the message shown in 'git stash list' without this
> change" is not a use case.  It would be far more useful to know
> what real-world task you are blocked from accomplishing just
> because you cannot reword a misspelled entry in 'git stash list'.
>=20
> Personally, I cannot think of any such roadblock.  If I find that
> a stash entry is worth tweaking right now, I would probably
> create a new branch for the task, unstash it there, and either
> make further changes or record the exact state with an updated
> message to help my future self.  After all, having a branch I
> can start working on immediately is far more useful than having
> the same stash entry with its spelling corrected.

I have a large number of stashes in my git.git repository (211 at
present) and it may be that I, in a mad rush to solve some problem or
another, went with the default message.  I do this kind of thing with
repositories at work all the time.  But it's inconvenient to have to
search through `git stash list -p` to see which change it was and which
stash I need to pop to resume my work, so I can see the utility of this
approach.

In my case, the stash is likely on an existing branch (such as my
sha256-interop branch), so I don't want to create another branch right
now, but I do want to distinguish a couple of different stashes.

Of course, I don't know what Emin's use case is, but I think it would in
fact be useful to have and I can see myself using it. If my use case is
valuable to others, anyone is free to summarize it in the commit message
as a justification.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--r96HGVJunnCiJ1t5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmpZSEgJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ2TqWhErr73MfNh+4Hb0WwZdlww+3r/XYfN/NR0gO880
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJ8uAP9pKbw3XiMJTUfA3I1ysP+LsW3s
H3aSgkoZis6gt1Ji2wD/dAvfeVEIUW06ntMSJoa+Uzrp7Pmmb+QyFG5Tgd3PSAo=
=ipZq
-----END PGP SIGNATURE-----

--r96HGVJunnCiJ1t5--
