From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/6] worktree: new config file hierarchy
Date: Tue, 26 Jan 2016 18:44:43 +0700
Message-ID: <1453808685-21235-5-git-send-email-pclouds@gmail.com>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, max@max630.net,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 12:45:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO245-0005R5-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 12:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbcAZLpk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2016 06:45:40 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35466 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933850AbcAZLph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 06:45:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id q63so856135pfb.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=O/YNg+lJfm62KQQ1JOlFMQsUfdrzLTUb/CTZAi18HVI=;
        b=hsVddzSY9Hd58DOjvmdXDksAoI4+u3ti4cUuieMJM0Xq/LQ2LS6whO4HSZSI41CIWc
         TtilcQUFezwSLQ6ltmHiQvcWfwFAefPcENfdep9p3nefJpj2c6MeYgwCwIpWHsMuFpeb
         lC62gZk/Yo0cPhrOfGw5+pH8dSiuVhTIcgvHvi3w9d0qjwVd9wsIKWbfltmg4HTZvs8V
         U4mB09ztl8HZXbffqy/1dip4MiPLryGLin1cXvwWYG4AAytYEPQZ5CB4bFCjcy1Aon3d
         tu3gweIKbQo8TQqdvt1UfJBocXveeNFYIFmg6/UXlaVjaNQS9k+4pYZkiuubOzReN2BE
         RspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=O/YNg+lJfm62KQQ1JOlFMQsUfdrzLTUb/CTZAi18HVI=;
        b=e3ND0y1yKyjZ1XEU+GvPGVwnEnX7ucdSesFm2GcXOnOCXrozj932voIjIh+Ln/THOl
         Dw4xHREbYF4q1sHKc942SQvc4bgYX1RP0xvkHo2v4dV6VfVbn8p8WjA+FAJ4Ef0ynctX
         1mh5PIgJf8+8ivU2wINwjF9e5nxBIALMoPUKHaSbwxPeaUt2JR3YNJs7C9wVpYYgwldP
         I4vCqgquDVS1XTAQlhhtsu8FMk3OxTwQTvIbJg4RwakpbePP8PPshWM45MvtrYNGc+DG
         WtEwSrRuQmebRxs6mtlP+mjqwf/xXiP2R5bkUVmFIYnkDEPgl9WgxpmrAC4WQsnkPnj3
         oprQ==
X-Gm-Message-State: AG10YOSHGe3vPiMO3AjFqbzBNRfNKRW9vmsJFh7feVABmH6KblK8FjEf1x00UKjk39XFUQ==
X-Received: by 10.98.14.68 with SMTP id w65mr33529334pfi.146.1453808737569;
        Tue, 26 Jan 2016 03:45:37 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id 20sm1522363pfa.5.2016.01.26.03.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 03:45:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 26 Jan 2016 18:45:39 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
In-Reply-To: <1453808685-21235-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284807>

($C stands for $GIT_COMMON_DIR for the rest of the message)

In main worktree, we read these config files in this order:

1) system config
2) XDG config
3) user config
4) $GIT_DIR/config

Currently linked worktrees share the same config file at step 4 with
main worktree. The problem is, not all config variables can be
shared. We need per-repo vars and per-worktree ones.

With this patch, since worktree v1, the repo config file (or worktree
config file in multi worktree context) is no longer shared. Main
worktree reads $C/config.  Linked worktrees read $C/worktrees/xxx/confi=
g
and a new file, $C/worktrees/config. Sharing is done via this new
file. The read hierarchy for a worktree becomes

1) system config
2) XDG config
3) user config
4) $C/common/config
5) $C/worktrees/xxx/config (or $C/config for main worktree)

Compare to an alternative scheme where $C/config contains both shared
variables and main-worktree-only ones, this is a cleaner design.

* We do not have to check every single variable name to see if it's
  shared or per-worktree when reading config files.

* We do not enforce any particular variable split. If a variable
  is in $C/worktrees/config, it is shared. Putting core.worktree in
  $C/worktrees/config is punished the same way the variable is put in
  $HOME/.gitconfig, for example.

* We will provide a new "git config --repo" to access this new config
  file. In single-worktree context, or worktree v0, --repo is an alias
  of --local.

There is one problem though. We store worktree version in config file
and expect that all worktrees must share the same version (i.e. read
the same config file). But the share-ness of per-repo config files is
changed based on worktree version. Where do we put extensions.worktree
then?

Worktree version detection is tweaked a bit in this case. The presence
of $C/worktrees/config implies worktree version 1+. The lack of it
implies wortree version 0.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt               |  5 +++--
 Documentation/git-worktree.txt         |  8 ++++++-
 Documentation/gitrepository-layout.txt |  8 +++++++
 cache.h                                |  4 +++-
 config.c                               | 14 ++++++++++--
 path.c                                 |  1 -
 setup.c                                | 37 +++++++++++++++++++++++++-=
