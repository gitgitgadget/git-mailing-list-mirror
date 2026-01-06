Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14B32694F
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704346; cv=none; b=osg26uwEPtMKJBvxPtvyJi/DUQnDU0cEXmBCcnnf/PmYbLSEczGMhkiDzgjOe3P/E8XE0slll18pRfSZi3FXG2XRGJNWBnWfZXQ0SgchUrPVrbZ0KDE+wuwRRG7p+p7JeTMxQhtc563o7HhmsQttn7583hpkB2sPnRMpQqDiCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704346; c=relaxed/simple;
	bh=jGMQFHUrR0fLghAjHOSWqb8keQJnDrNu0zUr4GII2qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrZM1ZD8BDxhFBjTarUmgOFLvt8AxNGwztWIRsvpxvAQhLxUcvl5UXB18NK+BoEDJO8Ip0EzG9gdsKs7Udud2SLndQDsaJNSz8RhfTxCHUlcT9rQlUy/6T2Q4O0Gny6R7aTjC03xksofnclIpvQf0eq8VJ9y7kx0qhS1C9AzBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cD2xq8nO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gv3rO4DJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cD2xq8nO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gv3rO4DJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C13887A0054;
	Tue,  6 Jan 2026 07:59:03 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 07:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767704343;
	 x=1767790743; bh=+lUlLSgnih4LWzxJ4Qu1NarsTM5i6/KM9vHuFB3lGAQ=; b=
	cD2xq8nO7tXvoT1aHTyVSvFqEpkxAY2e9ZyRBEiuM/Ciy5XHMXtwlnuFbBkEWGUv
	G3424MmYJe8jRFfNm9ghx5w3RVCPAj2QFoBP+tX9iFNbhQkY66+bIhx7OFJll9i9
	I10uzzzKBp5UYq+T9s5ENEKL199n1pyN8x8vTKAiSoV2hPHJo8DorbDiGnPJy3t5
	x9rAe9yJC+ZLj3TGi0yUUZ70hVdQc74gOSemk8AKP9+1XAy1AOWyADEX9hIhvNYx
	mXecW4co01GZCU+EX3LSDP2bSKCg5zbSqOHx8/8nMrAGQRiF7rS0+0qEIyI4Qfgn
	u7zUjOFMRUbS731YhX3Nmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767704343; x=
	1767790743; bh=+lUlLSgnih4LWzxJ4Qu1NarsTM5i6/KM9vHuFB3lGAQ=; b=g
	v3rO4DJiNl2ES7OdFfcZusUhiUPwZTvE5xBn3EEjf03gbaAkFlEfBm+9YTQtE6wm
	/wm2VQZaRDDerok6ZZS+ZxVZEPWwwPW9xhdEeufTviC50zWkQ2mdeGFU9FrGdOIg
	1DSEo5EnBNV9Q9SZ7xRnuG7qrpCmO8dJitib14W9Ki44B0XPQhTLC+7RhniWQ5vs
	E5TVuUG1ZS8YGG0OEF5mXocMyxbQjdFOZNL1WQlAIME+8xZEV3jjxBse7wX6M53e
	pwzODcNuN618YtmAr+E2rLe64YFmwztjhqPJpre0aGybYOmLd56bug+fddr+/aVc
	nFjwpZmis66mD50vnF+wg==
X-ME-Sender: <xms:FwddaeKANHjycUeiFFjwKjOA8YzwxhBsoVTTTzthfqkaMRJAnPi0lA>
    <xme:FwddadKsrIk82jxXcOWA3aD7mgtIuHdLI4Nmyhjt4D-Xn7yzrnjgZGUqmWAadbdG2
    A_6DRHZEspu4X-v8pAewSPs7hB7fwNLrklDZ86l5zZpK0epx05AB2Y>
X-ME-Received: <xmr:FwddaTtPTJ0bUypgW7iX-m3SdwzrzYtkaUBE0-GejnZU2oAK5D7765C0dEwXrVhPrPvcE-susUMkm5Z-0D97WgFYZ73dgXDEza0L6TUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelkeefvdfhieeffffhhedthfefhfffheefvdffudehheetffehgeffgfelleefuden
    ucffohhmrghinheptghomhhmihhtqdhgrhgrphhhrdgruhhtohenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FwddaSTMMJbBn2kXXPMw8LHA8VXA-GbfEeITIJ053gc0sa2eLpGTbA>
    <xmx:FwddaRN5oOAq_JaavIv5EqhFVXJnfIbiad3WI4BOYn1kWWD0qdIoyQ>
    <xmx:FwddafbsNDdUEatVNdSJndqPY6B2UGxYSgoVuxCK7km6aSBe3TVCbg>
    <xmx:FwddaTz8IF2di4OQBbqxZo2teXMOphHnbI7wAny6Pdoo0jscVxstUg>
    <xmx:FwddaTOtmYoWmGoOYZ7w1Scb18VUIeNKEHRNtPrUcz-_AZ7mpKlxiDzb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 07:59:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22579745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 12:59:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 Jan 2026 13:58:49 +0100
Subject: [PATCH v3 1/2] builtin/gc: fix condition for whether to write
 commit graphs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-odb-related-fixes-v3-1-7ac157207b20@pks.im>
