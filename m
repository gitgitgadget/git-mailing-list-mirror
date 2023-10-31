Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22E111AE
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tjKtpiyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VuJAj92U"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D15BD
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:10:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 731793200A6E;
	Tue, 31 Oct 2023 04:10:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Oct 2023 04:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698739835; x=1698826235; bh=P5
	yExTg51zaJp2EhKREEs77VjTs+KVlrFhfxFyafEKQ=; b=tjKtpiyEVOcHJATPBb
	ecfdwGMHH65KVC1WOS5KT+IJDG/Sfv8E+S5X6XBsx3O2wYPfEVj+x1g+cc2/raaj
	yd8BPvZRKcCjK09JhVsYmV+Hwak59Oa+bxB+UcaZNyj+l4WXfDjii72HbIr8eC9f
	nIHajaECSQhOEO6wQdrKL17F7N6FXuBDGDRlcg1wkG1RMs4tANOjLP4XmY+GZS1w
	V24HN8P4JSoDsyaUWVd6eZ0MgbEdGWjzlXPJGn3KUKuG6DKrrdpRWHE8jturaLgp
	Laa9nd0mWLh5ucTO0Jm5GvkKuoMvFv6KsHDzU76begKLkaQqGB2wVqNU9+HS64pJ
	1+8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698739835; x=1698826235; bh=P5yExTg51zaJp
	2EhKREEs77VjTs+KVlrFhfxFyafEKQ=; b=VuJAj92UDKNg3xQZwapo5bmBE611e
	LpumIN1cOHyITwU7LrNfffnAb0jnbPnwmLQh/QDQnVwO9EIFZ+SGD4OV4Yn3Y2bP
	yCiQ7/sSXXz70lQd3iSzvFShNUk9mglgsGCH85hdKfqEWuipzi2DxEaO44qF6ox3
	j6TPKULA+BH6cs/8YFfMXegbhtJpLlBU6duC9/reJZOaufyCx6e+JLXGInHIE5PE
	mBpPwrJXCdhR3c5R8nGYUaJPZAFQ18DpcFD4qp2oS3wtwBySHT2e9HYYr21BBxXM
	aCHT7ZSJRmE/Lxhrr4wcDI89pVSgb/xgQjSnCfgEk2n/dAMGyqnG/CJvQ==
X-ME-Sender: <xms:erZAZdx_gt4Aty60IpnyWjR7dwD8Ngg7uzzGe8nw5FIqDn2E6woLwA>
    <xme:erZAZdQ0NuuLcazij-8_lfB6IEgOp7QHcLeQb5J-lvogDli30txbZL9LIqelg0YJL
    8MW919UZCV1YxNNgA>
X-ME-Received: <xmr:erZAZXVOW1zQ5NUI1MMi61Zf4Ym4OtGG3KXRzfpqKRXjIZYddTbsGp7SUK5ZiAyEwD0Raf-o59oGBpVpOqYCkUzCYA4fECGKa_gctx0cq2Fcd9Sp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:erZAZfjxHGpv1OqTowf5YrijOHzCxtVIGBbs2bhpt9G1dBjyoTRegw>
    <xmx:erZAZfCam4z0rm8pbhm_KFjjEkIPPz-M1md1YQBg9AZoWHgbUC5ASg>
    <xmx:erZAZYI0myG46TXvQ-pjNN4z5TDUFOMnQpBLOuC8hRonaYuAnMYthA>
    <xmx:e7ZAZWPoEPXG2FKdsRfRlWjOhd8wRBq46kJVTdwIsKEXNz1ClNI_HQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:10:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3287189 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:10:26 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:10:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 05/12] builtin/show-ref: refactor `--exclude-existing`
 options
Message-ID: <ZUC2ePXa4t8OElhu@tanuki>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698314128.git.ps@pks.im>
 <bed2a8a07696371e07c0b2d1282ed51c0b1b9fee.1698314128.git.ps@pks.im>
 <ZT/8GbzAmBq0aRIK@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="anGq2Qp6WJcp7o1T"
Content-Disposition: inline
In-Reply-To: <ZT/8GbzAmBq0aRIK@nand.local>


