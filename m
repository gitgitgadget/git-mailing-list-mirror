Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gbh0loAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQv6A0KH"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873BD1B6
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 05:53:57 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 56C095C00FB;
	Thu, 23 Nov 2023 08:53:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Nov 2023 08:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1700747634; x=1700834034; bh=rg
	o0wPck0n0qFmKN1q5rn+XP9afpuqcXy+JToe9pC/0=; b=gbh0loAa2rn6w/wEHF
	jzdygIF07vjRYSsmXdigAzj34MGOvi84OL8fpXmqfdnfmSnOWlc9zbdE+Hi9BNGw
	HPJHNEHWZw7nBV4TKbecgWFlhfRExs/mR8m+FR/DmC9FWFFinNY/4LRyHFWnMMi1
	ziX79D4E77JAixq8uFvqHFwVZ14r1DxqEvzK6uzrGXbxHEBjH53jG3BeAzH1BENa
	AwGe5MXDoKt+jlpKhczH4uwG9dTXukE3LlxXglX8iukkvvEtp2sIlj3l61B2Xt+f
	6TmtvoO2OBV0Ac3P791kyYPIYzR/st6tMd7y4bbgijrd//eCPMt7EuEjbV5DZM37
	OQiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700747634; x=1700834034; bh=rgo0wPck0n0qF
	mKN1q5rn+XP9afpuqcXy+JToe9pC/0=; b=gQv6A0KHtpO16RCHoPqn/bAXvJGaL
	ImKgFKNVyxed3F8WmMLqt4wBlmxwbiN1MkN4yD/43awbeLq00oGxSccqIp8wqRAo
	MoXTNffnwNWgBCbXXN8j2nR+Yi5kA3QDLDTeEKBEPdcpOgkhSF+bKX392xJ/pO89
	yspUTrpBQ8iItx6kOxg4fJpVcECtFGO1Ja+/xeEhX6uvkinQSjVSBgug+3iSuFRQ
	9Ilp3mfn+XmtZKaaB2FD8qM36ng3quG5o/GprYYQZbU1Qyd7+ydZv3SxE99tvBsb
	gJrfBoCFEBr8N7Y910vxEE+XpHt0ihLnWSGf+NGENOhqWxdenRN462mkA==
X-ME-Sender: <xms:cVlfZdQq9fKd-U5Gj7E2pBdHJsJAzi5w3ecSNEJJ6W3NNBn6fO0jPg>
    <xme:cVlfZWzQQ1JmgmOVb2Lxa1yipnwgrKrhq4gdDutt_0Zrq7YRnG3xvqc7sDofMA35l
    s6DQjl6tJY3rA4Jww>
X-ME-Received: <xmr:cVlfZS0eEbeM-4bikmZjmH2j16z_QihNfU6lbacG_iBtzoDrkVvdCROtQF8t7FHIwcW8rw2B8VU6eG97DCvRwg71N8CUOsw6XTuIcbS2Ha8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cVlfZVCzxW_PowW_1Eqvnh_Gp0DmeS4Clbh_xegQjYXOXQRbO8KHVA>
    <xmx:cVlfZWj9SiBOYrxCyZSavkP6B27yMTO80eRX5rlx-wHr8NlOQl8NxQ>
    <xmx:cVlfZZrxX2wNIhiT9IkSNwEzkCpw-5fv1rLwJOVxjzmk1299mnKq3A>
    <xmx:cllfZXswVwYNreh7apCS-reVxXDGIRMddrzyGw0VtcVw_aVzWYywdQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Nov 2023 08:53:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 893c3ae1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 Nov 2023 13:52:52 +0000 (UTC)
Date: Thu, 23 Nov 2023 14:53:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] object-name: reject too-deep recursive ancestor queries
Message-ID: <ZV9Za7iCL6WiE-Py@tanuki>
References: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6xoqBrJ2riVAdIZs"
Content-Disposition: inline
In-Reply-To: <57c0b30ddfe7c0ae78069682ff8454791e54469f.1700496801.git.me@ttaylorr.com>


