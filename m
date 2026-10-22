Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792704081;
	b=vn641Nm06Gr+HgbTQ4FX9Gi7byjILmGvsAc4MhShADeU//T5GgkjELTrXC88GftHAVz+
	 QDJe9qNhPJGWKO83qoz4HzTMskoEDLRmoJvUymK0xe2vUxFLpY1pfsBpDR3dpO0lDinCR
	 LgH7o390sOF6BmWA0zSqOi2/aKrDL41dUukn4yO/KlIncMstJUUhITShL/8EZCzwTb5FT
	 V8mCZcbIVWTRNWVOOqBqrg/lSJld6Nh4yiPIvCZ2ZVV52/u400k7FiYg9MiNuoPAiV8eH
	 NIRnakTpvuyvfa3OGZ04YfhiUDDsfVFyQxMq4S1t+6zKG3ed5wBcIW0j3aOEbFv+yNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792704081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YDCUPNxhOzODv/OwDKb7mPV0YF9jHqHfSjWXJu3Vl0Q=;
	b=CiOSv+ZRxMCJuxTYGUGOQYf5++W3Gr/6Pwa/GrZ7dFbLfaRJKLpXjUL9e/oMaAlBMJ4P
	 EJunKYm90h9VSq5rpkMyn/uXBl7efqiTGM8S2EKlmZ0PBMzyv+0Oo3PqhRRBLgMrSxNal
	 sBP2x6VhluBkLvrKQTmdimMy98cT92vbMh4nFZCSGBDDykxtAs1saZSkCEY+NhiiCBNGQ
	 t+Xc3vHMmKVWOe0JcSW8EBIwGm95gp8xwzvHm2K/kJ/8MAG4Ddtfl8PyLoKth6mAgEhJH
	 bMgCF00+fhCPcuW9giqwSymVPtqkkp6PTx8TFegUFiaN287kFbG9KjpO+VvtSwWpUHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=P7Y2JCvg;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D2606A31D
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 21:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5D2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=P7Y2JCvg
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-70094949641so206869eaf.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792704079; x=1793308879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YDCUPNxhOzODv/OwDKb7mPV0YF9jHqHfSjWXJu3Vl0Q=;
        b=P7Y2JCvggTpRXBZf73OZwO/viLWnvWwsYg/GmhEvIm/AaR4jpUXhECAHKQUJaEvsiQ
         CWKvm0CNDuoO42yuMmZXz+GYWvGnLelOOoSdKUOw+sIWxR0OVQkJ/8ujsk8k+yK10MGW
         Ppyxxp6g8gwfEiwIIjPERB5HSgjbRBFW8WpfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792704079; x=1793308879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDCUPNxhOzODv/OwDKb7mPV0YF9jHqHfSjWXJu3Vl0Q=;
        b=gz45p+5zET7Nb+ULzWa87iExBsCukqLs4KNspyuhZQ0QQaWB+2DtQBXWplBGpef9B0
         nshwz1qIWpC7IbCzRsx/sl7KoT4/VTz2/PBmLbnztYZkoSLi631XR8vsH34WRK1Y5Tal
         2DB4Bmc9e3NAi4ncUYmgDsdTLZMQl49mUICkac0dVuMFGx5IVVzQbShq0vFwoURXfZg8
         90qCNZ49fB9rMNREWv1nicxLj0hjZqj6dRHXtCLCHFgChU2USecFp8XOYyXgONmJ7P45
         PtqVhGs+upDI8WLxJdI+XQGGxsTiPaSUZdj7Gx43FO3OtNpGGtyhtV6oz9Ogg+11Jy/H
         zZWg==
X-Gm-Message-State: AFq9FYIq5F88opG51fNLgfB9RgE3yA5MqZ3CZe4nB22pFxQSESqI5Ytb
	lxnvNqx7mEgAW0gzPYXHJPndUL3mwcYamfUcRV/EYY3AGOIGqbzZQraL+Z0CiipwvM+q1SbR1m2
	CrCKVHoo=
X-Gm-Gg: AYBFou2mb+YLOI2STm8mbrzhjA17+jga6q1k8PX6l4nK5KUFvauZwkox7LURB6sYQgR
	G8L2gNHxvDHARZQlXKezoH0Qx/tsQ4FOcw4QahIx6vh/CRinxgKfTdLiUcFQSwo+IHBF+0o+YkC
	eX4IKQJC4cKmhotFgvf2lLgP+ghfMuJuiqjua3q6oPDp+tqLSW9rKK8DnfNT16r7/svU8/fZ0H6
	eCfk0hMwZ1gMv5olvh/JP0+H1Qh2vOuz3IWo6mGYM46fU0FctEbBk9oEtlhvyBJK75J2z+xxwQ0
	RfJJYW8UUGNsXemXsHU483KC93juURD+uQagkz79w53rlgLh+rbHBV5nt8xCIZPjRf7v0iUxujO
	+bPR6atxPRkvWHPz1SiBNyHZX4SBMvvxfTKNvhmUoK2ajdAKJMfHHGYm7IFz0WMWxeGfsb1BrOb
	59xq57xfxZDNSYq0DYzLzen4OE7ILzBGArbma7UpkbhfBL6p/+mg+pSJziaY/EtJAk0zxxjutJ6
	CDimpHk1638lTCyvJikdXx/7g13cW98+iMoNhKEVtuDaTyqCL8eGPnODzMgMHDwME7fHVsr+5gM
	/VLC38yGFRpj72PfF4JgR1wl0f3QOrEYi0LRveBMM1qaY5IWF1qb76JG7RGXdoJP
