Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49431DD96
	for <git@vger.kernel.org>; Sat, 30 May 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157144; cv=none; b=IpOZ/5kaEVHHEezPVAnJeJednlBPfegflMv21iOM+A/JycsjKrB4aVCzW05PrZ3Fj8jG2Jx6xkueR5fGYvC+HlBlhcdD9jqB22rSp5ZE75x4FiwAVyRIFSbT6HT9r0H2cyepRux1IYNFd9reobDxYgHliPmLozuLSxu1d6PITx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157144; c=relaxed/simple;
	bh=hLMhXtcNv4NdAWlxhAAWbTrzFfoS4sz6ZBjhbn/OaGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNlmGWkJVQ3Njjxp00tpGHWApmNAyWDEwE0KgLYWpFZ/C4InasGueMlCILRP1RrCOb18MOkAU+Bw+xJ2WDZSflsawGUn/x/tjhLOIsXc1Lg5LVeKQFAcS7T4tcc5ZU8XrBoZmJEHrz73S27vDtkn/luuXZ2ENmEcEMJfgdpuCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=bX1+Mm07; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=lhTTjrC+; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="bX1+Mm07";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="lhTTjrC+"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=bX1+Mm07SD6W26oEzKc+9etI4h9GsVD0HaZOotBZHmLkxSW/qaeOHg2kShEMnQuS9CJd5KS0DHKByyH453vdD7YQ0HC0LCrenqZS+/XoGveWW3I/YTvW8A1+a3slGJ+Ul4svc0trcP6lSxOF7qg1ZREMwB2RmX6aHIs+gDHGZcEN8z6M3zjqz4lXAia4CuBg/+SJGF0tK4uYnt3DdMQ6ZGDTndkzDiS+2dNWSMbVKMyUqgdBwjVNEBPc0/4QHmH8wtvo9N7W7atW623MpCxkSaUAVNR1xjI2bveOefxJLDZeYHLrD/Igqpc/0B7pvimwfdIXgw0Zhgkv/ylOpIRWjg==; s=purelymail1; d=malon.dev; v=1; bh=hLMhXtcNv4NdAWlxhAAWbTrzFfoS4sz6ZBjhbn/OaGs=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=lhTTjrC+wT0MKaglT68JHuaN2yZK7Ucf1rH2+7o54ZgGm156a1JTGhk8d0rrvoyB80tAngw3NTsOwNZ5aD2DsFxhRbhMDWU8eEB+wk+Q/RpvqNWPFxspyJfPJEcK7YMNO8t9aoNVm3T3Y7ydhYrVJbE3ug4ZWOhJuS52OQ90JlAB4jtVc2PA3uOvhTb6VWY6IjBYdRvnnrKRSz00C1+gtd3Zhi/UmuD64v8nqyQKfSs8qdwcUxZKnFY8li3oop/cRoTfB9Nk7QeumkBiFXym10m9GtSwlTOd57cEKC5DaCHuyLfqVcF85RSUWDfNpcf6CcJrRcow7RgcL9lQ0OcTZg==; s=purelymail1; d=purelymail.com; v=1; bh=hLMhXtcNv4NdAWlxhAAWbTrzFfoS4sz6ZBjhbn/OaGs=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1173446767;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 30 May 2026 16:05:40 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 3/4] environment: move 'trust_executable_bit' into repo_config_values
Date: Sun, 31 May 2026 00:05:18 +0800
Message-ID: <20260530160520.77859-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530160520.77859-1-cat@malon.dev>
References: <20260530160520.77859-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'trust_executable_bit' configuration into the
repository-specific 'repo_config_values' struct.

For now, associated functions in read-cache.c access this configuration
by explicitly falling back to 'the_repository'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c       |  4 +++-
 environment.c |  4 ++--
 environment.h |  2 +-
 read-cache.c  | 15 +++++++++++----
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..73ca9907f8 100644
--- a/apply.c
+++ b/apply.c
@@ -3890,10 +3890,12 @@ static int check_preimage(struct apply_state *state=
,
 =09}
