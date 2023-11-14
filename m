Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCEC10E9
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M77S684b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JSL/gzfW"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A3173F
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 00:46:31 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 71E265C028E;
	Tue, 14 Nov 2023 03:46:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 14 Nov 2023 03:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1699951590; x=1700037990; bh=lR
	HJF909xr+9bJKBtJdQXG3TnM6dPO0pNUaegokFVvA=; b=M77S684bl5EcFNt4SI
	olQOi4NpxYMjthGWTUT4MB6QXiCMY8Xb3zQ0TSFILe0kAx+7gxoOWjivIqsx01UC
	fCRCeUWA0j/HW9dRV1GeIQ0tIw+2pCS7gaqZMEAIZ8/DpUEDOfRYTTeZDaPyyj9k
	yRwGqEsA5BcpREqMBjqcNp5ZsSCzlvMmqDLVcm+6Fpwv2wlVwecySGHyL5Ym8FWL
	F3gSaAt5J9HxEfjl9xmibNg030HX1ApHr/2lK+DspldWVwjtz+erFSlVdp1bEt2d
	bfSdGNquPk5ZHiwpY58UYpUbnXibUBPPtf8YcP2/mYXtHcyMJYScX+Cm9GaMSjbV
	1DCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699951590; x=1700037990; bh=lRHJF909xr+9b
	JKBtJdQXG3TnM6dPO0pNUaegokFVvA=; b=JSL/gzfW1l1QagEe6716smiHoPcDU
	gGnBFxd6+JGvFJws500jQ6qzkOK+tGwKP9WhkKMKlxoIV/UAxWsdVriUBTxfmixu
	wgUnv+Nslv+F7vVlOSHm5Fg0CHITbv/jnIzoQNWkh9LaF86RMmd6KkGMbGu36lBm
	5KIO3ZFZ2l5GbbCyDpxHQpx57WBkhViEFrmmT6iorDAuGMgQwJgUJ4QRVHLR+21V
	BG4DnBPCuuUfCix6Rhf0vAJID5Dd+oodAw1zTMwMXEVo4uWqhpQZX3YTuhOb5R2j
	IRebgY+z8+2JWLenG3JvUMSD8rkGJ0GtwavKEn48D/QYM2zq/c4xX7QPQ==
X-ME-Sender: <xms:5jNTZVM6IlWI8nx075wZaUE0NuqaO8DgchH7DxQBuzlKGhUm80HjFw>
    <xme:5jNTZX-DcwYjT733HwzQxGfH43HdPz_HqDgpY1M0DH2svIA7S0Edy0ttuWhfahGaz
    apHtUBaPi2_dK6BXQ>
X-ME-Received: <xmr:5jNTZURvx9muVne9iJZdeMWELUPDKRJLQbAhVbZfso6c0VdR8OAy3vUY81WvIVin2-kOD9L3Jv_N-zw_QuJ2tQO0obUzttBZXzXkqdf_N16_zxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5jNTZRvkdLcDwf5GncZ_DV7jcD_bOk2J_WovEvF7sCZLDaDpkUsstA>
    <xmx:5jNTZdcl3RDDnRFp914i-M3yuIAAYvHL52mPb811-J2JE25NVaAvMQ>
    <xmx:5jNTZd3iQrMgJ233mPSCmxs1VEd-90H3d6etebArj7YczeqEC2_kuQ>
    <xmx:5jNTZdE3_Bfr9I2_BieS1fGsphv9FoZ3KqZsUQcSmUgyCjCNmY-dpg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 03:46:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64bbaebf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Nov 2023 08:45:50 +0000 (UTC)
Date: Tue, 14 Nov 2023 09:46:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: commit-graph paranoia performance, was Re: [ANNOUNCE] Git
 v2.43.0-rc1
Message-ID: <ZVMz4iDWfC__H8Jp@tanuki>
References: <xmqq8r785ev1.fsf@gitster.g>
 <20231113205538.GA2028092@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c6UdL4TkP4+sbFGz"
Content-Disposition: inline
In-Reply-To: <20231113205538.GA2028092@coredump.intra.peff.net>


--c6UdL4TkP4+sbFGz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2023 at 03:55:38PM -0500, Jeff King wrote:
> On Thu, Nov 09, 2023 at 02:33:54AM +0900, Junio C Hamano wrote:
>=20
> >  * The codepath to traverse the commit-graph learned to notice that a
> >    commit is missing (e.g., corrupt repository lost an object), even
> >    though it knows something about the commit (like its parents) from
> >    what is in commit-graph.
> >    (merge 7a5d604443 ps/do-not-trust-commit-graph-blindly-for-existence=
 later to maint).
