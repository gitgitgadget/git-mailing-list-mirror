Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1831714A
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345584; cv=pass; b=mG+uf43L4rGLQEIdyTA5FNuDpG8tzc2hybF+MUJV/2gMpjoKnwjlxl47tMa38kYZJx4g01D5T64LgQ8G/P5hm+S7U8tGaZMGBGT3O6r3FTXYfAACGk/GHj2JgWfJqLUvChkwWuUO+J2Qp4rn9dAzQGAs/yjlcZE4g7fpyZcU/E8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345584; c=relaxed/simple;
	bh=X98evsCmsGM3muqQBykuTtkBWtMzD0bh2T8MktIAS1Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=aVqvDGpnvR10FCYy6kqqn/WVAPmi80+SM3B0hxpDAeTK5XaOcpHLihIHdMG9YhVAJQwisGNCd8DbXYeEXfABsCYTA3mbidHwLhqquAr/1oB191nWHlNdb21H0TLwJKa3KdV92Lz2iadf75Cah2jVCBwraks4x+HyGvaksaCafYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nbobko.com; spf=pass smtp.mailfrom=nbobko.com; dkim=pass (1024-bit key) header.d=nbobko.com header.i=nikita@nbobko.com header.b=f5qt1sfS; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nbobko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbobko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nbobko.com header.i=nikita@nbobko.com header.b="f5qt1sfS"
ARC-Seal: i=1; a=rsa-sha256; t=1790345577; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MhV11bouCgsgEB/LQRvoQk8VMwfCX9jjpRqgAKAZNckc56PRMH5a7LlsCieLlEU7TESMf63fN2q8BRt/3nZWYsQXWC6sYd2kIWNI8rtXYfNEra0wasihluFNBRkifQQiOrSP2kg6cNPev2+S465anUol49cqmQQzxcl3Vm7nNEg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790345577; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Rq1Qc6UMR0bIMO0OR3RHA/r0DQmYY3uaa+fxgDA0Dps=; 
	b=LzG1/htU3PWVFdc/LNn89e16jdZ7R1NMssVBJ9dqli2xr5FZ0NB9dQwOmpxtg3zDTEHD3CQJeTYpe39M+cSUWckQtBwH5ISOhiWAAFHozFkq8CVD/fn0AoH6JIZ7PmgKkpBggkYCPED2W8Xj9y8XvKLCBBkUGSycCaCT4ckr99k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=nbobko.com;
	spf=pass  smtp.mailfrom=nikita@nbobko.com;
	dmarc=pass header.from=<nikita@nbobko.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790345577;
	s=zmail; d=nbobko.com; i=nikita@nbobko.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Rq1Qc6UMR0bIMO0OR3RHA/r0DQmYY3uaa+fxgDA0Dps=;
	b=f5qt1sfSiWHpp8VTyzngBGYC7ciSBCfnmNHL2F586WyG8KwhFvoIJctEFL0ulHum
	vXyHkUmVN9PE3hVXARlgljgw5Tuj0CtSwKurXgzIh5T0ZghxbhFkwjK4tnFmTOoPp/m
	gRPR5dbojDt4/ba1ww/N94ckNwiWf+0fAgazWuEc=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1790345577652567.4645759011446; Fri, 25 Sep 2026 07:12:57 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1790345575804822.7812211641747; Fri, 25 Sep 2026 07:12:55 -0700 (PDT)
Date: Fri, 25 Sep 2026 16:12:55 +0200
From: Nikita Bobko <nikita@nbobko.com>
To: "git" <git@vger.kernel.org>
Cc: "ps" <ps@pks.im>
Message-ID: <1a0d8e97d66.360c5b64612300.827632721379389681@nbobko.com>
In-Reply-To: 
Subject: [BUG] git-history in the middle of rebase leads to a broken state
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

git-history by default updates all branches that are descendants of the
original commit to point to the rewritten commit. That also includes the
branch that is *currently being rebased* (if such a branch exists),
which leads to a broken state. Even `git branch --force` doesn't allow
changing the currently being rebased branch.

I'm cc'ing Patrick Steinhardt, the original author of the git-history
command -- I hope that's fine.

I searched the mailing list and, to my knowledge, these types of bugs
haven't been reported yet (feature interactions between git-history and
git-rebase/git-cherry-pick).

