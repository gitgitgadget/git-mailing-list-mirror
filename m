Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JB2DebSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mO405Cdy"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72DD54
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 05:13:17 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id AE2465C01A6;
	Thu,  7 Dec 2023 08:13:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 08:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701954796; x=1702041196; bh=Te
	cFvTPi8fozhs6s29RlCr6ORFfhASKfTjydh3MV6rA=; b=JB2DebSzSyEGDT0tgs
	KLVFruews7C7Y1gCQuDBN8bFAprgkm2NJSIIoJ6v6WKIsXSVRD3K39CRNHHIa3hw
	5+7c+mBN2yD+s5Euxcx3sdOZN1as5WYFCHRov5Ew16v7gRQB6oT4LCCikJgQ85Pb
	bi9lYUvkzGmrcXL5UYYovGtmLF1G49tKJlgpo7ftqbWHf1hAAzrjUGV7ksUZv/WM
	ow2oZHZwNPYYe3dw527yO7v5zsI41o6ap8vF101MW1XxM0nv8S2Kwt3YYdCGCbyG
	1yyH3XblD5DAOH8TTD/egGx9NOzeyNel2kLEkvWZrltdCsOjhXZW6kJbrJTSP5Ax
	p+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701954796; x=1702041196; bh=TecFvTPi8fozh
	s6s29RlCr6ORFfhASKfTjydh3MV6rA=; b=mO405CdyHqONj1dFj5k73dhuoHL58
	wJrIrBLYZLwV06G+bajU7fpB/9FAZTPdzij6mItA/+R/I7KNJ3t3ZcKqx+IBgo+L
	roqDSKqrU0+QiUSP1I5U7o6zpcNHsOZudAQM5+BjWwdk5UN7sS5uyOITpUK++/nk
	ttO0ACigQ+U30+bobDvU2o/KvQCQD7DG+LibhmZJ9kG1ustFYowfC9uqROdMp7Mo
	crMSjIRFiZCjE08oAxmI4EKPwhUc5CVXDN7zyZbiean07b4nH+JnFCaRRpHeDZu+
	xZu6T22d72lnOvb4NZjQZcbC2bzowI6Fi0Is777oUQ74W3FoSpWgK6RXw==
X-ME-Sender: <xms:7MRxZfNaxGqV5_PZ5XO0aYDy7vrENIxP3RRUfJPoJSZxKEA-djg1oQ>
    <xme:7MRxZZ8nS7kY5WKbvYABaB-zIy7kzyAv6UJQ1WDWpZ9L-l6L7CGlfRQD052XjVMJU
    7t51gFuh3oQj_Jblw>
X-ME-Received: <xmr:7MRxZeQQjcov2_lks2hOArCQV3agITIBT72bBTmrOv1cDlfAGk7hO_4CR2T4NMnbADPyzTzgI2RCl6QsQMHOPU2yefvwkvoeV_WTy4XwKlh-lkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:7MRxZTt1UIpZa9Hj0ttXQ8rY7tHnYsfg8gNsyiGmLS4QimVzDhgdLA>
    <xmx:7MRxZXewPKaar9G3tSBeAQlnW9wWe1iIVycNJ8CjvHnRj0f6OT-kSg>
    <xmx:7MRxZf2o_K6fCnToKJwp5IJFpGyXUhc5riPWiZalk1Op5zQqaEXKkQ>
    <xmx:7MRxZYq1akbJOSQh0K_UJnGF3SCIhPYod33uHc7IsOXLw9qRHCvw4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 08:13:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea1092b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 13:11:47 +0000 (UTC)
Date: Thu, 7 Dec 2023 14:13:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/24] pack-bitmap: pass `bitmapped_pack` struct to
 pack-reuse functions
Message-ID: <ZXHE6Ym3CICtNxFd@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <970bd9eaeae038adb6e7d4c399c9b033668a8864.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H0w6TjIoPk4Wa1/J"
Content-Disposition: inline
In-Reply-To: <970bd9eaeae038adb6e7d4c399c9b033668a8864.1701198172.git.me@ttaylorr.com>


