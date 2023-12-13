Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prQnZY4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C9gBwr3x"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F86DBD
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 23:38:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id ECBFA3200A80;
	Wed, 13 Dec 2023 02:38:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 02:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702453118; x=1702539518; bh=gjRffRiznd
	qe03G+fMArBECUM9ohN+noy4caCPpfnpc=; b=prQnZY4+g9gxfKnf6fCKH3W+FU
	yYyt50XZLsJY8i6gzjEAnkaol8oF904EFFNH7txqoYp0Jqjqb4hdUdzrBQzSqIBD
	UjGbpdQ2dkXw0qMCTZvSNA++8srCJhmwq7/hlcKWIEZAJkFCu5+yXadlgv3rijxm
	evwyFoFTgrEjbxu7m2ktHTobFx5xTWg+AHcbZY/+rLEkmTgGJd15R6kbiTEiZLEc
	xbVa8ZDEAo+G29FLkq71xanBeIeWn8BgoOXEQB9Kok5gZj1ttadne6R8yDl6Wrw/
	hc2LMRts7EmEw+KZ+wJjFU0mRJ1sO4FiHSQdHoylt5VRcWygCnNlmz+7oewA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702453118; x=1702539518; bh=gjRffRizndqe03G+fMArBECUM9oh
	N+noy4caCPpfnpc=; b=C9gBwr3xlkvSNoTOYh+wYYfPAOQjxYqnEXicKz2rjeG2
	Cx0lgok3zd6JRHLXDYLFl+k88HGI6/L2NUeJTmppqv60MUajnyP0W++8dgjj+u80
	sxrUNb+HuHBdJGbyrHuCCu5dZnJKZq9pCCcnhXHbbL0O5Yx3erZb67G5XBcKKRQm
	M1he0kV4Qsq6TmvNe/P4yE7qVt//E5d9tZ8OAyOPkBtDOuZPqa/uilku4pf0kqb1
	EOXf8m7cDUL8TC4Qengi34iwOLb154M2r89PtlfnXptYv7I12lIAtoszaXOxpQpl
	JtxEEIYaM1aEM319NWZE0+ya9mlq6ut2VIfEkfFQhQ==
X-ME-Sender: <xms:fl95ZZuKC9iqAlcXzRZblID-yuZv4w4BEpN07_rYpUKKUZorCt-AhQ>
    <xme:fl95ZSdiS9TBhGJavorpG4z2rohU8uAn1Kjnqbr5fgOEp-LtITr16-X9n8Es-LVKC
    TQJ1PwGLN3I_LwIMg>
X-ME-Received: <xmr:fl95ZcwsnGMAu44G0WmI6hjeRH5-ujy0BhnX4NtMKw_rS-ZY8mBVZslquQUq91rxWmyrRLTK7pcqtHT8N9-5b1F0Z56rdZYIXuT0xd_YWlF3jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:fl95ZQPHsTJGFye-a8Y5W7-MlZInarn2tr_gVzIfBopHxr2qRJ_deQ>
    <xmx:fl95ZZ8yhpvr3gftyMrfK1XIBU-PAbzuBglRcbgwGNQWMm4gFqScSA>
    <xmx:fl95ZQUEGdeusAXw7o0jAOSq688ZaF5NxTfn_rmZkYfENiZKuUsdSA>
    <xmx:fl95ZUYFGtlBQKRMt8ysJQivtCNa5U_Ks_dAqRlhoGve29ikVnFiTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 02:38:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0f721e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Dec 2023 07:36:54 +0000 (UTC)
Date: Wed, 13 Dec 2023 08:38:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
Message-ID: <ZXlfeWtDgr1GQFCL@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <cover.1702365291.git.ps@pks.im>
 <1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
 <xmqqle9zqidj.fsf@gitster.g>
 <ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
 <xmqq34w7os53.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fOzE1TUqu6hIohFv"
Content-Disposition: inline
In-Reply-To: <xmqq34w7os53.fsf@gitster.g>


--fOzE1TUqu6hIohFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 04:36:24PM -0800, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>=20
> >> "via the refdb" -> "via the refs API" or something here and on the
> >> title, and possibly elsewhere in the proposed log messages and
> >> in-code comments in patches in this series, as I've never seen a
> >> word "refdb" used in the context of this project.
> >>=20
> >> I agree it is bad manners to be intimate with the implementation
> >> details of the how files-backend stores HEAD and ORIG_HEAD.
> >
> > Hmm, I have never thought of the 'pseudo-refs' as being a part of
> > the 'reference database' at all. ;)
>=20
> Me neither, but once you start thinking about getting rid of the
> need to use one-file-per-ref filesystem, being able to maintain all
> refs, including the pseudo refs, in one r/w store backend, becomes a
> very tempting goal.  From that point of view, I do not have problem
> with the idea to move _all_ pseudorefs to reftable.

