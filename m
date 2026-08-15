Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205133BE64C
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 06:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776487; cv=none; b=UIi8kV9XS1dOhg0ST0toWVeH8VjIdvDdFoQo4cftsDv0Pbo5ArUX6BdXtTNX9k5s6zhhggoccRduarLYg81CCmDj6rIvzQLJuctSZjShsWLlWjnryP+Xs4z5FZU5Ien+jrX4AqCsGeNfp+dTLAv7M/BWwne3pmNqKJyz/hrCU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776487; c=relaxed/simple;
	bh=icEBrpFQcwKUE3aLYRV9ggRqk08Zc3QknQCiS0hvrP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxVTMYIppTV9XfZY6gMkI+/KwbNzSjDoahYK2Xb3/2FYJTJ6VGyFkthhgNN6k8yRzqvIH8yb96Tk598m+E9ARrl1/aUXYHRGKXEmEGQjt3iK3raSYR/NjmDYHWEWhu+D16Y32wV5V+xmq2J1yqbywQ4ymLqh+pwDhZEwxuvvqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=Rq+Bl81k; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WNX/P5iW; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="Rq+Bl81k";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WNX/P5iW"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Rq+Bl81kldigX0miGDV2zDd+R0u4DvFpppli4bAxJNZo9GPXMlhHCuWF9peUYNd20XhE9YgS5OCMwXH0O6xRYP/Xc08+FXulHUvWfHJvXjjs2W7llHj5r4sNOqxpgfvuVF1vd/vBBQXVO+ujRtV6TdUCXW8zFOqFrDYqReTyfBwaabg24Mujs/4IoTRG/FyCNqVet620Jev34FYLvGSU8etPMzywzRTRzY+MUqTT9k+OkuIZl/ebrOfzHJvRHGg43PNz+yxfpPqgwe5UR/xTC1MPU9J56uV0OMZlYzta1zcPtnicsz1jMD/ulljMHgqeKMB66F58lqyA35mvCjTh7g==; s=purelymail3; d=malon.dev; v=1; bh=icEBrpFQcwKUE3aLYRV9ggRqk08Zc3QknQCiS0hvrP0=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WNX/P5iWmuhLMY70apCPILKjY2Vq3liBN4Q6JfyjeDe5t20/8a8LkQWdF963TgeQscMX2ihUSw6u0iflrMokz1p7OBx/GNFM4fwcLSMAjq68tLtbsMGk5pF7s2mg4a8peTpDQWdo8QV87fbGnpQzcABNT3eZWtOT9Fck+/DwivzXefkbl2wbyl+d6NadzALwtZi7uAPxCkv/CjkoKpvO91IQk8BUcXNLiWrj4JF3RcrVcmWA4+j2zQmqZ1u1naKbF46DFdApyB4O/sK0I9BJTI2Adr8kE4a7fMa8lGTkFNiKwxpBTFr3fEaO5GwGOQ6e0iPrwepsDvZkg9BdNqxkGQ==; s=purelymail3; d=purelymail.com; v=1; bh=icEBrpFQcwKUE3aLYRV9ggRqk08Zc3QknQCiS0hvrP0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1793642447;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 15 Aug 2026 06:47:55 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v6] repository: move fetch_if_missing into struct repository
Date: Sat, 15 Aug 2026 14:47:46 +0800
Message-ID: <20260815064747.2196896-1-cat@malon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814072419.1666358-1-cat@malon.dev>
References: <20260814072419.1666358-1-cat@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The global variable 'fetch_if_missing' controls whether a missing
object check should prompt a lazy fetch from a promisor remote.
In order to continue the libification effort, move it into
'struct repository' and initialize it to 1 by default to keep the
previous behavior.

builtin/fetch-pack.c, builtin/fsck.c, and builtin/rev-list.c are
entered via commands marked RUN_SETUP in git.c:commands[]. Their
'repo' parameter is only NULL when '-h' is given outside of a
repository, in which case either show_usage_if_asked() or
parse_options()'s own '-h' handling exits the process before
returning. We can therefore drop their UNUSED markers and assign
to 'repo' directly.

builtin/index-pack.c is entered via RUN_SETUP_GENTLY, so its
'repo' pointer can be NULL any time it is run outside of a
repository, not only with '-h'. We keep a NULL check there and fall
back to 'the_repository'.

