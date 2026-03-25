Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96127380A
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465754; cv=none; b=htn+TC62FiNjOUSPqcJUQ2BONBjoiN4UuOBiDVzxmlkdfITYp6ut1mU3kfhajUKtrJSMkTT8oQHpXTHajxWyDsx+cqEw/2A+xcP/o1ZQxFxiUSk5XaV0JkS16PjddVZ9EbZOjrKUGjdw5PXPSNQQjWboUdB2qYDFHAT117aNAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465754; c=relaxed/simple;
	bh=cbUGYxmUx3+ubMWGg60DO/fk7o1xaQrs2k5BXaebYSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piH/lUbx/FcGnPmex03GjcBE1sqF+HYZ9SI4rbZfSOcvn8a7iLg24HNJYdEAqUbFrD8aWnmQzLE0LTrkCrgAQRXp2qbd107Ky04hRP/XcuDM1nq5BsmqSgkel+16kfF0UHF8dJ9fyxZfIWf2cfUUloD25EwtZ+w6WHJdL5U0KP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9sTPmKw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9sTPmKw"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c741db5d610so117436a12.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774465752; x=1775070552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi7Ywl3P9sqnzNuHU+vPfSGcCFx13WGJPhP9Y2dzY34=;
        b=s9sTPmKwqIOJO+kcKoaa9+5D6kif2fJ1hhybCJtl+yfAI0PFsCw9gECF7dLbRq4uQa
         MkW9qjCBSW96b2lJykGvgY2DW6B04407UCEXQh42+HRTNS1jGDQQr/G4k14pNEBZQL5W
         K23lC3g+9xs2zXwY+yyDjk6NAbUU25bUXOdZBUGGdE8uMg72EXTLPehoMtZlvJZSQwYA
         F4kNlDhd7nZeoaCSZ8ntx4pR5cpnOlurlqe+wZYHVLvy4ImHnrcBRgBgGg8OaQ+K9w/K
         xrWHpplHeh47SpBva1wgzTLm3wdFREABCtALmDZq0a3h5zMKniL4mmkGJe6EVoDPjmoP
         E9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465752; x=1775070552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vi7Ywl3P9sqnzNuHU+vPfSGcCFx13WGJPhP9Y2dzY34=;
        b=nNNuJfFticXd98lSxgKlL6Tx4NUHzDnLdLT3UOjql6OwFEYGZdbJycI1zp/40IGyE0
         Yy6AuzalgHm+EkgvWe00Jkj7SyZ0Ed8nMRvcj1EEIc25l4rSn3KtbEHguiIXjnA8ie62
         wn+v4AbD5gW+FDMXI6lDJOTADEWnqNqbyOPrFt/4TDnwyxICKba+aT5rfvBji/B3XfaU
         k5hhF77gK1wKkVuZSO9M7XQLf7e84US93hmi43oCYruAZPW4cUfXwUGfFfDaUBnJ8nEc
         nXELJoNE760nc44RpMQ5hU0nBYW+V0zB8t56hUGEWCo87AbOjX6JEpO7tb/3JG/OgPKW
         FinQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSdSdkU3ZRRv+DpFJsfGIjMiEIc2r3jnsrN8MeCpblmkFh6O4y2w+nEycieuqSIxdjgUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXUEyVJ8Yh5mJ78m0NM7fSEdBW0iIVpWIg5jtvB91LM2d5Medc
	s6dYDwznR15uh5yw4OscgsllN3WZ93e5PGdFQRpDDMPtChvDUtz+q/Yo
X-Gm-Gg: ATEYQzxqFVvDQz2o1QolrmNa7/f1wp3HYQSzh5OheBJ5Lf7x1AkD0KeXH883wWvADhn
	yC3lLY/lDozsOSkjsMTlQJ4QQzbsnFWSlOs6ON10hPbmHbd4+b2H4cRoF4Po9I7GNBAH799igNW
	KtcnuPnp2LqXmbfIGVthc4D2xaOWfs+pe01zs80SnEmPgLeNOyH8Y50/13szAEoJV6SmrvptVjI
	donaILxqRUCOvApw4Q80Hg3JnEEEZNyrP3T08FfI9NveFD150GYRIvrOTfmWsSZw0Jjvn0AgzD7
	k2M9DIdfqW7GwMmafyjwrIQFhlIC1peEeY+AqfeuPr9D1X3OXXu9FJ63gUyLbtDSl1Gtp786XWm
	/rTprSvoOIMabfcXz+fuW8MbCZqQdgf7+UgD4TdmBLWwObh8DGlNjvnxhxFL6JYhPE5j8adYC6L
	CX/2GQNlOnSyBFc1J+izJuZGBjHKfzBzBL/n+1RTyLsXV9eJIA3Kzrlo+VOk6ILw==
