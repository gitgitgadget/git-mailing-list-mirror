Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D61465B7
	for <git@vger.kernel.org>; Thu, 16 May 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864729; cv=none; b=I7Db7ZzvfscuSWQXnfPgBi/64vI/I7R4Q/p8VjDAZMVnmGbUPgffbtBixQyoZ74dTTUqyWO80ZIE7Rs70MBSFXVady+cmszbwcxmzRqaLclbXwq/aON+C+DfzSkKEHj2oE+gat0QuzW6rAn+gL8A5ZRAXOjpan1CHclbcLQJG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864729; c=relaxed/simple;
	bh=8+RO2m33wZisf3z3JdUsC0EWJNyYIUiPCZbYQ5SdFRM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fv9GQRnGNf3K6GtI+qXbnS2EiWX7G3Ljfmns6eNnZqYZqc4Ef/Sj95FIHFtRU+DI6OFa31zl6lA1q+wM9ZImmXhR9emRyHeA3OxDUUZ9vNoS8Rejtnejh+A2g60cGe8GKlcbTdCLc0xBjfHKAJ7Q6KCzy8hScINGEgVeqKTpE3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=ntZnv5ql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ti6uti+P; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="ntZnv5ql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ti6uti+P"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id EB232180008D;
	Thu, 16 May 2024 09:05:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 16 May 2024 09:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1715864724; x=1715951124; bh=KSNGnH9qxPf8NyIHDOHqFcUrPG9NAwZW
	tlZ5Xe0+mME=; b=ntZnv5qldq59qhjB3/ZE5HDsf2gZIsGjYlM+k0JuLWLuyhDP
	CYDBgdOPbo7GIe5OS/OLKfGhPgO8NDboAbB9Wnhyj8C0B7yIgCKNV/d1JU+Rk4m3
	HB0QoExaAu67EHwgr645v3yV/vuux+TvFk7LpaZmhDlbcpg8Mjxh1nmQz3iiRmpl
	WhrDWpqLiZNqiBrNd0tLMLTsd/rQDKuG4RmgWTuvie0vNDlD4BoKkAQcQYiPKr0Y
	hzrukACGnGkR5+Dh/GYu154/EQ19qCiWI3hH95VeGjbogaZGay+J4z9QJkKVx9fb
	6+IIgZJXyrT+o8B2tiFgnKgGAAQN97A9xgirGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715864724; x=
	1715951124; bh=KSNGnH9qxPf8NyIHDOHqFcUrPG9NAwZWtlZ5Xe0+mME=; b=T
	i6uti+PfWoD5cFX3YuYPA/cKsu1Mzg6l/R0IOv87S9bLC7Ib5WJwD0+UPh2qAP3M
	XCd+5SuRwFuG3CiVcLRHFVH1wB6dbkQEcqCeYEi+E+zXaJ0o57FiUGP+Eov/S7kY
	p7QcokklDFz3x3dTLvPUnstSlJ/wVkufJVF302Y/bQDSgslVTsO36z8Oo8K+koiT
	PZZWovJZg7QEZgLKh2wEut6iXSG4LJ37E3e1myP5tMQreDfMBDFpIm7DchnXbQTU
	N5qFOQ3gs+WjUE2ArpA4w+I8PrYl4cWvBsULlUFVvt/Rdo/pnQ4WjZ6vuEkSuQ7A
	8txzdZcGiAglVy30ZnJmw==
X-ME-Sender: <xms:kwRGZot2Qj7U20ap74uB3H3UKvqGNH84yGVOMp5CPLywgHj1umJl3g>
    <xme:kwRGZld351LYEMUF6Je6SaaYq0acUPRtAXzJIqVvZ7DgnNhWPotnsy7V-BBrIzCcc
    mnYUxouYkTzttGL>
