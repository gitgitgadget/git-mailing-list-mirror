Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QOeTUW82";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0BikgX/+"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27B410F4
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 02:12:01 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id EAB5932001FC;
	Fri, 24 Nov 2023 05:11:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 24 Nov 2023 05:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700820718; x=1700907118; bh=5Y
	69eY90pSMsfK9wfbERdwj+JivaxvHnMUj7jHapdfY=; b=QOeTUW82hlUou13wgi
	PM3M8glizVMhE2QTP8Rhwfat8rCxkZAEC/+OQnYSDhi+/anNyAAgMA0MFIXOn2Rw
	12NHzvWHd5mIw/XUcOweafoq1Hi2PZnpcjm3suiGZT+uaiyoqdSC4SxHcZdJNN8Z
	wHfnREvlRwa6xbofzEDAcTDek2Uiqg02edRx95tq1lgc6OsqatO2O3ZPfyXtVs+L
	hYN7OYtl/jKqFXEA+bbF2xQihxh565p8R8idS+PpZkzkSbOITUVZkbGBsi5sgNFY
	K0Qp53XZn1YTcBgYkYOrMEU6x6YglTpj32fD/91W9yIH5VEJfQdiASOiY5x5BvJk
	MICg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700820718; x=1700907118; bh=5Y69eY90pSMsf
	K9wfbERdwj+JivaxvHnMUj7jHapdfY=; b=0BikgX/+zmgcRpUqd+iZCvD5EL8TA
	k4lFPUKtf1IF3nD2JlOI58o1tzK8N8kwBtoGlvPdKVWIc12D5Rc0QxvT+RYovydZ
	Q4K5aDuPEXLoBNZj6UTf1foEm4wXwwKG1tv3F26MxKlbB1Gqz3p9DTDxPz/rnixW
	7tC065VrKynPymcIhN5HnlTwupbtBsoTy9t5EidbSqJhK8CapBwSK2PK7RqqH/s7
	zmIWE8KnUhkfuYEBS9NGE0WMsJANPJTHj9VfSSWXdXU2IpGQRkTGaWfVu2T++TJz
	B/lRtfCByV1R6oHO5MCAyDis/FSphUFsMYCE7yhjbNqooChuwxEf0K0HA==
X-ME-Sender: <xms:7nZgZdkXRfO5_aqXi7OvdbvPRZxEPI_68BOdJqrJMP1XFMpyG2bnew>
    <xme:7nZgZY052hnnK5-6BZ6EbXqPESK9kQdIxyQumTb2KUexwmzb0Yey5nrY8WgaoOGsD
    _xoSqDKE-iwepBXmg>
X-ME-Received: <xmr:7nZgZTqH-1wHGvCeQKGI0crpeeIW9__tszUe_pqL0l6U8dsKF10SRA1q7Mqt68umKk6tuLM2PdZ0xL0cQt51B0nW9z__RiFLaYZu0HJoIg-8iLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    ggredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeekjedvgffhieehkeffuefgvdekieeivd
    dvjeefieehvdelveevieefuedtieeffeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:7nZgZdkb8szJFoGdPIYg0rDp-P2JbmJZWHsLFKqKe2JmqGCHw7s2rg>
    <xmx:7nZgZb2Vat5kFUGV8NjRYmTgsLq2h59l9CY_1320J5-qKoQC1T5yJQ>
    <xmx:7nZgZcsrDOe6_F7aU5qxUUUSGrRCKRxILC4HCYX3MThV8jAwQ__a_w>
    <xmx:7nZgZcwfxKasWx2IQIq2lqSSSXPKVAzE6fgtp9t3XgF-6gDm_t3WDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Nov 2023 05:11:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 23b9f722 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Nov 2023 10:10:56 +0000 (UTC)
Date: Fri, 24 Nov 2023 11:11:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
Message-ID: <ZWB26TH0CFW1KC4L@tanuki>
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
 <ZV9Za7iCL6WiE-Py@tanuki>
 <xmqqy1en7af2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s/X5dy28ft0xp4De"
Content-Disposition: inline
In-Reply-To: <xmqqy1en7af2.fsf@gitster.g>


--s/X5dy28ft0xp4De
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 06:44:33PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I have to wonder whether we should tighten restrictions even further:
> > instead of manually keeping track of how deep in the stack we are, we
> > limit the length of revisions to at most 1MB. I would claim that this
> > limit is sufficiently large to never be a problem in practice.
>=20
> Tempting.
>=20
> > Revisions
> > are limited to 4kB on most platforms anyway due to the maximum path
> > length.
>=20
> I do not quite get this part, though.
>=20
> When we get "HEAD~~~~~~~~~^2~~~~~~" from the user, do we somehow try
> to create a file or a directory with that name and fail due to
> ENAMETOOLONG?

Sorry, this was a typo on my part. I didn't mean "revision", I meant
"reference" here. References are limited to at most 4kB on most
platforms due to filesystem limitations, whereas revisions currently
have no limits in place.

Patrick

> There are ways like "git rev-list --stdin" to cause Git read input
> lines of arbitrary length, so I do not think the command line length
> limit does not come into the picture, either.
>=20
> But I do agree that the only useful use of such a revision string
> that is longer than 1MB would be to attack.
>=20

--s/X5dy28ft0xp4De
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVgduUACgkQVbJhu7ck
PpRkew/9EA+zuzLYa7kk9dok9mCqEDr8OQvBFvf58q8frWJIjhoxWSSE1PStklQa
ODt2KrepMUboSPlrllYyXJ+wkMY7zfXRznf033PM7R29Qow5UR55ehjd7nocueDp
3Pe/z+HGS32j3NLgppJPk33Cb5H5kPieui0wrT6bt9NF0oCFyC1CnDQt5BkY9hqp
t8gy3+jPCzQ0DBuVqzHtBvk1ryxiL8kRaVqn/bsu5Bh1O1PDN6lg0KuN1IlbkalZ
z/lnoQ0SrjV8dGEuaODacvPFmGPIAQdcdbl9UwJTVy4K5N7aqeyJjHCsdtPjzIja
qGBDWey84A7dBSqjRt/zya2UgRmUT7sLd7CsOypYdPAoyLoVolU/VPQi7h5nqHQ3
DYkplBrQmvHNSEVqheVKIBF7T0BPLu5cX/MoQGm8phD7gXz6U0AA5gQPKKEu4kCY
mJ5U7y76OJ4MAQK8OD7VjlmcrxFF+FJfzATIDk55KKnBOzEmao8TUdV61CET7s1E
OQCeUPZGsFULRlAXHHGWQFuenqmd8qJJFVqQ0aYfVIcdPJKNqCynPxENadylJwky
mt5Vn3XO43z2Nivi2w1jn1KNaDgDlh+AvLnQVXbN+9ZR4quqxJpRF6EJ8YMZG0EX
SKE3xAw7vWgZ8SvbSJhqde7fY/B3mUGygP6EPfX8NTjxa8WORjA=
=B7Jr
-----END PGP SIGNATURE-----

--s/X5dy28ft0xp4De--
