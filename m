Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F12F12AB
	for <git@vger.kernel.org>; Sat, 30 May 2026 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157153; cv=none; b=uGhNLX9VlqFQYoOQaZMSM6bJImyR7uS0i/ar1tZzfAc1gvaS4z9caW4646O/R2vrLe1kGhsVgtYo3Td4fELVYAuUSjoERkauuxF4WeopuGoLFLj5Lh5t+KUpR7IeCYpbydITqtnd4ywcungxBxM3KsdugUvpccRrKt5Y6w4oraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157153; c=relaxed/simple;
	bh=Y+3sS7yN75JfcCpbs7sF6+bwNvsxZPKFnj957nL1uU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jk2fkuSgbqq16Mwxfha5iW4j2/6FbSbyKCPEsn1BOlD+xDHEu8FQHjjelhguOnl0uV+EZGKyjmeuOmuTttpLeAUimUZfeH39Rm0qT869sRo2qJcEQ4bKZlIyhIxV3wXx95Xzx19i4C/k6QWJcR3pmB1JCo3GHnLfp6nCi1vkfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=BB0AZkBs; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Oi0X9biR; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="BB0AZkBs";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Oi0X9biR"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BB0AZkBshP7C6nabPYD931m0Cz7TZEjmJczGK/F+dv9oxXN7ZGvK6cNmU/JHqsWgo76mErR9Ss1SG1kAH+inle3oF/mV2dvcMCCIgx5EwXfD/z6765g+1Lx8FBX0YFlJxTRFxIEndJoaoif8aoFLwkmj0jWh0qKwcUGqL2KA4KvEeW7+u7bau5jksEW/3/U3mRStRLdvGLT5YyQ4acaZGYUSIuoQFzI8YOsXgpGzDgj1Oo0oF2UKghLFIKBCrAcJV/ewhIjWyLTKSjbvoNSXZK3e0K4bFjBvyR9E7VLU9otoqZpVhcY8lgXTGTlf4jcp5ixA8ExcmoQVJ9s7/ivpKA==; s=purelymail1; d=malon.dev; v=1; bh=Y+3sS7yN75JfcCpbs7sF6+bwNvsxZPKFnj957nL1uU8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Oi0X9biRUMVyErB59+TCoFeRYdDKSBN6FGVvrPAETBk6CBBKoNn2nmsNHHEecQxMhupnhbRwEyBAQTRm8MDk8DtKKH9qQj4LfmdPhrf3G44okeCRm8xWP2XCCWvZZSDz94R4gIUCQ9byL+qnZtaE/8bfYK11WrtSLWgclEQ45qvu623k1F+lYRtVVghkDz48nb2xF1gNcydmAp8OmiynN1rL2cCalp4Onvq6OsgbW5DbI2cZnFRkMRgUvCQR4B53sM5Ihum2siGv85Gl8CA8eovPsF6avqadoL/fM4pMcT5oA8zEe14BF05QAxpKeX33nlk+R7Gtpf3+ZBAg00I82w==; s=purelymail1; d=purelymail.com; v=1; bh=Y+3sS7yN75JfcCpbs7sF6+bwNvsxZPKFnj957nL1uU8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1173446767;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 30 May 2026 16:05:45 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1 4/4] read-cache: pass 'istate' to stat/mode helper functions
Date: Sun, 31 May 2026 00:05:19 +0800
Message-ID: <20260530160520.77859-5-cat@malon.dev>
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

In the previous commit, the gloabl 'trust_executable_bit' was
migrated into 'repo_config_values', but low-level helpers in
read-cache.c still relied on 'the_repository' to access it.

Refactor the signatures of ce_mode_from_stat(), st_mode_from_ce(),
fake_lstat(), and check_removed() to accept a 'struct
index_state *istate'. This allows these functions to retrieve the
repository context via 'istate->repo'.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c                |  4 ++--
 builtin/update-index.c |  2 +-
 diff-lib.c             | 20 ++++++++++----------
 read-cache-ll.h        |  2 +-
 read-cache.c           | 31 +++++++++++++++++++------------
 read-cache.h           |  3 ++-
 6 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/apply.c b/apply.c
