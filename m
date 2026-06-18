Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8281724
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782952; cv=none; b=H4DMJvQ3TH+UQcqH5LWs9Khatw5hz2RHXHM1qRodlrRQmcRbaMjH4fsuTQUHuH4/iQlGE2vj7d6tduqBlbjF61pBYftyvS9Ff5aHARXVznP9nfMxwJnPq8OrPjhw9zGE5cxQ7oqfmulyJSmXcgHeUcmAnKXF1aQtwgMlk/LESRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782952; c=relaxed/simple;
	bh=6ovpdmLQoh8YP99ffg9qv6mxIUpER0xycBTAPh/KhR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzdad4ptF3Raa0e4+BhW4cMVWBt+s5wV3ezyC0MnY3FsB8sYanxGpd4qUfWCoUF/pFLrLBvPdn+bi65VOkQKs8NvlxAnoEBVP6+ZmtBZPJ055nOlHvm5psRPHyI2ET2nok88XuS6JeJWjNtbg1VCKiF36nm8Tmv4UM5bhFRYwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=HAe1o9bo; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=dvM4Brhf; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="HAe1o9bo";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="dvM4Brhf"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=HAe1o9boouChJ1/vDfo4g3OYNh4Ee/F6ItIMMPDNi8BplUBQ+HPtQhLi7b1Xse3DMpBvmq5pgfSitNRiBHJSAp5933E2uRws9o/u5q2quU8ZJ46RpwdSRXIkoaL6/yB786sjaAZNNdAgWoeMB8wNdCLKo0TIaOOnrHaAscYtRPl10mqPHqWb/hLsH+Wnz7oV6dYtFW47mUaEXKrKv13sczmf768RZwwg4xoneyOHOnMjKpP+2SvkiUUWWrCuLOC+rzLavA2MN65lY8O04IkxgrPFW9EPOwOguBNP2l+9gZbaeblFIil1k0p8Eke6GdwS/JYdq11kJbO7hOcQ+z+bxA==; s=purelymail1; d=malon.dev; v=1; bh=6ovpdmLQoh8YP99ffg9qv6mxIUpER0xycBTAPh/KhR8=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=dvM4BrhfqsgeZPLGTh1AZgt5Ky5pN7ECDp5vwD1dpEj0GaFDGJjGhTdWnyl0yjr5qZ4KxcDS6JVC7sIlQ3wJzDyH9sCp5Zbg04zIjSQSNNxDTtkdEjHABZlBU+iVlWf1dlancZh0ELPGGanQGfQ853xTNtlHKtcTpx+AL3Oh2JXUqozKUefyYcmx2aBSdSihuDEkxxS4NooYPyW7TELrnTtLk2djWUXarSUarO3O3wH5jXSkr0kRIczbTKI5228tEzT5oV0Gnp0MHyxWby6ah3XHV8pGHSqpo1ms4OwPGxzmSYb/gvOywDQ3Q/8wAG1xSM5rCaIe3Qf9euN/pcJ6zA==; s=purelymail1; d=purelymail.com; v=1; bh=6ovpdmLQoh8YP99ffg9qv6mxIUpER0xycBTAPh/KhR8=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -632351446;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 18 Jun 2026 11:42:24 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	johannes.schindelin@gmx.de,
	stolee@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v2 2/2] config: use repo_ignore_case() to access core.ignorecase
Date: Thu, 18 Jun 2026 19:42:07 +0800
Message-ID: <20260618114207.605211-3-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618114207.605211-1-cat@malon.dev>
References: <20260617154929.564498-1-cat@malon.dev>
 <20260618114207.605211-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Replace the accesses to the global 'ignore_case' variable with
calls to 'repo_ignore_case(the_repository)'. This step eliminates
the 'ignore_case' global state.

Note on compat/win32/path-utils.c:
To eliminate the global state, several helper functions
(e.g. 'win32_fspathncmp()') now read from
'repo_ignore_case(the_repository)'. While this introduces
dependency on 'repository.h' into the 'compat/', it avoids massive
refactoring of the signatures across the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c                             |  2 +-
 builtin/fetch.c                     |  2 +-
 builtin/mv.c                        |  2 +-
 compat/win32/path-utils.c           |  3 ++-
 dir.c                               | 18 +++++++++---------
 environment.c                       |  3 +--
 environment.h                       |  1 -
 fsmonitor.c                         |  2 +-
 name-hash.c                         |  6 +++---
 read-cache.c                        |  6 +++---
 refs/files-backend.c                |  4 ++--
 submodule.c                         |  2 +-
 t/helper/test-lazy-init-name-hash.c |  2 +-
 unpack-trees.c                      |  2 +-
 14 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..620c88d2a0 100644
