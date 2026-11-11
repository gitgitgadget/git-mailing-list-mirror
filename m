Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410897;
	b=P2XjpAuEj8LPCSBz4pikQ2nr5xIV3OK7MPc3C621nAIhortP7+7y0ScyTsTlKou+suWx
	 LQSS5gv6iim4D32KGb6WiIvuaOzKnXchqW4NPm1qhOzUO1G+TuWwVavmb9mfi1k+C9MeE
	 m1+9VBIy66bs+6RfagIic+UsmKNJQhO73zIBX8SjE/OW2CanIKpvhp/LcFpolHnGQiUva
	 CNtaIhMdQ/Uez06MckRjXVsU0TuDlFKSmDLyT9XVgFBmikdd/Ka9QvNrXgzd/AnD1IWHY
	 t8ZPQm0PQVsHJdalJRqGKiQjGHQt/Hay9YNLTvavcZCKrhSWPq+QKAy/JHdCU+CahYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ISIH98deu9GTISVX1VokS4WS0gD9cuYMqqG4s5WUxz0=;
	b=PoH7rGPTjbR9IZ/Bb/hM8Qm/xmqYQKKXQPpLGNXWpZmgU8fVphdoHOZc2dnX4btDf6SY
	 hrCDtUDLtihNsNr4e9ikQ51iDBhdxVJRHIqNn1f8ux9TpE+2O5nLZk2WxOaobQWCH4my+
	 2fYHewDpVYD7RkJ5Bs2k31hZ3V5X0X20FmksBAlwyOFLhtURT1hPsoKk4Leix1nb/B6jN
	 bE6R+dUUlIdA4OH5QHO0z4FXbxKrEj8koXqKtu9WyHtgzhk4bt1bLptn/TlO7IjddlZzA
	 NZ3SkPXfflc2FP/a7ox4vdVSC6TYBqKBW5Xs6adm+kwKeKC7TRi3TE5f+Th+Vi3OEnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=e8671Vz6;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A93606A326
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A93606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=e8671Vz6
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91ea0c05c92so33320796d6.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410895; x=1795015695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISIH98deu9GTISVX1VokS4WS0gD9cuYMqqG4s5WUxz0=;
        b=e8671Vz6qYn4w/s8LtN/kQU5qalwAnqBgaej2VL6vyUPgWWOlYexArn6Vtjw5wFn06
         53kcZ/2T54bUT6LoZD5R/CqiFYcGNGGRuLiemF3jD6+mjt57ZxT/iwUaRsoQydXYeRcj
         aFX2X9TlBfKqts1IL20EcX5WCLAUM+E+UGstlkinw1mRkoYOiOyXLnO5Zcl3JbHjqJmG
         vE4jtziUGg77Dqa9md8jIqSi+BQ+yce68gggsPSaNiSPQwzm2PhKMRpknEdpjkOg2sIK
         BAaOkgwvFCYCR56N47i98nyKKUVr/TzivgTCcOiVAgpQVZjh013JimjotX/cpn6tD3hB
         n7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410895; x=1795015695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISIH98deu9GTISVX1VokS4WS0gD9cuYMqqG4s5WUxz0=;
        b=WVnFRMWz+LvHAkOQiBIyxF5exZobg6B1fawGpbwYs8ROBxbcE/QQKn90TtYJQ7B4R7
         g/h3tp5EKUB7qJgiPGg9gPWGnvfJrsPQbU625dWc6hhYr984Qz7Z+m64M7/+spWnaH6h
         J1+vlOlyiEWOTOGcBLhYUvPtf78YromhHRW9v6KHfnwBOm5NBE6q19GfpxGC5Lq0C6ta
         LMbzQ0t2zXFc4za0bkJuo111aWKKzLgEGcAZURI1W+TdQ1idjVjt7Opam+Dy5fGtN/qg
         cDeacSRJjJndUcLIPzUpMnt8GThWtR0PTKyBd7f68ucLfT16MfYCkxWVHOKRWKddFpym
         s2lg==
