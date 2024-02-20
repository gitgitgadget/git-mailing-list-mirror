Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395C5FBA6
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419985; cv=none; b=Ig6VQQGyKi1CEEr9iOfVEd9HpVojh6Ja8zX8aRGKNuDft+c0jyncg+38+2/FmNOUsHbUX1cLjyA4vs/BM2OPVwSP/qxHiHcyQGjAiFKHQepI5B1yblToKcpEoUD80oFFI4noEn5iEtfyBsW2Dqk+ISvXuTPAPQL80eZV8Pb2lB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419985; c=relaxed/simple;
	bh=c2z1tycJl3veF5glPK0TNchA6fzdOxC5368L8ALxvjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvsOT3HZ/BmCu3iOxRnmeRMJk05uN14njEnpJWUA9HHJWU0/XL6DH+sX49Rkwimy6cnQPxgYqq1rocvgOlA+q7udr55o88oROqC3b4RRSZXETFTuwNz2aG0MGU1FD1qaQHrHu6SP5ezqMPYxCN7lvnF4kxvDqC/Qmgg0DrDQGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UBxvtpBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qkzqk9FY; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UBxvtpBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qkzqk9FY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8BAF91800088;
	Tue, 20 Feb 2024 04:06:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 20 Feb 2024 04:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708419981; x=1708506381; bh=jZNjR/Ocwq
	GetQ0HzEflNd0xaxI3UoaNWd2avA9TDdc=; b=UBxvtpBc0/+0uXm/tkYQmd5z0V
	81nMz7rPhZ4NCyuwe7oJRjJ/vMCYDFDKn6+hB3nj00wT0vuNb9rVJ6wvS1pgT69+
	ZhrXzkG8DrIWuTMLBYMRtKSDidigTsKYg4yb2Xn4CNrtmMH7l45Af+I/n2DO/GKR
	eDkUAL39WMJqWUufoo/VCMGzD2Vm8FnmLWBZbKB7PZ8Jv/Nt7orMSyqmv08b9090
	xXy2IDGJV2pn3+Pg7o+KLB1EuHyhH7ozHSR8M1Fhq2uGZsKLjz//Ga4O5wgDdgNb
	SchMPCfpXGsY/rVHuPJMAJMUy6lwBzrXi+RBtv6i6zw+k0Lwv/F2yQ4LwkEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708419981; x=1708506381; bh=jZNjR/OcwqGetQ0HzEflNd0xaxI3
	UoaNWd2avA9TDdc=; b=Qkzqk9FY60pLNy6yu8n+qbCAyniKj/Ud9nGlMWhalIsD
	FOpgVL4XFIWX6V0siyKxIjH68/QAAhm2SrsnO1LCw00Ney4KVESsyCEkXxPLpMWO
	ZBI1v0j0VVzVDEPcqd7kcvVxY8eIrekrcEIjbEgUuExC/j0fiY3o4fIbdol/XrY4
	0wdNa1IogQyHZzX+T4TJwBHsUraJWtArHPYH1QO5gSwE8KXdiYWKFgVjb6SaPz1e
	pEkHhBcYTxV8/EVQFI2t7Ge7oxClzVDP9/FE4t7WIUwHHAXIRXq4MGgzKrqPoKJB
	OwwUfXWkqH7B1SwbLN0RjjPxB777NqLtaw3XvG7u3w==
X-ME-Sender: <xms:jGvUZdUDCYK1VObD7wuF_ahVsaIapmTiur8lWc4-LjKzE7yLOcudpw>
    <xme:jGvUZdkbmv0N70TcwyZDaqAGSvN3LLVfBqmEE1bOrxd7QMg3t5u0IelyalZpVyNsU
    XE8FID6IYAvqkG1Og>
X-ME-Received: <xmr:jGvUZZYpD0H8j-_pqkjmSWLLsqFtntHJz29BMCZ09AU0pFEeloHqHiHHW4k_Yuc8pP4x2op_NCnNTHMfDdTc9_rcDXYzbV1etAsP2EQV_ktWzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:jGvUZQXl_AFpe35GVoL98dOazbJeTfFBReu-EW1I14ghhFNuGJKzow>
    <xmx:jGvUZXnFT8Gp0fL_Xf0CmOrdENuRvEEtUbaQ1GbRXVEb-HmlOFvpsg>
    <xmx:jGvUZddm1HRt07fYK6gCZcHdIEQsNwW3U7hrRTVxIT0Ihmcc0sFg5Q>
    <xmx:jWvUZcyoNuX6KBDFM9Dxd_AyxmjgxbSSBG_vlOmYIQp49RSNBw9LgO-QL0U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05db12af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:16 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/7] reflog: introduce subcommand to list reflogs