X-Received: by 2002:a05:6820:230c:b0:6f9:f85:aea4 with SMTP id 006d021491bc7-70b88a9f83dmr284095eaf.33.1792704079585;
        Thu, 22 Oct 2026 14:21:19 -0700 (PDT)
Received: from com-79390 (vpn-centralus-04.tradc-corp.com. [20.80.83.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b8afa2941sm297132eaf.2.2026.10.22.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 14:21:19 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Thu, 22 Oct 2026 16:21:13 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: [PATCH v2] negotiator/skipping.c: parse parents before queueing
Message-ID: <9e9ae442333b5e2ccc0905c44c2c3e16c49481a7.1792704069.git.me@ttaylorr.com>
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

From: Taylor Blau <ttaylorr@openai.com>

The skipping negotiator sorts its queue by commit date, but callers
which push commits onto that queue, such as `push_parent()`, can add a
parent before parsing it. When an unparsed commit enters the queue, its
date is still zero, so old ref tips may sort ahead of it.

For example, suppose a topic branch is one commit ahead of master.
Skipping offers the topic tip and skips master's tip. Master's parent
then waits behind old ref tips. With enough old refs, negotiation can
end before we offer that recent common ancestor.

Parse each unseen parent before adding it to the queue, so the queue
uses its actual date. If parsing fails, leave the parent out of the
queue.

Since the sole caller of `prio_queue_put()` ensures that commits are
fully parsed before pushing them onto the queue, we can avoid a noop
call to `repo_parse_commit()` within `get_rev()`.

Note that unlike the default negotiator, the skipping negotiator's
version of `rev_list_push()` returns a pointer to an 'entry' struct. As
a consequence, callers must be prepared to handle a NULL return value.
The caller in `push_parent()` gains a NULL-ness check, and the remaining
two callers continue to ignore the return value from `rev_list_push()`.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 negotiator/skipping.c                |  8 +++++--
 t/t5552-skipping-fetch-negotiator.sh | 32 ++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index db90fa77b53..0ae5f28d353 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -66,6 +66,9 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 	struct entry *entry;
 	commit->object.flags |= mark | SEEN;
 
+	if (repo_parse_commit(the_repository, commit))
+		return NULL;
+
 	CALLOC_ARRAY(entry, 1);
 	entry->commit = commit;
 	prio_queue_put(&data->rev_list, entry);
@@ -125,7 +128,7 @@ static void mark_common(struct data *data, struct commit *seen_commit)
  * entry has the correct flags and ttl.
  *
  * This function returns 1 if an entry was found or created, and 0 otherwise
- * (because the entry for this commit had already been popped).
+ * (because the commit could not be parsed or its entry had already been popped).
  */
 static int push_parent(struct data *data, struct entry *entry,
 		       struct commit *to_push)
@@ -152,6 +155,8 @@ static int push_parent(struct data *data, struct entry *entry,
 		;
 	} else {
 		parent_entry = rev_list_push(data, to_push, 0);
+		if (!parent_entry)
+			return 0;
 	}
 
 	if (entry->commit->object.flags & (COMMON | ADVERTISED)) {
@@ -194,7 +199,6 @@ static const struct object_id *get_rev(struct data *data)
 		if (!(commit->object.flags & COMMON) && !entry->ttl)
 			to_send = commit;
 
-		repo_parse_commit(the_repository, commit);
 		for (p = commit->parents; p; p = p->next)
 			parent_pushed |= push_parent(data, entry, p->item);
 
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 96e224168eb..7479424ca94 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -223,4 +223,36 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
 	have_sent b2.c1 b2.c0
 '
 
+test_expect_success 'recent ancestors are sent before old ref tips' '
+	rm -rf server client trace &&
+	git init server &&
+	test_tick=2000000000 &&
+	test_commit -C server --no-tag base &&
+	test_commit -C server --no-tag parent &&
+	test_commit -C server --no-tag main &&
+	git clone server client &&
+	test_commit -C server --no-tag to_fetch &&
+
+	git -C client checkout -b topic &&
+	test_commit -C client --no-tag topic &&
+
+	# These old tips have known dates, but the recent parent has no ref.
+	# Without parsing parents before queueing them, its date is zero and
+	# all of these tips are sent first, delaying it past the first batch.
+	for i in $(test_seq 32)
+	do
+		old=$(echo "old $i" |
+			GIT_AUTHOR_DATE="1000000000 +0000" \
+			GIT_COMMITTER_DATE="1000000000 +0000" \
+			git -C client commit-tree HEAD^{tree}) &&
+		git -C client update-ref refs/heads/old-$i "$old" || return 1
+	done &&
+
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	trace_fetch client origin &&
+	git -C client rev-parse HEAD HEAD~2 >expect &&
+	sed -n "s/.*fetch> have //p" trace | head -n 2 >actual &&
+	test_cmp expect actual
+'
+
 test_done

Range-diff against v1:
1:  cfb16d16d8c ! 1:  9e9ae442333 negotiator/skipping.c: parse parents before queueing
    @@ Metadata
      ## Commit message ##
         negotiator/skipping.c: parse parents before queueing
     
    -    The skipping negotiator sorts its queue by commit date, but
    -    `push_parent()` can add a parent before parsing it. Its date is still
    -    zero, so old ref tips go ahead of it.
    +    The skipping negotiator sorts its queue by commit date, but callers
    +    which push commits onto that queue, such as `push_parent()`, can add a
    +    parent before parsing it. When an unparsed commit enters the queue, its
    +    date is still zero, so old ref tips may sort ahead of it.
     
         For example, suppose a topic branch is one commit ahead of master.
         Skipping offers the topic tip and skips master's tip. Master's parent
    @@ Commit message
         uses its actual date. If parsing fails, leave the parent out of the
         queue.
     
    +    Since the sole caller of `prio_queue_put()` ensures that commits are
    +    fully parsed before pushing them onto the queue, we can avoid a noop
    +    call to `repo_parse_commit()` within `get_rev()`.
    +
    +    Note that unlike the default negotiator, the skipping negotiator's
    +    version of `rev_list_push()` returns a pointer to an 'entry' struct. As
    +    a consequence, callers must be prepared to handle a NULL return value.
    +    The caller in `push_parent()` gains a NULL-ness check, and the remaining
    +    two callers continue to ignore the return value from `rev_list_push()`.
    +
         Signed-off-by: Taylor Blau <ttaylorr@openai.com>
    -    Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## negotiator/skipping.c ##
    +@@ negotiator/skipping.c: static struct entry *rev_list_push(struct data *data, struct commit *commit, int
    + 	struct entry *entry;
    + 	commit->object.flags |= mark | SEEN;
    + 
    ++	if (repo_parse_commit(the_repository, commit))
    ++		return NULL;
    ++
    + 	CALLOC_ARRAY(entry, 1);
    + 	entry->commit = commit;
    + 	prio_queue_put(&data->rev_list, entry);
     @@ negotiator/skipping.c: static void mark_common(struct data *data, struct commit *seen_commit)
       * entry has the correct flags and ttl.
       *
    @@ negotiator/skipping.c: static void mark_common(struct data *data, struct commit
      static int push_parent(struct data *data, struct entry *entry,
      		       struct commit *to_push)
     @@ negotiator/skipping.c: static int push_parent(struct data *data, struct entry *entry,
    - parent_found:
      		;
      	} else {
    -+		/* Parse the parent before using its date to order the queue. */
    -+		if (repo_parse_commit(the_repository, to_push))
    -+			return 0;
      		parent_entry = rev_list_push(data, to_push, 0);
    ++		if (!parent_entry)
    ++			return 0;
      	}
      
    + 	if (entry->commit->object.flags & (COMMON | ADVERTISED)) {
    +@@ negotiator/skipping.c: static const struct object_id *get_rev(struct data *data)
    + 		if (!(commit->object.flags & COMMON) && !entry->ttl)
    + 			to_send = commit;
    + 
    +-		repo_parse_commit(the_repository, commit);
    + 		for (p = commit->parents; p; p = p->next)
    + 			parent_pushed |= push_parent(data, entry, p->item);
    + 
     
      ## t/t5552-skipping-fetch-negotiator.sh ##
     @@ t/t5552-skipping-fetch-negotiator.sh: test_expect_success 'do not send "have" with ancestors of commits that server AC
    @@ t/t5552-skipping-fetch-negotiator.sh: test_expect_success 'do not send "have" wi
     +	test_config -C client fetch.negotiationalgorithm skipping &&
     +	trace_fetch client origin &&
     +	git -C client rev-parse HEAD HEAD~2 >expect &&
    -+	sed -n "s/.*fetch> have //p" trace >haves &&
    -+	sed -n "1,2p" haves >actual &&
    ++	sed -n "s/.*fetch> have //p" trace | head -n 2 >actual &&
     +	test_cmp expect actual
     +'
     +

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0.187.g9e9ae442333
