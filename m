Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595A28BAB9
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770256439; cv=none; b=jQ2Jp9n7XctopsOCBKce8EZcRCYDAlCyQGzcuW4lZS2fzBpgwC+NXX8Lp/sGTI/MXPhNXfVsNxoaH14WuvJH2se6ywNlU9IXMI3L3bUE3R3KzamBN3Y5RPWH/YlW4ltlURoplDR4+ZZmklzG8D17ayEpH7XCSM8+huFZJ3XXjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770256439; c=relaxed/simple;
	bh=RSxCylwNPhI1LLzuaJgxm02ykNkBZ0vL2ayMifWkaTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu/Ddc26veBm54W0FyEdkF7rTlbGb/MbQu/slFtxQ1Orfa0QHnl4AWm9xzzmqu9urIhHmt1d0krN+pTbgQ+DMAIhFz9kO5JjVA1idw3Yn0GuByTXubFnV8qLhkxb+QzoERZMs58cH7G2j9VIb1ztRzg7aCKthA5Cp0FrSZXt8Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=qK35BxMK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="qK35BxMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770256437;
	bh=RSxCylwNPhI1LLzuaJgxm02ykNkBZ0vL2ayMifWkaTw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=qK35BxMK2tPUXlJKww+BvRsZ9fbq+v4/hBmLgKVHJbmhjGxeXkds64TDVxaJJ1+D1
	 hpDo4MJp01gXhP2nNk7y7yLbGbDS/wLIB30NjfhUbmV9u93Ui5z0Kq3RVlw0qjj5me
	 qHZDhYFVdx/z3V5B54LUHZgLAK72DC5RRwDzQVIcjyHR1t/4vTU1/S+vggBrT1PHzW
	 pJXJbl+YitaxsHziYGSXMo/ryi7auT8ppWzVUdj278OcKirj9BIFS3jATnoGHqPYHV
	 NN7LuwpOFTGm7A5bOI25QfASCcU1JSkc2adZkle/5MNq4rFvRH9VQYKrYaVuvJnfr3
	 XA3zfle5flKY7XUhgt+6Zgzi3Km9nrLZc5t2CnbCNOuYy8wspfI3mkUpFi0+bD0t+r
	 efpUJf8hNG7XPRaX+U93reZSoqRnHrsE8Vv2vhNe+QY/Wy356wmWzQtL740IzF6Xca
	 L7uK93ND0R/FC/t6M61yaRj9HnEpNwswiHwHexSAZ4AuboUpjID
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:139e:b5f:f1d6:55e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D2641200B0;
	Thu,  5 Feb 2026 01:53:57 +0000 (UTC)
Date: Thu, 5 Feb 2026 01:53:56 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
	Phillip Szelat <phillip.szelat@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
	insolor <insolor@gmail.com>,
	Kateryna Golovanova <kate@kgthreads.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ray Chen <oldsharp@gmail.com>,
	=?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>,
	Fangyi Zhou <me@fangyi.io>,
	Franklin Weng <franklin@goodhorse.idv.tw>,
	Git List <git@vger.kernel.org>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
Message-ID: <aYP4NLj-W0oF68c1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
	Phillip Szelat <phillip.szelat@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
	insolor <insolor@gmail.com>,
	Kateryna Golovanova <kate@kgthreads.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ray Chen <oldsharp@gmail.com>,
	=?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>,
	Fangyi Zhou <me@fangyi.io>,
	Franklin Weng <franklin@goodhorse.idv.tw>,
	Git List <git@vger.kernel.org>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
 <CANYiYbEpfC1TO13U1DF+3ZmBYw=HkgFtZvpWdiZ5PaJLw6t-Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4PwoEpAHHRJWPPRK"
Content-Disposition: inline
In-Reply-To: <CANYiYbEpfC1TO13U1DF+3ZmBYw=HkgFtZvpWdiZ5PaJLw6t-Yw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4PwoEpAHHRJWPPRK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-02-05 at 01:04:51, Jiang Xin wrote:
> To clarify, the intention is not to enforce automated translations via
> a central bot. Instead, each l10n team should retain full control over
> whether or not to use AI assistance in their workflow. The recent
> commits in the git-po next branch only add optional guidance in
> po/README.md to help AI agents (if a team chooses to use them) perform
> specific tasks more effectively=E2=80=94such as recognizing glossary terms
> from the .po header, locating untranslated or fuzzy strings, and
> splitting large files for easier handling.
>=20
> We fully acknowledge that AI translation quality varies significantly
> across languages, and for some=E2=80=94like Swedish=E2=80=94it may not ye=
t be reliable
> enough for direct use. The goal is to provide tools that teams can
> optionally leverage, not to replace human judgment or community
> oversight.

My experience in seeing AI translations is that they tend to be of
poor quality.  Certainly, I'm only a native speaker of English, but my
reading and writing skills in Spanish and French are somewhere around B2
or C1 and I've seen some AI translations that are frankly just wrong,
making errors that no human would ever make.  And Spanish and French are
two of the most spoken languages on the planet, with hundreds of
millions of speakers each.

I also will share with you the experience of a colleague of mine who is
a European Portuguese speaker.  Most of the AI models produce Brazilian
Portuguese, which is much more common (since there are more people in
Brazil than in Portugal), but can vary substantially from European
Portuguese.  (Most FLOSS I've seen has separate pt_BR and pt_PT
translations for this reason.)  This means that these tools are going to
produce bad translations in such a case.

I strongly feel that we should provide people good quality software,
which includes good quality translations, to the best of our ability.  I
realize that this demands extra effort from humans to do good quality
translations, but I feel really positively about the quality of the
translations we have in Git: they are overall excellent and it is only
extremely infrequently that I've found a problem (which is usually a
typo of some sort that anyone could have made).  Considering that most
people on the planet do not speak English and that even those that do
may not speak it fluently, it's of the utmost importance that we produce
the best quality translations we can.  I don't feel using AI-generated
translations would be honouring our users in that way.

Finally, we have this text in SubmittingPatches:

    The Developer's Certificate of Origin requires contributors to certify
    that they know the origin of their contributions to the project and
    that they have the right to submit it under the project's license.
    It's not yet clear that this can be legally satisfied when submitting
    significant amount of content that has been generated by AI tools.

    Another issue with AI generated content is that AIs still often
    hallucinate or just produce bad code, commit messages, documentation
    or output, even when you point out their mistakes.

    To avoid these issues, we will reject anything that looks AI
    generated, that sounds overly formal or bloated, that looks like AI
    slop, that looks good on the surface but makes no sense, or that
    senders don=E2=80=99t understand or cannot explain.

It's my understanding that copyright attaches to translations, at least
under U.S. and Canadian law, and so the sign-off requirements would need
to be met here.  So I'm afraid that we wouldn't be able to accept such
contributions if they were made due to the need for sign-off with the
DCO.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4PwoEpAHHRJWPPRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaYP4MwAKCRB8DEliiIei
gfstAQC0NcEI+qH1HzAONWHWASBb2JTJzq4WKtNfTE+fzCta8QEAlvmr+VLnw3gE
9VEXObJl0qYZdG/SQR2+JIdgET9f+AM=
=t5zR
-----END PGP SIGNATURE-----

--4PwoEpAHHRJWPPRK--
