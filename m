Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761683;
	b=o7XnKxZAq31f11G2d35NkNWAPURWni92u1eMpuAQwG2qVLtBzG7fgfVh8+qnZ5QLlcNc
	 7xjBO4Wr7D3hKyIr4kS0DcNvllRskeFY2FX0zNGdyZniYoJzoa9m9j1ZTroc5a+eb8rX0
	 7zRPMhHS7CEotTOvtoC89ikLjdx5mwElygwzCheeJ1HfjPKkuKU40de54UgBp2zhsThAp
	 yhDu8l2+zrvtYQ6mS2pmd/EDVtm6YcQs7Mq6oFZuDJasydrLRWZsU7igAbg0JqWP3zK6S
	 1ulG2Fz0lQefwBdv9TglXEYKtLalOtOlpRpBsC9tUJFU4d5RywUkWfbaIHD7f7UWCtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=k8AyR8ixJnRKu52/kyUZijzRrD4+6LqHnICUyaQmZp0=;
	b=raivmO19kdFnA7x4i0t81eF7HBzWD07a7/HKb8BCgDyF89rl/FgvG1pebUdZdOab4q6O
	 fI12NXgmCNutL8cV7urQccu+yrSYvZ3GwrfC6hFhI1L+007H6vAnVaxmVFdGmEbCNrqtf
	 5ymN38VFttXPiCupm9WNJJxllcmclrqJyrIBAUilsqJKux17qUUdpZD/mk6Mc1jLd2pI0
	 ELHzR3cpBTanrmbZd/Ye2QKUReUL6rl7UjD7xZirWpROOUk7xAtEeOA2c/La203dbb+20
	 T2MGX5BGMhj1L2R6TWjvkRFJ/9TDbeW7YJRC3EkhbwBAHczBE/3iCTXrs4SY8Q4Q59Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=IJJX8sxU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eH6gh9Iy;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCD606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FCD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=IJJX8sxU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eH6gh9Iy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E6661D001C1
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:21:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792761682;
	 x=1792848082; bh=k8AyR8ixJnRKu52/kyUZijzRrD4+6LqHnICUyaQmZp0=; b=
	IJJX8sxUcI+BwerWQSbhAGGV9a9M8tCfp22Sb00r8MS+PB5EplLC4ihS2GLjDI7J
	m9aG+huJOJpHshHmK7AwWqKQLkVg9aRh0F22J+v/fMcPSdmYPpz1uijKu1u6pXRL
	VDlMlBEVN4c9NnawdBd62F3qLNgn7p7PyT8+Icdg+N7PBk4gV0rznYS5vC3fVYt2
	iMVyGRotBtD8Xf8mqsDJAUUKmktODuSW0EnWyWVHvtJRNPepa90HkQedrmhOGtRT
	t7f4Ro+pXYqtSniBCp8ACd6+2SeFQI7rnDeFyI5h9ho+YDWKb89B7B6UPMijcKvy
	cqmNu764KS88cntCngquEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792761682; x=
	1792848082; bh=k8AyR8ixJnRKu52/kyUZijzRrD4+6LqHnICUyaQmZp0=; b=e
	H6gh9IyTPWeeeVLsvYqz6o5/av8n/T4Dp9duajyyrOGbUEn0+SwW/mYTQ8Hv6Nvc
	3xy4G8WZZe1BI0thz7NXx22jrKVg2vHYTC0u9ezGGeXzAIynpC7dNWTpGcXfUfeM
	qEwKW/ylPOI5ayaqMr8YAOaoD1O8LuOspUCoVcLiN0NYheNoSmZC4qehf+KpMmY5
	s3H/qmmShh5gnLWulNTO2mdtkqaOsWEJoDLjE1nx/Nx84Nq/x5EOL6L2WjrEnryf
	RpiCiwxw/mbeQMKNDWRj4ggxQ0YB+efhCs+lYSLLo83zn/OqH3d02kV4mp0nyLj9
	Cbk8iNjGc2LSH8bFwpnSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792761682; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qISvnJ3LMsEUjq6pGIb2lpGgjAlbq2HO+0fvgIQKdC3xcmw
	DOsNXfB7RkWsTD8uNrtadyEFdclbhLBSaXNGwBY9Ys0ZUqr0tZBaKCQ3vIl80+RD
	7VeyNWCLu/DKq7oSCNBuKGLUoGU8hrJF+BCexBqK+BzCg0axJ50WSnmdbf1yrzUu
	JONRr8ded5zW0nY6NiCIBT7sxjgdk6+TEhS2w7SB1MgJJD+1yGYxZuoM88daomQ2
	vXrI29pLfQHGZyQWX38i6bN2iQqxkbH58lZ2ysDCqW9OPqtBAhh/uglwCcAzKk6F
	mEGrWHUiam5j1uG4HibZ8wa1JkSCbeyYk9bzOcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:q6NT6LlZG55Qdiz9nQi+pjDoHb8htg6lrIasZ0vCWfY=:deGmu7PnK+5DBY7JgZjDQuR1P4a9XkvRZF1KwABnqAg=;
