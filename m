Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D523748
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FWckbZ9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NiMP9hxs"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id F31825C00C5;
	Thu,  4 Jan 2024 09:47:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jan 2024 09:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704379677; x=1704466077; bh=oMwCmDNTc8
	Sr3+UFe4cJGPNzulOXmQ8ki2/zSwdt0U0=; b=FWckbZ9KeYuadqrfWeSNqWmaOV
	cCgC05ZL9nhgGsIdvwezkOiCkPlaA6p/UHhcK5nE2Re82xZLi47HMcXU39H5QUzO
	SD3Vf8TKim6X6cOvJP3DCnNeev23mLAD54pD2//WCGxYHZpvd+prRxOa/vEu/J0Q
	klg/CScBWfykiwibGq0vFZTdFLaN/tRfIZq8jBIB3JRnid27FKdZ9mfdXg4oy/Kv
	kVOpHUbI2jzCa703/J1pLDSJWx8QDhr/dqujmWUyKENpuniiwW3OgDj2nVm6u5JN
	loy3CQc5eJfaE1gduE44cdbVkfnD4Bd57z7ZsJA456CtvSQRGaSGkCf7NqSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704379677; x=1704466077; bh=oMwCmDNTc8Sr3+UFe4cJGPNzulOX
	mQ8ki2/zSwdt0U0=; b=NiMP9hxs+6k/7eJVxkC3wSYwEWMb2d7Lh026Q+WiyMhm
	uRd4QrBVpKSfOpN83hRGJ5naocvvEQZcj7XOJg+zL/BydxYjaSrVsZZmtyDN0XoD
	k7pOZws22O4XhdvTqs+8LRJMS4u4iygug5dhn7ogrYJdBF9oXadKyJv21St1YYpC
	nRoTkyCukut1NyUhvcw1mQN63c8zbHWfz70yYiYsH31dHzEpF5S7rv5/8R7JxXXu
	+NA44lh1G3pe9emuDd3yGr7jCqdwmxayehlgopSAYOMj3QZVWL3RGJa0iPR1tvS7
	7436qoz1+7MzrtfB86aJFwGYJYkIshBiMwT6G/xevQ==
X-ME-Sender: <xms:HcWWZZZZa82m60CXU6VdAx07FRqluK4UDpU8qjW1uOBYG81NhFQiyw>
    <xme:HcWWZQYFcNtTCx8LUZm588CCouOma9KZs0XLiQlEwdVGLpXPb-8UMs16I6ODz03qQ
    2IV_kWf-nQr-m-7fw>
X-ME-Received: <xmr:HcWWZb_fHeDspkSCEYTDjyNmKQ1fJDno8eUUET5ADSbcr-kltZityuKTQF4hImuP36EZ95ChQazO0suFXYeEKjH_AuphthpSx-vLOV4DCjIcwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HcWWZXpKtW6u6cff5i5Kp7IOYJ0LkVHKrHhgMS9gQljQD0RsW8U3DA>
    <xmx:HcWWZUoW1rTmOT-hUnlUH2hgIYs9RAnih9EObV_cTlegbXzK-NN8eA>
    <xmx:HcWWZdSVTJCq1R6G5HNgOiKTLzD7U21_qk2XbaN859hkFLAjksr48w>
    <xmx:HcWWZfVhOmRk1KRkDm3catoQfLRKP6a3ztD2tJQBJmxXcbm77mCiMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 09:47:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf9001e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jan 2024 14:45:26 +0000 (UTC)
Date: Thu, 4 Jan 2024 15:47:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] git-prompt: stop manually parsing HEAD with unknown
 ref formats
Message-ID: <ZZbFGTkM8aR7MXQu@tanuki>
References: <cc902954f30c2faa92d1c5a4469f0dcc23e4acfe.1700825779.git.ps@pks.im>
 <ef4e36a5a40c369da138242a8fdc9e12a846613b.1704356313.git.ps@pks.im>
 <ZZabqfPDcA1jtmZS@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LCKlhVILzOMwHVSk"
