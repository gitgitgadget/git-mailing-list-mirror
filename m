Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5E42A81
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SQz0prGj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLG+EzL3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 642ED3200A8D;
	Fri, 12 Jan 2024 02:45:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 12 Jan 2024 02:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705045526; x=1705131926; bh=SPm40PMWgg
	u9KPLtPr4/iMdS978S282ymbGfZouBhSE=; b=SQz0prGjAD9UH1iPP+acqeTdeY
	NHTOAygXALvAh4j8K8qTlBrsw94qBPAjdBXWZSpL3rF55rsXHoqu5/R4F0sNgzxj
	noJklTQVDiQ9lqQAwe56k0SdS1gWv8hwqxj4pMxnAlVTav3dCxj3EHx7lA1BRcRG
	lV7ai+3HUtb7Z0MHA512Jo5Ber3KBL8PbG28N9l5D7Kk2NeK7yS/lBCf+IHOpjmh
	Kqw4J+gaLcfDUn36eTKTseSxnJ83vceg49O84ZGsba9WJJZbs4JHzloZTzgfAuWH
	lMH5UbEBpASDC79Gv/Or6Ceaie7G525nXoJ31rGVOOvLBoainFZpsIpWr3gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705045526; x=1705131926; bh=SPm40PMWggu9KPLtPr4/iMdS978S
	282ymbGfZouBhSE=; b=PLG+EzL3FJsRoysjjpL4G/vnhFcdHswY4m+MFk/MCZEO
	JqVjifpE3xKdBYu0BnEExydHqI6ykXcpL4ZA0f679dSHnRs7f2ZItYP1/XFeLSco
	fU3oJ4ovLsksjCCrs38bVon8BwPLZduCqRoW/NsCUoDA0oie/ZSD+Dt1m/jrxpHs
	h4PGR+vkYvrZR3Xz3asizb6edDknkAgkl8fmGv+xeB/eC6oJqw+L72kK3dt2TEQe
	YSDbs3egOaF7+NjUPrcpOyTSycakB+eIW78iRAhnf9PRdlftQ0ID8an7UdSam7eP
	mqSSaICqbM5cb2Z8E9Bcv2Cdt8mcuY2uUwHxRwtcEQ==
X-ME-Sender: <xms:Fu6gZQUMPpsV3lHG4o3F16VPLNl0zDy6vgURHE7Koa8UCmuSxVU8kw>
    <xme:Fu6gZUm4yYqOy69uY3K227KTiqL2P33l77m_R-9-rezyPjmKUsfig2-3bYwxQ81I5
    4bhSjrkQQVjYjNGeQ>
X-ME-Received: <xmr:Fu6gZUZlIXyGrWZHSNcCw5zsyQPqYA9tnRc7ef0xaKg02oAYQrcLa7qqLN2bwuS7Dfv5aD8DxbLWMWrCK2EorT2D2xlkVT-fjWvFoRpVMmanx9c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeigedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Fu6gZfVuoDDMHyT2HIhav4x1nXYCwNSQe4B4K14pdT3I76qNJQjJiw>
    <xmx:Fu6gZakgH9SwCvYOXU0A67a2ZvsLswQQD3sx6jaF7rgg7FwuL4RzbA>
    <xmx:Fu6gZUdaS3OhO8JHE-ULO1nhrux19FGNvyZ239w55B3WsDoIvEOCTA>
    <xmx:Fu6gZfw5hBldQxMuvi2cjOj32xkFZE_YB-jc8IVAK2IMC9koO_I_xQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 02:45:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95042856 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jan 2024 07:42:40 +0000 (UTC)
Date: Fri, 12 Jan 2024 08:45:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 1/2] t1401: generalize reference locking
Message-ID: <ZaDuEufXOnwH7hT4@framework>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
 <20240111071329.GC48154@coredump.intra.peff.net>
 <ZZ_MPK2huH2j6CGd@tanuki>
 <20240112070142.GD618729@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DJ0aXhs5t6WRmYsI"
