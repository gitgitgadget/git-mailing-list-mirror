Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ouMtrtLr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iwGiCnxS"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD21BD3
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 02:13:23 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id CD2875C025A;
	Wed, 29 Nov 2023 05:13:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 29 Nov 2023 05:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701252802; x=1701339202; bh=2y
	EUanXJpFiUaNtujmRfLRzNBSG+eHkTHBtC00kVQuU=; b=ouMtrtLrykBuGuXWSd
	/r8LJc/o4VLG3x55viPBD0lbUWTAbBLB/E28x6s5Fa2bZNdN8zYa7jdJ9143o5eC
	PWumShzl2SpgApGGupTyHuBM1XoM81Qx0wyLLSRI7cO6gXGCrksqxAUontH1q1oS
	0nblcEhfhq+3edg/Ofe4Z9FsWQSUeykGODfkUkoPipt0/WmIBxICb0a/CAnU+Ysw
	PAPn91F5PAyblnjOK720yerfD5yZYozmwTJlEE5lpQtXKFoRgl4E+hhEjx8zI4hH
	ZKyuWDHBYcAE7ndl6dtuSNGbAbHwNwDa5RBFcM9ejX1bI5oVYKK+haadbqxr1NAN
	RVkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701252802; x=1701339202; bh=2yEUanXJpFiUa
	NtujmRfLRzNBSG+eHkTHBtC00kVQuU=; b=iwGiCnxS6vLgSGzh87+jaX29XucA+
	WbwreGimWWVNsiP78WPfBbRORDkIjC6B8zkWYmEB7yPPWNvIlIIjwpSzbUSuUslC
	vsuOQFLTBZ1GZao2BYgTsTlHpakmIySP76EMVUwLW4nwXX7UnNqDsm49UCEEfDGE
	Kjv7dfO/Bra+ZL74O/CqXVWgt5YjmCjmeb5U8dPwyNcleRVXJyiK+wYrzSdoPO8+
	BzU+DGmQQ2jctgAAaj1eZHeemiyD8j9pTTcEtwuxEO05k/ik1fma2ZiEMS5h/NCk
	5mergTiCFxWxcoW+aCrTm6oktE8jNbBP1oD1OwLUmtmRz/D1xuIaOQcQA==
X-ME-Sender: <xms:wg5nZY1vfNKD22xCoCXdNfLvsNqe0yS8PhN92ALyYVNLQQcqcVN01Q>
    <xme:wg5nZTFJJs8e7QVEO9nmZLkJ_ZqcNzt2UyMD2Ixp7M_61IA1cwioFsHG9JUmB09nm
    YO2WR-pMoCjmApeww>
X-ME-Received: <xmr:wg5nZQ6Im4d97QB_s4x3_mppVwfNjeCl4vthfgeceF_ujdQjceCQliYFaimvcvHdWtoBDBRUBgoXcXhM-5X-pvSG4BzDE8tNvslHds7vcGJ0mDFW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wg5nZR3uQE9JpwyBqqyT2TiHsNO5YgYbkYm1YbBNPWst4PVizDEJ7g>
    <xmx:wg5nZbE0k_n0cSE4zaoWlf0ZXtuqXyThKV8H7qAmVcGG2bLTPqpEzg>
    <xmx:wg5nZa8RFxeE0Qm-4WlmkhVJIlfymqnZx_Lbgg9AjRIwTbZ3AmO_vg>
    <xmx:wg5nZRPAyhO5potl2sgbc0XpcUgRkeUd0VB94u1AJva-ma_5eziflw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 05:13:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e19bc8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 10:12:09 +0000 (UTC)
Date: Wed, 29 Nov 2023 11:13:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZWcOvjGPVS_CMUAk@tanuki>
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
 <20231128190446.GA10477@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pt9SxFT0sJ5p7Q/3"
Content-Disposition: inline
In-Reply-To: <20231128190446.GA10477@coredump.intra.peff.net>


