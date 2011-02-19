From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 66/72] gettextize: git-notes basic commands
Date: Sat, 19 Feb 2011 19:24:49 +0000
Message-ID: <1298143495-3681-67-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUY-0003dU-8P
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284Ab1BST2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:55 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab1BST2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:23 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=W9EVdoL1GNOyXE7Pa5U+4XhDmRk6g3VcNYDOKjHpBK8=;
        b=i0zHhqbdyO87rODY2JvHOItLQgUCCFK5cMiUVLAE9jMtELuuj3kp+D3Qw8RaTJ3zgJ
         27usLxXz97vhzFBfyLTG+vMZFRIRwQ7/cgu9u6KoSqe0Zzp59CKdqYpwpp6Vu3QJCyfo
         a0ikFYxdYBNxYtKuTKdbTyLuxZ42/mr703Tf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PAZlgbwWNyGxbeDlaHzJbBt7sWOXKwR4/q7/T5XAXzNPetcHOhbbE6eEwynGge3VDF
         y4YCT3Svtn/8kMffhlPAjPRkWlFRUZl8e4hNiD0aTgPU82IacX0a6ZJ/mgCWCBmkoQdY
         OdNm2H7/XDgyoGDkgTOGf7cOxWdwDPJZo/nUY=
Received: by 10.213.30.20 with SMTP id s20mr2573915ebc.15.1298143702362;
        Sat, 19 Feb 2011 11:28:22 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.21
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:21 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167358>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |  106 +++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4d5556e..4c6cf85 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -146,13 +146,13 @@ static void write_commented_object(int fd, const =
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
@@ -162,10 +162,10 @@ static void write_commented_object(int fd, const =
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
@@ -182,7 +182,7 @@ static void create_note(const unsigned char *object=
, struct msg_arg *msg,
 		path =3D git_pathdup("NOTES_EDITMSG");
 		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno("could not create file '%s'", path);
+			die_errno(_("could not create file '%s'"), path);
=20
 		if (msg->given)
 			write_or_die(fd, msg->buf.buf, msg->buf.len);
@@ -196,8 +196,8 @@ static void create_note(const unsigned char *object=
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
@@ -217,14 +217,14 @@ static void create_note(const unsigned char *obje=
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
@@ -258,9 +258,9 @@ static int parse_file_arg(const struct option *opt,=
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
@@ -279,10 +279,10 @@ static int parse_reuse_arg(const struct option *o=
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
@@ -306,7 +306,7 @@ void commit_notes(struct notes_tree *t, const char =
*msg)
 	if (!t)
 		t =3D &default_notes_tree;
 	if (!t->initialized || !t->ref || !*t->ref)
-		die("Cannot commit uninitialized/unreferenced notes tree");
+		die(_("Cannot commit uninitialized/unreferenced notes tree"));
 	if (!t->dirty)
 		return; /* don't have to commit an unchanged tree */
=20
@@ -347,7 +347,7 @@ static int notes_rewrite_config(const char *k, cons=
t char *v, void *cb)
 			config_error_nonbool(k);
 		c->combine =3D parse_combine_notes_fn(v);
 		if (!c->combine) {
-			error("Bad notes.rewriteMode value: '%s'", v);
+			error(_("Bad notes.rewriteMode value: '%s'"), v);
 			return 1;
 		}
 		return 0;
@@ -357,8 +357,8 @@ static int notes_rewrite_config(const char *k, cons=
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
@@ -446,13 +446,13 @@ int notes_copy_from_stdin(int force, const char *=
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
@@ -461,7 +461,7 @@ int notes_copy_from_stdin(int force, const char *re=
write_cmd)
 					combine_notes_overwrite);
=20
 		if (err) {
-			error("Failed to copy notes from '%s' to '%s'",
+			error(_("Failed to copy notes from '%s' to '%s'"),
 			      split[0]->buf, split[1]->buf);
 			ret =3D 1;
 		}
@@ -505,20 +505,20 @@ static int list(int argc, const char **argv, cons=
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
@@ -557,26 +557,26 @@ static int add(int argc, const char **argv, const=
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
@@ -618,7 +618,7 @@ static int copy(int argc, const char **argv, const =
char *prefix)
=20
 	if (from_stdin || rewrite_cmd) {
 		if (argc) {
-			error("too many parameters");
+			error(_("too many parameters"));
 			usage_with_options(git_notes_copy_usage, options);
 		} else {
 			return notes_copy_from_stdin(force, rewrite_cmd);
@@ -626,41 +626,41 @@ static int copy(int argc, const char **argv, cons=
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
@@ -703,19 +703,19 @@ static int append_edit(int argc, const char **arg=
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
@@ -750,20 +750,20 @@ static int show(int argc, const char **argv, cons=
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
@@ -961,22 +961,22 @@ static int remove_cmd(int argc, const char **argv=
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
 	retval =3D remove_note(t, object);
 	if (retval)
-		fprintf(stderr, "Object %s has no note\n", sha1_to_hex(object));
+		fprintf(stderr, _("Object %s has no note\n"), sha1_to_hex(object));
 	else {
-		fprintf(stderr, "Removing note for object %s\n",
+		fprintf(stderr, _("Removing note for object %s\n"),
 			sha1_to_hex(object));
=20
 		commit_notes(t, "Notes removed by 'git notes remove'");
@@ -999,7 +999,7 @@ static int prune(int argc, const char **argv, const=
 char *prefix)
 			     0);
=20
 	if (argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_prune_usage, options);
 	}
=20
@@ -1069,7 +1069,7 @@ int cmd_notes(int argc, const char **argv, const =
char *prefix)
 	else if (!strcmp(argv[0], "get-ref"))
 		result =3D get_ref(argc, argv, prefix);
 	else {
-		result =3D error("Unknown subcommand: %s", argv[0]);
+		result =3D error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(git_notes_usage, options);
 	}
=20
--=20
1.7.2.3
