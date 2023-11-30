Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XxA/xPwm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDZVEDIN"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AEE10D0
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:18:30 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7248A5C02B8;
	Thu, 30 Nov 2023 05:18:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 05:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339509; x=1701425909; bh=Hm
	s1UPr8zjINwk6Kg9556Nn25x/G9VL3SURuq8HFfhM=; b=XxA/xPwm2fboaG0Luj
	Grz1MjCU1k5H2s/wbt6YOIzsOCCvBXE/2w+5TXO3sBLME91pFd9IhCRSKb2lQnUV
	SlZt3LA/2g81oZaZ2b28uNGTZVtL2G7C0RFqAp1L1bkJrh11E8bA2GWduFulsVFp
	gKPt+Sfjp2Z94up1VoAZML78F2lY8NyNhfrdvj+fiiDDle6s5OuvmmvRUx3aJ9oR
	fgAJ+E8U7eGle/Qwl9C0jQiMleDSSj2T2fcJTqMbTk56I41+Ha3qEy4/DUyYpe90
	sJI3r1iL6jKXlvA3SCvB1GIYAqtZ/MQx4ZR57bUi5ZEDOSnxnKcsmKZU5BUKVWfx
	g+/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339509; x=1701425909; bh=Hms1UPr8zjINw
	k6Kg9556Nn25x/G9VL3SURuq8HFfhM=; b=rDZVEDINNRRkLH7Hmuhyvglhpad6G
	VI0RMF54P0ZqN/abILecrVrdALkZ6D6yF+f8fMz/+yinwro0gLhxXyrm3B2ap3yB
	Px1k7CixkaXMSf763ZSdqnW7VvwRPim11AJECdk1JwmuwcRFHkFi39+ZhiST6flC
	Ilvbpbp57Oo16LAsjbx9LcmtkV0+Oo3ixP5N/aiEmtLj0IZ2Rl0k1774w3QFQYxE
	p/ufBwZv3NE3T7zOMjGnYsnLACXtIkFdJBt9ESalH7I2qEUvzKAlRfAAcc+cvhzx
	x8jMYejhWFOwL1zqYbhkEAHixj0Zz8QJ233wi9FdFEBQgbYAglHWjZQqQ==
X-ME-Sender: <xms:dWFoZcYV8lI_sp8Owurvm0nX1V_CYPvsgGk1mD1MHU10OxJR-Fpp1w>
    <xme:dWFoZXZFId8ojf4Jzlf_GhBWRqtwGo0eEyOS870s7auInbrL1iSSC_cmKbAkwt_1m
    fUAsXSVfOStp-ylDA>
X-ME-Received: <xmr:dWFoZW_vujlxe3DHnIbZoWm9WHMKLj2iujf-9HEjumkGZSy3F-JQE92sa_gIs4aSFZeQWOrxw4AwH15U2WZ407XJEQ4Zs49a4r-GXzsVNKtIF5Ua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dWFoZWoY7cjjqbc2CPAxSkp4aH1-QvVlhn5qxvXoKiHBZT7zv2HbGw>
    <xmx:dWFoZXpl3jqsl3YnS2M_MYddIDK91BNYxtsVe918oQbCXePlpX_CRg>
    <xmx:dWFoZURtO7mhaS9ZmuRLFc7J_dqAUTTOTsh0i7JmmIEIfM6jOtRZ9Q>
    <xmx:dWFoZe3nHuULJjX12NvWZgN3wjMXY8369uuyTWpc2GQoTuzaUbGNtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98356135 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:15 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/24] pack-objects: free packing_data in more places
Message-ID: <ZWhhcv25B5nUNoyu@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
 <101d6a2841a909aa9c99225ebf1b65695cf116cb.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hmb4dw4RNHDjXxCF"
Content-Disposition: inline
In-Reply-To: <101d6a2841a909aa9c99225ebf1b65695cf116cb.1701198172.git.me@ttaylorr.com>


