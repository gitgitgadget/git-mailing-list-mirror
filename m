Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PLUgw30d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2LTJdqmZ"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EA8126
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:37:30 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 2A6733200A9F;
	Thu,  7 Dec 2023 03:37:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 07 Dec 2023 03:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701938249; x=1702024649; bh=iM
	zH1gGLvRzmUp8kDUmxMhWONRPkRB1f8UuU/fmshFQ=; b=PLUgw30dfCMxgcnfs9
	tR/oZq+99xA4nz7B45ff1meseWy1fhGXzm7W4DCXg4u5eSG/Kh784zTfAD3DoMiF
	JTnSfFaOpmR1Fxmo8rQuagEs/zeOfjRLv7FT9qYIwgjA2SnyBnLNUzPthcawIYQ8
	FMSAiiIu6buZd/+D8V9y+CzNpc7BwUVtF5a0i6kOKhO4acRCoKUxshvW/7Vjz18T
	xJi7oJ2Uw87scFysb7EpZ21Jz+KxzP+p5Lm7qpzsuDqZ33OwIsSzpCVXkyISOmUh
	6/bPKicJpFI3jmcbOcYIe3tjlytm+fV/yJW/DLRK6j8q+HWFH5CHXYgYY2Z40Snr
	UXVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701938249; x=1702024649; bh=iMzH1gGLvRzmU
	p8kDUmxMhWONRPkRB1f8UuU/fmshFQ=; b=2LTJdqmZHOVMubACoqIPjBxpzMTpd
	ie+2mduLUUBkBZJv7vLVDAYApYrv07sFrx0+s4CYtisQtv9PzxJpahyHcIo52r2M
	CdwgKD5XOoBRbLrEn1G6wO6Ws+uedJXERdGoURUfKW3UpcpJPzPiQwtP1p8fA+4Z
	dLAh7OiFKU1fowOEcVsTBrxwQEjIhEi0SAa07cy7vz/GvVGtTLhCTK0Db+IPH9b7
	XZFxuWHBpMKwM4yKzV1JJJozcDmgV+VAZU340KMFT6Onv68wbnRbeQ02IwWRDJqZ
	eJr2/cZUrIgwpDURoLIVoUU5ktI+oV9iuVtPJg77qlkQISlv5ibw3taaw==
X-ME-Sender: <xms:SYRxZcYQNhqiOHpjRJIc19Vle2yz7iOD6tX0nUHbokkNs6acl8gMFA>
    <xme:SYRxZXYklS49E35uXwVUzYMB4tnyaQhdrFjzhzxD1kwlZbUPDwCT7zxlfvRgRqvw2
    qgr-0QMLih6DmKE9A>
X-ME-Received: <xmr:SYRxZW_iarx3Nxpd8GhBBmK8i46VFALfnHxL9vfyvl8QAdm6cjO5AoXOgaaaiH7DpCGLv4UqP4kU4r5Er1gmRvbsPSmZbPmac3YgqK4NUo38_KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:SYRxZWqPKYawVeCqasYJ5G_N7iPtpDKNRlRwvhj31pgdIU1JSwcDrw>
    <xmx:SYRxZXoQh9R1Mh07lw5vM_WFPEhM4jxRdcFgzVum-034k64qSJGxxQ>
    <xmx:SYRxZUQ8rlPOpRTDHrr_ENBvI57FHsLBmsx2g3X6BV9bsn8e1nsv4Q>
    <xmx:SYRxZQBeF8c6YtmbJjE7T7sEyW2BmLa3x2dCyRO5ACpc-ZJ9NWSyxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:37:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d90b747b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:35:59 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:37:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZXGERbcSiM8PDQbw@tanuki>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
 <ZWcOvjGPVS_CMUAk@tanuki>
 <20231206201048.GE103708@coredump.intra.peff.net>
 <ZXFt1foDuHKBmFwk@tanuki>
 <20231207073451.GA1278091@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QWHCg9ayLDYk19DU"
Content-Disposition: inline
In-Reply-To: <20231207073451.GA1278091@coredump.intra.peff.net>


