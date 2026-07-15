Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D5371D14
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078351; cv=none; b=HEXT/EkweyQg5kNssk57Pqjb5iEZKLa2orrlaaqOljd8SHz1KtyiI9BHe8puUGe+LkPp0b+OrImivUa3gBfIs5T4TFHvy83MJe7yylntV+nfm7BIptQDam1fXJ1Xu72sw1uOwuxsAo2HiEdEycZyQkLQARS5toBgXF2vAllnVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078351; c=relaxed/simple;
	bh=WWEUodUOZ4neRf/D3WsXoftuykC8Jj4/QCwLiEYEvac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tw8YQmFhWwtm2e37rQcfO94ppl5M/V4IX43/H9jz77xgKO7LeAJeazgS+Ae/PBA2KRTB23WAyQ/STsPvlLvmLBPyfwvtwEnnSFIKFuTYVakAG6823bY/9ptT4hd8iHRtmzfefM4fz6I7pnc49AYNSx1O6K31kF83JPN8214nl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=enV3DgCe; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=T5CjbRjQ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="enV3DgCe";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="T5CjbRjQ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=enV3DgCebj6plUagqVQhzThuLNQ5JreCCBaK5j2xT72TBTlcfmSdoKnpDcmb0P+xdRHfD3lW0dHhNg8ujkK0i21E2x/64l9Oy7JGr4vNb8wsT1ALNE4I92fAsgXrFlPj6ZYgafKMe0k9uTG6hMb1cqx/hx8UD4qkR6FtfHTtk4tyefMHsVd3h/h+5RFPU2UmV4ytBIuuftjDE3o0Um9nabZ6g8oAQGu9Yc/QQI2m//a+3cIS9dFdqBd500ptqVNeqc5RsL0AZSwTP7sIbKQj0JMOX84wkjeLD/L7/6N3OK9aWdNelJF69xWd1T89Y9W5mFB7glxykT9y6JTYCGDKFA==; s=purelymail1; d=malon.dev; v=1; bh=WWEUodUOZ4neRf/D3WsXoftuykC8Jj4/QCwLiEYEvac=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=T5CjbRjQa4upuu1tcvqWQqvKt+9EQQmOc0ZhTSaNjjTIKxgnwWmSCUPYhH6I/tc5tqixdVnswSkdWsVgFUO+9nMKdp9cRTt+1a+LVSyWs0YnVQHptggwcG3WzgTisPqTVTNV8eTDcbN8YPg33gwlM1M1iudW7Ek4P6axLgRzD8aw6FpsJok8hNssOy7g/HLaiDt6ld6tfLXetCiMSCxN7lU4YFlPWKvE/uzZZwqFa9lTpZrCB6SQjz1Wp+6ed9gw8yYADhLkGazSd3OYyNg5qV9K1OMFwMMow7E4rKmqtxql3LNPXPh0w+SApx2puN0sx3IRFykhgPqxlHQXgQ0L7Q==; s=purelymail1; d=purelymail.com; v=1; bh=WWEUodUOZ4neRf/D3WsXoftuykC8Jj4/QCwLiEYEvac=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1283426547;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 15 Jul 2026 01:19:06 +0000 (UTC)
From: Tian Yuchen <cat@malon.dev>
To: git@vger.kernel.org
Cc: ps@pks.im,
	five231003@gmail.com,
	hariom18599@gmail.com,
	Tian Yuchen <cat@malon.dev>,
	Christian Couder <christian.couder@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH v1] repository: move fetch_if_missing into struct repository
Date: Wed, 15 Jul 2026 09:18:50 +0800
Message-ID: <20260715011850.3181131-1-cat@malon.dev>
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

The global variable 'fetch_if_missing' controls whether a missing
object check should prompt a lazy fetch from a promisor remote.
In order to continue the libification effort, move it into
'struct repository' and initialize it to 1 by default to keep the
previous behavior.