>=20
> I happened to be timing "rev-list" for an unrelated topic today, and I
> noticed that this change had a rather large effect. The commit message
> for 7a5d604443 claims a 30% performance regression. But that's when
> using "--topo-order", and actually writing out the result.
>=20
> Running "rev-list --count" on a copy of linux.git with a fully-built
> commit-graph shows that the run-time doubles:
>=20
>   Benchmark 1: git.v2.42.1 rev-list --count HEAD
>     Time (mean =C2=B1 =CF=83):     658.0 ms =C2=B1   5.2 ms    [User: 613=
=2E5 ms, System: 44.4 ms]
>     Range (min =E2=80=A6 max):   650.2 ms =E2=80=A6 666.0 ms    10 runs
>  =20
>   Benchmark 2: git.v2.43.0-rc1 rev-list --count HEAD
>     Time (mean =C2=B1 =CF=83):      1.333 s =C2=B1  0.019 s    [User: 1.2=
63 s, System: 0.069 s]
>     Range (min =E2=80=A6 max):    1.302 s =E2=80=A6  1.361 s    10 runs
>  =20
>   Summary
>     git.v2.42.1 rev-list --count HEAD ran
>       2.03 =C2=B1 0.03 times faster than git.v2.43.0-rc1 rev-list --count=
 HEAD

Ah, indeed. I thought I already benchmarked the worst-case behaviour by
simply doing a full graph walk, but of course the performance hit is
even worse when not outputting the commits at all but only counting
them.

> Now in defense of that patch, this particular command is going to be one
> of the most sensitive in terms of percent change, simply because it
> isn't doing much besides walking the commits. And 650ms isn't _that_ big
> in an absolute sense. But it also doesn't quite feel like nothing, even
> tacked onto a command that might otherwise take 1000ms to run.
>=20
> Should we default GIT_COMMIT_GRAPH_PARANOIA to "0"? Yes, some operations
> might miss a breakage, but that is true of so much of Git. For day to
> day commands we generally assume that the repository is not corrupted,
> and avoid looking at any data we can. Other commands (like "commit-graph
> verify", but maybe others) would probably want to be more careful
> (either by checking this case explicitly, or by enabling the paranoia
> flag themselves).
>=20
> -Peff

I'd be fine with that as a follow-up change, yes. I agree that in
general we shouldn't see this kind of corruption, and it's good that the
behaviour can be toggled so easily now.

I'm happy to write that patch if you don't plan to.

Patrick

--c6UdL4TkP4+sbFGz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVTM+EACgkQVbJhu7ck
PpT97BAAlehu2WmRVQY1u1uhdnWmwA8S4QTVBa60DwX/H3XmZeKmitYOTWIpdj5U
eLKDPYJ8t0S8hoews5o3xmE3XCcTWiRBEZW6UCR1jG8TU34jkah04CxHte+MGRtX
aWSDCdBXns4Qz5XUit4Bi3eVnd8h5FLjgJ+FLhpnKRgKjovfiXgTCEjhsbDZOLJr
EQSPgc+xGi3leYxY0Ix+Z7uRqHnjdPpOvgrzRdWxMIp8Ogzc8kOeOugPj86QWgSa
03UGx5Im8ubwtJ5OXL3Y0E5XWfbC2HpKZQjdCos8B7T6WflKKD5rV0eRtU3qLP1T
/t2/iEPEKiXdB2zXGEw2EptCjhl1OnjRThQ965Sr3dJsANH7TUQekqE6mk3BcIS6
DTx+DIu254X/Dxz+yf72CWztIe07NOtrCHvydd1IajDXwrDCkr6JHpf/3Xt7gEAk
mirxj3M43BiCB3EzDB5yWXYolDTLxfhYe9KdUVUsbrvYOLFLsnR7T6P+bv96SLd4
x89v+UHMymuilGsd9QUAGPqTBk01l7oQxpNiQjpHEXHgrGJWgBVLqkrIWdMzPz1U
Uw1E5ILepxtHwVz1XiWw/wkj7MrZjIDR1u76tCvAozHB59/M5KKmR3zl/2WWWUfg
UjEcOF/nx21h0pk355zzoOeUwi98PSpT36pWhIvhQ0XkysqYV5c=
=1alR
-----END PGP SIGNATURE-----

--c6UdL4TkP4+sbFGz--