X-Received: by 2002:a17:902:f60a:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b0b0aad98cmr51712235ad.32.1774465751911;
        Wed, 25 Mar 2026 12:09:11 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc773472sm6466235ad.7.2026.03.25.12.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:09:11 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v3 0/2] push: add support for pushing to remote groups
Date: Thu, 26 Mar 2026 00:39:04 +0530
Message-ID: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds support for `git push` to accept a remote group
name (as configured via `remotes.<name>` in config) in addition to a
single remote name, mirroring the behaviour that `git fetch` has
supported for some time.

A user with multiple remotes configured as a group can now do:

    git push all-remotes

instead of pushing to each remote individually, in the same way that:

    git fetch all-remotes

already works.

The series is split into two patches:

  - Patch 1 moves `get_remote_group`, `add_remote_or_group`, and the
    `remote_group_data` struct out of builtin/fetch.c and into
    remote.c/remote.h, making them part of the public remote API.

  - Patch 2 extends builtin/push.c to use the newly public
    `add_remote_or_group()` to resolve the repository argument as
    either a single remote or a group, and pushes to each member of
    the group in turn.

Changes in v3:

- Clarify documentation for remote group pushes:
  * describe behavior on partial failures (rejection vs fatal errors)
  * emphasize that group push is equivalent to running independent
    pushes to each member remote

- Simplify tests:
  * remove redundant comparisons between remotes
  * verify pushed commits against the expected value using `rev-parse`

- Add tests for failure scenarios:
  * ensure push continues on non-fast-forward rejection
  * ensure push stops on fatal transport errors

- Use `size_t` for loop index to match type of `remote_group.nr`
  and avoid compiler warnings

Range-diff v2 -> v3:

1:  dd370a19e7 = 1:  dd370a19e7 remote: move remote group resolution to remote.c
2:  ba5801cee1 ! 2:  6a7957e61c push: support pushing to a remote group
    @@ Commit message
     
             git push <group>
     
    -    When the argument resolves to a single remote the behaviour is
    +    When the argument resolves to a single remote, the behaviour is
         identical to before. When it resolves to a group, each member remote
         is pushed in sequence.
     
    @@ Commit message
         a copy of the flags, so that a mirror remote in the group cannot set
         TRANSPORT_PUSH_FORCE on subsequent non-mirror remotes in the same group.
     
    -    A known interaction: push.default = simple will die when the current
    -    branch has no upstream configured, because setup_default_push_refspecs()
    -    requires an upstream for that mode. Users pushing to a group should set
    -    push.default = current or supply explicit refspecs. This is consistent
    -    with how fetch handles default refspec resolution per remote.
    -
         Suggested-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
    @@ Documentation/git-push.adoc: further recursion will occur. In this case, `only`
     +behaviour is added or removed — the group is purely a shorthand for
     +running the same push command against each member remote individually.
     +
    ++The behaviour upon failure depends on the kind of error encountered:
    ++
    ++If a member remote rejects the push, for example due to a
    ++non-fast-forward update, force needed but not given, an existing tag,
    ++or a server-side hook refusing a ref, Git reports the error and continues
    ++pushing to the remaining remotes in the group. The overall exit code is
    ++non-zero if any member push fails.
    ++
    ++If a member remote cannot be contacted at all, for example because the
    ++repository does not exist, authentication fails, or the network is
    ++unreachable, the push stops at that point and the remaining remotes
    ++are not attempted.
    ++
     +This means the user is responsible for ensuring that the sequence of
    -+individual pushes makes sense.  For example, if `push.default = simple`
    -+is set and the current branch has no upstream configured, then
    -+`git push r1` may fail.  `git push all-remotes` will fail in the same
    -+way, on whichever member remote triggers the condition first.  Setting
    -+`push.default = current` or supplying explicit refspecs is recommended
    -+when pushing to a remote group.
    -+
    -+Similarly, if `--force-with-lease` is given without an explicit expected
    -+commit, Git will guess the expected commit for each remote independently
    -+from that remote's own remote-tracking branch, the same way it would if
    -+each push were run separately.  If an explicit commit is given with
    -+`--force-with-lease=<refname>:<expect>`, that same value is forwarded
    -+to every member remote, as if each of
    -+`git push --force-with-lease=<refname>:<expect> r1`,
    -+`git push --force-with-lease=<refname>:<expect> r2`, ...,
    -+`git push --force-with-lease=<refname>:<expect> rN` had been invoked.
    -+
    -+Each member remote is pushed using its own push mapping configuration
    -+(`remote.<name>.push`), so a refspec that maps differently on r1 than
    -+on r2 is resolved correctly for each one.
    ++individual pushes makes sense. If `git push r1`` would fail for a given
    ++set of options and arguments, then `git push all-remotes` will fail in
    ++the same way when it reaches r1. The group push does not do anything
    ++special to make a failing individual push succeed.
     +
      OUTPUT
      ------
      
     
      ## builtin/push.c ##
    -@@ builtin/push.c: static int git_push_config(const char *k, const char *v,
    - 
    - 	return git_default_config(k, v, ctx, NULL);
    - }
    --
    - int cmd_push(int argc,
    - 	     const char **argv,
    - 	     const char *prefix,
     @@ builtin/push.c: int cmd_push(int argc,
      	int flags = 0;
      	int tags = 0;
    @@ builtin/push.c: int cmd_push(int argc,
     +	 * same group.
     +	 */
     +	base_flags = flags;
    -+	for (int i = 0; i < remote_group.nr; i++) {
    ++	for (size_t i = 0; i < remote_group.nr; i++) {
     +		int iter_flags = base_flags;
     +		struct remote *r = pushremote_get(remote_group.items[i].string);
     +		if (!r)
    @@ t/t5566-push-group.sh (new)
     +test_expect_success 'setup' '
     +	for i in 1 2 3
     +	do
    -+		git init --bare dest-$i.git &&
    -+		git -C dest-$i.git symbolic-ref HEAD refs/heads/not-a-branch ||
    -+		return 1
    ++		git init --bare dest-$i.git || return 1
     +	done &&
     +	test_tick &&
     +	git commit --allow-empty -m "initial" &&
    @@ t/t5566-push-group.sh (new)
     +	git config set remotes.all-remotes "remote-1 remote-2 remote-3"
     +'
     +
    -+test_expect_success 'push to remote group pushes to all members' '
    ++test_expect_success 'push to remote group updates all members correctly' '
     +	git push all-remotes HEAD:refs/heads/main &&
    -+	j= &&
    ++	git rev-parse HEAD >expect &&
     +	for i in 1 2 3
     +	do
    -+		git -C dest-$i.git for-each-ref >actual-$i &&
    -+		if test -n "$j"
    -+		then
    -+			test_cmp actual-$j actual-$i
    -+		else
    -+			cat actual-$i
    -+		fi &&
    -+		j=$i ||
    ++		git -C dest-$i.git rev-parse refs/heads/main >actual ||
     +		return 1
    ++		test_cmp expect actual || return 1
     +	done
     +'
     +
    @@ t/t5566-push-group.sh (new)
     +	test_tick &&
     +	git commit --allow-empty -m "second" &&
     +	git push all-remotes HEAD:refs/heads/main &&
    ++	git rev-parse HEAD >expect &&
     +	for i in 1 2 3
     +	do
    -+		git -C dest-$i.git rev-parse refs/heads/main >hash-$i ||
    ++		git -C dest-$i.git rev-parse refs/heads/main >actual ||
     +		return 1
    -+	done &&
    -+	test_cmp hash-1 hash-2 &&
    -+	test_cmp hash-2 hash-3
    ++		test_cmp expect actual || return 1
    ++	done
     +'
     +
     +test_expect_success 'push to single remote in group does not affect others' '
    @@ t/t5566-push-group.sh (new)
     +	! test_cmp hash-after-1 hash-after-2
     +'
     +
    -+test_expect_success 'push to nonexistent group fails with error' '
    -+	test_must_fail git push no-such-group HEAD:refs/heads/main
    -+'
    -+
    -+test_expect_success 'push explicit refspec to group' '
    -+	test_tick &&
    -+	git commit --allow-empty -m "fourth" &&
    -+	git push all-remotes HEAD:refs/heads/other &&
    -+	for i in 1 2 3
    -+	do
    -+		git -C dest-$i.git rev-parse refs/heads/other >other-hash-$i ||
    -+		return 1
    -+	done &&
    -+	test_cmp other-hash-1 other-hash-2 &&
    -+	test_cmp other-hash-2 other-hash-3
    -+'
    -+
     +test_expect_success 'mirror remote in group with refspec fails' '
     +	git config set remote.remote-1.mirror true &&
     +	test_must_fail git push all-remotes HEAD:refs/heads/main 2>err &&
    -+	grep "mirror" err &&
    ++	test_grep "mirror" err &&
     +	git config unset remote.remote-1.mirror
     +'
     +test_expect_success 'push.default=current works with group push' '
    @@ t/t5566-push-group.sh (new)
     +	git config unset push.default
     +'
     +
    ++test_expect_success 'push continues past rejection to remaining remotes' '
    ++	for i in c1 c2 c3
    ++	do
    ++		git init --bare dest-$i.git || return 1
    ++	done &&
    ++	git config set remote.c1.url "file://$(pwd)/dest-c1.git" &&
    ++	git config set remote.c2.url "file://$(pwd)/dest-c2.git" &&
    ++	git config set remote.c3.url "file://$(pwd)/dest-c3.git" &&
    ++	git config set remotes.continue-group "c1 c2 c3" &&
    ++
    ++	test_tick &&
    ++	git commit --allow-empty -m "base for continue test" &&
    ++
    ++	# initial sync
    ++	git push continue-group HEAD:refs/heads/main &&
    ++
    ++  # advance c2 independently
    ++  git clone dest-c2.git tmp-c2 &&
    ++  (
    ++    cd tmp-c2 &&
    ++    git checkout -b main origin/main &&
    ++    test_commit c2_independent &&
    ++    git push origin HEAD:refs/heads/main
    ++  ) &&
    ++  rm -rf tmp-c2 &&
    ++
    ++	test_tick &&
    ++	git commit --allow-empty -m "local diverging commit" &&
    ++
    ++	# push: c2 rejects, others succeed
    ++	test_must_fail git push continue-group HEAD:refs/heads/main &&
    ++
    ++	git rev-parse HEAD >expect &&
    ++	git -C dest-c1.git rev-parse refs/heads/main >actual-c1 &&
    ++	git -C dest-c3.git rev-parse refs/heads/main >actual-c3 &&
    ++	test_cmp expect actual-c1 &&
    ++	test_cmp expect actual-c3 &&
    ++
    ++	# c2 should not have the new commit
    ++	git -C dest-c2.git rev-parse refs/heads/main >actual-c2 &&
    ++	! test_cmp expect actual-c2
    ++'
    ++
    ++test_expect_success 'fatal connection error stops remaining remotes' '
    ++	for i in f1 f2 f3
    ++	do
    ++		git init --bare dest-$i.git || return 1
    ++	done &&
    ++	git config set remote.f1.url "file://$(pwd)/dest-f1.git" &&
    ++	git config set remote.f2.url "file://$(pwd)/dest-f2.git" &&
    ++	git config set remote.f3.url "file://$(pwd)/dest-f3.git" &&
    ++	git config set remotes.fatal-group "f1 f2 f3" &&
    ++
    ++	test_tick &&
    ++	git commit --allow-empty -m "base for fatal test" &&
    ++
    ++	# initial sync
    ++	git push fatal-group HEAD:refs/heads/main &&
    ++
    ++	# break f2
    ++	git config set remote.f2.url "file:///tmp/does-not-exist-$$" &&
    ++
    ++	test_tick &&
    ++	git commit --allow-empty -m "after fatal setup" &&
    ++
    ++	test_must_fail git push fatal-group HEAD:refs/heads/main &&
    ++
    ++	git rev-parse HEAD >expect &&
    ++	git -C dest-f1.git rev-parse refs/heads/main >actual-f1 &&
    ++	test_cmp expect actual-f1 &&
    ++
    ++	# f3 should not be updated
    ++	git -C dest-f3.git rev-parse refs/heads/main >actual-f3 &&
    ++	! test_cmp expect actual-f3 &&
    ++
    ++	git config set remote.f2.url "file://$(pwd)/dest-f2.git"
    ++'
    ++
     +test_done

Usman Akinyemi (2):
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 Documentation/git-push.adoc |  73 ++++++++++++++++--
 builtin/fetch.c             |  42 ----------
 builtin/push.c              | 123 +++++++++++++++++++++--------
 remote.c                    |  37 +++++++++
 remote.h                    |  12 +++
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 150 ++++++++++++++++++++++++++++++++++++
 7 files changed, 355 insertions(+), 83 deletions(-)
 create mode 100755 t/t5566-push-group.sh

-- 
2.48.0.rc0.4242.g73eb647d24.dirty

