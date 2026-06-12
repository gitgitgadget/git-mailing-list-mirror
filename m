Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9E3ED3B4
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280357; cv=none; b=JXc2Ab46Y/KapGmzLBvdbABPV3Oiqs0LhOYj81EriyOhVONcKYuqzHRVBXjNHTgZQhrzx47qDbBSk9m+4vjly8FFS9ySOsqNHgJgSn3/4C42+n/sFYkCZ+unnJpzxfVrt422USLJ0rIWfH6j8Ef3swJZrv7LdnCeLw5Zd/YujSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280357; c=relaxed/simple;
	bh=KbM0o9Aj2kENPkrVlxanN0JaRutB4eo2r5jvIy/gzwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mamGwX/bHMMNq1fA3nuyXfqcwd6QrZbpsX+KLObzRCnz52SKVBNgrRAJrJXQyAXU4OQfDDy/4syXaRmWIibHozN5zbBUkoY8MTDSOZxAv1mW4IExdqPC5F86uuID3ZX/GgF6wPkt+7yUXjXOQQI4tL3IzXbm+xLWcrxWhCj6otk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=A+Nfk2Lf; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=A5wpIGg5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="A+Nfk2Lf";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="A5wpIGg5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=A+Nfk2LfYXYb7KEUsGXWWWfHGizO0uPeo+s2kxoNj2l/yYsb7tm5Vc/Sm/KXsyZsao+hDdS5JEoy/Vf1kmzmJ0LIGd0HN2ntBsyHUQ5skF3UNcqcJIA2hlQZXtF6OQzf/zBQWl+2GluYW+QVg2GTgjM5grIbQVnCZ+x0pHIiFdY8+BbeBGkytzJjPgIHSl6lMNOi95YXgZXbVQ1TvTSywEPna3f+3q0511OoJZC+0gvfQnNCpzhZIvYI5sgOx+dyGkCynDlCFyIAuxt72KLC/NrgI2Od4HQK3VR+Rkt4EGgOollY8gn/htzee/33PJMUuQ+EzfKJN/sqOoC8uLZScA==; s=purelymail3; d=malon.dev; v=1; bh=KbM0o9Aj2kENPkrVlxanN0JaRutB4eo2r5jvIy/gzwY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=A5wpIGg5P80ilODWkHu0z9Yg+LFcJiYZRWSZlQm8oG/B6TePuSz7FNnO6Q5ebD2rGEPaZnUKMLg/SLUrc0g4/WhUOiyNfrZM0EXq/z1vtjN7e5LnFCRbeVtUvcncMtnC1TaMY/w88qvU7OAD7OMf7JIZM3CL7QaChoUL2aJL8SR2ATQuYu869KLHlpymqzne/d+YEXxbyzFnpJnM59LCm8lchjMqc0UVJnPQy/EBuINhdolx0jwCR9bWestK/W65A3Vqo7Br7WdDNjhbLhbLZyTo9u4yOFkHWQ4hkVDiPub06+KzCMNPcp+UnmNZTIsG/C3Saqed8I77m1FeOAwUNw==; s=purelymail3; d=purelymail.com; v=1; bh=KbM0o9Aj2kENPkrVlxanN0JaRutB4eo2r5jvIy/gzwY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -702755865;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 12 Jun 2026 16:05:50 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v3 3/3] environment: move trust_executable_bit into repo_config_values
Date: Sat, 13 Jun 2026 00:05:26 +0800
Message-ID: <20260612160527.167203-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612160527.167203-1-cat@malon.dev>
References: <20260610093635.139719-1-cat@malon.dev>
 <20260612160527.167203-1-cat@malon.dev>
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
struct. To ensure code readability, the getter function
'repo_trust_executable_bit()' has been introduced.

For now, associated functions access this configuration by
explicitly falling back to 'the_repository'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c       |  2 +-
 environment.c | 11 +++++++++--
 environment.h |  9 ++++++++-
 read-cache.c  |  8 ++++----
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..fbb907d3c0 100644
--- a/apply.c
+++ b/apply.c
@@ -3893,7 +3893,7 @@ static int check_preimage(struct apply_state *state,
 =09=09if (*ce && !(*ce)->ce_mode)
 =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
=20
-=09=09if (trust_executable_bit || !S_ISREG(st->st_mode))
+=09=09if (repo_trust_executable_bit(the_repository) || !S_ISREG(st->st_mod=
e))
 =09=09=09st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
 =09=09else if (*ce)
 =09=09=09st_mode =3D (*ce)->ce_mode;
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..75069a884d 100644
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
+=09return repo->gitdir?
+=09=09repo_config_values(repo)->trust_executable_bit :
+=09=091;
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
index 123a71cdc8..d602d2cd95 100644
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
@@ -123,6 +124,13 @@ int git_default_config(const char *, const char *,
 int git_default_core_config(const char *var, const char *value,
 =09=09=09    const struct config_context *ctx, void *cb);
=20
+/*
+ * Getter for the `trust_executable_bit` field of `struct repo_config_valu=
es`.
+ * It checks `repo->gitdir` to prevent calling repo_config_values()
+ * before the configuration is loaded or in bare environments.
+ */
+int repo_trust_executable_bit(struct repository *repo);
+
 void repo_config_values_init(struct repo_config_values *cfg);
=20
 /*
@@ -160,7 +168,6 @@ int is_bare_repository(void);
 extern char *git_work_tree_cfg;
=20
 /* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
diff --git a/read-cache.c b/read-cache.c
index 54150fe756..757249a449 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -207,7 +207,7 @@ unsigned int ce_mode_from_stat(const struct cache_entry=
 *ce, unsigned int mode)
 =09if (!has_symlinks && S_ISREG(mode) &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
-=09if (!trust_executable_bit && S_ISREG(mode)) {
+=09if (!repo_trust_executable_bit(the_repository) && S_ISREG(mode)) {
 =09=09if (ce && S_ISREG(ce->ce_mode))
 =09=09=09return ce->ce_mode;
 =09=09return create_ce_mode(0666);
@@ -221,7 +221,7 @@ static unsigned int st_mode_from_ce(const struct cache_=
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
@@ -331,7 +331,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
 =09=09/* We consider only the owner x bit to be relevant for
 =09=09 * "mode changes"
 =09=09 */
-=09=09if (trust_executable_bit &&
+=09=09if (repo_trust_executable_bit(the_repository) &&
 =09=09    (0100 & (ce->ce_mode ^ st->st_mode)))
 =09=09=09changed |=3D MODE_CHANGED;
 =09=09break;
@@ -752,7 +752,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09ce->ce_flags |=3D CE_INTENT_TO_ADD;
=20
=20
-=09if (trust_executable_bit && has_symlinks) {
+=09if (repo_trust_executable_bit(the_repository) && has_symlinks) {
 =09=09ce->ce_mode =3D create_ce_mode(st_mode);
 =09} else {
 =09=09/* If there is an existing entry, pick the mode bits and type
--=20
2.43.0

