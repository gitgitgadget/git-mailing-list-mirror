Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vRT/eWMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUmoKmh2"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED740170C
	for <git@vger.kernel.org>; Fri,  1 Dec 2023 00:31:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2AC973200A3F;
	Fri,  1 Dec 2023 03:31:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 03:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701419479; x=1701505879; bh=l+
	qxk/Mc/UeM9yqHxQBAQYxyVZLmkLxfZmdYRmEYlc8=; b=vRT/eWMic9mISbvE9h
	jRydrWFXCLijHxTCMD0qKb4DYM3ZwmaYXuZwyfVX1LqNgY59vVel2pff0lAVk8F6
	UWqNJImo4m4OraeTb09T5wQFBhmHuTOgQ1+Mz2cvCthr6FCygSS8DVzESEznElvU
	H4wEhS60wBb3ECZHGO4rRda2HcpcQov/A9kq43BsG1tEkIByoePuqSghSD8JPE+s
	dVckWuWJt0pJTicRBCfmXdm9CVs1RojHfT+38acNd6DPLGc4HXaLjwKXhNUf1yDk
	nrJzI9mKvC7hW9Q1NgT/uCg0R0CUzTqHXolwmgN63vbH5hABFjfEo6OJmcohB0bp
	y5sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701419479; x=1701505879; bh=l+qxk/Mc/UeM9
	yqHxQBAQYxyVZLmkLxfZmdYRmEYlc8=; b=vUmoKmh2iOP+wh953kqgYBJQVZz92
	A/vP0ikBAOv6U5NaTSp+8gUdaPMiypBvdcVl6nyaJ03w15OWl6EVY2m+4tz5HniT
	hKV6oKSB1OdkoRHV0Gulko+F4RKSm18JfK3HkwSNpgJAP8CdnNhW8SSDlXuT0gnN
	qA2plzjy30z9Zqi0cvfYsqfvP1vicX1nSc/YilX0n7X2u9rFagMshdpxfOI51VL0
	Zx5hCRbJDdDGH0iWlXILahwhVpB0SXKRdIE+SF7e4OP+Pogw+Kyf3jEEYbTyHchC
	TcCaTGRMQ4vr98du9egDnVf2FBGgcCc1j3TCF76zseV5yJYaU0huYQR+w==
X-ME-Sender: <xms:15lpZQZ9ClX3XM3uAuF3ICQdtAALt0xy3AkhoS8YjVFWL3ejIkzlWw>
    <xme:15lpZba7SF8jAIkitZNJhVWLrD-LAqGfb3pz2eDYXVcSKzweMxyhK9tAEFWoKap0G
    w-MJrfFR6fesIfo5w>
X-ME-Received: <xmr:15lpZa_IxcHraJMv3USSsVmjlCNWNeiihExKdJzVmbX86ZIdif2Pw8AqvFAF2OWVtZKZBbUmwQ7ex5vOUC1fePK7dh38JFxDqqhsPG4SiaZ4cKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeikedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:15lpZaoYuzvwsD9UBIpwsfhYY6BGXbRW7cWemxLBJV3R0ZBntbMvbg>
    <xmx:15lpZboAzut24FlVi5fZg5GeT_wocsF4pZRxyHhNlPJLTe9CgX28Jw>
    <xmx:15lpZYQHvPMsKegF1jTmGRBt6Edr48tiADhg4RaFFglFOYrSaLmoMA>
    <xmx:15lpZS2rrrWOP5D1UOiu-z8UuOr5HnmBXcgwsur_HJqoeD5GtVbuGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 03:31:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f60d515 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 1 Dec 2023 08:30:01 +0000 (UTC)
Date: Fri, 1 Dec 2023 09:31:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZWmZ0pk6fr-8dmF1@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <ZWhha2h2zzZWCXrw@tanuki>
 <ZWjk/TYzsrdHefgy@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e+pLgYLC52iGu5MD"
Content-Disposition: inline
In-Reply-To: <ZWjk/TYzsrdHefgy@nand.local>


