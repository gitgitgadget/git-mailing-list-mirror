Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AFA3ED113
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544842; cv=none; b=sLWelt0/UGPOUNR4JEIBnKFfJQEAnqPupbevEI4iD1HMHpFhn3w+VdM/8RuEP1Pq+37wGjqC0wg/qRj2G9PUb+6260dqguPhKavjRJjIpI7TFm1osLV7luJ+z/wEba0gYJ6fylIY8kYm1PqRe0wxcOf2b8cyLRTw86wJ248hj2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544842; c=relaxed/simple;
	bh=gMIANG9lSVySfWPvlmgpajMsNE2XLF5/5hc4Oaae0ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYyHwonGbUkkT2vRqip7wRpeFLbJlUy9F3imygoLOgf/deOGIwT0SyHYZK/GUTtQs/iYu4gGU/Pdw/nxMsOcT/Ye0Y2NpKaZ/6MxikHex45kEschLQCHwStNI0MEzmxOISKDsxv7SyOofwKa68ngDqZPbHJfnDWckKgUj12Wfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=cESUK7f7; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=jAxGezNk; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="cESUK7f7";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="jAxGezNk"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=cESUK7f7bWpIAeAHPCoJwrY7LV1VQbehqyd83xkc7WYm8zPRnEjLO++gbG6VV2eOAkSYBfETdvW6Keph0zR6MgMoSXKHkmyBLI9AkR1+OOfk19el65+qGlbnFVUSMVB0obe6tUI7wX9xOG+LiJ6vqK+66EAKfCFCq8VIOgWytGivJ9Fi0QgnKc1oNWAsXp8rLf+OyPR+AJBRcyIgz1xO152r7+F5/H7kuRWvwQag8AlDakzXRA9RqZ1S4IPaSacuLvNnhCjIM5WFD5Gvr739QURhLo9LVVh7WzmYxXbFnXFArLVjw/tvxOvzteXAkIM4vpRI/25wCDLm+DgaFMK29w==; s=purelymail2; d=malon.dev; v=1; bh=gMIANG9lSVySfWPvlmgpajMsNE2XLF5/5hc4Oaae0ZA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=jAxGezNkKh5XBdXDX+HCLo5fXFhhMBxBDSVL/V5TLdwick4MpUJBULUaMKWz/lfHb8Q2FstKbX2Z6RqyApFv3sAydqtI2NYYte/r21pOAhsoNJzNjooxJ8lMfumB4HuGS8o+oY9u/lOHsqX8Nxr3VIp81uQuYDMd2Q7OMpltYVZH7UZ/Yd4pjqz0OBjWbGVibOLbVS2WI4sHWQLnTUj9R4E6+cQnM302WXBj7tiHvCn/RmNEBVZ6yNQepAdNCoI5FyMGlkume75N/Bnj9M844djihPn1iQhIheleCThu8PrLu/iR3jLJEEnFCuJLUQ4sFWrwR73cD8VS3J4mKZ+nZQ==; s=purelymail2; d=purelymail.com; v=1; bh=gMIANG9lSVySfWPvlmgpajMsNE2XLF5/5hc4Oaae0ZA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1835461667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:53:55 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 3/4] environment: move trust_executable_bit into repo_config_values
Date: Mon, 20 Jul 2026 18:53:34 +0800
Message-ID: <20260720105335.3202013-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720105335.3202013-1-cat@malon.dev>
References: <20260717063559.1633567-1-cat@malon.dev>
 <20260720105335.3202013-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'trust_executable_bit' configuration
into the repository-specific 'repo_config_values'
struct.

