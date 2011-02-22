From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 05/73] gettextize: git-init basic messages
Date: Tue, 22 Feb 2011 23:41:24 +0000
Message-ID: <1298418152-27789-6-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wo-0001H8-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab1BVXnr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:47 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab1BVXng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:36 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=v3ATAJeSLaxpJ1x8VZd2Iy2KIY8DLFOiLz7B3cXotpA=;
        b=Cz0dpS68r/THNWk8XH0KJTbMb+AdvZibdg5zchSVq+MBFC2VTey8xEfHlObVYjZJUN
         2eJsEHZHLK1qwzR86i9iLHYSSsab2sZ78sU23znX9ZCY2qlG3FrGl5DDRs0d4LuVWDKe
         Vc3zTbJ8rTomoL80gclBIbkwbyQkaN4mnl0Pg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=B7bwQzw5v418o/21yWAsRgJbdiagnua8MkaZqm1hkSyTxhg6KouQ+oZ9qIwPNPjYUK
         UABv02ZeouiMEnJy8glImf/sBs/igAxuB4uOrFmVZYqjU6P4+HMMKHTzQeFz0NdVSil2
         eZ5TRXURZV0V9byLE9CI8x8nqXcHpzIM6eafM=
Received: by 10.204.71.65 with SMTP id g1mr3038309bkj.178.1298418214938;
        Tue, 22 Feb 2011 15:43:34 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.33
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:34 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167641>

Change the user visible strings in init-db.c to use gettext
localizations. This only converts messages which needed to be changed
from "foo" to _("foo"), and didn't need any TRANSLATORS comments.

I haven't marked the messages in init_db_usage or init_db_options for
translation, since that would require additional changes in
parse-options.c. Those can be done later.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/init-db.c |   46 +++++++++++++++++++++++----------------------=
-
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4f5348e..f7ddf5b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -31,7 +31,7 @@ static void safe_create_dir(const char *dir, int shar=
e)
 		}
 	}
 	else if (share && adjust_shared_perm(dir))
-		die("Could not make %s writable by group", dir);
+		die(_("Could not make %s writable by group"), dir);
 }
