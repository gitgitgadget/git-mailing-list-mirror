Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923433B440F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887123; cv=none; b=exJxU0l4QjaWr1mK+IPB3Ui3DPZPmse4BOT5eS/N2rp/7SSLUETePc2twuN4AqCTuJNkB7JzFLq0MBB4cSqTfD/oAURKALMMBgINWyvkrQyhkq6fs/5U48QcC0HaRNFBHlEdTez1rI9neZs5yhlNWPYdpdsupi4iYfD/uWk1YxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887123; c=relaxed/simple;
	bh=IAwUTL4Kkov08AQ3rmPotjuBhStLPhDaAhNtpxCMir8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDWVZ89vZrFCpWdaTMZ6T+0xVkKRvl00DOWbWp097Sdli1lnEaAMTnp4kdpv6Dtxx4mxb/kYw8yE5G0rPQBcrMVTTk1ubQ687VlWixYnbAv9bOa3rCkCmZnVTEKHhfqJNLeIv9rjdoYu/1QfDmJA3olSgxhe5yGpqGNHEu/UVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=iKwKEZyd; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=eXAkO0aA; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="iKwKEZyd";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="eXAkO0aA"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=iKwKEZydYn3HNAoV0xyMZIAzOsHCTbXLApQR8ydt5joNIgutjdIl7dvT2/XEtOWfk67+Mb3Jq7OjJGhKFcynRvUkL4DxczR4iu5M1UqhjOl2LvAu/WInaFtoe0J6o8fRg55vqRazKJea07zWc0SLtNCux1fSXs9FE+QP8i9LYLfgx3BRyvXXML8F05/IRvuIB9/FNNRO/Q2o4FOUZBsEP5JE7atqjQS9IjarrQrHkgMJI7UHBSld9DK/lbnkB991r8DiZWFbiuFfvziPnfNSMmDpn1HmrX/uPKN0C1CDlP3TwErddbqidSI76rtl6G7EUxIR6gfjihRaigfgHrAs/Q==; s=purelymail1; d=malon.dev; v=1; bh=IAwUTL4Kkov08AQ3rmPotjuBhStLPhDaAhNtpxCMir8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=eXAkO0aAXgxUWvhKiXaqpUn+Bwh+fcB1Ys1JC6/i6gym5d7OrDlbdW6sJHTmO035iLinmTbi1N4bwmrpGJK8EUjfuYR38uXUzPQp91sjzPWtYnXWlBxpn7gVX8CUnGfOIcvWMJwvTwsqKAd7QT+wtXu513cq/EKIxI3tuobn7ckQzAirLrCh4A4Hbg87YtWzEfnL4Va/zRYEfGyU6679KwYDLkFRLcekz6SpUgS+PCnC0tBf92JGS4QafFae4Xblwx5aen26UxUsDizhI9bKRkwvtWa0C7QNakD+J0c2dg6lBTwaksg7yfGluF9NX3K2q14f9ACgiFi8yeW2oTxWPA==; s=purelymail1; d=purelymail.com; v=1; bh=IAwUTL4Kkov08AQ3rmPotjuBhStLPhDaAhNtpxCMir8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 474948874;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 19 Jun 2026 16:38:39 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v4 1/1] environment: move 'protect_hfs' and 'protect_ntfs' into 'repo_config_values'
Date: Sat, 20 Jun 2026 00:38:23 +0800
Message-ID: <20260619163823.652091-2-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619163823.652091-1-cat@malon.dev>
References: <20260619163823.652091-1-cat@malon.dev>
Reply-To: <20260613153302.168801-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'protect_hfs' and 'protect_ntfs' configurations
into the repository-specific 'repo_config_values' struct.
This will help with the elimination of 'the_repository'

To ensure code readability, the getter functions
'repo_protect_hfs()' and 'repo_protect_ntfs()'
have been introduced.

For now, associated functions access this configuration by
explicitly falling back to 'the_repository', which needs to
be addressed in the future.

Note: In 't/helper/test-path-utils.c', there is a function
'protect_ntfs_hfs_benchmark()' where these two global
variables are used as loop iterators. New local variables
have been created to replace them.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 compat/mingw.c             |  2 +-
 environment.c              | 22 ++++++++++++++++++----
 environment.h              | 12 ++++++++++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 24 +++++++++++++++---------
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index aa7525f419..af87df77fd 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3392,7 +3392,7 @@ int is_valid_win32_path(const char *path, int allow_l=
iteral_nul)
 =09const char *p =3D path;
 =09int preceding_space_or_period =3D 0, i =3D 0, periods =3D 0;
