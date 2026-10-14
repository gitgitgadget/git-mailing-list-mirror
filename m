Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DF559313
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992442; cv=none; b=q+88OR5Whg2uAUc/Jw/jlZ6WMzBuNjJ5F/zkGodOW+2ICfjGv9ZhjrSFtriX4PqGmIn7rA8UHfuIkqhe1eWISe2zlvLCQtcXil5exu+KvHJyRVihtydRlBGesj1RztcpnqF6noqCzK/VoqQXyJ6+7KCdsXW8E5dfEbyCvP9+WHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992442; c=relaxed/simple;
	bh=iaFdzLhn9g+kOxuKUER3C16jbkTi3Z3Ltw3n7ERtVg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGkYclcNULKx/3qowxcqfcvsNsvmEwd+9AxlUZKOgPFFrNQcQ2fUfdwNyKcpmXOC4InAsQs7hgHtseNLXG5qBIdG2d6Uvw6YfTS+NRMraID/QJe+sNYlJ5SlWrPc9i1emzi5QUkFPOFMLrGefSRC4rQl/HrmlZkd4CAGPgv34d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtpjBtbm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtpjBtbm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so589259f8f.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791992433; x=1792597233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fvZdMLDKN2OVz4ykyoB+FtjCUCTE38AiYZmRqn/OVyo=;
        b=QtpjBtbmd/lJmgi6ykc/I3mxuoGGCcj45hf7zq7UGU1M+F87b+W/vwBwcX9ixeApPN
         zndy6nJQ4O1J/mnt7ERvg7V9vsGAdKN5LMngFNagk6fa5sLffnXSZOYCPcJlH/9IzRie
         YUUXLfj8dzxOsh8i8q96mgC909JYQ8bpPkG8M7269czDjb/VYr8qHixCskvH3Nu0hD9Y
         G++YpHL5I48NieWhmbabImrb1T1cGeKIZVaFfTqsiscVl0Lw6rL0GVr26ABLtWjw3U5Z
         OLVJj1J5MLuHDqffIVrTDM8xbHZO7i/oHgYC5nDGfW402bA0lyxK2or+X0pFo8p9KVfQ
         DsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992433; x=1792597233;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvZdMLDKN2OVz4ykyoB+FtjCUCTE38AiYZmRqn/OVyo=;
        b=A9QlUZABLm6Ji92YYczNAtpP3ksdh+dnaxfgL7MAjSiewYwD+riS4eZQZsSP1dXXpZ
         EzMvDED8nVwrQzPuNrRdfjw/ZQcepCozDR1GGAxmonxofoBLpjKP0TLWwYz8vMjFwvjo
         2h41r25vjbBHBeHlt+f11IN/Fc9LLvsYtDkNhp2dHTnxzg+HLM12HkUiukydjIOlQd/m
         FrUXJ9fcI5JVGisXA5J2/6geEsUagduwDhDCTdM0nBmyS+q/blpAXPkaABvn6yN4lZub
         rSjI7r8iDqaXkycBRiyyekVyHeNfjkHbGk2RDF29UM0KI39bdS4tJT2rYEB6Pgz0Yauj
         5GAw==
X-Gm-Message-State: AFq9FYJ+A21OYClDowtnH3wqxvUil5B4CCpNBF/VJYA6vX/UjknYveZu
	WTPoFgpNqiQCQQbopTxfF8pp+yNbSPDzsgUCq/+zzJy3hKMCJB2o3vTFju3hqA==
X-Gm-Gg: AYBFou3O7rE6E7EtzOWzCP8+PReaPzmKtGvE4c0XLR5OaIGAmggLB4YfTcHr+1SzSsy
	NsbFMiNEhiWGwK1ehKBazD/3m303Xmx2IXrti8FpoZdW4zch+c8Dt1HEPeeALS0o5vHvNBjNCVV
	w/fZme4xKzfWEeCFAXEz6yILoqXnBMGRBfuaOXJLbObUtMWi3DtI9vooiJ0G6x9B2yY1q1MTIWG
	wc2Xm1nO0J5+6P+6XUxJbtgEjcDrljOD5u0R6ePjj3dFo01bU7kIgdmFPvK+9OLS50mEl9r4FFD
	zupz/TX7C9xePiPFjBsiAJERuZuj0f1DzN6TZoALn0ZgkC6SXl/ST+BmANdk8BQr91l8mtH2E+s
	1+sLrpoOf2hvK9StlrNIKDl3JhBYAopzryRmnmNTbeLgolKkSoVyDqxmdYpE2azD3fbCdrG9Egs
	fj8MtUQEube2aygABz1CQviVYvkLnZgFVhlQkRvwGm+rNYFtxijpxVy6VHtVUPnAzGRtYAKwn2z
	A==
