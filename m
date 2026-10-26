Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058585;
	b=EFLFaq5SZ9yxoxXtTEoq5NPCq0D/Fm1/YTi97/lgsQ66a937FB2Ry91mSa2xpIn/4OmP
	 wKaCCaqwTHVzX1vdBE4wPGafNOEdyV36iEnNB0aX8NafVQAjJ2jkVgBT1w1pABkN4hcCN
	 124yAd3p4/ut4EvfraRATlRGzIyWme3Sj8x73Gw6DXNUzG7RrghOHAdmqx4dbAIy68DJ1
	 8yqRx2+P0bK2QE2uvVvjXAy6KyseCGz7EWvv7HEhjxmaemrhXVA5D15BQjNLC3OD+lIYZ
	 FrdPoF8fzdcNzorJswM6CU220wqCXRg4LxKFXoDeRYSKcMYDDVxjH8pOonPk002DMqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=m26aWaaHLjyGsQMx8l6oJBC7pp6+z/+qIUe4dCnKREo=;
	b=pXcZwnEBf7ZbStzh43eqDVC7geOp44Xga0iy2s2YPO3+IyktKzSLcuwGwGcmA1qAiYPv
	 nxkNt/F2VPvrsO/sYoeHuyAR6OtiiizRdSugq4lVU6ue7KjAIE4ysLpF7TsJZ/3TC84yd
	 Sb+EPMakYdcZKKUzwSsJFQIRtkX09cdq/ur5MdsZOnQqW+nNpjc2oi6JM7sxD61ofmI/H
	 srOl/t2ySDypRjq2G7NAemlHvP7RRcpisthCBAbJCRgNyBHef46tiPsXBC7EjZR2LsRHA
	 KsUAxGNEZPPsaFd+1FdWHVI/kgDKzhQiVseis5tX73NNEYV+GcmvzOmy8dNmQWy6iJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Yv+codgA;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC85606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 23:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC85606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Yv+codgA
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53cd0c8614eso9811011cf.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793058583; x=1793663383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m26aWaaHLjyGsQMx8l6oJBC7pp6+z/+qIUe4dCnKREo=;
        b=Yv+codgAqDwt1fZ/VvroO2cCiqY91W+n2alyvGrTa4zAQpB7w1fYNAdauM90ejO2II
         z8YiqdRQNmxfp5XaS4feHTGQ6WamC7/H97Whg+NAr1mUszfh1gysBh47jYA2k2hKpCLv
         pDjVz6N8wua+6zSXgt4lEAYyukkifreAYaEXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058583; x=1793663383;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m26aWaaHLjyGsQMx8l6oJBC7pp6+z/+qIUe4dCnKREo=;
        b=EI9hNf5giISlNPbwwwM4yWL1KKUb0vmo8U3Xz1Lz4/3KyMfpEKc353lO6dahsjGIzN
         d+7Tfj4+GstCdnv3VDQHbEYRaEDMQRofkGFAxzMeGpjHK3JmQ6V5oxyb0uelvfgKz+IE
         XyOCxdyJWro7i6V6I684PL4mLwIF/9Hkgo8xik/YKjmQdUvkx05E3KBT3FnzFmNKWF7O
         llec3B3ikI0rI6nrza8wbeLqw/EuIMqvANyC59VvbujbqX5oD/EsYqXl5dUEwPucEEKE
         lJUJVHtf2iAwEJwaB9oBwKE7B535BaXPa8RSJ3FstMp3IkbYlbfMEHFcyjyO6Hha60tm
         wwMw==
X-Gm-Message-State: AFq9FYJKb7YaoiTfC/80Dx9gBS7XLRhaNBdHbHk5nR6S8+AXQu9BUufA
	Wsn4VA7YTPI0uF8pBhAUrwKIukZsX0NAhjBbKrySJOiUm7ygiylaNzVLJ0DtR9f05B4xCVnj6nd
	e2dh6EsA=
X-Gm-Gg: AYBFou1j7MWxs4M6Xi4OsBvurA+SPX0gbgeHwBw8Y8+xVjUFJSNHnVnKKugqxJ9T/G0
	ukkpqd0+pS25ockV4MKoLQwS2I8Yozhe8frC1mFppa3G5h86x26j1JQ7B7GEa8wybG6B6cdnyGb
	PZqmL5pC9Xm9PCFIiPlufpzOb0aiKVFNJPN3rXTJLMEjdkuqGikSZ7YqEnTLSM3Jx0QID798HL2
	WnaXVRTa9F/mZwSc6ev/jut3kBV7egQgDBcjYjwqZiCwkeQG67T9vB+qAzrlZ+Z/F6RPQfrBL7k
	rPeEYFAALGaK0jAmuF5GDZTeOOCzjn8dPV88PezsZa3PoHW1k+X2AD972/7UZ8q7X5eLm/z1KKn
	QE5Nhu7xts3JXR6f4E2pp/vMsAVC9DG7+8ineW+rnaZ/8l951VxTouzdPtQmuTxwDyC3yP1vTll
	8Fpxk/3m8NBaUXrEObj5VS9j8tppgy66IzWP6JhLO24MbnFzTjR0As3+RnZvZJ0FaLFFQzqAJwh
	vUPO6honC2rn6OU3FigD3ZQ/10n2pE892ug8Rkjn7tlQqUACxQJHruHNV7tJSzgo/HM7iWyuZjj
	4jsv4PZd/6OWf4XNaeIG99ut3o3R0xK+42LLiKXOY2acdGDAT75FsI5xljXgDtSINy84
