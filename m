Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E371E5B88
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777083; cv=none; b=OuSFlsePAsM2ViCKUWSv0/ahx//3JQuShBZ9lDlvbit7satwpqFtvwC1lBPKrnv8JTsP4r3Y3kaPlSGxL2btQCV0gMRkQxJF4cEIiKLtie/9lhxtxdN936I0/8DvZPIJRmdY2ezTuUfXtXwv0PY4Wqvc91Q72jr4cZOZkS+sRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777083; c=relaxed/simple;
	bh=AAlcZ15AajZfkfzhc1/oW1znfe3R8O7oJ5ttiCTNsVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i99938nFOKWidkYCIyiXYdotpgv5oEtsDkZf9ks9z0C9p7VuOWQYbnGUKjSHAyDXjesQhSJMqijennLD/eVetoXwzdZTmhxD4DC/M1uZFesb37pmR/apNU59T66JrvKgRVpPKySacdh6K6eZ5WMIivyqkbIgvv1Dm2qsnrnsrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INExF654; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INExF654"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ec555a26so12322305e9.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783777080; x=1784381880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Tn/FVNTSNfCAP1bRVvO7qnZx3qOrrTRx9xdsqB4aYs=;
        b=INExF654qh/vJVfh/QYJdf9QWm0NCq0rEIcdMCjwc5MQaiP+dZDek+XJLL34BhtXkj
         P3EE2TjXUwWrWKFs0RFmABnRFZVf8SJSw+IAAyDDvRQv25WYICsZYqIFtkmeTpenUg58
         iDbGFLRKowlj1hEgGmddbA2iiHfgghmXCQSf4pLA1u/pIXEZrb42/zMkg6xV+N+GgWzF
         4OwY9caqV3FXM8aPQR5suZqTcEkOAvA5iRC7YZAMVCW8zCxy9iquSYRII79W1ufprD+Z
         o7zsgDguzlQjahmS+GgoU3fMLd42QeBNTCjHw29O6yyRPr5aqim4PU6Fm4RRZo06rOyD
         rwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783777080; x=1784381880;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Tn/FVNTSNfCAP1bRVvO7qnZx3qOrrTRx9xdsqB4aYs=;
        b=WRxGH16gj3ljx7TXrM6EixLsdqMTux07ZcCNGHX7/v6CHQfN4VxBTJrLKjoY0ecpqO
         459XuDYoXWUEqtq6VVRLgKp99IgvlwrafW73FlvEv0UMi92Qa0XrrsG5UZLR+dUIRQmS
         ook0y2kBv6GrSk+gLKxYCQLbaP9QrETFwEd4uUhX/8dL/N93xpP+MlwViMdDkDYuzWeN
         UYzSV3E2SK5SOeTKWcjH8mbffONL8sjVOfYrGo7OuhBWkAYYm+lbFvkUzZuMzpub856D
         v6QlPmkHYSQg9yr2q4YlN7DrG63jI/1HIxIBAQ//8n2VHhVU9jDYN/Iz7UYyn/69BTvu
         Ygpw==
X-Gm-Message-State: AOJu0YzVCMW51p6ojMEuy0TIelfx5pv2MNlL0Xt7wk+hXr9m1a+uk2Mw
	gk1OIC1bq3eEU1Xwus12jlch7846vyntf1Kwxj2T3X4je5lGtnZ1CCdxNY/H3/0f
X-Gm-Gg: AfdE7cnz/w8Z7E6e8PGmzaRkZc8gkkhCO0LWChAuAgB6egw5lYWSF5x/cUI58ctvlCy
	gQz9ScWUMNPGiBinZduaB71phJ/A0g3bYL8/hzjatiDxTF00zrgFYKIG0BqfNauC5INIP64JNMO
	+xWBUmVib7rMpBVKo9Na1ulVw0CiT2HDyoCcfk0pzhOxflJh5BqlPcCoYrMAO1GL+E40iy6qXul
	2pJXz9tiuaF8rzAo4+DLWGGKx4M2uwy0ExpPRdeSDXe4PIxYUXsHbw4edarJUFdT/jelcsgpIiB
	blP+YPwaZ8QACqTD42CMxClaR099fAdw12c8ZY0Ca6WvHkyRg3vl0JLLBdDW7PoNxRsp8Cu+7/F
	IKNQA+KyeJQlP+nb8XJPWTg3E7b7QBVqlOWYlK5PHT0oQVXSvjiuP8W4V0b1zFxEWhdYlRI4Fj9
	YZk1Gs7iB1dAwKs0UzdqZBS90HrEBSzGkDrrHXY6jNLebl/PbnUVKDcp+TWfrsI4Nlnt+mPClbE
	YuCe+6QJtYxjOolLtScMqtpmdfQ9cBkZyQn3DE1GvKu/mr/kYf31BDcX0du9pPirIL6aYJtzc/Z
	i4TlP5tMnv9rFNYsbdkn+ieT+mFUHpJDU8lLzLw9h+qVfD1egDBmNoodMbZBCrIKfvrXeATTpSX
	AtAIbPj8UFOyoDyJz0dPW
X-Received: by 2002:a05:600c:190f:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-493f87e5b7fmr28302795e9.15.1783777079749;
        Sat, 11 Jul 2026 06:37:59 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4f09f89sm220999015e9.10.2026.07.11.06.37.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Jul 2026 06:37:59 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	mroik@delayed.space,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v9 0/4] graph: indent visual roots in graph