-----
 t/t2028-worktree-config.sh (new +x)    | 40 ++++++++++++++++++++++++++=
++++++++
 8 files changed, 103 insertions(+), 14 deletions(-)
 create mode 100755 t/t2028-worktree-config.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 07f7a3b..5009d98 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,8 +2,9 @@ CONFIGURATION FILE
 ------------------
=20
 The Git configuration file contains a number of variables that affect
-the Git commands' behavior. The `.git/config` file in each repository
-is used to store the configuration for that repository, and
+the Git commands' behavior. The files `.git/config` and
+`.git/common/config` (see linkgit:git-worktree.txt[1]) are each
+repository is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 048d7d6..0846f2a 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -111,7 +111,13 @@ WORKTREE VERSIONS AND MIGRATION
 Multiple worktree is still an experimental feature and evolving. Every
 time the behavior is changed, the "worktree version" is stepped
 up. Worktree version is stored as a configuration variable
-extensions.worktree.
+extensions.worktree. Latest version is one.
+
+Version 1
+~~~~~~~~~
+In this version, the repository config file `.git/config` is not
+shared anymore. A new file, `.git/common/config`, read for all
+worktrees. Shared configuration should be stored here.
=20
 Version 0
 ~~~~~~~~~
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index 771e362..d65345d 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -261,6 +261,11 @@ worktrees::
 	$GIT_COMMON_DIR is set, in which case
 	"$GIT_COMMON_DIR/worktrees" will be used instead.
=20
+common/config::
+	Repository specific configuration file. Note that if this file
+	is present, it must contain the variable extensions.worktree
+	whose value must be one or above.
+
 worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
 	that points to here. This is used to check if the linked
@@ -280,6 +285,9 @@ worktrees/<id>/link::
 	file. It is used to detect if the linked repository is
 	manually removed.
=20
+worktrees/<id>/config::
+	Working tree specific configuration file.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/cache.h b/cache.h
index e742c46..fa5e451 100644
--- a/cache.h
+++ b/cache.h
@@ -1497,7 +1497,9 @@ extern void git_config(config_fn_t fn, void *);
 extern int git_config_with_options(config_fn_t fn, void *,
 				   struct git_config_source *config_source,
 				   int respect_includes);
-extern int git_config_early(config_fn_t fn, void *, const char *repo_c=
onfig);
+extern int git_config_early(config_fn_t fn, void *,
+			    const char *repo_common_config,
+			    const char *repo_config);
 extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_parse_maybe_bool(const char *);
 extern int git_config_int(const char *, const char *);
diff --git a/config.c b/config.c
index 86a5eb2..a75926e 100644
--- a/config.c
+++ b/config.c
@@ -1184,7 +1184,9 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
-int git_config_early(config_fn_t fn, void *data, const char *repo_conf=
ig)
+int git_config_early(config_fn_t fn, void *data,
+		     const char *repo_common_config,
+		     const char *repo_config)
 {
 	int ret =3D 0, found =3D 0;
 	char *xdg_config =3D xdg_config_home("config");
@@ -1206,6 +1208,11 @@ int git_config_early(config_fn_t fn, void *data,=
 const char *repo_config)
 		found +=3D 1;
 	}
=20
+	if (repo_common_config && !access_or_die(repo_common_config, R_OK, 0)=
) {
+		ret +=3D git_config_from_file(fn, repo_common_config, data);
+		found +=3D 1;
+	}
+
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
 		ret +=3D git_config_from_file(fn, repo_config, data);
 		found +=3D 1;
