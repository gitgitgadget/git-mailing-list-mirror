Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dv16IuwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgaqq+LQ"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451810D1
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 02:18:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 450935C0159;
	Thu, 30 Nov 2023 05:18:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 Nov 2023 05:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701339505; x=1701425905; bh=Os
	cYJFUyjVYI5ugFSgLH/nY+voiDA5M/TxxjDYuhBXk=; b=dv16IuwDhbOr3e/mDz
	J7Ig6iaE2uVfvng7kqJ2ccL9zSnCFJIuxEe/Wm1Sx7rhiRR8mkfnPmFDDRzYbEKm
	MJPOcpx26K3wI7hnhRYBGwZhjKfSwl6CV/m7PHbSPPcrsvfKdFcifLzCpujA5MIa
	wCTbntgVrNjbnHwdhVPop5dcF8hSLFiFcyjHtSabJTRBen9SUGJAVzSr8u0o4ukS
	RLfyFjQnAaa2EWm9BX9w6loufNyKdgwnLrGGW/GZo6aGMmLlv90blA5hx9RMj+Je
	gi1u8HUu2SmWdicooCfrFpjVkVI41Az0ZSuC1DF/2Mkg5Tt4xTBkJfczWFvfdJaS
	2ykA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701339505; x=1701425905; bh=OscYJFUyjVYI5
	ugFSgLH/nY+voiDA5M/TxxjDYuhBXk=; b=jgaqq+LQH8tIEod/5JDsViA5ky/Jj
	OYKYCAYtaPqn7c/5Zb6uRicv4aX51A5pZis2qEXxp8oLwu6//J0op57jGEXBaqjp
	D9JbHySN09taMn3nsv7vWxJhPvi0PgM84zdbKYDvjPnt1F/Dsj83dP4IyDucbR3k
	+TdXE45/ZXWKujVFlmffooXzNOpZm0jdI6Tp1uJCSalElmZVPvKShKZQb5ONQmwj
	X0bfp2uwYDnRnuHmsJ9YQpXV1xaYwr8UiD1tdn5l4rUIbJKKbYAVZ09zC1M1P2B9
	NuZQUyPZEFOWky88UbJTqIQKzLzj4tbVmDc93pajnE/Kk3OToDnTGazYQ==
X-ME-Sender: <xms:cGFoZe4a_464-Irzr1KqhSDH-l0NjoKuaXHrTygVpfsUunU8wN6wMw>
    <xme:cGFoZX5nLpRKqFcGFG-90G6sQHV-1kGZyVXkVO1mHMMX7wfW3_-I2p07f8Vw-_Q0V
    gdhQtLjP22-Jgbyeg>
X-ME-Received: <xmr:cGFoZdecRWxX3uHq2AJ_Ap2Z63PVmsvk20r1Ga66XTmzR3mGfPqi_a1eUXebH4kuz6eqqSehFC4lod-W9ZRxZTzem50cKx67mLWmjS4T0s2c7noy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cGFoZbJdpPFP3T1MWZL51p_H0n33RyOd34S1awLRkbpxfNNRSvde5g>
    <xmx:cGFoZSKVhYe6goVYC34G7K4IiXzw_uPeAEALsjU6lu2bRJwpR78z-g>
    <xmx:cGFoZcynGzBYf4u84hATwPW8et_UYizfYEx-nNtMCnIBggrMtV2gDg>
    <xmx:cWFoZZVkjdg3Ghh58vpDO74Gx_hm7M6UhAq-2rIDNzAqPVbnhVtIog>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 05:18:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f2a953d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Nov 2023 10:17:08 +0000 (UTC)
Date: Thu, 30 Nov 2023 11:18:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZWhha2h2zzZWCXrw@tanuki>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Oo/QZ08F8GpU/VO"
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>