X-ME-Sender: <xms:UV_basR-DWnIX4BpgftgJXODn5Vu2GUvDBhLj43Vc_jR8pH3afR6mQ>
    <xme:UV_bagzSgRKd9cwGfZE5I_1R4zgqSzq897cnRe6uycCwgCsiaGZ2vCHVBNMVXOL4Y
    zurBJv1h3v0Q8fm4X0ZG80VEbFrGnpYiruHWrYMD9RN9K4ekKXBvxE>
X-ME-Received: <xmr:UV_bau1E9_wjgwmlVGIbIS6ygNfflVwWYrF6KjyV9NsrID-YQAycI3hQaul4tYif2alVlipL76MPHZBAdS8QzpNG81Kj27PGfACVY-hIOcPgHt5Dkp_k>
X-ME-Proxy-Cause: dmFkZTE/xSHHe1R87P16AXrQj6p36dT+vprU8ZL7ZOvfP/WgqB3QqRNw/T8Z1JovIYKqyJ
    wFR4NWvHAF0drdOWD6ZBTsJ90uQh0WhCbXod1df1bztEz+ZagmRmR0bg/GlkG4TLuaUJZA
    k+OmIJu5d5KAWF8eD2RACaxiq79eOkKUOXfpjW81ULdc6yboe5kkeOffNY2f9Q61VAUhTV
    StoqlvHdwa4j/nbIPtUltrGZvoXqiEwO+SiD6rluEQUKNCJBCfy2zSgpvussSC+IHfyaWE
    +ZkRK+TKnAZmn8ADbIMb7nGdaDkRT8R/CSXXPydzATJXsye7Ask8PUi6pB57DEXdRrlbXL
    ZpseU41ewFauROiRVxo/jsQfOnw0JR+MkR3jlYxsMHppfyfC1TtQOpkb9bsMjxGf2Lvh95
    qUKG/cNhCRGaAjGwAu/XXDQZeF4GNoLmWoYsKul9fGkBRkUHDhUL6xEHmi7ER5TbiAMbrL
    zndKWJ3YJNdIRrD+oXcU9E6dcfxZUOIEAjakNdJFeEIAaT3N/DMnpSA7V6uuzqfmim+yF8
    YBSOGz2yv6gyUEZhJ2PlKGi7NkCw6Dh8iGlcWcZfouLPeXNQbrxlKuscPuiEwdt7z9f4zs
    GmyYccyKcDsWtnaXxmYN1lIzDiA2939uHJuZyJokL3Oc23pA19p1PsO09T2A