Date: Sat, 11 Jul 2026 15:37:49 +0200
Message-ID: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

Before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

After indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after
them, and if they have children it connects them with an edge at a new
row.

If there are multiple visual roots adjacent in history, the indentation
starts with the second one, avoiding redundant indentation of the first
one and cascades after the second.

	* A
	  * B
	    * C
	* D1
	* D2

This series first commit is a cleanup that brings a common function
from t4215 and t6016 to a graph functions file which they both use, so
the new test file for indentation, t4218, can use it as well.

GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29154333559

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V8 DIFF:

- Checking if the parents of a commit are NULL is not enough to know if
  the commit is a visual root due to options that filter the commit
  parents but they do not remove them (--author, --grep, etc).
  At graph_is_visual_root_candidate(), iterate the parents and call
  graph_is_interesting() for each of them to know whether they will be
  shown or not.
- Add a --author and a --grep test.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>

---
Pablo Sabater (4):
      lib-log-graph: move check_graph function
      revision: add next_commit_to_show()
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph

 graph.c                                    | 295 +++++++++++++++++
 graph.h                                    |  17 +
 revision.c                                 |  48 ++-
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +-
 t/t4218-log-graph-indentation.sh           | 514 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 8 files changed, 893 insertions(+), 45 deletions(-)

Range-diff versus v8:

1:  ce4f6419c2 = 1:  22ab444372 lib-log-graph: move check_graph function
2:  8c7326745e = 2:  ebb88c8b29 revision: add next_commit_to_show()
3:  f2e895c72b = 3:  0705ee321e graph: add a 2 commit buffer for lookahead
4:  90d5d22344 ! 4:  fa2e60fb3f graph: indent visual root in graph
    @@ graph.c: void graph_push_lookahead(struct git_graph *graph, struct commit *c)
     + * - It has parents but they are all filtered out and
     + *   commit->parents arrives NULL.
     + *
    ++ * - Its parents are uninteresting.
    ++ *
     + * - It is not a boundary commit. Boundary commits also have no visible
     + *   parents, but they are not selected as visual roots because they cannot
     + *   cause the ambiguity of being vertically adjacent because:
    @@ graph.c: void graph_push_lookahead(struct git_graph *graph, struct commit *c)
     + *      ancestor of the boundary it would be excluded and not rendered.
     + *      Boundaries therefore always sink to the bottom.
     + */
    -+static int graph_is_visual_root_candidate(struct commit *c)
    ++static int graph_is_visual_root_candidate(struct commit *c, struct git_graph *graph)
     +{
    -+	return c->parents == NULL && !(c->object.flags & BOUNDARY);
    ++	struct commit_list *p;
    ++
    ++	if (c->object.flags & BOUNDARY)
    ++		return 0;
    ++	for (p = c->parents; p; p = p->next)
    ++		if (graph_is_interesting(graph, p->item))
    ++			return 0;
    ++	return 1;
     +}
     +
     +static int graph_is_visual_root(struct git_graph *graph,
    @@ graph.c: void graph_push_lookahead(struct git_graph *graph, struct commit *c)
     +	 * current commit has to act as the last commit and omit
     +	 * indentation.
     +	 */
    -+	return graph_is_visual_root_candidate(graph->commit) &&
    ++	return graph_is_visual_root_candidate(graph->commit, graph) &&
     +	       !(graph->commit_in_columns &&
     +		 graph->columns[graph->commit_index].is_merge_parent) &&
     +	       flags->is_next_visible &&
    @@ graph.c: void graph_push_lookahead(struct git_graph *graph, struct commit *c)
     +	flags->next_has_column =
     +		graph_find_new_column_by_commit(graph, graph->lookahead[0]) >= 0;
     +
    -+	if (!graph_is_visual_root_candidate(graph->lookahead[0]))
    ++	if (!graph_is_visual_root_candidate(graph->lookahead[0], graph))
     +		return;
     +
     +	if (graph->lookahead_nr >= 2)
    @@ t/t4218-log-graph-indentation.sh (new)
     +	EOF
     +'
     +
    ++# when the graph commits are filtered with regex options like --author, the
    ++# commit parents do not come NULL so it is needed to check if the parents are
    ++# interesting.
    ++test_expect_success '--author skipped parent makes a visual root' '
    ++	create_orphan _55 &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 55_A &&
    ++	create_orphan _54 &&
    ++	test_tick &&
    ++	git commit --allow-empty --author="Other <other@example.com>" -m 54_A &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 54_B &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 54_C &&
    ++	lib_test_check_graph --author="A U Thor" _54 _55 <<-\EOF
    ++	* 54_C
    ++	 \
    ++	  * 54_B
    ++	* 55_A
    ++	EOF
    ++'
    ++
    ++test_expect_success '--grep skipped parent makes a visual root' '
    ++	create_orphan _57 &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 57_keep_A &&
    ++	create_orphan _56 &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 56_skip &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 56_keep_A &&
    ++	test_tick &&
    ++	git commit --allow-empty -m 56_keep_B &&
    ++	lib_test_check_graph --grep=keep _56 _57 <<-\EOF
    ++	* 56_keep_B
    ++	 \
    ++	  * 56_keep_A
    ++	* 57_keep_A
    ++	EOF
    ++'
    ++
     +test_done

---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47