X-Received: by 2002:a05:622a:394:b0:535:a5fa:ee04 with SMTP id d75a77b69052e-5383b61dc72mr119862751cf.68.1793058583244;
        Mon, 26 Oct 2026 16:49:43 -0700 (PDT)
Received: from com-79390 (vpn-eastus-02.tradc-corp.com. [20.102.114.220])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5383970a2basm66895991cf.18.2026.10.26.16.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:49:42 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:49:40 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Derrick Stolee <stolee@gmail.com>, Ted Nyman <tnyman@openai.com>,
	Daniel Reynaud <dreynaud@openai.com>,
	Aaron Friel <friel@openai.com>
Subject: [PATCH v3 2/2] negotiator/skipping.c: parse parents before queueing
Message-ID: <7365a2ab180bc4b534dac3b7515a398a987e8384.1793058562.git.ttaylorr@openai.com>
References: <dc3dfa3647c42da9170bf3289f4e8a4a8a55c8e2.1792441003.git.me@ttaylorr.com>
 <cover.1793058562.git.ttaylorr@openai.com>
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
In-Reply-To: <cover.1793058562.git.ttaylorr@openai.com>

The skipping negotiator sorts its queue by commit date, but callers
which push commits onto that queue, such as `push_parent()`, can add a
parent before parsing it. When an unparsed commit enters the queue, its
date is still zero, so old ref tips may sort ahead of it.

For example, suppose a topic branch is one commit ahead of master.
Skipping offers the topic tip and skips master's tip. Master's parent
then waits behind old ref tips. With enough old refs, negotiation can
end before we offer that recent common ancestor.

Parse commits in rev_list_push() before adding them to the queue, so
the queue uses their actual dates. If parsing fails, leave the commit
out of the queue. Move the parsing from get_rev() to the insertion
point, where the date is needed to order the queue.

Set SEEN only after parsing succeeds, following the default negotiator
after the preceding fix. push_parent() assumes that a commit marked
SEEN but not POPPED has an entry in the queue. Marking an unparseable
parent SEEN would violate that assumption and trigger a BUG() if another
child tried to push the same parent.

Unlike the default negotiator, the skipping negotiator's version of
rev_list_push() returns a pointer to an entry struct. Check for NULL in
push_parent() before using that entry. The other two callers continue
to ignore the return value.

Add tests for the ordering of recent ancestors relative to old ref tips
and for two tips sharing a missing parent. In the latter case, fetching
from a server that has the parent should retrieve it without triggering
the missing-entry BUG().

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 negotiator/skipping.c                |  9 +++-
 t/t5552-skipping-fetch-negotiator.sh | 63 ++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index db90fa77b53..a7c7b8d9e94 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -64,6 +64,10 @@ static int compare(const void *a_, const void *b_, void *data UNUSED)
 static struct entry *rev_list_push(struct data *data, struct commit *commit, int mark)
 {
 	struct entry *entry;
+
+	if (repo_parse_commit(the_repository, commit))
+		return NULL;
+
 	commit->object.flags |= mark | SEEN;
 
 	CALLOC_ARRAY(entry, 1);
@@ -125,7 +129,7 @@ static void mark_common(struct data *data, struct commit *seen_commit)
  * entry has the correct flags and ttl.
  *
  * This function returns 1 if an entry was found or created, and 0 otherwise
- * (because the entry for this commit had already been popped).
+ * (because the commit could not be parsed or its entry had already been popped).
  */
 static int push_parent(struct data *data, struct entry *entry,
 		       struct commit *to_push)
@@ -152,6 +156,8 @@ static int push_parent(struct data *data, struct entry *entry,
 		;
 	} else {
 		parent_entry = rev_list_push(data, to_push, 0);
+		if (!parent_entry)
+			return 0;
 	}
 
 	if (entry->commit->object.flags & (COMMON | ADVERTISED)) {
@@ -194,7 +200,6 @@ static const struct object_id *get_rev(struct data *data)
 		if (!(commit->object.flags & COMMON) && !entry->ttl)
 			to_send = commit;
 
-		repo_parse_commit(the_repository, commit);
 		for (p = commit->parents; p; p = p->next)
 			parent_pushed |= push_parent(data, entry, p->item);
 
diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 96e224168eb..0efd2f2ac49 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -223,4 +223,67 @@ test_expect_success 'do not send "have" with ancestors of commits that server AC
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
+test_expect_success 'missing parent shared by two tips is not treated as queued' '
+	rm -rf server client trace &&
+	git init server &&
+	test_commit -C server base &&
+	parent=$(git -C server rev-parse HEAD) &&
+	test_commit -C server to_fetch &&
+
+	git init client &&
+	tree=$(git -C client mktree </dev/null) &&
+	# Write the tips directly, bypassing the parent lookup in commit-tree.
+	# Both tips name a parent that only the server has.
+	for i in 1 2
+	do
+		cat >commit <<-EOF_COMMIT &&
+		tree $tree
+		parent $parent
+		author A U Thor <author@example.com> 1000000000 +0000
+		committer C O Mitter <committer@example.com> 1000000000 +0000
+
+		tip $i
+		EOF_COMMIT
+		tip=$(git -C client hash-object -w -t commit --stdin <commit) &&
+		git -C client update-ref refs/heads/tip-$i "$tip" || return 1
+	done &&
+
+	test_config -C client fetch.negotiationalgorithm skipping &&
+	trace_fetch client "$(pwd)/server" \
+		--negotiation-tip=tip-1 --negotiation-tip=tip-2 &&
+	git -C client cat-file -e "$parent"
+'
+
 test_done
-- 
2.56.0.187.g9e9ae442333
