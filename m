From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 68/72] gettextize: git-revert basic messages
Date: Sat, 19 Feb 2011 19:24:51 +0000
Message-ID: <1298143495-3681-69-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUW-0003dU-Hn
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271Ab1BST2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61282 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab1BST2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:25 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347203eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=WTfefPwEjsDSswBXMOdfVJJnw0vfAlaa/b4oKqkXMsM=;
        b=lgNn+WuxmZFHIatXepD5GdwV/89M8R/cOKpfBGCi7X7/Z3E8EPNIGLQBZj/aL6tV7o
         ZM2g+ekZPu0vPCKI1p8gzqMSS5oeQP29kc7BjpG9o2RZadswC2NMzXvRmHSdqyJp59Yb
         UUJ5+br3ZBSCQY2VhBX6iDbf1XmGtnY9MJj6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KDpRCbEsAnrvNaV1d4EExFcfISU9ylk6soHw9ce69IOAvEUZA/DjIeHultGyu3Mdqz
         uy9bw9EyT2ohoIc5N07gRbDMeMiSFMlPtZ7uoM8xSa98mcZ8wYjAsPhxn7D5hqlMNphc
         rFNDXCS1EtB1wOK15q52l5/KIfV5AvjP0zrqo=
Received: by 10.213.27.78 with SMTP id h14mr909198ebc.17.1298143704315;
        Sat, 19 Feb 2011 11:28:24 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.23
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:23 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167352>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index dc1b702..1ca08da 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -96,7 +96,7 @@ static void parse_args(int argc, const char **argv)
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
-			die("program error");
+			die(_("program error"));
 	}
=20
 	commit_argc =3D parse_options(argc, argv, NULL, options, usage_str,
@@ -168,7 +168,7 @@ static char *get_encoding(const char *message)
 	const char *p =3D message, *eol;
=20
 	if (!p)
-		die ("Could not read commit message of %s",
+		die (_("Could not read commit message of %s"),
 				sha1_to_hex(commit->object.sha1));
 	while (*p && *p !=3D '\n') {
 		for (eol =3D p + 1; *eol && *eol !=3D '\n'; eol++)
@@ -202,7 +202,7 @@ static void set_author_ident_env(const char *messag=
e)
 {
 	const char *p =3D message;
 	if (!p)
-		die ("Could not read commit message of %s",
+		die (_("Could not read commit message of %s"),
 				sha1_to_hex(commit->object.sha1));
 	while (*p && *p !=3D '\n') {
 		const char *eol;
@@ -216,7 +216,7 @@ static void set_author_ident_env(const char *messag=
e)
 			line =3D xmemdupz(p, eol - p);
 			email =3D strchr(line, '<');
 			if (!email)
-				die ("Could not extract author email from %s",
+				die (_("Could not extract author email from %s"),
 					sha1_to_hex(commit->object.sha1));
 			if (email =3D=3D line)
 				pend =3D line;
@@ -228,7 +228,7 @@ static void set_author_ident_env(const char *messag=
e)
 			email++;
 			timestamp =3D strchr(email, '>');
 			if (!timestamp)
-				die ("Could not extract author time from %s",
+				die (_("Could not extract author time from %s"),
 					sha1_to_hex(commit->object.sha1));
 			*timestamp =3D '\0';
 			for (timestamp++; *timestamp && isspace(*timestamp);
@@ -244,7 +244,7 @@ static void set_author_ident_env(const char *messag=
e)
 		if (*p =3D=3D '\n')
 			p++;
 	}
-	die ("No author information found in %s",
+	die (_("No author information found in %s"),
 			sha1_to_hex(commit->object.sha1));
 }
=20
@@ -281,10 +281,10 @@ static void write_message(struct strbuf *msgbuf, =
const char *filename)
 	int msg_fd =3D hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno("Could not write to %s.", filename);
+		die_errno(_("Could not write to %s."), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die("Error wrapping up %s", filename);
+		die(_("Error wrapping up %s"), filename);
 }
=20
 static struct tree *empty_tree(void)
@@ -420,10 +420,10 @@ static int do_pick_commit(void)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die ("Your index file is unmerged.");
+			die (_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			die ("You do not have a valid HEAD");
+			die (_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
 			die_dirty_index(me);
 	}
@@ -431,7 +431,7 @@ static int do_pick_commit(void)
=20
 	if (!commit->parents) {
 		if (action =3D=3D REVERT)
-			die ("Cannot revert a root commit");
+			die (_("Cannot revert a root commit"));
 		parent =3D NULL;
 	}
 	else if (commit->parents->next) {
@@ -440,7 +440,7 @@ static int do_pick_commit(void)
 		struct commit_list *p;
=20
 		if (!mainline)
-			die("Commit %s is a merge but no -m option was given.",
+			die(_("Commit %s is a merge but no -m option was given."),
 			    sha1_to_hex(commit->object.sha1));
=20
 		for (cnt =3D 1, p =3D commit->parents;
@@ -448,11 +448,11 @@ static int do_pick_commit(void)
 		     cnt++)
 			p =3D p->next;
 		if (cnt !=3D mainline || !p)
-			die("Commit %s does not have parent %d",
+			die(_("Commit %s does not have parent %d"),
 			    sha1_to_hex(commit->object.sha1), mainline);
 		parent =3D p->item;
 	} else if (0 < mainline)
-		die("Mainline was specified but commit %s is not a merge.",
+		die(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent =3D commit->parents->item;
@@ -465,7 +465,7 @@ static int do_pick_commit(void)
 		    me, sha1_to_hex(parent->object.sha1));
=20
 	if (get_message(commit->buffer, &msg) !=3D 0)
-		die("Cannot get commit message for %s",
+		die(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
=20
 	/*
@@ -556,10 +556,10 @@ static void prepare_revs(struct rev_info *revs)
 		usage(*revert_or_cherry_pick_usage());
=20
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	if (!revs->commits)
-		die("empty commit set passed");
+		die(_("empty commit set passed"));
 }
=20
 static void read_and_refresh_cache(const char *me)
@@ -567,12 +567,12 @@ static void read_and_refresh_cache(const char *me=
)
 	static struct lock_file index_lock;
 	int index_fd =3D hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die("git %s: failed to read the index", me);
+		die(_("git %s: failed to read the index"), me);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL,=
 NULL);
 	if (the_index.cache_changed) {
 		if (write_index(&the_index, index_fd) ||
 		    commit_locked_index(&index_lock))
-			die("git %s: failed to refresh the index", me);
+			die(_("git %s: failed to refresh the index"), me);
 	}
 	rollback_lock_file(&index_lock);
 }
@@ -588,13 +588,13 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
=20
 	if (allow_ff) {
 		if (signoff)
-			die("cherry-pick --ff cannot be used with --signoff");
+			die(_("cherry-pick --ff cannot be used with --signoff"));
 		if (no_commit)
-			die("cherry-pick --ff cannot be used with --no-commit");
+			die(_("cherry-pick --ff cannot be used with --no-commit"));
 		if (no_replay)
-			die("cherry-pick --ff cannot be used with -x");
+			die(_("cherry-pick --ff cannot be used with -x"));
 		if (edit)
-			die("cherry-pick --ff cannot be used with --edit");
+			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
=20
 	read_and_refresh_cache(me);
--=20
1.7.2.3
