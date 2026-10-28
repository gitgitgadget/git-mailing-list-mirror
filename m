Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221753;
	b=lZHpDya1G6jvK6LbUDl3XlQJnrRVofbIbiuOQu7r0dBterxSAin31VS/xGAJbtVAyAJg
	 teXwAG1v5oqMp9jX53gIEyOO7tH9H0LecTvM8TIVgkFR/EqBSbAbrmYAaK+nVmM/4QHz3
	 q+gqVssauMnLx/WnkrWeJQf2vN0ytNNrKza8guEkEq/UPY1p4M58i7Ewg3r3/TLmPIaMD
	 yln5qzn1knuSoA+zf35OZs3uyAx8C1csVyxKzH5jt4d4BR9F6qyw2gselfj6ysubIjYR2
	 mFD5X5YoexPstHSSGL6U3dCyFf+YAeqq6CJoMFAT22CO+aQbmUbjQeFvV3MvEvQIgdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer;
	bh=PssN2ihVcNezGZj90K3Ky6q7JCkSFfXCF/m4oIxAPvI=;
	b=dnj44xgex6TfuWrnCeLT7Joxhw8Xw5pKEqygp546QqcHhm2UC/CKsL1UQVun0NcS0tGu
	 iyeyQ+wSDorH4oNckzI+WYX7wT2BI5qLhDhDM2QSdOwTBz8zcsxarfXrG/YtLO4vDAlTS
	 WKhJ9gwysRHkMEbUJyDEcqGyiDXASaAGy4YGjsQhMxKKyN0LxF4OADcW+UM5zHXdJQ1/J
	 YcX5tOO8v7XkTgWu1vmocyx1Yd1lU3ROFXgZEUAX+O+CJfu8mP3E1ATTYLadsCo62czM+
	 lUFkO+dBuadXDel9LviItxFx6j7K/lqedJYzC+qbDI631qp2N0SvkV74XF15fH3JPFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQng4Ylw;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CA606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 096CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RQng4Ylw
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15dd124bbe7so2635372c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793221752; x=1793826552; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PssN2ihVcNezGZj90K3Ky6q7JCkSFfXCF/m4oIxAPvI=;
        b=RQng4Ylw+oOXsSZkoCvlhcxeBulM9U5Xmxr1c8/coba3ZkRwv1r73LigO/YvBVb7A4
         aWB5Ox3Tf+SNKTO9nrZzbBeAWKBJZXOa+ipIwvTiEvussbwQhLjndFWx8VywTQhTrE66
         1XufEmfI0azBoJnKKGuiaAf69H8e4Vc13Y7JWGuDLgtkbHV57AP1k7I7v5SldSF1OfR9
         N5/ebDBr930VcCcuv0b1U/EDly448R184yrp0AMF8vFieLe7U7G66xZdKm3BxcB+r4qz
         WlqqBKC/xntx1ZnZPxpjJVSTzfq0oWQU7m6A4mdXZvZmJ2VcHbUIE4FqdMP15DvWl8X2
         uATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221752; x=1793826552;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PssN2ihVcNezGZj90K3Ky6q7JCkSFfXCF/m4oIxAPvI=;
        b=Korih8psFrzAe9Qm6Yu+3RbdOs1s62AupMcnBTkrbsVrHPrTVmkKMEDo9NGx8uzZEb
         kI5ZJlvQoaOZH9I4eHeaeTlM75dPpFrfuCyjgSmoUhhPd43p77qLwINSEaGJTbM0yXpR
         yZjFajwd5kBOldSehQ9b8hJ2A9G3jn+qTsMj2DqMc7QWYbIqnCOrXB05hfqbDlsvkxon
         iZB7akb6YoPrHPgrFFLHN4+3TR7Zc+zl3W8i6sVTshJ8rx5ifSc6Q2iSpADQvmKtF6xq
         PZmy1QjfbBEmbmVVvnzMVkLUbnF8/NLdBp9Lhvse8hJaxBUox4QK9FkpP2riwLDxGq4F
         Pj0A==
X-Gm-Message-State: AFq9FYIdWYN+P+KqA/UOuW616P/ycKV88iTpdRSxOZNz/F26oRVeqUjq
	YJZOa6bv1tbwJKJ1ejRHeP2hz7cMruf4fTeebuJ5ecqf6lwlhTL13uon
