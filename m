Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4D18E0E
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SHQHysFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBk3XKv4"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 689CC3200A7A;
	Tue, 19 Dec 2023 07:25:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 19 Dec 2023 07:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702988736; x=1703075136; bh=A4jMJKGxcL
	+hgFubRI6rbx0lvjy7Jy6PHjI3v2DSCQ8=; b=SHQHysFVDdV82O2/H5AqXfcRQT
	QoEyAYHBmnfYV18VnqZ6KEXM/okmYWx0i6uX4gF8QGc7mlzuusxm1l5E90T71cXA
	/ouOikHx151TwFLHtwJlgoxv8WfHxoPGQEis1XSZfy0duVcItocDli3hYmxW0xnt
	TpN3QRctOKobepftJtSxbduzkQPfVENdEkxP73fJku3TNmJegh7Jw272IlRyDGek
	wiYAqqniHGtvs+v8YXcNb+6O42XC7MQvawuqHeKF9QKPELgco0pIIAx9eqb46fB9
	Eoefh7S9XoHP6Cn3R7tlwCanhkyojst8IPQLGPUapBLlwTm+QS31UT4wWQAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702988736; x=1703075136; bh=A4jMJKGxcL+hgFubRI6rbx0lvjy7
	Jy6PHjI3v2DSCQ8=; b=lBk3XKv4mW/nCx0Ues/Gr2L+hXLKHzlhQKSBYLdYD61M
	9dDaPFL8Y0zCL8RaOWzIgR4RKoaPKAwGaQPp39/ERVBTUDmvOsil69DCj3bY0VPY
	8T9Ahax50XaSI+nMK5SAcT2jeb25sjKCTpDVraoMfONQLNamAUchWKtm71xgUqcK
	xAJk7jMy898//o9qptOhwktpuXSnlbD5kRfta8mur7sHDKqMmxWx6n2xRD5CyI0r
	GAZilSMxEu92xntqUb2PytbL5iSD0g9zucpDXYTAqtiCfvshEtJW64OdgvyfVujt
	ehZ1VSBNUAo5rPu/3g14twjPbv+oKBcbVhORSFLjJw==
X-ME-Sender: <xms:wIuBZctLxTaieJy5N6cmOffSWEDMxJTYMNOqhM5OY2KOAPMbn2bBzg>
    <xme:wIuBZZfDM8U3g8xLVVvunCPKtn9Gamf87pU02DdIgSVRRJmb8UaLWyKWb3_IacLqo
    gjfkjMU2Dd1bqnR5Q>
