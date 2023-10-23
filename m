Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA2101D6
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xSAnkoL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akZ8YKdu"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B74A6
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 00:38:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id F295A3200985;
	Mon, 23 Oct 2023 03:38:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 03:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698046700; x=1698133100; bh=KH
	dHBAvoKWVWJ/Tea27Y0Qx+Ukn/INI39/lcT2bheUg=; b=xSAnkoL+eVk0ccTWZt
	hNpLBjdo1bJCPllftM1NUi7ASu6j8pxYvGUNnfsDIVBBkfwe519lhguYXzVqWyBc
	hat/1f0KzeqGFin7UcdaY54xYpWZr7ZIFVrfz6augJvn/fuuCV6a1YuslI0F+g7A
	9cSDZRLccqHXF9AjaCNODPPWs3WScQs8K4ctAFhPex6WGsboFpMgpdm3GkVPLC87
	8ETsFJ9XOJ2NWCX5vfRPj9euVcHwHkKg5Q9E9C6fcyG6gAc8LWUHGgu8zfP0oviq
	OiUrUHdOKIir35IoFOyDRxHeVgaBmv9Pk8lEaLD53XAA6sCsUAi/o3AKafAljjGh
	/9HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698046700; x=1698133100; bh=KHdHBAvoKWVWJ
	/Tea27Y0Qx+Ukn/INI39/lcT2bheUg=; b=akZ8YKduh/RkTQdxPf67Ui2n0mDoq
	WkEQvx2omK2F3nZvwa2ecHUHYSYmtuyYl+0X46imzfiP1+GKgy23lPkMYN8pxW8g
	TifzWvykdJIQA7KIfNvl4a0hGbWzyrHY/fc/aksaTyyUMmNXPM1q5rvoRFWpPWJA
	oD9n9uTdoQSRts74ra4y/frTAUq2KHZWp5HLV44TAMt/qnLLGL8/lGhMP3R+g6KP
	hJHaiwfyEnHaZ3k/BD1XdcqZUcKNzLfxW0jXNXbFQd4vzOFDbORCYhlR7ydDV+1H
	MOW6FkIOejboWP7h2vzttXvjr4oKmbxdGQGlakmriQgoIsIurny0VcokA==
X-ME-Sender: <xms:7CI2ZWtYSNIn_W3ApIWERNhNnPFsRJDks0zx474iWDK1ow3RY_HiRQ>
    <xme:7CI2Zbfj1xxaCJthpOeL3D79bMDznEcJEYBjTnAOhVR8gUhyTDexniS1F55LepF34
    uMkiXc5_9VwUvgdhw>
X-ME-Received: <xmr:7CI2ZRy3ltTahG6GiNKFUC8ovhLMPUruTU5lxKmYdDYfdGu9GkgsJAZrN32pJWVN5-2_x9ITGZ4D3Tko1akIut8uhC47Xhmt-bqkxTsyJx21>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeehgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7CI2ZROLYkfeo75zgHUBNEjSzmxevdX6rOoci8DilAAATYHZiJLKhw>
    <xmx:7CI2ZW8NsNkzHFnOcneqr9Bj4IAM9DvPpRsXhHw_9KyfFcYfC4wDTw>
    <xmx:7CI2ZZUOQgF43tbbCFzw9qGFTpx7yBXuVWWlLyQdyROsvdYtARgqNg>
    <xmx:7CI2ZdbRw7xNOnq-ECLC3jXiH7uxZkcto1pO5DPY4Ah8pbTvrW_A6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 03:38:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56aaa2b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Oct 2023 07:38:15 +0000 (UTC)
Date: Mon, 23 Oct 2023 09:38:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	cousteau via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Javier Mora <cousteaulecommandant@gmail.com>
Subject: Re: [PATCH] doc/git-bisect: clarify `git bisect run` syntax
Message-ID: <ZTYi55w_70ZlP8Ew@tanuki>
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
 <CAPig+cS4J-L44a-fjQ=2bXxRj6e1qdQK8705K3NPqmTsWXBQsw@mail.gmail.com>
 <xmqqa5sap44i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tE20GkvCG2/5bepL"