X-Gm-Message-State: APuU4Z+gPZwDlclvc/wBD/iBOG+NqD8I9vXKvDTApN6T67KYOIdz5wEI
	YPmXiWGq6J8PO59QlsE+JIvIsjySoT/P7UZyDO9W1GuuP0HlBQBLA/NxOMwgToDNh48klyQix9m
	nYUpQBe+un1yCS1LOWpKKN1h2q20yuEx8Tkizpv1BC/BX+zjmYiTPNzkp6ETx3bV05pNg7fwffj
	yOg0C7GRj6JlEo8LcSinA8WD1V5F3V25wSdD+DcaTf+f7jdEcpkAVXotryPEoVowK8YHc49ldM/
	rfeo0+QVdP0KCR9yGj2DUhVov2oirsnzpDwFclYokc=
X-Gm-Gg: AYBFou3eoJ8enWQ0QVbmT5gz0BO3podDRXZO2HSbctx56Y6ERwxaPU/FtxDYCMDysNr
	uqBo9LylGdHVF73LgRqltgz40Ni9Wt4Jvnmn4g5KSFGGt9J5XJHg75D4sMHun6OeH/SYFkiTBB3
	7KTps3+Q1u0bKrAr2skvQj7QIv3f6qkF7OoYFqvjqCzQhxdE8VF9Z9En1J0oQeaHzORsRge3Fdg
	L//jpw/DpT+YZKkWVo+TCCHl47hPW0XdWLolfrX9Xu0SbB+3ArZsxoOEXtth/dTkaKOr2uGniFO
	DLzN5SfzsdM3kIu5/UADhKVRCQGoQ6J5s5VS8/f3Dt3lk+bhKyRNztPvgLY+77+sWcsw9s0TTOx
	5LklkqAPafWCW4FE+jjCMiNOYu34ik4hpi70jVFu1Zuw2Wy0CjVo8F7zYroSEsLeB4QaxjteZy1
	izvx4BsrRPsTWQfjrsfPShLNNXtc/drOAKNP27T2RnSFGL0I54hSsWCuIBcuV6xroiUjQ0dLUdY
	/cTnUToHk0kjbv1d1l6Of5rXJfkmVDKFDzrLOJYb+0HqgxOYoHm19b3Cc+1N3hqkDE75DD7xdOb
	XNzXJfWUHxlrAwvwIesWUQbs9NckRXfLk3mU9geh2jpRMLQ/L4MSJvKPT5rnBFNOYX/nglUHW2/
	2O0HZTRrG5h3vu1u9HvT/0bJrByPfgeMiC4U2edXPZGO3uZaIiPrPUGGgRewhMYIfY53mleS4Eg
	8fAqXB895MPXIeBjlimmXstl2rdqyhA7CB+oLRTt7P7vrNfL0yDLI8NcvN0JzJoxjwyBO0xbbgc
	JbQ9PCXz1CVhh0P8+btsAbwfdzsRlfZv60WiU8cwJ2lCWqNLFzb9w==
X-Received: by 2002:a05:6214:3186:b0:91f:324:eff0 with SMTP id 6a1803df08f44-91f042ccc96mr45717326d6.53.1794410894835;
        Wed, 11 Nov 2026 07:28:14 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:13 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 0/5] worktree: treat a branch being rebased or bisected as checked out
Date: Wed, 11 Nov 2026 10:28:05 -0500
Message-ID: <20261111152811.99986-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102182930.3511-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While a worktree is rebasing or bisecting a branch, its HEAD is
detached. "git worktree add" and "git branch -d" already treat the
branch as checked out there, but "git worktree remove" deletes such a
worktree when its files are clean, and %(worktreepath) and "git
branch" do not show which worktree has the branch.

