Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V9EMbxOS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JzeX27q7"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89053D44
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 23:23:03 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id E2F4A3200A1A;
	Thu,  7 Dec 2023 02:23:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 Dec 2023 02:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701933782; x=1702020182; bh=zJ
	RSBo4m9Sdnkr8/XlPOLkxbZKmguGsUbEVTduI2u1Q=; b=V9EMbxOSY3NRXl0hGT
	3RFFQqzzJ5bvstHH2FNdEnN9ByCWXBr7LKyYFWDbCfLMn3mH3j56wljL3Q5WrpD3
	XYeJgOqhHjDm1FbweSXjY8lkAos73ncej1qDvUT8r/AhpuhzTfz94JGZdmqPSvLG
	HuF0LCfxca9siPL9R7TKyfhDmGNCRlHeUf6UN6RC+9By5WF9dQrY5zcfyVZSrhWk
	4eROYkJ2K/7hyxnD/rvvpvjY2LEvhVgtar1KP3ttu4Lgs2un2XGqGfMMxUCmF6FQ
	VLpJKqphXehn8x7sJ3J00tdx28gpbg2iRSEH7lsb9X7g0w9m7bYwl/xsw6dvSxSH
	oLfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701933782; x=1702020182; bh=zJRSBo4m9Sdnk
	r8/XlPOLkxbZKmguGsUbEVTduI2u1Q=; b=JzeX27q7+y3mEl9t/9OMe0HyQsZ3M
	JdGM0aAv9dVOPNk9dcF8nkJ4GFHskgsIpQdhcQPWAWxPVxwA7qG66WokfVmaTKvY
	ci+CrQCYL2HOBJwYLkh3fRQ4Hca+DFk9PW4TaLERWg8cZKXsefO2HQzi+0bRrnXg
	visP33xWaqujRVWeI0Yi7QpkbkD2DES0RzB4rTRqlKaVzcD7/gM7Lk3Uua90qSn8
	bMUeNVBRjxncdiwGDl0i+ZxMVTdlfmu9tu116+eFMiIeykuIa5HwiwCPINbHc3qo
	5+YI5djxMj0jn2ZZQdIFNmdsaxQDMAFQ3NaxYe/nJTFRWeLua1VQNCx+Q==
X-ME-Sender: <xms:1nJxZQ6ERJFae7mo9a4HNz739qnL3e2RaHNpDjmI9Cp5HLogY-hzaw>
    <xme:1nJxZR7qrpGyj0RmFBvXKixX10MVS0EhSDby2fODnPCKlnb4o-wkOvcr0Ry7Wo3bD
    5dMnPr79jlTfGK1QQ>
X-ME-Received: <xmr:1nJxZff62Pw6UPg5mamdbYWVpKlL0Uh0ihRjebHsgFjrBtHLQVoL3_W9xWKMnjOxk-bKrK8nONRnY6Cb-X4QBFSnN7NAGDDUjMkxKqIGxyng9AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1nJxZVIxdGwms4eXip1Mx_rN6fDqjvliVngzp3j7rhasVgEmINu6Pg>
    <xmx:1nJxZUJwpGHCnFci0gDVlsMua7N9uZO3hhieO6RHZddKRRJofhf8ug>
    <xmx:1nJxZWy0nYliuntrMiaVr7nFLf75bYH_rbNPZs9NMxR5uDqO4o5QFw>
    <xmx:1nJxZezf1zJctUJmJIBpMN_9agk8pi_OrQbBSGK1TLOzteBePM3t4A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 02:23:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e571505c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 07:21:34 +0000 (UTC)
Date: Thu, 7 Dec 2023 08:22:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] setup: extract function to create the refdb
Message-ID: <ZXFy0_T1AZLh058g@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <b69c57d27269c9b40c9e4394861dffd8a8b9860c.1701863960.git.ps@pks.im>
 <CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksc/XEwIr+HIie1g"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSZztJUF9nmSzGdOW0oWBRUp2sw8QyuZO_q06cNymad3Q@mail.gmail.com>