To ensure code readability, the getter function
'repo_trust_executable_bit()' has been introduced.
Callers access this configuration by passing in 'repo'
when possible, and explicitly fall back to 'the_repository'
the rest of time.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c       |  2 +-
 environment.c | 11 +++++++++--
 environment.h |  4 +++-
 read-cache.c  |  6 +++---
 read-cache.h  |  6 +++---
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 26286eb57b..edb1502414 100644
--- a/apply.c
+++ b/apply.c
@@ -3893,7 +3893,7 @@ static int check_preimage(struct apply_state *state,
 =09=09if (*ce && !(*ce)->ce_mode)
 =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
=20
-=09=09if (trust_executable_bit || !S_ISREG(st->st_mode))
+=09=09if (repo_trust_executable_bit(state->repo) || !S_ISREG(st->st_mode))
 =09=09=09st_mode =3D ce_mode_from_stat(state->repo, *ce, st->st_mode);
 =09=09else if (*ce)
 =09=09=09st_mode =3D (*ce)->ce_mode;
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..32b110c405 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,6 @@
 static int pack_compression_seen;
 static int zlib_compression_seen;
=20
-int trust_executable_bit =3D 1;
 int trust_ctime =3D 1;
 int check_stat =3D 1;
 int has_symlinks =3D 1;
@@ -142,6 +141,13 @@ int is_bare_repository(void)
 =09return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
=20
+int repo_trust_executable_bit(struct repository *repo)
+{
+=09return repo->initialized
+=09=09? repo_config_values(repo)->trust_executable_bit
+=09=09: 1;
+}
+
 int have_git_dir(void)
 {
 =09return startup_info->have_repository
@@ -305,7 +311,7 @@ int git_default_core_config(const char *var, const char=
 *value,
=20
 =09/* This needs a better name */
 =09if (!strcmp(var, "core.filemode")) {
-=09=09trust_executable_bit =3D git_config_bool(var, value);
+=09=09cfg->trust_executable_bit =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
 =09if (!strcmp(var, "core.trustctime")) {
@@ -720,5 +726,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->trust_executable_bit =3D 1;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 123a71cdc8..72b59fd89c 100644
--- a/environment.h
+++ b/environment.h
@@ -91,6 +91,7 @@ struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
 =09int apply_sparse_checkout;
+=09int trust_executable_bit;
=20
 =09/* section "branch" config values */
 =09enum branch_track branch_track;
@@ -123,6 +124,8 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+int repo_trust_executable_bit(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -160,7 +163,6 @@ int is_bare_repository(void);
 extern char *git_work_tree_cfg;
=20
 /* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
diff --git a/read-cache.c b/read-cache.c
index b37bf688ec..1f8b5ed15f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -208,7 +208,7 @@ static unsigned int st_mode_from_ce(const struct cache_=
entry *ce)
 =09case S_IFLNK:
 =09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
 =09case S_IFREG:
-=09=09return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFRE=
G;
+=09=09return (ce->ce_mode & (repo_trust_executable_bit(the_repository) ? 0=
755 : 0644)) | S_IFREG;
 =09case S_IFGITLINK:
 =09=09return S_IFDIR | 0755;
 =09case S_IFDIR:
@@ -318,7 +318,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
 =09=09/* We consider only the owner x bit to be relevant for
 =09=09 * "mode changes"
 =09=09 */
-=09=09if (trust_executable_bit &&
+=09=09if (repo_trust_executable_bit(the_repository) &&
 =09=09    (0100 & (ce->ce_mode ^ st->st_mode)))
 =09=09=09changed |=3D MODE_CHANGED;
 =09=09break;
@@ -739,7 +739,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09ce->ce_flags |=3D CE_INTENT_TO_ADD;
=20
=20
-=09if (trust_executable_bit && has_symlinks) {
+=09if (repo_trust_executable_bit(istate->repo) && has_symlinks) {
 =09=09ce->ce_mode =3D create_ce_mode(st_mode);
 =09} else {
 =09=09/* If there is an existing entry, pick the mode bits and type
diff --git a/read-cache.h b/read-cache.h
index af8c657ecb..4b54cfc57c 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -13,15 +13,15 @@
  * This function handles degradation for filesystems that lack
  * symlink support or reliable executable bits.
  */
-static inline unsigned int ce_mode_from_stat(struct repository *repo UNUSE=
D,
+static inline unsigned int ce_mode_from_stat(struct repository *repo,
 =09=09=09=09=09     const struct cache_entry *ce,
 =09=09=09=09=09     unsigned int mode)
 {
-=09extern int trust_executable_bit, has_symlinks;
+=09extern int has_symlinks;
 =09if (S_ISREG(mode) && !has_symlinks &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
-=09if (S_ISREG(mode) && !trust_executable_bit) {
+=09if (S_ISREG(mode) && !repo_trust_executable_bit(repo)) {
 =09=09if (ce && S_ISREG(ce->ce_mode))
 =09=09=09return ce->ce_mode;
 =09=09return create_ce_mode(0666);
--=20
2.43.0