--QWHCg9ayLDYk19DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:34:51AM -0500, Jeff King wrote:
> On Thu, Dec 07, 2023 at 08:01:41AM +0100, Patrick Steinhardt wrote:
>=20
> > > So forgetting at all about how we structure the code, it seems to me
> > > that the problem is not new code, but all of the existing code which
> > > looks for access("refs", X_OK).
> >=20
> > True. The question is of course how much value there is in an old tool
> > to be able to discover a new repository that it wouldn't be able to read
> > in the first place due to it not understanding the reference format. So
> > I'd very much like to see that eventually, we're able to get rid of
> > "legacy" cruft that doesn't serve any purpose anymore.
>=20
> Right, nobody is going to be mad about not being able to use the
> repository with old code. My concern is that by skipping it in the
> discovery phase, though, the user may see unexpected behavior (like
> continuing and finding some _other_ repo). I admit it's a pretty narrow
> case, though.

Agreed, that's also an angle I brought up in a separate thread [1]. The
second benefit is that the user would get a proper error message stating
that the "extensions.refFormat" is not understood compared to Git just
skipping over the repository completely.

> > The question is whether we can do a better job of this going forward so
> > that at least we don't have to pose the same question in the future.
> > Right now, we'll face the same problem whenever any part of the current
> > on-disk repository data structures changes.
> >=20
> > I wonder whether it would make sense to introduce something like a
> > filesystem-level hint, e.g. in the form of a new ".is-git-repository"
> > file. If Git discovers that file then it assumes the directory to be a
> > Git repository -- and everything else is set up by parsing the config
> > and thus the repository's configured format.
>=20
> I kind of think the presence of a well-formed HEAD is a good indicator
> that it is a Git directory. IOW, I don't have any real problem with
> simply loosening is_git_directory() to remove the "refs/" check
> entirely. But again, that can only help us going forward; older versions
> will still get confused if we truly ditch "refs/" for other formats.
>=20
> Of course some ref formats may want to avoid the "HEAD" file itself, so
> your .is-git-repository would be cleaner. I'm just not sure if it's
> worth the headache to try to switch things now.

I think that both "HEAD" and "refs/" are in the same spirit and consider
both to be legacy cruft that ideally wouldn't exist with the reftable
backend. I think dropping just one of these requirements ("refs/") is
the least favorable option though:

  - We'd still have unneeded files that only exist to aid old clients.

  - At the same time, the old clients wouldn't be able to detect the
    repository anymore and need an update. So we could just as well drop
    both files and would have the same outcome.

  - This is not a long-term solution in case anything else in the
    on-disk format will ever change.

Whether it's worth getting rid of them now... probably not, at least not
for the time being. But if we want to address this issue I'd rather want
to aim for a proper solution that also works for future changes.

Patrick

[1]: <ZXFy0_T1AZLh058g@tanuki>

--QWHCg9ayLDYk19DU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxhEQACgkQVbJhu7ck
PpSpug//ZFBkaBWYVA205zmg/Pi7iSVEQ6g7616iHO2YutMNhSqtic5v7FfmU4TU
+qrmc4osEngDGtmOCkbDVX5yzOrFGk3iCG4HwUoo1y9GoVgvLfnUQIiRVlCEekrc
ciCFliBzH+qdYC3TKpaEEP6X3Lj7CuGkP/4ZivxRropq5TtofKXLA8wNHiMcaJdV
GqYtxLpOscpNx9t9r548I/WnlYsagIZOy0dPRcwHmoOyeByl1lHb8OlBoB1oy356
kEn2wEiPcZJO44ZK8bMwScNnkoDiKe76NDS8yMCmHWnZOEx++bNMDJeL5saTMLZg
i5bkZVoIp3WpTMf/49tOrDzdcX5hObsVnt3aT11rN0aJ5VRPfpbUOJo436TA8Yue
DWUHuH5ATOCdXpR9sEPzChV/9gYMRAjA7dHeWIJkxhbOZSkBQ6T5cqcZWyskIPdZ
v5HR0YQTrAOq/7umzAxPQqv2Ri1otdcrgHNXWfuu9FSme0T3t7NXAu6NfK1jPCn8
FGfznXqGghAm+T1zTAa9a2HtWjhQdx5FsbqUzkz1g+wHJ3zrKeNThJ22Ak3Yw017
Flo9COuZLjmhx+cb9Y9qhQpm1aLh6NMLxEKku2COCNxlrLG8YVi3nGmVOy5E/W6O
ZISX4yOSi4SUUFiQUJnxYS0KoYqchSytjcJl2+luVvFnCEpBXB4=
=YXMW
-----END PGP SIGNATURE-----

--QWHCg9ayLDYk19DU--
