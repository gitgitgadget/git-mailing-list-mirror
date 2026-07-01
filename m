Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20234C040A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929312; cv=none; b=K/QhIyeNZ7nfVcTPwKR9KLmmTGg6LmuxC1UJERw1LhuJDr6LI1JeMp8D09SBilUIoeqWMouKCAuSHnVsCWvgkK31GV1D6L4AnIcEDLPIJo/6gfNUMy1mq1Kw9u4OgGQTdKEeEcGnj6oYAFTndU3P5vu7h9PQTVWK967Q3pSxUvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929312; c=relaxed/simple;
	bh=Z7723L1WWJJxw5vmAEk4BmXPagPx4OZE/BpD0rI5Pls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS7nS+Oisz5PqY0LgApW3ubXHUIqLharMCRfQAC978N79C/PVxQqobEAn6c940otAZqjiiPE5jAsDJKLhM/0iXDVPUxkKpnbbc4amjW0rYayd+w4bW6Bjzjl9NmGIR2UX9+ir4pqdYngRH35hbSCeUjEXtYTggyy+SiKIv6lN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=PMwsokJv; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Og3q4/Ou; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="PMwsokJv";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Og3q4/Ou"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PMwsokJvBUksv7m8TgccAICKchG6fjKAoDiR6JYUzM6q3c1eIMGXRwBlI9yGh3T/YIrJdZu1q3FmyMnW7HHm3y8rff7BTdqG3cKOAieMzQgE+UTPX9xlvoBUPjOU3+0ueUWRLe/WjKXdp4vBL3/yJhRQgL8+Gvg8O+lN45sQZqc5azumRJIoIyI7KCOs7gzZ1Sv4cZFbJxY5oOyo9wANEE5oFFsShT5V1oT7w0s33H9RagTxSSrPe0G9xOvk+s9te9YgyPNo3nuJcQ3D/1rGI1FuVnniT0vD71WCfIQ1VOD2RZnqqFWpr+j8frXq2FuKCZxbGEgyRMggRLMdQGIsOg==; s=purelymail3; d=malon.dev; v=1; bh=Z7723L1WWJJxw5vmAEk4BmXPagPx4OZE/BpD0rI5Pls=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Og3q4/Oux3aatEhbdnuMOwx4n3rOJ3MB7VDpYCSwU766Z8xOP6lo4wh7YXJ5/B9idNdWIRssATGnpPzSQGWv5nKRuY/wGCkqoU1DsAG+2Y67AhGiWd8qAYRtzQn1+mxN0p5g1YwiaJv9S9bnTt+Xcxe1gezgJz2TDwK0rpIGGN5DZmhEQfb1SI2gqhYmv6n+oWocEIJLuDprLx27QYi3VmwMvOsowINf+K+i9gDVoUF5bHoDgvahdq3Re4Orbd4pFcjgN3d0LTqqZvSta8xYWl0MKIaf7d5s8+DehQfneoXQjvCNpQqqENOsfkfMnmR1LFT/fCzT9PpJjdFi/CahPg==; s=purelymail3; d=purelymail.com; v=1; bh=Z7723L1WWJJxw5vmAEk4BmXPagPx4OZE/BpD0rI5Pls=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 308788970;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 01 Jul 2026 18:08:22 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6 1/1] environment: move excludes_file into repo_config_values
Date: Thu,  2 Jul 2026 02:08:12 +0800
Message-ID: <20260701180813.776173-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701180813.776173-1-cat@malon.dev>
References: <20260630164401.2906091-1-cat@malon.dev>
 <20260701180813.776173-1-cat@malon.dev>
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
global ignore file. If this variable is NULL, 'setup_standard_excludes()'
in 'dir.c' forcefully evaluates and assigns the XDG default path to it.

Continue the libification effort by encapsulating this lazy-loading
fallback logic into a proper getter and moving the variable into
'struct repo_config_values'.

Since 'excludes_file' is a dynamically allocated string, it requires
proper heap memory management. Introduce repo_config_values_clear()
and wire it up in 'repo_clear()' to safely free this memory when a
repository instance is destroyed. Also clean up the heap-allocated
'attributes_file' in this new destructor while we are at it.

Note on transition:

Submodules are currently not supported by repo_config_values().
Since repo_clear() cleans up all repository instances (including
submodules), we must bypass them in repo_config_values_clear() to
prevent hitting the BUG() in repository.c:59. In the future when
submodules are supported, this check should be removed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         |  4 ++--
 environment.c | 33 ++++++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 45 insertions(+), 6 deletions(-)

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
index ba2c60103f..f1f859dd08 100644
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
@@ -726,3 +734,22 @@ void repo_config_values_init(struct repo_config_values=
 *cfg)
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
 =09cfg->warn_on_object_refname_ambiguity =3D 1;
 }
+
+void repo_config_values_clear(struct repository *repo)
+{
+=09struct repo_config_values *cfg;
+
+=09/*
+=09 * NEEDSWORK: Submodules are currently not supported by
+=09 * repo_config_values(). Since repo_clear() cleans up all
+=09 * repository instances (including submodules), we must bypass
+=09 * them here to prevent hitting the BUG() in repository.c:59.
+=09 */
+=09if (repo !=3D the_repository)
+=09=09return;
+
+=09cfg =3D repo_config_values(repo);
+
+=09FREE_AND_NULL(cfg->attributes_file);
+=09FREE_AND_NULL(cfg->excludes_file);
+}
diff --git a/environment.h b/environment.h
index 6f18286955..2e8352de7f 100644
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
@@ -133,8 +134,19 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+const char *repo_excludes_file(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
+/*
+ * Frees memory allocated for dynamically loaded configuration values
+ * inside `repo_config_values`.
+ *
+ * As dynamically allocated variables are migrated into this struct,
+ * their FREE_AND_NULL() calls should be appended here.
+ */
+void repo_config_values_clear(struct repository *repo);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
@@ -208,7 +220,6 @@ extern char *git_log_output_encoding;
=20
 extern char *editor_program;
 extern char *askpass_program;
-extern char *excludes_file;
=20
 /*
  * The character that begins a commented line in user-editable file
diff --git a/repository.c b/repository.c
index 187dd471c4..b31f1b7852 100644
--- a/repository.c
+++ b/repository.c
@@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
 =09FREE_AND_NULL(repo->parsed_objects);
=20
 =09repo_settings_clear(repo);
+=09repo_config_values_clear(repo);
=20
 =09if (repo->config) {
 =09=09git_configset_clear(repo->config);
--=20
2.43.0

