Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E325EFAB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473764; cv=none; b=EMhZT8HN0GnikIP6UPfd8XFRO8g1IkWdAOllbIHKOkWCqBr5nWbuYjGz0Yb/dTgjLJPL5rjbLRklaBsxNDAzvxzlvn0nsMWcpyGB9+XGGJ+wfg3NJG3VNlnqi6zgfohl7eaJu27rYt0ujmw4QFvO6iSVPprUY3x7fzKsy72BgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473764; c=relaxed/simple;
	bh=NgCrMl2agioteSsU+3Eg99HVi3rZH/twDRZjWCGz9MA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HCAT6A+dkRDHOpWY9b264JZfXwtxYeJ1WY/mqXyuKWGCTD1OIwHDnFwi+PjD3uFeoGiPMqkjf18O5anc3VK6dmQnfjZ/A7Pln/2etw1cMI9Otcq/gXd8JsomIGTdUUCiCxbiAtZtzIoeKwFxAJVlJq7EDJ7w4CXyJF5TJa5jPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gAbboVGh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lypkw1Ib; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gAbboVGh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lypkw1Ib"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B8D62540170;
	Tue, 25 Feb 2025 03:55:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Feb 2025 03:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740473759;
	 x=1740560159; bh=P92koRkNhSXcG2XOplBe3lLeixwJU8/gYlyomTOCR94=; b=
	gAbboVGh083o7BVfqHLIdxXsDdcwk0cZaRQqLGxRFOSni8ymLAv0/ALbZ5jYylsS
	cCJZLiuiVv3HNhcUuJ3KZhP7Ma5DDK+hgpDjXKqOtCO4OM2knlhqJvEMU0s/8XDl
	VuyLyJ+ZuJyioSpOhXqcpn9mMJpTvOAcL3UiOkTPHlSM1MqM8VDaISs4Pyx+Emm0
	z9evLLdcKuclO0HTAj8a2XoUPEk+z19jSAgs9pTDVAyA1dGCeM/4h3T7pZiewP69
	k1ODnq74I8RRuePcuQ84jqF7xUZqYPyuPbBzDFQumbcwoJzbcTIfORKlYhbKmCxX
	SdQFqL8GXdVP15r64Y/vqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740473759; x=
	1740560159; bh=P92koRkNhSXcG2XOplBe3lLeixwJU8/gYlyomTOCR94=; b=l
	ypkw1IbRnrva11i3rVfH3HwDfusV4gqJhb3tyb7ZQAB6Dp21uAdL++YnH5lzE87v
	rEqhabGsGbMxLBQBqwKIcHSo9mtsgDcMpRraXiPqYUbbHpnsk0ZOj0YlSnpKq6om
	RcwV2LCvU7aBI7EzbtxLBSJb1FuzYua6yYnNyLuUrSXt7wsqopWvNAh1FmgzN4Iu
	yq8Lli4IXLsw2YxME/O8088D6vrCiViqkJqkKQEeh/Nao4ID8BGkx77O5cDL5isf
	jSmPZIsRKEgm6NmFBH6U9W790uq1f74SelYfPijUn4m7fJhMJsUoeuLmiYaVlKum
	FDJHzjzPGTNn18vVuRzWw==
X-ME-Sender: <xms:n4W9ZxKRdBbws8przx3Wq8SU3cRRODtbptbF2fkUoBzYGvhV8PhvoA>
    <xme:n4W9Z9IMhupHJVb3tai2Mls0__hCTGOE6GeP5000CADqI93iGs3zdnUJowMPim97H
    a1UkFuv1a3Wt8HQvw>