--0Oo/QZ08F8GpU/VO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 02:07:54PM -0500, Taylor Blau wrote:
> Back in fff42755ef (pack-bitmap: add support for bitmap indexes,
> 2013-12-21), we added support for reachability bitmaps, and taught
> pack-objects how to reuse verbatim chunks from the bitmapped pack. When
> multi-pack bitmaps were introduced, this pack-reuse mechanism evolved to
> use the MIDX's "preferred" pack as the source for verbatim reuse.
>=20
> This allows repositories to incrementally repack themselves (e.g., using
> a `--geometric` repack), storing the result in a MIDX, and generating a
> corresponding bitmap. This keeps our bitmap coverage up-to-date, while
> maintaining a relatively small number of packs.
>=20
> However, it is recommended (and matches what we do in production at
> GitHub) that repositories repack themselves all-into-one, and
> generate a corresponding single-pack reachability bitmap. This is done
> for a couple of reasons, but the most relevant one to this series is
> that it enables us to perform verbatim pack-reuse over a complete copy
> of the repository, since the entire repository resides in a single pack
> (and thus is eligible for verbatim pack-reuse).
>=20
> As repositories grow larger, packing their contents into a single pack
> becomes less feasible. This series extends the pack-reuse mechanism to
> operate over multiple packs which are known ahead of time to be disjoint
> with respect to one another's set of objects.
>=20
> The implementation has a few components:
>=20
>   - A new MIDX chunk called "Disjoint packfiles" or DISP is introduced
>     to keep track of the bitmap position, number of objects, and
>     disjointed-ness for each pack contained in the MIDX.
>=20
>   - A new mode for `git multi-pack-index write --stdin-packs` that
>     allows specifying disjoint packs, as well as a new option
>     `--retain-disjoint` which preserves the set of existing disjoint
>     packs in the new MIDX.
>=20
>   - A new pack-objects mode `--ignore-disjoint`, which produces packs
>     which are disjoint with respect to the current set of disjoint packs
>     (i.e. it discards any objects from the packing list which appear in
>     any of the known-disjoint packs).
>=20
>   - A new repack mode, `--extend-disjoint` which causes any new pack(s)
>     which are generated to be disjoint with respect to the set of packs
>     currently marked as disjoint, minus any pack(s) which are about to
>     be deleted.
>=20
> With all of that in place, the patch series then rewrites all of the
> pack-reuse functions in terms of the new `bitmapped_pack` structure.
> Once we have dropped all of the assumptions stemming from only
> performing pack-reuse over a single candidate pack, we can then enable
> reuse over all of the disjoint packs.
>=20
> In addition to the many new tests in t5332 added by that series, I tried
> to simulate a "real world" test on git.git by breaking the repository
> into chunks of 1,000 commits (plus their set of reachable objects not
> reachable from earlier chunk(s)) and packing those chunks. This produces
> a large number of packs with the objects from git.git which are known to
> be disjoint with respect to one another.
>=20
>     $ git clone git@github.com:git/git.git base
>=20
>     $ cd base
>     $ mv .git/objects/pack/pack-*.idx{,.bak}
>     $ git unpack-objects <.git/objects/pack/pack-*.pack
>=20
>     # pack the objects from each successive block of 1k commits
>     $ for rev in $(git rev-list --all | awk '(NR) % 1000 =3D=3D 0' | tac)
>       do
>         echo $rev |
>         git.compile pack-objects --revs --unpacked .git/objects/pack/pack=
 || return 1