Patch 1 makes "git worktree remove" refuse a worktree in the middle of
an operation unless --force is given. Patch 2 documents how to read
%(worktreepath) safely. Patch 3 makes %(worktreepath) name the
worktree that is rebasing or bisecting a branch. Patch 4 adds
%(currentworktree), and patch 5 uses it so that "git branch" does not
mark that branch with "+" in the worktree that is rebasing it.

Changes since v4 [1]:

 * Patch 1: each item in the list of cases that need --force is now a
   complete sentence, and all the commands are in the same font, as
   Phillip asked. Ben was happy with the old wording, and I hope this
   suits both of you.

 * Patch 2: no change.

 * Patch 3: branch.c records the branches in a map, so
   branch_checked_out_worktree() is one map lookup in place of a loop
   over every worktree for each ref.

 * Patch 4 is new. It adds %(currentworktree), which Phillip
   suggested. It uses a second map in branch.c for the branches that
   the current worktree has.

 * Patch 5 replaces v4's patch 4. The default "git branch" format now
   uses %(currentworktree), so print_ref_list() is unchanged and the
   patch is a few lines in build_format().

[1] https://lore.kernel.org/git/20261102182930.3511-1-me@jaspermayone.com/

Jasper Mayone (5):
  worktree remove: refuse a worktree in the middle of an operation
  doc: for-each-ref: say how to read %(worktreepath) safely
  ref-filter: name the worktree of a branch being rebased or bisected
  ref-filter: add %(currentworktree)
  branch: do not mark the branch the current worktree is rebasing

 Documentation/git-branch.adoc       |  6 +-
 Documentation/git-for-each-ref.adoc | 19 +++++-
 Documentation/git-worktree.adoc     | 17 +++--
 branch.c                            | 33 ++++++++--
 branch.h                            | 16 +++++
 builtin/branch.c                    | 10 ++-
 builtin/worktree.c                  | 37 ++++++++++-
 ref-filter.c                        | 84 ++++---------------------
 t/t2403-worktree-move.sh            | 94 ++++++++++++++++++++++++++++
 t/t3203-branch-output.sh            | 49 +++++++++++++++
 t/t6302-for-each-ref-filter.sh      | 97 +++++++++++++++++++++++++++++
 11 files changed, 373 insertions(+), 89 deletions(-)

Range-diff against v4:
1:  bca692b844 ! 1:  69668bf9b1 worktree remove: refuse a worktree in the middle of an operation
    @@ Documentation/git-worktree.adoc: the new working tree location.
     -with submodules can be removed with `--force`. The main worktree cannot be
     -removed.
     +Remove a worktree. The main worktree cannot be removed. Without
    -+`--force`, a worktree is not removed when:
    ++`--force`, a worktree is not removed in these cases:
     ++
     +--
    -+* it has untracked files or modifications in tracked files,
    -+* it has submodules, or
    -+* it is in the middle of a rebase, a `git am` session, a bisect, a
    -+  cherry-pick or a revert, because removing it loses the state of that
    -+  operation.
    ++* The worktree has untracked files or modifications in tracked files.
    ++* The worktree has submodules.
    ++* The worktree is in the middle of a `git rebase`, `git am`,
    ++  `git bisect`, `git cherry-pick` or `git revert`. Removing the
    ++  worktree would lose the state of that operation.
     +--
      
      `repair [<path>...]`::