Yes, we're in agreement.

> But I do have reservations on what Patrick, and the code he
> inherited from Han-Wen, calls "special refs" (which is not defined
> in the glossary at all), namely, refs.c:is_special_ref() and its
> callers.

I do not want to add "special refs" to the glossary because ultimately
they should go away, with two exceptions: FETCH_HEAD and MERGE_HEAD.
Once we're there we can of course discuss whether we want to explicitly
point them out in the glossary and give them a special name.

> Neither am I very much sympathetic to the hardcoded list
> of "known" pseudorefs, refs.c:pseudorefs[].  I cannot quite see why
> we need anything more than


>     any string that passes refs.c:is_pseudoref_syntax() is a
>     pseudoref, is per worktree, and ref backends can store them like
>     any other refs.  Many of them have specific meaning and uses
>     (e.g. HEAD is "the current branch").
>=20
> Enumerating existing pseudorefs in files backend may need to
> opendir(".git") + readdir() filtered with is_pseudoref_syntax(),
> and a corresponding implementation for reftable backend may be much
> simpler (because there won't be "other cruft" stored there, unlike
> files backend that needs to worry about files that are not refs,
> like ".git/config" file.
>=20
> > We seem to have pseudo-refs, special pseudo-refs and (recently)
> > ex-pseudo-refs!
> >
> > This patch (well series) changes the 'status' of some, *but not all*,
> > pseudo-refs; some graduate to full-blown refs stored as part of *a*
> > reference database (ie reftable).
>=20
> Yeah, that leaves bad taste in my mouth, too.

I'm taking an iterative approach to things, which means that we're at
times going to be in an in-between state. I want to avoid changing too
many things at once and overwhelming potential reviewers. But I realize
that I should've done a better job of explaining that this patch series
is not the end goal, but rather a step towards that goal.

The patch series at hand merely records the status quo and rectifies any
inconsistencies we have with accessing such "special" refs. The natural
next step here would be to reduce the list of special refs (like e.g. we
do in patch 4) so that in the end it will only contain those refs which
really are special (FETCH_HEAD, MERGE_HEAD).

Please let me know in case you strongly disagree with my iterative
approach, or whether the issue is rather that I didn't make myself
sufficiently clear.

Patrick

--fOzE1TUqu6hIohFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV5X3gACgkQVbJhu7ck
PpRxOA/7BBdzExf9iPW+40iNmNjcz7GN86LBkQttcLgjszUGhLm3hzFMu6GlXHg7
UCVEyhXCZ3kjSb/sc5fMCD81QtX3ucHRZN/8DoL3Hm45iXm2VF6z8ZsSB2v2ygWN
6Noa89+p3u77dJiIJoYwXYJOwvNn07cBWNHPjxcW7OdnRI03PX/hMJ2gT3YQabVC
ZPuyMwPtBtI+SzwOerIJi2LYemQbgr8CAIlJ4iJfWKleAauU2CfI5Sozpzdhs9GY
X3G00ajlOrZJF6OrhAQ99UozmQcYTxJSFqPInVYAIBg55kuNsSpIMi1GWsGXSg2J
3PMlDd8yDFRf48kqebgpd8EHdayuyS7Gs8hHGI9aKb/YHj2mAiY6e7oda0HeXoAu
24X4luFl1WEITtXLCaMXPxozST1dhvsQHDMIR7WDEYSCxkqt5U6N1zuG3H7Hzx6/
tOqzgOkJLn6l/cr0of+z00TmRCohHeoEDDlOF1ceJB+IFDkcHBaHwo5kejGXRbBK
XcD9Rl5V9orUGNb3JZdgzD3wRx5vdIsg1XK3jRr/4yzjIfvXqpChf8SDo3VPUTc+
A1sPCJCH27jdlOjteQZnQ2IEfGFTYzctv2m0ywuDthGL8aaoDJbhM4SDcclQ2aCc
xGj+VwQ04VWQTAO+5FNqA1YEMO9TKJ/NY+wU2NJN70pIZY4zMXo=
=6dal
-----END PGP SIGNATURE-----

--fOzE1TUqu6hIohFv--