X-Gm-Gg: AYBFou3qRWFuvnRokRQTe/U3BMV10RIdJh7SFoa/byTkO5CZfraXCc+KJxq3vjwmtDR
	LQPqKRM6HVvz540B4J4KCATzKLJ7/w1ZSo5gX4cVSEzwBsAJdpywQnJhi8lUstWwcE+L1vzc22O
	hrzAu2BJ/7Nz3PMKo1ROKCtrcQFwn2VljXrxrwwH75BZvRdaUzqFliwWjMSnERajFdR9GSJIxww
	gMDn8mrldyK/hcmXqmSY+cVVq9/YKnVJha+Lh0OoAvfO+nzrUQZxxpuVl+7VinCeASBKS7RsKJj
	xurYGukCWvnL1tlGSQDlqI8Q85SfDCZH2djG5XXweiHdHi/JnI1xDHcLEfLNPlXoMoK2B0UwMXi
	N9RtneeCUEpcxGwWokIuz3bmQ4L4wZr5uNbN36EeRXn6jrGZojcqHjzyxt2iCnh40Kim4zXfdrD
	Suia7SVguS8MSnZji2Y8UG708RXwlxRBH621J727XB8KkvNE1hGhiYm61GQE9vSOVlpXRrBOmXZ
	8xXXG7Ir6pdawdtwbY3+5rPxXSBL8Q6ipMunqxfbyLDWrCaDKnT5+5PEcAI38z+3GDds8thR9nl
	1eCE/80JITw4lRh/Qgqz9kZJBrXa+/YO/wXntwsVOzHMzmjQdf8MSf5c
X-Received: by 2002:a05:7022:7f0e:b0:144:c127:dd1b with SMTP id a92af1059eb24-1a6cef7a4d4mr4896679c88.39.1793221751465;
        Wed, 28 Oct 2026 14:09:11 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a76056a001sm11874804c88.22.2026.10.28.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:09:10 -0700 (PDT)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 28 Oct 2026 14:09:00 -0700
Subject: [PATCH v5] sequencer: honor --empty when a fixup!/squash! empties
 its target
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fz-autosquash-empty-v5-1-a3cfb582fff5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6XPTU7DMBAF4KtUXmPkGf+GFfdAXTjOuLFEmhKnU
 UuVu+OEBRGK2LB8I71vZh4s05Aos5fDgw00pZz6cwn66cBC688n4qkpmaFAI6yoePzk/jr2+eP
 qc8upu4x3XhtTYYjSBCNYaV4Gium2qm/HktuUx364r0smXKZ/exNw4E6FWlUqSAPy9dT59P4c+
 m7hv7sg9rtYutEDobUkdHSb7nLLBP/bvxpyYwDsG7IYDaKtjaRaA/w21I/h0O4bavmlcjE22mr
 rxNaY5/kLy1n1q74BAAA=
X-Change-ID: 20260709-fz-autosquash-empty-b6692cf36c60
In-Reply-To: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Junio C Hamano <gitster@pobox.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When "git rebase --autosquash" squashes a "fixup!" or "squash!" commit
into its target, the result can be a commit that no longer changes
anything relative to its parent, for example when the squashed change
reverts the target.  Rather than dropping or keeping that commit, the
rebase stops with

	You asked to amend the most recent commit, but doing so would
	make it empty. ...

and "--empty" has no effect on it.  This makes backing a change out of a
series awkward: reverting a commit as a "fixup!" and running "git rebase
--autosquash --empty=drop" ought to remove both the commit and its
revert, but it halts instead.

A "fixup" is applied by amending HEAD, so the commit it produces is
empty when the index matches the tree of HEAD's parent rather than the
tree of HEAD.  allow_empty() only knows about the latter, so it never
notices that the fixup cancelled the commit out and "git commit --amend"
is left to refuse to create the empty commit.

Check for this case separately and honor "--empty" for it, subject to
two restrictions.

First, "--empty" only governs commits that become empty, so a commit
that was picked empty to begin with must be left alone.  To tell the two
apart, record in "struct replay_ctx" what the "pick" that created the
commit at HEAD was, and write it to "$GIT_DIR/rebase-merge/fixup-target"
so that it survives a stop for conflict resolution.  Only a commit
created by a "pick" is a candidate: when the todo list has been edited
so that a chain starts after "reset", "exec" or "break", we do not know
how the commit at HEAD came to be and keep it.

Second, only the last fixup of a chain may drop the commit.  Were an
earlier one to drop it, the fixups still to come would be squashed into
the previous commit instead, so a commit emptied mid-chain is kept --
empty for the time being -- and the decision is deferred to the end of
the chain.  The check is made even when that last fixup is itself
dropped because its changes are already upstream, as the fixups before
it may have emptied the commit.

With "--empty=drop" the emptied commit has already been created by the
"pick", so drop it by moving HEAD back to its parent and report the new
PICK_RESULT_DROPPED_HEAD, so that neither that commit nor any of the
fixups squashed into it is recorded as rewritten and the post-rewrite
machinery has nothing to report.  A "label" or "update-ref" that follows
then sees HEAD at the parent.

A conflicted fixup that the user resolves by undoing the commit it is
being squashed into leaves the same empty commit behind, so give
commit_staged_changes() the same treatment.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
Sorry this v5 has taken a while; I got sidelined by other personal
and $DAYJOB work.  Thanks for the review, Phillip -- this version
addresses it.

