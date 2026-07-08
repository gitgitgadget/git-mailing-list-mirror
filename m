Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7C373BFE
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526600; cv=none; b=fjHBDbodhNgCMezYRQwpcZGxp/R2dui2jwcKO1AxgYi99GiIaWflzZvbMXYts9R+BTzi55hYzK3a5M6d6GdwY+fNAL3TYa6RMxP2eITwBsY7/vOIZfaXX23ghscyXYZ+viPUFHfslcaqad12X1dMOfZn2nWDRWWP/grhb4PIc4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526600; c=relaxed/simple;
	bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMjqab2ehn55OvbgyPyCAU2ZzbUBr5osRyj1qW2lZrgQeXBXeLV9D/LVY3kUXMyJQjEXXJQz/E+Q8ACpDNDg2SZXNSMdLv9uSzn4WTFtb0mUo3/YZ152hmZVYUDU1fx7KDzAbeZg43m/nOXf6PG9GCCncNObln2cUrd35rDPxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Xm9nm7bu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=J/9SkSMi; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Xm9nm7bu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="J/9SkSMi"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Xm9nm7bu24UGHDfxKp0YnTik8b573a10xIdtbZpCSG6Z6C2ukEsxhFKCaIwf++y0DsOdhjaCfD1jnLOZeZg23FtPR9MxrPtCirc151rsJ6fP6PwJNZTkuVVG0PeXOqBxfFl+C5n1zDRfGjYZrEMZKe1sUm7A3QQB3gJi++tasKo9yBON5FqkLmdOkotY0QldmunfZXQP36AlGKCxHY3Xy0z9QSj3NRlX6IubrMgsIpApX7nmZ4ux/bi3grZHYIOvNZ0ee/loyiFra410pMGy8G8Y+cxUY+fnGqSZ3UsgCj1Jt+Kfl5FDp/VxEAfHmHBLGjXem+yr3pRIyMhN5Crnww==; s=purelymail3; d=malon.dev; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=J/9SkSMi8rvoUmXYB0xwrIJ3QeyEh2XHku9RPqvUv8wcKatkuNoaLCTeYAjP3INexdZ4K9H/kop8SnceUfBmWinLXsCqTHP3qA/AdmnGw5LYAOr6+3QePZIOAW4p7gcBd24SvTS8wOlKF4lvcmVFvUnLFrXrMJaL9/lUQHx0hKxLOFFGOnw9xRudqBhSXZCLkDPpSTIGgHCIcgpxx4fst7xvto2W1Wl0OQ11jec86wg7THgc0JyUUQw47XctYJBpES6WmiSlH65OH813/KGngR5u6f9AmB9oWx0and2DreK5F5M/1Jdqkteif0BOQM9bEdRenLzCgvj+UGI+1UJQhQ==; s=purelymail3; d=purelymail.com; v=1; bh=NnKM/xeaUHlX759Ewg0zSxvU0e4ZZqvAcStzYuWUBd8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -238025841;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 08 Jul 2026 16:03:16 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 2/9] environment: move excludes_file into repo_config_values
Date: Thu,  9 Jul 2026 00:02:53 +0800
Message-ID: <20260708160300.8852-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708160300.8852-1-cat@malon.dev>
References: <20260706142530.3681520-1-cat@malon.dev>
 <20260708160300.8852-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'excludes_file' is used to track the path to the
global ignore file. If this variable is NULL,
'setup_standard_excludes()'
in 'dir.c' forcefully evaluates and assigns the XDG default path to it.

Continue the libification effort by encapsulating this lazy-loading
fallback logic into a proper getter and moving the variable into
'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string, it requires
proper heap memory management. It is safely freed using the newly
introduced `repo_config_values_clear()` function when the repository
is torn down.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         |  4 ++--
 environment.c | 15 ++++++++++++---
 environment.h |  4 +++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 7a73690fbc..4f87a52b3c 100644
--- a/dir.c
+++ b/dir.c
@@ -3481,11 +3481,11 @@ static GIT_PATH_FUNC(git_path_info_exclude, "info/e=
xclude")
=20
 void setup_standard_excludes(struct dir_struct *dir)
 {
+=09const char *excludes_file =3D repo_excludes_file(the_repository);
+
 =09dir->exclude_per_dir =3D ".gitignore";
=20
 =09/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
-=09if (!excludes_file)
-=09=09excludes_file =3D xdg_config_home("ignore");
 =09if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
 =09=09add_patterns_from_file_1(dir, excludes_file,
 =09=09=09=09=09 dir->untracked ? &dir->internal.ss_excludes_file : NULL);
diff --git a/environment.c b/environment.c
index 13677484de..5950592d63 100644
--- a/environment.c
+++ b/environment.c
@@ -57,7 +57,6 @@ enum fsync_method fsync_method =3D FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components =3D FSYNC_COMPONENTS_DEFAULT;
 char *editor_program;
 char *askpass_program;
-char *excludes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
@@ -134,6 +133,14 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+const char *repo_excludes_file(struct repository *repo)
+{
+=09if (!repo_config_values(repo)->excludes_file)
+=09=09repo_config_values(repo)->excludes_file =3D xdg_config_home("ignore"=
);
+
+=09return repo_config_values(repo)->excludes_file;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -461,8 +468,8 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.excludesfile")) {
-=09=09FREE_AND_NULL(excludes_file);
-=09=09return git_config_pathname(&excludes_file, var, value);
+=09=09FREE_AND_NULL(cfg->excludes_file);
+=09=09return git_config_pathname(&cfg->excludes_file, var, value);
 =09}
=20
 =09if (!strcmp(var, "core.whitespace")) {
@@ -715,6 +722,7 @@ int git_default_config(const char *var, const char *val=
ue,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 =09cfg->attributes_file =3D NULL;
+=09cfg->excludes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -744,4 +752,5 @@ void repo_config_values_clear(struct repository *repo)
 =09cfg =3D repo_config_values(repo);
=20
 =09FREE_AND_NULL(cfg->attributes_file);
+=09FREE_AND_NULL(cfg->excludes_file);
 }
diff --git a/environment.h b/environment.h
index c4a6a45704..2e8352de7f 100644
--- a/environment.h
+++ b/environment.h
@@ -90,6 +90,7 @@ struct repository;
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
+=09char *excludes_file;
 =09int apply_sparse_checkout;
 =09int trust_ctime;
 =09int check_stat;
@@ -133,6 +134,8 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+const char *repo_excludes_file(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -217,7 +220,6 @@ extern char *git_log_output_encoding;
=20
 extern char *editor_program;
 extern char *askpass_program;
-extern char *excludes_file;
=20
 /*
  * The character that begins a commented line in user-editable file
--=20
2.43.0