--e+pLgYLC52iGu5MD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 02:39:41PM -0500, Taylor Blau wrote:
> On Thu, Nov 30, 2023 at 11:18:19AM +0100, Patrick Steinhardt wrote:
[snip]
> Then you'd have five patch series, where each series does roughly the
> following:
>=20
>   1. Preparatory clean-up.
>   2. Implementing the DISP chunk, as well as --retain-disjoint, without
>      a way to generate such packs.
>   3. Implement a way to generate such packs, but without actually being
>      able to reuse more than one of them.
>   4. Implement multi-pack reuse, but without actually reusing any packs.
>   5. Enable multi-pack reuse (and implement the required scaffolding to
>      do so), and test it.
>=20
> That's the most sensible split that I could come up with, at least.

Looks sensible to me.

> But
> I still find it relatively unsatisfying for a couple of reasons:
>=20
>   - With the exception of the last group of patches, none of the earlier
>     series enable any new, useful behavior on their own. IOW, if we just
>     merged the first three series and then forgot about this topic, we
>     wouldn't have done anything useful ;-).

Well, sometimes I wish we'd buy more into the iterative style of working
in the Git project, where it's fine to land patch series that only work
into the direction of a specific topic but don't yet do anything
interesting by themselves. The benefits would be both that individual
pieces land faster while also ensuring that the review load is kept at
bay.

But there's of course also downsides to this, especially in an open
source project like Git:

  - Contributors may go away in the middle of their endeavour, leaving
    behind dangling pieces that might have complicated some of our
    architecture without actually reaping the intended benefits.

  - Overall, it may take significantly longer to get all pieces into
    Git.

  - Contributors need to do a much better job to explain where they are
    headed when the series by itself doesn't do anything interesting
    yet.

So I understand why we typically don't work this way.

I wonder whether a compromise would be to continue sending complete
patch series, but explicitly point out "break points" in your patch
series. These break points could be an indicator to the maintainer that
it's fine to merge everything up to it while still keeping out the
remainder of the patch series.

>   - The fourth series (which actually implements multi-pack reuse) still
>     remains the most complicated, and would likely be the most difficult
>     to review. So I think you'd still have one difficult series to
>     review, plus four other series which are slightly less difficult to
>     review ;-).

That's fine in my opinion, there's no surprise here that a complicated
topic is demanding for both the author and the reviewer.

Patrick

--e+pLgYLC52iGu5MD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVpmdEACgkQVbJhu7ck
PpR5RBAAj+MH/Wgfxrkd12pCuxWqFXNEgcbIs/k33fFLB/vs7s1MdEr+JOxEcThv
g8d0i87A2BLLsbdd113WtasaRI2+532RtjjB99UNNHwgRS8FP7EdLiEmPKLXAQbv
T17LW/1AEbDwiNEgwNFIPVBEKVyk+6q7IK+lz45nULWHUHaVb6LNLn5OKSXeiyK8
iKnj2V1rguB61hXPUpqfGs2sGEA99czZ7B5LiS9eBxULSfYIwFmBNv4bOsnojfTW
UrN4T1eD9sDmRfwO7QwaTJNMJCh4vtc0kVmqXFR8VkdBLq7NNRZl5n84+I+Ts2Tg
KOKKbVP6Tzt64B1wVw0oZBIe30TXEFPAKWl0McShvncUBhHVB7eW59ieAdHg+QD7
O9MtKOYuEMcH92ZfBNz11G1uYTzIB3sr4kAEf9Q630G+iNIKzele7gqMZ/M2w81P
YDCx7KB79hS2yPwKWUMS5CRekwFCnnyeREzfHdLqhDC5veeMB7izozfUGHVp3lUP
WV/4DuyAMM/Ru13TgOOWs5krx752/3mKDpPWdgixL+7EHFWl1Vi8fK9V2k2bZUX1
bZpy8CRDVYnIa4h24s/38ZGo40InAXrghCr9AmMOiXkvVsC156hCEvvjNHfBcyDu
jPzlh1Hb7vLJOqgJI3Rj3+VsI2r0O7TEfVVCci7n4fMEf5pz+bY=
=3qzJ
-----END PGP SIGNATURE-----

--e+pLgYLC52iGu5MD--