X-ME-Proxy: <xmx:UV_bau5U0cazHSqFVXcBIAqxPfULbP3C6SYNykQ2_NNlVlTb3xLMAA>
    <xmx:UV_bahUzGBYdC4BFduv4lheqrPOOsIOQNNsaHkOSX_DAXySjRXGVJA>
    <xmx:UV_batDrJMKYWY_F9AJX7bK4U31UoktXNsD8kVhtB8AXG2JTX0Zabg>
    <xmx:UV_bag5bQCGZnikHynMASXQaSHKc_FLIGksklGuOdcP0f8BvU6BIHw>
    <xmx:Ul_baji4lOaC2erwuZOSnl92rZqj3QEEbe1RKDcdlMzns6C2kY-UiCF9>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 09:21:21 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 0/5] root refs vs pseudorefs
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <20261022212903.177261-1-andy.koppe@gmail.com>
Date: Fri, 23 Oct 2026 09:21:11 -0400
Cc: git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <93D20D7C-E19B-4A41-AC10-4AFC8330E844@jvns.ca>
References: <20261022212903.177261-1-andy.koppe@gmail.com>
To: Andy Koppe <andy.koppe@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Oct 22, 2026, at 5:28=E2=80=AFPM, Andy Koppe <andy.koppe@gmail.com> =
wrote:
>=20
> Since 993d57eded (refs: pseudorefs are no refs, 2024-05-15), the term
> "pseudoref" has been restricted to FETCH_HEAD and MERGE_HEAD, which =
are
> not stored in the ref backends, while other refs outside of "refs/",
> such as HEAD and ORIG_HEAD, are called root refs. However, a fair =
number
> of docs, comments, messages and tests still use "pseudoref" in its old
> sense. And while the glossary describes the rules for refs in the root
> of the hierarchy, it does not explicitly define the term, even though
> "git for-each-ref --include-root-refs" uses it.
>=20
> This series adds a "root ref" entry to the glossary and clarifies the
> "pseudoref" entry, and then replaces the outdated uses of "pseudoref" =
in
> docs, code and tests. While at it, it also updates the long outdated
> glossary entry for per-worktree refs, and fixes a few inaccuracies
> found along the way, for example about which refs get a reflog in
> git-update-ref(1) and core.logAllRefUpdates.
>=20
> I've left __git_pseudoref_exists() in the completion script alone =
apart
> from its comment, even though it's used for both pseudorefs and root
> refs. It could be renamed, keeping the old name as a deprecated =
wrapper
> like elsewhere in the script, but it's not obvious what to, because
> there is no term covering both.

> Andy Koppe (5):
>  doc: glossary: add root ref and clarify pseudorefs
>  doc: glossary: update per-worktree refs
>  doc: stop calling root refs pseudorefs
>  refs: stop calling root refs pseudorefs
>  t: stop calling root refs pseudorefs
>=20
> Documentation/config/core.adoc                |  2 +-
> Documentation/for-each-ref-options.adoc       |  2 +-
> Documentation/git-ls-remote.adoc              |  4 +-
> Documentation/git-update-ref.adoc             | 13 ++-
> Documentation/git-worktree.adoc               |  9 +-
> Documentation/glossary-content.adoc           | 86 ++++++++++++-------
> Documentation/rev-list-options.adoc           |  4 +-

I wonder if gitdatamodel.adoc should also cover pseudorefs and root refs
in the =E2=80=9CReferences=E2=80=9D section. Right now it only says =
something extremely
short on the topic:

  Git may also create references other than HEAD at the base of
  the hierarchy, like ORIG_HEAD.


> builtin/for-each-ref.c                        |  2 +-
> contrib/completion/git-completion.bash        |  7 +-
> refs.h                                        | 13 ++-
> revision.c                                    |  2 +-
> t/show-ref-exists-tests.sh                    |  4 +-
> t/t0600-reffiles-backend.sh                   |  2 +-
> t/t0610-reftable-basics.sh                    |  2 +-
> t/t1400-update-ref.sh                         | 66 +++++++-------
> t/t1403-show-ref.sh                           |  2 +-
> t/t1460-refs-migrate.sh                       |  4 +-
> t/t4013-diff-various.sh                       |  6 +-
> ...iff.diff-tree_--cc_--summary_REVERSE_HEAD} |  2 +-
> t/t6302-for-each-ref-filter.sh                |  4 +-
> t/t9902-completion.sh                         |  4 +-
> 21 files changed, 129 insertions(+), 111 deletions(-)
> rename t/t4013/{diff.diff-tree_--cc_--summary_REVERSE =3D> =
diff.diff-tree_--cc_--summary_REVERSE_HEAD} (73%)
>=20
>=20
> base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
> --=20
> 2.56.0
>=20
>=20

