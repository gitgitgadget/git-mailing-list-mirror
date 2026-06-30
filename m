Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324313D6682
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837861; cv=none; b=jWIX3oGZoZfgAAur98ClNLOOIY46A1uT9JA2BLMnXm2w1uIMyWLjwlANQ0mcldDPfkZ74pyEwArYKDS6RoOP+rBfVaSRFOJwSe/u7rK51U4wjSzClKHs2LWTccoqdHCM+wnV+QdvqC/SpoQNVza/tKLowEeBNbleteOP43sUbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837861; c=relaxed/simple;
	bh=P0ws+3uNC52QLA6NoTsWjyRW/ZbpOLjIKVyKTROyBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fboxUI6+P8T9SfNLQo/DGwMuWfA9NIE7jn+PWhhR5OJ+FVDZzAu8DwHzDGkOLVkCKZvHDI5uPFQqENkjteThW+UME+wIGY3lHs/k52ce14shE3kFXlu+SAQENKBkVYjxNUaNhz+iZYz3dezVFHArTSlvTkTROddOHlJOk3Camc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=e+K5st3A; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YRtCiwVh; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="e+K5st3A";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YRtCiwVh"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=e+K5st3AX/wd0EfhkGZxj9DW1M6toaDBVlSBfXgKgiQPt6hMJq3D6ATTv9xR8j+2xR0YXDrjT3ZDpLga9XwfTSOU9fpO96VWtJoIFkUOoalspVsCc6BpWMbZ/WeHDhtCfUO0O6QL4TonMGnpCfDmkq2TJmIgF3A8TsKg5IKo2XXcomPx9bGF49N9KQFsKnE9e2geaowXs7nFCEWtQAUng+0L2LObR/ATUCvWQ8ivSeb+nUJC9QVM+rrFzPxUI/0VFempkisygoKr9COoFcBScwxTFWepvJpxqv1nLoMOPbwIrK/Nj7kgJG3FsPoThreoYu9/tKW2/DDGe3sVBMgyrw==; s=purelymail2; d=malon.dev; v=1; bh=P0ws+3uNC52QLA6NoTsWjyRW/ZbpOLjIKVyKTROyBzI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YRtCiwVhHoatlEGPu+LL3ID1X/seUZ9SkCACF2/soM6AR9El+FyOLNqRXPHQOZ6J//zSTe7avMJ4Ij/RQ+U93CUH5e+jExuvr+xfNqf0XLtOw1faV2zFNS5nW/pBmPUYna8VHlsm97O6nYH+8qMYUKOrtrOU0gKDpX7RwE6vlTkIwvrUs1XUHtWIsX/zRK+xcWaVgExpBF/EHBK5+IdxNdiRdjPUsPm0qx/LMkLtrUAvsu8/2cmyaGZ9VnW5oyGZ3OcSkQoXoAUz9Pi0QyF9vcvBK7Q9P8Q3zT4ZmH9gmORIXkkhVKQGhqMunxQsAmMLQtTspAakXtX5032a2oIyZQ==; s=purelymail2; d=purelymail.com; v=1; bh=P0ws+3uNC52QLA6NoTsWjyRW/ZbpOLjIKVyKTROyBzI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1862105654;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 30 Jun 2026 16:44:18 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
	szeder.dev@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 1/1] environment: move excludes_file into repo_config_values
Date: Wed,  1 Jul 2026 00:44:01 +0800
Message-ID: <20260630164401.2906091-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630164401.2906091-1-cat@malon.dev>
References: <20260627160813.1074201-1-cat@malon.dev>
 <20260630164401.2906091-1-cat@malon.dev>
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

Defensive checks are temporarily retained in both the getter (returning
NULL if uninitialized) and the destructor (bypassing non-the_repository
instances) to maintain bug-to-bug compatibility. These are marked with
NEEDSWORK comments. Future work will track down and fix the offending
callers to eventually replace these shields with stricter BUG()
assertions.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 dir.c         |  4 ++--
 environment.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 environment.h | 13 ++++++++++++-
 repository.c  |  1 +
 4 files changed, 55 insertions(+), 6 deletions(-)

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
index ba2c60103f..5fc13d47c2 100644
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
@@ -134,6 +133,24 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+const char *repo_excludes_file(struct repository *repo)
+{
+=09/*
+=09 * NEEDSWORK: This is a temporary shield to maintain bug-to-bug
+=09 * compatibility during the libification transition.
+=09 *
+=09 * Once offending callers are properly fixed, this check should
+=09 * be upgraded to a BUG() assertion and eventually removed entirely.
+=09 */
+=09if (!repo || !repo->initialized)
+=09=09return NULL;
+
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
@@ -461,8 +478,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -715,6 +732,7 @@ int git_default_config(const char *var, const char *val=
ue,
 void repo_config_values_init(struct repo_config_values *cfg)
 {
 =09cfg->attributes_file =3D NULL;
+=09cfg->excludes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 =09cfg->trust_ctime =3D 1;
@@ -726,3 +744,22 @@ void repo_config_values_init(struct repo_config_values=
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
+=09 * NEEDSWORK: Temporary shield to prevent temporary/uninitialized
+=09 * submodules from triggering the BUG() at repository.c:59
+=09 * during repo_clear(). This should be removed once submodule
+=09 * lifecycle and per-repo config support are fully resolved.
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