2:  39eb92d441 = 2:  35035d30e2 doc: for-each-ref: say how to read %(worktreepath) safely
3:  990a19fd11 ! 3:  4484dfff22 ref-filter: name the worktree of a branch being rebased or bisected
    @@ Commit message
     
         branch.c already knows the answer, as prepare_checked_out_branches()
         records the branch that each worktree has checked out, is rebasing or
    -    is bisecting. Add branch_checked_out_worktree() to look a branch up in
    -    that list, and use it for %(worktreepath) in place of the map that
    -    ref-filter.c builds from the HEAD of each worktree.
    +    is bisecting. Record those branches in a map as well, add
    +    branch_checked_out_worktree() to look a branch up in it, and use that
    +    for %(worktreepath) in place of the map that ref-filter.c builds from
    +    the HEAD of each worktree.
     
         The new function skips the branches that "rebase --update-refs" will
         update. branch_checked_out() includes them, so that they cannot be
    @@ Documentation/git-for-each-ref.adoc: but if used together the last option is sel
      	use one of the quoting options such as `--shell`, or follow
     
      ## branch.c ##
    +@@ branch.c: int validate_branchname(const char *name, struct strbuf *ref)
    + 
    + static int initialized_checked_out_branches;
    + static struct strmap current_checked_out_branches = STRMAP_INIT;
    ++/* Like current_checked_out_branches, without the "update-ref" branches. */
    ++static struct strmap checked_out_worktrees = STRMAP_INIT;
    + 
    + enum branch_checkout_kind {
    + 	BRANCH_CHECKOUT_KIND_CHECKOUT,
    +@@ branch.c: static void register_checked_out_branch(const char *prefix, const char *name,
    + 	checked_out_branches_nr++;
    + 
    + 	strmap_put(&current_checked_out_branches, refname, path_copy);
    ++	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF)
    ++		strmap_put(&checked_out_worktrees, refname, path_copy);
    + }
    + 
    + static void prepare_checked_out_branches(void)
     @@ branch.c: const char *branch_checked_out(const char *refname)
      	return strmap_get(&current_checked_out_branches, refname);
      }
      
     +const char *branch_checked_out_worktree(const char *refname)
     +{
    -+	const char *path = NULL;
    -+
     +	prepare_checked_out_branches();
    -+	for (size_t i = 0; i < checked_out_branches_nr; i++) {
    -+		if (checked_out_branches[i].kind != BRANCH_CHECKOUT_KIND_UPDATE_REF &&
    -+		    !strcmp(refname, checked_out_branches[i].refname))
    -+			path = checked_out_branches[i].path;
    -+	}
    -+	return path;
    ++	return strmap_get(&checked_out_worktrees, refname);
     +}
     +
      const char *branch_bisecting(const char *refname)