Content-Disposition: inline
In-Reply-To: <20240112070142.GD618729@coredump.intra.peff.net>


--DJ0aXhs5t6WRmYsI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 02:01:42AM -0500, Jeff King wrote:
> On Thu, Jan 11, 2024 at 12:08:44PM +0100, Patrick Steinhardt wrote:
>=20
> > > (note that you get a different error message if the refs are packed,
> > > since there we can notice the d/f conflict manually).
> >=20
> > If all we care for is the exit code then this would work for the
> > reftable backend, too:
> >=20
> > ```
> > $ git init --ref-format=3Dreftable repo
> > Initialized empty Git repository in /tmp/repo/.git/
> > $ cd repo/
> > $ git commit --allow-empty --message message
> > [main (root-commit) c2512d3] x
> > $ git symbolic-ref refs/heads refs/heads/foo
> > $ echo $?
> > 1
> > ```
>=20
> Yep, exactly. That should work for both and cover what the test was
> originally trying to do.
>=20
> > A bit unfortunate that there is no proper error message in that case,
> > but that is a different topic.
>=20
> Yeah, I would call that an outright bug. It does not have to be part of
> this patch, but is worth fixing (and testing). I suspect it's not going
> to be the only place with this problem. Most of the files-backend ref
> code is very happy to spew to stdout using error(), but the reftable
> code, having been written from a more lib-conscious perspective,
> probably doesn't.

Yup, I've already fixed this bug in the reftable backend.

> The obvious quick fix is to sprinkle more error() into the reftable
> code. But in the longer term, I think the right direction is that the
> ref code should accept an error strbuf or similar mechanism to propagate
> human-readable error test to the caller.

Agreed, I think it's good that the reftable library itself does not
print error messages. In this particular case we are already able to
provide a proper error message due to the error code that the library
returns. But there are certainly going to be other cases where it might
make sense to pass in an error strbuf.

Patrick

--DJ0aXhs5t6WRmYsI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWg7gwACgkQVbJhu7ck
PpTu7hAAmJtzg0/Dz/Pq0VcnJMR7NWzMtIyBX2q2gLDXf71l4vRWPubr9mXx4JKm
bxI8oL1fdakuHQqG/IGKeKuA5utOJtjW4YbC4tANpvaPqPcpciynNAji9q21iVQ3
a0I8HnrybKcYLW7z6mR08ICWIqXdwu8AgwZz/IGxvGzu2J7ZLv6UZQg1DbviQlFO
BYVP6Qqg8XC2oeQB6bzMgxgENE8Xjn3QXE5miKO2U1PruAMErmRIXER3Oc3NAMUQ
mQe/+qy360fQhC4+IEVuHv3hVWSgyp8sKHMPLXVYkEspAvRrHDpFzt1luOiB6vHz
X2mWcDkDKWNSSsUXgv4pqZ+QKVhCXBIsUjshG6vSiaJgOrrVZMTCmnaDM2xS7AIf
6iKHgJhpjpuX992CvheLtqI1AYkf8L/K7huxlDZVpPgOn0BqyjbwzPFmIh7TIcq2
nxT1lOrMJOj6YKHhn+Y351Zlv5akfVhCfmETf23+I/VUzzbnt2jWkSGNkQWfEGqK
hV0O0EiWXa3Brvvzflew32j2htenydV74xmyO2pAT/Z0iCYbC4317y3mCRXyviXm
i7iLr974BQtKMAzykvFn+G64T0iXssaTHp2/cVkMbIwxPX4Eo7t7AkNyU1XNPlYl
G1nQZO3ea3kkHpLobe7/GOitUdeWJvHq4d/d/anuel8ea+ozt9M=
=4qWl
-----END PGP SIGNATURE-----

--DJ0aXhs5t6WRmYsI--
