Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2553B2FD6
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087724; cv=none; b=CRTqEjSFGp/gmDBme2dVigVhOq9SEYS6bHbSJDqyl3P8ubw5XgvtyKe7Q64yoYAu+TxccHzYzJge0VQohU8H1hrbBtj+xIvcaWTu+b2Tal5zAuBWm090KThlxX+Zi0AHAKedShvlBQcDSXrgskmphMupCJrsEwFbYQLCx4p10dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087724; c=relaxed/simple;
	bh=RYq0duh3mjdbTJPuKspbUK9dZLWocWweootTd+tnu1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZqb7TChPRz6O+jxHmSrjKhbZLFnjrIwLfd4owAfthIa9uJuwDv+KENHxj+5aUU9us0hNnYNYxIFX0cdTUA6W1E3c6pNzKVhV94OWynS1PE1qkDXDWwipbvfKmVj8cuhyR/aKBKggLQY+ZpPudL1FXqGoqUXFx53M7Ino6lsbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=h7sbi2nl; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dg8xFxM3; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="h7sbi2nl";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dg8xFxM3"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=h7sbi2nlnqh9AFzGFbG9YpzkpJsEM2l6/q4xBc2fZDhSeaPOVTsRMCiyeuR4ZpwXCr50llgN4/4eP+Qo+vFGOu7Fd2Ed0GkjbSzyOy3ydhGvaDLmOaAMbZnzo44F+Hh/RXoL3y/HhQD0naDQhIRWaC5SZnR1brMUibGVB/bk6vVm6U2gr3RciNMlz1810z+5Zch0Ktfrrj46nbZvxc4l9lDoT36WWYbwSH/wvrR0apXOwnGI82dQc3YQ2S4OM+z5yv+7gTXqY3uFYZeD7FqWYyRP++K0s3A4tFXbjZh0Qq5+Wea/DBE2nXUtdxLvDbI4/0jzzbp3FxNUzP1ck5bVqQ==; s=purelymail1; d=malon.dev; v=1; bh=RYq0duh3mjdbTJPuKspbUK9dZLWocWweootTd+tnu1w=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dg8xFxM3vCkZv3SSA/Aqdod835o4r6ZWxxlMs7YBjOwhyZK9N4MOFbQkHa885bGd87VuPjUAzGmpbPKtQw1z/OiViZ2hX28nNP2/Ydm7U1Yfj8S3+kFTO0x9NpaImAhVHKwi5MqA2VEtN0BRvePpCHj7zLXdqItE1vVjTbGkj6Qo47E+iohVyFuikR5lbYmKK9Z+x7UO5MmV3oIstgF9+GsTLY+qso2rMFPyrgeoozrz/TmlbV1cM8ijcm3vONeiIJ34UJS07UKKy/YgIkDgb/aqYUPEAiof5OaJ/PIuG3KnSKGzR0yw1AeNKnBRqltc0KSGuBbsWJtSF80SWyg0fQ==; s=purelymail1; d=purelymail.com; v=1; bh=RYq0duh3mjdbTJPuKspbUK9dZLWocWweootTd+tnu1w=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1876003495;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 03:55:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	cirnovskyv@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v5 4/4] environment: move has_symlinks into repo_config_values
Date: Wed, 15 Jul 2026 11:55:01 +0800
Message-ID: <20260715035501.48271-5-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715035501.48271-1-cat@malon.dev>
References: <20260619162105.648495-1-cat@malon.dev>
 <20260715035501.48271-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'has_symlinks' configuration into the
repository-specific 'repo_config_values' struct.

To ensure code readability, the getter function
'repo_has_symlinks()' has been introduced. Callers access
this configuration by passing in 'repo' when possible,
and explicitly fall back to 'the_repository' the rest
of the time.

Note:
To support early platform-specific (MinGW) overrides
before repository initialization, a global variable
'default_has_symlinks' fallback is introduced as a fallback
in environment.h. The *writer* in compat/mingw.c can only
access this variable.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c        |  2 +-
 combine-diff.c |  2 +-
 compat/mingw.c |  7 ++++---
 entry.c        |  2 +-
 environment.c  | 17 +++++++++++++++--
 environment.h  |  5 ++++-
 read-cache.c   |  9 +++++----
 7 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/apply.c b/apply.c
index 47b6ae5904..4ce4160b48 100644
--- a/apply.c
+++ b/apply.c
@@ -4511,7 +4511,7 @@ static int try_create_file(struct apply_state *state,=
 const char *path,
 =09=09return !!mkdir(path, 0777);
 =09}
=20
-=09if (has_symlinks && S_ISLNK(mode))
+=09if (repo_has_symlinks(state->repo) && S_ISLNK(mode))
 =09=09/* Although buf:size is counted string, it also is NUL
 =09=09 * terminated.
 =09=09 */
