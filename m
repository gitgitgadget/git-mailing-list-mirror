Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3233A1CA8B
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mH50T0Df";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9kgBsQ1"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id C6D0D3200A26;
	Wed,  3 Jan 2024 12:36:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 03 Jan 2024 12:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704303415; x=1704389815; bh=6cwmA6uj0l
	8sbOXLpJbQ7/SysWVsMf+JcveS31JgFOc=; b=mH50T0Dfxs7NKuHssTv+wSCMLq
	amefUkX0yYvAFSxXNdwN6eJTNWDemjdLylYm2QmOJXZDIS1DfvekkOJTAxI/BQ9J
	Z/C3XkK7dCNGDBGJTrBmAM8zu2dUR7L5wtrluJ8yPUkDDQGDCKNfoI3K8Uh6xPRm
	84aho7uqG5nlJapVKcQYYWZzntJOhIMEZWgDKMhCc60+QXex7kxyBH/1Ld4Skakn
	MdFsb3vvIfSs15cAZhfauuSes8bJDHA6g6+MknWy2uN5f35+Wq10AzqEoKmZMahV
	QcNsaq573v8posy/bsO30jc4KbR+HJP6suh/KARHoo+Ya4qqDY9HXm+xr7QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704303415; x=1704389815; bh=6cwmA6uj0l8sbOXLpJbQ7/SysWVs
	Mf+JcveS31JgFOc=; b=F9kgBsQ1J02BNKxEzgYJzy45qw4gPlgwc5pdkXJGB+to
	RrEhlAg6M6PVrlYoLl+QTdSrf2ciSDBe3VXEcbDOVVpn6jDTyrC0O6XKBYPAbSjg
	G5K+0xhriQZuF9k3PnuM3dzWTodqyOjKSWsl9t1TfCWNlrXuwoII4AuUkY5Tv3r/
	Wn0veGUKZXYzw1Nh5cBSgXjXgbMWntqQcr+zQDu7FBPj19OQYoVNsXkEY9W7X3qO
	H8XOG6c3cyIxmTCOKaTjl/XrKFI0LxJscm9WpJIJJiu6z0EqrX+Tn/BFVqMvGQvt
	7RIWZOi688ka14I6v6TCFn2VvyEXYWqvW5GQWDYSCA==
X-ME-Sender: <xms:NpuVZfh9y4a0l4YxCtQvklPI4HsO4KFB4MDOsLaMHmztlig3kVcmbQ>
    <xme:NpuVZcCOZ7BfOoeM5ZZVgHloFnwSTrGVzCYIOjfymOsh26p2bt-32wOIHtW2KBmHp
    XMeAfzpVWVGa0lzUA>
X-ME-Received: <xmr:NpuVZfGfuDbdnjiTI3z-LoSZbhn43s0ygc6N-HwvhVuPc8OkQB9i20e-EOooABaW0vSHKQj9WHN-vzeZOqt4f3hcSrMEArPA1V3Xhwj68jYCeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeghedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NpuVZcQLXuEiLfMkIhvu2CAaXl3VgQXlubZSwnEN1SbYlXiu8rUKXw>
    <xmx:NpuVZczekIC8h45ib9LSklKVbiYpqdHtjLiDICbwBq8hOX9th7xo3Q>
    <xmx:NpuVZS7B0LKdACMZqypbQWl2KPR2ir5RjujLnvz_AVxw-O4pemD-XA>
    <xmx:N5uVZY_eMhhjz-xMg-V_voHveg7IPBvNgXxQDkeZwXraUmIdLhPE-g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jan 2024 12:36:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c958e4d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jan 2024 17:34:25 +0000 (UTC)
Date: Wed, 3 Jan 2024 18:36:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
Message-ID: <ZZWbMekL2URby0qV@tanuki>
References: <xmqqsf3oj3u8.fsf@gitster.g>
 <CAOLa=ZTPxWXnZ8kpBB7=cybNfdEv6d6O37Em7Vpmcw=enpY1_w@mail.gmail.com>
 <ZZRaOhK869S1Sg1h@nand.local>
 <ZZUgUUlB8A-rhep5@tanuki>
 <CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
 <xmqqwmsqbhyt.fsf@gitster.g>
 <ZZWCXFghtql4i4YE@tanuki>
 <xmqqsf3ebe1l.fsf@gitster.g>
 <ZZWIlx-9D2r9AfDW@tanuki>
 <xmqqil4a9vue.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JlRW4TxmZu9DtzH3"
Content-Disposition: inline
In-Reply-To: <xmqqil4a9vue.fsf@gitster.g>


--JlRW4TxmZu9DtzH3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 09:21:13AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > ... But the problem is that tools like git-update-ref(1) don't
> > enforce this, so something like `git update-ref foo/bar HEAD` happily
> > creates "$GIT_DIR/foo/bar". And I bet there are other ways to write refs
> > at arbitrary paths.
>=20
> I think we should tighten things up over time.  First by teaching
> the ref backend that anything that is not a pseudoref, HEAD or a
> proper ref (one item of whose definition is "lives under refs/
> hierarchy) should not resolve_ref() successfully.  That should
> correctly fail things like
>=20
>     $ git rev-parse worktrees/$name/bisect/bad
>     $ git update-ref foo/bar HEAD
>=20
> I'd hope.
>=20
> Thanks.

Yeah, agreed, that's something we should do. I do wonder whether this
will break existing usecases, but in any case I'd rather consider it an
accident that it is possible to write (and read) such refs in the first
place.

Patrick

--JlRW4TxmZu9DtzH3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWVmzEACgkQVbJhu7ck
PpQ42g//T/gBwWLTUBwcI8mi9MtBq7sOfICWIS5pL+07TwcTk0+XBa0P3bz/+dDn
DLELpsKEbv66cDrM4FMH9jh7sD8Cb+juWKLulx7QyYupSKdaqSdKM10cMgOqp0wk
tV48cn8Uq+4YbBkd6LdOg3bdfEFAZi6k+F6RYuez1tY5jawWDIujNHtKd/iJ6wkL
W/L0Wgn//VpTh3drtcUcthng4oQKhy4gyz9fQIdETBPUijgmKJAPLuQ3Fj+QgRA+
oftMSCIiC83xkuklZ0IDEU9WioHBKRDTXgih9GERl+69eYiv/gp3/FqWcV1Ii91R
FkoKE8efZ3QcfI7oisnkhzASaw6LrxthAJlw6eKlzHchrL+nIwGvuw8IyFMRek4R
6SAR6allGr1+39xWQHuARciy4EMpGfzSwkkzEIdNZLCzBwqjckhiOwu6eOhvZ+l5
JKfDC1w5CD9jZITqMM74zKx1RydimxEusEiONBJVhIEK0eQe5CCfPj+8GyeqXlpn
n39HAm/SgTtzmHvHx2FPJHHOgikwNF9vzgWW07ogir8YxqVPsHh8YHz4yGtLmA3D
Kb36RFaV1jP8MYJqkFLh1PrF35nW4MDvv9ZOU5+dLXxEFlGPz4sySVb5S2kMFChX
+aTfqGj5d3hGy9KqL5VAvaKwe2YctaaEY2J0S6s3Es3vFK6uVCE=
=0FWd
-----END PGP SIGNATURE-----

--JlRW4TxmZu9DtzH3--
