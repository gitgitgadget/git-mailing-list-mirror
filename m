Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126ECA6C
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XcixHhNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbU9Uwd9"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1943210DA
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 23:05:55 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4E4DE3200937;
	Wed,  8 Nov 2023 02:05:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Nov 2023 02:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1699427151; x=1699513551; bh=sx
	aIoMlBBwZlPMRGToJqsAuW5MGrddfRKJq/qgSvwWw=; b=XcixHhNsOoPG46459K
	914ZoLK9wtUUZp8cm9Pc0NDDkudTZbH4gdcZkXY4ePhjDfJoYjjPWZffGEIm2xjn
	/kAwBw3n+4JrvWJfoD/FpxDqHh1e5bA9Rrd+pBh44t2nisiyv6QjoCOnr5vZrXK4
	5rDQB7YVkMf/aOsaO2j4shNctzosKWAFRJ+kW8zayusiVBWvT7EbUT8ACduhCgWN
	62OPtzRvGNZ+YsOy0NCpk75qQSN+mJBSx74wr9Owwg+wjsqVmIFcZUtZckAienWV
	twh2OkNml0YyT7tplx1IgkUwp8uoD6HQcW+J1/LRzvg6SmEu2XCF5e4fiB0tkWLI
	3xMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699427151; x=1699513551; bh=sxaIoMlBBwZlP
	MRGToJqsAuW5MGrddfRKJq/qgSvwWw=; b=pbU9Uwd9DvZSnxNuFwlStXnreE5TO
	6Oiug32lAU9fksw+Fdgj4D/jY71yFC11iJxA+P8qJyXBKZe/XIr8JNnt7fQJYkYJ
	sD4/vFMj/vVgIYiLaFG/yfecbXjlOWHXbJwbbRkLtFpVa6dqw18VTjTyNwsTPY2H
	qJOosVWcY0c9eHp6CLjc8+AMzGr6Oz5farJXceMGZAnsa7oF3NU9R3/reo848tvJ
	WseVVowU9khNa+EvkKjNAPwDsuBoHjo26QWBMxK8xZXS/19WRY8voHJmNSSxdf1r
	qoc1PPKEAqdHVbMS6YU9T8xad66whRhp2XQuJx6LHx2iQumZwbcnlZYsw==
X-ME-Sender: <xms:TzNLZdyVeXVAchNem-vMlKtoJjiiJ59-WrYsoCCudR4TaD92R7KEaw>
    <xme:TzNLZdSSLnhgoEadBJ-UVGgBwmentsvvSE-y4jL7kq6JUjWCY85Q5btOdFSQUpjvn
    ztnbSxviSraQUrbAw>
X-ME-Received: <xmr:TzNLZXVUjy44KAiSXSjkudVnsX-PO3c6KiZasPJJufDw24OULj1Ley8V2juAXdF6uFiBzzZhf51ZxD7btiIw20ik3B9FCKJrLkkT-Ls0Hl8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:TzNLZfh_py8_PcKoj1JA8nUsedV4RL5brJMFyZfUyB25GfwACf92jQ>
    <xmx:TzNLZfAQLgwS5rvVHDuKAdbsrl-_lo7pMSWiWjG0qhAFCcI_TnZnzg>
    <xmx:TzNLZYJy-9Ca3mF8bXiN2bYBrbk1G2qin2MS-t2ecughRz5KD49vAw>
    <xmx:TzNLZa-pqEevBiOvk68VAilrOLV4mD52jNB7HCzMHjayj59NInEIaw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 02:05:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d011058f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Nov 2023 07:05:23 +0000 (UTC)
Date: Wed, 8 Nov 2023 08:05:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/3] tmp-objdir: introduce `tmp_objdir_repack()`
Message-ID: <ZUszSs0CYoFV9YJ0@tanuki>
References: <ZUpepnSCSxL8i96b@nand.local>
 <cover.1699381371.git.me@ttaylorr.com>
 <0f19c139ba9bb5105747f545038825d0c89f2e42.1699381371.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KkC7CTdy46jLeMGR"
Content-Disposition: inline
In-Reply-To: <0f19c139ba9bb5105747f545038825d0c89f2e42.1699381371.git.me@ttaylorr.com>


