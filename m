From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 01/25] gettextize: git-commit basic messages
Date: Thu,  2 Sep 2010 19:40:22 +0000
Message-ID: <1283456446-22577-2-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFf5-0005iA-Ur
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab0IBTlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0IBTlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:07 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=83gBwvVzLrlJwIBQ5LtN0jzYf51BVflh0VoZzAXVLG0=;
        b=tK5xmgYpGV8f8ATaV0ph34/j0bEwltnMYe31C4MAATUWKDr8p4Gk16tnpbYAWPj6Eg
         prIDRIcZ//duXZuO0WdrUHyc5YMJ1vo9S+5esooVQw3qi/khxR6K6hAfQFFkoTU6yFmt
         rkLGK25k2gnQIfN2f8EbqOzlPiwbAxVbRM4DM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VU7tIG1bBoAsSTeWQLnOwHdlv5kXbPTrLxTwmqRHvnP1GEUMzn9JBRr6yOclyIh0Mc
         U0LAjpNByWz3VCa5fn3QunurRuO29w+8lSQA/Ek/v8kSyauFUU3ifCYgfhbYvuWckw+a
         TY8BRRk0BOp/R2kIFI7QmoCtORfL2Is0KvRNg=
Received: by 10.227.156.210 with SMTP id y18mr10050807wbw.63.1283456466882;
        Thu, 02 Sep 2010 12:41:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155163>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |  116 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..cabf6e3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -241,7 +241,7 @@ static void add_remove_files(struct string_list *li=
st)
=20
 		if (!lstat(p->string, &st)) {
 			if (add_to_cache(p->string, &st, 0))
-				die("updating files failed");
+				die(_("updating files failed"));
 		} else
 			remove_file_from_cache(p->string);
 	}
@@ -268,7 +268,7 @@ static void create_base_index(void)
 	opts.fn =3D oneway_merge;
 	tree =3D parse_tree_indirect(head_sha1);
 	if (!tree)
-		die("failed to unpack HEAD tree object");
+		die(_("failed to unpack HEAD tree object"));
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
@@ -296,9 +296,9 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		refresh_flags |=3D REFRESH_UNMERGED;
 	if (interactive) {
 		if (interactive_add(argc, argv, prefix) !=3D 0)
-			die("interactive add failed");
+			die(_("interactive add failed"));
 		if (read_cache_preload(NULL) < 0)
-			die("index file corrupt");
+			die(_("index file corrupt"));
 		commit_style =3D COMMIT_AS_IS;
 		return get_index_file();
 	}
@@ -307,7 +307,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		pathspec =3D get_pathspec(prefix, argv);
=20
 	if (read_cache_preload(pathspec) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	/*
 	 * Non partial, non as-is commit.
@@ -327,7 +327,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		refresh_cache_or_die(refresh_flags);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
-			die("unable to write new_index file");
+			die(_("unable to write new_index file"));
 		commit_style =3D COMMIT_NORMAL;
 		return index_lock.filename;
 	}
@@ -347,7 +347,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 		if (active_cache_changed) {
 			if (write_cache(fd, active_cache, active_nr) ||
 			    commit_locked_index(&index_lock))
-				die("unable to write new_index file");
+				die(_("unable to write new_index file"));
 		} else {
 			rollback_lock_file(&index_lock);
 		}
@@ -377,7 +377,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
 	commit_style =3D COMMIT_PARTIAL;
=20
 	if (in_merge)
-		die("cannot do a partial commit during a merge.");
+		die(_("cannot do a partial commit during a merge."));
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
@@ -386,14 +386,14 @@ static char *prepare_index(int argc, const char *=
*argv, const char *prefix, int
=20
 	discard_cache();
 	if (read_cache() < 0)
-		die("cannot read the index");
+		die(_("cannot read the index"));
=20
 	fd =3D hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
-		die("unable to write new_index file");
+		die(_("unable to write new_index file"));
=20
 	fd =3D hold_lock_file_for_update(&false_lock,
 				       git_path("next-index-%"PRIuMAX,
@@ -406,7 +406,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix, int
=20
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&false_lock))
-		die("unable to write temporary index file");
+		die(_("unable to write temporary index file"));
=20
 	discard_cache();
 	read_cache_from(false_lock.filename);
@@ -453,7 +453,7 @@ static int is_a_merge(const unsigned char *sha1)
 {
 	struct commit *commit =3D lookup_commit(sha1);
 	if (!commit || parse_commit(commit))
-		die("could not parse HEAD commit");
+		die(_("could not parse HEAD commit"));
 	return !!(commit->parents && commit->parents->next);
 }
=20
@@ -472,13 +472,13 @@ static void determine_author_info(void)
=20
 		a =3D strstr(use_message_buffer, "\nauthor ");
 		if (!a)
-			die("invalid commit: %s", use_message);
+			die(_("invalid commit: %s"), use_message);
=20
 		lb =3D strchrnul(a + strlen("\nauthor "), '<');
 		rb =3D strchrnul(lb, '>');
 		eol =3D strchrnul(rb, '\n');
 		if (!*lb || !*rb || !*eol)
-			die("invalid commit: %s", use_message);
+			die(_("invalid commit: %s"), use_message);
=20
 		if (lb =3D=3D a + strlen("\nauthor "))
 			/* \nauthor <foo@example.com> */
@@ -496,7 +496,7 @@ static void determine_author_info(void)
 		const char *rb =3D strchr(force_author, '>');
=20
 		if (!lb || !rb)
-			die("malformed --author parameter");
+			die(_("malformed --author parameter"));
 		name =3D xstrndup(force_author, lb - force_author);
 		email =3D xstrndup(lb + 2, rb - (lb + 2));
 	}