X-ME-Received: <xmr:kwRGZjxSWq-4Dr8zbc8VIbTAi2ne3ypQddMsQWny9IBSv6aQ-OpYC4MIey67FlTT7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeeurhho
    ohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegrlhgthhgvmhhishhtshdrihhoqe
    enucggtffrrghtthgvrhhnpeegjedvuedvteeileetuefhheeikeekfefgvdfhleeggeet
    heeuleefgeelvdeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghrohhokhgvsegrlhgt
    hhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:lARGZrNXiuvTPqredxu50k1kxh87aKhs4PAgtXkE8OeU_KlzwJrgNg>
    <xmx:lARGZo_t-eNYwRzy_36sjRvix9Tb4bVTf9b2imNApwUFpBnH6SCQnw>
    <xmx:lARGZjU8kx-rtAxlnqFMG78zTwBcpUsLu1Z5Di1tnyc8_FdVHkoxFQ>
    <xmx:lARGZhfSQaOorIEeB4mmFIcFfCIix7tmuqOzNOnwXXxEj_4ZuN2FfA>
    <xmx:lARGZnYTsQj9h8As-MdF1HPA3UpPgLgcl0ZDV-Nf_JH2h2kKUXO6Rb0l>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 09:05:23 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Git 2.45.1 - What is the right way to clone with global hooks
 disabled?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de>
Date: Thu, 16 May 2024 07:05:12 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <30AB54F7-DB53-40AC-BB43-1544A8128AB2@alchemists.io>
References: <FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io>
 <5b3b0882-eb98-558b-3fd1-40cc4cec3ba0@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3774.600.62)

Hey Brian and Johannes, thanks for your feedback. =F0=9F=99=87=F0=9F=8F=BB=
=E2=80=8D=E2=99=82=EF=B8=8F

Brian, true, the Git LFS issues don't necessarily help me.

Johannes, yes, your patch would definitely be of great help to me. =
Thanks for doing that!


> On May 16, 2024, at 6:13=E2=80=AFAM, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>=20
> Hi Brooke,
>=20
> On Wed, 15 May 2024, Brooke Kuhlmann wrote:
>=20
>> With the release of Git 2.45.1, I can no longer do this when cloning
>> trusted repositories (my own) for build and deployment purposes:
>>=20
>> git clone --config core.hooksPath=3D/dev/null =
https://github.com/bkuhlmann/infusible
>=20
> Ah, that's a clever trick. The clone protections try to prevent =
overriding
> the `core.hooksPath` with a valid (but not intended by the user) path.
> What you are doing is to specifically turn hooks off *1*.
>=20
> I plan on sending out a patch series later either today or tomorrow to
> address a couple of regressions introduced by v2.45.1, and this patch
> would address your specific scenario:
>=20
> -- snip --
> diff --git a/config.c b/config.c
> index 85b37f2ee09..380f7777a6e 100644
> --- a/config.c
> +++ b/config.c
> @@ -1527,6 +1527,7 @@ static int git_default_core_config(const char =
*var, const char *value, void *cb)
>=20
> 	if (!strcmp(var, "core.hookspath")) {
> 		if (current_config_scope() =3D=3D CONFIG_SCOPE_LOCAL &&
> +		    (!value || (*value && strcmp(value, "/dev/null"))) =
&&
> 		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
> 			die(_("active `core.hooksPath` found in the =
local "
> 			      "repository config:\n\t%s\nFor security "
> diff --git a/t/t1350-config-hooks-path.sh =
b/t/t1350-config-hooks-path.sh
> index f6dc83e2aab..1eae346a6e3 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -41,4 +41,8 @@ test_expect_success 'git rev-parse --git-path hooks' =
'
> 	test .git/custom-hooks/abc =3D "$(cat actual)"
> '
>=20
> +test_expect_success 'core.hooksPath=3D/dev/null' '
> +	git clone -c core.hooksPath=3D/dev/null . no-templates
> +'
> +
> test_done
>=20
>> I have automation in place where I want my global Git Hooks to be
>> ignored when cloning like this. The solution is to do this:
>>=20
>> GIT_CLONE_PROTECTION_ACTIVE=3Dfalse git clone --config =
core.hooksPath=3D/dev/null https://github.com/bkuhlmann/infusible
>>=20
>> ...but is there a better, more secure, way to clone a repository =
while
>> ignoring any global Git Hooks from firing without a lot of effort?
>=20
> That is certainly a good work-around for now. Thank you for the =
report! I
> hope that we can address your use case in v2.45.2, hopefully soon.
>=20
> Thanks,
> Johannes