X-ME-Received: <xmr:wIuBZXxJWLFUkG9KAKiRTD2LETejrN_RlGU6YxVW0Q9QJ82a6pye8cni0TWmZRbJWEaomEBA-rVMLSfDjnqDCaamDmgCMQH7xU1eC0Y4J5flOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wIuBZfMd0F9RTOhOd0oOwuUxxwU5b-i_fQEXK3VxcJNpqvTGWQTHew>
    <xmx:wIuBZc_WzFhNRLb3CS3KfT0NmmGfVnapWD4T63J_QPscRgSigGlGAg>
    <xmx:wIuBZXUM8OHLxdjN1gytiHuDZDm46MrSDWIqEo-6uM6NTEgYVq5Upg>
    <xmx:wIuBZRGaPn08pybbfznycsMjA2vT-QLjPPP82gutMI637SKrA4B_Uw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 07:25:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b92d9ead (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Dec 2023 12:23:41 +0000 (UTC)
Date: Tue, 19 Dec 2023 13:25:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: use strvec_pushf() for format-patch revisions
Message-ID: <ZYGLvKYQe6DhP3Uf@tanuki>
References: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7Apu/Io8BVPb4N1"
Content-Disposition: inline
In-Reply-To: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>


--r7Apu/Io8BVPb4N1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 08:42:18AM +0100, Ren=E9 Scharfe wrote:
> In run_am(), a strbuf is used to create a revision argument that is then
> added to the argument list for git format-patch using strvec_push().
> Use strvec_pushf() to add it directly instead, simplifying the code.
>=20
> Signed-off-by: Ren=E9 Scharfe <l.s.r@web.de>

Thanks, this simplification looks good to me!

Patrick

> ---
> Formatted with --inter-hunk-context=3D14 for easier review.
>=20
>  builtin/rebase.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>=20
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 9f8192e0a5..ddde4cbb87 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -582,7 +582,6 @@ static int run_am(struct rebase_options *opts)
>  {
>  	struct child_process am =3D CHILD_PROCESS_INIT;
>  	struct child_process format_patch =3D CHILD_PROCESS_INIT;
> -	struct strbuf revisions =3D STRBUF_INIT;
>  	int status;
>  	char *rebased_patches;
>=20
> @@ -615,34 +614,32 @@ static int run_am(struct rebase_options *opts)
>  		return run_command(&am);
>  	}
>=20
> -	strbuf_addf(&revisions, "%s...%s",
> -		    oid_to_hex(opts->root ?
> -			       /* this is now equivalent to !opts->upstream */
> -			       &opts->onto->object.oid :
> -			       &opts->upstream->object.oid),
> -		    oid_to_hex(&opts->orig_head->object.oid));
> -
>  	rebased_patches =3D xstrdup(git_path("rebased-patches"));
>  	format_patch.out =3D open(rebased_patches,
>  				O_WRONLY | O_CREAT | O_TRUNC, 0666);
>  	if (format_patch.out < 0) {
>  		status =3D error_errno(_("could not open '%s' for writing"),
>  				     rebased_patches);
>  		free(rebased_patches);
>  		strvec_clear(&am.args);
>  		return status;
>  	}
>=20
>  	format_patch.git_cmd =3D 1;
>  	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>  		     "--full-index", "--cherry-pick", "--right-only",
>  		     "--default-prefix", "--no-renames",
>  		     "--no-cover-letter", "--pretty=3Dmboxrd", "--topo-order",
>  		     "--no-base", NULL);
>  	if (opts->git_format_patch_opt.len)
>  		strvec_split(&format_patch.args,
>  			     opts->git_format_patch_opt.buf);
> -	strvec_push(&format_patch.args, revisions.buf);
> +	strvec_pushf(&format_patch.args, "%s...%s",
> +		     oid_to_hex(opts->root ?
> +				/* this is now equivalent to !opts->upstream */
> +				&opts->onto->object.oid :
> +				&opts->upstream->object.oid),
> +		     oid_to_hex(&opts->orig_head->object.oid));
>  	if (opts->restrict_revision)
>  		strvec_pushf(&format_patch.args, "^%s",
>  			     oid_to_hex(&opts->restrict_revision->object.oid));
> @@ -665,10 +662,8 @@ static int run_am(struct rebase_options *opts)
>  			"As a result, git cannot rebase them."),
>  		      opts->revisions);
>=20
> -		strbuf_release(&revisions);
>  		return status;
>  	}
> -	strbuf_release(&revisions);
>=20
>  	am.in =3D open(rebased_patches, O_RDONLY);
>  	if (am.in < 0) {
> --
> 2.43.0
>=20

--r7Apu/Io8BVPb4N1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWBi7sACgkQVbJhu7ck
PpQDEBAAms2qh5kA4uYR0On3O39J2M2pk8TzCB9D5AechoWQERtVT2Sgw9QBiP5g
MkTGqYhLNkP07fQuyIK806V+42Z/c6Ep+I44nqajP2XFW5rfJ0gFlMkRqJSI9qLE
MpyRYeXKylzVdwG2ooftlokpyv9jKxnGvMhO9KlJJGN6+8WnJxfLIIwCZoFaKci8
uVMQx051UtDcQZUEftKKWqUrN4AY1mOksIhmlr7F+rXspLWGsEGhkd0jHeFM/xSB
/nfw0y5mBvq/HJvaC7L0OUbCiElUJkHJi68brAQlvYP/gzm27S16Xy2/ReI0mOXD
KAXqMiEp04ngmzf/w/Yor5k6NjhB10qMTpjbxK/lhC4AiDlrIGiWgd3SY7gGgtwI
/FBjolNCkKygYwxtthF0PNO18lbZd8sp9hYKV5lx/yZuSzHTO+NA9RngLo3Aiv4D
pYY04qVc8ZZSYycRT5Y1udmXEobhqDsDW3VdMkUx65Wn57ukFWts1XadJkGUSTU1
Bloy+1q+lDM5lzaRxiR6hC2sbswr98EtAc+xavZlrLvdDgFtFFLXMiSBeSChCisr
TRQNGCRKlpdimXiHBR5tKTUVoORzCvJ3PsHZYHCvR8E7P/0TxxmBgTrWjXr5pCnt
7YRHBkpwkBhZeli6kKBsaR4GPVDS4TsQ0oRxjonUpojbPWVi96k=
=nZ5D
-----END PGP SIGNATURE-----

--r7Apu/Io8BVPb4N1--
