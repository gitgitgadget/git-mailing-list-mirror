From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/15] add: mark basic messages for translation
Date: Mon, 21 Feb 2011 04:24:30 -0600
Message-ID: <20110221102430.GK32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:24:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSwb-0005LD-Ra
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab1BUKYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:24:37 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40910 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BUKYg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:24:36 -0500
Received: by iwn8 with SMTP id 8so1733788iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8xfxL/kQkecl2L5rbOycZU9q6D56+/3uRAxW+ZarROU=;
        b=gMgrUzVbN2uppwCircOw1iNT+0SAhrlG+HxMspcJC7GXLBfjsTycW9JI16oqIxAuOw
         lghoAeDcK5yeVegGhMWzjiD4Q8PrrUzAmnvdeE9ngqSao2vMRsUlgmNP73IV9MIuCeOG
         iqGdq+L4d+6zlKYIxKSCT+678+E08x32QNuiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xX7+eKCOawVOJm3fxyGOI4FlmoHqle7vPxHlFi4LZHnszq2SwyMJl6c2OCkl7+H5uG
         RHG+6+eTGLvWaIfjgTRcMzDaExiZu5SUw9JBfSGma/Ye+nAAn3rLHyr5lEKlUf+T6GTd
         khNfWE17LKvcKJaBkvzwzY8Mt57Km9f15P5O0=
Received: by 10.42.171.135 with SMTP id j7mr1742633icz.182.1298283875563;
        Mon, 21 Feb 2011 02:24:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id gy41sm980182ibb.11.2011.02.21.02.24.33
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:24:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167466>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Wed, 1 Sep 2010 18:40:13 +0000

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 42c906e..a9a78f4 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -38,7 +38,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		const char *path =3D p->one->path;
 		switch (p->status) {
 		default:
-			die("unexpected diff status %c", p->status);
+			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_UNMERGED:
 			/*
 			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
@@ -64,7 +64,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 		case DIFF_STATUS_TYPE_CHANGED:
 			if (add_file_to_index(&the_index, path, data->flags)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die("updating files failed");
+					die(_("updating files failed"));
 				data->add_errors++;
 			}
 			break;
@@ -172,7 +172,7 @@ static void treat_gitlinks(const char **pathspec)
 					/* strip trailing slash */
 					pathspec[j] =3D xstrndup(ce->name, len);
 				else
-					die ("Path '%s' is in submodule '%.*s'",
+					die (_("Path '%s' is in submodule '%.*s'"),
 						pathspec[j], len, ce->name);
 			}
 		}
@@ -191,7 +191,7 @@ static void refresh(int verbose, const char **paths=
pec)
 		      pathspec, seen, "Unstaged changes after refreshing the index:"=
);
 	for (i =3D 0; i < specs; i++) {
 		if (!seen[i])
-			die("pathspec '%s' did not match any files", pathspec[i]);
+			die(_("pathspec '%s' did not match any files"), pathspec[i]);
 	}
         free(seen);
 }
@@ -205,7 +205,7 @@ static const char **validate_pathspec(int argc, con=
st char **argv, const char *p
 		for (p =3D pathspec; *p; p++) {
 			if (has_symlink_leading_path(*p, strlen(*p))) {
 				int len =3D prefix ? strlen(prefix) : 0;
-				die("'%s' is beyond a symbolic link", *p + len);
+				die(_("'%s' is beyond a symbolic link"), *p + len);
 			}
 		}
 	}
@@ -272,7 +272,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
=20
 	if (read_cache() < 0)
-		die ("Could not read the index");
+		die (_("Could not read the index"));
=20
 	init_revisions(&rev, prefix);
 	rev.diffopt.context =3D 7;
@@ -281,24 +281,24 @@ static int edit_patch(int argc, const char **argv=
, const char *prefix)
 	rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 	out =3D open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
-		die ("Could not open '%s' for writing.", file);
+		die (_("Could not open '%s' for writing."), file);
 	rev.diffopt.file =3D xfdopen(out, "w");
 	rev.diffopt.close_file =3D 1;
 	if (run_diff_files(&rev, 0))
-		die ("Could not write patch");
+		die (_("Could not write patch"));
=20
 	launch_editor(file, NULL, NULL);
=20
 	if (stat(file, &st))
-		die_errno("Could not stat '%s'", file);
+		die_errno(_("Could not stat '%s'"), file);
 	if (!st.st_size)
-		die("Empty patch. Aborted.");
+		die(_("Empty patch. Aborted."));
=20
 	memset(&child, 0, sizeof(child));
 	child.git_cmd =3D 1;
 	child.argv =3D apply_argv;
 	if (run_command(&child))
-		die ("Could not apply '%s'", file);
+		die (_("Could not apply '%s'"), file);
=20
 	unlink(file);
 	return 0;
@@ -354,7 +354,7 @@ static int add_files(struct dir_struct *dir, int fl=
ags)
 	for (i =3D 0; i < dir->nr; i++)
 		if (add_file_to_cache(dir->entries[i]->name, flags)) {
 			if (!ignore_add_errors)
-				die("adding files failed");
+				die(_("adding files failed"));
 			exit_status =3D 1;
 		}
 	return exit_status;
@@ -386,9 +386,9 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	argv++;
=20
 	if (addremove && take_worktree_changes)
-		die("-A and -u are mutually incompatible");
+		die(_("-A and -u are mutually incompatible"));
 	if (!show_only && ignore_missing)
-		die("Option --ignore-missing can only be used together with --dry-ru=
n");
+		die(_("Option --ignore-missing can only be used together with --dry-=
run"));
 	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] =3D { ".", NULL };
 		argc =3D 1;
@@ -408,14 +408,14 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
 		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
=20
 	if (require_pathspec && argc =3D=3D 0) {
-		fprintf(stderr, "Nothing specified, nothing added.\n");
-		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
+		fprintf(stderr, _("Nothing specified, nothing added.\n"));
+		fprintf(stderr, _("Maybe you wanted to say 'git add .'?\n"));
 		return 0;
 	}
 	pathspec =3D validate_pathspec(argc, argv, prefix);
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 	treat_gitlinks(pathspec);
=20
 	if (add_new_files) {
@@ -467,7 +467,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	return exit_status;
--=20
1.7.4.1
