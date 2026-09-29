Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F21344D91
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684442; cv=none; b=j9GIDlkF10k7Pa9cG/s4NDaf5eu9Hgk628Rqy6S12ubaJQwRm4HAtFfz3x5l8EN4UnITjkVpi20aLAiOSAk7h9oV2UuO9XMs+DV+F/yc00d6gCTVl+0GDrHX7bYlTW+F2qWCPN80FLOxEli/0tjrAvt0bEtqBPBoSxWhigHkdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684442; c=relaxed/simple;
	bh=c5sxzins9GsOhaqgurE0e1gQOWzNyKZYZqgeXqVtV08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhDYv/TZJqN3+aPjgy7dzFnF9h3X7ZXbtASrXLqmrTSJUqf+VoMVDw8WGWAKaye6dKCBrZihbbBPwJnhd1XKZ1SYsyxNf+eOskLLPt+UgxVoeJxaPm06Q3SAnMeDScXSAUOP8nGEOvHdDP5KHKzuRQvjA9HbW9LShRwgsTezsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWVYrLCb; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWVYrLCb"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-671563fb8beso3904755d50.3
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684439; x=1791289239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dPPD/Uxnvrnso/IwTfsQjgCb889AFGo/cOhC/nbM12Q=;
        b=jWVYrLCb6D3EUX63FLX6S1GRJ3LCU4/mg5tkFkS0PN5yYdzOObIe3zE/1uhShGy/NQ
         tM4pnwyZJSdaSbwCP93GWZq5W7pdgGM2evBty7os/fqTIuwU5Vy+y7pD4wf0TXsUymOk
         eNIbTijisCQdp0c9Z0R6r0mdqPjRzAoonY5vSfXAwE/v9mTHWrdldUU/q9BD8yS2WdNH
         f279PHWqZN3EHK+oqmjsUe2GaI0mCE3SgwTWVOZwSEzfqENqFmyUj/gqews0mhuYVdPM
         OYif9fpnuTOW7gabEHp66yoVUhXtJSlLGOw/gbObQ0mZ540LIz+jmtChVcXs6EzQIAng
         IIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684439; x=1791289239;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dPPD/Uxnvrnso/IwTfsQjgCb889AFGo/cOhC/nbM12Q=;
        b=1WZdqbL/ThPj5Mh90cnU/T6LFMdEBpbfUop6srlMbAO9G67E/EDToEW5FVj4Wd6AGB
         ZYT0kBP/YByOOI1WVV5OVWb+Zu+Wwx809bHIr+7/8+Tde0+QdadtuxFf5QmuYQ86otAo
         J1JQ5Oejz8dvVUcPwbvJXLd37AcyADfw+VNXbnIE9ZpCrTxVVfFcw7C6asTejjU1vuK6
         eiwcK8VPQOEttrka9KV68p/7oaUsJ9L9d0rE6jYOxC7zdr4uKvfHKprFHQPwACheXRoJ
         GQsxaQpzokIyrII6QG9nRWunoOn8MduDzxfbJpcMYlsq6n33FL8doVV27ZqWmnAURTrT
         WRTg==
X-Gm-Message-State: AFq9FYL5xpU4+hANMhzTmAjqZlmC8wax+wicmXinv7BcRlHlLNjKOKFT
	hemhBc6vhykFN+QSEHcYLjTUnlvWjWOqhLSZfv0BfdLGbFO+M49IWjwRyb+oMoVW
