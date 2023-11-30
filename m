Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IpM4Z58c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQBz+Thy"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0710DE
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:18:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A07FD5C0182;
	Thu, 30 Nov 2023 05:18:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 30 Nov 2023 05:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339514; x=1701425914; bh=Tm
	IaWUrtAuEs+Vxo5YA7zh8I5FeZ+RI9W0DvuR8HZxY=; b=IpM4Z58clwRT1WrvfM
	ge8Ma885E+u23rPOPIVVL9ZeaEaRVewZwWa6rALv/qsUmPU9FKxEDigsjw+gVV9R
	YEu1QpPsP4IaufWdRF/cMu3RCghWo+F5IdW3/JTOKH5YjNlDXqOm9RPtj1obZgET
	g2Ce5kYj+nW0VfAU2D7us4FW/6kXRNL6DaPqvyT00DvQmrKrpEHwkxbjKFdGdWSx
	auZTQduaqDdvTC/41ib9EaNfu/AV3A1Y8ny/5nwdFS2cPuDtFvamp0cG072or0eT
	fWhuFhs7v12p3U/rNVIy0C0jptSgrOfhacX2KCOEpVRbFQCCxkoaUwm3cveA+99p
	AyyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339514; x=1701425914; bh=TmIaWUrtAuEs+
	Vxo5YA7zh8I5FeZ+RI9W0DvuR8HZxY=; b=XQBz+ThyEwbh7KLF5JD7EjOYENuEE
	x/GnYu0gYPijktVOrhhpoPnIE/GgVuLKmujGTFbqP3q3TqIcrjLNKJnrBu188Wk9
	XwxJnBldoF9y775lwfTF+a/uxAMMHSKhQWqRRg2h6UQkFFEG4MNWmvSGn0NxfZ+a
	Z6nwvj7Cm7oUMs/P1Q5P6y7odGcXurIJSpZuMI2LvbPYzYMJsONkbM2FTdBsiqF8
	ZF5o+VlPAz+gIQH9l9FkJU2nVVa0HrWaNNyjn1sE17YS5m0HIwi994lGLac/wDGf
	pCtQ2XcA9g6Jc9LGUQN7b003DEWoaKhnriDXBZViHvspIQIDJQTQsQH1w==
X-ME-Sender: <xms:emFoZZSBFdc5r-JFToFKGEKzoNgoSu9ZS7D8ZOyN3BpYzMqC57ho_g>
    <xme:emFoZSxA-fqR_FHzP-BJHTpCBUJXwvkkXr3_UQx-1DZNMw_9500NLLRMD-G_Qdwu0
    TodQyHyTmSWKOrrBg>
X-ME-Received: <xmr:emFoZe0yuBOq6VzYgFl-sy45uaEk-_nzB6hmbZLzpNxiHoLW9J8LPqOm1BhqbJnYNnrk5ByowKXua2Z-iwCX8akwM9BQ5z9tEaoUcdjtAbUESS4z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:emFoZRAJjqD5SSKZTbq5r6gdY8PAe8z5rpCNMUUDumx_YhLnflHBdg>
    <xmx:emFoZSgAom_32AfZjMTUHaXXAxWx0sOP_3pvtAm8U7bZdLB3Rnk7iA>
    <xmx:emFoZVqd5Gkez7V7b-xYtEvDSj3g2aLBpS9a-7rrBlgYJEH6bnHQVw>
    <xmx:emFoZVvqjZzQu88wvJJ3-LjYrfUY1UjFjuWlaMDhw21Ctl_ErNUCKA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0514f71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:20 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/24] pack-bitmap-write: deep-clear the `bb_commit` slab
Message-ID: <ZWhhd5gLzYwPEgBl@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dLgkFC9jtg48E2zL"
Content-Disposition: inline
In-Reply-To: <6f5ff96998946f3f49da56fd05c096b949521339.1701198172.git.me@ttaylorr.com>


--dLgkFC9jtg48E2zL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:07:59PM -0500, Taylor Blau wrote:
> The `bb_commit` commit slab is used by the pack-bitmap-write machinery
> to track various pieces of bookkeeping used to generate reachability
> bitmaps.
>=20
> Even though we clear the slab when freeing the bitmap_builder struct
> (with `bitmap_builder_clear()`), there are still pointers which point to
> locations in memory that have not yet been freed, resulting in a leak.
>=20
> Plug the leak by introducing a suitable `free_fn` for the `struct
> bb_commit` type, and make sure it is called on each member of the slab
> via the `deep_clear_bb_data()` function.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap-write.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index f4ecdf8b0e..dd3a415b9d 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -198,6 +198,13 @@ struct bb_commit {
>  	unsigned idx; /* within selected array */
>  };
> =20
> +static void clear_bb_commit(struct bb_commit *commit)
> +{
> +	free(commit->reverse_edges);

I'd have expected to see `free_commit_list()` here instead of a simple
free. Is there any reason why we don't use it?

Patrick

> +	bitmap_free(commit->commit_mask);
> +	bitmap_free(commit->bitmap);
> +}
> +
>  define_commit_slab(bb_data, struct bb_commit);
> =20
>  struct bitmap_builder {
> @@ -339,7 +346,7 @@ static void bitmap_builder_init(struct bitmap_builder=
 *bb,
> =20
>  static void bitmap_builder_clear(struct bitmap_builder *bb)
>  {
> -	clear_bb_data(&bb->data);
> +	deep_clear_bb_data(&bb->data, clear_bb_commit);
>  	free(bb->commits);
>  	bb->commits_nr =3D bb->commits_alloc =3D 0;
>  }
> --=20
> 2.43.0.24.g980b318f98
>=20

--dLgkFC9jtg48E2zL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYXYACgkQVbJhu7ck
PpRfFA/7B4zV/OpO7evHRDZ21GWvGEy40j6Ae6CCLdj4FJmoPpn7dTNKNyRp6C17
se/zauV71zlWpEunzOeA/kLemXqnElcAxidISH6lNRIL6frDOJABq4ed5cItW80s
KvciY//efuZaoGeQFO1vSUhmKsIfuMIWYvKr39V5BwClhcyG6f+uMssFg0ov3bWU
NbQIJWfVibMLHj2HxGTH0CLNC278q4xnn8EsrK5jhVHXgMbXWq9HyrCSakNKMvfz
ldSSJYq5HdlovEA2BYqSzCpXaasSKhfLG4ELFIFE2P4+RqzmCDNYgmTi3D4TVawo
2FYMGgZDz2UC6UEtwCcQ+srBMQ9TMFnPcnVpGooA4WfIa1au/y6R6ZyPzqamouAu
Md6a8SH1JwnrAbX3ccrzytnDQaAunQGzTUKY7rTOHzy5s9Sp/onw9ONQ0fcbnt/H
Lw8SFOXhHx/I2QKvebXTCT01/sb1da2QupHpiALEX5I3U+bsqYjtoi7s/PmKt6CR
kNMrs0Mk6km2jDN0cALABHqzUs/4P5X3ixwoylc1p7d/MYqKo6Y7hQlvGU1JyfI5
3wcPVLubVFfqIhjtY6mKNGJGyyS4ogXrNZpBCi0CxuDZQ2P16jL2yimxgFO1Zisg
TH1aDjR0sBjq/cxj174Re74ui1ykFYlHpK5NSykbLAQ8p2GA94c=
=Z/9P
-----END PGP SIGNATURE-----

--dLgkFC9jtg48E2zL--