>       done
>     # and grab any stragglers, pruning the unpacked objects
>     $ git repack -d
>     I then constructed a MIDX and corresponding bitmap
>=20
>     $ find_pack () {
>         for idx in .git/objects/pack/pack-*.idx
>         do
>           git show-index <$idx | grep -q "$1" && basename $idx
>         done
>       }
>     $ preferred=3D"$(find_pack $(git rev-parse HEAD))"
>=20
>     $ ( cd .git/objects/pack && ls -1 *.idx ) | sed -e 's/^/+/g' |
>         git.compile multi-pack-index write --bitmap --stdin-packs \
>           --preferred-pack=3D$preferred
>     $ git for-each-ref --format=3D'%(objectname)' refs/heads refs/tags >in
>=20
> With all of that in place, I was able to produce a significant speed-up
> by reusing objects from multiple packs:
>=20
>     $ hyperfine -L v single,multi -n '{v}-pack reuse' 'git.compile -c pac=
k.allowPackReuse=3D{v} pack-objects --revs --stdout --use-bitmap-index --de=
lta-base-offset <in >/dev/null'
>     Benchmark 1: single-pack reuse
>       Time (mean =C2=B1 =CF=83):      6.094 s =C2=B1  0.023 s    [User: 4=
3.723 s, System: 0.358 s]
>       Range (min =E2=80=A6 max):    6.063 s =E2=80=A6  6.126 s    10 runs
>=20
>     Benchmark 2: multi-pack reuse
>       Time (mean =C2=B1 =CF=83):     906.5 ms =C2=B1   3.2 ms    [User: 1=
081.5 ms, System: 30.9 ms]
>       Range (min =E2=80=A6 max):   903.5 ms =E2=80=A6 912.7 ms    10 runs
>=20
>     Summary
>       multi-pack reuse ran
>         6.72 =C2=B1 0.03 times faster than single-pack reuse
>=20
> (There are corresponding tests in p5332 that test different sized chunks
> and measure the runtime performance as well as resulting pack size).
>=20
> Performing verbatim pack reuse naturally trades off between CPU time and
> the resulting pack size. In the above example, the single-pack reuse
> case produces a clone size of ~194 MB on my machine, while the
> multi-pack reuse case produces a clone size closer to ~266 MB, which is
> a ~37% increase in clone size.

Quite exciting, and a tradeoff that may be worth it for Git hosters. I
expect that this is going to be an extreme example of the benefits
provided by your patch series -- do you by any chance also have "real"
numbers that make it possible to quantify the effect a bit better?

No worry if you don't, I'm just curious.

> I think there is still some opportunity to close this gap, since the
> "packing" strategy here is extremely naive. In a production setting, I'm
> sure that there are more well thought out repacking strategies that
> would produce more similar clone sizes.
>=20
> I considered breaking this series up into smaller chunks, but was
> unsatisfied with the result. Since this series is rather large, if you
> have alternate suggestions on better ways to structure this, please let
> me know.

The series is indeed very involved to review. I only made it up to patch
8/24 and already spent quite some time on it. So I'd certainly welcome
it if this was split up into smaller parts, but don't have a suggestion
as to how this should be done (also because I didn't yet read the other
16 patches).

I'll review the remaining patches at a later point in time.

Patrick