4:  56e29c448f ! 4:  944ce70324 branch: do not mark the branch the current worktree is rebasing
    @@ Metadata
     Author: Jasper Mayone <me@jaspermayone.com>
     
      ## Commit message ##
    -    branch: do not mark the branch the current worktree is rebasing
    +    ref-filter: add %(currentworktree)
     
    -    Since the previous commit, "git branch" marks a branch with "+" when a
    -    worktree is rebasing or bisecting it. In that worktree itself, the
    -    list already starts with "* (no branch, rebasing topic)", so the
    -    "+ topic" line below it says the same thing twice.
    +    %(worktreepath) names the worktree that has a branch checked out, or
    +    is rebasing or bisecting it, but a format cannot tell if that worktree
    +    is the current one. Comparing %(worktreepath) with a fixed path in
    +    %(if:equals=...) does not work for every path, because a ")" ends the
    +    atom.
     
    -    The default format cannot tell that apart: %(worktreepath) gives the
    -    same path either way, and comparing it with %(if:equals=...) is not
    -    safe because a path, or a branch name, can contain the ")" that ends
    -    the atom. So build a second format that has no "+" marker and no
    -    "(path)" for -vv, and use it for each branch that
    -    branch_checked_out_worktree() maps to the current worktree. A branch
    -    that is checked out normally in the current worktree also gets that
    -    format, but %(HEAD) still marks it with "*" and -vv already hides
    -    its path, so its output does not change.
    +    Add %(currentworktree), which gives the path of the current worktree
    +    when that worktree has the branch, and an empty string otherwise.
    +    branch.c records these branches when it reads the worktrees, in a
    +    second map next to the one that %(worktreepath) uses, so the lookup is
    +    one map lookup per ref.
     
    -    To pick a format for each branch, print_ref_list() now formats the
    -    branches itself in place of print_formatted_ref_array(), keeping
    -    --omit-empty. A format given with --format is used for every branch,
    -    as before.
    +    The next commit uses it in "git branch".
     
         Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Jasper Mayone <me@jaspermayone.com>
     
    - ## builtin/branch.c ##
    -@@ builtin/branch.c: static const char *quote_literal_for_format(const char *s)
    - 	return buf.buf;
    - }
    + ## Documentation/git-for-each-ref.adoc ##
    +@@ Documentation/git-for-each-ref.adoc: but if used together the last option is selected.
    + 	the `NUL` after the path and then for the `LF` that ends each
    + 	record.
      
    --static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
    -+/*
    -+ * With "show_worktree" unset, the format does not mark a branch that is
    -+ * checked out in a worktree, nor show the path of that worktree. It is
    -+ * used for a branch that the current worktree is rebasing or bisecting,
    -+ * because the "(no branch, ...)" line already names it.
    -+ */
    -+static char *build_format(struct ref_filter *filter, int maxwidth,
    -+			  const char *remote_prefix, int show_worktree)
    - {
    - 	struct strbuf fmt = STRBUF_INIT;
    - 	struct strbuf local = STRBUF_INIT;
    - 	struct strbuf remote = STRBUF_INIT;
    - 
    --	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
    --			branch_get_color(BRANCH_COLOR_CURRENT),
    --			branch_get_color(BRANCH_COLOR_WORKTREE),
    --			branch_get_color(BRANCH_COLOR_LOCAL));
    -+	if (show_worktree)
    -+		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
    -+			    branch_get_color(BRANCH_COLOR_CURRENT),
    -+			    branch_get_color(BRANCH_COLOR_WORKTREE),
    -+			    branch_get_color(BRANCH_COLOR_LOCAL));
    -+	else
    -+		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
    -+			    branch_get_color(BRANCH_COLOR_CURRENT),
    -+			    branch_get_color(BRANCH_COLOR_LOCAL));
    - 	strbuf_addf(&remote, "  %s",
    - 		    branch_get_color(BRANCH_COLOR_REMOTE));
    - 
    -@@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
    - 
    - 		if (filter->verbose > 1)
    - 		{
    --			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
    --				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
    -+			if (show_worktree)
    -+				strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
    -+					    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
    - 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
    - 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
    - 				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
    -@@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
    - 	return strbuf_detach(&fmt, NULL);
    - }
    - 
    -+static char *current_worktree_path(void)
    -+{
    -+	struct worktree **worktrees = get_worktrees(the_repository);
    -+	char *path = NULL;
    ++`currentworktree`::
    ++	The absolute path to the current worktree, if the ref is checked
    ++	out there, in the same sense as for `worktreepath`. Empty string
    ++	otherwise, also when the ref is checked out only in other
    ++	worktrees. Use it with `%(if)` to treat the current worktree
    ++	differently from the others.
     +
    -+	for (size_t i = 0; worktrees[i]; i++) {
    -+		if (worktrees[i]->is_current) {
    -+			path = xstrdup(worktrees[i]->path);
    -+			break;
    -+		}
    -+	}
    -+	free_worktrees(worktrees);
    -+	return path;
    -+}
    -+
    -+/*
    -+ * Is "refname" checked out in the worktree at "here", or is that
    -+ * worktree rebasing or bisecting it?
    -+ */
    -+static int checked_out_here(const char *refname, const char *here)
    -+{
    -+	const char *path = branch_checked_out_worktree(refname);
    -+
    -+	return path && !strcmp(path, here);
    -+}
    -+
    - static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
    - 			   struct ref_format *format, struct string_list *output)
    - {
    -@@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
    - 	int maxwidth = 0;
    - 	const char *remote_prefix = "";
    - 	char *to_free = NULL;
    -+	struct ref_format here_format = REF_FORMAT_INIT;
    -+	char *here_to_free = NULL, *here = NULL;
    -+	struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
    - 
    - 	/*
    - 	 * If we are listing more than just remote branches,
    -@@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
    - 	if (filter->verbose)
    - 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
    - 
    --	if (!format->format)
    --		format->format = to_free = build_format(filter, maxwidth, remote_prefix);
    -+	if (!format->format) {
    -+		format->format = to_free = build_format(filter, maxwidth,
    -+							remote_prefix, 1);
    -+		here = current_worktree_path();
    -+		here_format = *format;
    -+		here_format.format = here_to_free = build_format(filter, maxwidth,
    -+								 remote_prefix, 0);
    -+	}
    - 	format->use_color = branch_use_color;
    -+	here_format.use_color = branch_use_color;
    - 
    --	if (verify_ref_format(format))
    -+	if (verify_ref_format(format) ||
    -+	    (here && verify_ref_format(&here_format)))
    - 		die(_("unable to parse format string"));
    - 
    - 	filter_ahead_behind(the_repository, &array);
    - 	ref_array_sort(sorting, &array);
    - 
    --	if (column_active(colopts)) {
    --		struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
    --
    -+	if (column_active(colopts))
    - 		assert(!filter->verbose && "--column and --verbose are incompatible");
    - 
    --		for (i = 0; i < array.nr; i++) {
    --			strbuf_reset(&err);
    --			strbuf_reset(&out);
    --			if (format_ref_array_item(array.items[i], format, &out, &err))
    --				die("%s", err.buf);
    -+	for (i = 0; i < array.nr; i++) {
    -+		struct ref_array_item *item = array.items[i];
    -+		struct ref_format *f = format;
    - 
    -+		if (here && checked_out_here(item->refname, here))
    -+			f = &here_format;
    -+
    -+		strbuf_reset(&err);
    -+		strbuf_reset(&out);
    -+		if (format_ref_array_item(item, f, &out, &err))
    -+			die("%s", err.buf);
    -+
    -+		if (column_active(colopts))
    - 			/* format to a string_list to let print_columns() do its job */
    - 			string_list_append(output, out.buf);
    -+		else if (out.len || !format->array_opts.omit_empty) {
    -+			fwrite(out.buf, 1, out.len, stdout);
    -+			putchar('\n');
    - 		}
    --
    --		strbuf_release(&err);
    --		strbuf_release(&out);
    --	} else {
    --		print_formatted_ref_array(&array, format);
    - 	}
    - 
    -+	strbuf_release(&err);
    -+	strbuf_release(&out);
    - 	ref_array_clear(&array);
    - 	free(to_free);
    -+	free(here_to_free);
    -+	free(here);
    - }
    - 
    - static void print_current_branch_name(void)
    + `ahead-behind:<commit-ish>`::
    + 	Two integers, separated by a space, demonstrating the number of
    + 	commits ahead and behind, respectively, when comparing the output
     
    - ## t/t3203-branch-output.sh ##
    -@@ t/t3203-branch-output.sh: test_expect_success 'branch being rebased in a worktree is marked' '
    + ## branch.c ##
    +@@ branch.c: static int initialized_checked_out_branches;
    + static struct strmap current_checked_out_branches = STRMAP_INIT;
    + /* Like current_checked_out_branches, without the "update-ref" branches. */
    + static struct strmap checked_out_worktrees = STRMAP_INIT;
    ++/* The subset of checked_out_worktrees that the current worktree has. */
    ++static struct strmap current_worktree_branches = STRMAP_INIT;
    + 
    + enum branch_checkout_kind {
    + 	BRANCH_CHECKOUT_KIND_CHECKOUT,
    +@@ branch.c: static struct checked_out_branch *checked_out_branches;
    + static size_t checked_out_branches_alloc, checked_out_branches_nr;
    + 
    + static void register_checked_out_branch(const char *prefix, const char *name,
    +-					const char *path,
    ++					const struct worktree *wt,
    + 					enum branch_checkout_kind kind)
    + {
    + 	char *refname = xstrfmt("%s%s", prefix, name);
    +-	char *path_copy = xstrdup(path);
    ++	char *path_copy = xstrdup(wt->path);
    + 
    + 	ALLOC_GROW(checked_out_branches, checked_out_branches_nr + 1,
    + 		   checked_out_branches_alloc);
    +@@ branch.c: static void register_checked_out_branch(const char *prefix, const char *name,
    + 	checked_out_branches_nr++;
    + 
    + 	strmap_put(&current_checked_out_branches, refname, path_copy);
    +-	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF)
    ++	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF) {
    + 		strmap_put(&checked_out_worktrees, refname, path_copy);
    ++		if (wt->is_current)
    ++			strmap_put(&current_worktree_branches, refname, path_copy);
    ++	}
    + }
    + 
    + static void prepare_checked_out_branches(void)
    +@@ branch.c: static void prepare_checked_out_branches(void)
    + 			continue;
    + 
    + 		if (wt->head_ref) {
    +-			register_checked_out_branch("", wt->head_ref, wt->path,
    ++			register_checked_out_branch("", wt->head_ref, wt,
    + 						    BRANCH_CHECKOUT_KIND_CHECKOUT);
    + 		}
    + 
    +@@ branch.c: static void prepare_checked_out_branches(void)
    + 		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
    + 		    state.branch) {
    + 			register_checked_out_branch("refs/heads/", state.branch,
    +-						    wt->path,
    ++						    wt,
    + 						    BRANCH_CHECKOUT_KIND_REBASE);
    + 		}
    + 		wt_status_state_free_buffers(&state);
    +@@ branch.c: static void prepare_checked_out_branches(void)
    + 		    state.bisecting_from) {
    + 			register_checked_out_branch("refs/heads/",
    + 						    state.bisecting_from,
    +-						    wt->path,
    ++						    wt,
    + 						    BRANCH_CHECKOUT_KIND_BISECT);
    + 		}
    + 		wt_status_state_free_buffers(&state);
    +@@ branch.c: static void prepare_checked_out_branches(void)
    + 			struct string_list_item *item;
    + 			for_each_string_list_item(item, &update_refs) {
    + 				register_checked_out_branch("", item->string,
    +-							    wt->path,
    ++							    wt,
    + 							    BRANCH_CHECKOUT_KIND_UPDATE_REF);
    + 			}
    + 			string_list_clear(&update_refs, 1);
    +@@ branch.c: const char *branch_checked_out_worktree(const char *refname)
    + 	return strmap_get(&checked_out_worktrees, refname);
    + }
    + 
    ++const char *branch_checked_out_current_worktree(const char *refname)
    ++{
    ++	prepare_checked_out_branches();
    ++	return strmap_get(&current_worktree_branches, refname);
    ++}
    ++
    + const char *branch_bisecting(const char *refname)
    + {
    + 	prepare_checked_out_branches();
    +
    + ## branch.h ##
    +@@ branch.h: const char *branch_checked_out(const char *refname);
    +  */
    + const char *branch_checked_out_worktree(const char *refname);
    + 
    ++/*
    ++ * Like branch_checked_out_worktree(), but only for the current
    ++ * worktree: return its path if it has the branch 'refname' checked
    ++ * out, or is rebasing or bisecting it. Otherwise return NULL.
    ++ */
    ++const char *branch_checked_out_current_worktree(const char *refname);
    ++
    + /*
    +  * If the branch at 'refname' is currently used for bisecting in a
    +  * worktree, then return the path to that worktree.
    +
    + ## ref-filter.c ##
    +@@ ref-filter.c: enum atom_type {
    + 	ATOM_HEAD,
    + 	ATOM_COLOR,
    + 	ATOM_WORKTREEPATH,
    ++	ATOM_CURRENTWORKTREE,
    + 	ATOM_ALIGN,
    + 	ATOM_END,
    + 	ATOM_IF,
    +@@ ref-filter.c: static struct {
    + 	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
    + 	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
    + 	[ATOM_WORKTREEPATH] = { "worktreepath", SOURCE_NONE },
    ++	[ATOM_CURRENTWORKTREE] = { "currentworktree", SOURCE_NONE },
    + 	[ATOM_ALIGN] = { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
    + 	[ATOM_END] = { "end", SOURCE_NONE },
    + 	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
    +@@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
    + 				v->s = xstrdup("");
    + 			continue;
    + 		}
    ++		else if (atom_type == ATOM_CURRENTWORKTREE) {
    ++			const char *path = NULL;
    ++
    ++			if (ref->kind == FILTER_REFS_BRANCHES)
    ++				path = branch_checked_out_current_worktree(ref->refname);
    ++			v->s = xstrdup(path ? path : "");
    ++			continue;
    ++		}
    + 		else if (atom_type == ATOM_SYMREF)
    + 			refname = get_symref(atom, ref);
    + 		else if (atom_type == ATOM_UPSTREAM) {
    +
    + ## t/t6302-for-each-ref-filter.sh ##
    +@@ t/t6302-for-each-ref-filter.sh: test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
      	test_cmp expect actual
      '
      
    -+test_expect_success 'branch being rebased is not marked in its own worktree' '
    -+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
    -+	git worktree add -b rebasing rebase_dir branch-two &&
    -+	(
    -+		cd rebase_dir &&
    -+		git commit --allow-empty -m rebase-me &&
    -+		test_must_fail git rebase -f -x false HEAD~1 &&
    -+		git branch --list rebasing >actual &&
    -+		echo "  rebasing" >expect &&
    -+		test_cmp expect actual &&
    -+		git branch -vv --list rebasing >actual &&
    -+		test_grep ! "$(pwd)" actual &&
    -+		git branch >actual &&
    -+		test_grep "^\* (no branch, rebasing rebasing)" actual
    -+	)
    ++test_expect_success 'currentworktree atom' '
    ++	test_when_finished "git -C current rebase --abort; rm -rf current; git worktree prune; git branch -D current" &&
    ++	git worktree add -b current current main &&
    ++	git -C current commit --allow-empty -m rebase-me &&
    ++	test_must_fail git -C current rebase -f -x false main &&
    ++	git for-each-ref --format="%(refname:short) [%(currentworktree)]" \
    ++		refs/heads/main refs/heads/current >actual &&
    ++	cat >expect <<-EOF &&
    ++	current []
    ++	main [$(pwd)]
    ++	EOF
    ++	test_cmp expect actual &&
    ++	git -C current for-each-ref --format="%(refname:short) [%(currentworktree)]" \
    ++		refs/heads/main refs/heads/current >actual &&
    ++	cat >expect <<-EOF &&
    ++	current [$(pwd)/current]
    ++	main []
    ++	EOF
    ++	test_cmp expect actual
     +'
     +
    - test_expect_success 'branch being bisected in a worktree is marked' '
    - 	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
    - 	git worktree add -b bisecting bisect_dir branch-two &&
    -@@ t/t3203-branch-output.sh: test_expect_success 'branch being bisected in a worktree is marked' '
    - 		git commit --allow-empty -m bisect-one &&
    - 		git commit --allow-empty -m bisect-two &&
    - 		git bisect start HEAD HEAD~2 &&
    --		test_must_fail git symbolic-ref -q HEAD
    -+		test_must_fail git symbolic-ref -q HEAD &&
    -+		git branch --list bisecting >actual &&
    -+		echo "  bisecting" >expect &&
    -+		test_cmp expect actual
    - 	) &&
    - 	git branch --list bisecting >actual &&
    - 	echo "+ bisecting" >expect &&
    + test_expect_success 'start after with empty value' '
    + 	cat >expect <<-\EOF &&
    + 	refs/heads/main
-:  ---------- > 5:  4177c84d31 branch: do not mark the branch the current worktree is rebasing
-- 
2.56.0

