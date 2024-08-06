Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804FF1B9B4E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722922201; cv=none; b=WjxbunT1G3q2J/P7Kl3kmY/g8n5voyX2Cew8r/YWMAo37mNBVE1HycWRkEpb62I4WhRtVM9+0oanbX7V3g7TXUC07/e5aDnMHsU3FNl6FtA5Tst0Rd8WRSCOxsC7L3a7IYeRqtaFA8h0tP6qedGFhyX5SG1993gD2nG15dKtCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722922201; c=relaxed/simple;
	bh=EmXK/n0pZOvwZzzQJ930NZkFu1P6sTYsXQMdz2+7jrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB5GOdN4g2yxx5zx4lm49pprnZdmJS+L0s7zdLlXYC2Q4PBqH/gB5OPh9zQJEIl4sWyUekpqqFhuCTamGz+U3BFme1JKdS6YvAv29a7LbttBSjtAZ0iVyV+3AMYx22pEcL51rRvWt72YqgbmvbBVAkpi5TxU6mjgB8e6d0Y+qg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m5T78aoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J7IU+F1x; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m5T78aoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7IU+F1x"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4300138FB12;
	Tue,  6 Aug 2024 01:29:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 06 Aug 2024 01:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722922196; x=1723008596; bh=cJ3zQj5xch
	jTBtvxtfIH4/SquoZfNtV+MpdSLJXk2yU=; b=m5T78aoZRk8fM3Xk29NiEJsXuN
	+ZL0leMtj718rYIGgSFqRO1RcWO8DZogJPQFzVBHCgUjFb3iVitvfIPUHi8Fx0Ra
	gLfZfmUfWNoP0bZD4s2EuGZ/CdViEIVwxOPBi8JJ4dtHCr7nKj4wefxIJ3vHkiyG
	gxnyMzZLFMVQJ/Cra91yAd4hD2eGnfa+wr+a425qiIxTphXpbM9O0Ityh8sGXvF3
	I3o4gZ5z5N9J/0HcX/wpRHDIPH+o1iZqUBE7zyxpYjGknFKWTd89H1z17ZgTCxvV
	hK6HC+cdBNG5R7vNUh4K2y4oLGFVQK7zlzT7/2oja//df1jl6sn4y58sA0nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722922196; x=1723008596; bh=cJ3zQj5xchjTBtvxtfIH4/SquoZf
	NtV+MpdSLJXk2yU=; b=J7IU+F1x8dbchOE7CCZEwlQoucnUKi5xpG5Huo3TUvUR
	hg7irrHdVgWEYuA84qnbiXu4FMAmc3fci1KcX05+8Z6NxWAC8irIPVq8DLAztUNA
	XHnFDdmYpJVci5Y4bQq4p3B1XqterE7oy82EuLzWvZI0QJR0TZjDqTYDDkh1kVTK
	XPYEmOIzMZB3nIgdgx0CGQeSAzlBtiH9fohc+zYrwlyq4vA1h1NSwNDzxbdzp9pG
	75pVYa+gl2XRp0SOgE2lKZwZVryj27x2UCosnWRUulufW/I+9N4iqYuxps8cGVdP
	LeHDIpMP5LRSFgT931EsM0RST/uPZuRN8D9qKTcVkg==
X-ME-Sender: <xms:1LSxZuAz628Vlw6Yt1cYJ-DZhYBRNA8W4ptWGsgiKSa5C0WKtAeTwg>
    <xme:1LSxZohyNlIi7FhVmTuL3YyTrsU-d3gz_ZrXaYCJhCt2KIa0gV2K6SGM8DRzecrqf
    7VsuJRpRcwfG17wLQ>
X-ME-Received: <xmr:1LSxZhlM1Wi97TKExl0Yo7moXqTMtJLSNsTqaS32f-Vkun8EIiqMdzlgaZt0hh_JuQC_aLwg-R0nUzEwfF_V5SjPKGQ5o-ZYwKzwXEL3GUKt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:1LSxZsxIH1-1QRDtVT34WOsKnc7kLt7trIEIzyAcA6JiQBG9cR8PFg>
    <xmx:1LSxZjQLDdzF05NNIolFLS1IG3DxeYtkRzmw1XFU93N4-8BCfrkZwQ>
    <xmx:1LSxZnYZdVZmd5vg1dgcQtbChyvLiVpYJ4Ppgei03eVpnGVjl_5cXA>
    <xmx:1LSxZsRsIUTji7xMaUTViE08hgB-AL1PzY-_UqJjcxoCdNJGIslpvw>
    <xmx:1LSxZiFRDW6U9DEjxO5HPekEgrFCYvb_fADkrr35Znh3sfian9SFGadI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 01:29:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b2561a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 05:29:50 +0000 (UTC)
