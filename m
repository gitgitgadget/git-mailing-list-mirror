Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XUjJk+UT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMCBK83G"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C719F
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 23:44:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D5B955C0294;
	Thu, 30 Nov 2023 02:44:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 Nov 2023 02:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701330248; x=1701416648; bh=k7
	ImLtfxy+IpyybuS8Hc3E196E+/m59O8SxHBQsTtGI=; b=XUjJk+UT44iTerEW7I
	vaeBqPQ+IZCBbTVkbpZDGyIh9ZkUNd43WD4cZb7O/MTeIuZ4V81J98uWW0X2BitS
	Ig7req5C6677sflFjNeieCE9Qg3mVhGiltV/SnwXTv8OCQFLHBqFBF/qdl2jRYOr
	mCNw3qouT725cg0Z1064DDds5foHGB6zVoMZfR+SXUxjVp4mjmrFyk+ki6nWXQqD
	25AQVhGRVoRHsrUvArkRYX27hjBqUDYAOnMoZY3+vYGCyGQFi3No2rC/9RTxRioV
	s/vggdEKLkeERdoi01+bZdZG1KxM4GAtZxO2PUpZ8Q5vxGCVHr0OyE4wPMj63LMl
	hJmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701330248; x=1701416648; bh=k7ImLtfxy+Ipy
	ybuS8Hc3E196E+/m59O8SxHBQsTtGI=; b=bMCBK83GpnJEUa1QXeP6FU1E2UJzv
	KaddnFomF7Xe/i3oYQIybBbd+BI3pmPMQUUlSTtZwG3Ub0n6lc/bdgGNijKk2w8C
	8WotmeCYADZsWw31sKUlPlE6nx/FNOhW02q1GseNiWnd/dYJcQNmWYUqGPMl9May
	Hh/9wRKsKsRS12mpvAEDXLMmz3K8QOoa7Td3u5rzq9TuYjJ+hug/ti4aYxBZj4Zj
	bNCBiY08i4GYoF6YCWf029N6kEUqSIPwDwBsxBJndAY1BxtGf2Woth16keuTrtbj
	z1l5lqfdtXnkpxSYEmuI06EVxFfuEYmVm7S9frt8pT7XouhqhLeb2/HXg==
X-ME-Sender: <xms:SD1oZWJBbjZOW3U22MuxtsSfSGzJFBuA4DxNTSoWPz1RI19UNNxfjA>
    <xme:SD1oZeL-_cUOXJaEgNQSgSdMjgmhM_FUnZvGghWWUsrqWlbT0qVoCEszI3GIIs3yw
    Ai7JiPGtIlueq_07g>
X-ME-Received: <xmr:SD1oZWvq3GtnQtcmgYzrFx1sXxTRdvpKe4mjiGignQ9o5CYsDsW1UIVn5ZPxZ-ue1zG6hP067Md1Kh7HZVb8ALcOQ2hNVYSihIGfiIGKBg2AD08n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiiedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SD1oZbZdM5GhU_euP6Iu3b3Ubia6eHq_Iq_A2al2HzTFlckSdQogTg>
    <xmx:SD1oZdYuHG35zqqXxIfzRu315JDjVYtb6pJDXTefdPcsNVm8N954sg>
    <xmx:SD1oZXDRQgleEs11ljZOxGbYEvF2ApqffWUunVjLh0TYzEPutrYe9A>
    <xmx:SD1oZcwpeE9-ZgHlDlSsVkovR5gIbR9amHkDMVVuNxqjoT3ZmQpMKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 02:44:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8f9747d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 07:42:54 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:44:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, hanwenn@gmail.com
Subject: Re: [PATCH 3/4] refs: complete list of special refs
Message-ID: <ZWg9RW4L8nBhYmaB@tanuki>
References: <cover.1701243201.git.ps@pks.im>
 <0e38103114a206bedbbbd7ea97cb77fa05fd3c29.1701243201.git.ps@pks.im>
 <ZWe0RzOoHI9QZMox@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4s8AVajicg7iYKj"
Content-Disposition: inline
In-Reply-To: <ZWe0RzOoHI9QZMox@nand.local>