=20
 =09if (!state->cached && !previous) {
+=09=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
+
 =09=09if (*ce && !(*ce)->ce_mode)
 =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
=20
-=09=09if (trust_executable_bit || !S_ISREG(st->st_mode))
+=09=09if (cfg->trust_executable_bit || !S_ISREG(st->st_mode))
 =09=09=09st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
 =09=09else if (*ce)
 =09=09=09st_mode =3D (*ce)->ce_mode;
diff --git a/environment.c b/environment.c
index fc3ed8bb1c..94f74f39e6 100644
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
@@ -305,7 +304,7 @@ int git_default_core_config(const char *var, const char=
 *value,
=20
 =09/* This needs a better name */
 =09if (!strcmp(var, "core.filemode")) {
-=09=09trust_executable_bit =3D git_config_bool(var, value);
+=09=09cfg->trust_executable_bit =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
 =09if (!strcmp(var, "core.trustctime")) {
@@ -720,5 +719,6 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 {
 =09cfg->attributes_file =3D NULL;
 =09cfg->apply_sparse_checkout =3D 0;
+=09cfg->trust_executable_bit =3D 1;
 =09cfg->branch_track =3D BRANCH_TRACK_REMOTE;
 }
diff --git a/environment.h b/environment.h
index 123a71cdc8..72c400923d 100644
--- a/environment.h
+++ b/environment.h
@@ -90,6 +90,7 @@ struct repository;
 struct repo_config_values {
 =09/* section "core" config values */
 =09char *attributes_file;
+=09int trust_executable_bit;
 =09int apply_sparse_checkout;
=20
 =09/* section "branch" config values */
@@ -160,7 +161,6 @@ int is_bare_repository(void);
 extern char *git_work_tree_cfg;
=20
 /* Environment bits from configuration mechanism */
-extern int trust_executable_bit;
 extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
diff --git a/read-cache.c b/read-cache.c
index 54150fe756..18af533649 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -204,10 +204,12 @@ void fill_stat_cache_info(struct index_state *istate,=
 struct cache_entry *ce, st
=20
 unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int =
mode)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09if (!has_symlinks && S_ISREG(mode) &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
-=09if (!trust_executable_bit && S_ISREG(mode)) {
+=09if (!cfg->trust_executable_bit && S_ISREG(mode)) {
 =09=09if (ce && S_ISREG(ce->ce_mode))
 =09=09=09return ce->ce_mode;
 =09=09return create_ce_mode(0666);
@@ -217,11 +219,13 @@ unsigned int ce_mode_from_stat(const struct cache_ent=
ry *ce, unsigned int mode)
=20
 static unsigned int st_mode_from_ce(const struct cache_entry *ce)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09switch (ce->ce_mode & S_IFMT) {
 =09case S_IFLNK:
 =09=09return has_symlinks ? S_IFLNK : (S_IFREG | 0644);
 =09case S_IFREG:
-=09=09return (ce->ce_mode & (trust_executable_bit ? 0755 : 0644)) | S_IFRE=
G;
+=09=09return (ce->ce_mode & (cfg->trust_executable_bit ? 0755 : 0644)) | S=
_IFREG;
 =09case S_IFGITLINK:
 =09=09return S_IFDIR | 0755;
 =09case S_IFDIR:
@@ -321,6 +325,7 @@ static int ce_modified_check_fs(struct index_state *ist=
ate,
 static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *=
st)
 {
 =09unsigned int changed =3D 0;
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
=20
 =09if (ce->ce_flags & CE_REMOVE)
 =09=09return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
@@ -331,7 +336,7 @@ static int ce_match_stat_basic(const struct cache_entry=
 *ce, struct stat *st)
 =09=09/* We consider only the owner x bit to be relevant for
 =09=09 * "mode changes"
 =09=09 */
-=09=09if (trust_executable_bit &&
+=09=09if (cfg->trust_executable_bit &&
 =09=09    (0100 & (ce->ce_mode ^ st->st_mode)))
 =09=09=09changed |=3D MODE_CHANGED;
 =09=09break;
@@ -732,6 +737,8 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09=09  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 =09unsigned hash_flags =3D pretend ? 0 : INDEX_WRITE_OBJECT;
=20
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09if (flags & ADD_CACHE_RENORMALIZE)
 =09=09hash_flags |=3D INDEX_RENORMALIZE;
=20
@@ -752,7 +759,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09ce->ce_flags |=3D CE_INTENT_TO_ADD;
=20
=20
-=09if (trust_executable_bit && has_symlinks) {
+=09if (cfg->trust_executable_bit && has_symlinks) {
 =09=09ce->ce_mode =3D create_ce_mode(st_mode);
 =09} else {
 =09=09/* If there is an existing entry, pick the mode bits and type
--=20
2.43.0