@@ -1231,6 +1238,7 @@ int git_config_with_options(config_fn_t fn, void =
*data,
 			    struct git_config_source *config_source,
 			    int respect_includes)
 {
+	struct strbuf repo_common_config =3D STRBUF_INIT;
 	char *repo_config =3D NULL;
 	int ret;
 	struct config_include_data inc =3D CONFIG_INCLUDE_INIT;
@@ -1253,10 +1261,12 @@ int git_config_with_options(config_fn_t fn, voi=
d *data,
 	else if (config_source && config_source->blob)
 		return git_config_from_blob_ref(fn, config_source->blob, data);
=20
+	strbuf_addf(&repo_common_config, "%s/common/config", get_git_common_d=
ir());
 	repo_config =3D git_pathdup("config");
-	ret =3D git_config_early(fn, data, repo_config);
+	ret =3D git_config_early(fn, data, repo_common_config.buf, repo_confi=
g);
 	if (repo_config)
 		free(repo_config);
+	strbuf_release(&repo_common_config);
 	return ret;
 }
=20
diff --git a/path.c b/path.c
index 3b85968..aee9f59 100644
--- a/path.c
+++ b/path.c
@@ -140,7 +140,6 @@ static struct common_dir common_list_v1[] =3D {
 	{ 0, 1, 0, "worktrees" },
 	{ 0, 1, 0, "rr-cache" },
 	{ 0, 1, 0, "svn" },
-	{ 0, 0, 0, "config" },
 	{ 1, 0, 0, "gc.pid" },
 	{ 0, 0, 0, "packed-refs" },
 	{ 0, 0, 0, "shallow" },
diff --git a/setup.c b/setup.c
index 2f41648..7ca8ebe 100644
--- a/setup.c
+++ b/setup.c
@@ -385,18 +385,32 @@ static int check_repo_format(const char *var, con=
st char *value, void *cb)
 static int check_repository_format_gently(const char *gitdir, int *non=
git_ok)
 {
 	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf sb2 =3D STRBUF_INIT;
+	struct strbuf sb3 =3D STRBUF_INIT;
 	const char *repo_config;
+	const char *repo_common_config;
 	config_fn_t fn;
-	int ret =3D 0;
+	int ret =3D 0, has_common_dir;
=20
 	string_list_clear(&unknown_extensions, 0);
=20
-	if (get_common_dir(&sb, gitdir))
-		fn =3D check_repo_format;
-	else
+	has_common_dir =3D get_common_dir(&sb, gitdir);
+	strbuf_addf(&sb2, "%s/common/config", sb.buf);
+
+	if (access(sb2.buf, F_OK) =3D=3D -1) { /* worktree v0 */
+		if (has_common_dir)
+			fn =3D check_repo_format;
+		else
+			fn =3D check_repository_format_version;
+		strbuf_addf(&sb3, "%s/config", sb.buf);
+		repo_common_config =3D NULL;
+		repo_config =3D sb3.buf;
+	} else {
 		fn =3D check_repository_format_version;
-	strbuf_addstr(&sb, "/config");
-	repo_config =3D sb.buf;
+		strbuf_addf(&sb3, "%s/config", gitdir);
+		repo_common_config =3D sb2.buf;
+		repo_config =3D sb3.buf;
+	}
=20
 	/*
 	 * git_config() can't be used here because it calls git_pathdup()
@@ -407,7 +421,7 @@ static int check_repository_format_gently(const cha=
r *gitdir, int *nongit_ok)
 	 * Use a gentler version of git_config() to check if this repo
 	 * is a good one.
 	 */
-	git_config_early(fn, NULL, repo_config);
+	git_config_early(fn, NULL, repo_common_config, repo_config);
 	if (GIT_REPO_VERSION_READ < repository_format_version) {
 		if (!nongit_ok)
 			die ("Expected git repo version <=3D %d, found %d",
@@ -433,7 +447,16 @@ static int check_repository_format_gently(const ch=
ar *gitdir, int *nongit_ok)
 		ret =3D -1;
 	}
=20
+	if (repo_common_config && repository_format_worktree_version < 1)
+		die(_("worktree version must be one minimum in the presence of %s"),
+		    repo_common_config);
+	if (!repo_common_config && repository_format_worktree_version > 0)
+		die(_("worktree version must be zero if %s/common/config does not ex=
ist"),
+		    gitdir);
+
 	strbuf_release(&sb);
+	strbuf_release(&sb2);
+	strbuf_release(&sb3);
 	return ret;
 }
=20
diff --git a/t/t2028-worktree-config.sh b/t/t2028-worktree-config.sh
new file mode 100755
index 0000000..5561788
--- /dev/null
+++ b/t/t2028-worktree-config.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D"config file in multi worktree"
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit start &&
+	git worktree add wt1 &&
+	git worktree add wt2
+'
+
+test_expect_success 'main config is shared in version 0' '
+	git config -f .git/config wt.name main &&
+	git config wt.name >actual &&
+	echo main >expected &&
+	test_cmp expected actual &&
+	git -C wt1 config wt.name >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'main config is for main worktree only (v1)' '
+	mkdir .git/common &&
+	git config -f .git/common/config extensions.worktree 1 &&
+	git config wt.name >actual &&
+	echo main >expected &&
+	test_cmp expected actual &&
+	test_must_fail git -C wt1 config wt.name
+'
+
+test_expect_success 'worktrees/config is shared (v1)' '
+	git config -f .git/common/config some.thing is-shared &&
+	echo is-shared >expected &&
+	git config some.thing >actual &&
+	test_cmp expected actual &&
+	git -C wt1 config some.thing >actual &&
+	test_cmp expected actual
+'
+
+test_done
--=20
2.7.0.288.g1d8ad15
