From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/72] gettextize: git-init basic messages
Date: Sat, 19 Feb 2011 19:23:47 +0000
Message-ID: <1298143495-3681-5-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:25:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsR4-0001pR-91
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab1BSTZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:25:35 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42014 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab1BSTZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:25:31 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1969964ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=YFKdxJCXziobhIWwI3YtXfz64ZCCwQw9CMQsfdCVdN4=;
        b=vD/BUw0sIHysZf7r5xrpkq2jDE6apw9+S7Y4Lhf505AFJT/KlTKwiAKuTAywF38HOW
         cnFiG2ujG2Dm5yZ6eq2q0ZaTaJed2YBEe74yXYJD2OsGsAIsiKMlRzYf4Qz9xSAUjKrF
         GOpoPpq0wm59frd5yeF9y4URXmY10hOq1KdJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dyvzuZrUam2wFiL/nZOnzRPKmpEKMjllkWlgHozrwQY4gwVJYQB3OtjEiXz8Xk4tlL
         M1EuhmYyKCrIr56dKcEPMeyl9hrw6JZtKCklskf6vVwz5MycSyT8fM+znLd+9PbHcs9X
         Uo9pkGSjnoZf7qRMkQh0fuWppKfZYVX2J8kxE=
Received: by 10.213.30.3 with SMTP id s3mr2533411ebc.22.1298143529630;
        Sat, 19 Feb 2011 11:25:29 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.25.28
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:25:29 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167312>

Change the user visible strings in init-db.c to use gettext
localizations. This only converts messages which needed to be changed
from "foo" to _("foo"), and didn't need any TRANSLATORS comments.

I haven't marked the messages in init_db_usage or init_db_options for
translation, since that would require additional changes in
parse-options.c. Those can be done later.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/init-db.c |   48 ++++++++++++++++++++++++---------------------=
---
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 4f5348e..35f9f13 100644
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
@@ -346,7 +346,7 @@ int init_db(const char *template_dir, unsigned int =
flags)
 		else if (shared_repository =3D=3D PERM_EVERYBODY)
 			sprintf(buf, "%d", OLD_PERM_EVERYBODY);
 		else
-			die("oops");
+			die(_("oops"));
 		git_config_set("core.sharedrepository", buf);
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
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