Content-Disposition: inline
In-Reply-To: <ZZabqfPDcA1jtmZS@ugly>


--LCKlhVILzOMwHVSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 04, 2024 at 12:51:05PM +0100, Oswald Buddenhagen wrote:
> On Thu, Jan 04, 2024 at 09:21:53AM +0100, Patrick Steinhardt wrote:
> > --- a/contrib/completion/git-prompt.sh
> > +++ b/contrib/completion/git-prompt.sh
> > @@ -408,7 +408,7 @@ __git_ps1 ()
> >=20
> > 	local repo_info rev_parse_exit_code
> > 	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
> > -		--is-bare-repository --is-inside-work-tree \
> > +		--is-bare-repository --is-inside-work-tree --show-ref-format \
> > 		--short HEAD 2>/dev/null)"
> >=20
> that makes me wonder whether adding support for `--symbolic-ref HEAD` here
> would not be the cleaner solution? and why stop there, and not add a few
> more ps1 would need, like --upstream and --sequencer-state?  (though
> arguably, this overloading of `rev-parse` should be deprecated in favor o=
f a
> new generalized `query` command, maybe even unified with `var`.)

I'm on board with extending git-rev-parse(1) to support direct output of
symbolic refs without resolving them to an object ID. Indeed, we plan to
tackle this lack of support soonish at GitLab. But given that such a
feature currently doesn't exist, and that I expect there to be some
discussion around it, I'd rather want to postpone this to a later point
so that we can meanwhile unblock the reftable backend.

Regarding the other options like `--upstream` and `--sequencer-state`
I'm less sure. As you say, git-rev-parse(1) is already quite loaded with
semi-related tools, and extending it even further like this is only
going to make this state worse. I also wish for an "informative" tool
that queries repository-level information and state like you propose,
but would argue that this is also a bigger topic.

So... for now I'd like to keep the current version, but I certainly
agree that the state can and should eventually be improved.

Patrick

--LCKlhVILzOMwHVSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWWxRgACgkQVbJhu7ck
PpQ5LA//SC3+RUHbfsCFOq30jhOTp0TYVJmQA+PWXxBHr5dAFBkyHF5kUfwmKa68
sc9xhKJ0qGW/gV2v7LpfVMfKpXmBbbDFI2H1VLGv+Wr97iIa0lYg3vwX3kX5tX7z
fOzBwpl96Ti4NGkessCnRnUc87CMHGZXeCdAFmmNu+U7vw/+wiJQSmlpWe9BOish
8kTfA1NEs/5PxGA9mMU4wajpzSpmYzO2LMRKWNV/4ZwuTrUilPnIiD3E4xLg9tsH
ee2kMzcdIaHZaXg+NcYOvjzv1gy09C36FJyQcoL3ZMifkdrgDTWwK7zVi+2CbCgj
EG5EU/hH+TM2Uq2BABs8zXlg/0qr9rMaCgJGkoeldHiUCUEh0l5x4Z+YsuR584dq
MiVWhF+4WVN5UwMVDmJ3FnpDsVGOC1TfAiYKA5edACH0GbAg4GFMDzmErTEpZeYP
uV0zsFM61likxvEXqFqNPncJW2OHoAfzh85eLH8mUP0Se2+1pBHpLK3YsurKa16M
/r1c49k9gKATaYliYuDQXf5dQJd0IHvpfdPLFyuR5+wAEfqV5XwZR7wGdYgglG7b
QoTjD5FENPPjuTjoOQ8Q3Ed4DW4lKa63Fes4WEsffAbMehs+Z8QWnujqOncGZer3
QxY4M641qRpDxhqD1/u4Xpd7gxKTRWJJCoxtY5gzLwAPXXWMmpo=
=dm2K
-----END PGP SIGNATURE-----

--LCKlhVILzOMwHVSk--
