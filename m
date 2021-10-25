Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76372C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F74B60FE8
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 12:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJYMQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJYMQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 08:16:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FDDC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:13:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y22-20020a1c7d16000000b003231ea3d705so12867690wmc.4
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=l4XtbGxSEVGi17FX+rD6W7dKfdfKDcKhotwe73S7m0A=;
        b=lR0FTpge2e7XxC/BkAcAc+FxkTurwTo/afrF5jtW9zc62l7w5f9y4I/glfWyMbPOk1
         OWIDg+d6nIMH6VnfAmCGlQZUmuGBRlQR1lwBPFuC8f+tMIijolucncgcCcBxCTCMAqNm
         zAo2gjoZfVzd7/EmeZXkAwa/n8Nz5GAUQkiOCCzOE9Scrj7+3Jm9Aogko/OkNiAUiL2q
         3FNc4UrtAqRAKTbPIfRZc8jhWIaYkkQQlfrbAWcJgjl0RD2p+AK5DdB3KsK8AB5Rkall
         ybtaWdV2hLLYdVC4UW0uyTWOVnrxkGPCTR1/Agb0cebK0F1Q8OnomNbin2d35zyeGY3A
         W9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l4XtbGxSEVGi17FX+rD6W7dKfdfKDcKhotwe73S7m0A=;
        b=xhOwOlJ74Xzj215B3R1xcxUHhp0bfoMlyLtDKxRlLwF56EQJyqSkEI0s004oOOChmN
         dD+0V4k5AKNyR3Chkj70eQQcJKeH3ji+PzBhCcQcgu0qyGAwZVJpgfF1+1DbFXjYrShL
         ZnzIx+ONN0lD4UZ94+Y2COE81n7NPJFZlrLYbh+UA1MNc8/R0B+6lL3w57fbCPrjNVfL
         EcaEhnfFgW1CUjabqrkivwKW2xGfgcja60psP6zekPGrtoVpy7aDhZwuj+shEa03g39B
         1l98zFvhbUPp7BAh+SfGkr2aL+JnVinZ3B8JonTRu8py70Gb4rWTSwB+qfjmEOfoUaG2
         tyNA==
X-Gm-Message-State: AOAM531pN/pRgOyamSk3K9I0yeIUX+/IeZ7gM8H+w5D639v5ByeN1B3/
        Kwk9i5hOJkf1xB4zYakvlUL5THx/Seg=
X-Google-Smtp-Source: ABdhPJwFe6RlZ5zdvG1R35aUK+GNM9CqveCN8HEBZlL3sd52P7m17rYZ97WUyN0Lhrp5wlnX5Fw+4Q==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr49525050wmc.126.1635164027898;
        Mon, 25 Oct 2021 05:13:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m35sm2057859wms.2.2021.10.25.05.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:13:47 -0700 (PDT)
Message-Id: <pull.1062.git.1635164026698.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Oct 2021 12:13:46 +0000
Subject: [PATCH] amend error message violations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Issue no #635 in the gitgitgadget/git repo has a brief description
about the violation of error message style convention. These
violations are - 1) Do not end error messages with a full stop. 2) Do
not capitalize ("unable to open %s", not "Unable to open %s") 3) Say
what the error is first ("cannot open %s", not "%s: cannot open")

This commit is the first commit to amend those error strings. It
covers files in the root directory that start with letter 'a'. This is
a small patch to start as suggested. There will be more patches to
cover all files and directories.

One thing to note that I didn't change any .po file as there is a
doubt whether those are good to change or not.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    Amend error messages that violate git coding style convention
    
    There exists a lot of error messages that do not follow the git standard
    style convention. Some of these end with a full stop, some start with
    capital letter, others do not describe the problem first ( for example,
    "%s: not a valid attribute name" should be "not a valid attribute name:
    %s" as described in the 3rd point of error message style convention -
    "Say what the error is first"). Issue no. 635 of gitgitgadget/git is
    created particularly to address it. The current commit only covers those
    .c files that are in the root directory and start with letter 'a'.
    However there will be more patches to cover all files (as suggested by
    the reviewer). I didn't change any .po files for now. But will do it if
    reviewers tell me to do so.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1062%2FAbhra303%2Ferror_msg-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1062/Abhra303/error_msg-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1062

 abspath.c         |  8 ++++----
 add-interactive.c |  2 +-
 add-patch.c       | 30 +++++++++++++++---------------
 advice.c          | 18 +++++++++---------
 apply.c           | 26 +++++++++++++-------------
 archive.c         | 16 ++++++++--------
 attr.c            |  2 +-
 t/t5520-pull.sh   |  4 ++--
 8 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/abspath.c b/abspath.c
