Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918F16D9BF
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184920; cv=none; b=Csl/HMrZeziUYhpqxl6dRIDcVbTZ67QZ+prnhYOKSOaWQonHADbhaNoNWNGegEUBM8SJNX/zM7BsyaT9osjIIPeOiZE6HmI12mhieqAoxo5FHGUl0jTkMFP8ti+C6gt/rW56VFbiWMt7TOz5E5wofWPRt2Lr4YD7XQ65xcSNweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184920; c=relaxed/simple;
	bh=pUH+7yYvAXYWr7OFhMScH6p1fZQX7l8vLpRHSRy0sYI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zdei1Ayj1qdn0U9Hfg9Ax56f+zkIhrXvKjnBeV+HXx0iHwSK0dYvjKTLUCGgtyCN7jBEcNtBYC5hNhskyi+jpBu1+zUAHwJB5/0h0HGPjt18Ik7/7+OmG3zIxR3cyxGV3R1D8n3RlG6J+l34IaP2Qggp9sQZgPuLbQ2cfONbLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFNv4ch5; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNv4ch5"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-254c56efe06so1533776fac.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718184917; x=1718789717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9AUjBlv3RADn+ktdGy+gWePD2eNc8o0d6J7BUT33jI=;
        b=PFNv4ch5Ofj3FCX0ep3vOhr6DAtppu68IHJBOIsTp7x9wQvFuDx6Ce9oKwOtQJHYQ4
         x4t4IfRtszWjlWc8U3Dhp44unrUmOVnXzrpPnYQzQZuZzQGWGVXsS7PojN71LjQKNHBk
         Mjz3ggEVIARpuYldoLP7Bk3E5uOLEGpZ45ZncZ998RS1WUU1koub+GDyrpVLLxdheR9t
         Fd2CdG2zGe24FNAsDRUTjHrSs3y1LEHc/O53eCyHGvuundBZYex9emSTLxGlRxv+RIb0
         4AawpoCYs9rJwVRKdcRZGfFm0snKZBchit27OscBGIwFYSnTDu4Euz4pNW0a9cppIBKb
         18Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184917; x=1718789717;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9AUjBlv3RADn+ktdGy+gWePD2eNc8o0d6J7BUT33jI=;
        b=w13S4l+qvzM0NUk7VLyVO5amsdQ+C41PLHv8WfS5i0JlwqmzfLk6Ar290lZNkkkkH3
         5pefeyP5RxAtuTdPV9NRtzYNwMLiVboudVTK0GSxvmMfQO52ocCqXIA5U8xKWuLQHe30
         n6AJPcg7xMEZD/5sDc7FoR5Rlt+mM006x96u+/d86hoc/hTWbdlpe2qUYUyB2Zs3amlo
         3sa5JK0VWXnJ7c70XN7mbvZVc4o/J57pza0FHTOinRNxE/Cw3EKy47njBhAwuKWOKe3t
         oBoZM1iSm3RH75oR/sOrQ67oRCPBbu7S85BpWnABbCSKe4FE5ykhDJRsk/QYN27pdAPu
         Md5g==
X-Forwarded-Encrypted: i=1; AJvYcCXwyrWhcbMUlxHduxLKm63CvYbmZi+wqU8YCGQJiE3B0ok5Rml+yXVOY1d/4NjRWKBUSlP6g9a5xdwSaA75PA6H12/y
X-Gm-Message-State: AOJu0YyLzmiIb/KoYg4cji2Xz2wOO4dX5+DaE85G/Yx92d1WEmPan85e
	txIOqSJwzRPrfLuWXhTD9x+ooXvhap98jK+lpkAEjcQ5BUD0sK7QRn4Z4D5vSculcBBzyFxyvVl
	QMf98bBMNx9wEDDGvBobcNR2Hvd8=
X-Google-Smtp-Source: AGHT+IF2W5aPCmTCXgz4JCxwzcrAR5A2tKwQlXCuEluQIbWsO3EymYsXbqaOCmnPUlryO56HGD9489wQuwhg94Cq7a4=
X-Received: by 2002:a05:6871:b29:b0:254:9433:c88 with SMTP id
 586e51a60fabf-25514d9663bmr1399100fac.27.1718184917066; Wed, 12 Jun 2024
 02:35:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 11:35:16 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im> <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 11:35:16 +0200
