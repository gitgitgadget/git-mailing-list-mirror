Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0307C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C627461241
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 15:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347224AbhIXPk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347182AbhIXPku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 11:40:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610DC061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so28890914wri.1
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 08:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=KbsNlraAXjOK2VT0uR+aVTZlR+MX3K3NAD/4QLd+rpo=;
        b=Ihi4rs6i/KGsaycyStY4zWZ8zFQAulhKkfb1SMrUSNl9SDBiSFtNwDaXzF+z3e7Wgp
         PlaMjI4q0ZA1ce3cc3ayMUltLm5Yb1T6roBq80fRYaoIw7YFi+ORJ4/aU120Jq7VZZnZ
         3It4xaY2W8CU2q+Y948gvX8v7x1jptc8cHDIamdWwzakBFAz/gNRwpR5FRFTYgQ8zD5O
         3BltDRPqpYjKWgMzV1wdlBAk9InuW275330WjZqijRzZZGtpRZMyiJFC8GL3RWn2bgiM
         sJwH6tVU7DEjRN8QibMpDdbkq7g/Rx1tQKrd6DzGgb602i/jHfrABuyzMDYiKKzdNwic
         k5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=KbsNlraAXjOK2VT0uR+aVTZlR+MX3K3NAD/4QLd+rpo=;
        b=3x5Qn6hApG3lgwIW73rHuSmoCp9J4rVTS8HLxew/mLfLJdpjg8La+mPQZS+TXqMv2I
         5YZTTFfxkyv3qIh4LefM3ysCduemwxVwkGbrB9pOvQvn268SXMSpv0Ft0apB2pSe2KdS
         93QqVzl/2tyqqqQMMKCd1iKqi/iTaRHThk2e+GQlauizcwx22TQDDnL2TalRodPMGilg
         rQP+/BI/9X7Es5MR+94ik5Tai+xY3auJPK4pqeLibZR5ECHE8WgRT4TVKFoFdbjEU2C2
         SKKLGMWFkufsONPl+PusQX62SgfSPTURlQ8lVrUtNLBzfOp1aaJmyiFf8RC6YyxGHue6
         SCHA==
X-Gm-Message-State: AOAM530vhFo4sJCl/lV8+rOBzKMaFQjIns2+RcMG1IRX2IOkaBd71SQt
        gkby7WDzl8Gt0Rs1mT1rvVhT3ot4iYY=
X-Google-Smtp-Source: ABdhPJxQ5znL4ePSkj0TQIm47bGpzql7GgbKXDlhmL2N6c+RQL0n2opxiCroOsvYIFYghBxYPi7wYg==
X-Received: by 2002:adf:f612:: with SMTP id t18mr12310163wrp.16.1632497955305;
        Fri, 24 Sep 2021 08:39:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t23sm8892890wrb.71.2021.09.24.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 08:39:14 -0700 (PDT)
Message-Id: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 15:39:01 +0000
Subject: [PATCH v4 00/13] Sparse-checkout: modify 'git add', 'git rm', and 'git mv' behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/mergies-with-sparse-index.

As requested, this series looks to update the behavior of git add, git rm,
and git mv when they attempt to modify paths outside of the sparse-checkout
cone. In particular, this care is expanded to not just cache entries with
the SKIP_WORKTREE bit, but also paths that do not match the sparse-checkout
definition.

This means that commands that worked before this series can now fail. In
particular, if 'git merge' results in a conflict outside of the
sparse-checkout cone, then 'git add ' will now fail.

In order to allow users to circumvent these protections, a new '--sparse'
option is added that ignores the sparse-checkout patterns and the
SKIP_WORKTREE bit. The message for advice.updateSparsePath is adjusted to
assist with discovery of this option.

There is a subtle issue with git mv in that it does not check the index
until it discovers a directory and then uses the index to find the contained
entries. This means that in non-cone-mode patterns, a pattern such as
"sub/dir" will not match the path "sub" and this can cause an issue.

In order to allow for checking arbitrary paths against the sparse-checkout
patterns, some changes to the underlying pattern matching code is required.
It turns out that there are some bugs in the methods as advertised, but
these bugs were never discovered because of the way methods like
unpack_trees() will check a directory for a pattern match before checking
its contained paths. Our new "check patterns on-demand" approach pokes holes
in that approach, specifically with patterns that match entire directories.


