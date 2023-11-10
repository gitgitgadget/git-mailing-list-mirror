Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552E13FEE
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W+nQyXh1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qmWYxBqA"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552612810F
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 02:18:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 9A34C3200927;
	Fri, 10 Nov 2023 05:18:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 Nov 2023 05:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699611532; x=1699697932; bh=Iu
	iTE4FK/9Md7ugHoiE58EZ79VOkTTgVrkqiXTCgiDY=; b=W+nQyXh1Ud6y31O7lI
	0KG+s/kboHAuW/fYpLbXQO/0UPuKUEYF7MwfJ0CDk7VLxleG7S6jekX5dpobpC67
	4yQmoOhPwuS1wre1LlEPwiAEFuCu9VzHa/rcEf81h12RmZdhBlmgMMCeI9y1m7jQ
	J/7TZm3T5O1l9jzcAdDaiDSlEwturnnvQto6G9U3XkuhAYfLzKs/tC4MVrSoGWH6
	hj/eXy0roCFIDD4hukkJxsNski0X/H+4wXzQl6AJE69gNEA5GAk9C953IXAhitmM
	pB32fPpP8Ldf99aGShy89nd3IPn4iTiETSDaW0AsPcB+LLNo8WDy+4wVM9eGjYSd
	phRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699611532; x=1699697932; bh=IuiTE4FK/9Md7
	ugHoiE58EZ79VOkTTgVrkqiXTCgiDY=; b=qmWYxBqA2PJp3XzmiBhU6UOdVlLbT
	UrLNtwNeqWlzJ3ATt1V49d35sidTg+dmZHWMYnq6mBTxenV0UyOA6kzvODZWM/Ts
	rMQhRS1t/sftTul87c0+xkupjXno15xu0stKhHTR+qnV5NTkXyWxcaW8AUCGCADJ
	hBTKA4H20nLJgRuT4Ij5azCT4+Ay7WaYMrzgnnC672Z4HGSbEGOmuct9BY267psO
	7N76lviRHb7XRIaIpzpoj8lrk3EDKspj79hleCkhxrbKY6S8C4qsALopil6mZICb
	XnyLd66oHBZDZxExf8pfAipioBHx7i/Bx6WVvv9t4UpSZpoxwaiXQ976w==
X-ME-Sender: <xms:iwNOZQGZy-qeneh4qTu1p4AHde1Z8nicah3jnu22vRRuC4ALZKcz8Q>
    <xme:iwNOZZUnCRf9c1NTvXHZvCW9d1YFv9KtfIyyHBDsO3HDqDvl42KT1_l6J9LxbZzOG
    UPL09KETeiHSPUDGw>
X-ME-Received: <xmr:iwNOZaIQMrPKqwAKbXTAMRsv-omQ9U5FbtVIMwpG9un-LwIQJ07ZiQhYFPOEaYP6ImT7-r82wC2CoIvlZ64X4whBfOpP85rjbS84BXjlN8nkB63J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvfedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iwNOZSENfl3TqALSduu_wYAhvjN9pwxh3-5HvnWzxOAyHsNZaR-Uwg>
    <xmx:iwNOZWUBJwNtsPHaj5Yjg5Lx7afrKL_4J4ghGW_KtKkHr01ugF8xxA>
    <xmx:iwNOZVPy3sLT_reeb_ADRux8aMaGJxrdPgGTD1Ot0q5vZlbE3MyMOQ>
    <xmx:jANOZZc7g9cUIPiAkgrjWSFLbSfo89G6cH7J4hx33clqS0_KcKgYYA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Nov 2023 05:18:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6263108 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Nov 2023 10:18:21 +0000 (UTC)
Date: Fri, 10 Nov 2023 11:18:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number
 of args
Message-ID: <ZU4DiTQbKyuuT55k@tanuki>
References: <cover.1699526999.git.ps@pks.im>
 <b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
 <20231109185515.GD2711684@coredump.intra.peff.net>
 <xmqq8r76zg1j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cZm5518O11Nu7LkQ"
Content-Disposition: inline
In-Reply-To: <xmqq8r76zg1j.fsf@gitster.g>