Message-ID: <cover.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7RJ5foHdKWxKY38m"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--7RJ5foHdKWxKY38m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces a new `git
reflog list` subcommand to list available reflogs in a repository.

Changes compared to v1:

  - Patch 2: Clarified the commit message to hopefully explain better
    why a higher level implementation of reflog sorting would have
    increased latency.

  - Patch 2: Introduced a helper function that unifies the logic to
    yield the next directory entry.

  - Patch 3: Mark the merged reflog iterator as sorted, which I missed
    in my previous round.

  - Patch 4: This patch is new and simplifies the code to require all
    ref iterators to be sorted.

Junio, I noticed that you already merged v1 of this patch series to
`next`. I was a bit surprised to see it merged down this fast, so I
assume that this is only done due to the pending Git v2.44 release and
that you plan to reroll `next` anyway. I thus didn't send follow-up
patches but resent the whole patch series as v2. If I misinterpreted
your intent I'm happy to send the changes as follow-up patches instead.

The patch series continues to depend on ps/reftable-backend at
8a0bebdeae (refs/reftable: fix leak when copying reflog fails,
2024-02-08).

Thanks!

Patrick

Patrick Steinhardt (7):
  dir-iterator: pass name to `prepare_next_entry_data()` directly
  dir-iterator: support iteration in sorted order
  refs/files: sort reflogs returned by the reflog iterator
  refs: always treat iterators as ordered
  refs: drop unused params from the reflog iterator callback
  refs: stop resolving ref corresponding to reflogs
  builtin/reflog: introduce subcommand to list reflogs

 Documentation/git-reflog.txt   |   3 +
 builtin/fsck.c                 |   4 +-
 builtin/reflog.c               |  37 +++++++++++-
 dir-iterator.c                 | 105 ++++++++++++++++++++++++++++-----
 dir-iterator.h                 |   3 +
 refs.c                         |  27 ++++++---
 refs.h                         |  11 +++-
 refs/debug.c                   |   3 +-
 refs/files-backend.c           |  27 ++-------
 refs/iterator.c                |  26 +++-----
 refs/packed-backend.c          |   2 +-
 refs/ref-cache.c               |   2 +-
 refs/refs-internal.h           |  18 +-----
 refs/reftable-backend.c        |  20 ++-----
 revision.c                     |   4 +-
 t/helper/test-ref-store.c      |  18 ++++--
 t/t0600-reffiles-backend.sh    |  24 ++++----
 t/t1405-main-ref-store.sh      |   8 +--
 t/t1406-submodule-ref-store.sh |   8 +--
 t/t1410-reflog.sh              |  69 ++++++++++++++++++++++
 20 files changed, 286 insertions(+), 133 deletions(-)

Range-diff against v1:
1:  12de25dfe2 =3D 1:  12de25dfe2 dir-iterator: pass name to `prepare_next_=
entry_data()` directly
2:  8a588175db ! 2:  788afce189 dir-iterator: support iteration in sorted o=
rder
    @@ Commit message
         iterator to enumerate reflogs, returning reflog names and exposing=
 them
         to the user would inherit the indeterministic ordering. Naturally,=
 it
         would make for a terrible user interface to show a list with no
    -    discernible order. While this could be handled at a higher level b=
y the
    -    new subcommand itself by collecting and ordering the reflogs, this=
 would
    -    be inefficient and introduce latency when there are many reflogs.
    +    discernible order.
    +
    +    While this could be handled at a higher level by the new subcommand
    +    itself by collecting and ordering the reflogs, this would be ineff=
icient
    +    because we would first have to collect all reflogs before we can s=
ort
    +    them, which would introduce additional latency when there are many
    +    reflogs.
    =20
         Instead, introduce a new option into the directory iterator that a=
sks
         for its entries to be yielded in lexicographical order. If set, the
    -    iterator will read all directory entries greedily end sort them be=
fore
    +    iterator will read all directory entries greedily and sort them be=
fore
         we start to iterate over them.
    =20
         While this will of course also incur overhead as we cannot yield t=
he
    @@ dir-iterator.c
     =20
      struct dir_iterator_level {
      	DIR *dir;
    +=20
    ++	/*
    ++	 * The directory entries of the current level. This list will only be
    ++	 * populated when the iterator is ordered. In that case, `dir` will =
be
    ++	 * set to `NULL`.
    ++	 */
     +	struct string_list entries;
     +	size_t entries_idx;
    -=20
    ++
      	/*
      	 * The length of the directory part of path at this level
    + 	 * (including a trailing '/'):
    +@@ dir-iterator.c: struct dir_iterator_int {
    + 	unsigned int flags;
    + };
    +=20
    ++static int next_directory_entry(DIR *dir, const char *path,
    ++				struct dirent **out)
    ++{
    ++	struct dirent *de;
    ++
    ++repeat:
    ++	errno =3D 0;
    ++	de =3D readdir(dir);
    ++	if (!de) {
    ++		if (errno) {
    ++			warning_errno("error reading directory '%s'",
    ++				      path);
    ++			return -1;
    ++		}
    ++
    ++		return 1;
    ++	}
    ++
    ++	if (is_dot_or_dotdot(de->d_name))
    ++		goto repeat;
    ++
    ++	*out =3D de;
    ++	return 0;
    ++}
    ++
    + /*
    +  * Push a level in the iter stack and initialize it with information =
=66rom
    +  * the directory pointed by iter->base->path. It is assumed that this
     @@ dir-iterator.c: static int push_level(struct dir_iterator_int *iter)
      		return -1;
      	}
    @@ dir-iterator.c: static int push_level(struct dir_iterator_int *iter)
     +	 * directly.
     +	 */
     +	if (iter->flags & DIR_ITERATOR_SORTED) {
    -+		while (1) {
    -+			struct dirent *de;
    ++		struct dirent *de;
     +
    -+			errno =3D 0;
    -+			de =3D readdir(level->dir);
    -+			if (!de) {
    -+				if (errno && errno !=3D ENOENT) {
    -+					warning_errno("error reading directory '%s'",
    -+						      iter->base.path.buf);
    ++		while (1) {
    ++			int ret =3D next_directory_entry(level->dir, iter->base.path.buf, =
&de);
    ++			if (ret < 0) {
    ++				if (errno !=3D ENOENT &&
    ++				    iter->flags & DIR_ITERATOR_PEDANTIC)
     +					return -1;
    -+				}
    -+
    ++				continue;
    ++			} else if (ret > 0) {
     +				break;
     +			}
     +
    -+			if (is_dot_or_dotdot(de->d_name))
    -+				continue;
    -+
     +			string_list_append(&level->entries, de->d_name);
     +		}
     +		string_list_sort(&level->entries);
    @@ dir-iterator.c: static int pop_level(struct dir_iterator_int *iter)
      	return --iter->levels_nr;
      }
     @@ dir-iterator.c: int dir_iterator_advance(struct dir_iterator *dir_i=
terator)
    -=20
    - 	/* Loop until we find an entry that we can give back to the caller. =
*/
    - 	while (1) {
    --		struct dirent *de;
    + 		struct dirent *de;
      		struct dir_iterator_level *level =3D
      			&iter->levels[iter->levels_nr - 1];
    -+		struct dirent *de;
     +		const char *name;
     =20
      		strbuf_setlen(&iter->base.path, level->prefix_len);
     -		errno =3D 0;
     -		de =3D readdir(level->dir);
    --
    +=20
     -		if (!de) {
     -			if (errno) {
     -				warning_errno("error reading directory '%s'",
     -					      iter->base.path.buf);
    --				if (iter->flags & DIR_ITERATOR_PEDANTIC)
    --					goto error_out;
    ++		if (level->dir) {
    ++			int ret =3D next_directory_entry(level->dir, iter->base.path.buf, =
&de);
    ++			if (ret < 0) {
    + 				if (iter->flags & DIR_ITERATOR_PEDANTIC)
    + 					goto error_out;
     -			} else if (pop_level(iter) =3D=3D 0) {
     -				return dir_iterator_abort(dir_iterator);
    -+
    -+		if (level->dir) {
    -+			errno =3D 0;
    -+			de =3D readdir(level->dir);
    -+			if (!de) {
    -+				if (errno) {
    -+					warning_errno("error reading directory '%s'",
    -+						      iter->base.path.buf);
    -+					if (iter->flags & DIR_ITERATOR_PEDANTIC)
    -+						goto error_out;
    -+				} else if (pop_level(iter) =3D=3D 0) {
    ++				continue;
    ++			} else if (ret > 0) {
    ++				if (pop_level(iter) =3D=3D 0)
     +					return dir_iterator_abort(dir_iterator);
    -+				}
     +				continue;
      			}
     -			continue;
    @@ dir-iterator.c: int dir_iterator_advance(struct dir_iterator *dir_it=
erator)
     =20
     -		if (is_dot_or_dotdot(de->d_name))
     -			continue;
    -+			if (is_dot_or_dotdot(de->d_name))
    -+				continue;
    -=20
    --		if (prepare_next_entry_data(iter, de->d_name)) {
     +			name =3D de->d_name;
     +		} else {
     +			if (level->entries_idx >=3D level->entries.nr) {
    @@ dir-iterator.c: int dir_iterator_advance(struct dir_iterator *dir_it=
erator)
     +					return dir_iterator_abort(dir_iterator);
     +				continue;
     +			}
    -+
    +=20
    +-		if (prepare_next_entry_data(iter, de->d_name)) {
     +			name =3D level->entries.items[level->entries_idx++].string;
     +		}
     +
3:  e4e4fac05c ! 3:  32b24a3d4b refs/files: sort reflogs returned by the re=
flog iterator
    @@ refs/files-backend.c: static struct ref_iterator *reflog_iterator_be=
gin(struct r
      	iter->dir_iterator =3D diter;
      	iter->ref_store =3D ref_store;
      	strbuf_release(&sb);
    +@@ refs/files-backend.c: static struct ref_iterator *files_reflog_iter=
ator_begin(struct ref_store *ref_st
    + 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
    + 	} else {
    + 		return merge_ref_iterator_begin(
    +-			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
    ++			1, reflog_iterator_begin(ref_store, refs->base.gitdir),
    + 			reflog_iterator_begin(ref_store, refs->gitcommondir),
    + 			reflog_iterator_select, refs);
    + 	}
    =20
      ## t/t0600-reffiles-backend.sh ##
     @@ t/t0600-reffiles-backend.sh: test_expect_success 'for_each_reflog()=
' '
-:  ---------- > 4:  4254f23fd4 refs: always treat iterators as ordered
4:  be512ef268 ! 5:  240334df6c refs: drop unused params from the reflog it=
erator callback
    @@ refs/reftable-backend.c: static int reftable_reflog_iterator_advance=
(struct ref_
      	}
     @@ refs/reftable-backend.c: static struct reftable_reflog_iterator *re=
flog_iterator_for_stack(struct reftabl
      	iter =3D xcalloc(1, sizeof(*iter));
    - 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable=
, 1);
    + 	base_ref_iterator_init(&iter->base, &reftable_reflog_iterator_vtable=
);
      	iter->refs =3D refs;
     -	iter->base.oid =3D &iter->oid;
     =20
5:  a7459b9483 =3D 6:  7928661318 refs: stop resolving ref corresponding to=
 reflogs
6:  cddb2de939 =3D 7:  d7b9cff4c3 builtin/reflog: introduce subcommand to l=
ist reflogs
--=20
2.44.0-rc1


--7RJ5foHdKWxKY38m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa4cACgkQVbJhu7ck
PpRVEBAAhb39M31+b1V2g+6pPR+9g/0xhbjbqERecOhpQS8NWBagOxpeSwSxsRpt
QoJvsQxsQAGJy43AU8j6rQTiyf1tj06vd+lFSZgsw8w6m9l490MisX7cSpRodk9c
pbAH7SVARikGHH9HffdvvuAEQBxkmmq2rGcdStj2yHXA0gI9e6zTMIhWeKsbbqND
8tiVK7NM9rvjCarTrsNQczfgfXj4dYLkX1/CYTAcSEREv/uu4NaaaaoiXcRHTsy9
kqoEloq2layUNLjI/Uaz1vY0SgaNXDCI0iIhi3CCEwPX1om1PGzKm6VmEHtxR5MH
BzmUpYh9HxI21e0BP5oEZoZgLtNZ0I+x/+Q9d0PpwirDM4adHEIH78hjq5AvLjbT
CwX6Awo1Gsz+rKcbm6bs4OExjcqfVfEnRYkajk2+VNxN0dDLsAhIrTu2otf8bPcg
mnQk8/A5BM8HAvxYSYeAcpxcIIpRm4Dx1YfUqCvFtopO4dskbAP2OyrPY9alwWAu
dXCUP0kVM+D/t1lndTLdJ8aXaQWLEn5CaQzJHehQ+3I8a/5oqo4n5N0o5LHzVuUb
KnRGZs+zdFOU2wroEjAVJvDQjnyc5l+jpwlYegqYRzqBF5EilIkM5WPE15F4nVY2
LWuTiPwGAGDLks8em8PlQSD/RMGLLoyQI+Lo4GN6aK6DloKFylg=
=qAtZ
-----END PGP SIGNATURE-----

--7RJ5foHdKWxKY38m--
