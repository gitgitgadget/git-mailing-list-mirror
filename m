Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058577;
	b=lArkTRfwMO1MoEN1wwPMHKd+W1TPXGo7i/Bre/GSXHQV6F8/t3GF9hR55Tk/Zgi+l9KP
	 hIy8Y8WRf6oio26h+PEA2njkYMVJUtMU/ULLm3Jp8Lm+V7TpAMz45F+T5q89OTBAa9Nk+
	 uXJl3EoYLBGAP9BHftX2F4fI4MxzXQItR7Bvr/RWUXwCypRXsb+MGDNqUZ1MyA4l7Q3FR
	 /z8hgEQkl16qnP7ZexOmOaYV7rdZ6bweS53N2r/EXnXaDXq7xcgVhcaAYBr8iMPfuPvOK
	 kRo8/s/4gUhWuq+uVAgIRDVxUSTI6rk0lKHxSETcCBldOvO8qSAzYNumbYqYrpJE+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9GNWS9/RDFwA6k5QWvs7NJJJ3+gDuo5/OgMjwTTqACM=;
	b=b2F9PM1gUUTh7JNKf0uZFOkeau+IRb8sXJEziyB+JY2Z2yVqFlhwSk898h99VY1zvVsq
	 rDiBFUi4Hh4huyvrEqVQgf/G7f8INXeeW4QQdEqCXkBdaOyhkp+UPW6hSI7XeSntLe0ax
	 HPX+XNFFVI12XFZj8fMwb9kYn4cc+w/dS9FS80EjQfiUhkVbpjRHK15Y6S3fbbYEm8Jtg
	 tguDD0Hhly4JIW6XToUVLOm/ZasfzuV11R3a8iaHBFRYDyhqfEADkUJT5V1sTP2DBEeMU
	 Nl/o22xlFmT8ximG33v9fwclUmcM+8nmgkkvb82X5DTl7Ntx0XCG48htZi4+Gd39dEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UI7D4IsS;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BB606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 23:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454BB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=UI7D4IsS
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c616c84so296973585a.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793058576; x=1793663376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9GNWS9/RDFwA6k5QWvs7NJJJ3+gDuo5/OgMjwTTqACM=;
        b=UI7D4IsSDhklEd8Obo8/fA5rWf6N14G48zNvDNyNRI1exiGz4p4dieI9h1/INfg7xc
         TIga1TuRpGl1+tES0JqLHTepUhXRc9SbI9Hua2Rr0S9cCBdW0oz5c0V8eUmTshsN5eOj
         wEn4QYMtA+H6HGgkoVGX8u/st5x1bX1IC+ROg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058576; x=1793663376;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9GNWS9/RDFwA6k5QWvs7NJJJ3+gDuo5/OgMjwTTqACM=;
        b=KY0KfUT6GAC+eD5kx5FTsp8VwR0FvUDAioIzy/wguvDHJojh6+/pigHEaCxzjbLeyP
         x+I10p4FumuPsU8Li5VgisSo5vOxOI57KIxxz55RPqy5ELI1q8kF8RelDSyiRPnzYsDN
         LERaJ8GvfiwRFetKj48W9bIxd1svvqBPW0vZ3f7b3dU4WysMsTFK/OXbXMR9GH0vPLfR
         WqMKl7Befv9aS4d1YoD2Ft+KKTdd1u39W9yvqoWX3KpNLxfgcOpSX6g0eb4ini0EhGqt
         RFTl4LSZ2IgF9zalYeEPzvn9u7iD/an6ktqr6PgS+nkv9jv+eN6i1CH3u/FghQpuUdm1
         optA==
X-Gm-Message-State: AFq9FYJBN8mfIT5xZ+Hw2YDF/AcVKqTRAE53XOsJJxFILmTMxwgcSTEt
	7lY+9g+HC3ZYQGphIZphJcO9MfV13NxpjCKgM7jAht/yYKieZlV90DT/RZIPNmAhJTQEk1pCpdd
	dvPrM9lM=
