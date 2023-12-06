Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkg6s4u4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vpHKIrdp"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C021BF
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 05:08:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 814965C02A7;
	Wed,  6 Dec 2023 08:08:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Dec 2023 08:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701868086; x=1701954486; bh=JM
	k7CaB/UecPtzgRv3bCzrtz/CuXxe8GRwf/2QPmsMI=; b=nkg6s4u4/ZBf/tuS1D
	pwVe1KpIJUh7Zf5/qbMUZwbvX+UvCD6i0Xq3CDnAzHdzEQsWcr6cLywGs1vPTR1H
	DWn5hK6TGD9nAi2ZQMzhqeMyU3ISGu/3PycXtgtY5GQiUsj/FGTxDqJxh6/6iR4z
	OqLC27Ey3qQ5J+EhrxnSlc1BAMtrpSGSDFSleUZmXASBxgAOWlyivKjjBvg6yRHq
	ox/ttsOJ1uaibqYhYLL80pq3uLRg5X53yG4in0ZnbOHXmrE2yqluKFcfbHUvpu6S
	7p923hTVMWrNatH3BusPhuB9UjcCj/3Q8e3dm0F6STn87DRFycD6eczpK7Q4ppdz
	4Ufg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701868086; x=1701954486; bh=JMk7CaB/UecPt
	zgRv3bCzrtz/CuXxe8GRwf/2QPmsMI=; b=vpHKIrdpBtv86ymNu2CVldedXemMk
	6CMY5s2B2BNjrbZjfDUKDqy/2FPG3gboeh5Bz6GkhzROiCVWQShdxbJzH4/vn6Lv
	vD4ygYMPy0RVYS70xkgganRb9ZeEAXg2OQg2Nlx7uWCeacXcJwd780HTL+w31QLp
	oWKM1WUEYhpTnLz7zcnsoWY02O7mzyTNL5D9RuMXn5yK9sjaWRBJetG8dHA4TCsL
	1Ved1D9onRON34w6mBGn44+cqrsTPsyjxYRl78krHoS+SlzvFHZVLKnbx4SZ3ECX
	GUng0SCZeJj411BRVR43vgORVzsovzcXNBUa7TKu/r0dGSkzbXeNPH4Yg==
X-ME-Sender: <xms:NnJwZahiqV2MUwe5mMDuhE-R0yPVHwAbY51plnTrmmx_a1uJPFtFgA>
    <xme:NnJwZbANmPoEsmHArBb3NrK8Ui3dVrG7BXoGcZ6Pwa5zjf0obAWdDUY90bUh6j5U5
    n0nXLI5tyrYEk7tNg>
X-ME-Received: <xmr:NnJwZSFMqoR07Anc3LvyiRIzhLCYIvCTVj6ZDOZgJgTpWbWrAXspM6JgAE3gybxWs8e880tj3NpxNoix9SDTxKLLA0QjqK_GdLSvL08k_fyk74M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NnJwZTR8N47kX_v_AiyxTiaugBjPc7ec6CeWVtOEM5ce2SALRuuCdw>
    <xmx:NnJwZXxeajvKKx0VhN30TCTc3V2-XiB35-BMLVhHMDHVb8_Oq3VTkA>
    <xmx:NnJwZR4_ZADdzqCuvfaWcWdsAXn_6Dkgu4ZolPOIXyyOvrTYmyTwyw>
    <xmx:NnJwZVZsTofed_mU5Lpn7DIQcVy8SrLAwcm4LyWqwiuK6E3Bu0NJnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 08:08:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8d39f6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Dec 2023 13:06:39 +0000 (UTC)
Date: Wed, 6 Dec 2023 14:08:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/7] revision: use die_for_incompatible_opt3() for
 --graph/--reverse/--walk-reflogs
Message-ID: <ZXByNGuQTaOQ3sKW@tanuki>
References: <20231206115215.94467-1-l.s.r@web.de>
 <20231206115215.94467-4-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wS4zgi0GGZhmxBx2"
Content-Disposition: inline
In-Reply-To: <20231206115215.94467-4-l.s.r@web.de>


--wS4zgi0GGZhmxBx2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 12:51:57PM +0100, Ren=E9 Scharfe wrote:
> The revision options --reverse is incompatibel with --walk-reflogs and
> --graph is incompatible with both --reverse and --walk-reflogs.  So they
> are all incompatible with each other.
>=20
> Use the function for checking three mutually incompatible options,
> die_for_incompatible_opt3(), to perform this check in one place and
> without repetition.  This is shorter and clearer.
>=20
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>
> ---
>  revision.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index b2861474b1..1b7e1af6c6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3036,8 +3036,6 @@ int setup_revisions(int argc, const char **argv, st=
ruct rev_info *revs, struct s
>  		revs->grep_filter.ignore_locale =3D 1;
>  	compile_grep_patterns(&revs->grep_filter);
>=20
> -	if (revs->reverse && revs->reflog_info)
> -		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "=
--walk-reflogs");
>  	if (revs->reflog_info && revs->limited)
>  		die("cannot combine --walk-reflogs with history-limiting options");
>  	if (revs->rewrite_parents && revs->children.name)
> @@ -3048,11 +3046,10 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
>  	/*
>  	 * Limitations on the graph functionality
>  	 */
> -	if (revs->reverse && revs->graph)
> -		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "=
--graph");
> +	die_for_incompatible_opt3(!!revs->graph, "--graph",
> +				  !!revs->reverse, "--reverse",
> +				  !!revs->reflog_info, "--walk-reflogs");

I've been wondering why we use `!!` here, as `die_for_incompatible_*()`
doesn't care for the actual value but only checks that it is non-zero.
Is it because of the type mismatch, where these flags here use unsigned
ints whereas `die_for_incompatible_*()` expect ints?

Patrick

--wS4zgi0GGZhmxBx2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwcjMACgkQVbJhu7ck
PpQLPg/9HKKkI6mnzRW1a9bWCVT9eLE6EDZ/J3TOBvW9fu9iOMPfw12oox4ZqnXf
2nB+dikmjlxMKKPyStjEGH4tlMhdqE9NLONEyE6HoQQVSBynvBMr1pFoEphIF4Tk
Xp5qWS5+mriTofNwDc8GEyyJ4pGcrfdds1hmssjc8ZTh81w8M0YyOuqIv9JvODHz
/dfEXM+CAmoxMUHYwzToqnXs6m0rlyJNoeIBZq4aXPY5+j1PzaOI23Noa8Sqc/JG
2uDaBEOPu8G7eYr5MaK7jLS9gaO35x6VOJsIuCtLISmFXERYxOe1yqMQO6iB9h/g
vbIih2/L2iPI11oNn9EgtOB6D/582S4cQYHEJPbYdXPFv7nCa9qPncv0G1rdkIZ4
IL6W12660V45iUY7bQx6Kn82kRxcuFCWJXZvXPg0gCf6YCGe+GV68ygv321uezvh
WNazqzY7zZ8CvszJ0WSxE+OHyRWGBHN15kt+C6JZBQSjpCvHc6iloPjdPy5fHJWw
0TsTY2qD+zNpkMi8/yOwXX1AQMTdGB+hq5qikfsrdlbKDhbiEVgop0gcPUhjjZFY
zvByAKx+zg2vRWcWje/b5SYWn9rY6SA3cjipjZs9O38nPJuzbo6TMZ4UqA7x/5pO
j9sGYC/6fbmUWjKrzFrcTfAhYfgzB8tiuZ/M6EgXkouDMXAPGCs=
=o1+l
-----END PGP SIGNATURE-----

--wS4zgi0GGZhmxBx2--