Changes in v5 (thanks to Phillip Wood's review):
- The last fixup of a chain now checks whether HEAD was emptied even
  when that fixup is itself dropped as already upstream, so with
  "pick C", "fixup revert-C", "fixup already-upstream" the commit C is
  dropped.  Added Phillip's test for this.
- ALLOW_EMPTY is set unconditionally for a fixup that is not the last
  of its chain, or under --empty=keep, so is_amended_head_empty() is
  only called for the last fixup under --empty=drop.
- What a "pick" left at HEAD is now recorded in pick_commits(), next to
  where other commands forget it, rather than in do_pick_commit().  A
  new set_fixup_target_picked() helper is shared with
  skip_unnecessary_picks(), which now remembers the base commit instead
  of looking it up again.
- No longer reset the fixup target after dropping HEAD; the next
  command sets it anyway.
- commit_staged_changes() jumps to the cleanup that follows
  "git commit" instead of repeating it, so the drop path only removes
  the files that "git commit" would have removed.
- Tests create fixup commits with test_commit and compare
  "git log --format=%s" output with test_cmp instead of a series of
  test_grep calls.
- Left for later series, as suggested: not dropping a "pick" that is
  followed by fixups until the end of the chain, and making
  --empty=stop stop when a fixup empties a non-empty commit.
- Link to v4: https://patch.msgid.link/20260827-fz-autosquash-empty-v4-1-f98ffd575780@gmail.com

Changes in v4 (thanks again to Phillip Wood's review):
- Rebased onto 'master' now that pw/rebase-drop-notes-with-commit has
  graduated; the drop is reported with a new member of that topic's
  "enum pick_result" instead of an out-parameter.
- Only a commit that *becomes* empty is dropped: whether the "pick" that
  created it was empty is now remembered in "struct replay_ctx" and
  written to "$GIT_DIR/rebase-merge/fixup-target" so it survives a stop
  for conflict resolution.  A commit picked empty is left alone.
- Only the final fixup of a chain may drop the commit.  One that empties
  it mid-chain keeps it, empty for the time being, so that the remaining
  fixups still land on it rather than on the previous commit.
- A chain that is not preceded by a "pick" -- because the todo list was
  edited to start it with "reset", "exec" or "break" -- never drops HEAD.
- commit_staged_changes() honors "--empty=drop" as well, for a
  conflicted fixup that the user resolves by undoing its target.
- allow_empty() is left in place rather than being bypassed, so a fixup
  whose own contents are already upstream is still reported.
- Dropped the tests that expected an already-empty commit to be dropped;
  added tests for the mid-chain, no-preceding-pick and conflict cases,
  and moved the post-rewrite check to t5407 next to the one added by
  pw/rebase-drop-notes-with-commit.
- Reworded the documentation to talk about squashing rather than
  melding, matching the rest of git-rebase(1).
- Link to v3: https://lore.kernel.org/r/20260711-fz-autosquash-empty-v3-1-d227b63eb511@gmail.com

sequencer: let autosquash drop a commit it empties out

At Meta we maintain a fork of LLVM that we regularly rebase onto
upstream.  A set of internal patches rides on top, and we keep each one
as a single commit by folding follow-up changes into it with autosquash
"fixup!" commits.  That works well for evolving a patch, but not for
retiring one: to back an internal patch out today we hand-edit the
interactive rebase todo list to delete the commit and its scattered
fixups, which is fiddly and easy to get wrong.  (The history is rewritten
either way, so a force-push is still needed; what this avoids is the
manual todo surgery.)

It would be nicer to retire a patch the same way we amend one: commit a
revert of it as a "fixup!" and let autosquash fold the two together.
The net change is empty, so the commit should just drop out of the
series.  Today it does not -- the rebase stops instead.

For example, starting from a commit we want to retire:

    $ git log --oneline
    4d5e6f7 add feature patch
    9a1b2c3 base

    # revert the feature and mark the revert as a fixup of it
    $ git revert --no-edit HEAD
    $ git commit --amend -m "fixup! add feature patch"

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    You asked to amend the most recent commit, but doing so would
    make it empty. You can repeat your command with --allow-empty [...]
    Could not apply 8e9f0a1... # fixup! add feature patch

The "--empty=drop" is ignored.  "--empty" only governs commits that are
picked empty, whereas a "fixup!" is applied by amending, and the
emptiness of an amended commit is measured against the wrong parent.  So
the rebase falls through to "git commit --amend", which refuses to
create an empty commit, and halts.

With this patch the emptied commit is recognized and handled according
to "--empty", the same as any other commit that becomes empty during a
rebase:

    $ git rebase -i --autosquash --empty=drop 9a1b2c3
    Rebasing (2/2)
    dropping 8e9f0a1... fixup! add feature patch -- squashing it in empties the commit
    Successfully rebased and updated refs/heads/main.

    $ git log --oneline
    9a1b2c3 base

"--empty=keep" retains it as an empty commit, and "--empty=stop" (the
default under "-i") halts so the user can decide -- matching how these
options already behave for commits that become empty when picked.

As "--empty" only governs commits that *become* empty, a commit that was
picked empty to begin with is never dropped, and neither is one that a
fixup empties out in the middle of a chain, since the fixups that follow
it would then be squashed into the previous commit instead.

Changes in v3:
 * Switch the new tests' assertions from grep to test_grep for better
   diagnostics (per review).
 * Link to v2: https://lore.kernel.org/r/20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com

Changes in v2 (thanks to Phillip Wood's review):
 * An emptied fixup/squash now honors --empty in all cases, including
   when the commit it was folded into started out empty; v1 kept that
   case regardless of --empty.
 * On drop, the dropped commit and its fixup are no longer recorded as
   rewritten, so nothing spurious reaches the post-rewrite machinery.
 * Added tests for the empty-placeholder + fixup cases and for the
   not-recorded-as-rewritten behavior; adjusted t3415 "abort last squash".
 * Link to v1: https://lore.kernel.org/r/20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com
---
 Documentation/git-rebase.adoc |  11 ++
 sequencer.c                   | 300 +++++++++++++++++++++++++++++++++++++++++-
 t/t3415-rebase-autosquash.sh  | 164 +++++++++++++++++++++++
 t/t5407-post-rewrite-hook.sh  |  20 +++
 4 files changed, 491 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..a171d3831a 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -282,6 +282,11 @@ by `git log --cherry-mark ...`) are detected and dropped as a
 preliminary step (unless `--reapply-cherry-picks` or `--keep-base` is
 passed).
 +
+A commit can also become empty when `--autosquash` squashes a `fixup!`
+or `squash!` commit into it that cancels out all of its changes.  This
+option governs such a commit as well; it is dropped, kept, or stopped
+at just like a commit that becomes empty when it is picked.
++
 See also INCOMPATIBLE OPTIONS below.
 
 --no-keep-empty::
@@ -591,6 +596,12 @@ changed from `pick` to `squash`, `fixup` or `fixup -C`, respectively, and they
 are moved right after the commit they modify.  The `--interactive` option can
 be used to review and edit the todo list before proceeding.
 +
+Squashing a `fixup!` or `squash!` commit into its target can cancel out all
+of the changes of that target, leaving an empty commit behind.  What happens
+then is governed by the `--empty` option, so a change can be backed out of a
+series by committing a revert of it as a `fixup!` and letting
+`--autosquash --empty=drop` remove the two together.
++
 The recommended way to create commits with squash markers is by using the
 `--squash`, `--fixup`, `--fixup=amend:` or `--fixup=reword:` options of
 linkgit:git-commit[1], which take the target commit as an argument and
diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..4524de3f8b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -210,6 +210,31 @@ static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-res
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_trailer, "rebase-merge/trailer")
+/*
+ * The file that remembers, across a stop for conflict resolution, what
+ * "enum fixup_target" recorded about the commit a chain of fixup and
+ * squash commands is being applied to.
+ */
+static GIT_PATH_FUNC(rebase_path_fixup_target, "rebase-merge/fixup-target")
+
+/*
+ * What we know about the commit that the current chain of fixup and squash
+ * commands is being applied to.  A commit is only dropped when squashing
+ * the fixups into it empties it out if it was picked with changes of its
+ * own, so anything but FIXUP_TARGET_PICKED_NONEMPTY keeps it.
+ */
+enum fixup_target {
+	/*
+	 * The commit was not created by a "pick", either because it was
+	 * dropped or because the todo list starts the chain with some
+	 * other command such as "reset", "exec" or "break".
+	 */
+	FIXUP_TARGET_UNKNOWN = 0,
+	/* The commit was picked empty, so the fixups did not empty it. */
+	FIXUP_TARGET_PICKED_EMPTY,
+	/* The commit was picked with changes, so the fixups may empty it. */
+	FIXUP_TARGET_PICKED_NONEMPTY
+};
 
 /*
  * A 'struct replay_ctx' represents the private state of the sequencer.
@@ -234,6 +259,11 @@ struct replay_ctx {
 	 * Whether message contains a commit message.
 	 */
 	unsigned have_message :1;
+	/*
+	 * What the commit that the current chain of fixup and squash
+	 * commands is being applied to was picked as.
+	 */
+	enum fixup_target fixup_target;
 };
 
 struct replay_ctx* replay_ctx_new(void)
