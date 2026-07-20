Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D3D3ED13B
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544840; cv=none; b=LeOJ9Gqfl/Av98ruRLO4gY6VO8WwcxqujmBeVBypum0i4O3PXQUdFlvx+TXvlZrlO2yuZ8ToB4ovCAqX8h8oN4/sbhzNRIBwNORlmqIcAjHPNHfSKFElFEOAl/hv1mrl3oqf5/78QBEr12qk7cTKbl9+/30ATxFAtCmRFGLO3GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544840; c=relaxed/simple;
	bh=tbS06KO8x9itsHqMbT8OjRxHlNfN7cksQ5e5cxCZqpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJyPS6jDvp2Elwx7OXQ0sXJB0cZKel7yMO8+xRHCJp/d9xfDMYhaKFmGDwjToJVsTX+ArB8N/bjaQEuFPLfuTejXtcEv83+dAHR/dbADqrItE3H3Ua0msYY0AmSF3BMD1U6Hta0D3resultGEhQNCbdYqvuOEqrTHb3ulncLHvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=L+oxBxZG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=TDOtbR54; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="L+oxBxZG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="TDOtbR54"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=L+oxBxZG00Gj3Dw+PL6c3BxJgLB0hGwmu0rHpw/gMA6/der4BJekQoueD8B/3W7nDsLE5J64VLNngW2ENBxJdOvdVau4u2g/6xAgd/TaEtPMnoggv7xOjq8Q7g5tHB4qCoVNAdXlelMPVBa8n6vss9nz25ZC/Pns8NsSIQGlT9j1k44CrHWFveflbE4QmzyEM1WYiJYATDVY2JOfErpkpcjN0CubSIMIa19mz1L5B1lJyjOGKicRaM6sKg84P2BfugeeAfAbA0dGyQT7frE2LcIdMxycc0z3fgBFmGfitmqzrADDRHOmuRrcmgiUwgcboLfJ2svbyk0PfULHqF24Fg==; s=purelymail2; d=malon.dev; v=1; bh=tbS06KO8x9itsHqMbT8OjRxHlNfN7cksQ5e5cxCZqpU=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=TDOtbR54ZXnR6FOj2BXNW430Paj3Zuag9H9p/h2Q9TsIJBjm9z9Jdrmo0025a1/uAa+EeD+/8I8N9EN6x1eaG2dyoV2byuT0GbHc1zqvpxcl2x+BdGXCPKugIFSO+Tm791Zf2T77ewfu799ec4qrHYpL1alAQTv6LD5k+edsWdD/MFo7uZmFG7hCxfWmMJ+HNKoNgzDQT3NodEjWQnYwx8io3vBOotwPi27AwXPvwlBFLCdff0GaETCOqDcKidl3ULE0qbOyqAADnVr0TckXlS0/RNmUYgvJl9LaJg1qlP4IpL3QR0EtRQeQ1iOKFPch40oA5QKn7zGb1ogm4IrM6A==; s=purelymail2; d=purelymail.com; v=1; bh=tbS06KO8x9itsHqMbT8OjRxHlNfN7cksQ5e5cxCZqpU=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1835461667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 20 Jul 2026 10:53:52 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v8 2/4] read-cache: pass 'repo' to 'ce_mode_from_stat()'
Date: Mon, 20 Jul 2026 18:53:33 +0800
Message-ID: <20260720105335.3202013-3-cat@malon.dev>
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

The ce_mode_from_stat() function is a performance-critical static
inline helper in 'read-cache.h'. As we migrate configuration
variables into the repository struct, this helper needs access
to the repository context.

Update the signature of ce_mode_from_stat() to take a 'struct
repository *' parameter, and update all callers to pass the
appropriate repository instance.

To prepare for the overhead of replacing cheap global variable
accesses with getter functions, the boolean expressions are
reordered to evaluate 'S_ISREG(mode)' first.