=20
-=09if (!protect_ntfs)
+=09if (!repo_protect_ntfs(the_repository))
 =09=09return 1;
=20
 =09skip_dos_drive_prefix((char **)&path);
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..f34f6fc750 100644
--- a/environment.c
+++ b/environment.c
@@ -82,12 +82,10 @@ unsigned long pack_size_limit_cfg;
 #ifndef PROTECT_HFS_DEFAULT
 #define PROTECT_HFS_DEFAULT 0
 #endif
-int protect_hfs =3D PROTECT_HFS_DEFAULT;
=20
 #ifndef PROTECT_NTFS_DEFAULT
 #define PROTECT_NTFS_DEFAULT 1
 #endif
-int protect_ntfs =3D PROTECT_NTFS_DEFAULT;
=20
 /*
  * The character that begins a commented line in user-editable file
@@ -142,6 +140,20 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+int repo_protect_ntfs(struct repository *repo)
+{
+=09return (repo && repo->initialized) ?
+=09=09repo_config_values(repo)->protect_ntfs :
+=09=09PROTECT_NTFS_DEFAULT;
+}
+
+int repo_protect_hfs(struct repository *repo)
+{
+=09return (repo && repo->initialized) ?
+=09=09repo_config_values(repo)->protect_hfs :
+=09=09PROTECT_HFS_DEFAULT;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -541,12 +553,12 @@ int git_default_core_config(const char *var, const ch=
ar *value,
 =09}
=20
 =09if (!strcmp(var, "core.protecthfs")) {
-=09=09protect_hfs =3D git_config_bool(var, value);
+=09=09cfg->protect_hfs =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
 =09if (!strcmp(var, "core.protectntfs")) {
-=09=09protect_ntfs =3D git_config_bool(var, value);
+=09=09cfg->protect_ntfs =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
@@ -720,5 +732,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
+=09cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 9eb97b3869..b1ae4a70de 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,8 @@ struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
 =09int apply_sparse_checkout;
+=09int protect_hfs;
+=09int protect_ntfs;
=20
 =09/* section "branch" config values */
 =09enum branch_track branch_track;