@@ -587,6 +617,38 @@ static int write_message(const void *buf, size_t len, const char *filename,
 	return 0;
 }
 
+/* The two names that rebase_path_fixup_target() stores. */
+static const char *const fixup_target_name[] = {
+	[FIXUP_TARGET_PICKED_EMPTY] = "picked-empty",
+	[FIXUP_TARGET_PICKED_NONEMPTY] = "picked-non-empty"
+};
+
+/*
+ * Remember what the commit that the current chain of fixup and squash
+ * commands is being applied to was picked as, both in the sequencer state
+ * and on disk so that it survives a stop for conflict resolution.
+ */
+static int set_fixup_target(struct replay_opts *opts, enum fixup_target target)
+{
+	struct replay_ctx *ctx = opts->ctx;
+	const char *name;
+
+	if (ctx->fixup_target == target)
+		return 0;
+
+	ctx->fixup_target = target;
+	if (!is_rebase_i(opts))
+		return 0;
+
+	if (target == FIXUP_TARGET_UNKNOWN) {
+		unlink(rebase_path_fixup_target());
+		return 0;
+	}
+
+	name = fixup_target_name[target];
+	return write_message(name, strlen(name), rebase_path_fixup_target(), 1);
+}
+
 int read_oneliner(struct strbuf *buf,
 	const char *path, unsigned flags)
 {
@@ -1778,6 +1840,23 @@ static int is_original_commit_empty(struct commit *commit)
 	return oideq(ptree_oid, get_commit_tree_oid(commit));
 }
 
