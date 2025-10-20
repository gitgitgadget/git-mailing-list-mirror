Received: from www130.your-server.de (www130.your-server.de [88.198.195.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A920468E
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.195.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973856; cv=none; b=ICTOZHoHPLZx9JE/BPh9eWxcLwOoHKnuHGwjyHPS5exauucE5UiPE7nCD3zuAR7rVejfnlS+R4wrIJWqx4mIpPQGeF/rJUz736T4Drr4E0zN9X4ITu1PG934ETlgdzTjn6zJZH3e4dA+PmOPI7khFVhy5LItsfcj8UtyFdQWe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973856; c=relaxed/simple;
	bh=YG+xyWgzz2TIxyK1hGpy8rYVswy3lWdRsl2wri9Gd4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIPM7BTKoaA5MKgmYh73UCtECDmYE3GZoCCQl0RRFjCp/ZLdME9qCtcvY7RXqFLVbSVi8EsrnsNd3d+FqSU4xeP9+9KJe4RhiWFNut/lN/qkx6N4255btpcY2/webXs1XpQp1nbLZohnYmgaA9X67bLjS4RJSZaYLCDlLO0ELNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de; spf=pass smtp.mailfrom=virtuell-zuhause.de; dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b=k4xCAdt/; arc=none smtp.client-ip=88.198.195.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuell-zuhause.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuell-zuhause.de header.i=@virtuell-zuhause.de header.b="k4xCAdt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuell-zuhause.de; s=default2504; h=MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YG+xyWgzz2TIxyK1hGpy8rYVswy3lWdRsl2wri9Gd4I=; b=k4xCAdt/+bJ+r1PrH72C9IXXls
	PW2PXh4ksCYN4pVdz217lFwmQlXcHkNpXsI7YGsKctF7gff4rwu6ZC2TN4QlWPRJOP5ZX6w2vavxj
	yPzo0PWyKJNIsncB+CY06ZsPxuEMdjkcB4fbsGkW1MoRR18Imp7NY2XIP7ZqXryVv97yNhvnQzt/F
	awI3nzPyxHLmCy41SvdjgE13U4E4Bqmm0halcWpEd5zQX7dQHOwfJ2r0Dx0jZ8kKTuGzPtjCnMURB
	WDOFboADqehqkEzsQYfgytgWgn8ZV99npnp8I8z7HMgj8DowpZngHAqKReF2gPNEHHD3WE/hbsswM
	0edz98cg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www130.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1vArjw-000JQO-2x;
	Mon, 20 Oct 2025 17:24:04 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas.braun@virtuell-zuhause.de>)
	id 1vArjw-0001QZ-1g;
	Mon, 20 Oct 2025 17:24:04 +0200
Message-ID: <0ef23314ca63d03467a50a93d2db1db3ad950ede.camel@virtuell-zuhause.de>
Subject: Re: Making git grep ignore binary the default
From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, El_Hoy <eloyesp@gmail.com>, 
	git@vger.kernel.org, Jeff King <peff@peff.net>
Date: Mon, 20 Oct 2025 17:24:03 +0200
In-Reply-To: <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
References: 
	<CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
	 <xmqqsefhxlmd.fsf@gitster.g>
	 <0de410fa-22ef-4495-a6a9-dcd33a329201@virtuell-zuhause.de>
	 <aPLkuPgirAVHkERr@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.0.9/27798/Mon Oct 20 11:37:28 2025)

Am Samstag, dem 18.10.2025 um 00:52 +0000 schrieb brian m. carlson:
> On 2025-10-17 at 23:29:22, Thomas Braun wrote:
> > Am 17.10.2025 um 23:29 schrieb Junio C Hamano:
> > > Simply because we have never needed to do something similar to "-
> > > a"
> > > and "-I" that we added in early 2006 for the past nearly 20
> > > years.
> > > Also because GNU does not have any such thing to force "-a" or "-
> > > I"
> > > as default.=C2=A0 The biggest reason is that it would be surprising i=
f
> > > such a change does not break existing scripts that have been
> > > written
> > > by people over the years.
> >=20
> > And if we only would have the config option "grep.ignoreBinary"
> > defaulting
> > to false with no default change whatsoever? I always want to ignore
> > binaries
> > when grepping and find it a bit tedious that I have to spell it out
> > all over
> > again. And yes I do have an alias as well but usually don't
> > remember to use
> > it.
>=20
> As Junio said, this could break existing scripts.=C2=A0 If I write a
> command which uses `git grep` and expects to find all matching files,
> it would not work on your system with `grep.ignoreBinary` set to
> true.
>=20
> For instance, if I am working on a project for a company and must
> exclude source code with a certain vendor's copyright (because we
> don't have permission to distribute their code), then it would be
> very bad if I accidentally distributed that company's binary files
> due to `git grep -l PATTERN | xargs rm -f` not matching them since it
> would violate the license.
>=20
> This is just an example, but there are lots of cases where people do
> really want to search every file.

I understand your use case. But if you don't control the environment
(git config settings among others) your task of finding things reliably
will just very easily break.

Also in your use case, I either opted in to ignoring binary files, so I
should be wary of scripts assuming binary files are searched or I did
not and then nothing changes.

> > I'm also curious what people are looking for in binary files with
> > git grep.
>=20
> It's common to mark PDFs or PostScript files as binary because they
> often contain embedded binary fonts, but they are actually mostly
> text
> and can be usefully searched with grep.=C2=A0 For instance, I once create=
d
> some awards for a non-profit based on combining standalone text-based
> PostScript code along with output from groff, so those independent
> pieces could end up being source that you might store in Git and
> search,
> even if many configurations would use `*.ps -text` in a system
> gitattributes file.
>=20
> Sometimes you also have images or such for a website, which contain
> XMP metadata (a form of XML-serialized RDF).=C2=A0 Finding those images
> which have certain author metadata or a certain license URL embedded
> in them could be valuable.

Thanks for the examples.

The previous discussion dug up by Junio and Peff was an interesting
read. But from my understanding adding a git attribute like grep, which
allows to ignore "uninteresting" files for grep, does not solve your
backward compatibility concerns. Changing that looks easier now to be
done in 2012 comared to 2025 ;)
