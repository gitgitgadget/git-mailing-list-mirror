Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D88489893
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574097; cv=none; b=lDaPLlNX4zqlz/E9y4YoiCBaqOQhu+m/UW7kBxQlbO0Qhfr6h3eWdMfkey0CKjQjJBgncuhEv4GSroCjl4A/3NYxsmgDYU71BMADqi442SDBf0IDq3RaOpyTLTZ0Vywp06cAsEsfWLxLUXjFvu49t72o84azi5nuuUsDUXsFOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574097; c=relaxed/simple;
	bh=IoS/fEvD51WNrPlAJ+xSuNQJGpYECmis2hM+v5LnOv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKAOV4TZskoX8zZCnlXChNPNBGoutbNV61I0U0c5oYdUMrZgz07t000hcrSqAVqRoepvVBiuva3ywYG+qyLZ8T7NFZCJH2C7fbtyiBduYeUN1FY4XAGlQ/TZD2/CTgTnzK7Szu94b6IbyMTQNrS6GrZtaegDH/onxTP+od7820k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=RanNcl5B; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="RanNcl5B"
Received: from cixi.localnet (unknown [IPv6:2a01:e0a:b3f:5350:b6e:bf81:919d:c0f3])
	(Authenticated sender: tnemeth@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 399D913F880;
	Sat,  1 Aug 2026 10:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1785574093;
	bh=IoS/fEvD51WNrPlAJ+xSuNQJGpYECmis2hM+v5LnOv4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RanNcl5BvchYNMsbIXxBqs2aAqDvimXFO06XEBxx/5Fxu2BJqP9HLudLK/h9wZ+i/
	 RCCZ1qD3PU/dS0EMYzwqk6DbAlKZ+GaCyELUV/0Dco+1GQeolK6huT6JYA+JMmjj/x
	 S6BIBAMG7rp8VLtdP36iGUFSnA2Mn6/T6/CoaMI50FhDofxFzLfWJmE+1lN9a98G6E
	 1yls3qbMH7jLhZ+EUcntQeLcE3U7GscJTNuvEdeNrbVbGIdGJ1mJmvajoDpkLw6Yks
	 yvlLuFvNTUv2BPjNXLEihaKXHCXdtCl+7V3vQm/SeN1X3I+of5wfjtog7bVHSEQWlj
	 1Sw60cnsOAFlQ==
From: Thomas Nemeth <tnemeth@free.fr>
To: Ben Knoble <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
Date: Sat, 01 Aug 2026 10:48:11 +0200
Message-ID: <3433010.aeNJFYEL58@cixi>
Organization: =?UTF-8?B?ZMOpc29yZ2FuaXPDqWU=?=
In-Reply-To: <06230920-FCA6-495C-BFE5-04DF1CC2A426@gmail.com>
References:
 <5097209.GXAFRqVoOG@cixi> <06230920-FCA6-495C-BFE5-04DF1CC2A426@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Le samedi 1 ao=C3=BBt 2026, 02:05 Ben Knoble a =C3=A9crit :
> > Le 31 juil. 2026 =C3=A0 20:55, Thomas Nemeth <tnemeth@free.fr> a =C3=A9=
crit :
> >=20
> >    I wouldn't say necessary, of course. It's -- at least -- my
> >    preference. For _my_ use case, it's useful. When I move code
> >    around, and that code is at the end of the file or to be put
> >    at the end of the file, I find it easier to already have a
> >    blank line there. That is... Because that's how I use vim to
> >    code.
>=20
> I use Vim, too, and I=E2=80=99ve not personally encountered the desire for
> keeping a blank line at EOF (though occasionally certain operations
> benefit from placing one there first!).
>=20
> I wonder if you could describe example workflows that lead to this
> desire? I might learn something, and in exchange, if I see a way to
> accomplish the same thing with less hassle, I=E2=80=99ll suggest it ;)

    It's hard to describe something like that :)

    Imagine you are editing a C file. It contains functions, code blocks
    an so on. I usually organize my code as such :

#includes
[...]
#defines
[...]
static variables
[...]
static functions()
[...]
public_functions()
[...]


    Code reorganization happens quite some times during the development
    process.
    If I need to move a previously static function at the end of the
    public functions section, I switch to VISUAL, select the function
    to be moved with the blank lines above (I like having neatly spaced
    code) _and_ including the eol of the function last line.
    Then I delete it (d), I move to EOF (:$). As the line is blank I
    just have to paste (p) it back there. The function is moved. The last
    blank line is kept for other code movements.

    Conversely, I can select the last function to move it upper in the
    file.

    Adding new functions is also eased. It may be because I use only a
    few vim commands (especially I rarely use the `o` command). But also
    because I like spaced code :)


=2D-=20
Thomas.