> Thanks in advance for your review!
>=20
> Taylor Blau (24):
>   pack-objects: free packing_data in more places
>   pack-bitmap-write: deep-clear the `bb_commit` slab
>   pack-bitmap: plug leak in find_objects()
>   midx: factor out `fill_pack_info()`
>   midx: implement `DISP` chunk
>   midx: implement `midx_locate_pack()`
>   midx: implement `--retain-disjoint` mode
>   pack-objects: implement `--ignore-disjoint` mode
>   repack: implement `--extend-disjoint` mode
>   pack-bitmap: pass `bitmapped_pack` struct to pack-reuse functions
>   pack-bitmap: simplify `reuse_partial_packfile_from_bitmap()` signature
>   pack-bitmap: return multiple packs via
>     `reuse_partial_packfile_from_bitmap()`
>   pack-objects: parameterize pack-reuse routines over a single pack
>   pack-objects: keep track of `pack_start` for each reuse pack
>   pack-objects: pass `bitmapped_pack`'s to pack-reuse functions
>   pack-objects: prepare `write_reused_pack()` for multi-pack reuse
>   pack-objects: prepare `write_reused_pack_verbatim()` for multi-pack
>     reuse
>   pack-objects: include number of packs reused in output
>   pack-bitmap: prepare to mark objects from multiple packs for reuse
>   pack-objects: add tracing for various packfile metrics
>   t/test-lib-functions.sh: implement `test_trace2_data` helper
>   pack-objects: allow setting `pack.allowPackReuse` to "single"
>   pack-bitmap: reuse objects from all disjoint packs
>   t/perf: add performance tests for multi-pack reuse
>=20
>  Documentation/config/pack.txt          |   8 +-
>  Documentation/git-multi-pack-index.txt |  12 ++
>  Documentation/git-pack-objects.txt     |   8 +
>  Documentation/git-repack.txt           |  12 ++
>  Documentation/gitformat-pack.txt       | 109 ++++++++++
>  builtin/multi-pack-index.c             |  13 +-
>  builtin/pack-objects.c                 | 200 +++++++++++++++----
>  builtin/repack.c                       |  57 +++++-
>  midx.c                                 | 218 +++++++++++++++++---
>  midx.h                                 |  11 +-
>  pack-bitmap-write.c                    |   9 +-
>  pack-bitmap.c                          | 265 ++++++++++++++++++++-----
>  pack-bitmap.h                          |  18 +-
>  pack-objects.c                         |  15 ++
>  pack-objects.h                         |   1 +
>  t/helper/test-read-midx.c              |  31 ++-
>  t/lib-disjoint.sh                      |  49 +++++
>  t/perf/p5332-multi-pack-reuse.sh       |  81 ++++++++
>  t/t5319-multi-pack-index.sh            | 140 +++++++++++++
>  t/t5331-pack-objects-stdin.sh          | 156 +++++++++++++++
>  t/t5332-multi-pack-reuse.sh            | 219 ++++++++++++++++++++
>  t/t6113-rev-list-bitmap-filters.sh     |   2 +
>  t/t7700-repack.sh                      |   4 +-
>  t/t7705-repack-extend-disjoint.sh      | 142 +++++++++++++
>  t/test-lib-functions.sh                |  14 ++
>  25 files changed, 1650 insertions(+), 144 deletions(-)
>  create mode 100644 t/lib-disjoint.sh
>  create mode 100755 t/perf/p5332-multi-pack-reuse.sh
>  create mode 100755 t/t5332-multi-pack-reuse.sh
>  create mode 100755 t/t7705-repack-extend-disjoint.sh
>=20
>=20
> base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
> --=20
> 2.43.0.24.g980b318f98

--0Oo/QZ08F8GpU/VO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVoYWoACgkQVbJhu7ck
PpQeDQ/8D9bCCmny/UAH6s3G8qxFYGIiQoB2DkNVd8YFqzwYaKNVTYOfIrW3Vu4q
BT9DYmBwwnbsjAO7Se0r4n1BY+i0GitsPKyetbE17+PYXS/Ht9+QTAerdhumtYrW
kpYotcM5iomeqvzPS+zfYNfaWs9avP0Y9248mmj4JJpdKHwKX5vngob964bIfgSD
D4CAHBaTkhpT6NHP3qOVtOB0zVwdPm0KMRLT+P+/xLBXJcKDQHHh+QhO/Ysn5ZbU
EgMoOEmVAGHZyNwPbplCiYg2UfV6zElrzTzM4NxY4B4RYmqJ+NNtLAO6htkQhmt2
VDu3bd2il+EGCt1rQl2tcIYjRI/MSIPeBQFkLmZjH+03G+4G/U315aZbIXZ0Pf45
r6sn9jDUND3WCJpZ2RQHhEZWtJbkhTe+DlT5jQo/4VbrtBA7r2y+nAPEFRzGv3Hn
y7kwuwDg9Zv83bkIobhZ2gSC7g9KwNeX6GlgD4LalQAC6Z63+dx2ZtINqNNNkTiY
BRO0H/IZ+smXZFx1Bbgc1l+WmGnH/T/TIcgMpRPRoOUR2iWaCFShBm3G515yx6K5
Yz6M5mv/nR5UXti+chVgnalptYGA+NtkLQ44NBjlMoPT1pBhaPKS4j2NS+kmV999
9qj/YmlsmopEjf1tyPtalDbahyQZFG6h/F0cN4RCi0iIcsZF3io=
=d6Ng
-----END PGP SIGNATURE-----

--0Oo/QZ08F8GpU/VO--
