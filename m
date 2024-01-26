Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE31637
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228801; cv=none; b=ZAcRzufszaKR/GMpBI9N1e4QnNjT0tJbFdBe6syInA/CSqrAkaZ6NVQqKiaHdfX6E0lMcM/yD3AAQXgpOxru6/e4oHUaBc/UHSy3T5YudRVvXTG/qFRjVY26PbPvOdx9/7iYctegNbwdK+ZgqXPP8vmcN/HcclTKTGC3BX5FkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228801; c=relaxed/simple;
	bh=Gl7HNexL6ZQi2xHx2nfYDiKgBBfO14pDmdauFp54DjQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFaYNXwZzZjxke9KW80NwN/htcdhh0+zUqx2vtC7kYbkZogBf0tID72Db6xW/610qvHVNkk7YnO2+woVVtVQZuCnsKl3pwZsFsVcu+32WG7hrnu954EGYvT0aIhgwo7UA9sCMh24SDWfpJ6TwF4rLfzGBomEyOinQRvuI37+TSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uzoPZdS5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uzoPZdS5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73D3E1C1AAA;
	Thu, 25 Jan 2024 19:26:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Gl7HNexL6ZQi2xHx2nfYDiKgBBfO14pDmdauFp
	54DjQ=; b=uzoPZdS5d7faH4vav39eBvaO/JzbfBi+L50F5Vf7WI6Jzv8bM+VXPB
	/tE25iZOAve5Wuv3iE77/Cygo0iNyhH6BSagD4SUnSauVVNvEnrl8UjjwkCed3kG
	dS2oGT7y6K5okZqO+C0bivTH/HYKcuQgaACe7r3CA0VQBihZeXDus=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1251C1AA9;
	Thu, 25 Jan 2024 19:26:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDEB81C1AA8;
	Thu, 25 Jan 2024 19:26:37 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2024, #07; Tue, 23)
In-Reply-To: <xmqqfryntw4x.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jan 2024 16:25:50 -0800")
References: <xmqqfryntw4x.fsf@gitster.g>
Date: Thu, 25 Jan 2024 16:26:36 -0800
Message-ID: <xmqq5xzhq6rn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 917C8764-BBE1-11EE-960E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