diff --git a/combine-diff.c b/combine-diff.c
index b799862068..80e5c46e9b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1078,7 +1078,7 @@ static void show_patch_diff(struct combine_diff_path =
*elem, int num_parent,
 =09=09=09/* if symlinks don't work, assume symlink if all parents
 =09=09=09 * are symlinks
 =09=09=09 */
-=09=09=09is_file =3D has_symlinks;
+=09=09=09is_file =3D repo_has_symlinks(rev->repo);
 =09=09=09for (i =3D 0; !is_file && i < num_parent; i++)
 =09=09=09=09is_file =3D !S_ISLNK(elem->parent[i].mode);
 =09=09=09if (!is_file)
diff --git a/compat/mingw.c b/compat/mingw.c
index aa7525f419..b38cd9a1ec 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
+#include "repository.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "strbuf.h"
@@ -1043,7 +1044,7 @@ int mingw_chdir(const char *dirname)
 =09if (xutftowcs_path(wdirname, dirname) < 0)
 =09=09return -1;
=20
-=09if (has_symlinks) {
+=09if (repo_has_symlinks(the_repository)) {
 =09=09HANDLE hnd =3D CreateFileW(wdirname, 0,
 =09=09=09=09FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
 =09=09=09=09OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
@@ -2903,7 +2904,7 @@ int symlink(const char *target, const char *link)
 =09int len;
=20
 =09/* fail if symlinks are disabled or API is not supported (WinXP) */
-=09if (!has_symlinks) {
+=09if (!repo_has_symlinks(the_repository)) {
 =09=09errno =3D ENOSYS;
 =09=09return -1;
 =09}
@@ -3181,7 +3182,7 @@ static void setup_windows_environment(void)
 =09 * symlink support.
 =09 */
 =09if (!(tmp =3D getenv("MSYS")) || !strstr(tmp, "winsymlinks:nativestrict=
"))
-=09=09has_symlinks =3D 0;
+=09=09default_has_symlinks =3D 0;
 }
=20
 static void get_current_user_sid(PSID *sid, HANDLE *linked_token)
diff --git a/entry.c b/entry.c
index 7817aee362..f2854b4cd8 100644
--- a/entry.c
+++ b/entry.c
@@ -321,7 +321,7 @@ static int write_entry(struct cache_entry *ce, char *pa=
th, struct conv_attrs *ca
 =09=09 * We can't make a real symlink; write out a regular file entry
 =09=09 * with the symlink destination as its contents.
 =09=09 */
-=09=09if (!has_symlinks || to_tempfile)
+=09=09if (!repo_has_symlinks(state->istate ? state->istate->repo : NULL) |=
| to_tempfile)
 =09=09=09goto write_file_entry;
=20
 =09=09ret =3D symlink(new_blob, path);
diff --git a/environment.c b/environment.c
index 75069a884d..c7cebe18fd 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,7 @@ static int zlib_compression_seen;
=20
 int trust_ctime =3D 1;
 int check_stat =3D 1;
-int has_symlinks =3D 1;
+int default_has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D -1;
 int ignore_case;
 int assume_unchanged;
@@ -148,6 +148,17 @@ int repo_trust_executable_bit(struct repository *repo)
 =09=091;
 }
=20
+int repo_has_symlinks(struct repository *repo)
+{
+=09if (!repo)
+=09=09repo =3D the_repository;
+
+=09if (!repo->gitdir)
+=09=09return default_has_symlinks;
+
+=09return repo_config_values(repo)->has_symlinks;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -336,7 +347,8 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.symlinks")) {
-=09=09has_symlinks =3D git_config_bool(var, value);
+=09=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
+=09=09cfg->has_symlinks =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
@@ -727,5 +739,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->trust_executable_bit =3D 1;
+=09cfg->has_symlinks =3D default_has_symlinks;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 72b59fd89c..e590225c86 100644
--- a/environment.h
+++ b/environment.h
@@ -92,6 +92,7 @@ struct repo_config_values {
 =09char *attributes_file;
 =09int apply_sparse_checkout;
 =09int trust_executable_bit;
+=09int has_symlinks;
=20
 =09/* section "branch" config values */
 =09enum branch_track branch_track;
@@ -126,6 +127,8 @@ int git_default_core_config(const char *var, const char=
 *value,
=20
 int repo_trust_executable_bit(struct repository *repo);
=20
+int repo_has_symlinks(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -165,7 +168,7 @@ extern char *git_work_tree_cfg;
 /* Environment bits from configuration mechanism */
 extern int trust_ctime;
 extern int check_stat;
-extern int has_symlinks;
+extern int default_has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
diff --git a/read-cache.c b/read-cache.c
index a9c11a3346..5a40ffa061 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -211,7 +211,7 @@ void fill_stat_cache_info(struct index_state *istate, s=
truct cache_entry *ce, st
  */
 unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int =
mode)
 {
-=09if (!has_symlinks && S_ISREG(mode) &&
+=09if (!repo_has_symlinks(the_repository) && S_ISREG(mode) &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
 =09if (!repo_trust_executable_bit(the_repository) && S_ISREG(mode)) {
@@ -226,7 +226,7 @@ static unsigned int st_mode_from_ce(const struct cache_=
entry *ce)
 {
 =09switch (ce->ce_mode & S_IFMT) {
 =09case S_IFLNK:
-=09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
+=09=09return repo_has_symlinks(the_repository) ? S_IFLNK : (S_IFREG | 0644=
);
 =09case S_IFREG:
 =09=09return (ce->ce_mode & (repo_trust_executable_bit(the_repository) ? 0=
755 : 0644)) | S_IFREG;
 =09case S_IFGITLINK:
@@ -344,7 +344,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
 =09=09break;
 =09case S_IFLNK:
 =09=09if (!S_ISLNK(st->st_mode) &&
-=09=09    (has_symlinks || !S_ISREG(st->st_mode)))
+=09=09    (repo_has_symlinks(the_repository) || !S_ISREG(st->st_mode)))
 =09=09=09changed |=3D TYPE_CHANGED;
 =09=09break;
 =09case S_IFGITLINK:
@@ -759,7 +759,8 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09ce->ce_flags |=3D CE_INTENT_TO_ADD;
=20
=20
-=09if (repo_trust_executable_bit(istate->repo) && has_symlinks) {
+=09if (repo_trust_executable_bit(istate->repo) &&
+=09    repo_has_symlinks(istate->repo)) {
 =09=09ce->ce_mode =3D create_ce_mode(st_mode);
 =09} else {
 =09=09/* If there is an existing entry, pick the mode bits and type
--=20
2.43.0