--- a/apply.c
+++ b/apply.c
@@ -4008,7 +4008,7 @@ static int path_is_beyond_symlink_1(struct apply_stat=
e *state, struct strbuf *na
 =09=09=09struct cache_entry *ce;
=20
 =09=09=09ce =3D index_file_exists(state->repo->index, name->buf,
-=09=09=09=09=09       name->len, ignore_case);
+=09=09=09=09=09       name->len, repo_ignore_case(the_repository));
 =09=09=09if (ce && S_ISLNK(ce->ce_mode))
 =09=09=09=09return 1;
 =09=09} else {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e4e8a72ed9..073e716bc4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1819,7 +1819,7 @@ static void ref_transaction_rejection_handler(const c=
har *refname,
 {
 =09struct ref_rejection_data *data =3D cb_data;
=20
-=09if (err =3D=3D REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
+=09if (err =3D=3D REF_TRANSACTION_ERROR_CASE_CONFLICT && repo_ignore_case(=
the_repository) &&
 =09    !data->case_sensitive_msg_shown) {
 =09=09error(_("You're on a case-insensitive filesystem, and the remote you=
 are\n"
 =09=09=09"trying to fetch from has references that only differ in casing. =
It\n"
diff --git a/builtin/mv.c b/builtin/mv.c
index 948b330639..d60582262c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -419,7 +419,7 @@ int cmd_mv(int argc,
 =09=09=09goto act_on_entry;
 =09=09}
 =09=09if (lstat(dst, &st) =3D=3D 0 &&
-=09=09    (!ignore_case || strcasecmp(src, dst))) {
+=09=09    (!repo_ignore_case(the_repository) || strcasecmp(src, dst))) {
 =09=09=09bad =3D _("destination exists");
 =09=09=09if (force) {
 =09=09=09=09/*
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index 966ef779b9..f779f367cf 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -2,6 +2,7 @@
=20
 #include "../../git-compat-util.h"
 #include "../../environment.h"
+#include "../../repository.h"
=20
 int win32_has_dos_drive_prefix(const char *path)
 {
@@ -75,7 +76,7 @@ int win32_fspathncmp(const char *a, const char *b, size_t=
 count)
 =09=09} else if (is_dir_sep(*b))
 =09=09=09return +1;
=20
-=09=09diff =3D ignore_case ?
+=09=09diff =3D repo_ignore_case(the_repository) ?
 =09=09=09(unsigned char)tolower(*a) - (int)(unsigned char)tolower(*b) :
 =09=09=09(unsigned char)*a - (int)(unsigned char)*b;
 =09=09if (diff)
diff --git a/dir.c b/dir.c
index 33c81c256e..540dd372c1 100644
--- a/dir.c
+++ b/dir.c
@@ -126,7 +126,7 @@ int count_slashes(const char *s)
=20
 int git_fspathcmp(const char *a, const char *b)
 {
-=09return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
+=09return repo_ignore_case(the_repository) ? strcasecmp(a, b) : strcmp(a, =
b);
 }
=20
 int fspatheq(const char *a, const char *b)
@@ -136,7 +136,7 @@ int fspatheq(const char *a, const char *b)
=20
 int git_fspathncmp(const char *a, const char *b, size_t count)
 {
-=09return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
+=09return repo_ignore_case(the_repository) ? strncasecmp(a, b, count) : st=
rncmp(a, b, count);
 }
=20
 int paths_collide(const char *a, const char *b)
@@ -153,7 +153,7 @@ int paths_collide(const char *a, const char *b)
=20
 unsigned int fspathhash(const char *str)
 {
-=09return ignore_case ? strihash(str) : strhash(str);
+=09return repo_ignore_case(the_repository) ? strihash(str) : strhash(str);
 }
=20
 int git_fnmatch(const struct pathspec_item *item,
@@ -202,7 +202,7 @@ static int fnmatch_icase_mem(const char *pattern, int p=
atternlen,
 =09=09use_str =3D str_buf.buf;
 =09}
=20
-=09if (ignore_case)
+=09if (repo_ignore_case(the_repository))
 =09=09flags |=3D WM_CASEFOLD;
 =09match_status =3D wildmatch(use_pat, use_str, flags);
=20
@@ -1851,7 +1851,7 @@ static struct dir_entry *dir_add_name(struct dir_stru=
ct *dir,
 =09=09=09=09      struct index_state *istate,
 =09=09=09=09      const char *pathname, int len)
 {
-=09if (index_file_exists(istate, pathname, len, ignore_case))
+=09if (index_file_exists(istate, pathname, len, repo_ignore_case(the_repos=
itory)))
 =09=09return NULL;
=20
 =09ALLOC_GROW(dir->entries, dir->nr+1, dir->internal.alloc);
@@ -1888,7 +1888,7 @@ static enum exist_status directory_exists_in_index_ic=
ase(struct index_state *ist
 =09if (index_dir_exists(istate, dirname, len))
 =09=09return index_directory;
=20
-=09ce =3D index_file_exists(istate, dirname, len, ignore_case);
+=09ce =3D index_file_exists(istate, dirname, len, repo_ignore_case(the_rep=
ository));
 =09if (ce && S_ISGITLINK(ce->ce_mode))
 =09=09return index_gitdir;
=20
@@ -1907,7 +1907,7 @@ static enum exist_status directory_exists_in_index(st=
ruct index_state *istate,
 {
 =09int pos;
=20
-=09if (ignore_case)
+=09if (repo_ignore_case(the_repository))
 =09=09return directory_exists_in_index_icase(istate, dirname, len);
=20
 =09pos =3D index_name_pos(istate, dirname, len);
@@ -2447,7 +2447,7 @@ static enum path_treatment treat_path(struct dir_stru=
ct *dir,
=20
 =09/* Always exclude indexed files */
 =09has_path_in_index =3D !!index_file_exists(istate, path->buf, path->len,
-=09=09=09=09=09=09ignore_case);
+=09=09=09=09=09=09repo_ignore_case(the_repository));
 =09if (dtype !=3D DT_DIR && has_path_in_index)
 =09=09return path_none;
=20
@@ -3201,7 +3201,7 @@ static int cmp_icase(char a, char b)
 {
 =09if (a =3D=3D b)
 =09=09return 0;
-=09if (ignore_case)
+=09if (repo_ignore_case(the_repository))
 =09=09return toupper(a) - toupper(b);
 =09return a - b;
 }
diff --git a/environment.c b/environment.c
index bfa3cb3045..c288c3613d 100644
--- a/environment.c
+++ b/environment.c
@@ -46,7 +46,6 @@ int trust_ctime =3D 1;
 int check_stat =3D 1;
 int has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D -1;
-int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg =3D -1; /* unspecified */
 int warn_on_object_refname_ambiguity =3D 1;
@@ -342,7 +341,7 @@ int git_default_core_config(const char *var, const char=
 *value,
 =09}
=20
 =09if (!strcmp(var, "core.ignorecase")) {
-=09=09ignore_case =3D git_config_bool(var, value);
+=09=09cfg->ignore_case =3D git_config_bool(var, value);
 =09=09return 0;
 =09}
=20
diff --git a/environment.h b/environment.h
index 39a8bf0b49..c15121db65 100644
--- a/environment.h
+++ b/environment.h
@@ -171,7 +171,6 @@ extern int trust_ctime;
 extern int check_stat;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
-extern int ignore_case;
 extern int assume_unchanged;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
diff --git a/fsmonitor.c b/fsmonitor.c
index d07dc18967..107767527e 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -453,7 +453,7 @@ static void fsmonitor_refresh_callback(struct index_sta=
te *istate, char *name)
 =09 * case-insensitive file system, try again using the name-hash
 =09 * and dir-name-hash.
 =09 */
-=09if (!nr_in_cone && ignore_case) {
+=09if (!nr_in_cone && repo_ignore_case(the_repository)) {
 =09=09nr_in_cone =3D handle_using_name_hash_icase(istate, name);
 =09=09if (!nr_in_cone)
 =09=09=09nr_in_cone =3D handle_using_dir_name_hash_icase(
diff --git a/name-hash.c b/name-hash.c
index b91e276267..83757db874 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -126,7 +126,7 @@ static void hash_index_entry(struct index_state *istate=
, struct cache_entry *ce)
 =09=09hashmap_add(&istate->name_hash, &ce->ent);
 =09}
=20
-=09if (ignore_case)
+=09if (repo_ignore_case(the_repository))
 =09=09add_dir_entry(istate, ce);
 }
=20
@@ -207,7 +207,7 @@ static int lookup_lazy_params(struct index_state *istat=
e)
 =09 * code to build the "istate->name_hash".  We don't
 =09 * need the complexity here.
 =09 */
-=09if (!ignore_case)
+=09if (!repo_ignore_case(the_repository))
 =09=09return 0;
=20
 =09nr_cpus =3D online_cpus();
@@ -651,7 +651,7 @@ void remove_name_hash(struct index_state *istate, struc=
t cache_entry *ce)
 =09ce->ce_flags &=3D ~CE_HASHED;
 =09hashmap_remove(&istate->name_hash, &ce->ent, ce);
=20
-=09if (ignore_case)
+=09if (repo_ignore_case(the_repository))
 =09=09remove_dir_entry(istate, ce);
 }
=20
diff --git a/read-cache.c b/read-cache.c
index 21829102ae..fcdf0e5ef1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -760,12 +760,12 @@ int add_to_index(struct index_state *istate, const ch=
ar *path, struct stat *st,
 =09 * case of the file being added to the repository matches (is folded in=
to) the existing
 =09 * entry's directory case.
 =09 */
-=09if (ignore_case) {
+=09if (repo_ignore_case(the_repository)) {
 =09=09adjust_dirname_case(istate, ce->name);
 =09}
 =09if (!(flags & ADD_CACHE_RENORMALIZE)) {
 =09=09alias =3D index_file_exists(istate, ce->name,
-=09=09=09=09=09  ce_namelen(ce), ignore_case);
+=09=09=09=09=09  ce_namelen(ce), repo_ignore_case(the_repository));
 =09=09if (alias &&
 =09=09    !ce_stage(alias) &&
 =09=09    !ie_match_stat(istate, alias, st, ce_option)) {
@@ -786,7 +786,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09} else
 =09=09set_object_name_for_intent_to_add_entry(ce);
=20
-=09if (ignore_case && alias && different_name(ce, alias))
+=09if (repo_ignore_case(the_repository) && alias && different_name(ce, ali=
as))
 =09=09ce =3D create_alias_ce(istate, ce, alias);
 =09ce->ce_flags |=3D CE_ADDED;
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4c7858787..c1da06b1d5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -806,7 +806,7 @@ static enum ref_transaction_error lock_raw_ref(struct f=
iles_ref_store *refs,
 =09=09} else {
 =09=09=09unable_to_lock_message(ref_file.buf, myerr, err);
 =09=09=09if (myerr =3D=3D EEXIST) {
-=09=09=09=09if (ignore_case &&
+=09=09=09=09if (repo_ignore_case(the_repository) &&
 =09=09=09=09    transaction_has_case_conflicting_update(transaction, updat=
e)) {
 =09=09=09=09=09/*
 =09=09=09=09=09 * In case-insensitive filesystems, ensure that conflicts w=
ithin a
@@ -920,7 +920,7 @@ static enum ref_transaction_error lock_raw_ref(struct f=
iles_ref_store *refs,
 =09=09 * conflicts between 'foo' and 'Foo/bar'. So let's lowercase
 =09=09 * the refname.
 =09=09 */
-=09=09if (ignore_case) {
+=09=09if (repo_ignore_case(the_repository)) {
 =09=09=09struct strbuf lower =3D STRBUF_INIT;
=20
 =09=09=09strbuf_addstr(&lower, refname);
diff --git a/submodule.c b/submodule.c
index a939ff5072..6e7f8b9f7c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2389,7 +2389,7 @@ static int validate_submodule_encoded_git_dir(char *g=
it_dir, const char *submodu
=20
 =09/* Prevent conflicts on case-folding filesystems */
 =09repo_config_get_bool(the_repository, "core.ignorecase", &config_ignorec=
ase);
-=09if (ignore_case || config_ignorecase) {
+=09if (repo_ignore_case(the_repository) || config_ignorecase) {
 =09=09bool suffixes_match =3D !strcmp(last_submodule_name, submodule_name)=
;
 =09=09return check_casefolding_conflict(git_dir, submodule_name,
 =09=09=09=09=09=09  suffixes_match);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-=
name-hash.c
index e542985c94..43cead6d7d 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -218,7 +218,7 @@ int cmd__lazy_init_name_hash(int argc, const char **arg=
v)
 =09/*
 =09 * istate->dir_hash is only created when ignore_case is set.
 =09 */
-=09ignore_case =3D 1;
+=09repo_config_values(the_repository)->ignore_case =3D 1;
=20
 =09if (dump) {
 =09=09if (perf || analyze > 0)
diff --git a/unpack-trees.c b/unpack-trees.c
index 998a1e6dc7..d13b004f71 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2428,7 +2428,7 @@ static int check_ok_to_remove(const char *name, int l=
en, int dtype,
 =09 *
 =09 * Ignore that lstat() if it matches.
 =09 */
-=09if (ignore_case && icase_exists(o, name, len, st))
+=09if (repo_ignore_case(the_repository) && icase_exists(o, name, len, st))
 =09=09return 0;
=20
 =09if (o->internal.dir &&
--=20
2.43.0

