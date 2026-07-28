Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EB28C037
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203208; cv=none; b=axn1p26ltQaivr4Py+Ug4j2HfFzu5inwp4z0Ohbk96UbgvpBenFpDOTNqzg3355yXxw7VYM5zwERZKwzufLhuEFI+3vmqEZ78nyY5Jc0Ln8ygP5EoXTI6/0ZcE51pPYLp4gMIvoSzO5K1ZPkA1CnrUFgO1wvfALZOajWjIf6/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203208; c=relaxed/simple;
	bh=jX0bnNkg+noQiAA0hA/jbSskU4yFXYiWFOIt41GsTdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgtXhqu/+4y+Xn+zU1HKVYOnEhCimmAh7ISgr4wcKywDi2paaXzcw/8i1CnHNgQ4InTT8U66+7FcoNMVbkKoFUBA5DEQ9t1YvffmSDmHeh/7mlTsFJYmhb0jBbqS5H9wDBcUxJ5DsOf3P3/F/fvdBny1EKM3boIAw9kX3ZFPEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Q15sLb2T; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=AsjPU8Si; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Q15sLb2T";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="AsjPU8Si"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Q15sLb2TKcV7Q462zRppIXwjrC67F0wiRTFNB4E/ZzUIQHj60HjdiLGUFRD+L1JXSTFNfgYQdSYg5QwSOURXwd62zCdG43D1W5+h+wByu7dGjVTz14nEb/FVJ8zuy/vInV0thg+iV63TKawElj2K4TH/YB7bjy3T1Q2Ka0R8brnO7dqSe2ey17UuUNcUvmiTK+/xFVc6tkf+8fuMX66FDSBUIu+geA0pSB3JjGFIJbvV56sBhNrl2AkcGB9VPzf0Wsp55FYygZqp+t1G4+yUbaG3N+tEdlMO2YN65L0NaBCbu7GWR4XxiGBJHF74LbSKqJjRl+PGDTqRqeSudsyvfQ==; s=purelymail3; d=malon.dev; v=1; bh=jX0bnNkg+noQiAA0hA/jbSskU4yFXYiWFOIt41GsTdI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=AsjPU8SiY21u0+lb5gotLfIx+rsJei4OUDqcfO+ZCid8khT4Cr0SxdOJ6zzzWi9fouXrkYegSDv9ew0xcDXsfgp8K+mhhCHnpD07ZFxwP5v31xm1jDTnGcgUBD20+CAP8QNPDJAoAKk5f8s+hfzDzvxbplA3SHVQ3+yAe2qJvl3hKgejyYUsd8ztckCc3YFEdSoXq9oUW/QAiuM+eXf8Gudip5m0UXOUxpgc3+4m6vd2dXGm28KfSoJ7ta1+FXSm5Pa0JgM4PrDRkpSfYsBRmHXi1wskS2hG41NpX8LULLxiYEp9n163ExB7NEuN4NRW+qfMUUnNvUdnUCdjX8gNDQ==; s=purelymail3; d=purelymail.com; v=1; bh=jX0bnNkg+noQiAA0hA/jbSskU4yFXYiWFOIt41GsTdI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1180613032;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 28 Jul 2026 01:46:43 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/2] environment: migrate assume_unchanged into repo_config_values
Date: Tue, 28 Jul 2026 09:46:30 +0800
Message-ID: <20260728014630.3284974-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728014630.3284974-1-cat@malon.dev>
References: <20260725115428.2214202-1-cat@malon.dev>
 <20260728014630.3284974-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Move the global 'assume_unchanged' configuration into the
repository-specific 'repo_config_values' struct.

