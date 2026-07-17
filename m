Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCC3271FD
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270190; cv=none; b=KNwcGQ+uS7rYbJlvpoemDrTWrvlqzsAmFPZ/PWiSchsRVhP/lmh+FGCYEUrLEJzcUOTco2ik9wsQ2yeHcFidTi9t62RXDfvH5LTUe2RL8dk1wk75M3OV7HXPG9lhayz0sEfwXHsqtEUtEXVqjhLGGRxxTjOz9Xk/4aOhWHFCdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270190; c=relaxed/simple;
	bh=utQRayV9PqYtqX+JdmGuVYZuMc+Lk7EqMU8KU3odwnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZimvWwlyuvCmj+a3WWZKB/S2PubDhjaQAsWcrBgelMmC0XThJXSYuOI43eCg81vDAtMe2UUux4N+OEDV3hzRA3blhnBlPyVUBdLQp2cWoPFxRwhJ3KEB/gLDaZ8+uPSn9alwYy1SKMcxSH0DwI9xK9yB+Y0prT9FfvwCfQMc1go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=jTsiAwtY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=kLvobow9; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="jTsiAwtY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="kLvobow9"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=jTsiAwtY0663xiW+jfw7abKuu7pxrQfG8CcXPOAElVb4a84V0RzdCIOb4NvrLoJxV26gtNVnX8fL9ETb56LfB+fMKhifbBds8OCU6GIp/YE2FefaiQrva2NP2FXvD5xeyWOEXg9FmjU1Xf5IluUGQ0irHv6D38lIv5UiP7qpzrjlRq5byD8gn8ZtFL2WEG8imkcm1O0cO5VPM8UHw6Vk6/JNWcyiLKwnVgJlXLwefnflplwnhcBVT0yqQ5s4KNQNt+RxkO8B1LlyPwsFZ4c2U/lJm+3blQoPbzYRcrOCeg5ZpAsV+XS3L26O8LXhhrr+2G4/SZykzC5YN13jsSKhhA==; s=purelymail2; d=malon.dev; v=1; bh=utQRayV9PqYtqX+JdmGuVYZuMc+Lk7EqMU8KU3odwnY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=kLvobow9VfYif/CmqC3TF+d9pso0F460QwkvpbxlS0XIUNOwyhM5V2B6ptLQRnTffFNFgK9SLuLhnErXLAaTF/zwU4JA5LwLNYWopa9RfidkxU5yl3Cj6eaxI+trrXZenD7oU2O1WR4ywYg/BG6XXZI3AVLBzBWDnPNJKiGTcDzDYHEeMETLK7ATkIs30hloJwDDNslnDY8LPCID0KSBx4VsDDnWZXkZUGEw5+V6Bu+iV9JC4EJw01Jj5+2TW0dRO6vVzAaN6EJ58V21GdKPU49RlZLP7xMXwp+ha6YIJ1M405ZJKNaJFdEQ44wH+ByeGlahEv7HW/DuVZyLJFY6Vg==; s=purelymail2; d=purelymail.com; v=1; bh=utQRayV9PqYtqX+JdmGuVYZuMc+Lk7EqMU8KU3odwnY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 894201780;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 17 Jul 2026 06:36:26 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v7 4/4] environment: move has_symlinks into repo_config_values
Date: Fri, 17 Jul 2026 14:35:59 +0800
Message-ID: <20260717063559.1633567-5-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717063559.1633567-1-cat@malon.dev>
References: <20260716084941.1101918-1-cat@malon.dev>
 <20260717063559.1633567-1-cat@malon.dev>
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

Introduce 'repo_has_symlinks()' getter for readability.
Callers access this configuration by passing in 'repo'
when possible, and explicitly fall back to
'the_repository' the rest of the time.

Introduce 'platform_has_symlinks()' macro to allow
platform specific-customization, primarily to help MinGW.
Platforms can override this in their respective headers.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c           |  2 +-
 combine-diff.c    |  2 +-
 compat/mingw.c    | 17 +++++++++++++----
 compat/mingw.h    |  3 +++
 entry.c           |  2 +-
 environment.c     | 16 ++++++++++++++--
 environment.h     |  4 +++-
 git-compat-util.h |  4 ++++
 read-cache.c      |  7 ++++---
 read-cache.h      |  3 +--
 10 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/apply.c b/apply.c
index edb1502414..b748192ee2 100644
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
index aa7525f419..4781911929 100644
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
@@ -3173,15 +3174,23 @@ static void setup_windows_environment(void)
 =09=09if (!tmp && (tmp =3D getenv("USERPROFILE")))
 =09=09=09setenv("HOME", tmp, 1);
 =09}