X-Received: by 2002:a05:6000:420b:b0:48c:a08:5858 with SMTP id ffacd0b85a97d-48dbaae6fa0mr30364434f8f.23.1791992432662;
        Wed, 14 Oct 2026 08:40:32 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm10324829f8f.2.2026.10.14.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:40:32 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/7] stash creation: avoid unecessary index loads and refreshes
Date: Wed, 14 Oct 2026 16:40:12 +0100
Message-ID: <cover.1791992404.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Junio for his comments on V1, this series has expanded in
scope to avoid unecessary index refreshes.

"git stash push" and "git stash create" load and refresh the index
multiple times when they only need to do it once. This series removes
a number of calls to repo_read_preload_index() and refresh_index()
which reduces the number of lstat() calls on each changed path by
four for "git stash create" and eight for "git stash push". It also
removes a duplicate call to check_changes() so that when stashing
untracked files we only walk them once.

Changes since V1:
 - Added an enum for the various return values from do_create_stash()
 - Fixed typos in the commit message of patch 2 (was patch 1)
 - Removed an unnecessary index refresh and several unnecessary index
   preloads

Cover letter for V1:

"git stash push" and "git stash create" check if there are
any unstaged or uncommitted changes at startup, and then again
when they try to create the stash. This short series removes
that duplication of effort which I spotted while looking at
<20260929074222.11942-1-kazumasa.shigeta@kanamei.com>.

base-commit: c46c1e37724f0478939de636ab8ea5a89086d532
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-optimize-check_changes-calls%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/c46c1e377...db53bf3b5
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-optimize-check_changes-calls/v2


Phillip Wood (7):
  stash: use an enum for create status
  stash create: remove duplicate changes detection
  stash push: remove duplicate changes detection
  stash push: avoid duplicate calls to preload_index()
  stash create: rework temporary index creation
  stash create: remove unnecessary index load and refresh
  stash: simplify reset_tree() function signature

 builtin/stash.c | 137 ++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 75 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  9e27bcd676 stash: use an enum for create status
1:  1617d92942 ! 2:  d56b7c6f67 stash create: remove duplicate changes detection
    @@ Commit message
         Before it creates a stash, git checks if there are any unstaged,
         or uncommitted changes. If there isn't anything to stash it bails
         out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
    -    and `check_changes()`, 2019-02-25) "git stash store" has checked
    +    and `check_changes()`, 2019-02-25) "git stash create" has checked
         for changes twice, once in create_stash() before we refresh the
         index and then again in do_create_stash() after the index has been
         refreshed. That commit claims it is an optimization but it is not
         clear what it is trying to optimize by checking for changes twice,
         especially as checking for changes before refreshing the index is
    -    unreliable (the scripted version of "git stash store", called "git
    +    unreliable (the scripted version of "git stash create", called "git
         update-index -q --refresh" before looking for any changes).
     
         Avoid checking for changes twice by removing the call to
    -    check_changes_tracked_files() from store_stash() and restore the return
    -    code handling in store_stash() that was removed by ef0f0b4509 so that
    -    we continue to exit 0 when there are no changes to stash. In principle
    -    we could remove the call to check_changes() from do_store_stash()
    -    instead, but then we'd need to pass in the list of untracked files.
    +    check_changes_tracked_files() from create_stash(). In principle we
    +    could remove the call to check_changes() from do_create_stash()
    +    instead, but it is more convenient to keep it there, rather than
    +    require each caller to call it instead.
    +
    +    The remaining callers of check_changes_tracked_files() sensibly read
    +    and refresh the index before calling it, so it no-longer needs to
    +    call to repo_read_index().
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/stash.c ##
    +@@ builtin/stash.c: static int check_changes_tracked_files(const struct pathspec *ps)
    + 	if (repo_get_oid(the_repository, "HEAD", &dummy))
    + 		return -1;
    + 
    +-	if (repo_read_index(the_repository) < 0)
    +-		return -1;
    +-
    + 	repo_init_revisions(the_repository, &rev, NULL);
    + 	copy_pathspec(&rev.prune_data, ps);
    + 
     @@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
      	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
      
    @@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char
      
      	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
      			      NULL, 0);
    -@@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
    - 
    - 	free_stash_info(&info);
    - 	strbuf_release(&stash_msg_buf);
    --	return ret;
    -+	/*
    -+	 * ret is 1 if there were no changes. In this case, we should
    -+	 * not error out.
    -+	 */
    -+	return ret < 0;
    - }
    - 
    - static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
