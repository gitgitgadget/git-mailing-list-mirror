Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44DC433FE
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiCDPFa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiCDPF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959DE15AF3B
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7373437wmj.0
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kHqV7XlU8o+YWLSS1P7lvcDhSCsVyJvx3hxo3CKTTho=;
        b=jLF6iw2qKZPpyGn2oUImkwa1dmkOqN/As+SLnLhO86xZbLj0NQM+6GN9ZDmfAk/BjI
         ZWAs2AqX+w75CBHfLP/A6WZLkewjFG7aaw1z3GtoHiY7cvIoetuBMUT9Wym6tNzLsZu+
         Ggviq3mCzB4hZJMMtj49uKdN1KFUdA8QMVXEygpntbQG7Am+ZVKLgIWSjKlXkFde+zge
         G7kUOvi10eNES/l3Fj1LX9dRSzf7V3oVZ+vUxqFwq5heOgZlY+19Q+Rp2RJ8Ygt/oaVW
         JMrAXPazx7OgR56ADHQtTYVNxcqvbyy435356JocqDwsC2BHKtujNMt2HH7JQ3u1VOAt
         I5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kHqV7XlU8o+YWLSS1P7lvcDhSCsVyJvx3hxo3CKTTho=;
        b=EP+ToKo7Qf0QPAEA5hglYkuqENgSYoW5bpbpGovS/ihHJ0enAYVVk473qPdukkthbP
         EcmD2M4/a3heHepxT3E7UWuBaCGX3JKhxqs2/Nn6Q51nnZUgjnxtJJSWTCCR2kKCeiUW
         /nYipDPThxMYd4otFlGAsLwB22QIwWjvnNp2D35rN8iNuo1w1RoxBySZlbW4SZIbc/qQ
         kAInizfJdvRkGHqZ3ENsQmvndrRSCcamTP3vKxJXu55Sg6y1OacAPT3QC3qh3WYMXYR4
         DWL6YWh4SW2fJ8EOxyW9vQv3vEQjc9W9mx1NFJKe+T7DFl53D9x7TL8ofZniC/JtqTsg
         UASQ==
X-Gm-Message-State: AOAM531Wk8rVttieHE6bpqE64ZVIirM5ILmawxjkUmsz623b6kMmY7ZJ
        7UYeNam0cGa9gXjORN0ZlYsWD97r+1o=
X-Google-Smtp-Source: ABdhPJyMJUeKwjBwq3p8VXAXn987OEdlgNZs9DpKSYpyi7NvuvvIpJR/6Lfj5ilbfjmGBbNm1z+uyA==
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id w22-20020a1cf616000000b0037d1e1cf90amr7751550wmc.148.1646406276321;
        Fri, 04 Mar 2022 07:04:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay10-20020a5d6f0a000000b001f02d3ec83csm4818454wrb.59.2022.03.04.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:35 -0800 (PST)
Message-Id: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:27 +0000
Subject: [PATCH v3 0/7] fetch: add repair: full refetch without negotiation (was: "refiltering")
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a filter is changed on a partial clone repository, for example from
blob:none to blob:limit=1m, there is currently no straightforward way to
bulk-refetch the objects that match the new filter for existing local
commits. This is because the client will report commits as "have" during
fetch negotiation and any dependent objects won't be included in the
transferred pack. Another use case is discussed at [1].