## Full reproducer

    $ git init # CMD_1
    Initialized empty Git repository in /Users/bobko/git-history-bug/.git/

    $ bash -c 'for i in 1 2 3 4 5; do echo $i > $i.txt; git add .; git commit -m $i; done' # CMD_2: Populate git history
    [main (root-commit) edff563] 1
     1 file changed, 1 insertion(+)
     create mode 100644 1.txt
    [main 106a0da] 2
     1 file changed, 1 insertion(+)
     create mode 100644 2.txt
    [main a36b6d5] 3
     1 file changed, 1 insertion(+)
     create mode 100644 3.txt
    [main fd8f39c] 4
     1 file changed, 1 insertion(+)
     create mode 100644 4.txt
    [main e641e3f] 5
     1 file changed, 1 insertion(+)
     create mode 100644 5.txt

    $ git log --oneline # CMD_3
    e641e3f (HEAD -> main) 5
    fd8f39c 4
    a36b6d5 3
    106a0da 2
    edff563 1

    $ GIT_SEQUENCE_EDITOR='perl -i -pe '\''print "break\n" if $. == 1'\''' git rebase -i a36b6d5 # CMD_4: Prepend 'break'. Stop the rebase
    Stopped at a36b6d5 (3)

    $ git log --oneline # CMD_5
    a36b6d5 (HEAD) 3
    106a0da 2
    edff563 1

    $ git log --oneline -1 main # CMD_6: main still points to the original commit - good
    e641e3f (main) 5

    $ echo 3 > 2.txt && git add . && git history fixup HEAD~ # CMD_7: The command that breaks everything

    $ git log --oneline -1 main # CMD_8: Oops, main has been overwritten by git-history - bad
    24fe5b2 (main) 5

    $ git rebase --continue # CMD_9: Now, git-rebase is broken
    error: update_ref failed for ref 'refs/heads/main': cannot lock ref 'refs/heads/main': is at 24fe5b2e2c697c43bc77fde0cfd25022cf5eadba but expected e641e3f7f50d0c07650e47b31c8198d57d5598db
    error: could not update refs/heads/main

    $ git log --oneline # CMD_10
    b5f15a4 (HEAD) 5
    50c2673 4
    2c1ed1a 3
    83f595c 2
    edff563 1

    $ git status # CMD_11
    interactive rebase in progress; onto a36b6d5
    Last commands done (3 commands done):
       pick fd8f39c # 2026-09-25 Nikita Bobko/Nikita Bobko 4
       pick e641e3f # 2026-09-25 Nikita Bobko/Nikita Bobko (HEAD -> main) 5
      (see more in file .git/rebase-merge/done)
    No commands remaining.
    You are currently editing a commit while rebasing branch 'main' on 'a36b6d5'.
      (use "git commit --amend" to amend the current commit)
      (use "git rebase --continue" once you are satisfied with your changes)

    nothing to commit, working tree clean

    $ git branch --force main # CMD_12
    fatal: cannot force update the branch 'main' used by worktree at '/Users/bobko/git-history-bug'

    $ pwd # CMD_13: Yep, we are broken
    /Users/bobko/git-history-bug

## What goes wrong

CMD_4 starts the rebase; CMD_7 runs git-history in the middle of it.

CMD_9 and CMD_12 demonstrate the broken state (`git rebase --continue`
cannot finish anymore).

## Solutions that I thought of

1. The obvious one is to just forbid git-history during
   rebase/cherry-pick. Probably fine for an experimental command, but
   I believe it would forbid valid workflows.

2. Require using the explicit `--update-refs=head` flag when we are in
   git rebase state. (Forbids valid workflows when combined with
   `git rebase --update-refs`.)

3. Implicitly use `--update-refs=head` flag when we are in git rebase
   state. (Not something that users might expect. Certainly must be
   documented in the git-history(1) man page.)

4. Update all branches but the one currently being rebased. Sounds
   complicated, but I haven't managed to think of a counter-example.

   I was thinking that graphs like this might be problematic:

      * 9cc305f (main) 5
      | * 5d8f3d2 (b-4.5) 4.5
      |/
      * fbb1ec7 4
      * b47bb7e (HEAD) 3 # stop interactive rebase here, and play with git-history
      | * b052adc (b-2.5) 2.5
      |/
      * 106a0da 2
      * edff563 1

   But it looks like the end result is surprisingly "self-consistent"
   even for such graphs. The user is certainly doing something weird,
   but, what's important, the end result doesn't lead to the broken
   state described in this bug report.

   My intuition tells me something is off with the suggested
   solution, though.

5. Something else?

## Environment

git version 2.55.0 (Homebrew), cpu: arm64
Darwin 27.0.0 arm64 (macOS)

## Related notes

1. git-cherry-pick doesn't do a final ref update pass the way
   git-rebase does, so it's not affected by this specific bug (please
   correct me if I'm wrong), but it is affected by another kind of
   interaction (see point 3 below).

2. Even `git branch --force` refuses to change the ref that is
   currently being rebased (see CMD_12). git-history must not be
   allowed to do that either.

3. What if we run git-history on one of the commits mentioned in the
   git-rebase-todo file (descendants of the original HEAD) while we
   are in rebase/cherry-pick state?

   Should git-history update the git-rebase-todo file as well in such
   a case or not? git-history tries too hard to update the branches, so
   updating git-rebase-todo fits this model, but it definitely feels
   "invasive".

   (Currently, it doesn't. And it leads to the same sort of bug as in
   the current bug report anyway: CMD_9)

   (Some people might claim that this specific bug also applies to
   git-cherry-pick but has a different symptom: the result of
   git-history is silently ignored by git-cherry-pick)

4. What about feature interaction with `git rebase --update-refs`?
   (I have just learnt about `git rebase --update-refs` while writing
   this bug report so I didn't think this interaction through)

--
Nikita Bobko