X-ME-Received: <xmr:n4W9Z5t5kC_t7GBg-CmI5ECkUERrOdN6F9SHmFc_mrYSaRRiNTnxM5NAw7HrkW9tWYiKsEwPFH3lnQ0M2RPoqcTWxX8JbFKwzZFJKspdeX7nqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepudduveejffffgeejgeehieetuefftddvheelgeef
    feevtdegteelhfekveettdehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthho
    pehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhig
    fhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:n4W9ZyZ1jNfLDHq9rfqN9yPDZDArCFpnTYPJRiBFfAsR1X-qoXjT8w>
    <xmx:n4W9Z4bJWSc-qbKwlCdIskhdc2GD0HMFL0sW8WeFPppawdwkCAB6jw>
    <xmx:n4W9Z2DOt-hqFTQj7IhgVJOQ8lI-1BxRQ0wxx9xhFZLdh6KVzndllQ>
    <xmx:n4W9Z2awyiyOAiR1Lxu8zRtbQPsIslQ4rWTe5jY8uKDSJL_q2sMKww>
    <xmx:n4W9Z45vtBkl9mtmLyNfRrYGFqbPVVZdZ84srZFK3Gy1mwuSR8NjeGOG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 03:55:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f213a458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 08:55:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/16] refs: batch refname availability checks
Date: Tue, 25 Feb 2025 09:55:46 +0100
Message-Id: <20250225-pks-update-ref-optimization-v3-0-77c3687cda75@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJOFvWcC/43NQQ6CMBAF0KuQrh1TRmnFlfcwLgoMMjFA09ZGJ
 dzdwsK4Mi7/5P83k/DkmLw4ZpNwFNnzOKSw22Si7sxwJeAmZYESC4m5BnvzcLeNCQSOWhht4J5
 fJqQd5EWty4KUIqxEEmxq8GPVz5eUO/ZhdM/1WcyX639uzEGCwUo1B21wb9pTam+5Fwsa8Rsqf
 0OYIFKlIo0oK8QPNM/zG4m+Xz8MAQAA
X-Change-ID: 20250217-pks-update-ref-optimization-15c795e66e2b
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this patch series has been inspired by brian's report that the reftable
backend is significantly slower when writing many references compared to
the files backend. As explained in that thread, the underlying issue is
the design of tombstone references: when we first delete all references
in a repository and then recreate them, we still have all the tombstones
and thus we need to churn through all of them to figure out that they
have been deleted in the first place. The files backend does not have
this issue.

I consider the benchmark itself to be kind of broken, as it stems from
us deleting all refs and then recreating them. And if you pack refs in
between then the "reftable" backend outperforms the "files" backend.

But there are a couple of opportunities here anyway. While we cannot
make the underlying issue of tombstones being less efficient go away,
this has prompted me to have a deeper look at where we spend all the
time. There are three ideas in this series:

  - git-update-ref(1) performs ambiguity checks for any full-size object
    ID, which triggers a lot of reads. This is somewhat pointless though
    given that the manpage explicitly points out that the command is
    about object IDs, even though it does know to parse refs. But being
    part of plumbing, emitting the warning here does not make a ton of
    sense, and favoring object IDs over references in these cases is the
    obvious thing to do anyway.

  - For each ref "refs/heads/bar", we need to verify that neither
    "refs/heads" nor "refs" exists. This was repeated for every refname,
    but because most refnames use common prefixes this made us re-check
    a lot of prefixes. This is addressed by using a `strset` of already
    checked prefixes.

  - For each ref "refs/heads/bar", we need to verify that no ref
    "refs/heads/bar/*" exists. We always created a new ref iterator for
    this check, which requires us to discard all internal state and then
    recreate it. The reftable library has already been refactored though
    to have reseekable iterators, so we backfill this functionality to
    all the other iterators and then reuse the iterator.

With the (somewhat broken) benchmark we see a small speedup with the
"files" backend:

    Benchmark 1: update-ref (refformat = files, revision = master)
      Time (mean ± σ):     234.4 ms ±   1.9 ms    [User: 75.6 ms, System: 157.2 ms]
      Range (min … max):   232.2 ms … 236.9 ms    10 runs

    Benchmark 2: update-ref (refformat = files, revision = HEAD)
      Time (mean ± σ):     184.2 ms ±   2.0 ms    [User: 62.8 ms, System: 119.9 ms]
      Range (min … max):   181.1 ms … 187.0 ms    10 runs

    Summary
      update-ref (refformat = files, revision = HEAD) ran
        1.27 ± 0.02 times faster than update-ref (refformat = files, revision = master)