@@ -570,33 +570,33 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		hook_arg1 =3D "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
-			fprintf(stderr, "(reading log message from standard input)\n");
+			fprintf(stderr, _("(reading log message from standard input)\n"));
 		if (strbuf_read(&sb, 0, 0) < 0)
-			die_errno("could not read log from standard input");
+			die_errno(_("could not read log from standard input"));
 		hook_arg1 =3D "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
-			die_errno("could not read log file '%s'",
+			die_errno(_("could not read log file '%s'"),
 				  logfile);
 		hook_arg1 =3D "message";
 	} else if (use_message) {
 		buffer =3D strstr(use_message_buffer, "\n\n");
 		if (!buffer || buffer[2] =3D=3D '\0')
-			die("commit has empty message");
+			die(_("commit has empty message"));
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
 		hook_arg1 =3D "commit";
 		hook_arg2 =3D use_message;
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
-			die_errno("could not read MERGE_MSG");
+			die_errno(_("could not read MERGE_MSG"));
 		hook_arg1 =3D "merge";
 	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
-			die_errno("could not read SQUASH_MSG");
+			die_errno(_("could not read SQUASH_MSG"));
 		hook_arg1 =3D "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
-			die_errno("could not read '%s'", template_file);
+			die_errno(_("could not read '%s'"), template_file);
 		hook_arg1 =3D "template";
 	}
=20
@@ -609,7 +609,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
=20
 	fp =3D fopen(git_path(commit_editmsg), "w");
 	if (fp =3D=3D NULL)
-		die_errno("could not open '%s'", git_path(commit_editmsg));
+		die_errno(_("could not open '%s'"), git_path(commit_editmsg));
=20
 	if (cleanup_mode !=3D CLEANUP_NONE)
 		stripspace(&sb, 0);
@@ -633,7 +633,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	}
=20
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
-		die_errno("could not write commit template");
+		die_errno(_("could not write commit template"));
=20
 	strbuf_release(&sb);
=20
@@ -702,7 +702,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		const char *parent =3D "HEAD";
=20
 		if (!active_nr && read_cache() < 0)
-			die("Cannot read index");
+			die(_("Cannot read index"));
=20
 		if (amend)
 			parent =3D "HEAD^1";
@@ -734,7 +734,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		active_cache_tree =3D cache_tree();
 	if (cache_tree_update(active_cache_tree,
 			      active_cache, active_nr, 0, 0) < 0) {
-		error("Error building trees");
+		error(_("Error building trees"));
 		return 0;
 	}
