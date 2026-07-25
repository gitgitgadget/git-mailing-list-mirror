Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9FE3BED7D
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980490; cv=none; b=mRPpetmGueCy16yB5vk6kS2Qqzmyljmf38MndkwlbwvlF2a0dA+qrpc7agCvCyfZXJbEw7fYsFCI6koMIDqf+Ac7DEKM4PVk9+m3F9YSUzaoGt8qyHn99kys7VmF0Dcz198tp0XagQiyF0g/nI8U0it2HJHkOd9ziyT8evOHdU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980490; c=relaxed/simple;
	bh=+m9tC5TeOTflbkebNvrjhC9EutZ9MhBFtB8Vx8rKEss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkefeVXGLCRhmSlkH6x9eIkG8gZCNTi5dD+WPiu9DzFyGKqRZYGV3VBhxuS4UEvUb0i5P50+UxyBm+vOn/LJ2zKrKHI8pgWe6QeRIsHHU/5UHJ+M/pkVk3kxnCLenXCDKo8LhAO7Mp2cYF0TEG3TmXf/vHZqUMHzj1UUhIfSF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=QaDMX6X6; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MkavB3QJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="QaDMX6X6";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MkavB3QJ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=QaDMX6X6iTARB647k1RIw5vei5z0FW5jPrCujvpuCBhJGSNDUYl513i4YTF0B2/ABUWNX4zyR5pvS4S16rWNg7vB66qOW36F4ko+0ntm2S8Hd4wc0JEFyUoCqupkui9oAIhgFLfZKAbkpkCQrNsVLFEjyPqY66oUQyG17nayOuRCgtnPuMP1kR/P3ZxG5uYbm8sZ1oIIzP7kd33h2m9eSoyQg8czBdbB3Usb5+kmW9tYiGoiRNtR5KdmZ93WxSxDYHs/xIi9vnVQ85Nui3wWTvDoexoSEtGh35LkOko9jom9tVB+FQs4oMdxj/l2WQqLTX97sZT4HZhiwbxHUnYU3A==; s=purelymail3; d=malon.dev; v=1; bh=+m9tC5TeOTflbkebNvrjhC9EutZ9MhBFtB8Vx8rKEss=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MkavB3QJ8YXQfw5QGk8UfCFKQaaOuvxJfOgVYPCymzipqzafVm5n3lBmFaOJnD69rGDU8yMGUljgiyKxiJXAyTZDMQOFnLIVEHo10zzm3mM8L40vCmwbn29nNWzW6fTKE3xK2pQoFbaorZ72Xh0110+78HFk7/umXbYg9wJt4NWdeKybKhTx4ZVh6nBABnAZL4q7xQlPxI4ABLS02LviVGbSzJXkH8Syr+B2ZfHJwTfkg886vOhH7HI9rEdHH0CFAND2KOkatf18NL9/2KWFc+IIgJtmOXb6mnrUUcGxbp3rTVnSNqsWMrSMCj6Z+lkyoHP0/YqjNR2FQF5j2NY+jg==; s=purelymail3; d=purelymail.com; v=1; bh=+m9tC5TeOTflbkebNvrjhC9EutZ9MhBFtB8Vx8rKEss=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 891366051;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 25 Jul 2026 11:54:46 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	newren@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 3/3] environment: migrate assume_unchanged into repo_config_values
Date: Sat, 25 Jul 2026 19:54:28 +0800
Message-ID: <20260725115428.2214202-4-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260725115428.2214202-1-cat@malon.dev>
References: <20260725115428.2214202-1-cat@malon.dev>
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
index ff731a9611..8fdb736023 100644
--- a/environment.c
+++ b/environment.c
@@ -43,7 +43,6 @@ static int zlib_compression_seen;
=20
 int trust_executable_bit =3D 1;
 int has_symlinks =3D 1;
-int assume_unchanged;
 char *git_commit_encoding;
 char *git_log_output_encoding;
 char *apply_default_whitespace;
@@ -374,7 +373,7 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.ignorestat")) {
-=09=09assume_unchanged =3D git_config_bool(var, value);
+=09=09cfg->assume_unchanged =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
@@ -758,6 +757,7 @@ void repo_config_values_init(struct repo_config_values =
*cfg)
 =09cfg->pack_compression_level =3D Z_DEFAULT_COMPRESSION;
 =09cfg->minimum_abbrev =3D 4;
 =09cfg->default_abbrev =3D -1;
+=09cfg->assume_unchanged =3D 0;
 =09cfg->precomposed_unicode =3D -1; /* see probe_utf8_pathname_composition=
() */
 =09cfg->core_sparse_checkout_cone =3D 0;
 =09cfg->sparse_expect_files_outside_of_patterns =3D 0;
diff --git a/environment.h b/environment.h
index c1d5bba2f0..a7e2bcbe30 100644
--- a/environment.h
+++ b/environment.h
@@ -97,6 +97,7 @@ struct repo_config_values {
 =09int pack_compression_level;
 =09int minimum_abbrev;
 =09int default_abbrev;
+=09int assume_unchanged;
 =09int precomposed_unicode;
 =09int core_sparse_checkout_cone;
 =09int warn_on_object_refname_ambiguity;
@@ -187,7 +188,6 @@ int have_git_dir(void);
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int has_symlinks;
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