Updates in v4
=============

 * Instead of using 'git status' and 'grep' to detect staged changes, we use
   'git diff --staged'. t1092 uses an additional --diff-filter because it
   tests with merge conflicts, so it needs this extra flag.

 * Patches 3 and 4 are merged into the new patch 3 to avoid temporarily
   having a poorly named method.


Updates in v3
=============

 * Fixed an incorrectly-squashed commit. Spread out some changes in a better
   way. For example, I don't add --sparse to tests before introducing the
   option.

 * Use a NULL struct strbuf pointer to indicate an uninitialized value
   instead of relying on an internal member.

 * Use grep over test_i18ngrep.

 * Fixed line wrapping for error messages.

 * Use strbuf_setlen() over modifying the len member manually.


Updates in v2
=============

 * I got no complaints about these restrictions, so this is now a full
   series, not RFC.

 * Thanks to Matheus, several holes are filled with extra testing and
   bugfixes.

 * New patches add --chmod and --renormalize improvements. These are added
   after the --sparse option to make them be one change each.

Thanks, -Stolee

Derrick Stolee (13):
  t3705: test that 'sparse_entry' is unstaged
  t1092: behavior for adding sparse files
  dir: select directories correctly
  dir: fix pattern matching on dirs
  add: fail when adding an untracked sparse file
  add: skip tracked paths outside sparse-checkout cone
  add: implement the --sparse option
  add: update --chmod to skip sparse paths
  add: update --renormalize to skip sparse paths
  rm: add --sparse option
  rm: skip sparse paths with missing SKIP_WORKTREE
  mv: refuse to move sparse paths
  advice: update message to suggest '--sparse'

 Documentation/git-add.txt                |   9 +-
 Documentation/git-rm.txt                 |   6 +
 advice.c                                 |  11 +-
 builtin/add.c                            |  32 +++-
 builtin/mv.c                             |  52 +++++--
 builtin/rm.c                             |  10 +-
 dir.c                                    |  56 ++++++-
 pathspec.c                               |   5 +-
 t/t1091-sparse-checkout-builtin.sh       |   4 +-
 t/t1092-sparse-checkout-compatibility.sh |  75 +++++++--
 t/t3602-rm-sparse-checkout.sh            |  40 ++++-
 t/t3705-add-sparse-checkout.sh           |  68 +++++++-
 t/t7002-mv-sparse-checkout.sh            | 189 +++++++++++++++++++++++
 13 files changed, 505 insertions(+), 52 deletions(-)
 create mode 100755 t/t7002-mv-sparse-checkout.sh


base-commit: 516680ba7704c473bb21628aa19cabbd787df4db
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1018%2Fderrickstolee%2Fsparse-index%2Fadd-rm-mv-behavior-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1018/derrickstolee/sparse-index/add-rm-mv-behavior-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1018