This patch series introduces a --refetch option to fetch & fetch-pack to
enable doing a full fetch without performing any commit negotiation with the
remote, as a fresh clone does. It builds upon cbe566a071 ("negotiator/noop:
add noop fetch negotiator", 2020-08-18).

 * Using --refetch will produce duplicated objects between the existing and
   newly fetched packs, but maintenance will clean them up when it runs
   automatically post-fetch (if enabled).
 * If a user fetches with --refetch applying a more restrictive partial
   clone filter than previously (eg: blob:limit=1m then blob:limit=1k) the
   eventual state is a no-op, since any referenced object already in the
   local repository is never removed. More advanced repacking which could
   improve this scenario is currently proposed at [2].

[1]
https://lore.kernel.org/git/aa7b89ee-08aa-7943-6a00-28dcf344426e@syntevo.com/
[2]
https://lore.kernel.org/git/21ED346B-A906-4905-B061-EDE53691C586@gmail.com/

Changes since v2:

 * Changed the name from "repair" to "refetch". While it's conceivable to
   use it in some object DB repair situations that's not the focus of these
   changes.
 * Pass config options to maintenance via GIT_CONFIG_PARAMETERS
 * Split out auto-maintenance to a separate & more robust test
 * Minor fixes/improvements from reviews by Junio & Ævar

Changes since RFC (v1):

 * Changed the name from "refilter" to "repair"
 * Removed dependency between server-side support for filtering and repair
 * Added a test case for a shallow clone
 * Post-fetch auto maintenance now strongly encourages
   repacking/consolidation

Robert Coup (7):
  fetch-negotiator: add specific noop initializer
  fetch-pack: add refetch
  builtin/fetch-pack: add --refetch option
  fetch: add --refetch option
  t5615-partial-clone: add test for fetch --refetch
  fetch: after refetch, encourage auto gc repacking
  doc/partial-clone: mention --refetch fetch option

 Documentation/fetch-options.txt           | 10 +++
 Documentation/git-fetch-pack.txt          |  4 ++
 Documentation/technical/partial-clone.txt |  3 +
 builtin/fetch-pack.c                      |  4 ++
 builtin/fetch.c                           | 34 +++++++++-
 fetch-negotiator.c                        |  5 ++
 fetch-negotiator.h                        |  8 +++
 fetch-pack.c                              | 46 ++++++++-----
 fetch-pack.h                              |  1 +
 remote-curl.c                             |  6 ++
 t/t5616-partial-clone.sh                  | 81 ++++++++++++++++++++++-
 transport-helper.c                        |  3 +
 transport.c                               |  4 ++
 transport.h                               |  4 ++
 14 files changed, 193 insertions(+), 20 deletions(-)


base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1138%2Frcoup%2Frc-partial-clone-refilter-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1138/rcoup/rc-partial-clone-refilter-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1138

Range-diff vs v2:

 1:  d146d8aaaaf ! 1:  96a75be3d8a fetch-negotiator: add specific noop initializor
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch-negotiator: add specific noop initializor
     +    fetch-negotiator: add specific noop initializer
      
     -    Add a specific initializor for the noop fetch negotiator. This is
     +    Add a specific initializer for the noop fetch negotiator. This is
          introduced to support allowing partial clones to skip commit negotiation
     -    when fetching to repair or apply a modified filter.
     +    when performing a "refetch".
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
 2:  2d817a65db5 ! 2:  04ca6a07f85 fetch-pack: add repairing
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch-pack: add repairing
     +    fetch-pack: add refetch
      
     -    Allow a 'repair fetch' where the contents of the local object store are
     +    Allow a "refetch" where the contents of the local object store are
          ignored and a full fetch is performed, not attempting to find or
          negotiate common commits with the remote.
      
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      -		if (((o = lookup_object(the_repository, remote)) != NULL) &&
      -				(o->flags & COMPLETE)) {
      -			continue;
     -+		if (!args->repair) {
     ++		if (!args->refetch) {
      +			/*
      +			* If that object is complete (i.e. it is an ancestor of a
      +			* local ref), we tell them we have it but do not have to
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       
       		remote_hex = oid_to_hex(remote);
      @@ fetch-pack.c: static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
     + 	int old_save_commit_buffer = save_commit_buffer;
     + 	timestamp_t cutoff = 0;
       
     - 	save_commit_buffer = 0;
     - 
     -+	if (args->repair)
     ++	if (args->refetch)
      +		return;
      +
     + 	save_commit_buffer = 0;
     + 
       	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
     - 	for (ref = *refs; ref; ref = ref->next) {
     - 		struct commit *commit;
      @@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 	struct fetch_negotiator negotiator_alloc;
       	struct fetch_negotiator *negotiator;
       
     --	negotiator = &negotiator_alloc;
     + 	negotiator = &negotiator_alloc;
      -	fetch_negotiator_init(r, negotiator);
     --
     - 	sort_ref_list(&ref, ref_compare_name);
     - 	QSORT(sought, nr_sought, cmp_ref_by_name);
     - 
     -@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     - 	if (!server_supports_hash(the_hash_algo->name, NULL))
     - 		die(_("Server does not support this repository's object format"));
     - 
     -+	negotiator = &negotiator_alloc;
     -+	if (args->repair) {
     ++	if (args->refetch) {
      +		fetch_negotiator_init_noop(negotiator);
      +	} else {
      +		fetch_negotiator_init(r, negotiator);
      +	}
     -+
     + 
     + 	sort_ref_list(&ref, ref_compare_name);
     + 	QSORT(sought, nr_sought, cmp_ref_by_name);
     +@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     + 
       	mark_complete_and_common_ref(negotiator, args, &ref);
       	filter_refs(args, &ref, sought, nr_sought);
      -	if (everything_local(args, &ref)) {
     -+	if (!args->repair && everything_local(args, &ref)) {
     ++	if (!args->refetch && everything_local(args, &ref)) {
       		packet_flush(fd[1]);
       		goto all_done;
       	}
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       
       	negotiator = &negotiator_alloc;
      -	fetch_negotiator_init(r, negotiator);
     -+	if (args->repair)
     ++	if (args->refetch)
      +		fetch_negotiator_init_noop(negotiator);
      +	else
      +		fetch_negotiator_init(r, negotiator);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       			mark_complete_and_common_ref(negotiator, args, &ref);
       			filter_refs(args, &ref, sought, nr_sought);
      -			if (everything_local(args, &ref))
     -+			if (!args->repair && everything_local(args, &ref))
     ++			if (!args->refetch && everything_local(args, &ref))
       				state = FETCH_DONE;
       			else
       				state = FETCH_SEND_REQUEST;
     @@ fetch-pack.h: struct fetch_pack_args {
       	unsigned update_shallow:1;
       	unsigned reject_shallow_remote:1;
       	unsigned deepen:1;
     -+	unsigned repair:1;
     ++	unsigned refetch:1;
       
       	/*
       	 * Indicate that the remote of this request is a promisor remote. The
 3:  a42d40ac294 ! 3:  879d30c4473 builtin/fetch-pack: add --repair option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    builtin/fetch-pack: add --repair option
     +    builtin/fetch-pack: add --refetch option
      
     -    Add a --repair option to fetch-pack to force a full fetch. Use when
     +    Add a refetch option to fetch-pack to force a full fetch. Use when
          applying a new partial clone filter to refetch all matching objects.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
     @@ Documentation/git-fetch-pack.txt: be in a separate packet, and the list must end
       	current shallow boundary instead of from the tip of each
       	remote branch history.
       
     -+--repair::
     ++--refetch::
      +	Skips negotiating commits with the server in order to fetch all matching
      +	objects. Use to reapply a new partial clone blob/tree filter.
      +
     @@ builtin/fetch-pack.c: int cmd_fetch_pack(int argc, const char **argv, const char
       			args.from_promisor = 1;
       			continue;
       		}
     -+		if (!strcmp("--repair", arg)) {
     -+			args.repair = 1;
     ++		if (!strcmp("--refetch", arg)) {
     ++			args.refetch = 1;
      +			continue;
      +		}
       		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
     @@ remote-curl.c: struct options {
       		/* see documentation of corresponding flag in fetch-pack.h */
       		from_promisor : 1,
       
     -+		repair : 1,
     ++		refetch : 1,
       		atomic : 1,
       		object_format : 1,
       		force_if_includes : 1;
     @@ remote-curl.c: static int set_option(const char *name, const char *value)
       	} else if (!strcmp(name, "from-promisor")) {
       		options.from_promisor = 1;
       		return 0;
     -+	} else if (!strcmp(name, "repair")) {
     -+		options.repair = 1;
     ++	} else if (!strcmp(name, "refetch")) {
     ++		options.refetch = 1;
      +		return 0;
       	} else if (!strcmp(name, "filter")) {
       		options.filter = xstrdup(value);
     @@ remote-curl.c: static int fetch_git(struct discovery *heads,
       		strvec_push(&args, "--deepen-relative");
       	if (options.from_promisor)
       		strvec_push(&args, "--from-promisor");
     -+	if (options.repair)
     -+		strvec_push(&args, "--repair");
     ++	if (options.refetch)
     ++		strvec_push(&args, "--refetch");
       	if (options.filter)
       		strvec_pushf(&args, "--filter=%s", options.filter);
       	strvec_push(&args, url.buf);
 4:  79c409d0542 ! 4:  a503b98f333 fetch: add --repair option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch: add --repair option
     +    fetch: add --refetch option
      
     -    Teach fetch and transports the --repair option to force a full fetch
     +    Teach fetch and transports the --refetch option to force a full fetch
          without negotiating common commits with the remote. Use when applying a
          new partial clone filter to refetch all matching objects.
      
     @@ Documentation/fetch-options.txt: endif::git-pull[]
       	setting. See linkgit:git-config[1].
       
      +ifndef::git-pull[]
     -+--repair::
     ++--refetch::
      +	Instead of negotiating with the server to avoid transferring commits and
      +	associated objects that are already present locally, this option fetches
      +	all objects as a fresh clone would. Use this to reapply a partial clone
     @@ builtin/fetch.c: static int prune_tags = -1; /* unspecified */
       static int all, append, dry_run, force, keep, multiple, update_head_ok;
       static int write_fetch_head = 1;
      -static int verbosity, deepen_relative, set_upstream;
     -+static int verbosity, deepen_relative, set_upstream, repair;
     ++static int verbosity, deepen_relative, set_upstream, refetch;
       static int progress = -1;
       static int enable_auto_gc = 1;
       static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
     @@ builtin/fetch.c: static struct option builtin_fetch_options[] = {
       	OPT_SET_INT_F(0, "unshallow", &unshallow,
       		      N_("convert to a complete repository"),
       		      1, PARSE_OPT_NONEG),
     -+	OPT_SET_INT_F(0, "repair", &repair,
     ++	OPT_SET_INT_F(0, "refetch", &refetch,
      +		      N_("re-fetch without negotiating common commits"),
      +		      1, PARSE_OPT_NONEG),
       	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
     @@ builtin/fetch.c: static int check_exist_and_connected(struct ref *ref_map)
       		return -1;
       
      +	/*
     -+	 * Similarly, if we need to repair, we always want to perform a full
     ++	 * Similarly, if we need to refetch, we always want to perform a full
      +	 * fetch ignoring existing objects.
      +	 */
     -+	if (repair)
     ++	if (refetch)
      +		return -1;
      +
      +
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
       	if (update_shallow)
       		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
     -+	if (repair)
     -+		set_option(transport, TRANS_OPT_REPAIR, "yes");
     ++	if (refetch)
     ++		set_option(transport, TRANS_OPT_REFETCH, "yes");
       	if (filter_options.choice) {
       		const char *spec =
       			expand_list_objects_filter_spec(&filter_options);
     @@ transport-helper.c: static int fetch_refs(struct transport *transport,
       	if (data->transport_options.update_shallow)
       		set_helper_option(transport, "update-shallow", "true");
       
     -+	if (data->transport_options.repair)
     -+		set_helper_option(transport, "repair", "true");
     ++	if (data->transport_options.refetch)
     ++		set_helper_option(transport, "refetch", "true");
      +
       	if (data->transport_options.filter_options.choice) {
       		const char *spec = expand_list_objects_filter_spec(
     @@ transport.c: static int set_git_option(struct git_transport_options *opts,
       		list_objects_filter_die_if_populated(&opts->filter_options);
       		parse_list_objects_filter(&opts->filter_options, value);
       		return 0;
     -+	} else if (!strcmp(name, TRANS_OPT_REPAIR)) {
     -+		opts->repair = !!value;
     ++	} else if (!strcmp(name, TRANS_OPT_REFETCH)) {
     ++		opts->refetch = !!value;
      +		return 0;
       	} else if (!strcmp(name, TRANS_OPT_REJECT_SHALLOW)) {
       		opts->reject_shallow = !!value;
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.update_shallow = data->options.update_shallow;
       	args.from_promisor = data->options.from_promisor;
       	args.filter_options = data->options.filter_options;
     -+	args.repair = data->options.repair;
     ++	args.refetch = data->options.refetch;
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
       	args.negotiation_tips = data->options.negotiation_tips;
     @@ transport.h: struct git_transport_options {
       	unsigned update_shallow : 1;
       	unsigned reject_shallow : 1;
       	unsigned deepen_relative : 1;
     -+	unsigned repair : 1;
     ++	unsigned refetch : 1;
       
       	/* see documentation of corresponding flag in fetch-pack.h */
       	unsigned from_promisor : 1;
     @@ transport.h: void transport_check_allowed(const char *type);
       #define TRANS_OPT_LIST_OBJECTS_FILTER "filter"
       
      +/* Refetch all objects without negotiating */
     -+#define TRANS_OPT_REPAIR "repair"
     ++#define TRANS_OPT_REFETCH "refetch"
      +
       /* Request atomic (all-or-nothing) updates when pushing */
       #define TRANS_OPT_ATOMIC "atomic"
 5:  38af2bbee79 ! 5:  01f22e784a5 t5615-partial-clone: add test for fetch --repair
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    t5615-partial-clone: add test for fetch --repair
     +    t5615-partial-clone: add test for fetch --refetch
      
     -    Add a test for doing a repair fetch to apply a changed partial clone
     -    filter under protocol v0 and v2.
     +    Add a test for doing a refetch to apply a changed partial clone filter
     +    under protocol v0 and v2.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ t/t5616-partial-clone.sh: test_expect_success 'manual prefetch of missing object
      +	git -C src push -u srv main
      +'
      +
     -+# Do partial fetch to fetch smaller files; then verify that without --repair
     ++# Do partial fetch to fetch smaller files; then verify that without --refetch
      +# applying a new filter does not refetch missing large objects. Then use
     -+# --repair to apply the new filter on existing commits. Test it under both
     ++# --refetch to apply the new filter on existing commits. Test it under both
      +# protocol v2 & v0.
     -+test_expect_success 'apply a different filter using --repair' '
     ++test_expect_success 'apply a different filter using --refetch' '
      +	git -C pc1 fetch --filter=blob:limit=999 origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 4 observed &&
      +
     -+	git -C pc1 fetch --filter=blob:limit=19999 --repair origin &&
     ++	git -C pc1 fetch --filter=blob:limit=19999 --refetch origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 2 observed &&
      +
      +	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
     -+		--repair origin &&
     ++		--refetch origin &&
      +	git -C pc1 rev-list --quiet --objects --missing=print \
      +		main..origin/main >observed &&
      +	test_line_count = 0 observed
      +'
      +
     -+test_expect_success 'fetch --repair works with a shallow clone' '
     ++test_expect_success 'fetch --refetch works with a shallow clone' '
      +	git clone --no-checkout --depth=1 --filter=blob:none "file://$(pwd)/srv.bare" pc1s &&
      +	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
      +	test_line_count = 6 observed &&
      +
     -+	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --repair origin &&
     ++	GIT_TRACE=1 git -C pc1s fetch --filter=blob:limit=999 --refetch origin &&
      +	git -C pc1s rev-list --objects --missing=print HEAD >observed &&
      +	test_line_count = 6 observed
      +'
 6:  cfa6dca8ef4 < -:  ----------- maintenance: add ability to pass config options
 7:  2338c15249a ! 6:  31046625987 fetch: after repair, encourage auto gc repacking
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    fetch: after repair, encourage auto gc repacking
     +    fetch: after refetch, encourage auto gc repacking
      
     -    After invoking `fetch --repair`, the object db will likely contain many
     +    After invoking `fetch --refetch`, the object db will likely contain many
          duplicate objects. If auto-maintenance is enabled, invoke it with
          appropriate settings to encourage repacking/consolidation.
      
     @@ Documentation/fetch-options.txt: ifndef::git-pull[]
       --refmap=<refspec>::
      
       ## builtin/fetch.c ##
     -@@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
     - 	struct remote *remote = NULL;
     - 	int result = 0;
     - 	int prune_tags_ok = 1;
     -+	struct strvec auto_maint_opts = STRVEC_INIT;
     -+	int opt_val;
     - 
     - 	packet_trace_identity("fetch");
     - 
      @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       					     NULL);
       	}
       
      -	if (enable_auto_gc)
     --		run_auto_maintenance(verbosity < 0, NULL);
      +	if (enable_auto_gc) {
     -+		if (repair) {
     ++		if (refetch) {
      +			/*
      +			 * Hint auto-maintenance strongly to encourage repacking,
      +			 * but respect config settings disabling it.
      +			 */
     ++			int opt_val;
      +			if (git_config_get_int("gc.autopacklimit", &opt_val))
      +				opt_val = -1;
      +			if (opt_val != 0)
     -+				strvec_push(&auto_maint_opts, "gc.autoPackLimit=1");
     ++				git_config_push_parameter("gc.autoPackLimit=1");
      +
      +			if (git_config_get_int("maintenance.incremental-repack.auto", &opt_val))
      +				opt_val = -1;
      +			if (opt_val != 0)
     -+				strvec_push(&auto_maint_opts, "maintenance.incremental-repack.auto=-1");
     ++				git_config_push_parameter("maintenance.incremental-repack.auto=-1");
      +		}
     -+		run_auto_maintenance(verbosity < 0, &auto_maint_opts);
     + 		run_auto_maintenance(verbosity < 0);
      +	}
       
        cleanup:
       	string_list_clear(&list, 0);
     -+	strvec_clear(&auto_maint_opts);
     - 	return result;
     - }
      
       ## t/t5616-partial-clone.sh ##
     -@@ t/t5616-partial-clone.sh: test_expect_success 'push new commits to server for file.4.txt' '
     - # Do partial fetch to fetch smaller files; then verify that without --repair
     - # applying a new filter does not refetch missing large objects. Then use
     - # --repair to apply the new filter on existing commits. Test it under both
     --# protocol v2 & v0.
     -+# protocol v2 & v0. Check repacking auto-maintenance is kicked off.
     - test_expect_success 'apply a different filter using --repair' '
     - 	git -C pc1 fetch --filter=blob:limit=999 origin &&
     - 	git -C pc1 rev-list --quiet --objects --missing=print \
     -@@ t/t5616-partial-clone.sh: test_expect_success 'apply a different filter using --repair' '
     - 		main..origin/main >observed &&
     - 	test_line_count = 2 observed &&
     - 
     -+	GIT_TRACE2_EVENT="$(pwd)/trace.log" \
     - 	git -c protocol.version=0 -C pc1 fetch --filter=blob:limit=29999 \
     - 		--repair origin &&
     - 	git -C pc1 rev-list --quiet --objects --missing=print \
     - 		main..origin/main >observed &&
     --	test_line_count = 0 observed
     -+	test_line_count = 0 observed &&
     -+	test_subcommand git -c gc.autoPackLimit=1 -c maintenance.incremental-repack.auto=-1 maintenance run --auto --no-quiet <trace.log
     +@@ t/t5616-partial-clone.sh: test_expect_success 'fetch --refetch works with a shallow clone' '
     + 	test_line_count = 6 observed
       '
       
     - test_expect_success 'fetch --repair works with a shallow clone' '
     ++test_expect_success 'fetch --refetch triggers repacking' '
     ++	GIT_TRACE2_CONFIG_PARAMS=gc.autoPackLimit,maintenance.incremental-repack.auto &&
     ++	export GIT_TRACE2_CONFIG_PARAMS &&
     ++
     ++	GIT_TRACE2_EVENT="$PWD/trace1.event" \
     ++	git -C pc1 fetch --refetch origin &&
     ++	test_subcommand git maintenance run --auto --no-quiet <trace1.event &&
     ++	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace1.event &&
     ++	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace1.event &&
     ++
     ++	GIT_TRACE2_EVENT="$PWD/trace2.event" \
     ++	git -c protocol.version=0 \
     ++		-c gc.autoPackLimit=0 \
     ++		-c maintenance.incremental-repack.auto=1234 \
     ++		-C pc1 fetch --refetch origin &&
     ++	test_subcommand git maintenance run --auto --no-quiet <trace2.event &&
     ++	grep \"param\":\"gc.autopacklimit\",\"value\":\"0\" trace2.event &&
     ++	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"-1\" trace2.event &&
     ++
     ++	GIT_TRACE2_EVENT="$PWD/trace3.event" \
     ++	git -c protocol.version=0 \
     ++		-c gc.autoPackLimit=1234 \
     ++		-c maintenance.incremental-repack.auto=0 \
     ++		-C pc1 fetch --refetch origin &&
     ++	test_subcommand git maintenance run --auto --no-quiet <trace3.event &&
     ++	grep \"param\":\"gc.autopacklimit\",\"value\":\"1\" trace3.event &&
     ++	grep \"param\":\"maintenance.incremental-repack.auto\",\"value\":\"0\" trace3.event
     ++'
     ++
     + test_expect_success 'partial clone with transfer.fsckobjects=1 works with submodules' '
     + 	test_create_repo submodule &&
     + 	test_commit -C submodule mycommit &&
 8:  20942562a66 ! 7:  f923a06aab5 doc/partial-clone: mention --repair fetch option
     @@ Metadata
      Author: Robert Coup <robert@coup.net.nz>
      
       ## Commit message ##
     -    doc/partial-clone: mention --repair fetch option
     +    doc/partial-clone: mention --refetch fetch option
      
     -    Document it for partial clones as a means to refetch with a new filter.
     +    Document it for partial clones as a means to apply a new filter.
      
          Signed-off-by: Robert Coup <robert@coup.net.nz>
      
     @@ Documentation/technical/partial-clone.txt: Fetching Missing Objects
         currently fetches all objects referred to by the requested objects, even
         though they are not necessary.
       
     -+- Fetching with `--repair` will request a complete new filtered packfile from
     ++- Fetching with `--refetch` will request a complete new filtered packfile from
      +  the remote, which can be used to change a filter without needing to
      +  dynamically fetch missing objects.
       

-- 
gitgitgadget