--cZm5518O11Nu7LkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 08:02:32AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> >>  # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITO=
RY]
> >>  process_subtree_split_trailer () {
> >> -	assert test $# =3D 2 -o $# =3D 3
> >> +	assert test $# -ge 2
> >> +	assert test $# -le 3
> >
> > It took me a minute to figure out why we were swapping "=3D" for "-ge".=
 It
> > is because we want to logical-OR the two conditions, but "assert"
> > requires that we test one at a time. I think that is probably worth
> > explaining in the commit message.
>=20
> I wish we could write something like
>=20
> 	assert test $# -ge 2 && test $# -le 3
>=20
> (and I'd allow double quoting the whole thing after assert if
> needed) but we cannot do so without tweaking the implementation of
> assert.
>=20
> >
> >> @@ -916,7 +919,7 @@ cmd_split () {
> >>  	if test $# -eq 0
> >>  	then
> >>  		rev=3D$(git rev-parse HEAD)
> >> -	elif test $# -eq 1 -o $# -eq 2
> >> +	elif test $# -eq 1 || test $# -eq 2
> >
> > OK, this one is a straight-forward use of "||".
>=20
> Yes, but why not consistently use the range notation like the
> earlier one here, or below?

I opted to go for the "obvious" conversion, if there was one easily
available, to make the diff easier to read. We could of course use a
range notation like this:

 		rev=3D$(git rev-parse HEAD)
-	elif test $# -eq 1 || test $# -eq 2
+	elif test $# -ge 1 && test $# -le 2
 	then
 		rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"

Or :

 		rev=3D$(git rev-parse HEAD)
-	elif test $# -eq 1 || test $# -eq 2
+	elif ! { test $# -lt 1 || test $# -gt 2; }
 	then
 		rev=3D$(git rev-parse -q --verify "$1^{commit}") ||
 			die "fatal: '$1' does not refer to a commit"

But both of these are not consistent with the other cases due to the
negation here, and both of them are harder to read in my opinion. So
I'm not sure whether we gain anything by trying to make this a bit more
consistent with the other conversions.

Patrick

> 	elif test $# -ge 1 && test $# -le 2
>=20
> >>  cmd_merge () {
> >> -	test $# -eq 1 -o $# -eq 2 ||
> >> +	if test $# -lt 1 || test $# -gt 2
> >> ...
> > (I am OK with either, it just took me a minute to verify that your
> > conversion was correct. But that is a one-time issue now while
> > reviewing, and I think the code is readable going forward).
>=20
> Yeah, the end result looks good.
>=20
> Thanks, both.

--cZm5518O11Nu7LkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVOA4gACgkQVbJhu7ck
PpS3hQ//bwmEUQp0mgecOmHWmO0c+K3qFgsxmE4cgOJ9NUaN/cdxU6b9cZ1PFbdg
0ct0aEmq4qCjE/UmBZ0uL5SUy7E2rvT9vPGy9ysPHby4PKHo1YJjR5pmM934z4ba
e7sUpETtUEJ3i/NLqYP+T4hRupApR1Md+Mhnr2MCoWZH1LRIrfIsrEDt1inuXVY1
pTiYSFpcJ8j4WlVrtYYp907bC8qvtcNCy7N3fUzP7Hwzlj0DVaHJZMfMsIJ0ItSK
XxaOIQVh/84n+are6lSri4uzEXZXAC7gygssUA50Q2Ja8CSkTTi11Wk3UGsxfd/I
pr7KO+vxW84kP6+bJF1RzcwcKFLeZLKmy6G+a9fEnOa3SOq2JLx/LUyQePnWF1RV
HvtznxcFQZVxanSr030ypNZ0+Hp7dEw+ccWUe2LTnUZJMLOMKd8wrzENXDBC4PQV
S4/W6A7PNWx1wfAksLWB1bjHo/wYGmbLcFs2XliXWO/4R2bPRod02C6Ad3tonb1i
lMZWRh/mq/dKuqnf4XwExa6KjYM8R8upWNaob6DlZzjcTLnLLVcFWiHUZmVfHCPT
8njdizW/zaSLwiHDrSAydJD0dSUgGw2vLjoI3WCLuBHeOd95yIozMC91Z8QPfahl
iUelTaoMcoARySpAH9ZljJ1JL6Vmah2rb0dKiF2H0Sj6gVvyVDY=
=P/Wg
-----END PGP SIGNATURE-----

--cZm5518O11Nu7LkQ--
