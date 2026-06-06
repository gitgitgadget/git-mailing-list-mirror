Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA94071DB
	for <git@vger.kernel.org>; Sat,  6 Jun 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780756464; cv=none; b=L8zFsvvGXfq+5r4fc47na0yotO5JvLTOePmcIMPTdKdSZeASO5sy7/+Gm0AvY7e3c4eeinLr4PhaORgtMwIqZVwEvkVT+RlUvOMIMUsbqxzlWXpf5C0eMfioiuiqJsuoeUdWIcDaQySoUO1KyIA7idmcIUfqlWTS3LWhJx8LwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780756464; c=relaxed/simple;
	bh=ZUJq2ruJD1dCnI6J7sj6UUri0qeeFfLcm374J3Auo98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TUu5fJtTWTaeFNTyGvKiQPm9XxV7jLmBKRP+CqmdFO2Ef/Bxmv+TfP+E4g9qD/vmux2SvZuPyPY81mKUQ8B/vjLXN0FNh6Ny7OaIEdpRtQe4KNKBthBt9Y4dZbpTg5pi/6LohDy5bw68Z4yEZJV+jtSrrQxLMk52P8xjzfAhP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=sh4xx8Kh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=crUBNrKq; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="sh4xx8Kh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="crUBNrKq"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=sh4xx8KhjYVpX+akXiDE/8bOElbyEvg2+Q/M3utedaLd8NCqB+/Je3ikEZ0Zv5eqqp8Yc+59sqGAWnHvResTmrNlm78i9DSPl/1vD9b2y2Xyg9RYin7FXkrICFemTGEvYCFTDezzC71YClCzIFI756+phyD/5xldiThp+Pa8lnvNO+PdOxvNb9F4nFFGMNZny54mcjFwv0VEVvR7M0m7y7GWU0yVvRlCwNlxFbRr3WqsR+ujAkErF4IcEllt98SMJaGOTOfoj4a0NwmEtpb4V2i5/43oflVN019tUsV0RjONQPvFrz1C73wRrD2My6gpvetZSAaQKAGjKIaKweVdhA==; s=purelymail2; d=malon.dev; v=1; bh=ZUJq2ruJD1dCnI6J7sj6UUri0qeeFfLcm374J3Auo98=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=crUBNrKqt/tObbz6nWl9RMDoAdEgUJBdcmuGXho1xWMoEwvnQ5Kg6RA1nnLdXql07H+bYc6q0LY6TJv6OQp8wFqstGdl1TU/fzoFlaRWiv3MkRtrUgY7gFZfXweh5z/OGJJnBpPm7COl5kCCZYyfeqsWTTY0PQyrJP7ihoqRZL1o5ndB6iHmSpW3Ay4ZvHmz/SMxAQ+maRAIRcU+Hwjx1lVmxdqE2qjC64xj/BKA4Ybb8UTyPI6Qv4Q+UW1UUTz+reJ0jUkWWD3z47wiNgdk3dvm1s3Zp9xYxMLrGtR18JyNYME6UOyF+RJAXcKY6IfbER4dAbgjxvSiEhqoWZ5BVg==; s=purelymail2; d=purelymail.com; v=1; bh=ZUJq2ruJD1dCnI6J7sj6UUri0qeeFfLcm374J3Auo98=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1807185963;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 06 Jun 2026 14:34:20 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian@gitlab.com,
	phillip.wood123@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 1/1] environment.c: move 'protect_hfs' and 'protect_ntfs' into 'repo_config_values'
Date: Sat,  6 Jun 2026 22:34:11 +0800
Message-ID: <20260606143412.15443-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
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
 environment.c              |  8 ++++----
 environment.h              |  4 ++--
 read-cache.c               |  7 ++++---
 t/helper/test-path-utils.c | 26 ++++++++++++++++----------
 5 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index aa7525f419..c77696ba8a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3392,7 +3392,7 @@ int is_valid_win32_path(const char *path, int allow_l=
iteral_nul)
 =09const char *p =3D path;
 =09int preceding_space_or_period =3D 0, i =3D 0, periods =3D 0;
=20
-=09if (!protect_ntfs)
+=09if (!(the_repository->gitdir ? repo_config_values(the_repository)->prot=
ect_ntfs : 1))
 =09=09return 1;
=20
 =09skip_dos_drive_prefix((char **)&path);
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..0730bfcbba 100644
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
@@ -541,12 +539,12 @@ int git_default_core_config(const char *var, const ch=
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
@@ -720,5 +718,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->protect_hfs =3D PROTECT_HFS_DEFAULT;
+=09cfg->protect_ntfs =3D PROTECT_NTFS_DEFAULT;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 9eb97b3869..d48fd2719c 100644
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
@@ -173,8 +175,6 @@ extern int pack_compression_level;
 extern unsigned long pack_size_limit_cfg;
=20
 extern int precomposed_unicode;
-extern int protect_hfs;
-extern int protect_ntfs;
=20
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..b64a5629ef 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1002,7 +1002,7 @@ static enum verify_path_result verify_path_internal(c=
onst char *path,
 =09=09=09return PATH_OK;
 =09=09if (is_dir_sep(c)) {
 inside:
-=09=09=09if (protect_hfs) {
+=09=09=09if ((the_repository->gitdir ? repo_config_values(the_repository)-=
>protect_hfs : 0)) {
=20
 =09=09=09=09if (is_hfs_dotgit(path))
 =09=09=09=09=09return PATH_INVALID;
@@ -1011,7 +1011,7 @@ static enum verify_path_result verify_path_internal(c=
onst char *path,
 =09=09=09=09=09=09return PATH_INVALID;
 =09=09=09=09}
 =09=09=09}
-=09=09=09if (protect_ntfs) {
+=09=09=09if ((the_repository->gitdir ? repo_config_values(the_repository)-=
>protect_ntfs : 1)) {
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
+=09=09=09   (the_repository->gitdir ? repo_config_values(the_repository)->=
protect_ntfs : 1)) {
 =09=09=09if (is_ntfs_dotgit(path))
 =09=09=09=09return PATH_INVALID;
 =09=09=09if (S_ISLNK(mode)) {
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 15eb44485c..4455a68903 100644
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
@@ -275,9 +276,14 @@ static int protect_ntfs_hfs_benchmark(int argc, const =
char **argv)
 =09=09while (len > 0)
 =09=09=09names[i][--len] =3D (char)(' ' + (my_random() % ('\x7f' - ' ')));
 =09}
-
-=09for (protect_ntfs =3D 0; protect_ntfs < 2; protect_ntfs++)
-=09=09for (protect_hfs =3D 0; protect_hfs < 2; protect_hfs++) {
+=09
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