Date: Tue, 6 Aug 2024 07:29:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrG0zr3Wh44a8GvF@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
 <ZrDtVJYoJJZDesB4@ArchLinux>
 <xmqq4j7y3kmt.fsf@gitster.g>
 <ZrEbllB6WjLfWqNZ@ArchLinux>
 <xmqqsevi220s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sSgZYQBVzPk2QFIL"
Content-Disposition: inline
In-Reply-To: <xmqqsevi220s.fsf@gitster.g>


--sSgZYQBVzPk2QFIL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 12:38:43PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
>=20
> > I agree with you that it would be strange if we do not expose any
> > interfaces for user who are adventurous. Actually we may simply add an
> > option "--refs-experimental" or simply "--refs" to allow the users check
> > ref consistency by using "git-fsck(1)".
> >
> > I guess the concern that Patrick cares about is that we ONLY make refs
> > optional here, but do not provide options for other checks. It will be
> > strange from this perspective.
>=20
> I do not care about strange all that much.  I however care about new
> complexity in the code, complexity that is not taken advantage of
> and is not exercised. =20
>=20
> You said
>=20
> > From the development of this series, we can know the main problem is
> > that fsck error message is highly coupled with the object checks.
>=20
> and even if it is true and we have problem in fsck code paths, we
> cannot see if _your_ solution to that problem is a good one without
> having the code that exercises your additional code.
>=20
> But if "git refs verify" does exercise all the new code paths (and
> the refactored code that existed before this series, sitting now in
> different places), then I do not have to worry about it.  My question
> was primarily to extract "even though we do not wire this up to fsck,
> we already have another code paths that uses all these changes" out
> of you.

Yeah, there is quite some complexity introduced in fsck code, where most
of the complexity comes from making the reportin functions more generic.
And we do end up using that in this series even if we don't integrate
`git refs verify` with `git fsck`. It brings us the ability to configure
the checks performed by `git refs verify` in the same way like we can
configure all the other checks in `git fsck`, such that we can enable,
disable or change severity levels for each of the messages reported by
it.

I think that this is a sensible way to go about it, and it leaves us
with a more flexible and consistent error reporting infrastructure that
we can eventually also use for other commands that git-fsck(1) shells
out to.

Patrick

--sSgZYQBVzPk2QFIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxtMkACgkQVbJhu7ck
PpTuZxAAmertnr+lSxUaOlSdp4xJYGiL1XQYWIlBuZxx/QKtV9g16bhxFtJ4sNfk
wPfAVF1U4p1jcKBwyPcq/Nszhya8OogV+2AV+s34rcozrzOhwThPaJygrltHPHPl
cmcifHiDJQb43MS1pPFIzgAoPG/lYBTH6D3+TQywdLyA2KvDZDkFuxDgvuGkXU/w
E+G+h8bKTAkKBjCNCyOdpP0QgviZzb82wOhpr4JvpUNfShT8+X3Z9SpHEN65XBAJ
u7WhI9WSSLhDs0zC+18Qd33WOl4rC/JPvtzDQwobQ9ijBvwgIc4hNywi3/Ry47Ja
YB6gJaP3hRYHLkK+a4hPxA+06GHDiFoFWDxBn7pxAmWLRoICp6NrWGHikuZH1ag6
b+RUeALj9L+qFUyCu9zTL3ZZQzmaTg9q0HZgMltCKKNNGOfNKoXnB7dh04vRgoRE
ZLYxnYNRuhUelF1JcHcN0JcOmKlBfqO2HM29cw+fms6iukWc5aF32P1WPE7ODc7h
LeYExrEOZ9Iy2FQuy1O81WYi7pB0/P8HExOwTjU7yh773X64SRTXM6h8gwtOAUoy
1emx+HODGsRy9W8SC20tI6UM+VIMhP7MpsCkBypVrH2VaI5rKzkrW+AF5lDw/rBK
ZsSRznQj1ahXc+zYiZPqOPZJwG4aG9q/X6hTdGZPYHsUKNtWfdw=
=gdom
-----END PGP SIGNATURE-----

--sSgZYQBVzPk2QFIL--
