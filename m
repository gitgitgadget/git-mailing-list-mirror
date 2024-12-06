Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AC328B6
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472435; cv=none; b=gy4aQs6e7WPLMWThPEo+9JrXpEYHHzUVYjLBlWW0E+qLfhORtrqajbklFSGoa8hPj+dpflDHFeFZ70hv43d+OObgkGCrFOIytZiymolVp6P4fsFZCHmPkhDyVE8/l2PNFDpsJ30+ZjETljTyS44nEi6ZhE6NHBrVvvxu2qlLoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472435; c=relaxed/simple;
	bh=MRrRkIJ6W1GnahSM/0y7eVvEQ7vYs3UuMBjpNrhxM4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uDHAthhnMJkQEAiwLn7qLfhKrO5hdO8UYND6YOH0Z5zZZwqTGak6Oza4A35MQYyVE7i9fFU4iNcJbfnEqjPPWVU0lN8FqoSLXTkpaAmC4mmQfYDK8kZHqzGnGAbyRhOk5SQoQMhZ0sjQ6ci6jA+3vDOJx4iKnWO19ZjrFHItiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OsqA6rQT; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OsqA6rQT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C1DD114015B;
	Fri,  6 Dec 2024 03:07:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 06 Dec 2024 03:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733472432; x=
	1733558832; bh=jfeo1Q0NZpRdcK43K1qhyecGbO9BgeYE/TZZ6TQb7ZI=; b=O
	sqA6rQTP5MEg56PGu2vCJiqBNsoVN9bVjVyBzkSz/3eWigBIW2jEOkhDLmd+eGDJ
	LoKd+eYV6tAqLPDwYw28XsZQnxxwMphjQQTGZVPfeD+p7VLZOT18nYwt8vAnweRf
	+sCodERfR7/a6mUixuAtxl4ZCD0qYSIqYHwXnBiZ5jC+ISIcLOcrB+TMTo8NzFeb
	1Ehs+V1aVFtWbLu3LaAKqGZIpw2diEaIdDTA13LSprl/cKIVHzoPldSwy4deDooA
	kBkblBAcxvsiOmn8xJrYe4yU2YzNjPHrvr4PKou4u5o9yEAu/4XSEkBKG4PhEfej
	e85whS/7SQS9/yEW9fAIw==
X-ME-Sender: <xms:r7BSZw48G129Ibd1Uiqy3RWU_6dQJjxcbrAW4ErJKRZR3wfBAPrA_A>
    <xme:r7BSZx5Ca-WBeGVSMFeCQoLViz4mWYSTvfAIR07x-3LNyS2a4v_8V_SoY2lMb8P9V
    4gi_dlcHKBM7Moepg>
X-ME-Received: <xmr:r7BSZ_dyGvtY_ihugAskhzgJVelZgcNu8QVRvYiCzhoh4r6-Sf18h1aoSAJZAIpuZvsVkgjVVIOV6gZm7ERz_ixgKDzGf4NgFz96S9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhffhkefhveekveelvefgkeetgedvuddv
    keefgfejvdfhffdvhfeuvdetveejueenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hfvghttghhrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhi
    nhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhs
    sehpkhhsrdhimh
X-ME-Proxy: <xmx:r7BSZ1JJJCDepXYUzVFJT6UaYtluxpZlJJqNV4j3rNyJopVYu0E_nw>
    <xmx:r7BSZ0KoLjkYqTp1LiO-UShQUBTtqQy6S5zcUlEMIfu_lp8dAvKobA>
    <xmx:r7BSZ2yMxx0ncCXi6RH2y9pdwdLO4QYmqsOP3F_Pv2ce3_QpfDXJUQ>
    <xmx:r7BSZ4JjTYThG2Rb1Vg28-hdfMuxD57YIy2zkUkxPaA3e6RrWo483Q>
    <xmx:sLBSZyySSX59lfYfq6kEYN6kezEeU-AxRdyz0SCi9TQX8Sv1ojWVvoQN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 03:07:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  bence@ferdinandy.com,  phillip.wood@dunelm.org.uk,
  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  karthik.188@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@google.com
Subject: Re* [PATCH] Fix `git fetch --tags` in repo with no configured remote
In-Reply-To: <xmqqcyi5zdzb.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Dec 2024 12:28:56 +0900")
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
	<b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
	<xmqqcyi5zdzb.fsf@gitster.g>