2:  95b7d582a2 ! 3:  36fc0eb913 stash push: remove duplicate changes detection
    @@ Metadata
      ## Commit message ##
         stash push: remove duplicate changes detection
     
    -    Before it creates a stash, git checks if there are any unstaged,
    -    or uncommitted changes. If there isn't anything to stash it bails
    -    out. "git stash push" checks for changes twice, once in do_push_stash()
    -    and then again in do_create_stash(). Avoid that by removing the call
    -    to check_changes() from do_push_stash() and checking the return value
    -    of do_create_stash() to see if there were any changes to stash. If
    -    check_changes() finds there are no changes do_create_stash() now
    -    returns 2 rather than 1. This enables us to distinguish between there
    -    being no changes and there being nothing stashed so that "git stash
    -    push --patch" when nothing is select, and "git stash push --staged"
    -    when the index matches HEAD still exit 1 rather than 0.
    +    Before it creates a stash, git checks if there are any unstaged, or
    +    uncommitted changes. If there isn't anything to stash it bails out. "git
    +    stash push" checks for changes twice, once in do_push_stash() and then
    +    again in do_create_stash(). While duplicating the checks for staged and
    +    unstaged charges is fairly cheap because they stop after finding the
    +    first changed path, if we're stashing untracked files then we visit
    +    them all twice. Avoid that by removing the call to check_changes()
    +    from do_push_stash() and checking the return value of do_create_stash()
    +    to see if there were any changes to stash. If check_changes() finds
    +    there are no changes do_create_stash() now returns CREATE_NO_CHANGES
    +    rather than CREATE_EMPTY. This enables us to distinguish between there
    +    being no changes and there being nothing stashed, so that "git stash
    +    push --patch" when nothing is selected, and "git stash push --staged"
    +    when the index matches HEAD, still exit 1 rather than 0.
    +
    +    As we're not calling check_changes() in do_push_stash() anymore, we do
    +    not need to refresh the index there either because do_create_stash()
    +    refreshes it again before calling check_changes(). Avoiding the extra
    +    index refresh saves us two lstat() calls per changed path.
     
         There is still one small change in behavior as, if there is nothing
    -    to stash, we'll try now to create the reflog for stashes before we
    +    to stash, we'll now try to create the reflog for stashes before we
         realize that there is nothing to stash. I don't think that should
         matter in practice.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/stash.c ##
    -@@ builtin/stash.c: static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
    +@@ builtin/stash.c: enum create_result {
    + 	CREATE_SUCCESS,
    + 	/* No changes were stashed */
    + 	CREATE_EMPTY,
    ++	/* There were no changes to stash */
    ++	CREATE_NO_CHANGES,
    + };
    + 
    + static enum create_result stash_staged(struct stash_info *info,
    +@@ builtin/stash.c: static enum create_result do_create_stash(const struct pathspec *ps,
      	}
      
      	if (!check_changes(ps, include_untracked, &untracked_files)) {
    --		ret = 1;
    -+		ret = 2;
    +-		ret = CREATE_EMPTY;
    ++		ret = CREATE_NO_CHANGES;
      		goto done;
      	}
      
    -@@ builtin/stash.c: static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
    - 	free_stash_info(&info);
    - 	strbuf_release(&stash_msg_buf);
    - 	/*
    --	 * ret is 1 if there were no changes. In this case, we should
    --	 * not error out.
    -+	 * ret is greater than zero if there were no changes. In this case,
    -+	 * we should not error out.
    - 	 */
    - 	return ret < 0;
    - }
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    - 		goto done;
    + 		free(ps_matched);
      	}
      
    +-	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
    +-					 NULL, NULL, NULL)) {
    +-		ret = error(_("could not write index"));
    +-		goto done;
    +-	}
    +-
     -	if (!check_changes(ps, include_untracked, &untracked_files)) {
     -		if (!quiet)
     -			printf_ln(_("No local changes to save"));
    @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char
      		ret = -1;
      		if (!quiet)
     @@ builtin/stash.c: static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
    - 
    - 	if (stash_msg)
    - 		strbuf_addstr(&stash_msg_buf, stash_msg);
    --	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
    --			    interactive_opts, only_staged, &info, &patch, quiet)) {
    -+	ret =  do_create_stash(ps, &stash_msg_buf, include_untracked,
    -+			       patch_mode, interactive_opts, only_staged, &info,
    -+			       &patch, quiet);
    -+	if (ret == 2) {
    + 	create_res =  do_create_stash(ps, &stash_msg_buf, include_untracked,
    + 				      patch_mode, interactive_opts, only_staged,
    + 				      &info, &patch, quiet);
    +-	if (create_res != CREATE_SUCCESS) {
    ++	if (create_res == CREATE_NO_CHANGES) {
     +		if (!quiet)
     +			printf_ln(_("No local changes to save"));
     +		ret = 0;
     +		goto done;
    -+	} else if (ret) {
    ++	} else if (create_res != CREATE_SUCCESS) {
      		ret = -1;
      		goto done;
      	}
-:  ---------- > 4:  6ca7e1c567 stash push: avoid duplicate calls to preload_index()
-:  ---------- > 5:  f799d86f52 stash create: rework temporary index creation
-:  ---------- > 6:  768d6bc7e5 stash create: remove unnecessary index load and refresh
-:  ---------- > 7:  db53bf3b57 stash: simplify reset_tree() function signature
-- 
2.56.0.134.g299a3c16181