And a huge speedup with the "reftable" backend:

    Benchmark 1: update-ref (refformat = reftable, revision = master)
      Time (mean ± σ):     16.852 s ±  0.061 s    [User: 16.754 s, System: 0.059 s]
      Range (min … max):   16.785 s … 16.982 s    10 runs

    Benchmark 2: update-ref (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      2.230 s ±  0.009 s    [User: 2.192 s, System: 0.029 s]
      Range (min … max):    2.215 s …  2.244 s    10 runs

    Summary
      update-ref (refformat = reftable, revision = HEAD) ran
        7.56 ± 0.04 times faster than update-ref (refformat = reftable, revision = master)

We're still not up to speed with the "files" backend, but considerably
better. Given that this is an extreme edge case and not reflective of
the general case I'm okay with this result for now.

But more importantly, this refactoring also has a positive effect when
updating references in a repository with preexisting refs, which I
consider to be the more realistic scenario. The following benchmark
creates 10k refs with 100k preexisting refs.

With the "files" backend we see a modest improvement:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     478.4 ms ±  11.9 ms    [User: 96.7 ms, System: 379.6 ms]
      Range (min … max):   465.4 ms … 496.6 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     388.5 ms ±  10.3 ms    [User: 52.0 ms, System: 333.8 ms]
      Range (min … max):   376.5 ms … 403.1 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.23 ± 0.04 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)

But with the "reftable" backend we see an almost 5x improvement, where
it's now ~15x faster than the "files" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)
      Time (mean ± σ):     153.9 ms ±   2.0 ms    [User: 96.5 ms, System: 56.6 ms]
      Range (min … max):   150.5 ms … 158.4 ms    18 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      32.2 ms ±   1.2 ms    [User: 27.6 ms, System: 4.3 ms]
      Range (min … max):    29.8 ms …  38.6 ms    71 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        4.78 ± 0.19 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)

The series is structured as follows:

  - Patches 1 to 4 implement the logic to skip ambiguity checks in
    git-update-ref(1).

  - Patch 5 to 8 introduce batched checks.

  - Patch 9 deduplicates the ref prefix checks.

  - Patch 10 to 16 implement the infrastructure to reseek iterators.

  - Patch 17 starts to reuse iterators for nested ref checks.

Changes in v2:
  - Point out why we also have to touch up the `dir_iterator`.
  - Fix up the comment explaining `ITER_DONE`.
  - Fix up comments that show usage patterns of the ref and dir iterator
    interfaces.
  - Start batching availability checks in the "files" backend, as well.
  - Improve the commit message that drops the ambiguity check so that we
    also point to 25fba78d36b (cat-file: disable object/refname
    ambiguity check for batch mode, 2013-07-12).
  - Link to v1: https://lore.kernel.org/r/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im

Changes in v3:
  - Fix one case where we didn't skip ambiguity checks in
    git-update-ref(1).
  - Document better that only the prefix can change on reseeking
    iterators. Other internal state will remain the same.
  - Fix a memory leak in the ref-cache iterator.
  - Don't ignore errors returned by `packed_ref_iterator_seek()`.
  - Link to v2: https://lore.kernel.org/r/20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im

Thanks!

Patrick