Date: Fri, 06 Dec 2024 17:07:09 +0900
Message-ID: <xmqqfrn1xmj6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> Stepping back a bit, do we even need to learn where HEAD points at
> in the remote, when we are not doing the "opportunistically set
> $REMOTE/HEAD"?  Your example is "in repo with no configured remote",
> which by definition means that we do not use any refs/remotes/*/ ref
> hierarchy to keep track of the remote-tracking branches for the
> remote we are fetching from.  There is no place we record what we
> learn by running ls-remote HEAD against them, so should we even push
> "HEAD" to the ls-remote prefixes in such a case?
>
> While this change may hide the breakage you saw in your set-up, we
> may be now asking to ls-remote HEAD even in cases we do not need to.
>
>> Fix this by adding HEAD to the ref_prefixes list prior to handling the
>> `--tags` flag, and removing the now obsolete check whether ref_prefixes
>> is empty or not.
>
> And if we unconditionally add HEAD even when we do not need to,
> especially with the loss of the ref-prefixes condition that was
> there in order to implement "learn refs/tags/* hierarchy only when
> we are doing the default fetch", wouldn't it mean we may learn
> refs/tags/* even when we do not have to?

In other words, what I think the "fix" should look like is more like
the attached.  It seems to pass your test, as well as existing tests
Bence added and other tests about "git fetch".

One thing I am not happy about is the abstraction violation that is
needed to make the uses_remote_tracking() helper aware of the "use
the rs, the refspec given from the command line, or if it is empty,
use the configured 'fetch' refspec from the remote" rule, which is
primarily used by get_ref_map() that is much later called, but the
layering violation started when we started limiting the ls-remote
request with narrowing common prefixes, and it would take a larger
surgery to fix, I would think.

００００---- >8 ----
Subject: [PATCH] fetch: do not ask for HEAD unnecessarily

In 3f763ddf28 (fetch: set remote/HEAD if it does not exist,
2024-11-22), git-fetch learned to opportunistically set $REMOTE/HEAD
when fetching by always asking for remote HEAD, in the hope that it
will help setting refs/remotes/<name>/HEAD if missing.

But it is not needed to always ask for remote HEAD.  When we are
fetching from a remote, for which we have remote-tracking branches,
we do need to know about HEAD.  But if we are doing one-shot fetch,
e.g.,

  $ git fetch --tags https://github.com/git/git

we do not even know what sub-hierarchy of refs/remotes/<remote>/
we need to adjust the remote HEAD for.  There is no need to ask for
HEAD in such a case.

Incidentally, because the unconditional request to list "HEAD"
affected the number of ref-prefixes requested in the ls-remote
request, this affected how the requests for tags are added to the
same ls-remote request, breaking "git fetch --tags $URL" performed
against a URL that is not configured as a remote.

Make sure we ask to list "HEAD" from the remote only when we are
fetching with configured remote for which we use remote-tracking
branches.

Reported-by: Josh Steadmon <steadmon@google.com>
[jc: tests are also borrowed from Josh's patch]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Even though I borrowed some part of the commit log message from
   Josh's version, it not clear to me how "*after* deciding" led to
   whatever the observed breakage (which was not described in the
   log message), in the following part.

      Specifically, we now unconditionally add HEAD to the
      ref_prefixes list, but we did this *after* deciding whether we
      also need to explicitly request tags.

   Bence's change asks "HEAD" after "if we are fetching something,
   then also ask about refs/tags/" logic thought we are not fetching
   anything (i.e. ref_prefixes.nr == 0 at that point).  But before
   Bence's series, the same refs/tags/ logic saw that (ref_prefix.nr
   == 0), didn't it?  So that does not sound like a sufficient
   explanation on how the series regressed.

 builtin/fetch.c  | 20 +++++++++++++++++++-
 t/t5510-fetch.sh | 17 +++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git c/builtin/fetch.c w/builtin/fetch.c
index a64de4485f..3eb6f3acc9 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -1643,6 +1643,21 @@ static int set_head(const struct ref *remote_refs)
 	return result;
 }
 
+static int uses_remote_tracking(struct transport *transport, struct refspec *rs)
+{
+	if (!remote_is_configured(transport->remote, 0))
+		return 0;
+
+	if (!rs->nr)
+		rs = &transport->remote->fetch;
+
+	for (int i = 0; i < rs->nr; i++)
+		if (rs->items[i].dst)
+			return 1;
+
+	return 0;
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1712,7 +1727,10 @@ static int do_fetch(struct transport *transport,
 				    "refs/tags/");
 	}
 
-	strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	if (uses_remote_tracking(transport, rs)) {
+		must_list_refs = 1;
+		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
+	}
 
 	if (must_list_refs) {
 		trace2_region_enter("fetch", "remote_refs", the_repository);
diff --git c/t/t5510-fetch.sh w/t/t5510-fetch.sh
index 87698341f5..d7602333ff 100755
--- c/t/t5510-fetch.sh
+++ w/t/t5510-fetch.sh
@@ -189,6 +189,23 @@ test_expect_success 'fetch --prune --tags with refspec prunes based on refspec'
 	git rev-parse sometag
 '
 
+test_expect_success 'fetch --tags gets tags even without a configured remote' '
+	REMOTE="$(pwd)/test_tag_1" &&
+	git init test_tag_1 &&
+	(
+		cd test_tag_1 &&
+		test_commit foo
+	) &&
+	git init test_tag_2 &&
+	(
+		cd test_tag_2 &&
+		git fetch --tags "file://$REMOTE" &&
+		echo "foo" >expect &&
+		git tag >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success REFFILES 'fetch --prune fails to delete branches' '
 	cd "$D" &&
 	git clone . prune-fail &&