X-Gm-Gg: AYBFou2S5fIjdDqg5/Y5PP1EiXEtkMAGAsm0klAVqqZKx/V0BTXOYl1t0JnW/uTvpK+
	t5ZboUeG0yPXyIWOptjtg3ro22XjtpcxVmhAj8oL8Hbw7F7xqHp9lQi9RMz5haPewngtT5gEjj5
	adXzPLWrLTr7KRi5YB1HOzFHlYUVMn7+L17KYgP00Brl2dzofwSW5iG8QH8Ujl4NH3if7IhN01E
	tSgPkf65Dk81VISadJhbMi8xs5KwlTz+RdrO0IlG1ElR0rvaTq48+LSip5Qnkb3JdVIt7CnyMhj
	1jbQtoUIN9WQkcNw+zmk2gxTe0vrmw7Dx+ksqziAAVN0ujtShM0GaR85s/X1FZ5PKkZAfgpGjN9
	lSxLPLfsb44GTv60Xj9eIKoNTl14XIwhdxxiGeIYqDe+w4/2C2rDJZg8F4+EPJw8qClLiuhhE7G
	RmHi5pljnMYXRsFqXKE8tEC3KzRIcVw1s7pFdHCknCC4hxBm3dcKYYBC4HVtVpxIF3eVDUDsWm+
	+iYgj2DuznlKEdwMpixnOnMlyuh1jNgBRtoRgxT9leVdSevRV6d2qCHpT0KztnWfqan4AURm7KF
	Uh5QJOkfZCJDxhvSUYl/pxC7JRnGJ94U8w==
X-Received: by 2002:a05:690e:1384:b0:675:40e7:8e5c with SMTP id 956f58d0204a3-67540e7c520mr3241028d50.13.1790684439045;
        Tue, 29 Sep 2026 05:20:39 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-674e5a7a556sm4499112d50.19.2026.09.29.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:20:37 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/5] stash: clean up index-mode test merge
Date: Tue, 29 Sep 2026 08:18:26 -0400
Message-ID: <cover.1790684309.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1789853192.git.ben.knoble@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This small patch series fixes a bug reported by Eli Barzilay in the
interaction between autostashing, staged index entries, and
stash.index=true.

The first patch is an incidental cleanup, and the second re-arranges one
line to make the change easier. The third adds missing test coverage
(which catch breakages from prior incorrect rounds of this series). The
fourth fixes a test interaction with another in-flight topic. The last
holds the interesting bits.

Changes in v4:
• Drop merge verbosity changes altogether. I was going to
  save-and-restore, but when looking at the index-merge test case (more
  below) closer, I noticed that "git apply --cached" reports conflicts
  on stderr. That is, "git stash apply --index" would report conflicts,
  and silencing the merge takes that away. So instead let's leave the
  configured verbosity alone.
• Only copy resulting index merge tree OID when successful
• Fix interaction with t5520 (new patch 4/5)
• Squash test from 3/5 into 5/5, since it requires actually merging
  trees. I've elected to keep it a separate test for now (contrary to
  Phillip's suggestion) since it's written and working. Adapting
  existing tests requires quite a bit more digging into implicit context
  assumptions ;)

Changes in v3:

• Change conflict label for current index
• Fix memory leak of merge_result
• Fix order of trees to make the correct merge (cherry-pick)
    • New test (3/5) to validate this
• Fix test in 4/5 to assert more details of expected state

Changes in v2:

• Do give branch labels for the incore merge, although they are never
  seen (and clarify commit message as a result, also keeping the
  merge-ort asserts). Phillip was right: without those, we do segfault
  on conflicts.
• Use the ui merge options to keep the same diff algorithm.
• Use merge_finalize instead of clear_merge_options, and reuse the
  options between merge calls if they are already initialized.
• Add a new 2/4 to simplify merge options initialization.
• Add a new 3/4 with a test case for conflicted index merges.

v1: <cover.1789853192.git.ben.knoble@gmail.com>
v2: <cover.1790168285.git.ben.knoble@gmail.com>
v3: <cover.1790425008.git.ben.knoble@gmail.com>

[1/5] builtin/stash: remove unused header
[2/5] stash: prepare merge options earlier
[3/5] t3903: test failed "stash apply --index"
[4/5] t5520: don't expire reflogs where it matters
[5/5] builtin/stash: merge index in-core

 builtin/stash.c  | 91 ++++++++++++------------------------------------
 t/t3903-stash.sh | 42 ++++++++++++++++++++++
 t/t5520-pull.sh  |  6 ++++
 t/t7600-merge.sh |  9 +++++
 4 files changed, 79 insertions(+), 69 deletions(-)