References: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
In-Reply-To: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

When performing auto-maintenance we check whether commit graphs need to
be generated by counting the number of commits that are reachable by any
reference, but not covered by a commit graph. This search is performed
by iterating through all references and then doing a depth-first search
until we have found enough commits that are not present in the commit
graph.

This logic has a memory leak though:

  Direct leak of 16 byte(s) in 1 object(s) allocated from:
      #0 0x55555562e433 in malloc (git+0xda433)
      #1 0x555555964322 in do_xmalloc ../wrapper.c:55:8
      #2 0x5555559642e6 in xmalloc ../wrapper.c:76:9
      #3 0x55555579bf29 in commit_list_append ../commit.c:1872:35
      #4 0x55555569f160 in dfs_on_ref ../builtin/gc.c:1165:4
      #5 0x5555558c33fd in do_for_each_ref_iterator ../refs/iterator.c:431:12
      #6 0x5555558af520 in do_for_each_ref ../refs.c:1828:9
      #7 0x5555558ac317 in refs_for_each_ref ../refs.c:1833:9
      #8 0x55555569e207 in should_write_commit_graph ../builtin/gc.c:1188:11
      #9 0x55555569c915 in maintenance_is_needed ../builtin/gc.c:3492:8
      #10 0x55555569b76a in cmd_maintenance ../builtin/gc.c:3542:9
      #11 0x55555575166a in run_builtin ../git.c:506:11
      #12 0x5555557502f0 in handle_builtin ../git.c:779:9
      #13 0x555555751127 in run_argv ../git.c:862:4
      #14 0x55555575007b in cmd_main ../git.c:984:19
      #15 0x5555557523aa in main ../common-main.c:9:11
      #16 0x7ffff7a2a4d7 in __libc_start_call_main (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a4d7) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
      #17 0x7ffff7a2a59a in __libc_start_main@GLIBC_2.2.5 (/nix/store/xx7cm72qy2c0643cm1ipngd87aqwkcdp-glibc-2.40-66/lib/libc.so.6+0x2a59a) (BuildId: cddea92d6cba8333be952b5a02fd47d61054c5ab)
      #18 0x5555555f0934 in _start (git+0x9c934)

The root cause of this memory leak is our use of `commit_list_append()`.
This function expects as parameters the item to append and the _tail_ of
the list to append. This tail will then be overwritten with the new tail
of the list so that it can be used in subsequent calls. But we call it
with `commit_list_append(parent->item, &stack)`, so we end up losing
everything but the new item.

This issue only surfaces when counting merge commits. Next to being a
memory leak, it also shows that we're in fact miscounting as we only
respect children of the last parent. All previous parents are discarded,
so their children will be disregarded unless they are hit via another
reference.

While crafting a test case for the issue I was puzzled that I couldn't
establish the proper border at which the auto-condition would be
fulfilled. As it turns out, there's another bug: if an object is at the
tip of any reference we don't mark it as seen. Consequently, if it is
the tip of or reachable via another ref, we'd count that object multiple
times.

Fix both of these bugs so that we properly count objects without leaking
any memory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  8 +++++---
 t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 92c6e7b954..17ff68cbd9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1130,8 +1130,10 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 		return 0;
 
 	commit = lookup_commit(the_repository, maybe_peeled);
-	if (!commit)
+	if (!commit || commit->object.flags & SEEN)
 		return 0;
+	commit->object.flags |= SEEN;
+
 	if (repo_parse_commit(the_repository, commit) ||
 	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return 0;
@@ -1141,7 +1143,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 	if (data->num_not_in_graph >= data->limit)
 		return 1;
 
-	commit_list_append(commit, &stack);
+	commit_list_insert(commit, &stack);
 
 	while (!result && stack) {
 		struct commit_list *parent;
@@ -1162,7 +1164,7 @@ static int dfs_on_ref(const struct reference *ref, void *cb_data)
 				break;
 			}
 
-			commit_list_append(parent->item, &stack);
+			commit_list_insert(parent->item, &stack);
 		}
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6b36f52df7..7cc0ce57f8 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -206,6 +206,31 @@ test_expect_success 'commit-graph auto condition' '
 	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
 '
 
+test_expect_success 'commit-graph auto condition with merges' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		test_commit initial &&
+		git switch --create feature &&
+		test_commit feature-1 &&
+		test_commit feature-2 &&
+		git switch - &&
+		test_commit main-1 &&
+		test_commit main-2 &&
+		git merge feature &&
+
+		# We have 6 commits, none of which are covered by a commit
+		# graph. So this must be the boundary at which we start to
+		# perform maintenance.
+		test_must_fail git -c maintenance.commit-graph.auto=7 \
+			maintenance is-needed --auto --task=commit-graph &&
+		git -c maintenance.commit-graph.auto=6 \
+			maintenance is-needed --auto --task=commit-graph
+	)
+'
+
 test_expect_success 'run --task=bogus' '
 	test_must_fail git maintenance run --task=bogus 2>err &&
 	test_grep "is not a valid task" err

-- 
2.52.0.508.g883dcfc63e.dirty