--6xoqBrJ2riVAdIZs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 11:13:45AM -0500, Taylor Blau wrote:
> When trying to resolve a revision query like "HEAD~~~~~", our call
> pattern looks something like:
>=20
>   - object-name.c::get_oid_with_context()
>   - object-name.c::get_oid_1()
>   - object-name.c::get_nth_ancestor()
>   - object-name.c::get_oid_1()
>   - ...
>=20
> With `get_nth_ancestor()` and `get_oid_1()` mutually recurring, popping
> one '~' off of the revision query for each round of the recursion.

One thing I noticed just now is that we have exactly the same problem
with `^`, just with a different callstack. This problem isn't yet
addressed by your patch.

I have to wonder whether we should tighten restrictions even further:
instead of manually keeping track of how deep in the stack we are, we
limit the length of revisions to at most 1MB. I would claim that this
limit is sufficiently large to never be a problem in practice. Revisions
are limited to 4kB on most platforms anyway due to the maximum path
length. And if somebody really wants to request the (1024 * 1024) + 1th
parent, they shouldn't do that by appending this many "~" or "^" chars,
but instead they should ask for "~1048577" or "^1048577".

I realize that this is much more restrictive than the current patch. But
it would be a good defensive mechanism against all kinds of weird revs,
and I am very certain that there are other ways to blow the stack or
cause out-of-bounds reads or writes here.

Patrick

> Since this recursive behavior is unbounded, having too many "~"'s
> contained in a revision query will cause us to blow the stack.
> Generating a message like this when compiled under SANITIZE=3Daddress:
>=20
>     $ valgrind git rev-parse "HEAD$(perl -e "print \"~\" x 1000000000000"=
)"
>     =3D=3D597453=3D=3D Memcheck, a memory error detector
>     =3D=3D597453=3D=3D Copyright (C) 2002-2022, and GNU GPL'd, by Julian =
Seward et al.
>     =3D=3D597453=3D=3D Using Valgrind-3.19.0 and LibVEX; rerun with -h fo=
r copyright info
>     =3D=3D597453=3D=3D Command: /home/ttaylorr/local/bin/git.compile diff=
 HEAD~~~~~~~~~~~~[...]
>     =3D=3D597453=3D=3D
>     AddressSanitizer:DEADLYSIGNAL
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     =3D=3D597453=3D=3DERROR: AddressSanitizer: stack-overflow on address =
0x7fffdd838ff8 (pc 0x7f2726082748 bp 0x7fffdd839110 sp 0x7fffdd839000 T0)
>         #0 0x7f2726082748 in __asan::GetTLSFakeStack() ../../../../src/li=
bsanitizer/asan/asan_fake_stack.cpp:176
>         #1 0x7f2726082748 in GetFakeStackFast ../../../../src/libsanitize=
r/asan/asan_fake_stack.cpp:193
>         #2 0x7f27260833de in OnMalloc ../../../../src/libsanitizer/asan/a=
san_fake_stack.cpp:207
>         #3 0x7f27260833de in __asan_stack_malloc_1 ../../../../src/libsan=
itizer/asan/asan_fake_stack.cpp:256
>         #4 0x563f9077d9d8 in get_nth_ancestor /home/ttaylorr/src/git/obje=
ct-name.c:1087
>         #5 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-name=
=2Ec:1295
>         #6 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/obje=
ct-name.c:1092
>         #7 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-name=
=2Ec:1295
>         #8 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/obje=
ct-name.c:1092
>         [...]
>         #247 0x563f9077e957 in get_oid_1 /home/ttaylorr/src/git/object-na=
me.c:1295
>         #248 0x563f9077da64 in get_nth_ancestor /home/ttaylorr/src/git/ob=
ject-name.c:1092
>=20
>     SUMMARY: AddressSanitizer: stack-overflow ../../../../src/libsanitize=
r/asan/asan_fake_stack.cpp:176 in __asan::GetTLSFakeStack()
>     =3D=3D597453=3D=3DABORTING
>=20
> (Note that the actual stack is much deeper. GDB reports that the bottom
> of the stack looks something like the following):
>=20
>     #54866 0x0000555555c6d3bf in get_oid_with_context_1 (repo=3D0x5555563=
849a0 <the_repo>, name=3D0x7fffffff4be5 "HEAD", '~' <repeats 196 times>...,=
 flags=3D128, prefix=3D0x0, oid=3D0x7ffff5713d40, oc=3D0x7ffff5713d90) at o=