+}
=20
+int mingw_platform_has_symlinks(void)
+{
+=09static int has_symlinks =3D -1;
 =09/*
 =09 * Change 'core.symlinks' default to false, unless native symlinks are
 =09 * enabled in MSys2 (via 'MSYS=3Dwinsymlinks:nativestrict'). Thus we ca=
n
 =09 * run the test suite (which doesn't obey config files) with or without
 =09 * symlink support.
 =09 */
-=09if (!(tmp =3D getenv("MSYS")) || !strstr(tmp, "winsymlinks:nativestrict=
"))
-=09=09has_symlinks =3D 0;
+=09if (has_symlinks < 0) {
+=09=09const char *tmp =3D getenv("MSYS");
+=09=09has_symlinks =3D (tmp && strstr(tmp, "winsymlinks:nativestrict")) ? =
1 : 0;
+=09}
+
+=09return has_symlinks;
 }
=20
 static void get_current_user_sid(PSID *sid, HANDLE *linked_token)
diff --git a/compat/mingw.h b/compat/mingw.h
index 444daedfa5..df02aeb632 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -208,6 +208,9 @@ void open_in_gdb(void);
  */
 int err_win_to_posix(DWORD winerr);
=20
+int mingw_platform_has_symlinks(void);
+#define platform_has_symlinks() mingw_platform_has_symlinks()
+
 #ifndef NO_UNIX_SOCKETS
 int mingw_have_unix_sockets(void);
 #undef have_unix_sockets
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
index 75069a884d..760689d6e7 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,6 @@ static int zlib_compression_seen;
=20
 int trust_ctime =3D 1;
 int check_stat =3D 1;
-int has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D -1;
 int ignore_case;
 int assume_unchanged;
@@ -148,6 +147,17 @@ int repo_trust_executable_bit(struct repository *repo)
 =09=091;
 }
=20
+int repo_has_symlinks(struct repository *repo)
+{
+=09if (!repo)
+=09=09repo =3D the_repository;
+
+=09if (!repo->gitdir)
+=09=09return platform_has_symlinks();
+
+=09return repo_config_values(repo)->has_symlinks;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -336,7 +346,8 @@ int git_default_core_config(const char *var, const char=
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
@@ -727,5 +738,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
 =09cfg->trust_executable_bit =3D 1;
+=09cfg->has_symlinks =3D platform_has_symlinks();
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 72b59fd89c..ef64a783b0 100644
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
@@ -165,7 +168,6 @@ extern char *git_work_tree_cfg;
 /* Environment bits from configuration mechanism */
 extern int trust_ctime;
 extern int check_stat;
-extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
diff --git a/git-compat-util.h b/git-compat-util.h
index 5024814bd4..333a5acf33 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -245,6 +245,10 @@ static inline int git_is_dir_sep(int c)
 #define is_dir_sep git_is_dir_sep
 #endif
=20
+#ifndef platform_has_symlinks
+#define platform_has_symlinks() 1
+#endif
+
 #ifndef offset_1st_component
 static inline int git_offset_1st_component(const char *path)
 {
diff --git a/read-cache.c b/read-cache.c
index 1f8b5ed15f..c2c3c2e6cc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -206,7 +206,7 @@ static unsigned int st_mode_from_ce(const struct cache_=
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
@@ -324,7 +324,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
 =09=09break;
 =09case S_IFLNK:
 =09=09if (!S_ISLNK(st->st_mode) &&
-=09=09    (has_symlinks || !S_ISREG(st->st_mode)))
+=09=09    (repo_has_symlinks(the_repository) || !S_ISREG(st->st_mode)))
 =09=09=09changed |=3D TYPE_CHANGED;
 =09=09break;
 =09case S_IFGITLINK:
@@ -739,7 +739,8 @@ int add_to_index(struct index_state *istate, const char=
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
diff --git a/read-cache.h b/read-cache.h
index 4b54cfc57c..ab9d40aa81 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -17,8 +17,7 @@ static inline unsigned int ce_mode_from_stat(struct repos=
itory *repo,
 =09=09=09=09=09     const struct cache_entry *ce,
 =09=09=09=09=09     unsigned int mode)
 {
-=09extern int has_symlinks;
-=09if (S_ISREG(mode) && !has_symlinks &&
+=09if (S_ISREG(mode) && !repo_has_symlinks(repo) &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
 =09if (S_ISREG(mode) && !repo_trust_executable_bit(repo)) {
--=20
2.43.0