--H0w6TjIoPk4Wa1/J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:08:21PM -0500, Taylor Blau wrote:
[snip]
> @@ -2002,6 +1986,65 @@ int reuse_partial_packfile_from_bitmap(struct bitm=
ap_index *bitmap_git,
> =20
>  done:
>  	unuse_pack(&w_curs);
> +}
> +
> +int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
> +				       struct packed_git **packfile_out,
> +				       uint32_t *entries,
> +				       struct bitmap **reuse_out)
> +{
> +	struct repository *r =3D the_repository;
> +	struct bitmapped_pack *packs =3D NULL;
> +	struct bitmap *result =3D bitmap_git->result;
> +	struct bitmap *reuse;
> +	size_t i;
> +	size_t packs_nr =3D 0, packs_alloc =3D 0;
> +	size_t word_alloc;
> +	uint32_t objects_nr =3D 0;
> +
> +	assert(result);
> +
> +	load_reverse_index(r, bitmap_git);
> +
> +	if (bitmap_is_midx(bitmap_git)) {
> +		for (i =3D 0; i < bitmap_git->midx->num_packs; i++) {
> +			struct bitmapped_pack pack;
> +			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
> +				warning(_("unable to load pack: '%s', disabling pack-reuse"),
> +					bitmap_git->midx->pack_names[i]);
> +				free(packs);
> +				return -1;
> +			}
> +			if (!pack.bitmap_nr)
> +				continue; /* no objects from this pack */
> +			if (pack.bitmap_pos)
> +				continue; /* not preferred pack */
> +
> +			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> +			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
> +
> +			objects_nr +=3D pack.p->num_objects;
> +		}
> +	} else {
> +		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> +
> +		packs[packs_nr].p =3D bitmap_git->pack;
> +		packs[packs_nr].bitmap_pos =3D 0;
> +		packs[packs_nr].bitmap_nr =3D bitmap_git->pack->num_objects;
> +		packs[packs_nr].disjoint =3D 1;
> +
> +		objects_nr =3D packs[packs_nr++].p->num_objects;
> +	}
> +
> +	word_alloc =3D objects_nr / BITS_IN_EWORD;
> +	if (objects_nr % BITS_IN_EWORD)
> +		word_alloc++;
> +	reuse =3D bitmap_word_alloc(word_alloc);
> +
> +	if (packs_nr !=3D 1)
> +		BUG("pack reuse not yet implemented for multiple packs");

Can't it happen that we have no pack here? In the MIDX-case we skip all
packs that either do not have a bitmap or are not preferred. So does it
mean that in reverse, every preferred packfile must have a a bitmap? I'd
think that to not be true in case bitmaps are turned off.

Patrick

--H0w6TjIoPk4Wa1/J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxxOgACgkQVbJhu7ck
PpQCHg//ZvHj1UJEHfdgIRkjSC/10ED8vljEwFpc2r/rnn95pEJ3n5Q7z01R4+1Q
dZ9gkHCaPA/OIFEu8zRT01LHSX7VWpLtNt8M6jwLDFOLsZs9q/NM3jePyYSqxoV3
so6xUdhHWcmAPaRhjgdk0VXBAguVVwv7a3hEamNhtkSXOPTbhoBtSR+hfELjXc8M
qwXzQ1My2+Nl/dClqYCgKyFt7JpUXIS2GyhMBHD5MQxXpCyszhCMKcQD1TfIKVwg
ZbpssynahHHxy3cJxJLeaRbC56Swk8lwdioF1JzmhFwIh41+gyC7lUn/YpIaQBUx
xds4rxu4tP4QkmPHoBtJ1Yi8Bpv6L5Y0CaCMliJHsE354km6HTobl7W8Pctv0nKl
TzmxpHG5OF4WcZqTb/uDexRg3r1w5Amr1QXui5lv07//SfmRvab8pEBm5Awc3oF/
ZioP/CJhOxPTXiDG7X+h+J1J3IRzC1nA4smQpBpN4mPWk0VG+dOuQJOCFGcETXAZ
InBzaunUm3uYkvKZZMtku6+/5i8f0zxlF34vKxxpj4gQ5cMz9oiHl6xYVQ7Wq3TR
pPdYGow5hpJz3QWdVHbmxgSkgJZjH6YcV0Q3xBEptSObiDZeKGGq/BRQZ83cRSOm
6RLUsqtoea8YUWzlP/e9gl4qPF4v7gr0RIWdNxGRjA3EfXD88ek=
=PlFW
-----END PGP SIGNATURE-----

--H0w6TjIoPk4Wa1/J--