Diff-intervalle contre v3 :
1:  6a165c4df4 = 1:  6a165c4df4 builtin/stash: remove unused header
2:  d9a9e18f3a ! 2:  35b64ae321 stash: prepare merge options earlier
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
      		return error(_("cannot apply a stash in the middle of a merge"));
      
     +	init_ui_merge_options(&o, the_repository);
    ++
    ++	if (quiet)
    ++		o.verbosity = 0;
     +
      	if (index) {
      		if (oideq(&info->b_tree, &info->i_tree) ||
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
      	o.branch1 = label_ours ? label_ours : "Updated upstream";
      	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
      	o.ancestor = label_base ? label_base : "Stash base";
    +@@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefix,
    + 	if (oideq(&info->b_tree, &c_tree))
    + 		o.branch1 = "Version stash was based on";
    + 
    +-	if (quiet)
    +-		o.verbosity = 0;
    +-
    + 	if (o.verbosity >= 3)
    + 		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
    + 
4:  d39e16905d ! 3:  7b0b317ce0 t3903: test failed "stash apply --index"
    @@ Commit message
     
      ## t/t3903-stash.sh ##
     @@ t/t3903-stash.sh: setup_stash() {
    - 	test_cmp expect file
    + 	test_cmp expect actual
      '
      
     +test_expect_success 'stash apply --index leaves everything untouched on failure' '
3:  8b5ea5e6f4 ! 4:  2ac371d2dc t3903: test stash --index merges
    @@
      ## Metadata ##
    -Author: D. Ben Knoble <ben.knoble@gmail.com>
    +Author: Thomas Bachem <mail@thomasbachem.com>
     
      ## Commit message ##
    -    t3903: test stash --index merges
    +    t5520: don't expire reflogs where it matters
     
    -    A future commit will refactor index handling for applied stashes, and we
    -    need to take care to get the order of trees right when merging. Add a
    -    test that covers this case.
    +    The "--rebase -f with rebased upstream" test computes its fork point
    +    from the reflog of refs/remotes/me/copy, and the entry it needs is
    +    the one that the fetch of the test before it wrote. Like every reflog
    +    entry the suite writes after test_tick, it is dated 2005, so the
    +    first "git reflog expire --all" after that fetch removes it. Pull
    +    then finds no fork point and rebases onto the merge head with the
    +    merge head as the upstream, and the rewound commits come back as a
    +    conflict.
     
    -    Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
    +    default, 2026-02-24) auto maintenance runs that expiry once the reflog
    +    of HEAD holds a hundred entries it would remove, the default of
    +    maintenance.reflog-expire.auto. Which run crosses the threshold
    +    depends on the entries and maintenance runs before it, so the script
    +    passed by chance: a stash topic that no longer runs "git reset" from
    +    "stash apply --index" and a rebase topic that runs auto maintenance
    +    at the end of "git rebase" together move the expiry between the two
    +    tests.
     
    - ## t/t3903-stash.sh ##
    -@@ t/t3903-stash.sh: setup_stash() {
    - 	test_cmp expect actual
    - '
    +    Pin the expiry as ea7d894f44 (t34xx: don't expire reflogs where it
    +    matters, 2026-02-24) did for the rebase tests. That covers a "git gc"
    +    as well, which expires reflogs on its own, where turning off the auto
    +    trigger of the reflog-expire task alone would not.
    +
    +    Reported-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Assisted-by: Claude Fable 5.1
    +    Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
    +
    + ## t/t5520-pull.sh ##
    +@@ t/t5520-pull.sh: test_pull_autostash_fail () {
    + }
      
    -+# the later "stash -k" test is not expecting us to muck with file so much, so
    -+# reset when finished
    -+test_expect_success 'stash apply --index merges the correct trees' '
    -+	head=$(git rev-parse HEAD) &&
    -+	test_when_finished "git reset --hard $head" &&
    -+	test_write_lines A B C >file &&
    -+	git commit -m setup file &&
    -+	test_write_lines A B staged >file &&
    -+	git add file &&
    -+	test_write_lines A B unstaged >file &&
    -+	git stash &&
    -+	test_write_lines committed B C >file &&
    -+	git commit -m to-be-merged file &&
    -+	git stash pop --index &&
    -+	git show :file >actual &&
    -+	test_write_lines committed B staged >expect &&
    -+	test_cmp expect actual &&
    -+	test_write_lines committed B unstaged >expect &&
    -+	test_cmp expect file
    -+'
    + test_expect_success setup '
    ++	# Commit dates are hardcoded to 2005, and the reflog entries will have
    ++	# a matching timestamp. Maintenance may thus immediately expire
    ++	# reflogs if it was running.
    ++	git config set gc.reflogExpire never &&
    ++	git config set gc.reflogExpireUnreachable never &&
     +
    - test_expect_success 'stash -k' '
    - 	echo bar3 >file &&
    - 	echo bar4 >file2 &&
    + 	echo file >file &&
    + 	git add file &&
    + 	git commit -a -m original
5:  fde7fb7988 ! 5:  e21b832a6e builtin/stash: merge index in-core
    @@ Commit message
         we don't see the usual branch and ancestor labels, but the merge
         subroutines insist on their presence, so use something simple.
     
    +    We need to take care to get the order of trees right when merging. Add a
    +    test that covers this case.
    +
         We *could* swap just the git-reset(1) subprocess with our internal
         reset_tree() and refresh_index(), which would fix the bug. We'd much
         prefer to clean up these vestiges of the shell-based git-stash, though.
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -			ret = apply_cached(&out);
     -			strbuf_release(&out);
     -			if (ret)
    -+			o.verbosity = 0;
    -+
     +			head = lookup_tree(o.repo, &c_tree);
     +			merge = lookup_tree(o.repo, &info->i_tree);
     +			merge_base = lookup_tree(o.repo, &info->b_tree);
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     +			merge_incore_nonrecursive(&o, merge_base, head, merge,
     +						  &result);
     +
    -+			oidcpy(&index_tree, &result.tree->object.oid);
    -+			merge_finalize(&o, &result);
    -+
    -+			if (!result.clean)
    ++			if (!result.clean) {
    ++				merge_finalize(&o, &result);
      				return error(_("conflicts in index. "
      					       "Try without --index."));
     -
    @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
     -			reset_head();
     -			discard_index(the_repository->index);
     -			repo_read_index(the_repository);
    ++			} else {
    ++				oidcpy(&index_tree, &result.tree->object.oid);
    ++				merge_finalize(&o, &result);
    ++			}
      		}
      	}
      
     
    + ## t/t3903-stash.sh ##
    +@@ t/t3903-stash.sh: setup_stash() {
    + 	test_cmp expect-index actual-index
    + '
    + 
    ++# the later "stash -k" test is not expecting us to muck with file so much, so
    ++# reset when finished
    ++test_expect_success 'stash apply --index merges the correct trees' '
    ++	head=$(git rev-parse HEAD) &&
    ++	test_when_finished "git reset --hard $head" &&
    ++	test_write_lines A B C >file &&
    ++	git commit -m setup file &&
    ++	test_write_lines A B staged >file &&
    ++	git add file &&
    ++	test_write_lines A B unstaged >file &&
    ++	git stash &&
    ++	test_write_lines committed B C >file &&
    ++	git commit -m to-be-merged file &&
    ++	git stash pop --index &&
    ++	git show :file >actual &&
    ++	test_write_lines committed B staged >expect &&
    ++	test_cmp expect actual &&
    ++	test_write_lines committed B unstaged >expect &&
    ++	test_cmp expect file
    ++'
    ++
    + test_expect_success 'stash -k' '
    + 	echo bar3 >file &&
    + 	echo bar4 >file2 &&
    +
      ## t/t7600-merge.sh ##
     @@ t/t7600-merge.sh: verify_no_mergehead () {
      	test_cmp result.1-5 file

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