builtin/pack-objects.c needs two adjustments to make 'repo' reach
every 'fetch_if_missing' call site: 'read_stdin_packs()' now takes a
'struct repository *'; 'option_parse_missing_action()', which
is registered as an OPT_CALLBACK, receives a 'repo' through the
option's 'value' field now.

Additionally, update the partial clone documentation to reflect
that this is now a per-repository flag.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
Changes since v5:

 - for 'option_parse_missing_action' in builtin/pack-objects.c, pass in
 a repo instance via the option's 'value' field. Hence, the commit 1/2
 of the v5 iteration (pack-objects: give fetch_if_missing call sites
 access to 'repo') is no longer needed. Drop it.

 Documentation/technical/partial-clone.adoc |  2 +-
 builtin/fetch-pack.c                       |  6 ++--
 builtin/fsck.c                             |  6 ++--
 builtin/index-pack.c                       |  8 +++---
 builtin/pack-objects.c                     | 32 ++++++++++++----------
 builtin/prune.c                            |  2 +-
 builtin/rev-list.c                         | 17 ++++++------
 common-init.c                              |  2 +-
 git.c                                      |  2 +-
 midx-write.c                               |  2 +-
 odb.c                                      |  4 +--
 odb.h                                      |  8 ------
 repository.c                               |  1 +
 repository.h                               |  6 ++++
 revision.c                                 |  2 +-
 15 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/tec=
hnical/partial-clone.adoc
index e513e391ea..18718a3840 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -159,7 +159,7 @@ and prefetch those objects in bulk.
 - `repack` in GC has been updated to not touch promisor packfiles at all,
   and to only repack other objects.
