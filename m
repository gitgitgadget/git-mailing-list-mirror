Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C915382
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbe45Qv6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZAEulUOo"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 3819B3200A89;
	Thu, 11 Jan 2024 01:56:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Jan 2024 01:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1704956195; x=1705042595; bh=u0uektmYC8
	5AzBDBZQ5eJ5yNlTGVfUWRKfHVMNBDD7k=; b=fbe45Qv6cdYWtf1fknj8ZZn3Dy
	6h8KpvqPh3/HX4yIrMeEf6bd8XAPqb85ixvvdxEirIDOLlg20gGjJLEO2jkAqFzT
	C2QinaZsqz4CTJGfrXKtJJjH+y6FcYrK3rgt2hKbT8rwUSqKfnHKfDVv5B2Ftx4K
	qtYTy/p0u4AwVzuAjN9K/JPGUNzgmLFojQjyliUFQ67pQ9jZ6etwuwlXlvDJGYe1
	67HOWzNg1VlRxGDxv8vzbkrvb8VwcXCn6EouyV40cxpF6eHu8Et2L5mxeb8Ta5//
	Y+6CYGTwKnuGqJYW7xpRbhU/2FEGY32wBOlw7GGQVYOx5scov7FOhy9NZwcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704956195; x=1705042595; bh=u0uektmYC85AzBDBZQ5eJ5yNlTGV
	fUWRKfHVMNBDD7k=; b=ZAEulUOo0qxNObhYIiw4nZclttu0PxOWJu3QlorVNsQj
	sCuljXQEXfusrSfbXx/MmfkUb4OWGQNB/u5Udr3kbibMLgRzyL9hl8qPB6WdMynp
	xG+S3xtUUYQVkeFuPmXo8qgeuJDnVLvdCFFxXOdYbcEgQ9aXkbpGu6Mik1RB5ABl
	+QFSTlxiaulz2PM4erFYJ8COXuZTXt1mbatodScQEgATg6j6twlMnyGt2EjrSi5n
	jX2RjvYgzxj6NgNiaVg7crW1eZRI4evcDCsn9G2g4ENYzzBXWMXNVYj/gyzMA9Qi
	TRTzTOFpyMjhso2eYVMCwHSYBByC/DGJBoCuuq60CQ==
X-ME-Sender: <xms:I5GfZYmhDKkJs9Sk5eqzx85vtaIE0eVcYN5AAuQJ7sEqcbnDFMb9FQ>
    <xme:I5GfZX35w1MsrQau56UEOS_uWJRtZ7QoKO_9UYlZTQMJGwRylN7erG3uGy7-zgZ8X
    P-FCZPeXFJY5DVK_g>
X-ME-Received: <xmr:I5GfZWrgMxlV_pxaxjU0t8rxXzH-AGoquRtgeQi40sE4En2K5Jq4p3_i2Jjnn-rSs2LCQ9DG5rPCPWHKoZsJ_byGz5cniTYb83vssMDMAMQCeuBxpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeivddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:I5GfZUk1UWkc3sZD_orb5xOMrEdxqFCh-Ayz7BeEZdB6Pc8SDi8iww>
    <xmx:I5GfZW0KA3e-4M5p-Re9ZkTubp-AqwqvmgO2fP9dEBhQmHizHQVEww>
    <xmx:I5GfZbv6CwvTQFgkRiokCnNhNYSFB9uYJt6OkzmoENFV-l_Gkz4h4Q>
    <xmx:I5GfZZSDdhhkvmaz4_5Zx013G5MX2mvzr6MarYeoZf7dDZ4flo1oSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jan 2024 01:56:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b9b55421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jan 2024 06:53:51 +0000 (UTC)
Date: Thu, 11 Jan 2024 07:56:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ-RH8L7H9vLcqoR@tanuki>
References: <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g>
 <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local>
 <007c01da4420$10a7b700$31f72500$@nexbridge.com>
 <CABPp-BEw_HFL-9u6WdSEe-qr_JfJyQtfU6PP7izEdPChKooc6g@mail.gmail.com>
 <008701da442f$b2dfe420$189fac60$@nexbridge.com>
 <CABPp-BHx=4HPSN4enkHTL7PPnNBsJ1vGWe4Em5imH7HcOcH2PA@mail.gmail.com>
 <009c01da4439$f70beef0$e523ccd0$@nexbridge.com>
 <CABPp-BGmXw0NQ8yBaMiVXHiKr0-Y_jkZWmJB1CG_oc4UGxt_gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IAXLOeXZvI/gBrqI"
Content-Disposition: inline
In-Reply-To: <CABPp-BGmXw0NQ8yBaMiVXHiKr0-Y_jkZWmJB1CG_oc4UGxt_gA@mail.gmail.com>


