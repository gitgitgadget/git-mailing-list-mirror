Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IfdcCqPU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNwL6RI6"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B3A5
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 00:49:48 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7233E5C0185;
	Mon,  4 Dec 2023 03:49:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Dec 2023 03:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701679785; x=1701766185; bh=3m
	7vTIhJaw33Z+glxadpvvow+4HyC/xgPp2NM8KVfOs=; b=IfdcCqPU6xto6FiH4o
	4SVt2wfFL1T38w4Fi1tVuJe0N6/+PKdxV9x7Hd41swcVEvov93PBex4p6sBE2Jwx
	smv25Vm3RsxuEKWX4KdHGcmxGpGiQ/8KnKLvSXoTYXzdrMjzJr+NZviouuVEimEh
	dZw++oV3Yq9K+7iguw475ejNAVLUQVYE1naZ3vbsVIbLR+nxdriwScncaXOt6IWf
	28I0YeuHs3L2kXRzfBkZBs+aK9WDFlcSwcubQV/wsm6TpqG/YYU6nJ1ktgakLKP+
	kQntepBpv5vMSJ3JcBBTHykUIhZAPsw/4Z0kBa47xKFYPDFWAXxPN0qSFtgkXFmv
	sXIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701679785; x=1701766185; bh=3m7vTIhJaw33Z
	+glxadpvvow+4HyC/xgPp2NM8KVfOs=; b=VNwL6RI6MAkfmnqJqqtwHDnVCTUdT
	X5Zjy93pQKJDWBR+s3CmRJVaVZFV043+vcI83WqHh8tO00Y8BzdDYMOulNBR94Up
	Xo9MggC5l7BUgepip0sVgZUGnrIX3gnyvRGfWt6ZBSmcEUTLLU/3tH0erk0WKKnW
	24VYBzw7LLRu9eet+ncmHN1xz6CKeflfC0jc5jCD8SVC3CluKkzUqDLH2IlyOqDM
	jqWkmqSoHDx6CRz5KIx2uhqvHVuuJzdV185r0KX+EahLQ4Q7g6DWTeppTllgX8WX
	antt2zh4d70w70nDwwSFr6+b0oEa+CqV/GiKFmyxQlU6qVWNWO4VVG+qg==
X-ME-Sender: <xms:qZJtZcL3WjFt3Lce4a9-wq6_D_2wYa7j6Nblkhini_ZSvPKtG6el2g>
    <xme:qZJtZcLlIakbLHyToevfyvdDjaJdUdV2h_IOZzJ-C6N0cjxc5wDXmtKQhNBL4mDvj
    fveQsVuoeN67Et64g>
X-ME-Received: <xmr:qZJtZct3E3r6-xKxldxzqSh_YZzWKnm_VOKs-mfuKDj4NqSW9xZkzgd05phtRbxTgUKRBYobm-WuOQTZmxSd1crBQ15mo0OqSq6ndtvUeLgDJG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:qZJtZZbP8TUshzMV25k9hOTKu4NDw57u3JpuFNk8NTB_A_CZ1s3ylw>
    <xmx:qZJtZTbrAedMbPOM3TVclqCtXhDYU_mc-HK8rlg-wYUs9-4dbG0NcQ>
    <xmx:qZJtZVBG0j_RnN9SY3YvG8yZndLZEIH8FN2ZyvNhD9KWSk4z4_NDeQ>
    <xmx:qZJtZSnp7j1w9SH_my7aC8NIlvlYQb7pw45JZ3LqOtXZp8u7eghLng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 03:49:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f72c7291 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Dec 2023 08:48:21 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:49:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZW2SpFbBIq6p1Myu@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ZWhha2h2zzZWCXrw@tanuki>
 <ZWjk/TYzsrdHefgy@nand.local>
 <ZWmZ0pk6fr-8dmF1@tanuki>
 <ZWo7zjs+q8SZ5o1o@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vPZzowbBq+yfhyPy"
Content-Disposition: inline
In-Reply-To: <ZWo7zjs+q8SZ5o1o@nand.local>


--vPZzowbBq+yfhyPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 03:02:22PM -0500, Taylor Blau wrote:
> On Fri, Dec 01, 2023 at 09:31:14AM +0100, Patrick Steinhardt wrote:
[snip]
> I suppose if we're relatively confident that the last series will be
> merged eventually, then that seems like less of a concern. But I'm not
> sure that we're at that point yet.

That's an additional valid concern indeed.

[snip]
> > >   - The fourth series (which actually implements multi-pack reuse) st=
ill
> > >     remains the most complicated, and would likely be the most diffic=
ult
> > >     to review. So I think you'd still have one difficult series to
> > >     review, plus four other series which are slightly less difficult =
to
> > >     review ;-).
> >
> > That's fine in my opinion, there's no surprise here that a complicated
> > topic is demanding for both the author and the reviewer.
>=20
> My preference is to avoid splitting the series if we can help it. But if
> you feel strongly, or others feel similarly, I'm happy to take another
> crack at breaking it up. Thanks for all of your review so far!

I don't feel strongly about this at all, I've only tried to spell out my
own thoughts in this context as I thought they were kind of relevant
here. I've thought quite a lot about this topic recently due to my work
on the reftable backend, where I'm trying to get as many pieces as
possible landed individually before landing the actual backend itself.
It's working well for most of the part, but in other contexts it's a bit
weird that we try to cater towards something that doesn't exist yet. But
naturally, the reftable work is of different nature than the topic you
work on here and thus my own takeaways may likely not apply heer.

To summarize, I think there is merit in splitting up patches into chunks
that make it in individually and thus gradually work toward a topic, but
I also totally understand why you (or Junio as the maintainer) might
think that this is not a good idea. The ultimate decision for how to
handle topics should be with the patch series' author and maintainer.

Patrick

--vPZzowbBq+yfhyPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVtkp8ACgkQVbJhu7ck
PpTmBg/9HxQj4vLZZSb+1yRk4nZ7JaAaAj3dDpHg6TWgUiMQ1Pv0sOo9IWt6wo+4
I63BiSqDz0kdTahb9h/8jiUCUzwpsYALYa0TSHvMsvBKaM4zvD0YrsyDbkVomamX
6a3C2o9qhq27IOKgz7bvp5GLQmUH2OxCUeJ2yxBYdFWmb+kxs7JBYnVqESLegekU
GmfoUYM499eHzgL3V7jf1R/rtzFDzakI2jr/Jk9tk9r7wufWH9LJT1GEioFPBRLj
kpSPt2Z6YvGRxWuMamo4HM/nIVfcw10Dzykh1o29eInQRSI4eyzvsSjAuZPI+VqH
GuOqU1z5mc4raHUsY2RWlUbXpn8Pd+2bgJw4ho0nEOZv7zHtCx+cw42pwz0J8PaB
XM2pm1oLj9ORFqN+anpAVaqMfjfDTtiTQLnh3YIXH0jdhXe+P4c1h/WCId3is2nx
VJBxKJ4SQ5AEmOUL8d+H1g++gQCqBzRYtoH0cOSPnA1zd7RCaMXATicgxBYvG7pA
PvoOPZfJd7dgmb4uQr/teHch0cY+VlhR8ngjnsvnRw6JFm/MuELAq2sGOg3FzmUg
hKQw8CU3Hql6oUiYBPDOG0kyj0IUqOxbJpDMyjrP9W0ggDFnCjoKnL0A1ZXBsaWR
LkyOHtzE8dTd19j95PXvXblq3iDvB471SNOuy7s7GabxMZohhkQ=
=w5ce
-----END PGP SIGNATURE-----

--vPZzowbBq+yfhyPy--