--Pt9SxFT0sJ5p7Q/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:04:46PM -0500, Jeff King wrote:
> On Tue, Nov 28, 2023 at 03:28:45PM +0100, Adam Majer wrote:
>=20
> > In a garbage collected bare git repository, the refs/ subdirectory is
> > empty.  In use-cases when such a repository is directly added into
> > another repository, it no longer is detected as valid. Git doesn't
> > preserve empty paths so refs/ subdirectory is not present. Simply
> > creating an empty refs/ subdirectory fixes this problem.
>=20
> I understand your use case, but I still have a vague feeling that this
> is bending some assumptions in a way that may create problems or
> confusion later. In particular:
>=20
> > Looking more carefully, there are two backends to handle various refs in
> > git -- the files backend that uses refs/ subdirectory and the
> > packed-refs backend that uses packed-refs file. If references are not
> > found in refs/ subdirectory (or directory doesn't exist), the
> > packed-refs directory will be consulted. Garbage collected repository
> > will have all its references in packed-refs file.
>=20
> This second paragraph doesn't seem totally accurate to me. There are not
> really two backends that Git can use. For production use, there is just
> one, the "files" backend, which happens to also use packed-refs under
> the hood (and a convenient way for the code to structure this was a
> subordinate backend). But it has never been possible to have a repo that
> just uses packed-refs.
>=20
> There is also the experimental reftable, of course. And there we have
> not yet loosened is_git_directory(), and it has to create an unused
> "refs/" directory (there has been some discussion about allowing it to
> be an empty file, though no patches have been merged).

As I'm currently working on the reftable backend this thought has also
crossed my mind. The reftable backend doesn't only create "refs/", but
it also creates "HEAD" with contents "ref: refs/heads/.invalid" so that
Git commands recognize the Git directory properly. Longer-term I would
really love to see us doing a better job of detecting Git repositories
so that we don't have to carry this legacy baggage around.

I can see different ways for how to do this:

    - Either we iterate through all known reference backends, asking
      each of them whether they recognize the directory as something
      they understand.

    - Or we start parsing the gitconfig of the repository so that we can
      learn about which reference backend to expect, and then ask that
      specific backend whether it thinks that the directory indeed looks
      like something it can handle.

I'd personally prefer the latter, but I'm not sure whether we really
want to try and parse any file that happens to be called "config".

> So with regards to the loosening in your patch, my questions would be:
>=20
>   - if we are going to change the rules for repository detection, is
>     this where we want to end up? We haven't changed them (yet) for
>     reftables. If we are going to do so, should we have a scheme that
>     will work for that transition, too? The "refs is an empty file"
>     scheme would fix your use case, too (though see below).
>=20
>   - is the rest of Git ready to handle a missing "refs/" directory? It
>     looks like making a ref will auto-create it (since we may have to
>     make refs/foo/bar/... anyway).
>=20
>   - what about other implementations? Your embedded repos will
>     presumably not work with libgit2, jgit, etc, until they also get
>     similar patches.
>=20
>   - what about empty repositories? In that case there will be no "refs/"
>     file and no "packed-refs" file (such a repository is less likely, of
>     course, but it may contain objects but no refs, or the point may be
>     to have an empty repo as a test vector). Likewise, it is possible
>     for a repository to have an empty "objects" directory (even with a
>     non-empty refs directory, if there are only symrefs), and your patch
>     doesn't address that.

Just throwing this out there, but we could use this as an excuse to
introduce "extensions.refFormat". If it's explicitly configured to be
"reffiles" then we accept repositories even if they don't have the
"refs/" directory or a "packed-refs" file. This would still require work
in alternative implementations of Git, but this work will need to happen
anyway when the reftable backend lands.

I'd personally love for this extension to be introduced before I'm
sending the reftable backend upstream so that we can have discussions
around it beforehand.

Patrick

> > To allow the use-case when packed-refs is the only source of refs and
> > refs/ subdirectory is simply not present, augment 'is_git_directory()'
> > setup function to look for packed-refs file as an alternative to refs/
> > subdirectory.
>=20
> Getting back to your use case, I'd suggest one of:
>=20
>   - do the usual "touch refs/.gitignore" trick to explicitly track the
>     empty directory. It looks like the ref code will ignore this (we
>     don't allow ref names to start with "." in a path component)
>=20
>   - whatever is consuming the embedded repos could "mkdir -p refs
>     objects" as needed. This is a minor pain, but I think in the long
>     term we are moving to a world where you have to explicitly do
>     "GIT_DIR=3D$PWD/embedded.git" to access an embedded bare repo. So
>     they're already special and require some setup; adding an extra step
>     may not be so bad.
>=20
> Now it may be that neither of those solutions is acceptable for various
> reasons. But it is probably worth detailing those reasons in your commit
> message.
>=20
> -Peff
>=20

--Pt9SxFT0sJ5p7Q/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVnDr0ACgkQVbJhu7ck
PpTJUA//fQLHQoPtC3VfmBb01o4NIErqqTGXPtnw7QlplZCzmKzvC/a+9xxuGuCi
qOdeQc6fIOIt4Rju68jJ6HjvRDJOQGMBiOINMlU+o8W+XXEExoV8Kp5m+Ed4UBB3
RmvcOixH5IjNv2pAiido9O9cxdEpuBGFUh/QtgHRpNUKsnkFB1ElOvuECBRP6S54
VLMI7wBoeGCDBzu7R12FYlHwyU9h6aCISwNg2GpLxb62EDlHTdYmWAA/wQuOm0lb
AOmtc6bmRJi7Hl/YiHFOe+zq/GU51aR1Djydjnk7P6f8KzByAVclBKOZf3IyJ0ei
2hVTzDAFo3HmYUDNEZ64p+LWDFFdgi2p+OeoeFA/sxWH6c6CG87ohvHr+jvN11OO
wkOoCMqCTsf6Byi/For5tUD2lKuE3JUqcX+lZThD49myxjSv3o58DMehLK39WW0a
mwiKN3yw8VAOdPJ+g6yC764GfbI/3Ij43y3rwYv6pyArM4wh7vWmK1IcGYSxQHik
ZVLT8wyuytyKwIaF3Y4xlRRwTCAqPxavz6BcSADbN9kb8he2px6BlYOG7D66niS6
Hh6ZEeT5Kd2qOVvkS8TqJjFT4xB9UXBtPsueGkFBI+N7DGCp7cvwziK5yYt1bd0J
OFktRjt0Shu7kRu4nZ25PSRED5oN8x3iOccBWWgP5H9IaWi6wAE=
=xGsA
-----END PGP SIGNATURE-----

--Pt9SxFT0sJ5p7Q/3--