We do not introduce a getter for it because the readers are
limited and no hardcoded fallback values are needed.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 builtin/update-index.c | 3 ++-
 environment.c          | 4 ++--
 environment.h          | 2 +-
 read-cache.c           | 9 ++++++---
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4c4b39a157..3ef7e9bb90 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -419,6 +419,7 @@ static int add_cacheinfo(unsigned int mode, const struc=
t object_id *oid,
 {
 =09int len, option;
 =09struct cache_entry *ce;
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
=20
 =09if (!verify_path(path, mode))
 =09=09return error("Invalid path '%s'", path);
@@ -431,7 +432,7 @@ static int add_cacheinfo(unsigned int mode, const struc=
t object_id *oid,
 =09ce->ce_flags =3D create_ce_flags(stage);
 =09ce->ce_namelen =3D len;
 =09ce->ce_mode =3D create_ce_mode(mode);
-=09if (assume_unchanged)
+=09if (cfg->assume_unchanged)
 =09=09ce->ce_flags |=3D CE_VALID;
 =09option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 =09option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
diff --git a/environment.c b/environment.c
index 53623518c7..12659c1d9c 100644
--- a/environment.c
+++ b/environment.c
@@ -44,7 +44,6 @@ static int zlib_compression_seen;
 int trust_executable_bit =3D 1;
 int has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D -1;
-int assume_unchanged;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
@@ -355,7 +354,7 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.ignorestat")) {
-=09=09assume_unchanged =3D git_config_bool(var, value);
+=09=09cfg->assume_unchanged =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
@@ -737,6 +736,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->check_stat =3D 1;
 =09cfg->zlib_compression_level =3D Z_BEST_SPEED;
 =09cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
+=09cfg->assume_unchanged =3D 0;
 =09cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 =09cfg->core_sparse_checkout_cone =3D 0;
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
diff --git a/environment.h b/environment.h
index 2e0f8beac0..3a391338e3 100644
--- a/environment.h
+++ b/environment.h
@@ -95,6 +95,7 @@ struct repo_config_values {
 =09int check_stat;
 =09int zlib_compression_level;
 =09int pack_compression_level;
+=09int assume_unchanged;
 =09int precomposed_unicode;
 =09int core_sparse_checkout_cone;
 =09int warn_on_object_refname_ambiguity;
@@ -183,7 +184,6 @@ int have_git_dir(void);
 extern int trust_executable_bit;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
-extern int assume_unchanged;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
=20
diff --git a/read-cache.c b/read-cache.c
index 38b55323dd..643b13f1fb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -192,9 +192,11 @@ void rename_index_entry_at(struct index_state *istate,=
 int nr, const char *new_n
  */
 void fill_stat_cache_info(struct index_state *istate, struct cache_entry *=
ce, struct stat *st)
 {
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+
 =09fill_stat_data(&ce->ce_stat_data, st);
=20
-=09if (assume_unchanged)
+=09if (cfg->assume_unchanged)
 =09=09ce->ce_flags |=3D CE_VALID;
=20
 =09if (S_ISREG(st->st_mode)) {
@@ -1346,6 +1348,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 {
 =09struct stat st;
 =09struct cache_entry *updated;
+=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
 =09int changed;
 =09int refresh =3D options & CE_MATCH_REFRESH;
 =09int ignore_valid =3D options & CE_MATCH_IGNORE_VALID;
@@ -1405,7 +1408,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 =09=09 * is not marked VALID, this is the place to mark it
 =09=09 * valid again, under "assume unchanged" mode.
 =09=09 */
-=09=09if (ignore_valid && assume_unchanged &&
+=09=09if (ignore_valid && cfg->assume_unchanged &&
 =09=09    !(ce->ce_flags & CE_VALID))
 =09=09=09; /* mark this one VALID again */
 =09=09else {
@@ -1440,7 +1443,7 @@ static struct cache_entry *refresh_cache_ent(struct i=
ndex_state *istate,
 =09 * (i.e. things to be edited) will reacquire CE_VALID bit
 =09 * automatically, which is not really what we want.
 =09 */
-=09if (!ignore_valid && assume_unchanged &&
+=09if (!ignore_valid && cfg->assume_unchanged &&
 =09    !(ce->ce_flags & CE_VALID))
 =09=09updated->ce_flags &=3D ~CE_VALID;
=20
--=20
2.43.0