=20
-- The global variable "fetch_if_missing" is used to control whether an
+- The per-repository flag "fetch_if_missing" is used to control whether an
   object lookup will attempt to dynamically fetch a missing object or
   report an error.
 +
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 316badd969..86754296fa 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -49,7 +49,7 @@ static void add_sought_entry(struct ref ***sought, int *n=
r, int *alloc,
 int cmd_fetch_pack(int argc,
 =09=09   const char **argv,
 =09=09   const char *prefix UNUSED,
-=09=09   struct repository *repo UNUSED)
+=09=09   struct repository *repo)
 {
 =09int i, ret;
 =09struct ref *fetched_refs =3D NULL, *remote_refs =3D NULL;
@@ -67,8 +67,6 @@ int cmd_fetch_pack(int argc,
 =09struct packet_reader reader;
 =09enum protocol_version version;
=20
-=09fetch_if_missing =3D 0;
-
 =09packet_trace_identity("fetch-pack");
=20
 =09memset(&args, 0, sizeof(args));
@@ -77,6 +75,8 @@ int cmd_fetch_pack(int argc,
=20
 =09show_usage_if_asked(argc, argv, fetch_pack_usage);
=20
+=09repo->fetch_if_missing =3D 0;
+
 =09for (i =3D 1; i < argc && *argv[i] =3D=3D '-'; i++) {
 =09=09const char *arg =3D argv[i];
=20
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a6c054e45b..8cfc0e8b26 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1017,15 +1017,15 @@ int cmd_fsck(int argc,
 =09=09.ref =3D NULL
 =09};
=20
-=09/* fsck knows how to handle missing promisor objects */
-=09fetch_if_missing =3D 0;
-
 =09errors_found =3D 0;
 =09disable_replace_refs();
 =09save_commit_buffer =3D 0;
=20
 =09argc =3D parse_options(argc, argv, prefix, fsck_opts, fsck_usage, 0);
=20
+=09/* fsck knows how to handle missing promisor objects */
+=09repo->fetch_if_missing =3D 0;
+
 =09fsck_options_init(&fsck_walk_options, repo, FSCK_OPTIONS_DEFAULT);
 =09fsck_walk_options.walk =3D mark_object;
=20
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..28f8d01e04 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1886,7 +1886,7 @@ static void repack_local_links(void)
 int cmd_index_pack(int argc,
 =09=09   const char **argv,
 =09=09   const char *prefix,
-=09=09   struct repository *repo UNUSED)
+=09=09   struct repository *repo)
 {
 =09int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, rev_index;
 =09const char *curr_index;
@@ -1903,15 +1903,15 @@ int cmd_index_pack(int argc,
 =09int report_end_of_input =3D 0;
 =09int hash_algo =3D 0;
=20
+=09show_usage_if_asked(argc, argv, index_pack_usage);
+
 =09/*
 =09 * index-pack never needs to fetch missing objects except when
 =09 * REF_DELTA bases are missing (which are explicitly handled). It only
 =09 * accesses the repo to do hash collision checks and to check which
 =09 * REF_DELTA bases need to be fetched.
 =09 */
-=09fetch_if_missing =3D 0;
-
-=09show_usage_if_asked(argc, argv, index_pack_usage);
+=09(repo ? repo : the_repository)->fetch_if_missing =3D 0;
=20
 =09disable_replace_refs();
=20
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1ec5b6f206..cb1bd39aee 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4087,9 +4087,10 @@ static void stdin_packs_read_input(struct rev_info *=
revs,
=20
 static void add_unreachable_loose_objects(struct rev_info *revs);
=20
-static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpa=
cked)
+static void read_stdin_packs(struct repository *repo,
+=09=09=09     enum stdin_packs_mode mode, int rev_list_unpacked)
 {
-=09int prev_fetch_if_missing =3D fetch_if_missing;
+=09int prev_fetch_if_missing =3D repo->fetch_if_missing;
 =09struct rev_info revs;
=20
 =09/*
@@ -4097,9 +4098,9 @@ static void read_stdin_packs(enum stdin_packs_mode mo=
de, int rev_list_unpacked)
 =09 * walk is best-effort though we don't want to perform backfill fetches
 =09 * for them.
 =09 */
-=09fetch_if_missing =3D 0;
+=09repo->fetch_if_missing =3D 0;
=20
-=09repo_init_revisions(the_repository, &revs, NULL);
+=09repo_init_revisions(repo, &revs, NULL);
 =09/*
 =09 * Use a revision walk to fill in the namehash of objects in the includ=
e
 =09 * packs. To save time, we'll avoid traversing through objects that are
@@ -4145,7 +4146,7 @@ static void read_stdin_packs(enum stdin_packs_mode mo=
de, int rev_list_unpacked)
 =09trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 =09=09=09   stdin_packs_hints_nr);
=20
-=09fetch_if_missing =3D prev_fetch_if_missing;
+=09repo->fetch_if_missing =3D prev_fetch_if_missing;
 }
=20
 static void add_cruft_object_entry(const struct object_id *oid, enum objec=
t_type type,
@@ -4455,9 +4456,11 @@ static void show_object__ma_allow_promisor(struct ob=
ject *obj, const char *name,
 =09show_object(obj, name, data);
 }
=20
-static int option_parse_missing_action(const struct option *opt UNUSED,
+static int option_parse_missing_action(const struct option *opt,
 =09=09=09=09       const char *arg, int unset)
 {
+=09struct repository *repo =3D opt->value;
+
 =09assert(arg);
 =09assert(!unset);
=20
@@ -4469,14 +4472,14 @@ static int option_parse_missing_action(const struct=
 option *opt UNUSED,
=20
 =09if (!strcmp(arg, "allow-any")) {
 =09=09arg_missing_action =3D MA_ALLOW_ANY;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_any;
 =09=09return 0;
 =09}
=20
 =09if (!strcmp(arg, "allow-promisor")) {
 =09=09arg_missing_action =3D MA_ALLOW_PROMISOR;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_promisor;
 =09=09return 0;
 =09}
@@ -5118,7 +5121,7 @@ static int parse_stdin_packs_mode(const struct option=
 *opt, const char *arg,
 int cmd_pack_objects(int argc,
 =09=09     const char **argv,
 =09=09     const char *prefix,
-=09=09     struct repository *repo UNUSED)
+=09=09     struct repository *repo)
 {
 =09int use_internal_rev_list =3D 0;
 =09int all_progress_implied =3D 0;
@@ -5225,7 +5228,7 @@ int cmd_pack_objects(int argc,
 =09=09=09      N_("write a bitmap index if possible"),
 =09=09=09      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
 =09=09OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
-=09=09OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
+=09=09OPT_CALLBACK_F(0, "missing", repo, N_("action"),
 =09=09  N_("handling for missing objects"), PARSE_OPT_NONEG,
 =09=09  option_parse_missing_action),
 =09=09OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
@@ -5345,7 +5348,7 @@ int cmd_pack_objects(int argc,
 =09=09=09=09  exclude_promisor_objects_best_effort,
 =09=09=09=09  "--exclude-promisor-objects-best-effort");
 =09if (exclude_promisor_objects) {
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
=20
 =09=09/* --stdin-packs handles promisor objects separately. */
 =09=09if (!stdin_packs) {
@@ -5354,8 +5357,9 @@ int cmd_pack_objects(int argc,
 =09=09}
 =09} else if (exclude_promisor_objects_best_effort) {
 =09=09use_internal_rev_list =3D 1;
-=09=09fetch_if_missing =3D 0;
-=09=09option_parse_missing_action(NULL, "allow-any", 0);
+=09=09arg_missing_action =3D MA_ALLOW_ANY;
+=09=09repo->fetch_if_missing =3D 0;
+=09=09fn_show_object =3D show_object__ma_allow_any;
 =09=09/* revs configured below */
 =09}
 =09if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
@@ -5471,7 +5475,7 @@ int cmd_pack_objects(int argc,
 =09=09progress_state =3D start_progress(the_repository,
 =09=09=09=09=09=09_("Enumerating objects"), 0);
 =09if (stdin_packs) {
-=09=09read_stdin_packs(stdin_packs, rev_list_unpacked);
+=09=09read_stdin_packs(repo, stdin_packs, rev_list_unpacked);
 =09} else if (cruft) {
 =09=09read_cruft_objects();
 =09} else if (!use_internal_rev_list) {
diff --git a/builtin/prune.c b/builtin/prune.c
index 55635a891f..a7e4678d11 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -194,7 +194,7 @@ int cmd_prune(int argc,
 =09if (show_progress =3D=3D -1)
 =09=09show_progress =3D isatty(2);
 =09if (exclude_promisor_objects) {
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09revs.exclude_promisor_objects =3D 1;
 =09}
=20
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 02818b81c6..6b596231ab 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -500,7 +500,8 @@ static void print_disk_usage(off_t size)
 =09strbuf_release(&sb);
 }
=20
-static inline int parse_missing_action_value(const char *value)
+static inline int parse_missing_action_value(struct repository *repo,
+=09=09=09=09=09     const char *value)
 {
 =09if (!strcmp(value, "error")) {
 =09=09arg_missing_action =3D MA_ERROR;
@@ -509,25 +510,25 @@ static inline int parse_missing_action_value(const ch=
ar *value)
=20
 =09if (!strcmp(value, "allow-any")) {
 =09=09arg_missing_action =3D MA_ALLOW_ANY;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "print")) {
 =09=09arg_missing_action =3D MA_PRINT;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "print-info")) {
 =09=09arg_missing_action =3D MA_PRINT_INFO;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "allow-promisor")) {
 =09=09arg_missing_action =3D MA_ALLOW_PROMISOR;
-=09=09fetch_if_missing =3D 0;
+=09=09repo->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
@@ -692,7 +693,7 @@ static void prepare_maximal_independent(struct rev_info=
 *revs)
 int cmd_rev_list(int argc,
 =09=09 const char **argv,
 =09=09 const char *prefix,
-=09=09 struct repository *repo UNUSED)
+=09=09 struct repository *repo)
 {
 =09struct rev_info revs;
 =09struct rev_list_info info;
@@ -745,10 +746,10 @@ int cmd_rev_list(int argc,
 =09for (i =3D 1; i < argc; i++) {
 =09=09const char *arg =3D argv[i];
 =09=09if (!strcmp(arg, "--exclude-promisor-objects")) {
-=09=09=09fetch_if_missing =3D 0;
+=09=09=09repo->fetch_if_missing =3D 0;
 =09=09=09revs.exclude_promisor_objects =3D 1;
 =09=09} else if (skip_prefix(arg, "--missing=3D", &arg)) {
-=09=09=09parse_missing_action_value(arg);
+=09=09=09parse_missing_action_value(repo, arg);
 =09=09} else if (!strcmp(arg, "-z")) {
 =09=09=09line_term =3D '\0';
 =09=09=09info_term =3D '\0';
diff --git a/common-init.c b/common-init.c
index d26c9c1f20..4a3fa4d7be 100644
--- a/common-init.c
+++ b/common-init.c
@@ -47,7 +47,7 @@ static void setup_environment(void)
 =09update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
=20
 =09if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 }
=20
 void init_git(const char **argv)
diff --git a/git.c b/git.c
index e5f1811b6b..f3ad3aad96 100644
--- a/git.c
+++ b/git.c
@@ -202,7 +202,7 @@ static int handle_options(const char ***argv, int *argc=
, int *envchanged)
 =09=09=09if (envchanged)
 =09=09=09=09*envchanged =3D 1;
 =09=09} else if (!strcmp(cmd, "--no-lazy-fetch")) {
-=09=09=09fetch_if_missing =3D 0;
+=09=09=09the_repository->fetch_if_missing =3D 0;
 =09=09=09setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
 =09=09=09if (envchanged)
 =09=09=09=09*envchanged =3D 1;
diff --git a/midx-write.c b/midx-write.c
index 580724d21a..8537102254 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -865,7 +865,7 @@ static void find_commits_for_midx_bitmap(struct commit_=
stack *commits,
 =09 * complain later that we don't have reachability closure (and fail
 =09 * appropriately).
 =09 */
-=09fetch_if_missing =3D 0;
+=09ctx->repo->fetch_if_missing =3D 0;
 =09revs.exclude_promisor_objects =3D 1;
=20
 =09if (prepare_revision_walk(&revs))
diff --git a/odb.c b/odb.c
index dabd481f57..110326f063 100644
--- a/odb.c
+++ b/odb.c
@@ -528,8 +528,6 @@ void disable_obj_read_lock(void)
 =09pthread_mutex_destroy(&obj_read_mutex);
 }
=20
-int fetch_if_missing =3D 1;
-
 static int register_all_submodule_sources(struct object_database *odb)
 {
 =09int ret =3D odb->submodule_source_paths.nr;
@@ -595,7 +593,7 @@ static int do_oid_object_info_extended(struct object_da=
tabase *odb,
 =09=09=09continue;
=20
 =09=09/* Check if it is a missing object */
-=09=09if (fetch_if_missing && repo_has_promisor_remote(odb->repo) &&
+=09=09if (odb->repo->fetch_if_missing && repo_has_promisor_remote(odb->rep=
o) &&
 =09=09    !already_retried &&
 =09=09    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 =09=09=09promisor_remote_get_direct(odb->repo, real, 1);
diff --git a/odb.h b/odb.h
index cbc2f9ced4..d3a1e378b6 100644
--- a/odb.h
+++ b/odb.h
@@ -15,14 +15,6 @@ struct repository;
 struct strbuf;
 struct strvec;
=20
-/*
- * Set this to 0 to prevent odb_read_object_info_extended() from fetching =
missing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
diff --git a/repository.c b/repository.c
index 651b0f6933..c2d954cf83 100644
--- a/repository.c
+++ b/repository.c
@@ -74,6 +74,7 @@ void initialize_repository(struct repository *repo)
 =09index_state_init(repo->index, repo);
 =09repo->check_deprecated_config =3D true;
 =09repo->bare_cfg =3D -1;
+=09repo->fetch_if_missing =3D 1;
 =09repo_config_values_init(&repo->config_values_private_);
=20
 =09/*
diff --git a/repository.h b/repository.h
index 3b467a2513..11f5c2ed10 100644
--- a/repository.h
+++ b/repository.h
@@ -184,6 +184,12 @@ struct repository {
 =09/* True if commit-graph has been disabled within this process. */
 =09int commit_graph_disabled;
=20
+=09/*
+=09 * Controls whether the repository should lazily fetch missing
+=09 * objects from promisor remotes. Defaults to 1.
+=09 */
+=09int fetch_if_missing;
+
 =09/*
 =09 * Lazily-populated cache mapping hook event names to configured hooks.
 =09 * NULL until first hook use.
diff --git a/revision.c b/revision.c
index 526bcf3fb5..40cb1cc828 100644
--- a/revision.c
+++ b/revision.c
@@ -2732,7 +2732,7 @@ static int handle_revision_opt(struct rev_info *revs,=
 int argc, const char **arg
 =09=09revs->ignore_missing =3D 1;
 =09} else if (opt && opt->allow_exclude_promisor_objects &&
 =09=09   !strcmp(arg, "--exclude-promisor-objects")) {
-=09=09if (fetch_if_missing)
+=09=09if (revs->repo->fetch_if_missing)
 =09=09=09BUG("exclude_promisor_objects can only be used when fetch_if_miss=
ing is 0");
 =09=09revs->exclude_promisor_objects =3D 1;
 =09} else {
--=20
2.43.0