index 73ca9907f8..a81bb29a6f 100644
--- a/apply.c
+++ b/apply.c
@@ -3890,13 +3890,13 @@ static int check_preimage(struct apply_state *state=
,
 =09}
=20
 =09if (!state->cached && !previous) {
-=09=09struct repo_config_values *cfg =3D repo_config_values(the_repository=
);
+=09=09struct repo_config_values *cfg =3D repo_config_values(state->repo);
=20
 =09=09if (*ce && !(*ce)->ce_mode)
 =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
=20
 =09=09if (cfg->trust_executable_bit || !S_ISREG(st->st_mode))
-=09=09=09st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
+=09=09=09st_mode =3D ce_mode_from_stat(state->repo->index, *ce, st->st_mod=
e);
 =09=09else if (*ce)
 =09=09=09st_mode =3D (*ce)->ce_mode;
 =09=09else
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..3f6967bd84 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -293,7 +293,7 @@ static int add_one_path(const struct cache_entry *old, =
const char *path, int len
 =09ce->ce_flags =3D create_ce_flags(0);
 =09ce->ce_namelen =3D len;
 =09fill_stat_cache_info(the_repository->index, ce, st);
-=09ce->ce_mode =3D ce_mode_from_stat(old, st->st_mode);
+=09ce->ce_mode =3D ce_mode_from_stat(the_repository->index, old, st->st_mo=
de);
=20
 =09if (index_path(the_repository->index, &ce->oid, path, st,
 =09=09       info_only ? 0 : INDEX_WRITE_OBJECT)) {
diff --git a/diff-lib.c b/diff-lib.c
index ae91027a02..95fd3ba4b9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -39,14 +39,14 @@
  * exists for ce that is a submodule -- it is a submodule that is not
  * checked out).  Return negative for an error.
  */
-static int check_removed(const struct cache_entry *ce, struct stat *st)
+static int check_removed(struct index_state *istate, const struct cache_en=
try *ce, struct stat *st)
 {
 =09int stat_err;
=20
 =09if (!(ce->ce_flags & CE_FSMONITOR_VALID))
 =09=09stat_err =3D lstat(ce->name, st);
 =09else
-=09=09stat_err =3D fake_lstat(ce, st);
+=09=09stat_err =3D fake_lstat(istate, ce, st);
 =09if (stat_err < 0) {
 =09=09if (!is_missing_file_error(errno))
 =09=09=09return -1;
@@ -158,9 +158,9 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 =09=09=09int num_compare_stages =3D 0;
 =09=09=09struct stat st;
=20
-=09=09=09changed =3D check_removed(ce, &st);
+=09=09=09changed =3D check_removed(revs->repo->index, ce, &st);
 =09=09=09if (!changed)
-=09=09=09=09wt_mode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09=09wt_mode =3D ce_mode_from_stat(revs->repo->index, ce, st.st_mod=
e);
 =09=09=09else {
 =09=09=09=09if (changed < 0) {
 =09=09=09=09=09perror(ce->name);
@@ -193,7 +193,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 =09=09=09=09=09num_compare_stages++;
 =09=09=09=09=09oidcpy(&dpath->parent[stage - 2].oid,
 =09=09=09=09=09       &nce->oid);
-=09=09=09=09=09dpath->parent[stage-2].mode =3D ce_mode_from_stat(nce, mode=
);
+=09=09=09=09=09dpath->parent[stage-2].mode =3D ce_mode_from_stat(revs->rep=
o->index, nce, mode);
 =09=09=09=09=09dpath->parent[stage-2].status =3D
 =09=09=09=09=09=09DIFF_STATUS_MODIFIED;
 =09=09=09=09}
@@ -249,7 +249,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 =09=09} else {
 =09=09=09struct stat st;
=20
-=09=09=09changed =3D check_removed(ce, &st);
+=09=09=09changed =3D check_removed(revs->repo->index, ce, &st);
 =09=09=09if (changed) {
 =09=09=09=09if (changed < 0) {
 =09=09=09=09=09perror(ce->name);
@@ -262,7 +262,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 =09=09=09=09continue;
 =09=09=09} else if (revs->diffopt.ita_invisible_in_index &&
 =09=09=09=09   ce_intent_to_add(ce)) {
-=09=09=09=09newmode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09=09newmode =3D ce_mode_from_stat(revs->repo->index, ce, st.st_mod=
e);
 =09=09=09=09diff_addremove(&revs->diffopt, '+', newmode,
 =09=09=09=09=09       null_oid(the_hash_algo), 0, ce->name, 0);
 =09=09=09=09continue;
@@ -270,7 +270,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
=20
 =09=09=09changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
 =09=09=09=09=09=09=09    ce_option, &dirty_submodule);
-=09=09=09newmode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09newmode =3D ce_mode_from_stat(revs->repo->index, ce, st.st_mode);
 =09=09}
=20
 =09=09if (!changed && !dirty_submodule) {
@@ -324,7 +324,7 @@ static int get_stat_data(const struct cache_entry *ce,
 =09if (!cached && !ce_uptodate(ce)) {
 =09=09int changed;
 =09=09struct stat st;
-=09=09changed =3D check_removed(ce, &st);
+=09=09changed =3D check_removed(diffopt->repo->index, ce, &st);
 =09=09if (changed < 0)
 =09=09=09return -1;
 =09=09else if (changed) {
@@ -338,7 +338,7 @@ static int get_stat_data(const struct cache_entry *ce,
 =09=09changed =3D match_stat_with_submodule(diffopt, ce, &st,
 =09=09=09=09=09=09    0, dirty_submodule);
 =09=09if (changed) {
-=09=09=09mode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09mode =3D ce_mode_from_stat(diffopt->repo->index, ce, st.st_mode);
 =09=09=09oid =3D null_oid(the_hash_algo);
 =09=09}
 =09}
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 2c8b4b21b1..9fb9bedfbf 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -442,7 +442,7 @@ void fill_stat_cache_info(struct index_state *istate, s=
truct cache_entry *ce, st
  * for lstat() for a tracked path that is known to be up-to-date via
  * some out-of-line means (like fsmonitor).
  */
-int fake_lstat(const struct cache_entry *ce, struct stat *st);
+int fake_lstat(struct index_state *istate, const struct cache_entry *ce, s=
truct stat *st);
=20
 #define REFRESH_REALLY                   (1 << 0) /* ignore_valid */
 #define REFRESH_UNMERGED                 (1 << 1) /* allow unmerged */
diff --git a/read-cache.c b/read-cache.c
index 18af533649..28e7f24382 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -202,9 +202,12 @@ void fill_stat_cache_info(struct index_state *istate, =
struct cache_entry *ce, st
 =09}
 }
=20
-unsigned int ce_mode_from_stat(const struct cache_entry *ce, unsigned int =
mode)
+unsigned int ce_mode_from_stat(struct index_state *istate,
+=09=09=09       const struct cache_entry *ce,
+=09=09=09       unsigned int mode)
 {
-=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+=09struct repository *repo =3D (istate && istate->repo) ? istate->repo : t=
he_repository;
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
=20
 =09if (!has_symlinks && S_ISREG(mode) &&
 =09    ce && S_ISLNK(ce->ce_mode))
@@ -217,9 +220,10 @@ unsigned int ce_mode_from_stat(const struct cache_entr=
y *ce, unsigned int mode)
 =09return create_ce_mode(mode);
 }
=20
-static unsigned int st_mode_from_ce(const struct cache_entry *ce)
+static unsigned int st_mode_from_ce(struct index_state *istate, const stru=
ct cache_entry *ce)
 {
-=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+=09struct repository *repo =3D (istate && istate->repo) ? istate->repo : t=
he_repository;
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
=20
 =09switch (ce->ce_mode & S_IFMT) {
 =09case S_IFLNK:
@@ -235,10 +239,10 @@ static unsigned int st_mode_from_ce(const struct cach=
e_entry *ce)
 =09}
 }
=20
-int fake_lstat(const struct cache_entry *ce, struct stat *st)
+int fake_lstat(struct index_state *istate, const struct cache_entry *ce, s=
truct stat *st)
 {
 =09fake_lstat_data(&ce->ce_stat_data, st);
-=09st->st_mode =3D st_mode_from_ce(ce);
+=09st->st_mode =3D st_mode_from_ce(istate, ce);
=20
 =09/* always succeed as lstat() replacement */
 =09return 0;
@@ -322,10 +326,12 @@ static int ce_modified_check_fs(struct index_state *i=
state,
 =09return 0;
 }
=20
-static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *=
st)
+static int ce_match_stat_basic(struct index_state *istate,
+=09=09=09       const struct cache_entry *ce, struct stat *st)
 {
 =09unsigned int changed =3D 0;
-=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+=09struct repository *repo =3D (istate && istate->repo) ? istate->repo : t=
he_repository;
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
=20
 =09if (ce->ce_flags & CE_REMOVE)
 =09=09return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
@@ -430,7 +436,7 @@ int ie_match_stat(struct index_state *istate,
 =09if (ce_intent_to_add(ce))
 =09=09return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
=20
-=09changed =3D ce_match_stat_basic(ce, st);
+=09changed =3D ce_match_stat_basic(istate, ce, st);
=20
 =09/*
 =09 * Within 1 second of this sequence:
@@ -737,7 +743,8 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09=09  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
 =09unsigned hash_flags =3D pretend ? 0 : INDEX_WRITE_OBJECT;
=20
-=09struct repo_config_values *cfg =3D repo_config_values(the_repository);
+=09struct repository *repo =3D (istate && istate->repo) ? istate->repo : t=
he_repository;
+=09struct repo_config_values *cfg =3D repo_config_values(repo);
=20
 =09if (flags & ADD_CACHE_RENORMALIZE)
 =09=09hash_flags |=3D INDEX_RENORMALIZE;
@@ -769,7 +776,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09int pos =3D index_name_pos_also_unmerged(istate, path, namelen);
=20
 =09=09ent =3D (0 <=3D pos) ? istate->cache[pos] : NULL;
-=09=09ce->ce_mode =3D ce_mode_from_stat(ent, st_mode);
+=09=09ce->ce_mode =3D ce_mode_from_stat(istate, ent, st_mode);
 =09}
=20
 =09/* When core.ignorecase=3Dtrue, determine if a directory of the same na=
me but differing
@@ -2592,7 +2599,7 @@ static void ce_smudge_racily_clean_entry(struct index=
_state *istate,
=20
 =09if (lstat(ce->name, &st) < 0)
 =09=09return;
-=09if (ce_match_stat_basic(ce, &st))
+=09if (ce_match_stat_basic(istate, ce, &st))
 =09=09return;
 =09if (ce_modified_check_fs(istate, ce, &st)) {
 =09=09/* This is "racily clean"; smudge it.  Note that this
diff --git a/read-cache.h b/read-cache.h
index 3c4af2faeb..61299ed95b 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -5,7 +5,8 @@
 #include "object.h"
 #include "pathspec.h"
=20
-unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+unsigned int ce_mode_from_stat(struct index_state *istate,
+=09=09=09=09const struct cache_entry *ce,
 =09=09=09=09unsigned int mode);
=20
 static inline int ce_to_dtype(const struct cache_entry *ce)
--=20
2.43.0