While at it, add a comment for ce_mode_from_stat().

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 apply.c                |  2 +-
 builtin/update-index.c |  2 +-
 diff-lib.c             | 10 +++++-----
 read-cache.c           |  2 +-
 read-cache.h           | 15 ++++++++++++---
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index 249248d4f2..26286eb57b 100644
--- a/apply.c
+++ b/apply.c
@@ -3894,7 +3894,7 @@ static int check_preimage(struct apply_state *state,
 =09=09=09BUG("ce_mode =3D=3D 0 for path '%s'", old_name);
=20
 =09=09if (trust_executable_bit || !S_ISREG(st->st_mode))
-=09=09=09st_mode =3D ce_mode_from_stat(*ce, st->st_mode);
+=09=09=09st_mode =3D ce_mode_from_stat(state->repo, *ce, st->st_mode);
 =09=09else if (*ce)
 =09=09=09st_mode =3D (*ce)->ce_mode;
 =09=09else
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..7917bd286f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -293,7 +293,7 @@ static int add_one_path(const struct cache_entry *old, =
const char *path, int len
 =09ce->ce_flags =3D create_ce_flags(0);
 =09ce->ce_namelen =3D len;
 =09fill_stat_cache_info(the_repository->index, ce, st);
-=09ce->ce_mode =3D ce_mode_from_stat(old, st->st_mode);
+=09ce->ce_mode =3D ce_mode_from_stat(the_repository, old, st->st_mode);
=20
 =09if (index_path(the_repository->index, &ce->oid, path, st,
 =09=09       info_only ? 0 : INDEX_WRITE_OBJECT)) {
diff --git a/diff-lib.c b/diff-lib.c
index ae91027a02..46cae637ec 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -160,7 +160,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
=20
 =09=09=09changed =3D check_removed(ce, &st);
 =09=09=09if (!changed)
-=09=09=09=09wt_mode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09=09wt_mode =3D ce_mode_from_stat(revs->repo, ce, st.st_mode);
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
o, nce, mode);
 =09=09=09=09=09dpath->parent[stage-2].status =3D
 =09=09=09=09=09=09DIFF_STATUS_MODIFIED;
 =09=09=09=09}
@@ -262,7 +262,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
 =09=09=09=09continue;
 =09=09=09} else if (revs->diffopt.ita_invisible_in_index &&
 =09=09=09=09   ce_intent_to_add(ce)) {
-=09=09=09=09newmode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09=09newmode =3D ce_mode_from_stat(revs->repo, ce, st.st_mode);
 =09=09=09=09diff_addremove(&revs->diffopt, '+', newmode,
 =09=09=09=09=09       null_oid(the_hash_algo), 0, ce->name, 0);
 =09=09=09=09continue;
@@ -270,7 +270,7 @@ void run_diff_files(struct rev_info *revs, unsigned int=
 option)
=20
 =09=09=09changed =3D match_stat_with_submodule(&revs->diffopt, ce, &st,
 =09=09=09=09=09=09=09    ce_option, &dirty_submodule);
-=09=09=09newmode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09newmode =3D ce_mode_from_stat(revs->repo, ce, st.st_mode);
 =09=09}
=20
 =09=09if (!changed && !dirty_submodule) {
@@ -338,7 +338,7 @@ static int get_stat_data(const struct cache_entry *ce,
 =09=09changed =3D match_stat_with_submodule(diffopt, ce, &st,
 =09=09=09=09=09=09    0, dirty_submodule);
 =09=09if (changed) {
-=09=09=09mode =3D ce_mode_from_stat(ce, st.st_mode);
+=09=09=09mode =3D ce_mode_from_stat(diffopt->repo, ce, st.st_mode);
 =09=09=09oid =3D null_oid(the_hash_algo);
 =09=09}
 =09}
diff --git a/read-cache.c b/read-cache.c
index c44e4d128f..b37bf688ec 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -749,7 +749,7 @@ int add_to_index(struct index_state *istate, const char=
 *path, struct stat *st,
 =09=09int pos =3D index_name_pos_also_unmerged(istate, path, namelen);
=20
 =09=09ent =3D (0 <=3D pos) ? istate->cache[pos] : NULL;
-=09=09ce->ce_mode =3D ce_mode_from_stat(ent, st_mode);
+=09=09ce->ce_mode =3D ce_mode_from_stat(istate->repo, ent, st_mode);
 =09}
=20
 =09/* When core.ignorecase=3Dtrue, determine if a directory of the same na=
me but differing
diff --git a/read-cache.h b/read-cache.h
index 043da1f1aa..af8c657ecb 100644
--- a/read-cache.h
+++ b/read-cache.h
@@ -4,15 +4,24 @@
 #include "read-cache-ll.h"
 #include "object.h"
 #include "pathspec.h"
+#include "environment.h"
=20
-static inline unsigned int ce_mode_from_stat(const struct cache_entry *ce,
+/*
+ * Determine the appropriate index mode for a file based on its stat()
+ * information and the existing cache entry (if any).
+ *
+ * This function handles degradation for filesystems that lack
+ * symlink support or reliable executable bits.
+ */
+static inline unsigned int ce_mode_from_stat(struct repository *repo UNUSE=
D,
+=09=09=09=09=09     const struct cache_entry *ce,
 =09=09=09=09=09     unsigned int mode)
 {
 =09extern int trust_executable_bit, has_symlinks;
-=09if (!has_symlinks && S_ISREG(mode) &&
+=09if (S_ISREG(mode) && !has_symlinks &&
 =09    ce && S_ISLNK(ce->ce_mode))
 =09=09return ce->ce_mode;
-=09if (!trust_executable_bit && S_ISREG(mode)) {
+=09if (S_ISREG(mode) && !trust_executable_bit) {
 =09=09if (ce && S_ISREG(ce->ce_mode))
 =09=09=09return ce->ce_mode;
 =09=09return create_ce_mode(0666);
--=20
2.43.0