--ksc/XEwIr+HIie1g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 10:10:37PM +0100, Karthik Nayak wrote:
> On Wed, Dec 6, 2023 at 1:40=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
> > +static void create_reference_database(const char *initial_branch, int =
quiet)
> > +{
> > +       struct strbuf err =3D STRBUF_INIT;
> > +       int reinit =3D is_reinit();
> > +
> > +       /*
> > +        * We need to create a "refs" dir in any case so that older
> > +        * versions of git can tell that this is a repository.
> > +        */
>=20
> How does this work though, even if an earlier version of git can tell
> that this is a repository, it still won't be able to read the reftable
> backend. In that sense, what do we achieve here?

This is a good question, and there is related ongoing discussion about
this topic in the thread starting at [1]. There are a few benefits to
letting clients discover such repos even if they don't understand the
new reference backend format:

  - They know to stop walking up the parent-directory chain. Otherwise a
    client might end up detecting a Git repository in the parent dir.

  - The user gets a proper error message why the repository cannot be
    accessed. Instead of failing to detect the repository altogether we
    instead say that we don't understand the "extensions.refFormat"
    extension.

Maybe there are other cases I can't think of right now.

> > +       safe_create_dir(git_path("refs"), 1);
> > +       adjust_shared_perm(git_path("refs"));
> > +
>=20
> Not related to your commit per se, but we ignore the return value
> here, shouldn't we die in this case?

While the end result wouldn't be quite what the user asks for, the only
negative consequence is that the repository is inaccessible to others. I
think this failure mode is comparatively benign -- if it were the other
way round and we'd over-share the repository it would more severe.

So while I don't think that dying makes much sense here, I could
certainly see us adding a warning so that the user at least knows that
something went wrong. I'd rather want to keep this out of the current
patch series, but could certainly see such a warning added in a follow
up patch series.

Patrick

[1]: <ZWcOvjGPVS_CMUAk@tanuki>

--ksc/XEwIr+HIie1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxctIACgkQVbJhu7ck
PpQESg//ZFTUii3TMUxoHAF8l011Y732exhcHHiKMCAVbFMI2dzo31uwKED6cKAu
h54bTs9tJJrIkOgKD6YvafvQrOAjcOanoKXVodGkRUSvMQbI7/1AzmWLzbeZwEAp
EhEWQGN51fPFKhYvmA4JichyP4wWj1e1qx04/zGig55dRtPGYJCPjM8CmZd5UKo+
W2I4ziDFYwRJpu3XdE1gMYPkIZo00URyqd30HNgRORo5w5OX//7B1HumFiNfT0G5
kviQz/ftyfq2jscBBsE/fHKkB6Paqh4nRa8hzie9VbrvZedCW5dyVgIQxmdCfxc1
wEhXkGHRilmknEVZseUVu12QGe5Rvu2UfDWdXzbmZ8bIAPRdD5aeaPepY0TNZmFL
kWs3wPRlNLpNLxCBMsq7FD0LJhauFIlLOK+516YNSAM8eO74a9CbviYCyMq2mkIS
64gZOVBZjR0zXJNKyzXWcSFalgNfxP3X46FglyBfJMPelORBejgpxZamVBgOzL62
6yWdKc1CA/F5oUCf15R0E+h2Czo2PN/sMjKoo0nYB+qqqoaPowrkXljMENJEn7Y5
9Iv6ZbJvANXBHrSy89gfR+Fw72yye2vFmnEmTBNsaWcn/qee2yT7nwK9crcan7Ls
xu/zZuA5BFcjF4zhuWP68WK9swyga/+flVEmcQcJoBAOaQwydf0=
=c+p3
-----END PGP SIGNATURE-----

--ksc/XEwIr+HIie1g--