index 39e06b58486..af6bbdb00dd 100644
--- a/abspath.c
+++ b/abspath.c
@@ -86,7 +86,7 @@ static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
 
 	if (!*path) {
 		if (flags & REALPATH_DIE_ON_ERROR)
-			die("The empty string is not a valid path");
+			die("the empty string is not a valid path");
 		else
 			goto error_out;
 	}
@@ -128,7 +128,7 @@ static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
 			if (errno != ENOENT ||
 			   (!(flags & REALPATH_MANY_MISSING) && remaining.len)) {
 				if (flags & REALPATH_DIE_ON_ERROR)
-					die_errno("Invalid path '%s'",
+					die_errno("invalid path '%s'",
 						  resolved->buf);
 				else
 					goto error_out;
@@ -141,7 +141,7 @@ static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
 				errno = ELOOP;
 
 				if (flags & REALPATH_DIE_ON_ERROR)
-					die("More than %d nested symlinks "
+					die("more than %d nested symlinks "
 					    "on path '%s'", MAXSYMLINKS, path);
 				else
 					goto error_out;
@@ -151,7 +151,7 @@ static char *strbuf_realpath_1(struct strbuf *resolved, const char *path,
 					      st.st_size);
 			if (len < 0) {
 				if (flags & REALPATH_DIE_ON_ERROR)
-					die_errno("Invalid symlink '%s'",
+					die_errno("invalid symlink '%s'",
 						  resolved->buf);
 				else
 					goto error_out;
diff --git a/add-interactive.c b/add-interactive.c
index 6498ae196f1..130d1e3c8f5 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -776,7 +776,7 @@ static int run_revert(struct add_i_state *s, const struct pathspec *ps,
 	else {
 		tree = parse_tree_indirect(&oid);
 		if (!tree) {
-			res = error(_("Could not parse HEAD^{tree}"));
+			res = error(_("could not parse HEAD^{tree}"));
 			goto finish_revert;
 		}
 		oidcpy(&oid, &tree->object.oid);
diff --git a/add-patch.c b/add-patch.c
index 8c41cdfe39b..a0d74451a06 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1287,7 +1287,7 @@ static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
 	}
 
 	if (!applies_index) {
-		err(s, _("The selected hunks do not apply to the index!"));
+		err(s, _("the selected hunks do not apply to the index!"));
 		if (prompt_yesno(s, _("Apply them to the worktree "
 					  "anyway? ")) > 0) {
 			setup_child_process(s, &apply_worktree,
@@ -1295,7 +1295,7 @@ static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
 			return pipe_command(&apply_worktree, diff->buf,
 					    diff->len, NULL, 0, NULL, 0);
 		}
-		err(s, _("Nothing was applied.\n"));
+		err(s, _("nothing was applied\n"));
 	} else
 		/* As a last resort, show the diff to the user */
 		fwrite(diff->buf, diff->len, 1, stderr);
@@ -1514,28 +1514,28 @@ soft_increment:
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
 				hunk_index--;
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("no previous hunk"));
 		} else if (s->answer.buf[0] == 'J') {
 			if (permitted & ALLOW_GOTO_NEXT_HUNK)
 				hunk_index++;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("no next hunk"));
 		} else if (s->answer.buf[0] == 'k') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_UNDECIDED_HUNK)
 				hunk_index = undecided_previous;
 			else
-				err(s, _("No previous hunk"));
+				err(s, _("no previous hunk"));
 		} else if (s->answer.buf[0] == 'j') {
 			if (permitted & ALLOW_GOTO_NEXT_UNDECIDED_HUNK)
 				hunk_index = undecided_next;
 			else
-				err(s, _("No next hunk"));
+				err(s, _("no next hunk"));
 		} else if (s->answer.buf[0] == 'g') {
 			char *pend;
 			unsigned long response;
 
 			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
-				err(s, _("No other hunks to goto"));
+				err(s, _("no other hunks to goto"));
 				continue;
 			}
 			strbuf_remove(&s->answer, 0, 1);
@@ -1558,13 +1558,13 @@ soft_increment:
 			strbuf_trim(&s->answer);
 			response = strtoul(s->answer.buf, &pend, 10);
 			if (*pend || pend == s->answer.buf)
-				err(s, _("Invalid number: '%s'"),
+				err(s, _("invalid number: '%s'"),
 				    s->answer.buf);
 			else if (0 < response && response <= file_diff->hunk_nr)
 				hunk_index = response - 1;
 			else
-				err(s, Q_("Sorry, only %d hunk available.",
-					  "Sorry, only %d hunks available.",
+				err(s, Q_("sorry, only %d hunk available",
+					  "sorry, only %d hunks available",
 					  file_diff->hunk_nr),
 				    (int)file_diff->hunk_nr);
 		} else if (s->answer.buf[0] == '/') {
@@ -1572,7 +1572,7 @@ soft_increment:
 			int ret;
 
 			if (!(permitted & ALLOW_SEARCH_AND_GOTO)) {
-				err(s, _("No other hunks to search"));
+				err(s, _("no other hunks to search"));
 				continue;
 			}
 			strbuf_remove(&s->answer, 0, 1);
@@ -1593,7 +1593,7 @@ soft_increment:
 				char errbuf[1024];
 
 				regerror(ret, &regex, errbuf, sizeof(errbuf));
-				err(s, _("Malformed search regexp %s: %s"),
+				err(s, _("malformed search regexp %s: %s"),
 				    s->answer.buf, errbuf);
 				continue;
 			}
@@ -1610,14 +1610,14 @@ soft_increment:
 					i = 0;
 				if (i != hunk_index)
 					continue;
-				err(s, _("No hunk matches the given pattern"));
+				err(s, _("no hunk matches the given pattern"));
 				break;
 			}
 			hunk_index = i;
 		} else if (s->answer.buf[0] == 's') {
 			size_t splittable_into = hunk->splittable_into;
 			if (!(permitted & ALLOW_SPLIT))
-				err(s, _("Sorry, cannot split this hunk"));
+				err(s, _("sorry, cannot split this hunk"));
 			else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk))
 				color_fprintf_ln(stdout, s->s.header_color,
@@ -1625,7 +1625,7 @@ soft_increment:
 						 (int)splittable_into);
 		} else if (s->answer.buf[0] == 'e') {
 			if (!(permitted & ALLOW_EDIT))
-				err(s, _("Sorry, cannot edit this hunk"));
+				err(s, _("sorry, cannot edit this hunk"));
 			else if (edit_hunk_loop(s, file_diff, hunk) >= 0) {
 				hunk->use = USE_HUNK;
 				goto soft_increment;
diff --git a/advice.c b/advice.c
index 1dfc91d1767..b34015b393b 100644
--- a/advice.c
+++ b/advice.c
@@ -175,17 +175,17 @@ void list_config_advices(struct string_list *list, const char *prefix)
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
-		error(_("Cherry-picking is not possible because you have unmerged files."));
+		error(_("cherry-picking is not possible because you have unmerged files"));
 	else if (!strcmp(me, "commit"))
-		error(_("Committing is not possible because you have unmerged files."));
+		error(_("committing is not possible because you have unmerged files"));
 	else if (!strcmp(me, "merge"))
-		error(_("Merging is not possible because you have unmerged files."));
+		error(_("merging is not possible because you have unmerged files"));
 	else if (!strcmp(me, "pull"))
-		error(_("Pulling is not possible because you have unmerged files."));
+		error(_("pulling is not possible because you have unmerged files"));
 	else if (!strcmp(me, "revert"))
-		error(_("Reverting is not possible because you have unmerged files."));
+		error(_("reverting is not possible because you have unmerged files"));
 	else
-		error(_("It is not possible to %s because you have unmerged files."),
+		error(_("it is not possible to %s because you have unmerged files"),
 			me);
 
 	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
@@ -201,15 +201,15 @@ int error_resolve_conflict(const char *me)
 void NORETURN die_resolve_conflict(const char *me)
 {
 	error_resolve_conflict(me);
-	die(_("Exiting because of an unresolved conflict."));
+	die(_("exiting because of an unresolved conflict"));
 }
 
 void NORETURN die_conclude_merge(void)
 {
-	error(_("You have not concluded your merge (MERGE_HEAD exists)."));
+	error(_("you have not concluded your merge (MERGE_HEAD exists)"));
 	if (advice_enabled(ADVICE_RESOLVE_CONFLICT))
 		advise(_("Please, commit your changes before merging."));
-	die(_("Exiting because of unfinished merge."));
+	die(_("exiting because of unfinished merge"));
 }
 
 void NORETURN die_ff_impossible(void)
diff --git a/apply.c b/apply.c
index 43a0aebf4ee..0947839c6cd 100644
--- a/apply.c
+++ b/apply.c
@@ -133,7 +133,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		return error(_("--reject and --3way cannot be used together."));
+		return error(_("--reject and --3way cannot be used together"));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
@@ -3555,7 +3555,7 @@ static int load_current(struct apply_state *state,
 			return -1;
 	}
 	if (verify_index_match(state, ce, &st))
-		return error(_("%s: does not match index"), name);
+		return error(_("does not match index: %s"), name);
 
 	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
 	if (status < 0)
@@ -3590,7 +3590,7 @@ static int try_threeway(struct apply_state *state,
 		write_object_file("", 0, blob_type, &pre_oid);
 	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
 		 read_blob_object(&buf, &pre_oid, patch->old_mode))
-		return error(_("repository lacks the necessary blob to perform 3-way merge."));
+		return error(_("repository lacks the necessary blob to perform 3-way merge"));
 
 	if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
 		fprintf(stderr, _("Performing three-way merge...\n"));
@@ -3721,7 +3721,7 @@ static int check_preimage(struct apply_state *state,
 		if (pos < 0) {
 			if (patch->is_new < 0)
 				goto is_new;
-			return error(_("%s: does not exist in index"), old_name);
+			return error(_("index doesn't contain %s"), old_name);
 		}
 		*ce = state->repo->index->cache[pos];
 		if (stat_ret < 0) {
@@ -3729,7 +3729,7 @@ static int check_preimage(struct apply_state *state,
 				return -1;
 		}
 		if (!state->cached && verify_index_match(state, *ce, st))
-			return error(_("%s: does not match index"), old_name);
+			return error(_("index does not match with %s"), old_name);
 		if (state->cached)
 			st_mode = (*ce)->ce_mode;
 	} else if (stat_ret < 0) {
@@ -3746,7 +3746,7 @@ static int check_preimage(struct apply_state *state,
 	if (!patch->old_mode)
 		patch->old_mode = st_mode;
 	if ((st_mode ^ patch->old_mode) & S_IFMT)
-		return error(_("%s: wrong type"), old_name);
+		return error(_("wrong type: %s"), old_name);
 	if (st_mode != patch->old_mode)
 		warning(_("%s has type %o, expected %o"),
 			old_name, st_mode, patch->old_mode);
@@ -3971,11 +3971,11 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 		case 0:
 			break; /* happy */
 		case EXISTS_IN_INDEX:
-			return error(_("%s: already exists in index"), new_name);
+			return error(_("already exists in index: %s"), new_name);
 		case EXISTS_IN_INDEX_AS_ITA:
-			return error(_("%s: does not match index"), new_name);
+			return error(_("does not match index: %s"), new_name);
 		case EXISTS_IN_WORKTREE:
-			return error(_("%s: already exists in working directory"),
+			return error(_("already exists in working directory: %s"),
 				     new_name);
 		default:
 			return err;
@@ -4024,7 +4024,7 @@ static int check_patch(struct apply_state *state, struct patch *patch)
 			     patch->new_name);
 
 	if (apply_data(state, patch, &st, ce) < 0)
-		return error(_("%s: patch does not apply"), name);
+		return error(_("patch does not apply: %s"), name);
 	patch->rejected = 0;
 	return 0;
 }
@@ -4962,8 +4962,8 @@ int apply_all_patches(struct apply_state *state,
 				squelched);
 		}
 		if (state->ws_error_action == die_on_ws_error) {
-			error(Q_("%d line adds whitespace errors.",
-				 "%d lines add whitespace errors.",
+			error(Q_("%d line adds whitespace errors",
+				 "%d lines add whitespace errors",
 				 state->whitespace_error),
 			      state->whitespace_error);
 			res = -128;
@@ -4986,7 +4986,7 @@ int apply_all_patches(struct apply_state *state,
 	if (state->update_index) {
 		res = write_locked_index(state->repo->index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
-			error(_("Unable to write new index file"));
+			error(_("unable to write new index file"));
 			res = -128;
 			goto end;
 		}
diff --git a/archive.c b/archive.c
index a3bbb091256..dc02bc11dea 100644
--- a/archive.c
+++ b/archive.c
@@ -519,9 +519,9 @@ static int add_file_cb(const struct option *opt, const char *arg, int unset)
 	item->util = info = xmalloc(sizeof(*info));
 	info->base = xstrdup_or_null(base);
 	if (stat(path, &info->stat))
-		die(_("File not found: %s"), path);
+		die(_("file not found: %s"), path);
 	if (!S_ISREG(info->stat.st_mode))
-		die(_("Not a regular file: %s"), path);
+		die(_("not a regular file: %s"), path);
 	return 0;
 }
 
@@ -575,13 +575,13 @@ static int parse_archive_args(int argc, const char **argv,
 	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
 
 	if (remote)
-		die(_("Unexpected option --remote"));
+		die(_("unexpected option --remote"));
 	if (exec)
-		die(_("Option --exec can only be used together with --remote"));
+		die(_("option --exec can only be used together with --remote"));
 	if (output)
-		die(_("Unexpected option --output"));
+		die(_("unexpected option --output"));
 	if (is_remote && args->extra_files.nr)
-		die(_("Options --add-file and --remote cannot be used together"));
+		die(_("options --add-file and --remote cannot be used together"));
 
 	if (!base)
 		base = "";
@@ -603,7 +603,7 @@ static int parse_archive_args(int argc, const char **argv,
 		usage_with_options(archive_usage, opts);
 	*ar = lookup_archiver(format);
 	if (!*ar || (is_remote && !((*ar)->flags & ARCHIVER_REMOTE)))
-		die(_("Unknown archive format '%s'"), format);
+		die(_("unknown archive format '%s'"), format);
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
@@ -612,7 +612,7 @@ static int parse_archive_args(int argc, const char **argv,
 		if (levels_ok && (compression_level <= 9 || high_ok))
 			args->compression_level = compression_level;
 		else {
-			die(_("Argument not supported for format '%s': -%d"),
+			die(_("argument not supported for format '%s': -%d"),
 					format, compression_level);
 		}
 	}
diff --git a/attr.c b/attr.c
index 79adaa50ea1..fcf5da50ba2 100644
--- a/attr.c
+++ b/attr.c
@@ -586,7 +586,7 @@ struct attr_check *attr_check_initl(const char *one, ...)
 			    check->nr, cnt);
 		attr = git_attr(param);
 		if (!attr)
-			BUG("%s: not a valid attribute name", param);
+			BUG("not a valid attribute name: %s", param);
 		check->items[cnt].attr = attr;
 	}
 	va_end(params);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 93ecfcdd245..81ef832b79f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -231,13 +231,13 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test_file_not_empty unmerged &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
+	test_i18ngrep "pulling is not possible because you have unmerged files" err &&
 	test_cmp expected file &&
 	git add file &&
 	git ls-files -u >unmerged &&
 	test_must_be_empty unmerged &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "You have not concluded your merge" err &&
+	test_i18ngrep "you have not concluded your merge" err &&
 	test_cmp expected file
 '
 

base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
-- 
gitgitgadget