@@ -123,6 +125,14 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+/*
+ * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo=
_config_values`.
+ * They check `repo->initialized` to prevent calling `repo_config_values()=
`
+ * before the repository setup is fully complete or in non-git environment=
s.
+ */
+int repo_protect_hfs(struct repository *repo);
+int repo_protect_ntfs(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -173,8 +183,6 @@ extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
=20
 extern int precomposed_unicode;
-extern int protect_hfs;
-extern int protect_ntfs;
=20
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..2c6a60c756 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1002,7 +1002,7 @@ static enum verify_path_result verify_path_internal(c=
onst char *path,
 =09=09=09return PATH_OK;
 =09=09if (is_dir_sep(c)) {
 inside:
-=09=09=09if (protect_hfs) {
+=09=09=09if (repo_protect_hfs(the_repository)) {
=20
 =09=09=09=09if (is_hfs_dotgit(path))
 =09=09=09=09=09return PATH_INVALID;
@@ -1011,7 +1011,7 @@ static enum verify_path_result verify_path_internal(c=
onst char *path,
 =09=09=09=09=09=09return PATH_INVALID;
 =09=09=09=09}
 =09=09=09}
-=09=09=09if (protect_ntfs) {
+=09=09=09if (repo_protect_ntfs(the_repository)) {
 #if defined GIT_WINDOWS_NATIVE || defined __CYGWIN__
 =09=09=09=09if (c =3D=3D '\\')
 =09=09=09=09=09return PATH_INVALID;
@@ -1035,7 +1035,8 @@ static enum verify_path_result verify_path_internal(c=
onst char *path,
 =09=09=09if (c =3D=3D '\0')
 =09=09=09=09return S_ISDIR(mode) ? PATH_DIR_WITH_SEP :
 =09=09=09=09=09=09       PATH_INVALID;
-=09=09} else if (c =3D=3D '\\' && protect_ntfs) {
+=09=09} else if (c =3D=3D '\\' &&
+=09=09=09   repo_protect_ntfs(the_repository)) {
 =09=09=09if (is_ntfs_dotgit(path))
 =09=09=09=09return PATH_INVALID;
 =09=09=09if (S_ISLNK(mode)) {
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 15eb44485c..f77b3f9d70 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -250,6 +250,7 @@ static int protect_ntfs_hfs_benchmark(int argc, const c=
har **argv)
 =09double m[3][2], v[3][2];
 =09uint64_t cumul;
 =09double cumul2;
+=09int ntfs, hfs;
=20
 =09if (argc > 1 && !strcmp(argv[1], "--with-symlink-mode")) {
 =09=09file_mode =3D 0120000;
@@ -276,8 +277,13 @@ static int protect_ntfs_hfs_benchmark(int argc, const =
char **argv)
 =09=09=09names[i][--len] =3D (char)(' ' + (my_random() % ('\x7f' - ' ')));
 =09}
=20
-=09for (protect_ntfs =3D 0; protect_ntfs < 2; protect_ntfs++)
-=09=09for (protect_hfs =3D 0; protect_hfs < 2; protect_hfs++) {
+=09if (!the_repository->gitdir)
+=09=09the_repository->gitdir =3D xstrdup(".git");
+
+=09for (ntfs =3D 0; ntfs < 2; ntfs++)
+=09=09for (hfs =3D 0; hfs < 2; hfs++) {
+=09=09=09repo_config_values(the_repository)->protect_ntfs =3D ntfs;
+=09=09=09repo_config_values(the_repository)->protect_hfs =3D hfs;
 =09=09=09cumul =3D 0;
 =09=09=09cumul2 =3D 0;
 =09=09=09for (i =3D 0; i < repetitions; i++) {
@@ -285,18 +291,18 @@ static int protect_ntfs_hfs_benchmark(int argc, const=
 char **argv)
 =09=09=09=09for (j =3D 0; j < nr; j++)
 =09=09=09=09=09verify_path(names[j], file_mode);
 =09=09=09=09end =3D getnanotime();
-=09=09=09=09printf("protect_ntfs =3D %d, protect_hfs =3D %d: %lfms\n", pro=
tect_ntfs, protect_hfs, (end-begin) / (double)1e6);
+=09=09=09=09printf("protect_ntfs =3D %d, protect_hfs =3D %d: %lfms\n", ntf=
s, hfs, (end-begin) / (double)1e6);
 =09=09=09=09cumul +=3D end - begin;
 =09=09=09=09cumul2 +=3D (end - begin) * (end - begin);
 =09=09=09}
-=09=09=09m[protect_ntfs][protect_hfs] =3D cumul / (double)repetitions;
-=09=09=09v[protect_ntfs][protect_hfs] =3D my_sqrt(cumul2 / (double)repetit=
ions - m[protect_ntfs][protect_hfs] * m[protect_ntfs][protect_hfs]);
-=09=09=09printf("mean: %lfms, stddev: %lfms\n", m[protect_ntfs][protect_hf=
s] / (double)1e6, v[protect_ntfs][protect_hfs] / (double)1e6);
+=09=09=09m[ntfs][hfs] =3D cumul / (double)repetitions;
+=09=09=09v[ntfs][hfs] =3D my_sqrt(cumul2 / (double)repetitions - m[ntfs][h=
fs] * m[ntfs][hfs]);
+=09=09=09printf("mean: %lfms, stddev: %lfms\n", m[ntfs][hfs] / (double)1e6=
, v[ntfs][hfs] / (double)1e6);
 =09=09}
=20
-=09for (protect_ntfs =3D 0; protect_ntfs < 2; protect_ntfs++)
-=09=09for (protect_hfs =3D 0; protect_hfs < 2; protect_hfs++)
-=09=09=09printf("ntfs=3D%d/hfs=3D%d: %lf%% slower\n", protect_ntfs, protec=
t_hfs, (m[protect_ntfs][protect_hfs] - m[0][0]) * 100 / m[0][0]);
+=09for (ntfs =3D 0; ntfs < 2; ntfs++)
+=09=09for (hfs =3D 0; hfs < 2; hfs++)
+=09=09=09printf("ntfs=3D%d/hfs=3D%d: %lf%% slower\n", ntfs, hfs, (m[ntfs][=
hfs] - m[0][0]) * 100 / m[0][0]);
=20
 =09return 0;
 }
--=20
2.43.0