X-Gm-Gg: AYBFou11JqZL4Unkbp1ao17lSGG55eRy1Ff2RicjY0Bl2JDJgZkg5q0xZThp3wAWLZd
	p1q163b8qJ4oJFtPER2BlrPw5HKyhQ6Kb2yWB9dPFn7jHz+3r4GER9c2dO7YIDyx2LQJzkVlREj
	7BXJc86/stc89ObpB2tzMqPLPK8P0N4ZxboaTveCLBnX4wOS746c6fHJ0GQ/uYbcvu/djTp7CLt
	cuGMZpmosVfrNkqJELIdRya6YaFiN6nYhOwwB/SRQ0a39qOAddlbExDBe9l0GQU0LBuw2bd0ouV
	7JI8OaEj/4sMtdESaRgJFTEmzm9fRgoNEsuE2lelQ92aU51XWc9Y6E5rYe73WBNlN4n5IduV1yq
	mLMHTQPtRUJ3WB/81ba0jeIIgaBS3df4jGZZ0ieJmH5g4kOHTuApYBHVrHLaGKhUYA11zSVg/7/
	B3i5ieGgpfSWpLN4AWxHQAa3xxTLV6b7mw2NNZgSZH/TO0i6PwTnleXt88ES9FnK7duztzkQ7uX
	mkGuPeYcgcZcHZhfjtb1+SMASgu17ydDxp97rdI/PGeK+mWykEYoj2zbk7RnhP4Nbh60lMC5+TC
	TleVLvDvFeMgRTSJ5eULt6B+XRFqKYBk0l0oOHfI41UK0LTtERvK4e/2k9x53/9m5qs1
X-Received: by 2002:a05:620a:649b:b0:93e:c12c:9dd0 with SMTP id af79cd13be357-940ef9e41cbmr1281575585a.80.1793058576192;
        Mon, 26 Oct 2026 16:49:36 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a8164asm820591285a.38.2026.10.26.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:49:35 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:49:28 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: [PATCH v3 0/2] negotiator: parse commits before queueing
Message-ID: <cover.1793058562.git.ttaylorr@openai.com>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>

This is a reroll of my patches to fix a pair of bugs in the default and
skipping negotiators.

This version fixes the SEEN bookkeeping issue Junio pointed out in v2,
and adds a separate fix for the same mistake in the default negotiator.

The original problem is that the skipping negotiator can queue unparsed
parents with a date of zero. Old ref tips then sort ahead of recent
ancestors, so negotiation can end before we offer a recent common
ancestor. As in v2, the fix parses commits in rev_list_push(), where
their dates are needed to order the queue, and removes the later parse
from get_rev().

But v2 set SEEN before attempting that parse. If parsing failed, another
child sharing the missing parent would look for a queue entry that did
not exist and trigger BUG("missing parent in priority queue"). Both
rev_list_push() implementations set SEEN only after parsing succeeds:

  - The first patch fixes the existing bug in the default negotiator.
    Marking a missing ancestor SEEN can cause mark_common() to decrement
    non_common_revs for a commit that was never queued, ending
    negotiation while other commits remain.

  - The second patch is an updated version of the previous round which
    applies the same fix to the skipping negotiator. Relative to the
    earlier round, it also adds a test where two tips share a missing
    parent and fetching retrieves that parent without hitting the BUG().

Thanks to Junio and Patrick for their review. The range-diff against v2
is below.

Thanks in advance for your review!

Taylor Blau (2):
  negotiator/default.c: mark commits seen only after parsing
  negotiator/skipping.c: parse parents before queueing

 negotiator/default.c                 |  3 +-
 negotiator/skipping.c                |  9 +++-
 t/t5552-skipping-fetch-negotiator.sh | 63 ++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh               | 31 ++++++++++++++
 4 files changed, 102 insertions(+), 4 deletions(-)