Range-diff vs v3:

  1:  ea940f10a7c !  1:  642b05fc020 t3705: test that 'sparse_entry' is unstaged
     @@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
       }
       
      +test_sparse_entry_unstaged () {
     -+	git status --porcelain >actual &&
     -+	! grep "^[MDARCU][M ] sparse_entry\$" actual
     ++	git diff --staged -- sparse_entry >diff &&
     ++	test_must_be_empty diff
      +}
      +
       test_expect_success 'setup' "
  2:  c7dedb41291 !  2:  58389edc76c t1092: behavior for adding sparse files
     @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
      +	file=$1 &&
      +	for repo in sparse-checkout sparse-index
      +	do
     -+		git -C $repo status --porcelain >$repo-out &&
     -+		! grep "^A  $file\$" $repo-out &&
     -+		! grep "^M  $file\$" $repo-out || return 1
     ++		# Skip "unmerged" paths
     ++		git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&
     ++		test_must_be_empty diff || return 1
      +	done
      +}
      +
  3:  b1f6468f9cd <  -:  ----------- dir: extract directory-matching logic
  4:  0252c7ee15c !  3:  2ebaf8e68c2 dir: select directories correctly
     @@ Commit message
          contained files. However, other commands will start matching individual
          files against pattern lists without that recursive approach.
      
     -    We modify path_matches_dir_pattern() to take a strbuf pointer
     -    'path_parent' that is used to store the parent directory of 'pathname'
     -    between multiple pattern matching tests. This is loaded lazily, only on
     -    the first pattern it finds that has the PATTERN_FLAG_MUSTBEDIR flag.
     +    The last_matching_pattern_from_list() logic performs some checks on the
     +    filetype of a path within the index when the PATTERN_FLAG_MUSTBEDIR flag
     +    is set. This works great when setting SKIP_WORKTREE bits within
     +    unpack_trees(), but doesn't work well when passing an arbitrary path
     +    such as a file within a matching directory.
     +
     +    We extract the logic around determining the file type, but attempt to
     +    avoid checking the filesystem if the parent directory already matches
     +    the sparse-checkout patterns. The new path_matches_dir_pattern() method
     +    includes a 'path_parent' parameter that is used to store the parent
     +    directory of 'pathname' between multiple pattern matching tests. This is
     +    loaded lazily, only on the first pattern it finds that has the
     +    PATTERN_FLAG_MUSTBEDIR flag.
      
          If we find that a path has a parent directory, we start by checking to
          see if that parent directory matches the pattern. If so, then we do not
     @@ Commit message
      
       ## dir.c ##
      @@ dir.c: int match_pathname(const char *pathname, int pathlen,
     + 				 WM_PATHNAME) == 0;
     + }
       
     - static int path_matches_dir_pattern(const char *pathname,
     - 				    int pathlen,
     ++static int path_matches_dir_pattern(const char *pathname,
     ++				    int pathlen,
      +				    struct strbuf **path_parent,
     - 				    int *dtype,
     - 				    struct path_pattern *pattern,
     - 				    struct index_state *istate)
     - {
     ++				    int *dtype,
     ++				    struct path_pattern *pattern,
     ++				    struct index_state *istate)
     ++{
      +	if (!*path_parent) {
      +		char *slash;
      +		CALLOC_ARRAY(*path_parent, 1);
     @@ dir.c: int match_pathname(const char *pathname, int pathlen,
      +			   pattern->patternlen, pattern->flags))
      +		return 1;
      +
     - 	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
     - 	if (*dtype != DT_DIR)
     - 		return 0;
     ++	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
     ++	if (*dtype != DT_DIR)
     ++		return 0;
     ++
     ++	return 1;
     ++}
     ++
     + /*
     +  * Scan the given exclude list in reverse to see whether pathname
     +  * should be ignored.  The first match (i.e. the last on the list), if
      @@ dir.c: static struct path_pattern *last_matching_pattern_from_list(const char *pathname
       {
       	struct path_pattern *res = NULL; /* undecided */
     @@ dir.c: static struct path_pattern *last_matching_pattern_from_list(const char *p
       		const char *exclude = pattern->pattern;
       		int prefix = pattern->nowildcardlen;
       
     --		if ((pattern->flags & PATTERN_FLAG_MUSTBEDIR) &&
     --		    !path_matches_dir_pattern(pathname, pathlen,
     +-		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
     +-			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
     +-			if (*dtype != DT_DIR)
     +-				continue;
     +-		}
      +		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR &&
      +		    !path_matches_dir_pattern(pathname, pathlen, &path_parent,
     - 					      dtype, pattern, istate))
     - 			continue;
     ++					      dtype, pattern, istate))
     ++			continue;
       
     + 		if (pattern->flags & PATTERN_FLAG_NODIR) {
     + 			if (match_basename(basename,
      @@ dir.c: static struct path_pattern *last_matching_pattern_from_list(const char *pathname
       			break;
       		}
  5:  c6d17df5e5d =  4:  24bffdab139 dir: fix pattern matching on dirs
  6:  3dd1d6c228c =  5:  e3a749e3182 add: fail when adding an untracked sparse file
  7:  15039e031e5 =  6:  2c5c834bc9f add: skip tracked paths outside sparse-checkout cone
  8:  6014ac8ab9e =  7:  430ab44e4f1 add: implement the --sparse option
  9:  2bd3448be5f =  8:  4f7b5cdfa36 add: update --chmod to skip sparse paths
 10:  131beda1bc3 =  9:  30ec6096939 add: update --renormalize to skip sparse paths
 11:  837a9314893 = 10:  99d50921ef4 rm: add --sparse option
 12:  cc25ce17162 = 11:  47a1444115b rm: skip sparse paths with missing SKIP_WORKTREE
 13:  63a9cd80ade = 12:  28e703d80d3 mv: refuse to move sparse paths
 14:  79a3518dc15 = 13:  9fbc88ee0da advice: update message to suggest '--sparse'

-- 
gitgitgadget