[1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

---
Patrick Steinhardt (16):
      object-name: introduce `repo_get_oid_with_flags()`
      object-name: allow skipping ambiguity checks in `get_oid()` family
      builtin/update-ref: skip ambiguity checks when parsing object IDs
      refs: introduce function to batch refname availability checks
      refs/reftable: batch refname availability checks
      refs/files: batch refname availability checks for normal transactions
      refs/files: batch refname availability checks for initial transactions
      refs: stop re-verifying common prefixes for availability
      refs/iterator: separate lifecycle from iteration
      refs/iterator: provide infrastructure to re-seek iterators
      refs/iterator: implement seeking for merged iterators
      refs/iterator: implement seeking for reftable iterators
      refs/iterator: implement seeking for ref-cache iterators
      refs/iterator: implement seeking for packed-ref iterators
      refs/iterator: implement seeking for files iterators
      refs: reuse iterators when determining refname availability

 builtin/clone.c              |   2 +
 builtin/update-ref.c         |  15 ++--
 dir-iterator.c               |  24 +++---
 dir-iterator.h               |  11 +--
 hash.h                       |   1 +
 iterator.h                   |   2 +-
 object-name.c                |  18 +++--
 object-name.h                |   6 ++
 refs.c                       | 186 ++++++++++++++++++++++++++-----------------
 refs.h                       |  12 +++
 refs/debug.c                 |  20 +++--
 refs/files-backend.c         | 117 +++++++++++++++++----------
 refs/iterator.c              | 145 +++++++++++++++++----------------
 refs/packed-backend.c        |  92 ++++++++++++---------
 refs/ref-cache.c             |  88 ++++++++++++--------
 refs/refs-internal.h         |  53 +++++++-----
 refs/reftable-backend.c      |  85 +++++++++++---------
 t/helper/test-dir-iterator.c |   1 +
 18 files changed, 528 insertions(+), 350 deletions(-)

Range-diff versus v2:

 1:  b7b3e057628 !  1:  34198fbc1c0 object-name: introduce `repo_get_oid_with_flags()`
    @@ object-name.c: void object_context_release(struct object_context *ctx)
     - * notably "xyz^" for "parent of xyz"
     - */
     -int repo_get_oid(struct repository *r, const char *name, struct object_id *oid)
    -+int repo_get_oid_with_flags(struct repository *r, const char *name, struct object_id *oid,
    -+			    unsigned flags)
    ++int repo_get_oid_with_flags(struct repository *r, const char *name,
    ++			    struct object_id *oid, unsigned flags)
      {
      	struct object_context unused;
     -	int ret = get_oid_with_context(r, name, 0, oid, &unused);
    @@ object-name.h: void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repo
     + * This is like "get_oid_basic()", except it allows "object ID expressions",
     + * notably "xyz^" for "parent of xyz". Accepts GET_OID_* flags.
     + */
    -+int repo_get_oid_with_flags(struct repository *r, const char *str, struct object_id *oid,
    -+			    unsigned flags);
    ++int repo_get_oid_with_flags(struct repository *r, const char *str,
    ++			    struct object_id *oid, unsigned flags);
      int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
      __attribute__((format (printf, 2, 3)))
      int get_oidf(struct object_id *oid, const char *fmt, ...);
 2:  3cba1ffa8aa =  2:  f5d4d2a67ce object-name: allow skipping ambiguity checks in `get_oid()` family
 3:  80dfc2ee6b7 !  3:  0512c256641 builtin/update-ref: skip ambiguity checks when parsing object IDs
    @@ builtin/update-ref.c: static int parse_next_oid(const char **next, const char *e
      				goto invalid;
      		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
      			/* With -z, treat an empty value as all zeros: */
    +@@ builtin/update-ref.c: static void parse_cmd_symref_update(struct ref_transaction *transaction,
    + 			die("symref-update %s: expected old value", refname);
    + 
    + 		if (!strcmp(old_arg, "oid")) {
    +-			if (repo_get_oid(the_repository, old_target, &old_oid))
    ++			if (repo_get_oid_with_flags(the_repository, old_target, &old_oid,
    ++						    GET_OID_SKIP_AMBIGUITY_CHECK))
    + 				die("symref-update %s: invalid oid: %s", refname, old_target);
    + 
    + 			have_old_oid = 1;
     @@ builtin/update-ref.c: int cmd_update_ref(int argc,
      		refname = argv[0];
      		value = argv[1];
 4:  9bd05801ac0 =  4:  ad7bf4bed31 refs: introduce function to batch refname availability checks
 5:  0104c9759aa =  5:  132f09c4584 refs/reftable: batch refname availability checks
 6:  fba06e5fcb7 =  6:  bd7e5fa7bf1 refs/files: batch refname availability checks for normal transactions
 7:  dfb4be26147 =  7:  a907f62d2c2 refs/files: batch refname availability checks for initial transactions
 8:  e7abe4bae25 =  8:  866e5f4b4cc refs: stop re-verifying common prefixes for availability
 9:  1deae95c53a =  9:  736f1bd9afd refs/iterator: separate lifecycle from iteration
10:  8b942563e65 ! 10:  71d4c4c4655 refs/iterator: provide infrastructure to re-seek iterators
    @@ Commit message
         the reftable backend.
     
         Introduce a new `.seek` function in the ref iterator vtable that allows
    -    callers to re-seek an iterator. It is expected to be functionally the
    -    same as calling `refs_ref_iterator_begin()` with a different (or the
    -    same) prefix.
    +    callers to seek an iterator multiple times. It is expected to be
    +    functionally the same as calling `refs_ref_iterator_begin()` with a
    +    different (or the same) prefix.
    +
    +    Note that it is not possible to adjust parameters other than the seeked
    +    prefix for now, so exclude patterns, trimmed prefixes and flags will
    +    remain unchanged. We do not have a usecase for changing these parameters
    +    right now, but if we ever find one we can adapt accordingly.
     
         Implement the callback for trivial cases. The other iterators will be
         implemented in subsequent commits.
    @@ refs/refs-internal.h: struct ref_iterator {
     + *
     + * This function is expected to behave as if a new ref iterator with the same
     + * prefix had been created, but allows reuse of iterators and thus may allow
    -+ * the backend to optimize.
    ++ * the backend to optimize. Parameters other than the prefix that have been
    ++ * passed when creating the iterator will remain unchanged.
     + *
     + * Returns 0 on success, a negative error code otherwise.
     + */
11:  ad4f063ef06 = 11:  5a0412d754b refs/iterator: implement seeking for merged iterators
12:  ddac957862f ! 12:  ece7e500ecd refs/iterator: implement seeking for reftable iterators
    @@ Commit message
         iterators already support seeking this change is straight-forward. Two
         notes though:
     
    -      - We do not support seeking on reflog iterators.
    +      - We do not support seeking on reflog iterators. It is unclear what
    +        seeking would even look like in this context, as you typically would
    +        want to seek to a specific entry in the reflog for a specific ref.
    +        There is not currently a usecase for this, but if there ever is we
    +        can implement seeking in the future.
     
           - We start to check whether `reftable_stack_init_ref_iterator()` is
             successful.
13:  87b81552acf ! 13:  f693de656b5 refs/iterator: implement seeking for ref-cache iterators
    @@ Commit message
         Note that we cannot use the optimization anymore where we return an
         empty ref iterator when there aren't any references, as otherwise it
         wouldn't be possible to reseek the iterator to a different prefix that
    -    may exist. This shouldn't be much of a performance corncern though as we
    +    may exist. This shouldn't be much of a performance concern though as we
         now start to bail out early in case `advance()` sees that there are no
         more directories to be searched.
     
    @@ refs/ref-cache.c: struct cache_ref_iterator {
      	 */
      	size_t levels_nr;
      
    +@@ refs/ref-cache.c: struct cache_ref_iterator {
    + 	 * The prefix is matched textually, without regard for path
    + 	 * component boundaries.
    + 	 */
    +-	const char *prefix;
    ++	char *prefix;
    + 
    + 	/*
    + 	 * A stack of levels. levels[0] is the uppermost level that is
     @@ refs/ref-cache.c: struct cache_ref_iterator {
      	struct cache_ref_iterator_level *levels;
      
    @@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref
     +{
     +	struct cache_ref_iterator *iter =
     +		(struct cache_ref_iterator *)ref_iterator;
    ++	struct cache_ref_iterator_level *level;
     +	struct ref_dir *dir;
     +
     +	dir = get_ref_dir(iter->cache->root);
     +	if (prefix && *prefix)
     +		dir = find_containing_dir(dir, prefix);
    ++	if (!dir) {
    ++		iter->levels_nr = 0;
    ++		return 0;
    ++	}
     +
    -+	if (dir) {
    -+		struct cache_ref_iterator_level *level;
    -+
    -+		if (iter->prime_dir)
    -+			prime_ref_dir(dir, prefix);
    -+		iter->levels_nr = 1;
    -+		level = &iter->levels[0];
    -+		level->index = -1;
    -+		level->dir = dir;
    ++	if (iter->prime_dir)
    ++		prime_ref_dir(dir, prefix);
    ++	iter->levels_nr = 1;
    ++	level = &iter->levels[0];
    ++	level->index = -1;
    ++	level->dir = dir;
     +
    -+		if (prefix && *prefix) {
    -+			iter->prefix = xstrdup(prefix);
    -+			level->prefix_state = PREFIX_WITHIN_DIR;
    -+		} else {
    -+			level->prefix_state = PREFIX_CONTAINS_DIR;
    -+		}
    ++	if (prefix && *prefix) {
    ++		free(iter->prefix);
    ++		iter->prefix = xstrdup(prefix);
    ++		level->prefix_state = PREFIX_WITHIN_DIR;
     +	} else {
    -+		iter->levels_nr = 0;
    ++		FREE_AND_NULL(iter->prefix);
    ++		level->prefix_state = PREFIX_CONTAINS_DIR;
     +	}
     +
     +	return 0;
    @@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref
      				   struct object_id *peeled)
      {
     @@ refs/ref-cache.c: static void cache_ref_iterator_release(struct ref_iterator *ref_iterator)
    + {
    + 	struct cache_ref_iterator *iter =
    + 		(struct cache_ref_iterator *)ref_iterator;
    +-	free((char *)iter->prefix);
    ++	free(iter->prefix);
    + 	free(iter->levels);
    + }
      
      static struct ref_iterator_vtable cache_ref_iterator_vtable = {
      	.advance = cache_ref_iterator_advance,
14:  2619de30fe1 ! 14:  ac71647ee94 refs/iterator: implement seeking for `packed-ref` iterators
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    refs/iterator: implement seeking for `packed-ref` iterators
    +    refs/iterator: implement seeking for packed-ref iterators
     
         Implement seeking of `packed-ref` iterators. The implementation is again
         straight forward, except that we cannot continue to use the prefix
    @@ refs/packed-backend.c: static struct ref_iterator *packed_ref_iterator_begin(
     -	if (prefix && *prefix)
     -		/* Stop iteration after we've gone *past* prefix: */
     -		ref_iterator = prefix_ref_iterator_begin(ref_iterator, prefix, 0);
    -+	packed_ref_iterator_seek(&iter->base, prefix);
    ++	if (packed_ref_iterator_seek(&iter->base, prefix) < 0) {
    ++		ref_iterator_free(&iter->base);
    ++		return NULL;
    ++	}
      
      	return ref_iterator;
      }
15:  d4f76e6480b ! 15:  02cafca513c refs/iterator: implement seeking for "files" iterators
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    refs/iterator: implement seeking for "files" iterators
    +    refs/iterator: implement seeking for files iterators
     
         Implement seeking for "files" iterators. As we simply use a ref-cache
         iterator under the hood the implementation is straight-forward. Note
16:  49017050289 = 16:  baed7615a97 refs: reuse iterators when determining refname availability

---
base-commit: e2067b49ecaef9b7f51a17ce251f9207f72ef52d
change-id: 20250217-pks-update-ref-optimization-15c795e66e2b