=20
@@ -749,7 +749,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 		snprintf(index, sizeof(index), "GIT_INDEX_FILE=3D%s", index_file);
 		if (launch_editor(git_path(commit_editmsg), NULL, env)) {
 			fprintf(stderr,
-			"Please supply the message using either -m or -F option.\n");
+			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
 	}
@@ -829,7 +829,7 @@ static const char *find_author_by_nickname(const ch=
ar *name)
 		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
 	}
-	die("No existing author found with '%s'", name);
+	die(_("No existing author found with '%s'"), name);
 }
=20
=20
@@ -844,7 +844,7 @@ static void handle_untracked_files_arg(struct wt_st=
atus *s)
 	else if (!strcmp(untracked_files_arg, "all"))
 		s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
 	else
-		die("Invalid untracked files mode '%s'", untracked_files_arg);
+		die(_("Invalid untracked files mode '%s'"), untracked_files_arg);
 }
=20
 static int parse_and_validate_options(int argc, const char *argv[],
@@ -861,7 +861,7 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
 		force_author =3D find_author_by_nickname(force_author);
=20
 	if (force_author && renew_authorship)
-		die("Using both --reset-author and --author does not make sense");
+		die(_("Using both --reset-author and --author does not make sense"))=
;
=20
 	if (logfile || message.len || use_message)
 		use_editor =3D 0;
@@ -875,9 +875,9 @@ static int parse_and_validate_options(int argc, con=
st char *argv[],
=20
 	/* Sanity check options */
 	if (amend && initial_commit)
-		die("You have nothing to amend.");
+		die(_("You have nothing to amend."));
 	if (amend && in_merge)
-		die("You are in the middle of a merge -- cannot amend.");
+		die(_("You are in the middle of a merge -- cannot amend."));
=20
 	if (use_message)
 		f++;
@@ -886,15 +886,15 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	if (logfile)
 		f++;
 	if (f > 1)
-		die("Only one of -c/-C/-F can be used.");
+		die(_("Only one of -c/-C/-F can be used."));
 	if (message.len && f > 0)
-		die("Option -m cannot be combined with -c/-C/-F.");
+		die(_("Option -m cannot be combined with -c/-C/-F."));
 	if (edit_message)
 		use_message =3D edit_message;
 	if (amend && !use_message)
 		use_message =3D "HEAD";
 	if (!use_message && renew_authorship)
-		die("--reset-author can be used only with -C, -c or --amend.");
+		die(_("--reset-author can be used only with -C, -c or --amend."));
 	if (use_message) {
 		unsigned char sha1[20];
 		static char utf8[] =3D "UTF-8";
@@ -903,10 +903,10 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 		struct commit *commit;
=20
 		if (get_sha1(use_message, sha1))
-			die("could not lookup commit %s", use_message);
+			die(_("could not lookup commit %s"), use_message);
 		commit =3D lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit))
-			die("could not parse commit %s", use_message);
+			die(_("could not parse commit %s"), use_message);
=20
 		enc =3D strstr(commit->buffer, "\nencoding");
 		if (enc) {
@@ -934,13 +934,13 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	}
=20
 	if (!!also + !!only + !!all + !!interactive > 1)
-		die("Only one of --include/--only/--all/--interactive can be used.")=
;
+		die(_("Only one of --include/--only/--all/--interactive can be used.=
"));
 	if (argc =3D=3D 0 && (also || (only && !amend)))
-		die("No paths with --include/--only does not make sense.");
+		die(_("No paths with --include/--only does not make sense."));
 	if (argc =3D=3D 0 && only && amend)
-		only_include_assumed =3D "Clever... amending the last one with dirty=
 index.";
+		only_include_assumed =3D _("Clever... amending the last one with dir=
ty index.");
 	if (argc > 0 && !also && !only)
-		only_include_assumed =3D "Explicit paths specified without -i nor -o=
; assuming --only paths...";
+		only_include_assumed =3D _("Explicit paths specified without -i nor =
-o; assuming --only paths...");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode =3D use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
@@ -950,14 +950,14 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
 	else if (!strcmp(cleanup_arg, "strip"))
 		cleanup_mode =3D CLEANUP_ALL;
 	else
-		die("Invalid cleanup mode %s", cleanup_arg);
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
=20
 	handle_untracked_files_arg(s);
=20
 	if (all && argc > 0)
-		die("Paths with -a does not make sense.");
+		die(_("Paths with -a does not make sense."));
 	else if (interactive && argc > 0)
-		die("Paths with --interactive does not make sense.");
+		die(_("Paths with --interactive does not make sense."));
=20
 	if (null_termination && status_format =3D=3D STATUS_FORMAT_LONG)
 		status_format =3D STATUS_FORMAT_PORCELAIN;
@@ -1036,7 +1036,7 @@ static int git_status_config(const char *k, const=
 char *v, void *cb)
 		else if (!strcmp(v, "all"))
 			s->show_untracked_files =3D SHOW_ALL_UNTRACKED_FILES;
 		else
-			return error("Invalid untracked files mode '%s'", v);
+			return error(_("Invalid untracked files mode '%s'"), v);
 		return 0;
 	}
 	return git_diff_ui_config(k, v, NULL);
@@ -1139,9 +1139,9 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
=20
 	commit =3D lookup_commit(sha1);
 	if (!commit)
-		die("couldn't look up newly created commit");
+		die(_("couldn't look up newly created commit"));
 	if (!commit || parse_commit(commit))
-		die("could not parse newly created commit");
+		die(_("could not parse newly created commit"));
=20
 	strbuf_addstr(&format, "format:%h] %s");
=20
@@ -1291,7 +1291,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D "commit (amend)";
 		commit =3D lookup_commit(head_sha1);
 		if (!commit || parse_commit(commit))
-			die("could not parse HEAD commit");
+			die(_("could not parse HEAD commit"));
=20
 		for (c =3D commit->parents; c; c =3D c->next)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
@@ -1304,19 +1304,19 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
-			die_errno("could not open '%s' for reading",
+			die_errno(_("could not open '%s' for reading"),
 				  git_path("MERGE_HEAD"));
 		while (strbuf_getline(&m, fp, '\n') !=3D EOF) {
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
-				die("Corrupt MERGE_HEAD file (%s)", m.buf);
+				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
 			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
 		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
 			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
-				die_errno("could not read MERGE_MODE");
+				die_errno(_("could not read MERGE_MODE"));
 			if (!strcmp(sb.buf, "no-ff"))
 				allow_fast_forward =3D 0;
 		}
@@ -1333,7 +1333,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0) {
 		int saved_errno =3D errno;
 		rollback_index_files();
-		die("could not read commit message: %s", strerror(saved_errno));
+		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
=20
 	/* Truncate the message just before the diff, if any. */
@@ -1347,7 +1347,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 		stripspace(&sb, cleanup_mode =3D=3D CLEANUP_ALL);
 	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
-		fprintf(stderr, "Aborting commit due to empty commit message.\n");
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"))=
;
 		exit(1);
 	}
=20
@@ -1355,7 +1355,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			fmt_ident(author_name, author_email, author_date,
 				IDENT_ERROR_ON_NO_NAME))) {
 		rollback_index_files();
-		die("failed to write commit object");
+		die(_("failed to write commit object"));
 	}
=20
 	ref_lock =3D lock_any_ref_for_update("HEAD",
@@ -1372,11 +1372,11 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
=20
 	if (!ref_lock) {
 		rollback_index_files();
-		die("cannot lock HEAD ref");
+		die(_("cannot lock HEAD ref"));
 	}
 	if (write_ref_sha1(ref_lock, commit_sha1, sb.buf) < 0) {
 		rollback_index_files();
-		die("cannot update HEAD ref");
+		die(_("cannot update HEAD ref"));
 	}
=20
 	unlink(git_path("MERGE_HEAD"));
@@ -1385,9 +1385,9 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	unlink(git_path("SQUASH_MSG"));
=20
 	if (commit_index_files())
-		die ("Repository has been updated, but unable to write\n"
+		die (_("Repository has been updated, but unable to write\n"
 		     "new_index file. Check that disk is not full or quota is\n"
-		     "not exceeded, and then \"git reset HEAD\" to recover.");
+		     "not exceeded, and then \"git reset HEAD\" to recover."));
=20
 	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
--=20
1.7.2.2.614.g1dc9
