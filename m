Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37B4A64F6
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387748; cv=none; b=ieTq3dMmypchBw/wdD+AvgBrCkMQT7358b/uiW0VqOMrx1EG+VKnU1QeGAovEUTmZJfO7MWi7U7JfhfnO7PaArNQzKriDCAjT9PAauA/d3ekRGyzR3HlrGwTW5RogehM1YCFSfYqaPbBkDtflK1vEb1G1S/zrNXd0jrCNqpAic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387748; c=relaxed/simple;
	bh=7tLZfYz1LsLdc4YQUrWHExrujrwfY8BYdTcKrpqYsEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mg+6oFiLbVa/wJCxzuiJLnQ5lKjl0FpY85qWdTp8hzsOJRFrP9D7mcdLfLqoIoBHRnGdEqpRELtPv+gA6RwuAsEly5MfAK0x1D7wY6GIi6s6TsRfimzESRhwRQ4vB+qRur9fz5xNc37kYmO2zZYHzWl43g1EJZ3EQGYcABg6cxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O3r0iMFU; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O3r0iMFU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788387283;
	bh=7tLZfYz1LsLdc4YQUrWHExrujrwfY8BYdTcKrpqYsEk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=O3r0iMFU0YvfnVazLd7Ge5tYH5T06peHpjbmr4pWiS1SmPCdk7F9qAaD2EFJcZZhY
	 Bca2zL6UeWCAFBdg4Ws3EKkjAuFcjcQd4T+sGAcvEc9JhhtVTJhU9d1ke47HL2tSIu
	 r0jMP4eG9DJCsxEkHvz1xq0/5F+Nx0BVVaaeZQxiewib0HmqeS58WkE3HCZqkIsnea
	 EKmE/B1rZrCYPcRklIxfUH7rSKTLyTs4sK4ztb3wVCVnY8TYmvT5VL1wQ6Zr1D11BD
	 NtyT4HukbcHY74N8/vx3viJ8maqdXIfUpyxJw8Ov9+ICUc/oW2Vuga0HfXOZPWzusd
	 BMBHr7PGE4P17/ngHQg3T/Aj/3aKUkUs35YT5jyHM0ZauAwnUjY1wUCn00cI9/P7qH
	 lOk+5wyRpidzZ09Qbw/dxqvUDqrGbCowAGgkmBzkir10omIi5H4z4lNipm14wSf65R
	 UNKGrEwe6mCDWEKjaPjedGgAka0hm9GGm1QsmJhBG0cS6J9vmUc
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:73db:89bf:a07b:452])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 64EA220125;
	Wed,  2 Sep 2026 22:14:43 +0000 (UTC)
Date: Wed, 2 Sep 2026 22:14:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Alessio Attilio via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alessio Attilio <hello@kairosci.dev>,
	Alessio Attilio <alessio.attilio@protonmail.com>
Subject: Re: [PATCH v3] hooks: introduce 'hooks.allowNoVerify' configuration
Message-ID: <apif0QhIHkAAXJmn@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Alessio Attilio via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Alessio Attilio <hello@kairosci.dev>,
	Alessio Attilio <alessio.attilio@protonmail.com>
References: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
 <pull.2215.v3.git.1788369794965.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G+j+lhD1bIqkqn/U"
Content-Disposition: inline
In-Reply-To: <pull.2215.v3.git.1788369794965.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--G+j+lhD1bIqkqn/U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-02 at 17:23:14, Alessio Attilio via GitGitGadget wrote:
> From: Alessio Attilio <alessio.attilio@protonmail.com>
>=20
> Introduce the 'hooks.allowNoVerify' configuration variable to control
> whether the '--no-verify' (or '-n') command-line option is permitted
> during operations executing client-side hooks (commit, push, merge,
> rebase, am).
>=20
> Client-side hooks execute in the user's local repository and cannot serve
> as an authoritative security boundary; authoritative policy enforcement
> belongs on the server (such as via pre-receive hooks). However,
> developers often invoke '--no-verify' out of habit or muscle memory,
> inadvertently skipping local checks.

I agree with Junio that this doesn't seem like a good idea.  It's up to
the user whether they want to install or use hooks and they are free to
disable them or override them as they see fit.  If the user doesn't want
to use local hooks on an individual case basis, then `--no-verify` is
the right option.

In my case, I use hooks for Git LFS when I use that software, but I
never use repository owner-provided hooks, although I may use my own. As
a result, I almost never use `--no-verify`.

If in your environment you are trying to force developers to use local
hooks, the Git FAQ mentions that this is not an effective control and
you should stop trying to do that.  In fact, I would even argue that you
should simply not install hooks by default for repositories using your
scripts or build tools because it's up to users whether those are useful
for them.  The Git FAQ mentions reasons why forced installation of hooks
is harmful for many workflows and I don't think we should be hassling
users like that.

In any event, it's trivial to simply bypass all hooks by setting
`core.hooksPath` to `/dev/null` using a variety of different techniques.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--G+j+lhD1bIqkqn/U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqYn9EJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4xoE+zyaibRS8QrLHuQIpapt3yMNZ92oH40JrbgCymq
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAP5/AQDaFpCfy+bCGjggh2VXX7TzbrBF
R2cIfNAliJd8ASUyAQEA6HGMvuRsvLlTsyzHRvhlAOUhys3Z+DDLrI2CxlxVyQ0=
=r5dc
-----END PGP SIGNATURE-----

--G+j+lhD1bIqkqn/U--
