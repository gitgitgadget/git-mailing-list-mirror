Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858A29A8
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NiNC1cNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlLLvYBD"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 3FD7C5C008D;
	Mon, 15 Jan 2024 06:36:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 06:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705318605; x=1705405005; bh=f22kAhB/gs
	b68fqAKKl2zfcNNiBmYtIB/0Hyce3b8x0=; b=NiNC1cNThE0VvdhGh83xn9giRU
	6tfzho7DtmOddgzVSBFWntaLB7PiUrL/riopwWv48K/ta/Ys/9Ix+fFRkgjP0k9o
	7FqHMr5pGBfef8LCQmgwPzt8D39vjRCk7OLjWISgZjYKhwcau2tjcuTmmaXdf2z+
	WK4vUsr3phig4GTVyEIdc6+N9owMD37y0GN7//5PjoUNoXkjwsH86m0BNsA3cLOT
	7i+mRugTwIaSi5/QJeFPDD8YDEgGT01kbMw3ivFvdK9fC32RInGSHsB1dFVdscVb
	BQsGW7Wvg+RZdt2HQvxqHd36OKTI78qaN0j2OncVRtz/WqTdYa7RJc8hPNAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705318605; x=1705405005; bh=f22kAhB/gsb68fqAKKl2zfcNNiBm
	YtIB/0Hyce3b8x0=; b=KlLLvYBD6X2JNzL4Yntvhigo5Wfxkf3c9Ovs++qdZeEM
	sMA5KthyO5svryNJXu1nD02TLsQaorXBLqErU1c9LqBTgZFOPoC/ioD2D0gCtzQx
	EmKuZzY7IhJgLY2JJALb39KMMep5KX9uE6mP3C/oPj2hMpIhYSZWs1FQvJmIsGTA
	/fSOZJzbi/1PwtnbCaV1PtsyMX7D6wljp3lLmUJ6wmZRu5r/Vi85BcjRd1fH3ev7
	Qmp9RLD3X4JEiNtijyc1AGQ9b1drmlqR5DyG4gXRg2rW9pDFULfc6ys/H5iwXQdv
	gcP3iCF8GQHV9dyo/N+wqKCKStfDtZFcIEb0kzjJ3g==
X-ME-Sender: <xms:zRilZZzCzreqEby_WaN6sUipAn3eTn86QsOhiFOJHQyU3rnVRiwHcA>
    <xme:zRilZZQgp_168sZs158l6aInMF9i9YTLnYOwjo-XPEb85jPosWa75fQ2IriyS8-Z-
    PJcgSF_PYQoHcmhKg>
X-ME-Received: <xmr:zRilZTUvPn_Ck1G5U_sA58rRpYLJzf2iMAU7Nc3281LRo0ttz2SvYlfxc8JmYt4N8APqNflQrLcD1gqvZBb04mElpESuIrLPxfr0vMbc7ZIIug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zRilZbgjo8uZwZL34zyN1OFzdH4lQpRCbQ80uIPcJVxKAU0TeNdCNQ>
    <xmx:zRilZbBJcQAiTzi_jOwMBH2SarcEYHyO_J9aSNOl5g_9cv1zfFZMgQ>
    <xmx:zRilZUIclwc_5ak9AwP6auurNTTMzfX-OVi9KhIklh3gXUPrTK3fbA>
    <xmx:zRilZSMIOs7PsAx0BpZR40Pt3BV3IoJqoCz4gm0vfrg92BqO2RFbNw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 06:36:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f067138 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jan 2024 11:33:52 +0000 (UTC)
Date: Mon, 15 Jan 2024 12:36:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>, git@vger.kernel.org,
	newren@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/2] revision: ensure MERGE_HEAD is a ref in
 prepare_show_merge
Message-ID: <ZaUYyEAdr4oTImL-@tanuki>
References: <xmqqy1cvcsp3.fsf@gitster.g>
 <20240112155033.77204-1-mi.al.lohmann@gmail.com>
 <xmqqzfxa9usx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehCiveO5yfzqrj16"
Content-Disposition: inline
In-Reply-To: <xmqqzfxa9usx.fsf@gitster.g>


