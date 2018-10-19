Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD0C1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJTBlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:41:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34890 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeJTBlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:41:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so31557394ljj.2
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJfXy3UX40Y9e3uSN2YEiTfekVsN5tjNTB90hoMhM4k=;
        b=jzONvYkdLBREUaz/MpvhsBHnoZdIBJBmZ0d8G8L9JOucuRwzZTx7XEZFHtZoow5AuM
         RxtG3rkufj8HJ+lOkqU5UVvLpOTbNlIpnzXF/pN4VhGt7iryqI8EDiUQZpWg/i7jNPpw
         3lIGkiyroum1jbIhS1WnKC3Fo2sUIPfGtkADND5nooVTt0nyEpru5lPNnZpOCdshzvY0
         UNDdTNfhfgQiNCRNRVFie1FjOAcrg8/kOXWrTRmQ5geNXL1IhB5MnFeXl4jsf2a4bPvk
         lr5tr/g8QKlNAN1fGdqhKvfCrp3+C45MFMzcLsf2JzAw2dbsQFkKA1LHyfw1BMcfaJW6
         pDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJfXy3UX40Y9e3uSN2YEiTfekVsN5tjNTB90hoMhM4k=;
        b=MJKzx7K1/POYKnOFsaE+GZUICtKyY0jTTZgRIUuHk6TU+rJdmaKw628yQOjPEJEWoY
         p62bmw5LZ0GPW942vT617+VyGM6ZD3hqpGYQ5pGybGxVjsJmYxi0cvD3ra9fq1M6Navo
         tvhkkf5VBx+43mZe7cThsDSI8J/IIjYWp7U69Tv/SBxgT+uBVJlmyZYAEMCjII4yKQUR
         ZY8wvTPd2svPPrXwByTwMYI8TseN8p8Ej6Rnq8xr0mihLEgv+R2gMyaOue/JVz0FPWiM
         E/f4JDmZJYc3oUmoasYx66MO8pVlUvzGZTWrFgKLWaqva+dCl2/F7bW8j19tqzcMlxdN
         zpIg==
X-Gm-Message-State: ABuFfojalTq9p2N8OMkB/TdfgG/+axchyxds4+pv1cItXGvcAtWuhYk4
        ugHfvs6RrPWlJE65Pllt9Bb8PMCH
X-Google-Smtp-Source: ACcGV627Fa01z7wp8vF+Og9ridNdnb8brlgWqzA1kPV05YsArSEcl/EjPLrQcVxWsD/EK9ijcV93DA==
X-Received: by 2002:a2e:4e01:: with SMTP id c1-v6mr25309646ljb.157.1539970486858;
        Fri, 19 Oct 2018 10:34:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f1-v6sm5287307ljf.5.2018.10.19.10.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:34:46 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] submodule.c: remove some of the_repository references
Date:   Fri, 19 Oct 2018 19:34:43 +0200
Message-Id: <20181019173443.25760-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019165532.GA31601@sigill.intra.peff.net>
References: <20181019165532.GA31601@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 174d131fc9 (submodule.c: remove implicit dependency on
the_index - 2018-09-21) makes collect_changed_submodules() take a
"struct index_state *" as argument even if it's not really used. My
bad.

Instead of deleting this argument and fixing up all call sites. Let's
take this opportunity to remove some the_repository instead because
there's one or two in this function (and two more in its callback).
The callers can also get rid of some the_repository.