bject-name.c:1947
>     #54867 0x0000555555c6e2fa in get_oid_with_context (repo=3D0x555556384=
9a0 <the_repo>, str=3D0x7fffffff4be5 "HEAD", '~' <repeats 196 times>..., fl=
ags=3D128, oid=3D0x7ffff5713d40, oc=3D0x7ffff5713d90) at object-name.c:2096
>     #54868 0x0000555555d8eed8 in handle_revision_arg_1 (arg_=3D0x7fffffff=
4be5 "HEAD", '~' <repeats 196 times>..., revs=3D0x7ffff5b000d0, flags=3D0, =
revarg_opt=3D0) at revision.c:2174
>     #54869 0x0000555555d8f1a9 in handle_revision_arg (arg=3D0x7fffffff4be=
5 "HEAD", '~' <repeats 196 times>..., revs=3D0x7ffff5b000d0, flags=3D0, rev=
arg_opt=3D0) at revision.c:2189
>     #54870 0x0000555555d97ca9 in setup_revisions (argc=3D2, argv=3D0x7fff=
ffff4970, revs=3D0x7ffff5b000d0, opt=3D0x0) at revision.c:2932
>     #54871 0x00005555557d6a63 in cmd_diff (argc=3D2, argv=3D0x7fffffff497=
0, prefix=3D0x0) at builtin/diff.c:502
>     #54872 0x00005555557367bf in run_builtin (p=3D0x5555561c4c30 <command=
s+816>, argc=3D2, argv=3D0x7fffffff4970) at git.c:469
>     #54873 0x000055555573716b in handle_builtin (argc=3D2, argv=3D0x7ffff=
fff4970) at git.c:723
>     #54874 0x000055555573785a in run_argv (argcp=3D0x7ffff56028b0, argv=
=3D0x7ffff56028e0) at git.c:787
>     #54875 0x0000555555738626 in cmd_main (argc=3D2, argv=3D0x7fffffff497=
0) at git.c:922
>     #54876 0x00005555559d3fdd in main (argc=3D3, argv=3D0x7fffffff4968) a=
t common-main.c:62
>=20
> Fortunately, we can impose a limit on the maximum recursion depth we're
> willing to accept when resolving queries like the above without
> significantly impeding users. This patch sets the limit at 4096, though
> we could probably increase that limit depending on the size of each
> frame.
>=20
> The limit introduced here is large enough that any reasonable query
> should still run to completion, but small enough that if the frame size
> were to significantly increase, our protection would still be effective.
>=20
> The change here is straightforward: each call to get_nth_ancestor()
> increases a counter, and then decrements that counter before returning.
>=20
> The diff is a little noisy since there are a handful of return paths
> from `get_nth_ancestor()`, all of which need to decrement the depth
> variable.
>=20
> Since this is a local-only exploit, a user would have to be tricked into
> running such a query by an adversary. Even if they were successfully
> tricked into running the malicious query, the blast radius is limited to
> a local stack overflow, which does not have meaningful paths to remote
> code execution, arbitrary memory reads, or any more grave security
> concerns.
>=20
> Reported-by: Carlos Andr=E9s Ram=EDrez Cata=F1o <antaigroupltda@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  object-name.c                  | 26 ++++++++++++++++++++------
>  t/t1506-rev-parse-diagnosis.sh |  5 +++++
>  2 files changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/object-name.c b/object-name.c
> index 0bfa29dbbf..675e0a759e 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1080,6 +1080,9 @@ static enum get_oid_result get_parent(struct reposi=
tory *r,
>  	return MISSING_OBJECT;
>  }
> =20
> +static int get_nth_ancestor_max_depth =3D 4096;
> +static int get_nth_ancestor_curr_depth;
> +
>  static enum get_oid_result get_nth_ancestor(struct repository *r,
>  					    const char *name, int len,
>  					    struct object_id *result,
> @@ -1089,20 +1092,31 @@ static enum get_oid_result get_nth_ancestor(struc=
t repository *r,
>  	struct commit *commit;
>  	int ret;
> =20
> +	if (++get_nth_ancestor_curr_depth > get_nth_ancestor_max_depth)
> +		 return error(_("exceeded maximum ancestor depth"));
> +
>  	ret =3D get_oid_1(r, name, len, &oid, GET_OID_COMMITTISH);
>  	if (ret)
> -		return ret;
> +		goto done;
>  	commit =3D lookup_commit_reference(r, &oid);
> -	if (!commit)
> -		return MISSING_OBJECT;
> +	if (!commit) {
> +		ret =3D MISSING_OBJECT;
> +		goto done;
> +	}
> =20
>  	while (generation--) {
> -		if (repo_parse_commit(r, commit) || !commit->parents)
> -			return MISSING_OBJECT;
> +		if (repo_parse_commit(r, commit) || !commit->parents) {
> +			ret =3D MISSING_OBJECT;
> +			goto done;
> +		}
>  		commit =3D commit->parents->item;
>  	}
>  	oidcpy(result, &commit->object.oid);
> -	return FOUND;
> +
> +	ret =3D FOUND;
> +done:
> +	get_nth_ancestor_curr_depth--;
> +	return ret;
>  }
> =20
>  struct object *repo_peel_to_type(struct repository *r, const char *name,=
 int namelen,
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis=
=2Esh
> index ef40511d89..b3b9f6c8c5 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -244,6 +244,11 @@ test_expect_success 'reject Nth ancestor if N is too=
 high' '
>  	test_must_fail git rev-parse HEAD~100000000000000000000000000000000
>  '
> =20
> +test_expect_success 'reject too-deep recursive ancestor queries' '
> +	test_must_fail git rev-parse "HEAD$(perl -e "print \"~\" x 4097")" 2>er=
r &&
> +	grep "error: exceeded maximum ancestor depth" err
> +'
> +
>  test_expect_success 'pathspecs with wildcards are not ambiguous' '
>  	echo "*.c" >expect &&
>  	git rev-parse "*.c" >actual &&
>=20
> base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
> --=20
> 2.43.0.rc2.19.geadd45bf00

--6xoqBrJ2riVAdIZs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVfWWYACgkQVbJhu7ck
PpQdIxAAgq7R6dkJI0A18fwEVX5z2MeKTUKHBuw82W9u8ICYVyiNplMmIp09DsXm
SOcN1ruIMMrs/l4XG14Jm78oCwjxVFG+iZ0rDzAdQLXcbYNmuGsMqYKOWHIBMWb+
A4czB4r3mssht+9VHBgq5MnqQFv+l6sxJfmRbRfbChTWjmQ8g6IQLq8d/VXLmAh+
43lwJtDb5haIGapikan2mknHf0TvPPLxNuyah3yKYXN9wfBed4rCUwbKkxdp5HNf
lKcCT7UCoE5b6VFbYkm9Ixd71e+/qyQUyH7/WZmN0HcEHbsLAyyJW7xzpUda0JIK
vKYInIXfz4zV2ReGvxiZ/EYsp09629XlmyQREb0aVliwsQFJtfBesbBLP26410Mh
6eQkHkH3fQFz7g79AlhGc1iWXZLsBwV6XAquFqtRDiojLRCPP2AcJ3bY78YSADoC
Lh29QsK6agd5KfrgNGhZBf04zvUHh96utP8byKxwep1GJ329TB3B8Fs9lnRVF59r
IwFtdUYyOa9I//Say1En/Eh87PaWj3kg35p6JpghB7jIbkvp3rRtn91nMZcWTcBI
IbJ9qCJ6ZSF6VzN60J/iG9z+H+0dJmqUDyJepJCBm3CKyosvXeyfV7voqMe7+RMu
GvDQ5CKXz404r04UeDTptPgPDtMaQGdwAg6JQD3Rh9U5HkcC3SQ=
=Vqvq
-----END PGP SIGNATURE-----

--6xoqBrJ2riVAdIZs--
