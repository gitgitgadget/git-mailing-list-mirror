Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d2+xCQlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krhF5HfP"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E79D1722
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 00:19:35 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 9ACC73200A73;
	Fri,  8 Dec 2023 03:19:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 08 Dec 2023 03:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702023574; x=1702109974; bh=Zn
	tjbgR+bqTq0qF5PFbWfDxglxDIInbSwvafuoZmULQ=; b=d2+xCQlPEMY00yNiRz
	tQXsuuj0l4e3M1NI1xqCLdgJ6w0BP+t4fEJdkiUuvZtn89lPY4KieS9o53TPlFgr
	dlFzBPP6XxWVq6IVaw/Ec4NpB7sO7zN2FuHb1KUQH/YI6zrBCClbS95kg4YqVY/7
	UWnh57caW0UcW0Xw+HhJq8X96qa7FGDrKNBKcHSNfF7dHv7vzr/WwbeycEnDCRIe
	LEOYLlDE1jQeLxTB5KElLKLiAih6TLMFyvDnA0UtpSuGtLrquPv+BAHmHIVMIOJq
	VggjF4HMzopBadzJNODGpTfSBp0Vg9YBXAQfTzkAAF5ZUQLvzapx7xieq5pI6/9B
	zEqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702023574; x=1702109974; bh=ZntjbgR+bqTq0
	qF5PFbWfDxglxDIInbSwvafuoZmULQ=; b=krhF5HfPx9JkKiE8lmy7yp8UM1oKe
	+WCs/n25cfi3WStT/vU0h5NzwVRk/qmklk1++NwnO1G7kJ6i7GZlhhtdCSQEQbCx
	h4PuYP0+NzRKr5Dz3dWaWLSS+IvoEisJUi1OUAJp4/55J1IJYqC46CnvIlXhiblC
	4kWMT2dl3nfGqNAt1o3luHfY9rsHkxtO/jxUukwzKl6D5IBYyuxDD3YEFD+a138d
	92wfGwuqZj68BXJqYFV7aG8WOhBB0RYme5GwkqEmbgZ2dPxGPy+zJM89ejOBhfYL
	9Di5Qp18mJLvTOi2MfOMf0IsMDuJe3MkfjFIn7WlkkW6pmY0BUwnfmNQw==
X-ME-Sender: <xms:ldFyZeMuNSCxDdPSQhp2BL_h9S18BfGTBNOHWM1o6VMS_6AXLVZieQ>
    <xme:ldFyZc8E_9mPSWN0FxjB1HsZLQlDPU8YctwkhBppUGsDndY5W55e9_Gw_TN918bgU
    u8RMYNpU-k2z7mt_g>
X-ME-Received: <xmr:ldFyZVReG9jfCZ35TTw1m5gCmUeOQ0iEcGVDXc5qNJgaLUveYZGwGo7zxjA6fj3ekSaTA6m4MbUNa6N9wP6DAQmFuk7yK5p7Mssl7wfZI7ga1pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekhedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ldFyZesNuqzv8nzQsGBVCvYnoD_xW9UyKA9dGfnn-8a-uavtpy6w3w>
    <xmx:ldFyZWfToI6N8h-6XoyF3tqRfc6Nj_USpsLxHcbVYf1MeQbJsT3hNQ>
    <xmx:ldFyZS0pQ-5VgX8QVQQu2lmx8uXJWxzmJI_uxOUm5CqUVTmwch4-zw>
    <xmx:ltFyZXpGtol1UsB3lg59vtypdLUVxx3ZbgiLR2RBeZGTg0JZBgw4cw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 03:19:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78604e5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Dec 2023 08:18:02 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:19:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/24] pack-bitmap: pass `bitmapped_pack` struct to
 pack-reuse functions
Message-ID: <ZXLRkry2-UFu4RQp@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <970bd9eaeae038adb6e7d4c399c9b033668a8864.1701198172.git.me@ttaylorr.com>
 <ZXHE6Ym3CICtNxFd@tanuki>
 <ZXIsbO++u9n/yDYi@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WF4mnkpG3BYSKecS"
Content-Disposition: inline
In-Reply-To: <ZXIsbO++u9n/yDYi@nand.local>


--WF4mnkpG3BYSKecS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 03:34:52PM -0500, Taylor Blau wrote:
> On Thu, Dec 07, 2023 at 02:13:13PM +0100, Patrick Steinhardt wrote:
[snip]
> > Can't it happen that we have no pack here? In the MIDX-case we skip all
> > packs that either do not have a bitmap or are not preferred. So does it
> > mean that in reverse, every preferred packfile must have a a bitmap? I'd
> > think that to not be true in case bitmaps are turned off.
>=20
> It's subtle, but this state is indeed not possible. If we have a MIDX
> and it has a bitmap, we know that there is at least one object at least
> one pack.
>=20
> On the "at least one object front", that check was added in eb57277ba3
> (midx: prevent writing a .bitmap without any objects, 2022-02-09). And
> we know that our preferred pack (either explicitly given or the one we
> infer automatically) is non-empty, via the check added in 5d3cd09a80
> (midx: reject empty `--preferred-pack`'s, 2021-08-31).
>=20
> (As a fun/non-fun aside, looking these up gave me some serious deja-vu
> and reminded me of how painful discovering and fixing those bugs was!)
>=20
> So we're OK here. We could add a comment which captures what I wrote
> above here, but since this is a temporary state (and we're going to
> change how we select which packs are reuse candidates in a later patch),
> I think it's OK to avoid (but please let me know if you feel differently).

Makes sense, thanks for the explanation!

Patrick

--WF4mnkpG3BYSKecS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVy0ZIACgkQVbJhu7ck
PpR/Kg/6A/Mi39n584XrUypzT9wTHwHlKNsTy9l9jniBF0ugt5nFZaDWpLSUadiF
BeMRMxqRs+9L4Gtyy/Fye6DDCWS5DfYAYWPBefgvKYwdG2rcG81+zy2tafhdtRkf
B1924NA9eOk1l/T/IEPmXg3u/N7PHWh7+zh1jJ/o4HXpDaWxQ8EzvMjyHhJxdIOS
nS6nVT74hqf6Qk8fvUqPg7BIJPB3/WuNvwC6cdyfQPYzgpmg0MVogtOy0kp089+r
MBXPbvnnssvVm7Buhd0mwKlI64WCPPmI9O4pSjZ0Exk/BQA3iTGk5IvAFvNXl2Pi
Pi3Qrl5/k3evVn7TXgGjXr6feHjXcyIFj3kVwPQPPHY/QW3hsad5wR61qqrxb4xh
M55nl6p6JpyKRiIAD4fwSawhmVWmfSXo1ahyimxYJpjrYrxbwh7tGSyCyuV6f3o+
ECDxk8kQPPYisvZHGNVf17pypMjlZuJhlCLD12Ay8LD8xXmzG9M/qcDfxYOrLkWH
mrFjZpcNJ7fuDM9913H6HDV/Gd0DrbD5lqW8Wbq5DcFAp8EbClAcsDxVUg084R09
cwZ+6Ul6eBgHORiSGMlTqqw0VbWgYAZVCZDjSe7pytrOmQZP9grPb3I2hSmAEZbo
F3S0XebiWIh3+MjSs8IpiRxIA5HrnpdNJS6nDegWU68Q7Pq7ENg=
=0LZv
-----END PGP SIGNATURE-----

--WF4mnkpG3BYSKecS--