Subsystems that already pass around a repository pointer, are
updated to read this flag directly from their respective 'repo'
instances. For the rest, we access 'the_repository'.

Note that in builtin/fsck.c and builtin/index-pack.c, when running
related commands with the '-h' parameter, the 'repo' pointer is not
passed in. To prevent null pointer dereferences, we defer
operations on the repo in until after parameter parsing is complete.

Additionally, update the partial clone documentation to reflect
that this is now a per-repository flag.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
Signed-off-by: Tian Yuchen <cat@malon.dev>
---
 Documentation/technical/partial-clone.adoc |  2 +-
 builtin/fetch-pack.c                       |  2 +-
 builtin/fsck.c                             |  6 +++---
 builtin/index-pack.c                       |  9 +++++----
 builtin/pack-objects.c                     | 14 +++++++-------
 builtin/prune.c                            |  2 +-
 builtin/rev-list.c                         | 10 +++++-----
 git.c                                      |  2 +-
 midx-write.c                               |  2 +-
 odb.c                                      |  4 +---
 odb.h                                      |  8 --------
 repository.c                               |  1 +
 repository.h                               |  6 ++++++
 revision.c                                 |  2 +-
 setup.c                                    |  2 +-
 15 files changed, 35 insertions(+), 37 deletions(-)

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
index 316badd969..c5edd7b80f 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -67,7 +67,7 @@ int cmd_fetch_pack(int argc,
 =09struct packet_reader reader;
 =09enum protocol_version version;
=20
-=09fetch_if_missing =3D 0;
+=09the_repository->fetch_if_missing =3D 0;
=20
 =09packet_trace_identity("fetch-pack");
=20
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 248f8ff5a0..aa31c69486 100644
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
index 0793dc595c..721d576938 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1881,7 +1881,7 @@ static void repack_local_links(void)
 int cmd_index_pack(int argc,
 =09=09   const char **argv,
 =09=09   const char *prefix,
-=09=09   struct repository *repo UNUSED)
+=09=09   struct repository *repo)
 {
 =09int i, fix_thin_pack =3D 0, verify =3D 0, stat_only =3D 0, rev_index;
 =09const char *curr_index;
@@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
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
+=09if (repo)
+=09=09repo->fetch_if_missing =3D 0;
=20
 =09disable_replace_refs();
=20
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8a1709a1ab..c6536b1f65 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4059,7 +4059,7 @@ static void add_unreachable_loose_objects(struct rev_=
info *revs);
=20
 static void read_stdin_packs(enum stdin_packs_mode mode, int rev_list_unpa=
cked)
 {
-=09int prev_fetch_if_missing =3D fetch_if_missing;
+=09int prev_fetch_if_missing =3D the_repository->fetch_if_missing;
 =09struct rev_info revs;
=20
 =09/*
@@ -4067,7 +4067,7 @@ static void read_stdin_packs(enum stdin_packs_mode mo=
de, int rev_list_unpacked)
 =09 * walk is best-effort though we don't want to perform backfill fetches
 =09 * for them.
 =09 */
-=09fetch_if_missing =3D 0;
+=09the_repository->fetch_if_missing =3D 0;
=20
 =09repo_init_revisions(the_repository, &revs, NULL);
 =09/*
@@ -4115,7 +4115,7 @@ static void read_stdin_packs(enum stdin_packs_mode mo=
de, int rev_list_unpacked)
 =09trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 =09=09=09   stdin_packs_hints_nr);
=20
-=09fetch_if_missing =3D prev_fetch_if_missing;
+=09the_repository->fetch_if_missing =3D prev_fetch_if_missing;
 }
=20
 static void add_cruft_object_entry(const struct object_id *oid, enum objec=
t_type type,
@@ -4451,14 +4451,14 @@ static int option_parse_missing_action(const struct=
 option *opt UNUSED,
=20
 =09if (!strcmp(arg, "allow-any")) {
 =09=09arg_missing_action =3D MA_ALLOW_ANY;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_any;
 =09=09return 0;
 =09}
=20
 =09if (!strcmp(arg, "allow-promisor")) {
 =09=09arg_missing_action =3D MA_ALLOW_PROMISOR;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09fn_show_object =3D show_object__ma_allow_promisor;
 =09=09return 0;
 =09}
@@ -5247,7 +5247,7 @@ int cmd_pack_objects(int argc,
 =09=09=09=09  exclude_promisor_objects_best_effort,
 =09=09=09=09  "--exclude-promisor-objects-best-effort");
 =09if (exclude_promisor_objects) {
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
=20
 =09=09/* --stdin-packs handles promisor objects separately. */
 =09=09if (!stdin_packs) {
@@ -5256,7 +5256,7 @@ int cmd_pack_objects(int argc,
 =09=09}
 =09} else if (exclude_promisor_objects_best_effort) {
 =09=09use_internal_rev_list =3D 1;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09option_parse_missing_action(NULL, "allow-any", 0);
 =09=09/* revs configured below */
 =09}
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
index 8f63003709..a6a0c5559e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -509,25 +509,25 @@ static inline int parse_missing_action_value(const ch=
ar *value)
=20
 =09if (!strcmp(value, "allow-any")) {
 =09=09arg_missing_action =3D MA_ALLOW_ANY;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "print")) {
 =09=09arg_missing_action =3D MA_PRINT;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "print-info")) {
 =09=09arg_missing_action =3D MA_PRINT_INFO;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
 =09if (!strcmp(value, "allow-promisor")) {
 =09=09arg_missing_action =3D MA_ALLOW_PROMISOR;
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 =09=09return 1;
 =09}
=20
@@ -745,7 +745,7 @@ int cmd_rev_list(int argc,
 =09for (i =3D 1; i < argc; i++) {
 =09=09const char *arg =3D argv[i];
 =09=09if (!strcmp(arg, "--exclude-promisor-objects")) {
-=09=09=09fetch_if_missing =3D 0;
+=09=09=09the_repository->fetch_if_missing =3D 0;
 =09=09=09revs.exclude_promisor_objects =3D 1;
 =09=09} else if (skip_prefix(arg, "--missing=3D", &arg)) {
 =09=09=09parse_missing_action_value(arg);
diff --git a/git.c b/git.c
index 36f08891ef..315d2e160e 100644
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
index 19e1cd10b7..e7313c9d2c 100644
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
index 965ef68e4e..664256e1a4 100644
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
index 0030467a52..1dca583fcb 100644
--- a/odb.h
+++ b/odb.h
@@ -14,14 +14,6 @@ struct repository;
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
index 187dd471c4..b959f7a028 100644
--- a/repository.c
+++ b/repository.c
@@ -73,6 +73,7 @@ void initialize_repository(struct repository *repo)
 =09ALLOC_ARRAY(repo->index, 1);
 =09index_state_init(repo->index, repo);
 =09repo->check_deprecated_config =3D true;
+=09repo->fetch_if_missing =3D 1;
 =09repo_config_values_init(&repo->config_values_private_);
=20
 =09/*
diff --git a/repository.h b/repository.h
index 36e2db2633..e8bd6ef0e7 100644
--- a/repository.h
+++ b/repository.h
@@ -169,6 +169,12 @@ struct repository {
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
index e91d7e1f11..bb645654c3 100644
--- a/revision.c
+++ b/revision.c
@@ -2714,7 +2714,7 @@ static int handle_revision_opt(struct rev_info *revs,=
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
diff --git a/setup.c b/setup.c
index b4652651df..ce2a80ac31 100644
--- a/setup.c
+++ b/setup.c
@@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct repository =
*repo,
 =09=09set_alternate_shallow_file(repo, shallow_file, 0);
=20
 =09if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
-=09=09fetch_if_missing =3D 0;
+=09=09the_repository->fetch_if_missing =3D 0;
 }
=20
 static void set_git_dir_1(struct repository *repo, const char *path)
--=20
2.43.0