Message-ID: <CAOLa=ZRBrR5X1bQFAEqM3Ovx5G=J9aqdyD2XKrGT9s6j1jEnnQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] Memory leak fixes (pt.2)
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a3ff70061aae19f4"

--000000000000a3ff70061aae19f4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that fixes various memory
> leaks in our codebase.
>
> Changes compared to v1:
>
>   - Fix various typos in commit messages.
>
>   - Refactor patch 20 such that we do not have both `ret` and `res` as
>     local variables, which was confusing.
>
> Thanks!
>

The changes with the range-diff looks good to me, Thanks!

> Patrick
>
> Patrick Steinhardt (29):
>   revision: fix memory leak when reversing revisions
>   parse-options: fix leaks for users of OPT_FILENAME
>   notes-utils: free note trees when releasing copied notes
>   bundle: plug leaks in `create_bundle()`
>   biultin/rev-parse: fix memory leaks in `--parseopt` mode
>   merge-recursive: fix leaking rename conflict info
>   revision: fix leaking display notes
>   notes: fix memory leak when pruning notes
>   builtin/rev-list: fix leaking bitmap index when calculating disk usage
>   object-name: free leaking object contexts
>   builtin/difftool: plug memory leaks in `run_dir_diff()`
>   builtin/merge-recursive: fix leaking object ID bases
>   merge-recursive: fix memory leak when finalizing merge
>   builtin/log: fix leaking commit list in git-cherry(1)
>   revision: free diff options
>   builtin/stash: fix leak in `show_stash()`
>   rerere: fix various trivial leaks
>   config: fix leaking "core.notesref" variable
>   commit: fix leaking parents when calling `commit_tree_extended()`
>   sequencer: fix leaking string buffer in `commit_staged_changes()`
>   apply: fix leaking string in `match_fragment()`
>   builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
>   sequencer: fix memory leaks in `make_script_with_merges()`
>   builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
>   merge: fix leaking merge bases
>   line-range: plug leaking find functions
>   blame: fix leaking data for blame scoreboards
>   builtin/blame: fix leaking prefixed paths
>   builtin/blame: fix leaking ignore revs files
>
>  apply.c                                   |  88 ++++++++++------
>  apply.h                                   |   2 +-
>  blame.c                                   |   4 +
>  builtin/am.c                              |   7 +-
>  builtin/archive.c                         |   7 +-
>  builtin/blame.c                           |   8 +-
>  builtin/cat-file.c                        |  17 ++--
>  builtin/clone.c                           |   3 +-
>  builtin/commit-tree.c                     |  11 +-
>  builtin/commit.c                          |  10 +-
>  builtin/difftool.c                        |   3 +
>  builtin/fmt-merge-msg.c                   |   4 +-
>  builtin/grep.c                            |   4 +-
>  builtin/log.c                             |  16 +--
>  builtin/ls-tree.c                         |   3 +-
>  builtin/merge-recursive.c                 |   6 +-
>  builtin/merge-tree.c                      |   1 +
>  builtin/merge.c                           |  18 +++-
>  builtin/multi-pack-index.c                |  13 ++-
>  builtin/replay.c                          |  14 ++-
>  builtin/rev-list.c                        |   2 +
>  builtin/rev-parse.c                       |  55 +++++-----
>  builtin/shortlog.c                        |   5 +-
>  builtin/sparse-checkout.c                 |   1 +
>  builtin/stash.c                           |  23 +++--
>  bundle.c                                  |  29 ++++--
>  commit.c                                  |  28 +++---
>  commit.h                                  |  12 +--
>  config.c                                  |   1 +
>  diff-lib.c                                |   2 +
>  diff.c                                    |   8 +-
>  help.c                                    |  12 +--
>  help.h                                    |   2 +
>  line-range.c                              |   2 +
>  list-objects-filter.c                     |   2 +
>  log-tree.c                                |   1 +
>  merge-ort-wrappers.c                      |   2 +-
>  merge-ort-wrappers.h                      |   2 +-
>  merge-ort.c                               |  12 ++-
>  merge-ort.h                               |   2 +-
>  merge-recursive.c                         |  68 ++++++++-----
>  merge-recursive.h                         |   4 +-
>  notes-merge.c                             |   1 +
>  notes-utils.c                             |   9 +-
>  notes-utils.h                             |   2 +-
>  notes.c                                   |  21 ++--
>  notes.h                                   |   5 +
>  object-name.c                             |  40 ++++++--
>  object-name.h                             |   2 +
>  rerere.c                                  |   3 +
>  revision.c                                |  59 +++++++----
>  sequencer.c                               | 116 +++++++++++++++-------
>  t/helper/test-parse-options.c             |   1 +
>  t/t1004-read-tree-m-u-wf.sh               |   1 +
>  t/t1015-read-index-unmerged.sh            |   2 +
>  t/t1021-rerere-in-workdir.sh              |   1 +
>  t/t1512-rev-parse-disambiguation.sh       |   1 +
>  t/t2500-untracked-overwriting.sh          |   1 +
>  t/t3301-notes.sh                          |   1 +
>  t/t3306-notes-prune.sh                    |   1 +
>  t/t3308-notes-merge.sh                    |   1 +
>  t/t3309-notes-merge-auto-resolve.sh       |   1 +
>  t/t3400-rebase.sh                         |   1 +
>  t/t3401-rebase-and-am-rename.sh           |   1 +
>  t/t3403-rebase-skip.sh                    |   1 +
>  t/t3406-rebase-message.sh                 |   1 +
>  t/t3407-rebase-abort.sh                   |   1 +
>  t/t3417-rebase-whitespace-fix.sh          |   1 +
>  t/t3418-rebase-continue.sh                |   1 +
>  t/t3420-rebase-autostash.sh               |   1 +
>  t/t3421-rebase-topology-linear.sh         |   2 +
>  t/t3424-rebase-empty.sh                   |   1 +
>  t/t3428-rebase-signoff.sh                 |   1 +
>  t/t3430-rebase-merges.sh                  |   1 +
>  t/t3434-rebase-i18n.sh                    |   1 +
>  t/t3500-cherry.sh                         |   1 +
>  t/t3504-cherry-pick-rerere.sh             |   1 +
>  t/t3505-cherry-pick-empty.sh              |   1 +
>  t/t3508-cherry-pick-many-commits.sh       |   1 +
>  t/t3509-cherry-pick-merge-df.sh           |   1 +
>  t/t3907-stash-show-config.sh              |   1 +
>  t/t4061-diff-indent.sh                    |   1 +
>  t/t4131-apply-fake-ancestor.sh            |   1 +
>  t/t4151-am-abort.sh                       |   1 +
>  t/t4153-am-resume-override-opts.sh        |   1 +
>  t/t4208-log-magic-pathspec.sh             |   1 +
>  t/t4253-am-keep-cr-dos.sh                 |   1 +
>  t/t4255-am-submodule.sh                   |   1 +
>  t/t5150-request-pull.sh                   |   1 +
>  t/t5300-pack-object.sh                    |   4 +-
>  t/t5305-include-tag.sh                    |   1 +
>  t/t5407-post-rewrite-hook.sh              |   1 +
>  t/t5605-clone-local.sh                    |   1 +
>  t/t5607-clone-bundle.sh                   |   1 +
>  t/t5612-clone-refspec.sh                  |   1 +
>  t/t6000-rev-list-misc.sh                  |   1 +
>  t/t6001-rev-list-graft.sh                 |   1 +
>  t/t6013-rev-list-reverse-parents.sh       |   1 +
>  t/t6017-rev-list-stdin.sh                 |   1 +
>  t/t6020-bundle-misc.sh                    |   1 +
>  t/t6115-rev-list-du.sh                    |   2 +
>  t/t6130-pathspec-noglob.sh                |   2 +
>  t/t6402-merge-rename.sh                   |   1 +
>  t/t6427-diff3-conflict-markers.sh         |   1 +
>  t/t6430-merge-recursive.sh                |   1 +
>  t/t6432-merge-recursive-space-options.sh  |   1 +
>  t/t6434-merge-recursive-rename-options.sh |   1 +
>  t/t6436-merge-overwrite.sh                |   1 +
>  t/t7006-pager.sh                          |   1 +
>  t/t7010-setup.sh                          |   1 +
>  t/t7012-skip-worktree-writing.sh          |   1 +
>  t/t7201-co.sh                             |   1 +
>  t/t7501-commit-basic-functionality.sh     |   1 +
>  t/t7505-prepare-commit-msg-hook.sh        |   1 +
>  t/t7512-status-help.sh                    |   1 +
>  t/t7600-merge.sh                          |   1 +
>  t/t7606-merge-custom.sh                   |   1 +
>  t/t7611-merge-abort.sh                    |   1 +
>  t/t8002-blame.sh                          |   1 +
>  t/t8003-blame-corner-cases.sh             |   1 +
>  t/t8004-blame-with-conflicts.sh           |   1 +
>  t/t8006-blame-textconv.sh                 |   2 +
>  t/t8008-blame-formats.sh                  |   2 +
>  t/t8009-blame-vs-topicbranches.sh         |   2 +
>  t/t8011-blame-split-file.sh               |   2 +
>  t/t8012-blame-colors.sh                   |   1 +
>  t/t8013-blame-ignore-revs.sh              |   2 +
>  t/t8014-blame-ignore-fuzzy.sh             |   2 +
>  t/t9500-gitweb-standalone-no-errors.sh    |   1 +
>  t/t9502-gitweb-standalone-parse-output.sh |   1 +
>  130 files changed, 591 insertions(+), 272 deletions(-)
>
> Range-diff against v1:
>  1:  a88a6fa266 =  1:  f602bb5444 revision: fix memory leak when reversing revisions
>  2:  ecabbb74e1 =  2:  84f2f56b71 parse-options: fix leaks for users of OPT_FILENAME
>  3:  17a8f53275 !  3:  c5f49bf930 notes-utils: free note trees when releasing copied notes
>     @@ Metadata
>       ## Commit message ##
>          notes-utils: free note trees when releasing copied notes
>
>     -    While we clear most of the members of `struct notet_rewrite_cfg` in
>     +    While we clear most of the members of `struct notes_rewrite_cfg` in
>          `finish_copy_notes_for_rewrite()`, we do not clear the notes tree. Fix
>          this to plug this memory leak.
>
>  4:  0c8c97cded =  4:  5a1eae2cc9 bundle: plug leaks in `create_bundle()`
>  5:  620814fb99 =  5:  91eefcf64a biultin/rev-parse: fix memory leaks in `--parseopt` mode
>  6:  0052d60ee8 !  6:  f16c29a20a merge-recursive: fix leaging rename conflict info
>     @@ Metadata
>      Author: Patrick Steinhardt <ps@pks.im>
>
>       ## Commit message ##
>     -    merge-recursive: fix leaging rename conflict info
>     +    merge-recursive: fix leaking rename conflict info
>
>          When computing rename conflicts in our recursive merge algorithm we set
>          up `struct rename_conflict_info`s to track that information. We never
>          free those data structures though and thus leak memory.
>
>          We need to be a bit more careful here though because the same rename
>     -    conflict info can be assigned to multiple structures. Accomodate for
>     +    conflict info can be assigned to multiple structures. Accommodate for
>          this by introducing a `rename_conflict_info_owned` bit that we can use
>          to steer whether or not the rename conflict info shall be free'd.
>
>  7:  8c55370b8e =  7:  b9c3a34ae1 revision: fix leaking display notes
>  8:  17671dc9cf =  8:  3ea5e5c6bd notes: fix memory leak when pruning notes
>  9:  5e01c39e35 =  9:  a0242359b7 builtin/rev-list: fix leaking bitmap index when calculating disk usage
> 10:  2ac24bf942 = 10:  bdb7389328 object-name: free leaking object contexts
> 11:  8349f6acbd = 11:  e6ff9a3f1c builtin/difftool: plug memory leaks in `run_dir_diff()`
> 12:  5d9fb78e63 = 12:  fb30a254ab builtin/merge-recursive: fix leaking object ID bases
> 13:  930de11911 = 13:  b6540e4aff merge-recursive: fix memory leak when finalizing merge
> 14:  3e3243f884 = 14:  7cb4f75178 builtin/log: fix leaking commit list in git-cherry(1)
> 15:  a754800fd1 = 15:  99f4f3d341 revision: free diff options
> 16:  8bde010d1d = 16:  707d798f78 builtin/stash: fix leak in `show_stash()`
> 17:  cadeb09b95 = 17:  7d73c50872 rerere: fix various trivial leaks
> 18:  cff6303ce1 = 18:  1700ec8d21 config: fix leaking "core.notesref" variable
> 19:  8ada8864d8 = 19:  c1a1eb34ab commit: fix leaking parents when calling `commit_tree_extended()`
> 20:  48bcd0ac80 ! 20:  144eb23617 sequencer: fix leaking string buffer in `commit_staged_changes()`
>     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>       			/*
>       			 * If a fixup/squash in a fixup/squash chain failed, the
>      @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>     + 				 * We need to update the squash message to skip
>     + 				 * the latest commit message.
>     + 				 */
>     +-				int res = 0;
>     + 				struct commit *commit;
>     + 				const char *msg;
>       				const char *path = rebase_path_squash_msg();
>       				const char *encoding = get_commit_output_encoding();
>
>     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
>
>       				p = repo_logmsg_reencode(r, commit, NULL, encoding);
>       				if (!p)  {
>     -@@ sequencer.c: static int commit_staged_changes(struct repository *r,
>     +-					res = error(_("could not parse commit %s"),
>     ++					ret = error(_("could not parse commit %s"),
>     + 						    oid_to_hex(&commit->object.oid));
>     + 					goto unuse_commit_buffer;
>     + 				}
>     + 				find_commit_subject(p, &msg);
>     + 				if (write_message(msg, strlen(msg), path, 0)) {
>     +-					res = error(_("could not write file: "
>     ++					ret = error(_("could not write file: "
>     + 						       "'%s'"), path);
>     + 					goto unuse_commit_buffer;
>       				}
>     ++
>     ++				ret = 0;
>     ++
>       			unuse_commit_buffer:
>       				repo_unuse_commit_buffer(r, commit, p);
>      -				if (res)
>      -					return res;
>     -+				if (res) {
>     -+					ret = res;
>     ++				if (ret)
>      +					goto out;
>     -+				}
>       			}
>       		}
>
> 21:  ebed18717f = 21:  8e1cf8a18b apply: fix leaking string in `match_fragment()`
> 22:  4f4ae5ea96 = 22:  8090891bd0 builtin/clone: plug leaking HEAD ref in `wanted_peer_refs()`
> 23:  713531c6f1 = 23:  1cdd988c45 sequencer: fix memory leaks in `make_script_with_merges()`
> 24:  eeef280dd5 = 24:  be9bccc853 builtin/merge: fix leaking `struct cmdnames` in `get_strategy()`
> 25:  5441f1e2ef = 25:  6f6456494c merge: fix leaking merge bases
> 26:  ba9c2b4ea7 = 26:  67f8637dc6 line-range: plug leaking find functions
> 27:  5f2b0adc56 = 27:  bd6db56a3f blame: fix leaking data for blame scoreboards
> 28:  7ee8734437 = 28:  c1291025fa builtin/blame: fix leaking prefixed paths
> 29:  5b5fdfc6cb = 29:  5d7007e724 builtin/blame: fix leaking ignore revs files
> --
> 2.45.2.436.gcd77e87115.dirty

--000000000000a3ff70061aae19f4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5842715e9147619_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acGE5SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnpNQy8wVUZyUXhWOC9XZ2hYQkdtSEt0Vmx4NElkdgp0Q2FtcHpJTUFT
ZmN3UjdYZFMyQUc3VStJYU0wdXA1NnZqYXJpODZHVVFYYWtLNlQrZllYa1ZLYXhFcSswVHhZCnQ2
R3lpZlJ0TUtQUkZ0cEcxZjN5b3JXOGZ3RjNTbHNQYU95ZjQyQktQUThyRGNGMEM2VGJIck94WTJH
U3I2OE8KcGJ5YmJyNUFBM2RNaXlHeFFWb1RhSXY5TkZDQnpvVy9vUEw1VUdSNk5UUXh4Q2IxcmhT
aFhJQUNXY2dkcmdoMgpxZXJMUTdiUFVySTdab3BnUllPUlE5c1hmWXBLRS9MVk1aaitpQXJGREVn
ZEwvRGJSeUlXeUkyVHMwUFpkQUZwCmQ1M2p6cjNRcmRPZi9BR3FyRTdpRU5MVkxVMTAvdTc5dVJo
OE05MFdxS1BEWWd4MnVLNjFpL3lvQ0ZuY3lBUzEKcjl4SjQ1V1N6ZXd4c1ByZS9Ea0ZobDdROXV6
NmxoQ3NEWEZPNzhET1NMQ0Y0NnpnUXNTM0VnWmlmek9VUGoveAo1VzhWdjdGcGlDUEdpb2RQQXU5
aHQ1dHdPSGdkTUVXRWRFRXNHNTlPVHhTWWI1S3RsSzNuSjFlbXo5VzJjd0RzCktQNnBDT293QVlM
SlF3LzFidkltL1BXMk1DSVFLWE9VcU10aFJkWT0KPTV2ZmYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a3ff70061aae19f4--