--IAXLOeXZvI/gBrqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 09:06:23PM -0800, Elijah Newren wrote:
> On Wed, Jan 10, 2024 at 6:57=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> >
> > On Wednesday, January 10, 2024 9:21 PM, Elijah Newren wrote:
> > >On Wed, Jan 10, 2024 at 5:44=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> > >>
> > >> On Wednesday, January 10, 2024 7:59 PM, Elijah Newren wrote:
> > >[...]
> > >> >Would you be okay with the following alternative: requiring that all
> > >> >Rust code be optional for now?
> > >> >
> > >> >(In other words, allow you to build with USE_RUST=3D0, or something
> > >> >like that.  And then we have both a Rust and a C implementation of
> > >> >anything that is required for backward compatibility, while any new
> > >> >Rust-only stuff would not be included in your build.)
> > >>
> > >> To address the immediate above, I assume this means that platform
> > >> maintainers will be responsible for developing non-portable
> > >> implementations that duplicate Rust functionality
> > >
> > >This doesn't at all sound like what I thought I said.  The whole propo=
sal was so that
> > >folks like NonStop could continue using Git with no more work than set=
ting
> > >USE_RUST=3D0 at build time.
> > >
> > >Why do you feel you'd need to duplicate any functionality?
> >
> > I think I misunderstood. What I took from this is that all new function=
ality would be in Rust, which would require a custom implementation in C fo=
r platforms that did not have Rust available - if that is even practical. D=
id I get that wrong?
>=20
> I think you somehow missed the word optional?
>=20
> I did say that new functionality should be allowed to be Rust only
> (unlike existing functionality), but I'm not sure how you leaped to
> assuming that all new functionality would be in Rust.  Further, I also
> don't understand why you jump to assuming that all new functionality
> needs to be supported on all platforms.  The point of the word
> "optional" in my proposal is that it is not required.  So, say, if
> git-replay is in Rust, well you've never had git-replay before in any
> release, so you haven't lost any functionality by it being implemented
> in Rust.  And existing things (merge, cherry-pick, rebase, etc.)
> continue working with C-only code.  But you may have one less optional
> addition.
>=20
> At least that was _my_ proposal -- that Rust be optional for now.  It
> does differ from what I think Taylor was originally proposing, but
> that's why I brought it up as an alternative proposal.

There are two ways to do this that I can see:

  - New features may not be available on some platforms. I think this is
    what Elijah had in mind.

  - New features may require two implementations, one in C and one in
    Rust. I think this is what Randall understood.

Ultimately, I think both alternatives would end up demoting platforms
that do not support Rust to become second-class citizens eventually.
This demotion is rather obvious in the case where new features may not
be available. But I also think that the second approach, where we
provide two implementations, would lead to a demotion of the Rust-less
platform because the alternate implementation in C would likely end up
receiving less attention than the Rust-based one. It's thus likely that
the implementation receiving less attention will deteriorate in code
quality.

I also think that once we start to accept Rust code, it will only be a
matter of time before we want to start using it in central code paths.
Rust does provide interfaces which are a lot nicer to use than the C
based ones, but it's hard to really reap the benefits unless we start to
embrace Rust fully. Also, the most complex interfaces tend to be those
which are deep inside our code base, like for example the object
database. They are thus also the most profitable targets for a Rust
conversion, even though likely also the hardest to realize.

To me this feels like a slippery slope, and the deeper we go the more
incentive we will have to drop platforms which do not support Rust
altogether. So I can certainly see where Randall is coming from and why
this proposal is not something that he is thrilled about.

Patrick

--IAXLOeXZvI/gBrqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWfkR4ACgkQVbJhu7ck
PpTOMA//Qohk6uA32sc5EsKATmfQcbRhFXt0h5hEyu5gvbKiqb2v+o6yXfLdPKY/
+JdqGvsEzt6wZkbJE+aqOjXbOSE2FEClYKzss1Rnb6fQeMEDyd73LcsD6iPkvhRS
pmSm79x/nCnBsHe4KM9GeM/zIZgRtP5KacIrU6y+cpixf1Ftw+yLTcWBqz9O20Df
WsnqYhdjzkzhtlhjtS/bDY2nDrkHgZ5VKk9f76FzXb1EKqead1r4VEAfF7hPKVY/
zJ/PJayGbIaDIDjP6w6Muu+N0Nvw+xi4C4F/zqLYXPisJ9OYTHcY2DE1Z5a/viOX
ceYzqoKloBgrNiRYx9gN4A/lkJv3pcDJS/kDoMjgVTHSlICiDcUgIL0ueTYUDO1f
+M4ShuY29btMz/f8uMR4RVvYlEAbojpAV0ekGKlcxTenS9DyWBL9q2fOmcj0e5CY
gj26HAoXxE8j/4zLyV7fpaef/s7wG6HHIILlkNQrOPa57nMhDTIhgHWbhhUh2L0A
IKv2zZgPu2TN1Ak3FzgIZ6p5CkIkWlAT1M6XPxnO7Sv/wZMyL1tAsoQj5khtMv5n
uAnjVZeIUwnYgyr1dgc/HzNZcelquMgE/CwNasJQiN2SrsugoqhImSCO7yF/gLt/
39kcDM19O+DCpjtB2d6tEEXDxqjk4bIJGHAFeZtoc8U+W35tDnM=
=D7bj
-----END PGP SIGNATURE-----

--IAXLOeXZvI/gBrqI--