--anGq2Qp6WJcp7o1T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:55:21PM -0400, Taylor Blau wrote:
> On Thu, Oct 26, 2023 at 11:56:37AM +0200, Patrick Steinhardt wrote:
> > @@ -95,6 +94,11 @@ static int add_existing(const char *refname,
> >  	return 0;
> >  }
> >
> > +struct exclude_existing_options {
> > +	int enabled;
> > +	const char *pattern;
> > +};
> > +
>=20
> Thinking on my earlier suggestion more, I wondered if using the
> OPT_SUBCOMMAND() function might make things easier to organize and
> eliminate the need for things like .enabled or having to define structs
> for each of the sub-commands.
>=20
> But I don't think that this is (easily) possible to do, since
> `--exclude-existing` is behind a command-line option, not a separate
> mode (e.g. "commit-graph verify", not "commit-graph --verify"). So I
> think you *could* make it work with some combination of OPT_SUBCOMMAND
> and callbacks to set the function pointer yourself when given the
> `--exclude-existing` option. But I think that's sufficiently gross as to
> not be worth it.

Yeah, agreed. Honestly, while working on this series I had the dream of
just discarding git-show-ref(1) in favor of a new command with proper
subcommands as we tend to use them nowadays:

    - `git references list <patterns>...` replaces `git show-ref
      <pattern>`.

    - `git references filter <pattern>` replaces `git show-ref
      --exclude-existing` and filters references from stdin.

    - `git references exists <ref>` checks whether a reference exists or
      not and replaces `git show-ref --exists`.

This would make for a much more enjoyable UX. It'd also be a more
natural home for potential future additions:

    - `git references show <ref>` allows you to show the contents of the
      reference without resolving it, regardless of whether it's a
      direct or a symbolic reference.

    - `git references count <patterns>...` allows you to count refs
      patching the pattern.

I shied away though because it would be a much more controversial topic
that would potentially result in lots of bikeshedding. Now if everyone
was enthusiastic about this idea I'd still be happy to do it, even
though it derails the topic even further from its original intent to
just fix a bunch of tests. But unless that happens, I'll continue to
stick with the mediocre UI we have in git-show-ref(1).

Patrick

--anGq2Qp6WJcp7o1T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAtncACgkQVbJhu7ck
PpQOHg//SnsrGg2370syE8WFv1s9ES7VTzuEizXopEERIVBhVnNMu4xomAnNR9ui
QkBvXcxLLVWhTxrD57Olaemv0nmMlScUSw6uY6CKqf1D+rmlH2dCxgQR3S/OS5NX
hPZ6PLPhn/pRsrEGwSjb3LqhDlX2gE94kqnJ0XhBu3Qy3PJyHA7sBPhNoF1Ic8lO
6Fk5JSTKp9LnihfLkOGlLzLzaIYqWsYAWOCmBAyq+7nKUlh51mDtLZE1UQq8aqaK
1KuYeEt25fCHxABogI5Ww9B3M2139q+srxu4ZH6G4IjIPT4E5bt/GDOBgWsxvPTl
/ztB2ihSFPeCzaRjRV8PFeMLTmzJeYJZ0iYCJLK89N9a2irTAzIQx/NX0zWzG64u
ktItmDGBedoMNeSRbWCc9K4p464rNcG3WJ1N+1Z6FUGm8pAHWYeQ7dHOEzjapktc
VB0vM10WN2b0GqMPujm3cfkAGdyzNS5NqsUx7PWrlsfRMLZRshD1TWxaqXq3o7g7
aAWWLMr1a17YEXlj3gWl0q4zdpFyYbs0S8KfeZuKmjTCYkbaHXogQkT7BWbbcsrR
4caPaiTP2fMz0VME9iFNnvB71YBB/JVUg06RUBi0E5rneNcRFcvse1E/0SbxkkxL
yMYu9h/H2aFqgZog6m7+mjJdyt6hDiL2smRZ2rjnWgXZ8fY2KyY=
=+OVA
-----END PGP SIGNATURE-----

--anGq2Qp6WJcp7o1T--