--KkC7CTdy46jLeMGR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 01:22:58PM -0500, Taylor Blau wrote:
> In the following commit, we will teach `git replay` how to write a pack
> containing the set of new objects created as a result of the `replay`
> operation.
>=20
> Since `replay` needs to be able to see the object(s) written
> from previous steps in order to replay each commit, the ODB transaction
> may have multiple pending packs. Migrating multiple packs back into the
> main object store has a couple of downsides:
>=20
>   - It is error-prone to do so: each pack must be migrated in the
>     correct order (with the ".idx" file staged last), and the set of
>     packs themselves must be moved over in the correct order to avoid
>     racy behavior.
>=20
>   - It is a (potentially significant) performance degradation to migrate
>     a large number of packs back into the main object store.
>=20
> Introduce a new function that combines the set of all packs in the
> temporary object store to produce a single pack which is the logical
> concatenation of all packs created during that level of the ODB
> transaction.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  tmp-objdir.c | 13 +++++++++++++
>  tmp-objdir.h |  6 ++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/tmp-objdir.c b/tmp-objdir.c
> index 5f9074ad1c..ef53180b47 100644
> --- a/tmp-objdir.c
> +++ b/tmp-objdir.c
> @@ -12,6 +12,7 @@
>  #include "strvec.h"
>  #include "quote.h"
>  #include "object-store-ll.h"
> +#include "run-command.h"
> =20
>  struct tmp_objdir {
>  	struct strbuf path;
> @@ -277,6 +278,18 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
>  	return ret;
>  }
> =20
> +int tmp_objdir_repack(struct tmp_objdir *t)
> +{
> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +	cmd.git_cmd =3D 1;
> +
> +	strvec_pushl(&cmd.args, "repack", "-a", "-d", "-k", "-l", NULL);
> +	strvec_pushv(&cmd.env, tmp_objdir_env(t));

I wonder what performance of this repack would be like in a large
repository with many refs. Ideally, I would expect that the repacking
performance should scale with the number of objects we have written into
the temporary object directory. But in practice, the repack will need to
compute reachability and thus also scales with the size of the repo
itself, doesn't it?

Patrick

> +	return run_command(&cmd);
> +}
> +
>  const char **tmp_objdir_env(const struct tmp_objdir *t)
>  {
>  	if (!t)
> diff --git a/tmp-objdir.h b/tmp-objdir.h
> index 237d96b660..d00e3b3e27 100644
> --- a/tmp-objdir.h
> +++ b/tmp-objdir.h
> @@ -36,6 +36,12 @@ struct tmp_objdir *tmp_objdir_create(const char *prefi=
x);
>   */
>  const char **tmp_objdir_env(const struct tmp_objdir *);
> =20
> +/*
> + * Combines all packs in the tmp_objdir into a single pack before migrat=
ing.
> + * Removes original pack(s) after installing the combined pack into plac=
e.
> + */
> +int tmp_objdir_repack(struct tmp_objdir *);
> +
>  /*
>   * Finalize a temporary object directory by migrating its objects into t=
he main
>   * object database, removing the temporary directory, and freeing any
> --=20
> 2.42.0.446.g0b9ef90488
>=20

--KkC7CTdy46jLeMGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVLM0UACgkQVbJhu7ck
PpTMgw/9Hfp6tN2N67/dT8hXdWcVNy5WWy1sO5IQJeBw19HV2BwP/bLALB4blYsx
XLyEKOakHoIt0fxvBRdMHcXP+Z4zhsc2Is5d8OTJ+w3fOMGc5uDIy3WnrLpdMVqb
V+7xbT0Z+1u7L906ujiGYAXb/vfb5HqVhEA73iDU3JpCk2vdOGefzS8puScU0u8J
g4qmD48lCJvbcbT24TJdck5aS9fN3w/tQ/urgth0/4iXZmoewO+l34BzObl3uKfm
qCwS0cPHw8YTJ61RzEwxvSmGctML/DbE6piV8RnamRkm7UGrmHBLtzR/0vEd5T4H
STr59gNP5q8UaU7PvnBK8GyuZ9V9HzPP6oFMhH7+yrnTyWdCQuk1B3u320REEx9d
gFZyb88dLZnZ1HVeUvFxnEKU030JUHy3IcExXo3Pwrp34fKGzWpn60hlOJrKZdDQ
QPWBgnsJkBm+heWfF8JHjpJ/x1PoJqQmInOupmYZE/D9Q6E6AN9cVnAnznkPVaX8
077YjMwwaoCB/g6CfaqanwKwViKJ9c265EDcjRtdND8FWzIZJnqtldChzXQesDvv
X+cZdF96Y7jsJrejqORSfGSjkVyYzweod2+AxpypWeWeT2mZ50MwuvXGDeO4J6Yn
MK3I25QkyjWRiShfH9FBiL+gXQBYuVkJ73P/8FS1daEW/N0OOqI=
=mpdp
-----END PGP SIGNATURE-----

--KkC7CTdy46jLeMGR--