Range-diff against v2:
-:  ----------- > 1:  5a6af916635 negotiator/default.c: mark commits seen only after parsing
1:  c1674625a65 ! 2:  7365a2ab180 negotiator/skipping.c: parse parents before queueing
    @@ Commit message
         then waits behind old ref tips. With enough old refs, negotiation can
         end before we offer that recent common ancestor.
     
    -    Parse each unseen parent before adding it to the queue, so the queue
    -    uses its actual date. If parsing fails, leave the parent out of the
    -    queue.
    +    Parse commits in rev_list_push() before adding them to the queue, so
    +    the queue uses their actual dates. If parsing fails, leave the commit
    +    out of the queue. Move the parsing from get_rev() to the insertion
    +    point, where the date is needed to order the queue.
     
    -    Since the sole caller of `prio_queue_put()` ensures that commits are
    -    fully parsed before pushing them onto the queue, we can avoid a noop
    -    call to `repo_parse_commit()` within `get_rev()`.
    +    Set SEEN only after parsing succeeds, following the default negotiator
    +    after the preceding fix. push_parent() assumes that a commit marked
    +    SEEN but not POPPED has an entry in the queue. Marking an unparseable
    +    parent SEEN would violate that assumption and trigger a BUG() if another
    +    child tried to push the same parent.
     
    -    Note that unlike the default negotiator, the skipping negotiator's
    -    version of `rev_list_push()` returns a pointer to an 'entry' struct. As
    -    a consequence, callers must be prepared to handle a NULL return value.
    -    The caller in `push_parent()` gains a NULL-ness check, and the remaining
    -    two callers continue to ignore the return value from `rev_list_push()`.
    +    Unlike the default negotiator, the skipping negotiator's version of
    +    rev_list_push() returns a pointer to an entry struct. Check for NULL in
    +    push_parent() before using that entry. The other two callers continue
    +    to ignore the return value.
    +
    +    Add tests for the ordering of recent ancestors relative to old ref tips
    +    and for two tips sharing a missing parent. In the latter case, fetching
    +    from a server that has the parent should retrieve it without triggering
    +    the missing-entry BUG().
     
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
     
      ## negotiator/skipping.c ##
    -@@ negotiator/skipping.c: static struct entry *rev_list_push(struct data *data, struct commit *commit, int
    +@@ negotiator/skipping.c: static int compare(const void *a_, const void *b_, void *data UNUSED)
    + static struct entry *rev_list_push(struct data *data, struct commit *commit, int mark)
    + {
      	struct entry *entry;
    - 	commit->object.flags |= mark | SEEN;
    - 
    ++
     +	if (repo_parse_commit(the_repository, commit))
     +		return NULL;
     +
    + 	commit->object.flags |= mark | SEEN;
    + 
      	CALLOC_ARRAY(entry, 1);
    - 	entry->commit = commit;
    - 	prio_queue_put(&data->rev_list, entry);
     @@ negotiator/skipping.c: static void mark_common(struct data *data, struct commit *seen_commit)
       * entry has the correct flags and ttl.
       *
    @@ t/t5552-skipping-fetch-negotiator.sh: test_expect_success 'do not send "have" wi
     +	sed -n "s/.*fetch> have //p" trace | head -n 2 >actual &&
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'missing parent shared by two tips is not treated as queued' '
    ++	rm -rf server client trace &&
    ++	git init server &&
    ++	test_commit -C server base &&
    ++	parent=$(git -C server rev-parse HEAD) &&
    ++	test_commit -C server to_fetch &&
    ++
    ++	git init client &&
    ++	tree=$(git -C client mktree </dev/null) &&
    ++	# Write the tips directly, bypassing the parent lookup in commit-tree.
    ++	# Both tips name a parent that only the server has.
    ++	for i in 1 2
    ++	do
    ++		cat >commit <<-EOF_COMMIT &&
    ++		tree $tree
    ++		parent $parent
    ++		author A U Thor <author@example.com> 1000000000 +0000
    ++		committer C O Mitter <committer@example.com> 1000000000 +0000
    ++
    ++		tip $i
    ++		EOF_COMMIT
    ++		tip=$(git -C client hash-object -w -t commit --stdin <commit) &&
    ++		git -C client update-ref refs/heads/tip-$i "$tip" || return 1
    ++	done &&
    ++
    ++	test_config -C client fetch.negotiationalgorithm skipping &&
    ++	trace_fetch client "$(pwd)/server" \
    ++		--negotiation-tip=tip-1 --negotiation-tip=tip-2 &&
    ++	git -C client cat-file -e "$parent"
    ++'
     +
      test_done

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0.187.g9e9ae442333