--ehCiveO5yfzqrj16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:10:54PM -0800, Junio C Hamano wrote:
> Michael Lohmann <mi.al.lohmann@gmail.com> writes:
>=20
> >> but we may want to tighten the original's use of repo_get
> >> > -	if (repo_get_oid(the_repository, "MERGE_HEAD", &oid))
> >> > -		die("--merge without MERGE_HEAD?");
> >> > -	other =3D lookup_commit_or_die(&oid, "MERGE_HEAD");
> >>=20
> >> ... so that we won't be confused in a repository that has a tag
> >> whose name happens to be MERGE_HEAD.  We probably should be using
> >> refs.c:refs_resolve_ref_unsafe() instead to _oid() here ...
> >
> > Here I am really at the limit of my understanding of the core functions.
> > Is this roughly what you had in mind? From my testing it seems to do the
> > job, but I don't understand the details "refs_resolve_ref_unsafe"...
>=20
> Perhaps there are others who are more familiar with the ref API than
> I am, but I was just looking at refs.h today and wonder if something
> along the lines of this ...
>=20
>     if (read_ref_full("MERGE_HEAD",
>     		      RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> 		      &oid, NULL))
> 	die("no MERGE_HEAD");
>     if (is_null_oid(&oid))
> 	die("MERGE_HEAD is a symbolic ref???");
>=20
> ... would be simpler.
>=20
> With the above, we are discarding the refname read_ref_full()
> obtains from its refs_resolve_ref_unsafe(), but I think that is
> totally fine.  We expect it to be "MERGE_HEAD" in the good case.
> The returned value can be different from "MERGE_HEAD" if it is
> a symbolic ref, but if the comment in refs.h on NO_RECURSE is to be
> trusted, we should catch that case with the NULL-ness check on oid.

Yeah, this should be fine.

Even though I have stared at our refs API for extended periods of time
during the last months I still have to look up this part of the API
almost every time. I find it to be hard to use because you not only have
to pay attention to the return value, but also to the flags in some edge
cases. I wouldn't be surprised if there were many callsites that get
this wrong.

> Which would mean that we do not need a separate "other_head"
> variable, and instead can use "MERGE_HEAD".

There is no need for this, is there? We have already resolved the ref to
an object ID, so why not use that via `add_pending_oid()`?

Patrick

--ehCiveO5yfzqrj16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWlGMcACgkQVbJhu7ck
PpRlQQ/8DsqmlpR8l9RKktG1mrALinoRwyw2ZydgUF801i85umIJ6uhEPgDYd6yE
YjXGDOwmp43ttW1Xg2T/pyyU3NniQQse+f6YAwtrlWfOWZpcac5CX+VchOOs4FC5
GAY48zUrcJ34kgsvjaVGwnWjzHB7gM6a9uRNmP9Y+oxrgHCONpubgFx4/yUSMqoX
HZzdu3lhHU9rf151ukU6ilew0cq9nYw9dDLYU7Bk7MAqJ9/efukx8v3AvchZmzSY
CWkG689yFkUbZnVKU7AX02dxkfquUONNIxVaOlPE7mgFx0iQzw71nZ+eemsnkwP6
ZLrkXC8imbUL5Doej+3H5mjs3N1d9b6j0migVCVBZ4X2+eYbiHGNKUG387fSNxHz
bZeL9DNEwhwlxn32jX8b2Aghzq3IYwo5/ZWLSDlY1qj/1dM8KG+kzjqCGGhA+ynq
jUNkYx4qGRGq/NGF6H1pEMRZuXMtWIkQtsarhEE77qeSfsfrKiTL33+dNBGaznff
sEgCu+oWPnhV71Sp5mmbe2BT3ehDvcuTQR13fR2+e0WgNjQt2HBMzeCPaXCJg7GK
IEBwLAUxws1OMhP/3PGIVU3u8U7C1COjqzrpO/Z3ITE7jaS0Z9zoTimcyIjZoc3I
CdlA8EwmD108i0UTlm9gHTxDXqw9nIDk5D1aTypMs0vIQsmZOVI=
=J3TB
-----END PGP SIGNATURE-----

--ehCiveO5yfzqrj16--
