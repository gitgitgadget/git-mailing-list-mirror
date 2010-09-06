From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/15] gettextize: git-notes basic commands
Date: Mon,  6 Sep 2010 12:21:37 +0000
Message-ID: <1283775704-29440-9-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiu-0000aR-Pr
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab0IFMWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:33 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:50377 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab0IFMWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:32 -0400
Received: by mail-ww0-f42.google.com with SMTP id 40so2310943wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=QCRAmJfcVOV/Y91ptuxKyhRCiEn0db3nKYxDNo2xXPM=;
        b=gZZpSKexPu4uAq7CdL8B3z1W5oIbniKYqjO5l914D0sUfgJOWAg+l0jEeOcZdvd215
         BzN5MYmm0ZK5zxIZpvZXzq7XUQPEY+WVsrPVRYKEFVOYeH8+RUOV8Gn9jD0DURIHS/m1
         4mFAi8hG/4gtiWLILrCDxpeaiKCRdKe4QnosE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AEp3Bw7u15SrrBb2HiXxpyTxp8/2hD5D0dfJYEE+f+MlV2V63S2xyvnd/eRNjHuGSK
         n+oBLwkIMiVY289/KWpu/04mFESXhaDdfx9iX+FkaCEfZCaMmy4RTKlHTGm/Se6rFplq
         bvc7x8EsXsFD3NUqvoOm0ECqmxOB0dsW5EGO8=
Received: by 10.216.158.7 with SMTP id p7mr2524398wek.58.1283775751022;
        Mon, 06 Sep 2010 05:22:31 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155558>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |  108 +++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index fbc347c..d171f6f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -119,13 +119,13 @@ static void write_commented_object(int fd, const =
unsigned char *object)
 	show.err =3D 0;
 	show.git_cmd =3D 1;
 	if (start_command(&show))