The next issue (#08) will appear tomorrow, but here is the changes
of the draft for it, relative to #07, after today's integration.

-What's cooking in git.git (Jan 2024, #07; Tue, 23)
+What's cooking in git.git (Jan 2024, #08; Thu, 25)

--------------------------------------------------
Born topics

[New Topics]

 * jc/coc-whitespace-fix (2024-01-23) 1 commit
  - CoC: whitespace fix
 
  Docfix.
 
  Will merge to 'next'.
  source: <xmqqmssvnb8d.fsf_-_@gitster.g>

 * jc/ls-files-doc-update (2024-01-25) 1 commit
  - ls-files: avoid the verb "deprecate" for individual options
 
  The documentation for the --exclude-per-directory option marked it
  as deprecated, which confused readers into thinking there may be a
  plan to remove it in the future, which was not our intention.
 
  Will merge to 'next'.
  source: <xmqqjznybfp4.fsf@gitster.g>

 * jk/fetch-auto-tag-following-fix (2024-01-24) 1 commit
  - transport-helper: re-examine object dir after fetching
 
  Fetching via protocol v0 over Smart HTTP transport sometimes failed
  to correctly auto-follow tags.
 
  Will merge to 'next'.
  source: <20240124010056.GA2603087@coredump.intra.peff.net>

 * ps/reftable-compacted-tables-permission-fix (2024-01-24) 1 commit
  - reftable/stack: adjust permissions of compacted tables
 
  Reftable bugfix.
 
  Will merge to 'next'.
  source: <b2fb6f5ad0c558527341bd8040544d6b0ae5d8a2.1706100744.git.ps@pks.im>

 * jc/index-pack-fsck-levels (2024-01-25) 2 commits
  - index-pack: --fsck-objects to take an optional argument for fsck msgs
  - index-pack: test and document --strict=<msg>
 
  The "--fsck-objects" option of "git index-pack" now can take the
  optional parameter to tweak severity of different fsck errors.
 
  Expecting a reroll.
  cf. <xmqq8r4dt4k5.fsf@gitster.g>
  source: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>

 * zf/subtree-split-fix (2024-01-25) 1 commit
  - subtree: fix split processing with multiple subtrees present
 
  "git subtree" (in contrib/) update.
 
  Will merge to 'next'.
  source: <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com>

--------------------------------------------------
Moved from [New Topics] to [Cooking]

 * al/t2400-depipe (2024-01-20) 1 commit

 * kl/allow-working-in-dot-git-in-non-bare-repository (2024-01-20) 1 commit
- - setup: allow cwd=.git w/ bareRepository=explicit
+  (merged to 'next' on 2024-01-24 at e77b796e11)
+ + setup: allow cwd=.git w/ bareRepository=explicit
 
  Loosen "disable repository discovery of a bare repository" check,
  triggered by setting safe.bareRepository configuration variable to
  'explicit', to exclude the ".git/" directory inside a non-bare
  repository from the check.
 
- Will merge to 'next'.
+ Will merge to 'master'.
  source: <pull.1645.git.1705709303098.gitgitgadget@gmail.com>

 * rs/parse-options-with-keep-unknown-abbrev-fix (2024-01-22) 2 commits

 * pb/ci-github-skip-logs-for-broken-tests (2024-01-22) 1 commit

 * pb/complete-log-more (2024-01-22) 4 commits
- - completion: complete missing 'git log' options
- - completion: complete --encoding
- - completion: complete --patch-with-raw
- - completion: complete missing rev-list options
+  (merged to 'next' on 2024-01-24 at 081d2a92fa)
+ + completion: complete missing 'git log' options
+ + completion: complete --encoding
+ + completion: complete --patch-with-raw
+ + completion: complete missing rev-list options
 
  The completion script (in contrib/) learned more options that can
  be used with "git log".
 
- Will merge to 'next'.
+ Will merge to 'master'.
  source: <pull.1650.git.git.1705810071.gitgitgadget@gmail.com>

 * jc/reftable-core-fsync (2024-01-23) 1 commit
- - reftable: honor core.fsync
+  (merged to 'next' on 2024-01-24 at cea12beddb)
+ + reftable: honor core.fsync
 
  The write codepath for the reftable data learned to honor
  core.fsync configuration.
 
- Will merge to 'next'.
+ Will merge to 'master'.
  source: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>

--------------------------------------------------
Other topics

[Cooking]

-* ad/custom-merge-placeholder-for-symbolic-pathnames (2024-01-18) 1 commit
+* ad/custom-merge-placeholder-for-symbolic-pathnames (2024-01-24) 1 commit
- - merge-ll: expose revision names to custom drivers
+  (merged to 'next' on 2024-01-24 at d9cf4e227d)
+ + merge-ll: expose revision names to custom drivers
 
  The labels on conflict markers for the common ancestor, our version,
  and the other version are available to custom 3-way merge driver
  via %S, %X, and %Y placeholders.
 
- Expecting a reroll.
- cf. <xmqqcytvei3c.fsf@gitster.g>
- source: <pull.1648.v3.git.git.1705615794307.gitgitgadget@gmail.com>
+ Will merge to 'master'.
+ source: <pull.1648.v4.git.git.1706126951879.gitgitgadget@gmail.com>

 * jc/reffiles-tests (2024-01-22) 12 commits
- - t5312: move reffiles specific tests to t0601
- - t4202: move reffiles specific tests to t0600
- - t3903: make drop stash test ref backend agnostic
- - t1503: move reffiles specific tests to t0600
- - t1415: move reffiles specific tests to t0601
- - t1410: move reffiles specific tests to t0600
- - t1406: move reffiles specific tests to t0600
- - t1405: move reffiles specific tests to t0601
- - t1404: move reffiles specific tests to t0600
- - t1414: convert test to use Git commands instead of writing refs manually
- - remove REFFILES prerequisite for some tests in t1405 and t2017
- - t3210: move to t0601
+  (merged to 'next' on 2024-01-24 at 0d1aaa6807)
+ + t5312: move reffiles specific tests to t0601
+ + t4202: move reffiles specific tests to t0600
+ + t3903: make drop stash test ref backend agnostic
+ + t1503: move reffiles specific tests to t0600
+ + t1415: move reffiles specific tests to t0601
+ + t1410: move reffiles specific tests to t0600
+ + t1406: move reffiles specific tests to t0600
+ + t1405: move reffiles specific tests to t0601
+ + t1404: move reffiles specific tests to t0600
+ + t1414: convert test to use Git commands instead of writing refs manually
+ + remove REFFILES prerequisite for some tests in t1405 and t2017
+ + t3210: move to t0601
 
  Tests on ref API are moved around to prepare for reftable.
 
- Will merge to 'next'.
+ Will merge to 'master'.
  cf. <Za5TW-q4cKS8pNNc@tanuki>
  source: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>

-* kn/for-all-refs (2024-01-19) 5 commits
+* kn/for-all-refs (2024-01-24) 4 commits
  - for-each-ref: avoid filtering on empty pattern
  - refs: introduce `refs_for_each_all_refs()`
  - refs: extract out `loose_fill_ref_dir_regular_file()`
- - refs: make `is_pseudoref_syntax()` stricter
- - refs: expose `is_pseudoref_syntax()`
+ - refs: introduce `is_pseudoref()` and `is_headref()`
 
  "git for-each-ref" filters its output with prefixes given from the
  command line, but it did not honor an empty string to mean "pass
  everything", which has been corrected.
 
- Expecting a reroll.
- cf. <CAOLa=ZQOcqGBJOSehok4BYGUE8RKtnE9eiJYogeT8E6NWZ25xw@mail.gmail.com>
- cf. <Za-gF_Hp_lXViGWw@tanuki>
- source: <20240119142705.139374-1-karthik.188@gmail.com>
+ Expecting a reroll?
+ cf. <xmqqfrymeega.fsf@gitster.g>
+ source: <20240124152726.124873-1-karthik.188@gmail.com>

 * la/trailer-api (2024-01-12) 10 commits
  - trailer: delete obsolete argument handling code from API
  - trailer: move arg handling to interpret-trailers.c
  - trailer: prepare to move parse_trailers_from_command_line_args() to builtin
  - trailer: spread usage of "trailer_block" language
  - trailer: make trailer_info struct private
  - sequencer: use the trailer iterator
  - trailer: delete obsolete formatting functions
  - trailer: unify trailer formatting machinery
  - trailer: include "trailer" term in API functions
  - trailer: move process_trailers() to interpret-trailers.c
 
  Code clean-up.
 
- Needs review.
+ Expecting a (hopefully final and small) reroll.
+ cf. <owlysf2l2bnj.fsf@fine.c.googlers.com>
  source: <pull.1632.git.1704869487.gitgitgadget@gmail.com>

-* ps/tests-with-ref-files-backend (2024-01-12) 6 commits
+* ps/tests-with-ref-files-backend (2024-01-24) 6 commits
  - t: mark tests regarding git-pack-refs(1) to be backend specific
  - t5526: break test submodule differently
  - t1419: mark test suite as files-backend specific
  - t1302: make tests more robust with new extensions
  - t1301: mark test for `core.sharedRepository` as reffiles specific
  - t1300: make tests more robust with non-default ref backends
 
  Prepare existing tests on refs to work better with non-default
  backends.
 
  Needs review.
- source: <cover.1704877233.git.ps@pks.im>
+ source: <cover.1706085756.git.ps@pks.im>

 * sd/negotiate-trace-fix (2024-01-03) 1 commit
- - push: region_leave trace for negotiate_using_fetch
+  (merged to 'next' on 2024-01-24 at 6305853ab2)
+ + push: region_leave trace for negotiate_using_fetch
 
  Tracing fix.
 
- Will merge to 'next'?
+ Will merge to 'master'.
  source: <20240103224054.1940209-1-delmerico@google.com>

 * tb/path-filter-fix (2024-01-16) 17 commits
  - bloom: introduce `deinit_bloom_filters()`
  - commit-graph: reuse existing Bloom filters where possible
  - object.h: fix mis-aligned flag bits table
  - commit-graph: drop unnecessary `graph_read_bloom_data_context`
  - commit-graph.c: unconditionally load Bloom filters
  - bloom: prepare to discard incompatible Bloom filters
  - bloom: annotate filters with hash version
  - commit-graph: new Bloom filter version that fixes murmur3
  - repo-settings: introduce commitgraph.changedPathsVersion
  - t4216: test changed path filters with high bit paths
  - t/helper/test-read-graph: implement `bloom-filters` mode
  - bloom.h: make `load_bloom_filter_from_graph()` public
  - t/helper/test-read-graph.c: extract `dump_graph_info()`
  - gitformat-commit-graph: describe version 2 of BDAT
  - commit-graph: ensure Bloom filters are read with consistent settings
  - revision.c: consult Bloom filters for root commits
  - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`
 
  The Bloom filter used for path limited history traversal was broken
  on systems whose "char" is unsigned; update the implementation and
  bump the format version to 2.
 
- Will merge to 'next'?
+ Will merge to 'next'.
  source: <cover.1705442923.git.me@ttaylorr.com>