+/*
+ * Remember whether "commit", which a "pick" has just put at HEAD, has
+ * changes of its own, as only such a commit is dropped when the fixups
+ * that follow it empty it out again.
+ */
+static int set_fixup_target_picked(struct replay_opts *opts,
+				   struct commit *commit)
+{
+	int empty = is_original_commit_empty(commit);
+
+	if (empty < 0)
+		return -1;
+
+	return set_fixup_target(opts, empty ? FIXUP_TARGET_PICKED_EMPTY :
+				FIXUP_TARGET_PICKED_NONEMPTY);
+}
+
 /*
  * Should empty commits be allowed?  Return status:
  *    <0: Error in is_index_unchanged(r) or is_original_commit_empty(commit)
@@ -1818,6 +1897,41 @@ static int allow_empty(struct repository *r,
 		return 0;
 }
 
+/*
+ * A "fixup" or "squash" is applied by amending HEAD, so the commit it
+ * produces is empty when the index matches the tree of HEAD's parent,
+ * rather than the tree of HEAD itself that is_index_unchanged() looks at.
+ * Returns 1 if amending HEAD would leave it empty, 0 if not, and negative
+ * on error.
+ */
+static int is_amended_head_empty(struct repository *r)
+{
+	const struct object_id *parent_tree_oid;
+	struct object_id *cache_tree_oid;
+	struct commit *head;
+
+	head = lookup_commit_reference_by_name("HEAD");
+	if (!head || repo_parse_commit(r, head))
+		return error(_("could not parse HEAD commit"));
+
+	if (head->parents) {
+		struct commit *parent = head->parents->item;
+
+		if (repo_parse_commit(r, parent))
+			return error(_("could not parse parent commit %s"),
+				     oid_to_hex(&parent->object.oid));
+		parent_tree_oid = get_commit_tree_oid(parent);
+	} else {
+		parent_tree_oid = the_hash_algo->empty_tree; /* HEAD is root */
+	}
+
+	cache_tree_oid = get_cache_tree_oid(r->index);
+	if (!cache_tree_oid)
+		return -1;
+
+	return oideq(cache_tree_oid, parent_tree_oid);
+}
+
 static struct {
 	char c;
 	const char *str;
@@ -2273,11 +2387,39 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+/*
+ * Drop the commit at HEAD by moving HEAD back to its parent.  The index and
+ * the worktree already match the tree of that parent, so nothing else needs
+ * to be updated.  "action" names the command doing the dropping and is only
+ * used for the reflog message.
+ */
+static int drop_head_commit(struct repository *r, struct replay_opts *opts,
+			    const char *action)
+{
+	struct commit *head = lookup_commit_reference_by_name("HEAD");
+
+	if (!head || repo_parse_commit(r, head))
+		return error(_("could not parse HEAD commit"));
+	if (!head->parents)
+		return error(_("cannot drop the root commit"));
+
+	return refs_update_ref(get_main_ref_store(r),
+			       reflog_message(opts, action,
+					      "dropping emptied commit"),
+			       "HEAD", &head->parents->item->object.oid,
+			       &head->object.oid, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 enum pick_result {
 	PICK_RESULT_ERROR = -1,
 	PICK_RESULT_OK,
 	PICK_RESULT_CONFLICTS,
 	PICK_RESULT_DROPPED,
+	/*
+	 * The fixups were squashed into a commit that they emptied out, so
+	 * that commit was dropped along with them.
+	 */
+	PICK_RESULT_DROPPED_HEAD,
 };
 
 static enum pick_result do_pick_commit(struct repository *r,
@@ -2293,7 +2435,7 @@ static enum pick_result do_pick_commit(struct repository *r,
 	const char *base_label, *next_label, *reflog_action;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
-	int res, unborn = 0, reword = 0, allow, drop_commit = 0;
+	int res, unborn = 0, reword = 0, allow, drop_commit = 0, drop_head = 0;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
@@ -2540,7 +2682,61 @@ static enum pick_result do_pick_commit(struct repository *r,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
 	} /* else allow == 0 and there's nothing special to do */
-	if (!opts->no_commit && !drop_commit) {
+
+	/*
+	 * allow_empty() above only notices a commit that adds nothing to
+	 * HEAD.  A "fixup" or "squash" can also cancel out the changes of
+	 * the commit it is squashed into, which leaves that commit empty
+	 * instead, so check for that here and honor --empty for it.
+	 */
+	if ((flags & AMEND_MSG) &&
+	    ctx->fixup_target == FIXUP_TARGET_PICKED_NONEMPTY) {
+		if (!final_fixup || opts->keep_redundant_commits) {
+			/*
+			 * Keep the commit, even if it is empty for now, when
+			 * more fixups are still to be squashed into it, as
+			 * dropping it here would squash them into the
+			 * previous commit instead.  Also keep it when
+			 * --empty=keep asks us to.
+			 */
+			flags |= ALLOW_EMPTY;
+		} else if (opts->drop_redundant_commits) {
+			/*
+			 * allow_empty() above may have dropped this final
+			 * fixup as already upstream, leaving HEAD as the
+			 * earlier fixups of the chain made it, so check
+			 * HEAD whether or not drop_commit is set.
+			 */
+			int emptied = is_amended_head_empty(r);
+
+			if (emptied < 0) {
+				res = emptied;
+				goto leave;
+			}
+			if (emptied) {
+				unlink(git_path_merge_msg(r));
+				refs_delete_ref(get_main_ref_store(r), "",
+						"AUTO_MERGE", NULL,
+						REF_NO_DEREF);
+				res = drop_head_commit(r, opts,
+						       command_to_string(command));
+				if (res)
+					goto leave;
+				drop_head = 1;
+				fprintf(stderr,
+					_("dropping %s %s -- squashing it in empties the commit\n"),
+					oid_to_hex(&commit->object.oid),
+					msg.subject);
+			}
+		}
+		/*
+		 * Otherwise --empty=stop is in effect, and "git commit
+		 * --amend" below refuses to make the commit empty, which
+		 * halts the rebase.
+		 */
+	}
+
+	if (!opts->no_commit && !drop_commit && !drop_head) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
 					opts, flags,
@@ -2587,6 +2783,8 @@ static enum pick_result do_pick_commit(struct repository *r,
 		return PICK_RESULT_ERROR;
 	else if (res > 0)
 		return PICK_RESULT_CONFLICTS;
+	else if (drop_head)
+		return PICK_RESULT_DROPPED_HEAD;
 	else if (drop_commit)
 		return PICK_RESULT_DROPPED;
 	else
@@ -3318,6 +3516,17 @@ static int read_populate_opts(struct replay_opts *opts)
 		}
 		strbuf_reset(&buf);
 
+		if (read_oneliner(&buf, rebase_path_fixup_target(),
+				  READ_ONELINER_SKIP_IF_EMPTY)) {
+			enum fixup_target target;
+
+			for (target = FIXUP_TARGET_PICKED_EMPTY;
+			     target <= FIXUP_TARGET_PICKED_NONEMPTY; target++)
+				if (!strcmp(buf.buf, fixup_target_name[target]))
+					ctx->fixup_target = target;
+			strbuf_reset(&buf);
+		}
+
 		if (read_oneliner(&ctx->current_fixups,
 				  rebase_path_current_fixups(),
 				  READ_ONELINER_SKIP_IF_EMPTY)) {
@@ -5057,9 +5266,25 @@ static int pick_one_commit(struct repository *r,
 				    peek_command(todo_list, 1));
 		return 0;
 	} else if (pick_res == PICK_RESULT_DROPPED) {
+		/*
+		 * When a "pick" is dropped HEAD stays where it was, so a
+		 * "fixup" that follows would be squashed into a commit we
+		 * know nothing about.  A dropped "fixup" on the other hand
+		 * leaves the commit it targets untouched.
+		 */
+		if (!is_fixup(item->command))
+			set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
 		if (is_final_fixup(todo_list))
 			flush_rewritten_pending();
 		return 0;
+	} else if (pick_res == PICK_RESULT_DROPPED_HEAD) {
+		/*
+		 * The commit the fixups were squashed into is gone, so
+		 * neither it nor any of them were rewritten and there is
+		 * nothing left for the post-rewrite machinery to report.
+		 */
+		unlink(rebase_path_rewritten_pending());
+		return 0;
 	} else if (pick_res == PICK_RESULT_CONFLICTS &&
 		   is_fixup(item->command)) {
 		return error_failed_squash(r, item->commit, opts,
@@ -5116,6 +5341,21 @@ static int pick_commits(struct repository *r,
 		if (save_todo(todo_list, opts, reschedule))
 			return -1;
 		if (is_rebase_i(opts)) {
+			/*
+			 * Only a commit created by a "pick" is dropped when
+			 * the fixups squashed into it empty it out, and only
+			 * if it was picked with changes of its own.  Remember
+			 * which kind of "pick" this is, and forget about the
+			 * last "pick" as soon as any other command runs.
+			 */
+			if (item->command == TODO_PICK) {
+				if (set_fixup_target_picked(opts, item->commit))
+					return -1;
+			} else if (!is_noop(item->command) &&
+				   !is_fixup(item->command)) {
+				set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
+			}
+
 			if (item->command != TODO_COMMENT) {
 				FILE *f = fopen(rebase_path_msgnum(), "w");
 
@@ -5520,12 +5760,51 @@ static int commit_staged_changes(struct repository *r,
 		}
 	}
 
+	/*
+	 * If resolving the conflicts of the last "fixup" or "squash" of a
+	 * chain undid the commit they are being squashed into, honor
+	 * --empty for that commit just as do_pick_commit() does when the
+	 * chain applies cleanly.
+	 */
+	if ((flags & AMEND_MSG) && opts->drop_redundant_commits &&
+	    ctx->fixup_target == FIXUP_TARGET_PICKED_NONEMPTY &&
+	    !is_fixup(peek_command(todo_list, 0))) {
+		int emptied = is_amended_head_empty(r);
+
+		if (emptied < 0) {
+			ret = emptied;
+			goto out;
+		}
+		if (emptied) {
+			ret = drop_head_commit(r, opts, "continue");
+			if (ret)
+				goto out;
+
+			/*
+			 * Neither the dropped commit nor the fixups squashed
+			 * into it were rewritten, so leave nothing behind for
+			 * the post-rewrite machinery to report.
+			 */
+			unlink(rebase_path_stopped_sha());
+			unlink(rebase_path_rewritten_pending());
+
+			/*
+			 * Remove what "git commit" would have removed, and
+			 * clean up after the chain like its final fixup does.
+			 */
+			unlink(git_path_merge_msg(r));
+			final_fixup = 1;
+			goto cleanup;
+		}
+	}
+
 	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
 			   reflog_action, opts, flags)) {
 		ret = error(_("could not commit staged changes."));
 		goto out;
 	}
 
+cleanup:
 	unlink(rebase_path_amend());
 	unlink(git_path_merge_head(r));
 	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
@@ -6488,9 +6767,11 @@ int todo_list_write_to_file(struct repository *r, struct todo_list *todo_list,
 
 /* skip picking commits whose parents are unchanged */
 static int skip_unnecessary_picks(struct repository *r,
+				  struct replay_opts *opts,
 				  struct todo_list *todo_list,
 				  struct object_id *base_oid)
 {
+	struct commit *base_commit = NULL;
 	struct object_id *parent_oid;
 	int i;
 
@@ -6513,6 +6794,7 @@ static int skip_unnecessary_picks(struct repository *r,
 		if (!oideq(parent_oid, base_oid))
 			break;
 		oidcpy(base_oid, &item->commit->object.oid);
+		base_commit = item->commit;
 	}
 	if (i > 0) {
 		const char *done_path = rebase_path_done();
@@ -6527,8 +6809,18 @@ static int skip_unnecessary_picks(struct repository *r,
 		todo_list->current = 0;
 		todo_list->done_nr += i;
 
-		if (is_fixup(peek_command(todo_list, 0)))
+		if (is_fixup(peek_command(todo_list, 0))) {
+			/*
+			 * The picks that were skipped never reach
+			 * pick_commits(), so record here what the last of
+			 * them left at HEAD for the fixups that follow it.
+			 */
+			if (base_commit &&
+			    set_fixup_target_picked(opts, base_commit))
+				return -1;
+
 			record_in_rewritten(base_oid, peek_command(todo_list, 0));
+		}
 	}
 
 	return 0;
@@ -6727,7 +7019,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		BUG("invalid todo list after expanding IDs:\n%s",
 		    new_todo.buf.buf);
 
-	if (opts->allow_ff && skip_unnecessary_picks(r, &new_todo, &oid)) {
+	if (opts->allow_ff && skip_unnecessary_picks(r, opts, &new_todo, &oid)) {
 		todo_list_release(&new_todo);
 		return error(_("could not skip unnecessary pick commands"));
 	}
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 07a5a11678..45f396cf62 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -510,4 +510,168 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
 	test_commit_message HEAD -m "something"
 '
 
+test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addX fileX 1 &&
+	test_commit --no-tag changeX fileX 2 &&
+	test_commit --no-tag later fileW hello &&
+	test_commit --no-tag "fixup! changeX" fileX 1 &&
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	cat >expect <<-\EOF &&
+	later
+	addX
+	EOF
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code ORIG_HEAD HEAD
+'
+
+test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
+	git reset --hard base &&
+	test_commit --no-tag addY fileY 1 &&
+	test_commit --no-tag changeY fileY 2 &&
+	test_commit --no-tag "fixup! changeY" fileY 1 &&
+
+	git rebase -i --autosquash --empty=keep HEAD~3 &&
+
+	cat >expect <<-\EOF &&
+	changeY
+	addY
+	EOF
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	: "the commit that was kept is empty" &&
+	git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'fixup! that empties its target halts by default' '
+	git reset --hard base &&
+	test_commit --no-tag addZ fileZ 1 &&
+	test_commit --no-tag changeZ fileZ 2 &&
+	test_commit --no-tag "fixup! changeZ" fileZ 1 &&
+
+	test_when_finished "git rebase --abort" &&
+	test_must_fail git rebase -i --autosquash HEAD~3
+'
+
+test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
+	git reset --hard base &&
+	test_commit --no-tag addS fileS 1 &&
+	test_commit --no-tag changeS fileS 2 &&
+	test_commit --no-tag "squash! changeS" fileS 1 &&
+
+	git rebase -i --autosquash --empty=drop HEAD~3 &&
+
+	echo addS >expect &&
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code ORIG_HEAD HEAD
+'
+
+test_expect_success 'a target emptied in the middle of a chain is not dropped' '
+	git reset --hard base &&
+	test_commit --no-tag addM fileM 1 &&
+	test_commit --no-tag changeM fileM 2 &&
+	test_commit --no-tag "fixup! changeM" fileM 1 &&
+	test_commit --no-tag "fixup! changeM" fileN later &&
+
+	git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	: "the second fixup! refills the commit the first one emptied" &&
+	cat >expect <<-\EOF &&
+	changeM
+	addM
+	EOF
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code ORIG_HEAD HEAD
+'
+
+test_expect_success 'fixup! that becomes empty, after its target has become empty' '
+	git checkout -f first-commit &&
+	test_commit two file1 2 &&
+	test_commit --no-tag "fixup! two" file1 0 &&
+	test_commit --no-tag "fixup! two" file3 3 &&
+	test_commit four file2 4 &&
+
+	git rebase --autosquash --empty=drop --reapply-cherry-picks base 2>err &&
+	test_grep "contents already upstream" err &&
+	test_grep "squashing it in empties the commit" err &&
+	echo four >expect &&
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code four HEAD
+'
+
+test_expect_success 'a commit picked empty is kept when a fixup! leaves it empty' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	git commit --allow-empty -m "fixup! placeholder" &&
+
+	git rebase -i --autosquash --empty=drop HEAD~2 &&
+
+	: "--empty only governs commits that become empty" &&
+	echo placeholder >expect &&
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'fixup! filling in an empty commit keeps a non-empty commit' '
+	git reset --hard base &&
+	git commit --allow-empty -m placeholder &&
+	test_commit --no-tag "fixup! placeholder" fileP content &&
+
+	git rebase -i --autosquash --empty=drop HEAD~2 &&
+
+	echo placeholder >expect &&
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual &&
+	git diff --exit-code ORIG_HEAD HEAD &&
+	test_must_fail git diff --exit-code HEAD~1 HEAD
+'
+
+test_expect_success 'a fixup! not preceded by a pick does not drop its target' '
+	git reset --hard base &&
+	test_commit --no-tag addQ fileQ 1 &&
+	test_commit --no-tag changeQ fileQ 2 &&
+	test_commit --no-tag "fixup! changeQ" fileQ 1 &&
+
+	: "an exec between the pick and the fixup hides what was picked" &&
+	test_when_finished "git rebase --abort" &&
+	set_fake_editor &&
+	test_must_fail env FAKE_LINES="1 2 exec_true 3" \
+		git rebase -i --autosquash --empty=drop HEAD~3
+'
+
+test_expect_success 'resolving a conflicted fixup! by emptying its target drops it' '
+	git reset --hard base &&
+	test_commit --no-tag addC fileC 1 &&
+	test_commit --no-tag changeC fileC 2 &&
+	test_commit --no-tag otherC fileC 3 &&
+	test_commit --no-tag "fixup! changeC" fileC 1 &&
+
+	test_when_finished "test_might_fail git rebase --abort" &&
+	: "the fixup! is built on otherC, so it conflicts with changeC" &&
+	test_must_fail git rebase -i --autosquash --empty=drop HEAD~4 &&
+
+	: "resolve it by undoing changeC, which leaves changeC empty" &&
+	echo 1 >fileC &&
+	git add fileC &&
+	: "changeC is now gone, so otherC conflicts with addC" &&
+	test_must_fail git rebase --continue &&
+	echo 3 >fileC &&
+	git add fileC &&
+	git rebase --continue &&
+
+	cat >expect <<-\EOF &&
+	otherC
+	addC
+	EOF
+	git log --format=%s base.. >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ca8a10fbb1..eb6e503b0c 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -333,4 +333,24 @@ test_expect_success 'rebase with commits that become empty' '
 	verify_hook_input
 '
 
+test_expect_success 'rebase drops a commit that its fixup empties' '
+	git checkout -b empty-fixup A &&
+	test_commit --no-tag P1 file1 one &&
+	test_commit --no-tag P2 file1 two &&
+	test_commit --no-tag P3 file2 three &&
+	test_commit --no-tag "fixup! P2" file1 one &&
+	p1=$(git rev-parse HEAD~3) &&
+	p3=$(git rev-parse HEAD~1) &&
+	clear_hook_input &&
+
+	git rebase -i --autosquash --empty=drop B &&
+
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$p1 $(git rev-parse HEAD~1)
+	$p3 $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
 test_done

---
base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
change-id: 20260709-fz-autosquash-empty-b6692cf36c60