=20
 static void copy_templates_1(char *path, int baselen,
@@ -58,25 +58,25 @@ static void copy_templates_1(char *path, int basele=
n,
 		namelen =3D strlen(de->d_name);
 		if ((PATH_MAX <=3D baselen + namelen) ||
 		    (PATH_MAX <=3D template_baselen + namelen))
-			die("insanely long template name %s", de->d_name);
+			die(_("insanely long template name %s"), de->d_name);
 		memcpy(path + baselen, de->d_name, namelen+1);
 		memcpy(template + template_baselen, de->d_name, namelen+1);
 		if (lstat(path, &st_git)) {
 			if (errno !=3D ENOENT)
-				die_errno("cannot stat '%s'", path);
+				die_errno(_("cannot stat '%s'"), path);
 		}
 		else
 			exists =3D 1;
=20
 		if (lstat(template, &st_template))
-			die_errno("cannot stat template '%s'", template);
+			die_errno(_("cannot stat template '%s'"), template);
=20
 		if (S_ISDIR(st_template.st_mode)) {
 			DIR *subdir =3D opendir(template);
 			int baselen_sub =3D baselen + namelen;
 			int template_baselen_sub =3D template_baselen + namelen;
 			if (!subdir)
-				die_errno("cannot opendir '%s'", template);
+				die_errno(_("cannot opendir '%s'"), template);
 			path[baselen_sub++] =3D
 				template[template_baselen_sub++] =3D '/';
 			path[baselen_sub] =3D
@@ -93,20 +93,20 @@ static void copy_templates_1(char *path, int basele=
n,
 			int len;
 			len =3D readlink(template, lnk, sizeof(lnk));
 			if (len < 0)
-				die_errno("cannot readlink '%s'", template);
+				die_errno(_("cannot readlink '%s'"), template);
 			if (sizeof(lnk) <=3D len)
-				die("insanely long symlink %s", template);
+				die(_("insanely long symlink %s"), template);
 			lnk[len] =3D 0;
 			if (symlink(lnk, path))
-				die_errno("cannot symlink '%s' '%s'", lnk, path);
+				die_errno(_("cannot symlink '%s' '%s'"), lnk, path);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
 			if (copy_file(path, template, st_template.st_mode))
-				die_errno("cannot copy '%s' to '%s'", template,
+				die_errno(_("cannot copy '%s' to '%s'"), template,
 					  path);
 		}
 		else
-			error("ignoring template %s", template);
+			error(_("ignoring template %s"), template);
 	}
 }
=20
@@ -129,7 +129,7 @@ static void copy_templates(const char *template_dir=
)
 		return;
 	template_len =3D strlen(template_dir);
 	if (PATH_MAX <=3D (template_len+strlen("/config")))
-		die("insanely long template path %s", template_dir);
+		die(_("insanely long template path %s"), template_dir);
 	strcpy(template_path, template_dir);
 	if (template_path[template_len-1] !=3D '/') {
 		template_path[template_len++] =3D '/';
@@ -137,7 +137,7 @@ static void copy_templates(const char *template_dir=
)
 	}
 	dir =3D opendir(template_path);
 	if (!dir) {
-		warning("templates not found %s", template_dir);
+		warning(_("templates not found %s"), template_dir);
 		return;
 	}
=20
@@ -150,8 +150,8 @@ static void copy_templates(const char *template_dir=
)
=20
 	if (repository_format_version &&
 	    repository_format_version !=3D GIT_REPO_VERSION) {
-		warning("not copying templates of "
-			"a wrong format version %d from '%s'",
+		warning(_("not copying templates of "
+			"a wrong format version %d from '%s'"),
 			repository_format_version,
 			template_dir);
 		closedir(dir);
@@ -188,7 +188,7 @@ static int create_default_files(const char *templat=
e_path)
 	int filemode;
=20
 	if (len > sizeof(path)-50)
-		die("insane git directory %s", git_dir);
+		die(_("insane git directory %s"), git_dir);
 	memcpy(path, git_dir, len);
=20
 	if (len && path[len-1] !=3D '/')
@@ -375,7 +375,7 @@ static int guess_repository_type(const char *git_di=
r)
 	if (!strcmp(".", git_dir))
 		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
-		die_errno("cannot tell cwd");
+		die_errno(_("cannot tell cwd"));
 	if (!strcmp(git_dir, cwd))
 		return 1;
 	/*
@@ -450,18 +450,18 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 					errno =3D EEXIST;
 					/* fallthru */
 				case -1:
-					die_errno("cannot mkdir %s", argv[0]);
+					die_errno(_("cannot mkdir %s"), argv[0]);
 					break;
 				default:
 					break;
 				}
 				shared_repository =3D saved;
 				if (mkdir(argv[0], 0777) < 0)
-					die_errno("cannot mkdir %s", argv[0]);
+					die_errno(_("cannot mkdir %s"), argv[0]);
 				mkdir_tried =3D 1;
 				goto retry;
 			}
-			die_errno("cannot chdir to %s", argv[0]);
+			die_errno(_("cannot chdir to %s"), argv[0]);
 		}
 	} else if (0 < argc) {
 		usage(init_db_usage[0]);
@@ -483,8 +483,8 @@ int cmd_init_db(int argc, const char **argv, const =
char *prefix)
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
 	work_tree =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	if ((!git_dir || is_bare_repository_cfg =3D=3D 1) && work_tree)
-		die("%s (or --work-tree=3D<directory>) not allowed without "
-		    "specifying %s (or --git-dir=3D<directory>)",
+		die(_("%s (or --work-tree=3D<directory>) not allowed without "
+			  "specifying %s (or --git-dir=3D<directory>)"),
 		    GIT_WORK_TREE_ENVIRONMENT,
 		    GIT_DIR_ENVIRONMENT);
=20
@@ -509,14 +509,14 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 		if (!git_work_tree_cfg) {
 			git_work_tree_cfg =3D xcalloc(PATH_MAX, 1);
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
-				die_errno ("Cannot access current working directory");
+				die_errno (_("Cannot access current working directory"));
 		}
 		if (work_tree)
 			set_git_work_tree(make_absolute_path(work_tree));
 		else
 			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
-			die_errno ("Cannot access work tree '%s'",
+			die_errno (_("Cannot access work tree '%s'"),
 				   get_git_work_tree());
 	}
 	else {
--=20
1.7.2.3