--n4s8AVajicg7iYKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 04:59:35PM -0500, Taylor Blau wrote:
> On Wed, Nov 29, 2023 at 09:14:20AM +0100, Patrick Steinhardt wrote:
> > We have some references that are more special than others. The reason
> > for them being special is that they either do not follow the usual
> > format of references, or that they are written to the filesystem
> > directly by the respective owning subsystem and thus circumvent the
> > reference backend.
> >
> > This works perfectly fine right now because the reffiles backend will
> > know how to read those refs just fine. But with the prospect of gaining
> > a new reference backend implementation we need to be a lot more careful
> > here:
> >
> >   - We need to make sure that we are consistent about how those refs are
> >     written. They must either always be written via the filesystem, or
> >     they must always be written via the reference backend. Any mixture
> >     will lead to inconsistent state.
> >
> >   - We need to make sure that such special refs are always handled
> >     specially when reading them.
> >
> > We're already mostly good with regard to the first item, except for
> > `BISECT_EXPECTED_REV` which will be addressed in a subsequent commit.
> > But the current list of special refs is missing a lot of refs that
> > really should be treated specially. Right now, we only treat
> > `FETCH_HEAD` and `MERGE_HEAD` specially here.
> >
> > Introduce a new function `is_special_ref()` that contains all current
> > instances of special refs to fix the reading path.
> >
> > Based-on-patch-by: Han-Wen Nienhuys <hanwenn@gmail.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 56 insertions(+), 2 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index 7d4a057f36..2d39d3fe80 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1822,15 +1822,69 @@ static int refs_read_special_head(struct ref_st=
ore *ref_store,
> >  	return result;
> >  }
> >
> > +static int is_special_ref(const char *refname)
> > +{
> > +	/*
> > +	 * Special references get written and read directly via the filesystem
> > +	 * by the subsystems that create them. Thus, they must not go through
> > +	 * the reference backend but must instead be read directly. It is
> > +	 * arguable whether this behaviour is sensible, or whether it's simply
> > +	 * a leaky abstraction enabled by us only having a single reference
> > +	 * backend implementation. But at least for a subset of references it
> > +	 * indeed does make sense to treat them specially:
> > +	 *
> > +	 * - FETCH_HEAD may contain multiple object IDs, and each one of them
> > +	 *   carries additional metadata like where it came from.
> > +	 *
> > +	 * - MERGE_HEAD may contain multiple object IDs when merging multiple
> > +	 *   heads.
> > +	 *
> > +	 * - "rebase-apply/" and "rebase-merge/" contain all of the state for
> > +	 *   rebases, where keeping it closely together feels sensible.
> > +	 *
> > +	 * There are some exceptions that you might expect to see on this list
> > +	 * but which are handled exclusively via the reference backend:
> > +	 *
> > +	 * - CHERRY_PICK_HEAD
> > +	 * - HEAD
> > +	 * - ORIG_HEAD
> > +	 *
> > +	 * Writing or deleting references must consistently go either through
> > +	 * the filesystem (special refs) or through the reference backend
> > +	 * (normal ones).
> > +	 */
> > +	const char * const special_refs[] =3D {
> > +		"AUTO_MERGE",
> > +		"BISECT_EXPECTED_REV",
> > +		"FETCH_HEAD",
> > +		"MERGE_AUTOSTASH",
> > +		"MERGE_HEAD",
> > +	};
>=20
> Is there a reason that we don't want to declare this statically? If we
> did, I think we could drop one const, since the strings would instead
> reside in the .rodata section.

Not really, no.

> > +	int i;
>=20
> Not that it matters for this case, but it may be worth declaring i to be
> an unsigned type, since it's used as an index into an array. size_t
> seems like an appropriate choice there.

Hm. We do use `int` almost everywhere when iterating through an array
via `ARRAY_SIZE`, but ultimately I don't mind whether it's `int`,
`unsigned` or `size_t`.

> > +	for (i =3D 0; i < ARRAY_SIZE(special_refs); i++)
> > +		if (!strcmp(refname, special_refs[i]))
> > +			return 1;
> > +
> > +	/*
> > +	 * git-rebase(1) stores its state in `rebase-apply/` or
> > +	 * `rebase-merge/`, including various reference-like bits.
> > +	 */
> > +	if (starts_with(refname, "rebase-apply/") ||
> > +	    starts_with(refname, "rebase-merge/"))
>=20
> Do we care about case sensitivity here? Definitely not on case-sensitive
> filesystems, but I'm not sure about case-insensitive ones. For instance,
> on macOS, I can do:
>=20
>     $ git rev-parse hEAd
>=20
> and get the same value as "git rev-parse HEAD" (on my Linux workstation,
> this fails as expected).
>=20
> I doubt that there are many users in the wild asking to resolve
> reBASe-APPLY/xyz, but I think that after this patch that would no longer
> work as-is, so we may want to replace this with istarts_with() instead.

In practice I'd argue that nobody is ever going to ask for something in
`rebase-apply/` outside of Git internals or scripts, and I'd expect
these to always use proper casing. So I rather lean towards a "no, we
don't care about case sensitivity".

Patrick

--n4s8AVajicg7iYKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoPUQACgkQVbJhu7ck
PpTL3RAAmzubrOiDG76WLPZTQ/Yxxd/cMDic6Gs58DCwl2j7dyRGmaSZlwOBPwk9
Ow4fXjVObNP91l6yxaKTE1XDgu23/gWrHO52O9LOjVqbRlBlfQ1KZPkPiShqCHlB
D1MynUKUjj9wSLcJloSGnL3wI/FqcuyY8pBauAA6H+jRSlsERZWLq0KF63V3MS+P
o5+nCbYbdJpMa8qt2857ypUPPiR0ezHzzcTPmc0vIbEb6e73jdwLI8M7zRyNNyJY
m/fi7JRgJecE2TpAsGmyWv3XwqTFBgt31m+S6fJLjmy6kJPAEjuj9P8KprHZEvk6
+nDcj+QUBeVbVU/FS71dl4C4MzkOxQdwnWJ8scTJYZ3MG7XQ7GfHQbdflj4pfK4q
222pVQDZhi0VOx5UOBA1FN1oSpP25u0sreZ0wT0gMp1mMeB6X0UDmetRKocZKP+G
GZtkeZEjCKPfMd1cCKvCIqMET7LUi05yPHc5Cohd+hMjdnf9gFdDb9mNTVZLYV5A
Kl/eQBaXZ6ux8/GJ6/+oGeRIQPaWVreSQ0EekbkFoMTG/FSqxyd8+ltxX4sH4XWK
MuUpGncY0HSLupl/RYwmP3i7tofITBMcv7uqUXn6RqKDjrr4+uRE+hrVXUmVne3G
jb4UDKlopNoFN7psgT4xJVrjb8kpxA+RalpySGwAASI8hSM973M=
=huAt
-----END PGP SIGNATURE-----

--n4s8AVajicg7iYKj--
