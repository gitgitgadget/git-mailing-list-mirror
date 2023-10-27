Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBE14A9E
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uUWj91qm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+xXZVMn"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A93FA
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 01:17:31 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6F3135C0105;
	Fri, 27 Oct 2023 04:17:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 04:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698394650; x=1698481050; bh=WN
	ceqnYM189lGg2XNwdG4GMR2pAVOnw2JLYOLxqW688=; b=uUWj91qmgbaHNv8BXG
	aV93xy1So/+HOGbCM8cgu8lIh1W7O+y2SkO9zsmJ82iQ9EHbKIi/D2s3qY5ZLEyR
	OxECyuApwa68FNg6fpROgnlvUduT0qfmBUabTiYxOg4+4UYwvnAR1Kq9mNSJItpx
	fKo/L1f8fBh2nLqBbHKDHhyf5hUjRMJ/0fZXLzfDt6EuHQa0tXLYp9GnzWlPL6aZ
	O2RszGrrLkDCNM0zmPS9qRn7BViael3iXt5juzDgm/l1SheDKU5IGHu+y5FeRQYv
	KC0ZIQoIGDABmYdsbIVnhSF7tl22V/RllLLAsVDfr+gI9UsWurl+bQekVyxeorlj
	g2Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698394650; x=1698481050; bh=WNceqnYM189lG
	g2XNwdG4GMR2pAVOnw2JLYOLxqW688=; b=s+xXZVMnPTEekXDBRpKh1XdpTHsyW
	fan/DGCiK9o3AKwOG/PkWexeUsfqrs6N2MAoIJx/nMWO6MGvdwkLRjautAC2vBhD
	mXy99ehKyYkSeQfvDxozT8s50B6yFEKueLNxKsPd0IRVCUeGNMZ0+/sZJfA8rxRq
	/6WZfbBUUic8wmf4srbNNOgJA0gWvsNGX35zfxIRG0sCSGEvWOAbuhhzW6zwsFEP
	UvhGhmbbxDaE8l/uehIEbsQDm6w1UqeiaZdIbJPth8e3WiC1qNzcDTU041Of79Yh
	Va0dxmAAAuEqUIX66fFuOULNt/6iaKI8l3q4vNjOxtiMTMO/gTEp9KW3g==
X-ME-Sender: <xms:GnI7ZblBGOMN4zRCYRtkYXyKnF7DWWtCynetfaDPCh2fN7Ig4eSAhQ>
    <xme:GnI7Ze1N4sjy0xsELpNOxPb9RTtyVLqDgpqcXR-OwZu4T7dGi3LeFbFc4HnGNxVMu
    7O_1q_GlfMRQGZf_w>
X-ME-Received: <xmr:GnI7ZRp0Oi77isYWf1RdSc0CJxVziA3AtvANQ86xXSmhC13WuHq4D5ZW9CBp0F86NZ40tpkvdU8cP4PIfhAiAhRBgtiGMAoodJ45F4mYFRtrSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GnI7ZTk3DgzBF4Mh1DmKsWJYEcF4L0Lv4cpr4VljhqD_M3e5uQxilQ>
    <xmx:GnI7ZZ19enoDp_oBQPfnhfqsJY9AwAmBxv4I8aSe2MfdA98Rlgf43Q>
    <xmx:GnI7ZSsmpaarTKluZVdeBFNM64bWhz8kXKNxWI1WI4H2ukz4CgTmYg>
    <xmx:GnI7ZW86tFkxmT6wVwpD2CO3Cg6C5WFvZCjF1IADau1tVxyxhtEIKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 04:17:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec91c242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Oct 2023 08:17:19 +0000 (UTC)
Date: Fri, 27 Oct 2023 10:17:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: group installation of Docker dependencies
Message-ID: <ZTtyGBLvH8Fji-C-@tanuki>
References: <cover.1698305961.git.ps@pks.im>
 <a65d235dd3c14df4945b9753507d9cdab777966c.1698305961.git.ps@pks.im>
 <ZTokgo1mQ7ZVH7GU@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q9eK5qaF3xtye/+V"
Content-Disposition: inline
In-Reply-To: <ZTokgo1mQ7ZVH7GU@ugly>


--Q9eK5qaF3xtye/+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:34:10AM +0200, Oswald Buddenhagen wrote:
> On Thu, Oct 26, 2023 at 10:00:12AM +0200, Patrick Steinhardt wrote:
> > Pull in "lib.sh" into "install-docker-dependencies.sh" such that we can
> > set up proper groups for those dependencise. This allows the reader to
> 					  ^^ !!!
> > collapse sections in the CI output on GitHub Actions (and later on on
> > GitLab CI).
> >=20
> the structure of the text is kind of backwards - the fact that you need to
> pull in a lib is just a consequence, not the intent, which imo should come
> first. tough it mostly doesn't matter, as it's just one short paragraph.
>=20
> regards

Good point indeed. Will rewrite.

Patrick

--Q9eK5qaF3xtye/+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU7chcACgkQVbJhu7ck
PpQfPA/9FEQWCjk+7PWhHUcHqcV1h4Y/RSSpg/WFTGt1xzVv2TjntifWUNOs3EiV
38KPJ4bnReQc5C9gNEajWOCnHTqk/PBvBHNkGI+sAHYHHLui6i/dvu/p9uYP+YWO
FSa35pn81St8J0FsjqX/Ko+YTh+xpjoQFe/f0X64xPxvphOUHKWsJD4W9WeY72RL
8VhHm2a7y5hwOaB2az//2DrJNdfqQlZDWVfNfzTtzjcIZMhCgTz8cwG0tYXal8St
CedwmOsHwpyzlqhD1PSGB/X4rRNyxraANPbFuJF019L0UEr5ILVV9XsGieoRHhlS
I6tO/iTUmw4cMwevqeF2PFj8Dg3MbfSNQn9GboiVCcd0TQjNOnt0IWDD2Qfki0OZ
fhYJZls25N3aXPO0qI1BUXg25YUWklXD/23d+uS7Vk585rANmC4LV3AE9iaYcJjr
5qDeGXXdd9UYKGlwZalE0qu5Rc+ArUty/BFmXia1/BP3pYfyFhkfz4ONuljfdfDi
gvHH++m2PHSzOrxcQSHfUBgbMy+e657MLzIaFqpzy38R3qvKUx9p6jIfDGJPOH3c
DdEtpby174slOUNVbNqUcpqN35IkIDKlzgxqxHUx1KLw7fIn5Mri6g1c3x/Yz7Sw
PDbcDPh3YfvJWhv2Zp/IbEIpRqly8jBsXMMclALb+kZxJAeoNok=
=Hlht
-----END PGP SIGNATURE-----

--Q9eK5qaF3xtye/+V--