--Hmb4dw4RNHDjXxCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:07:57PM -0500, Taylor Blau wrote:
> The pack-objects internals use a packing_data struct to track what
> objects are part of the pack(s) being formed.
>=20
> Since these structures contain allocated fields, failing to
> appropriately free() them results in a leak. Plug that leak by
> introducing a free_packing_data() function, and call it in the
> appropriate spots.
>=20
> This is a fairly straightforward leak to plug, since none of the callers
> expect to read any values or have any references to parts of the address
> space being freed.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c |  1 +
>  midx.c                 |  5 +++++
>  pack-objects.c         | 15 +++++++++++++++
>  pack-objects.h         |  1 +
>  4 files changed, 22 insertions(+)
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 89a8b5a976..bfa60359d4 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4522,6 +4522,7 @@ int cmd_pack_objects(int argc, const char **argv, c=
onst char *prefix)
>  			   reuse_packfile_objects);
> =20
>  cleanup:
> +	free_packing_data(&to_pack);
>  	list_objects_filter_release(&filter_options);
>  	strvec_clear(&rp);
> =20
> diff --git a/midx.c b/midx.c
> index 2f3863c936..3b727dc633 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1592,8 +1592,13 @@ static int write_midx_internal(const char *object_=
dir,
>  				      flags) < 0) {
>  			error(_("could not write multi-pack bitmap"));
>  			result =3D 1;
> +			free_packing_data(&pdata);
> +			free(commits);
>  			goto cleanup;
>  		}
> +
> +		free_packing_data(&pdata);
> +		free(commits);
>  	}
>  	/*
>  	 * NOTE: Do not use ctx.entries beyond this point, since it might
> diff --git a/pack-objects.c b/pack-objects.c
> index f403ca6986..1c7bedcc94 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -151,6 +151,21 @@ void prepare_packing_data(struct repository *r, stru=
ct packing_data *pdata)
>  	init_recursive_mutex(&pdata->odb_lock);
>  }
> =20
> +void free_packing_data(struct packing_data *pdata)

Nit: shouldn't this rather be called `clear_packing_data`? `free` to me
indicates that the data structure itself will be free'd, as well, which
is not the case.

Patrick

> +{
> +	if (!pdata)
> +		return;
> +
> +	free(pdata->cruft_mtime);
> +	free(pdata->in_pack);
> +	free(pdata->in_pack_by_idx);
> +	free(pdata->in_pack_pos);
> +	free(pdata->index);
> +	free(pdata->layer);
> +	free(pdata->objects);
> +	free(pdata->tree_depth);
> +}
> +
>  struct object_entry *packlist_alloc(struct packing_data *pdata,
>  				    const struct object_id *oid)
>  {
> diff --git a/pack-objects.h b/pack-objects.h
> index 0d78db40cb..336217e8cd 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -169,6 +169,7 @@ struct packing_data {
>  };
> =20
>  void prepare_packing_data(struct repository *r, struct packing_data *pda=
ta);
> +void free_packing_data(struct packing_data *pdata);
> =20
>  /* Protect access to object database */
>  static inline void packing_data_lock(struct packing_data *pdata)
> --=20
> 2.43.0.24.g980b318f98
>=20

--Hmb4dw4RNHDjXxCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYXEACgkQVbJhu7ck
PpRRMw/+Nc36M2hRsjQZcD/cb8tNgKJ935xqM0u/f+HVGSWmvjUsCnYamgBp62bK
Xq0YQ6I856mB3fP4wNweZZvvQiXjUgV4b34BKYhfMJ8S8gSUlPtKDJ2rf7EC08yH
giP7DV98npthCCwSfE1YbeFvnK48XOxFlUCpc5AarZ87VWNaBhcML0FEJJpq/3fK
jUcGpdeQCFM208YuiFvcvixOn/t0L364sJxc2p2kDnt+csGe67Bmzn7eNp4i7x7+
UMho14wDraFdUPPfyoiQ8OKv2K4gDAyCrqtjYTcHNA+uWs0Sm/+ZJQOL115jjn7T
TkHbm5oa+VDchCyykOMuH7UPg6BUKH7OEr7vh940BtDZnxJkfIaSI3I4AuROo4Ok
11ekQm9KLK9+oaE8+SKFPbC63CQilMvocc4NoAIGT3xjAoOVf/Rw75t+p8Nw5OYT
DRmBFmOmgefYjBd/7MWNfx2p0R7kvJrCi5yOYT4bZ+5/ZWn2ONIlTY8axtjsB2pT
gFpewmLZIaknxnBKMPd2wKxNY4kizJi20vAwm/25ZmcGryjSo47Vd27MR34QW9MZ
vjfLLywNVuCe6lDVZ7RsuHc295bz1k7Gsu9jICtfIPKU1YOat0DRGFse8oq8u+aZ
S0OL9UbNBBJixfgY2IkFBJsa/s8wkpxUD5S7HKxlyvL4jPkKFZo=
=2oe/
-----END PGP SIGNATURE-----

--Hmb4dw4RNHDjXxCF--