Content-Disposition: inline
In-Reply-To: <xmqqa5sap44i.fsf@gitster.g>


--tE20GkvCG2/5bepL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 05:35:41PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > On Sun, Oct 22, 2023 at 4:03=E2=80=AFPM cousteau via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> The description of the `git bisect run` command syntax at the beginning
> >> of the manpage is `git bisect run <cmd>...`, which isn't quite clear
> >> about what `<cmd>` is or what the `...` mean; one could think that it =
is
> >> the whole (quoted) command line with all arguments in a single string,
> >> or that it supports multiple commands, or that it doesn't accept
> >> commands with arguments at all.
> >>
> >> Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.
> >
> > Okay, makes sense.
> >
> >> Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
> >> ---
> >> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.t=
xt
> >> @@ -26,7 +26,7 @@ on the subcommand:
> >> - git bisect run <cmd>...
> >> + git bisect run <cmd> [<arg>...]
> >
> > The output of `git bisect -h` suffers the same problem. Perhaps this
> > patch can fix that, as well?
>=20
> Good eyes.
>=20
> Not a new problem and obviously can be left outside of this simple
> update, but I wonder if we should eventually move these into the
> proper SYNOPSIS section.  Other multi-modal commands like "git
> checkout", "git rebase", etc. do list different forms all in the
> SYNOPSIS section.
>=20
> I also thought at least some commands we know the "-h" output and
> SYNOPSIS match, we had tests to ensure they do not drift apart.  We
> would probably want to cover more subcommands with t0450.
>=20
> Thanks.

If we don't want them to drift apart I wonder whether we could instead
generate the synopsis from the output of `-h`? This reduces duplication
at the cost of a more complex build process for our manpages.

Not saying that this is necessarily a good idea, just throwing it out
there.

Patrick

--tE20GkvCG2/5bepL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU2IuIACgkQVbJhu7ck
PpRVfQ/+NVzd+Aw6GFc+3ieHaFa7Pj2+9m8L5tDfqQbeqD9Zcsdj3CgCgK5EI5MG
nLuob7VEZZy2iJyvQ3u+X/Zl7JHVdCTCYtq7dQ26Rt5aRE0fBYxgoGBzynoZBx8X
NmK3CVj45e1Qj+Sb6VoRp0O2+Wj86bHxCMHpooOV469i95WpaMMf8rW/Fg8fq/M1
euFE6VmJpt9mXOwxPn9t96bR3j+KjmVcBKggGRE9J6McENUiRxK8aTJHlFuuHWnt
FbTVR7HpYRbDUlsNJhhF0V+HMgsogWhs3kopRCUh3heZqq96CPqKnJ0uussmLoi6
juUumoUDULCJONDO9242Ycp6H5RZK3hbKhlW8AmtvZZ0ss4YH7+clY2BKrQIr7M7
lN6RstHVae7q7aFMUJOY4OQegw7FVSgxpXxhtynQOqh+wU5lFBNm/KnPgvLe8jk3
R4JJOghVYaNfdO3aI9O3CVxM/MeGldHpjX6xJ9NyBpa3tZsbegH3OlkPPk1xEUCG
+2Zj8DEng1ynN0gtg4IH2en6a1pjT9BprWJdMt134ay3fboxwWmH4uqfYuQibg9m
5Gi1qM4ShYzcdjl8XinPphrbrjXD4iSK7H4t6IcQ1KBc3d9bFEnh86DrVC0+Oc6h
qOhWEYVu6K/mZ/tBgz6VrSi5N6GJAFGmoGjw6lKJsPPPjrvrvfA=
=SOiu
-----END PGP SIGNATURE-----

--tE20GkvCG2/5bepL--