-		die("unable to start 'show' for object '%s'",
+		die(_("unable to start 'show' for object '%s'"),
 		    sha1_to_hex(object));
=20
 	/* Open the output as FILE* so strbuf_getline() can be used. */
 	show_out =3D xfdopen(show.out, "r");
 	if (show_out =3D=3D NULL)
-		die_errno("can't fdopen 'show' output fd");
+		die_errno(_("can't fdopen 'show' output fd"));
=20
 	/* Prepend "# " to each output line and write result to 'fd' */
 	while (strbuf_getline(&buf, show_out, '\n') !=3D EOF) {
@@ -135,10 +135,10 @@ static void write_commented_object(int fd, const =
unsigned char *object)
 	}
 	strbuf_release(&buf);
 	if (fclose(show_out))
-		die_errno("failed to close pipe to 'show' for object '%s'",
+		die_errno(_("failed to close pipe to 'show' for object '%s'"),
 			  sha1_to_hex(object));
 	if (finish_command(&show))
-		die("failed to finish 'show' for object '%s'",
+		die(_("failed to finish 'show' for object '%s'"),
 		    sha1_to_hex(object));
 }
=20
@@ -155,7 +155,7 @@ static void create_note(const unsigned char *object=
, struct msg_arg *msg,
 		path =3D git_pathdup("NOTES_EDITMSG");
 		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno("could not create file '%s'", path);
+			die_errno(_("could not create file '%s'"), path);
=20
 		if (msg->given)
 			write_or_die(fd, msg->buf.buf, msg->buf.len);
@@ -169,8 +169,8 @@ static void create_note(const unsigned char *object=
, struct msg_arg *msg,
 		strbuf_reset(&(msg->buf));
=20
 		if (launch_editor(path, &(msg->buf), NULL)) {
-			die("Please supply the note contents using either -m" \
-			    " or -F option");
+			die(_("Please supply the note contents using either -m" \
+			    " or -F option"));
 		}
 		stripspace(&(msg->buf), 1);
 	}
@@ -190,14 +190,14 @@ static void create_note(const unsigned char *obje=
ct, struct msg_arg *msg,
 	}
=20
 	if (!msg->buf.len) {
-		fprintf(stderr, "Removing note for object %s\n",
+		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
 		hashclr(result);
 	} else {
 		if (write_sha1_file(msg->buf.buf, msg->buf.len, blob_type, result)) =
{
-			error("unable to write note object");
+			error(_("unable to write note object"));
 			if (path)
-				error("The note contents has been left in %s",
+				error(_("The note contents has been left in %s"),
 				      path);
 			exit(128);
 		}
@@ -231,9 +231,9 @@ static int parse_file_arg(const struct option *opt,=
 const char *arg, int unset)
 		strbuf_addch(&(msg->buf), '\n');
 	if (!strcmp(arg, "-")) {
 		if (strbuf_read(&(msg->buf), 0, 1024) < 0)
-			die_errno("cannot read '%s'", arg);
+			die_errno(_("cannot read '%s'"), arg);
 	} else if (strbuf_read_file(&(msg->buf), arg, 1024) < 0)
-		die_errno("could not open or read '%s'", arg);
+		die_errno(_("could not open or read '%s'"), arg);
 	stripspace(&(msg->buf), 0);
=20
 	msg->given =3D 1;
@@ -252,10 +252,10 @@ static int parse_reuse_arg(const struct option *o=
pt, const char *arg, int unset)
 		strbuf_addch(&(msg->buf), '\n');
=20
 	if (get_sha1(arg, object))
-		die("Failed to resolve '%s' as a valid ref.", arg);
+		die(_("Failed to resolve '%s' as a valid ref."), arg);
 	if (!(buf =3D read_sha1_file(object, &type, &len)) || !len) {
 		free(buf);
-		die("Failed to read object '%s'.", arg);;
+		die(_("Failed to read object '%s'."), arg);;
 	}
 	strbuf_add(&(msg->buf), buf, len);
 	free(buf);
@@ -280,7 +280,7 @@ int commit_notes(struct notes_tree *t, const char *=
msg)
 	if (!t)
 		t =3D &default_notes_tree;
 	if (!t->initialized || !t->ref || !*t->ref)
-		die("Cannot commit uninitialized/unreferenced notes tree");
+		die(_("Cannot commit uninitialized/unreferenced notes tree"));
 	if (!t->dirty)
 		return 0; /* don't have to commit an unchanged tree */
=20
@@ -292,7 +292,7 @@ int commit_notes(struct notes_tree *t, const char *=
msg)
=20
 	/* Convert notes tree to tree object */
 	if (write_notes_tree(t, tree_sha1))
-		die("Failed to write current notes tree to database");
+		die(_("Failed to write current notes tree to database"));
=20
 	/* Create new commit for the tree object */
 	if (!read_ref(t->ref, prev_commit)) { /* retrieve parent commit */
@@ -304,7 +304,7 @@ int commit_notes(struct notes_tree *t, const char *=
msg)
 		parent =3D NULL;
 	}
 	if (commit_tree(buf.buf + 7, tree_sha1, parent, new_commit, NULL))
-		die("Failed to commit notes tree to database");
+		die(_("Failed to commit notes tree to database"));
=20
 	/* Update notes ref with new commit */
 	update_ref(buf.buf, t->ref, new_commit, prev_commit, 0, DIE_ON_ERR);
@@ -336,7 +336,7 @@ static int notes_rewrite_config(const char *k, cons=
t char *v, void *cb)
 			config_error_nonbool(k);
 		c->combine =3D parse_combine_notes_fn(v);
 		if (!c->combine) {
-			error("Bad notes.rewriteMode value: '%s'", v);
+			error(_("Bad notes.rewriteMode value: '%s'"), v);
 			return 1;
 		}
 		return 0;
@@ -346,8 +346,8 @@ static int notes_rewrite_config(const char *k, cons=
t char *v, void *cb)
 		if (!prefixcmp(v, "refs/notes/"))
 			string_list_add_refs_by_glob(c->refs, v);
 		else
-			warning("Refusing to rewrite notes in %s"
-				" (outside of refs/notes/)", v);
+			warning(_("Refusing to rewrite notes in %s"
+				" (outside of refs/notes/)"), v);
 		return 0;
 	}
=20
@@ -435,13 +435,13 @@ int notes_copy_from_stdin(int force, const char *=
rewrite_cmd)
=20
 		split =3D strbuf_split(&buf, ' ');
 		if (!split[0] || !split[1])
-			die("Malformed input line: '%s'.", buf.buf);
+			die(_("Malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
 		strbuf_rtrim(split[1]);
 		if (get_sha1(split[0]->buf, from_obj))
-			die("Failed to resolve '%s' as a valid ref.", split[0]->buf);
+			die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
 		if (get_sha1(split[1]->buf, to_obj))
-			die("Failed to resolve '%s' as a valid ref.", split[1]->buf);
+			die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
=20
 		if (rewrite_cmd)
 			err =3D copy_note_for_rewrite(c, from_obj, to_obj);
@@ -450,7 +450,7 @@ int notes_copy_from_stdin(int force, const char *re=
write_cmd)
 					combine_notes_overwrite);
=20
 		if (err) {
-			error("Failed to copy notes from '%s' to '%s'",
+			error(_("Failed to copy notes from '%s' to '%s'"),
 			      split[0]->buf, split[1]->buf);
 			ret =3D 1;
 		}
@@ -494,20 +494,20 @@ static int list(int argc, const char **argv, cons=
t char *prefix)
 				     git_notes_list_usage, 0);
=20
 	if (1 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_list_usage, options);
 	}
=20
 	t =3D init_notes_check("list");
 	if (argc) {
 		if (get_sha1(argv[0], object))
-			die("Failed to resolve '%s' as a valid ref.", argv[0]);
+			die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
 		note =3D get_note(t, object);
 		if (note) {
 			puts(sha1_to_hex(note));
 			retval =3D 0;
 		} else
-			retval =3D error("No note found for object %s.",
+			retval =3D error(_("No note found for object %s."),
 				       sha1_to_hex(object));
 	} else
 		retval =3D for_each_note(t, 0, list_each_note, NULL);
@@ -546,26 +546,26 @@ static int add(int argc, const char **argv, const=
 char *prefix)
 			     0);
=20
 	if (1 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_add_usage, options);
 	}
=20
 	object_ref =3D argc ? argv[0] : "HEAD";
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	t =3D init_notes_check("add");
 	note =3D get_note(t, object);
=20
 	if (note) {
 		if (!force) {
-			retval =3D error("Cannot add notes. Found existing notes "
+			retval =3D error(_("Cannot add notes. Found existing notes "
 				       "for object %s. Use '-f' to overwrite "
-				       "existing notes", sha1_to_hex(object));
+				       "existing notes"), sha1_to_hex(object));
 			goto out;
 		}
-		fprintf(stderr, "Overwriting existing notes for object %s\n",
+		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			sha1_to_hex(object));
 	}
=20
@@ -607,7 +607,7 @@ static int copy(int argc, const char **argv, const =
char *prefix)
=20
 	if (from_stdin || rewrite_cmd) {
 		if (argc) {
-			error("too many parameters");
+			error(_("too many parameters"));
 			usage_with_options(git_notes_copy_usage, options);
 		} else {
 			return notes_copy_from_stdin(force, rewrite_cmd);
@@ -615,41 +615,41 @@ static int copy(int argc, const char **argv, cons=
t char *prefix)
 	}
=20
 	if (argc < 2) {
-		error("too few parameters");
+		error(_("too few parameters"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
 	if (2 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
=20
 	if (get_sha1(argv[0], from_obj))
-		die("Failed to resolve '%s' as a valid ref.", argv[0]);
+		die(_("Failed to resolve '%s' as a valid ref."), argv[0]);
=20
 	object_ref =3D 1 < argc ? argv[1] : "HEAD";
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	t =3D init_notes_check("copy");
 	note =3D get_note(t, object);
=20
 	if (note) {
 		if (!force) {
-			retval =3D error("Cannot copy notes. Found existing "
+			retval =3D error(_("Cannot copy notes. Found existing "
 				       "notes for object %s. Use '-f' to "
-				       "overwrite existing notes",
+				       "overwrite existing notes"),
 				       sha1_to_hex(object));
 			goto out;
 		}
-		fprintf(stderr, "Overwriting existing notes for object %s\n",
+		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
 			sha1_to_hex(object));
 	}
=20
 	from_note =3D get_note(t, from_obj);
 	if (!from_note) {
-		retval =3D error("Missing notes on source object %s. Cannot "
-			       "copy.", sha1_to_hex(from_obj));
+		retval =3D error(_("Missing notes on source object %s. Cannot "
+			       "copy."), sha1_to_hex(from_obj));
 		goto out;
 	}
=20
@@ -691,19 +691,19 @@ static int append_edit(int argc, const char **arg=
v, const char *prefix)
 			     PARSE_OPT_KEEP_ARGV0);
=20
 	if (2 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(usage, options);
 	}
=20
 	if (msg.given && edit)
-		fprintf(stderr, "The -m/-F/-c/-C options have been deprecated "
+		fprintf(stderr, _("The -m/-F/-c/-C options have been deprecated "
 			"for the 'edit' subcommand.\n"
-			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n");
+			"Please use 'git notes add -f -m/-F/-c/-C' instead.\n"));
=20
 	object_ref =3D 1 < argc ? argv[1] : "HEAD";
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	t =3D init_notes_check(argv[0]);
 	note =3D get_note(t, object);
@@ -738,20 +738,20 @@ static int show(int argc, const char **argv, cons=
t char *prefix)
 			     0);
=20
 	if (1 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_show_usage, options);
 	}
=20
 	object_ref =3D argc ? argv[0] : "HEAD";
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	t =3D init_notes_check("show");
 	note =3D get_note(t, object);
=20
 	if (!note)
-		retval =3D error("No note found for object %s.",
+		retval =3D error(_("No note found for object %s."),
 			       sha1_to_hex(object));
 	else {
 		const char *show_args[3] =3D {"show", sha1_to_hex(note), NULL};
@@ -774,18 +774,18 @@ static int remove_cmd(int argc, const char **argv=
, const char *prefix)
 			     git_notes_remove_usage, 0);
=20
 	if (1 < argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_remove_usage, options);
 	}
=20
 	object_ref =3D argc ? argv[0] : "HEAD";
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	t =3D init_notes_check("remove");
=20
-	fprintf(stderr, "Removing note for object %s\n", sha1_to_hex(object))=
;
+	fprintf(stderr, _("Removing note for object %s\n"), sha1_to_hex(objec=
t));
 	remove_note(t, object);
=20
 	commit_notes(t, "Notes removed by 'git notes remove'");
@@ -808,7 +808,7 @@ static int prune(int argc, const char **argv, const=
 char *prefix)
 			     0);
=20
 	if (argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_prune_usage, options);
 	}
=20
@@ -864,7 +864,7 @@ int cmd_notes(int argc, const char **argv, const ch=
ar *prefix)
 	else if (!strcmp(argv[0], "prune"))
 		result =3D prune(argc, argv, prefix);
 	else {
-		result =3D error("Unknown subcommand: %s", argv[0]);
+		result =3D error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
=20
--=20
1.7.2.3.313.gcd15