Noticed-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 On Fri, Oct 19, 2018 at 6:55 PM Jeff King <peff@peff.net> wrote:
 > > > I think I'd lean toward the former, if
 > > > it's not likely to be used (even if we add "struct repository" later,
 > > > the separate index parameter would just go away then).
 > >
 > > Or we could fix it now. Something like this? It adds three the_repository
 > > (two technically are already there) but deletes eight, which makes me
 > > happy. It's up to you to decide.
 >
 > Yeah, that's fine by me, if it's not getting in the way of other related
 > work. The patch you sent looks reasonable.

 OK so here's the cleaned up patch and is actually tested. On top of master.

 builtin/pull.c |  2 +-
 submodule.c    | 57 ++++++++++++++++++++++++++++----------------------
 submodule.h    |  6 +++---
 transport.c    |  4 ++--
 4 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 798ecf7faf..c21aa276f1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -945,7 +945,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(&the_index, &rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(the_repository, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/submodule.c b/submodule.c
index d9d3046689..a2701ede4a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -694,6 +694,7 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
 }
 
 struct collect_changed_submodules_cb_data {
+	struct repository *repo;
 	struct string_list *changed;
 	const struct object_id *commit_oid;
 };
@@ -733,7 +734,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		submodule = submodule_from_path(the_repository,
+		submodule = submodule_from_path(me->repo,
 						commit_oid, p->two->path);
 		if (submodule)
 			name = submodule->name;
@@ -741,7 +742,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 			name = default_name_or_path(p->two->path);
 			/* make sure name does not collide with existing one */
 			if (name)
-				submodule = submodule_from_name(the_repository,
+				submodule = submodule_from_name(me->repo,
 								commit_oid, name);
 			if (submodule) {
 				warning("Submodule in commit %s at path: "
@@ -766,14 +767,14 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  * have a corresponding 'struct oid_array' (in the 'util' field) which lists
  * what the submodule pointers were updated to during the change.
  */
-static void collect_changed_submodules(struct index_state *istate,
+static void collect_changed_submodules(struct repository *r,
 				       struct string_list *changed,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
 	const struct commit *commit;
 
-	repo_init_revisions(the_repository, &rev, NULL);
+	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->argc, argv->argv, &rev, NULL);
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
@@ -781,10 +782,11 @@ static void collect_changed_submodules(struct index_state *istate,
 	while ((commit = get_revision(&rev))) {
 		struct rev_info diff_rev;
 		struct collect_changed_submodules_cb_data data;
+		data.repo = r;
 		data.changed = changed;
 		data.commit_oid = &commit->object.oid;
 
-		repo_init_revisions(the_repository, &diff_rev, NULL);
+		repo_init_revisions(r, &diff_rev, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
 		diff_rev.diffopt.format_callback_data = &data;
@@ -816,6 +818,7 @@ static int append_oid_to_argv(const struct object_id *oid, void *data)
 }
 
 struct has_commit_data {
+	struct repository *repo;
 	int result;
 	const char *path;
 };
@@ -824,7 +827,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
 
-	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	enum object_type type = oid_object_info(cb->repo, oid, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
@@ -842,9 +845,11 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	}
 }
 
-static int submodule_has_commits(const char *path, struct oid_array *commits)
+static int submodule_has_commits(struct repository *r,
+				 const char *path,
+				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { 1, path };
+	struct has_commit_data has_commit = { r, 1, path };
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -887,9 +892,11 @@ static int submodule_has_commits(const char *path, struct oid_array *commits)
 	return has_commit.result;
 }
 
-static int submodule_needs_pushing(const char *path, struct oid_array *commits)
+static int submodule_needs_pushing(struct repository *r,
+				   const char *path,
+				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(path, commits))
+	if (!submodule_has_commits(r, path, commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -931,7 +938,7 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-int find_unpushed_submodules(struct index_state *istate,
+int find_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing)
@@ -946,14 +953,14 @@ int find_unpushed_submodules(struct index_state *istate,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(istate, &submodules, &argv);
+	collect_changed_submodules(r, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(the_repository, &null_oid, name->string);
+		submodule = submodule_from_name(r, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -962,7 +969,7 @@ int find_unpushed_submodules(struct index_state *istate,
 		if (!path)
 			continue;
 
-		if (submodule_needs_pushing(path, commits))
+		if (submodule_needs_pushing(r, path, commits))
 			string_list_insert(needs_pushing, path);
 	}
 
@@ -1047,7 +1054,7 @@ static void submodule_push_check(const char *path, const char *head,
 		die("process for submodule '%s' failed", path);
 }
 
-int push_unpushed_submodules(struct index_state *istate,
+int push_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
@@ -1057,7 +1064,7 @@ int push_unpushed_submodules(struct index_state *istate,
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(istate, commits,
+	if (!find_unpushed_submodules(r, commits,
 				      remote->name, &needs_pushing))
 		return 1;
 
@@ -1115,14 +1122,14 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(struct index_state *istate)
+static void calculate_changed_submodule_paths(struct repository *r)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
 	const struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(the_repository, NULL, NULL))
+	if (!submodule_from_path(r, NULL, NULL))
 		return;
 
 	argv_array_push(&argv, "--"); /* argv[0] program name */
@@ -1136,14 +1143,14 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(istate, &changed_submodules, &argv);
+	collect_changed_submodules(r, &changed_submodules, &argv);
 
 	for_each_string_list_item(name, &changed_submodules) {
 		struct oid_array *commits = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
-		submodule = submodule_from_name(the_repository, &null_oid, name->string);
+		submodule = submodule_from_name(r, &null_oid, name->string);
 		if (submodule)
 			path = submodule->path;
 		else
@@ -1152,7 +1159,7 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 		if (!path)
 			continue;
 
-		if (!submodule_has_commits(path, commits))
+		if (!submodule_has_commits(r, path, commits))
 			string_list_append(&changed_submodule_names, name->string);
 	}
 
@@ -1163,7 +1170,7 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	initialized_fetch_ref_tips = 0;
 }
 
-int submodule_touches_in_range(struct index_state *istate,
+int submodule_touches_in_range(struct repository *r,
 			       struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
@@ -1172,7 +1179,7 @@ int submodule_touches_in_range(struct index_state *istate,
 	int ret;
 
 	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(the_repository, NULL, NULL))
+	if (!submodule_from_path(r, NULL, NULL))
 		return 0;
 
 	argv_array_push(&args, "--"); /* args[0] program name */
@@ -1182,7 +1189,7 @@ int submodule_touches_in_range(struct index_state *istate,
 		argv_array_push(&args, oid_to_hex(excl_oid));
 	}
 
-	collect_changed_submodules(istate, &subs, &args);
+	collect_changed_submodules(r, &subs, &args);
 	ret = subs.nr;
 
 	argv_array_clear(&args);
@@ -1352,7 +1359,7 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths(r->index);
+	calculate_changed_submodule_paths(r);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
diff --git a/submodule.h b/submodule.h
index 4826601ff2..a8a4fe8d25 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,15 +102,15 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-int submodule_touches_in_range(struct index_state *istate,
+int submodule_touches_in_range(struct repository *r,
 			       struct object_id *a,
 			       struct object_id *b);
-int find_unpushed_submodules(struct index_state *istate,
+int find_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing);
 struct refspec;
-int push_unpushed_submodules(struct index_state *istate,
+int push_unpushed_submodules(struct repository *r,
 			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
diff --git a/transport.c b/transport.c
index f4ffbd96cb..f9343e6dde 100644
--- a/transport.c
+++ b/transport.c
@@ -1172,7 +1172,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&the_index,
+			if (!push_unpushed_submodules(the_repository,
 						      &commits,
 						      transport->remote,
 						      rs,
@@ -1197,7 +1197,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&the_index,
+			if (find_unpushed_submodules(the_repository,
 						     &commits,
 						     transport->remote->name,
 						     &needs_pushing)) {
-- 
2.19.1.647.g708186aaf9

