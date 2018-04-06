Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2121F404
	for <e@80x24.org>; Fri,  6 Apr 2018 19:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeDFTJo (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 15:09:44 -0400
Received: from mail-cys01nam02on0113.outbound.protection.outlook.com ([104.47.37.113]:53082
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeDFTJm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 15:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l0vyLnjHXvvc/C9+kJSjwTyqmMU1l7BKeu1/uUwCxCY=;
 b=YrJVCcR7Hf/tYJsAtHKatCKvlFzZev/jyeXuExO9EeK8WUGyEr1LrYn1gvShLP5aEUn1mB4CpOcw4A8dhQ/GLY/tAQEejZYE734L4S175k4g+rv44wap5UDEqynawmEDDMl3SXgHJU9VSqD6aj8z/v+cSE3RjGsZUxkGmXzV304=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB1108.namprd21.prod.outlook.com (52.132.24.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Fri, 6 Apr 2018 19:09:39 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::c8cd:6461:8337:8ad1%2]) with mapi id 15.20.0696.000; Fri, 6 Apr 2018
 19:09:39 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 3/4] treewide: replace maybe_tree with accessor methods
Thread-Topic: [PATCH v2 3/4] treewide: replace maybe_tree with accessor
 methods
Thread-Index: AQHTzdrOEf7m7o7gtEC6rkxJP3TEKw==
Date:   Fri, 6 Apr 2018 19:09:38 +0000
Message-ID: <20180406190919.167092-4-dstolee@microsoft.com>
References: <20180403120057.173849-1-dstolee@microsoft.com>
 <20180406190919.167092-1-dstolee@microsoft.com>
In-Reply-To: <20180406190919.167092-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:400:4::26) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1108;7:/cO9tpOVafYNG4fER2xa+WR4eOwXt5uea6Kj+XPF4FJgNsfSjMqyaDCGP9FKSF7iFxYhChSNB/WzY9SqZe0xgDPtdbabWnM4xldvfL1UPHI9xXa8zd6Q6R6TiaWNmbUPoWq6brnOXOGcI+qDrTFMg+W7JWj/PlmxclLtg9utV3wNktkzjFwfPBI264639l/gPtZ3//Fb7k88uMI+bJqbLv80lEUCvd3Ik5PHkPxRhfv3ugOtE3G1LFPeauQC8fwZ;20:sREyJ+rG7DmvNgjSPLIwaNYvXsAztYWMKsfbRGPmYkqopeGpOn0eVY5aPlnDCyLMPw3XQQ4CkSJjh7E2iiAr1MDtDiOv5plE6+YGH2VGCBfzBWbrXwFOAp1yphoLJb5/ngpGka8lQ2MaVWiW3WyqPqwMkXOyfZWouy3JgzO5SMM=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7466d2f6-b6fc-4a26-26a4-08d59bf1f03e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1108;
x-ms-traffictypediagnostic: BL0PR2101MB1108:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB1108AEFAAD3FE82A54FF1052A1BA0@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1108;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1108;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39860400002)(189003)(199004)(22452003)(105586002)(316002)(2906002)(2501003)(5250100002)(76176011)(59450400001)(25786009)(54906003)(3280700002)(106356001)(3660700001)(14454004)(102836004)(486006)(46003)(478600001)(52116002)(99286004)(4326008)(5660300001)(6506007)(386003)(2616005)(446003)(11346002)(10290500003)(575784001)(476003)(86362001)(186003)(6486002)(2900100001)(97736004)(107886003)(39060400002)(5640700003)(6436002)(36756003)(8656006)(10090500001)(305945005)(7736002)(8676002)(6116002)(6916009)(53936002)(53946003)(8936002)(1076002)(81166006)(1730700003)(86612001)(81156014)(6512007)(2351001)(68736007)(22906009)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1108;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YEly0fjWSvUlBtLQ2g8gRRwAbh4jeinTY1aXDrGiWkhlCEcOgOKKoi0M/0Cl2vf+qyyiAqvjbzbNSXGjmeijMtYg7oomeKMej42A7RhWdu09g5bg0uA4HvXZqGmCC8GHGMlmlJc4CHcxyU5koZr/OqoIe4X17T+ARFg9JYrilg1AGVx8Say01k2CgQZVkeVDc2qjBpQZYh+ym53AlncVA/i9ornmYeXgnr3DIyBR5DvNPhN0e/1H4FVY3uhMwMI6x0TKkcY7LEJCLGLy30Nq/uZcfmBpWVi9kll2HMJ/gTNJMi3VVWmHm+m2e9Y1o/Ls9fhXfTH5LxWMyuqHRSRVyxrowX/Duei2oqH4V3LJHmhMFwzbQGQOG9LzODA12alr2S83ZpVrlFtMPNH+KOSAzuNwpRBmhWMHuC+ylBHJLQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7466d2f6-b6fc-4a26-26a4-08d59bf1f03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 19:09:38.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In anticipation of making trees load lazily, create a Coccinelle
script (contrib/coccinelle/commit.cocci) to ensure that all
references to the 'maybe_tree' member of struct commit are either
mutations or accesses through get_commit_tree() or
get_commit_tree_oid().

Apply the Coccinelle script to create the rest of the patch.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 blame.c                         | 18 +++++++++---------
 builtin/checkout.c              | 18 ++++++++++++------
 builtin/diff.c                  |  2 +-
 builtin/fast-export.c           |  6 +++---
 builtin/log.c                   |  4 ++--
 builtin/reflog.c                |  2 +-
 commit-graph.c                  |  2 +-
 contrib/coccinelle/commit.cocci | 30 ++++++++++++++++++++++++++++++
 fsck.c                          |  8 +++++---
 http-push.c                     |  2 +-
 line-log.c                      |  4 ++--
 list-objects.c                  | 10 +++++-----
 log-tree.c                      |  6 +++---
 merge-recursive.c               |  4 ++--
 notes-merge.c                   |  9 +++++----
 packfile.c                      |  2 +-
 pretty.c                        |  5 +++--
 ref-filter.c                    |  2 +-
 revision.c                      |  8 ++++----
 sequencer.c                     | 12 ++++++------
 sha1_name.c                     |  2 +-
 tree.c                          |  4 ++--
 walker.c                        |  2 +-
 23 files changed, 101 insertions(+), 61 deletions(-)
 create mode 100644 contrib/coccinelle/commit.cocci

diff --git a/blame.c b/blame.c
index b78e649cac..7f5700b324 100644
--- a/blame.c
+++ b/blame.c
@@ -553,10 +553,10 @@ static struct blame_origin *find_origin(struct commit=
 *parent,
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->maybe_tree->object.oid,
-			      &origin->commit->maybe_tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(origin->commit),
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
=20
@@ -622,10 +622,10 @@ static struct blame_origin *find_rename(struct commit=
 *parent,
 	diff_setup_done(&diff_opts);
=20
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->maybe_tree->object.oid,
-			      &origin->commit->maybe_tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(origin->commit),
 			      "", &diff_opts);
 	diffcore_std(&diff_opts);
=20
@@ -1257,10 +1257,10 @@ static void find_copy_in_parent(struct blame_scoreb=
oard *sb,
 		diff_opts.flags.find_copies_harder =3D 1;
=20
 	if (is_null_oid(&target->commit->object.oid))
-		do_diff_cache(&parent->maybe_tree->object.oid, &diff_opts);
+		do_diff_cache(get_commit_tree_oid(parent), &diff_opts);
 	else
-		diff_tree_oid(&parent->maybe_tree->object.oid,
-			      &target->commit->maybe_tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
+			      get_commit_tree_oid(target->commit),
 			      "", &diff_opts);
=20
 	if (!diff_opts.flags.find_copies_harder)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b15fed5d85..3c8b2d0c27 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -484,7 +484,8 @@ static int merge_working_tree(const struct checkout_opt=
s *opts,
=20
 	resolve_undo_clear();
 	if (opts->force) {
-		ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 1, writeou=
t_error);
+		ret =3D reset_tree(get_commit_tree(new_branch_info->commit),
+				 opts, 1, writeout_error);
 		if (ret)
 			return ret;
 	} else {
@@ -570,18 +571,23 @@ static int merge_working_tree(const struct checkout_o=
pts *opts,
 			o.verbosity =3D 0;
 			work =3D write_tree_from_memory(&o);
=20
-			ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 1,
+			ret =3D reset_tree(get_commit_tree(new_branch_info->commit),
+					 opts, 1,
 					 writeout_error);
 			if (ret)
 				return ret;
 			o.ancestor =3D old_branch_info->name;
 			o.branch1 =3D new_branch_info->name;
 			o.branch2 =3D "local";
-			ret =3D merge_trees(&o, new_branch_info->commit->maybe_tree, work,
-				old_branch_info->commit->maybe_tree, &result);
+			ret =3D merge_trees(&o,
+					  get_commit_tree(new_branch_info->commit),
+					  work,
+					  get_commit_tree(old_branch_info->commit),
+					  &result);
 			if (ret < 0)
 				exit(128);
-			ret =3D reset_tree(new_branch_info->commit->maybe_tree, opts, 0,
+			ret =3D reset_tree(get_commit_tree(new_branch_info->commit),
+					 opts, 0,
 					 writeout_error);
 			strbuf_release(&o.obuf);
 			if (ret)
@@ -1002,7 +1008,7 @@ static int parse_branchname_arg(int argc, const char =
**argv,
 		*source_tree =3D parse_tree_indirect(rev);
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
-		*source_tree =3D new_branch_info->commit->maybe_tree;
+		*source_tree =3D get_commit_tree(new_branch_info->commit);
 	}
=20
 	if (!*source_tree)                   /* case (1): want a tree */
diff --git a/builtin/diff.c b/builtin/diff.c
index 34f18a5f3f..bfefff3a84 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -398,7 +398,7 @@ int cmd_diff(int argc, const char **argv, const char *p=
refix)
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type =3D=3D OBJ_COMMIT)
-			obj =3D &((struct commit *)obj)->maybe_tree->object;
+			obj =3D &get_commit_tree(((struct commit *)obj))->object;
=20
 		if (obj->type =3D=3D OBJ_TREE) {
 			obj->flags |=3D flags;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 91e526b30d..c1304234cd 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -578,11 +578,11 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
 	    get_object_mark(&commit->parents->item->object) !=3D 0 &&
 	    !full_tree) {
 		parse_commit_or_die(commit->parents->item);
-		diff_tree_oid(&commit->parents->item->maybe_tree->object.oid,
-			      &commit->maybe_tree->object.oid, "", &rev->diffopt);
+		diff_tree_oid(get_commit_tree_oid(commit->parents->item),
+			      get_commit_tree_oid(commit), "", &rev->diffopt);
 	}
 	else
-		diff_root_tree_oid(&commit->maybe_tree->object.oid,
+		diff_root_tree_oid(get_commit_tree_oid(commit),
 				   "", &rev->diffopt);
=20
 	/* Export the referenced blobs, and remember the marks. */
diff --git a/builtin/log.c b/builtin/log.c
index f603b53318..25b4cb3347 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1067,8 +1067,8 @@ static void make_cover_letter(struct rev_info *rev, i=
nt use_stdout,
=20
 	diff_setup_done(&opts);
=20
-	diff_tree_oid(&origin->maybe_tree->object.oid,
-		      &head->maybe_tree->object.oid,
+	diff_tree_oid(get_commit_tree_oid(origin),
+		      get_commit_tree_oid(head),
 		      "", &opts);
 	diffcore_std(&opts);
 	diff_flush(&opts);
diff --git a/builtin/reflog.c b/builtin/reflog.c
index b17eabc009..88d0c8378c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -154,7 +154,7 @@ static int commit_is_complete(struct commit *commit)
 		for (i =3D 0; i < found.nr; i++) {
 			struct commit *c =3D
 				(struct commit *)found.objects[i].item;
-			if (!tree_is_complete(&c->maybe_tree->object.oid)) {
+			if (!tree_is_complete(get_commit_tree_oid(c))) {
 				is_incomplete =3D 1;
 				c->object.flags |=3D INCOMPLETE;
 			}
diff --git a/commit-graph.c b/commit-graph.c
index 005b4a753e..9f37d84209 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -369,7 +369,7 @@ static void write_graph_chunk_data(struct hashfile *f, =
int hash_len,
 		uint32_t packedDate[2];
=20
 		parse_commit(*list);
-		hashwrite(f, (*list)->maybe_tree->object.oid.hash, hash_len);
+		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
=20
 		parent =3D (*list)->parents;
=20
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.co=
cci
new file mode 100644
index 0000000000..ac38525941
--- /dev/null
+++ b/contrib/coccinelle/commit.cocci
@@ -0,0 +1,30 @@
+@@
+expression c;
+@@
+- &c->maybe_tree->object.oid
++ get_commit_tree_oid(c)
+
+@@
+expression c;
+@@
+- c->maybe_tree->object.oid.hash
++ get_commit_tree_oid(c)->hash
+
+@@
+expression c;
+@@
+- c->maybe_tree
++ get_commit_tree(c)
+
+@@
+expression c;
+expression s;
+@@
+- get_commit_tree(c) =3D s
++ c->maybe_tree =3D s
+
+@@
+expression c;
+@@
+- return get_commit_tree(c);
++ return c->maybe_tree;
diff --git a/fsck.c b/fsck.c
index 3228ca5bee..695fd71b13 100644
--- a/fsck.c
+++ b/fsck.c
@@ -396,9 +396,11 @@ static int fsck_walk_commit(struct commit *commit, voi=
d *data, struct fsck_optio
=20
 	name =3D get_object_name(options, &commit->object);
 	if (name)
-		put_object_name(options, &commit->maybe_tree->object, "%s:", name);
+		put_object_name(options, &get_commit_tree(commit)->object,
+				"%s:", name);
=20
-	result =3D options->walk((struct object *)commit->maybe_tree, OBJ_TREE, d=
ata, options);
+	result =3D options->walk((struct object *)get_commit_tree(commit),
+			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
 	res =3D result;
@@ -772,7 +774,7 @@ static int fsck_commit_buffer(struct commit *commit, co=
nst char *buffer,
 	err =3D fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
-	if (!commit->maybe_tree) {
+	if (!get_commit_tree(commit)) {
 		err =3D report(options, &commit->object, FSCK_MSG_BAD_TREE, "could not l=
oad commit's tree %s", sha1_to_hex(tree_sha1));
 		if (err)
 			return err;
diff --git a/http-push.c b/http-push.c
index d83479f32f..53a217291e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1330,7 +1330,7 @@ static int get_delta(struct rev_info *revs, struct re=
mote_lock *lock)
 	int count =3D 0;
=20
 	while ((commit =3D get_revision(revs)) !=3D NULL) {
-		p =3D process_tree(commit->maybe_tree, p);
+		p =3D process_tree(get_commit_tree(commit), p);
 		commit->object.flags |=3D LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
 			count +=3D add_send_request(&commit->object, lock);
diff --git a/line-log.c b/line-log.c
index e714969ca2..437d44c00a 100644
--- a/line-log.c
+++ b/line-log.c
@@ -817,8 +817,8 @@ static void queue_diffs(struct line_log_data *range,
 	assert(commit);
=20
 	DIFF_QUEUE_CLEAR(&diff_queued_diff);
-	diff_tree_oid(parent ? &parent->maybe_tree->object.oid : NULL,
-		      &commit->maybe_tree->object.oid, "", opt);
+	diff_tree_oid(parent ? get_commit_tree_oid(parent) : NULL,
+		      get_commit_tree_oid(commit), "", opt);
 	if (opt->detect_rename) {
 		filter_diffs_for_paths(range, 1);
 		if (diff_might_be_rename())
diff --git a/list-objects.c b/list-objects.c
index bfd09f545c..3eec510357 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -195,7 +195,7 @@ static void mark_edge_parents_uninteresting(struct comm=
it *commit,
 		struct commit *parent =3D parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(parent->maybe_tree);
+		mark_tree_uninteresting(get_commit_tree(parent));
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |=3D SHOWN;
 			show_edge(parent);
@@ -212,7 +212,7 @@ void mark_edges_uninteresting(struct rev_info *revs, sh=
ow_edge_fn show_edge)
 		struct commit *commit =3D list->item;
=20
 		if (commit->object.flags & UNINTERESTING) {
-			mark_tree_uninteresting(commit->maybe_tree);
+			mark_tree_uninteresting(get_commit_tree(commit));
 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 				commit->object.flags |=3D SHOWN;
 				show_edge(commit);
@@ -227,7 +227,7 @@ void mark_edges_uninteresting(struct rev_info *revs, sh=
ow_edge_fn show_edge)
 			struct commit *commit =3D (struct commit *)obj;
 			if (obj->type !=3D OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
-			mark_tree_uninteresting(commit->maybe_tree);
+			mark_tree_uninteresting(get_commit_tree(commit));
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |=3D SHOWN;
 				show_edge(commit);
@@ -300,8 +300,8 @@ static void do_traverse(struct rev_info *revs,
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
 		 */
-		if (commit->maybe_tree)
-			add_pending_tree(revs, commit->maybe_tree);
+		if (get_commit_tree(commit))
+			add_pending_tree(revs, get_commit_tree(commit));
 		show_commit(commit, show_data);
=20
 		if (revs->tree_blobs_in_commit_order)
diff --git a/log-tree.c b/log-tree.c
index 99499af57c..c106bd70df 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -806,7 +806,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 		return 0;
=20
 	parse_commit_or_die(commit);
-	oid =3D &commit->maybe_tree->object.oid;
+	oid =3D get_commit_tree_oid(commit);
=20
 	/* Root commit? */
 	parents =3D get_saved_parents(opt, commit);
@@ -831,7 +831,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 			 * we merged _in_.
 			 */
 			parse_commit_or_die(parents->item);
-			diff_tree_oid(&parents->item->maybe_tree->object.oid,
+			diff_tree_oid(get_commit_tree_oid(parents->item),
 				      oid, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 			return !opt->loginfo;
@@ -846,7 +846,7 @@ static int log_tree_diff(struct rev_info *opt, struct c=
ommit *commit, struct log
 		struct commit *parent =3D parents->item;
=20
 		parse_commit_or_die(parent);
-		diff_tree_oid(&parent->maybe_tree->object.oid,
+		diff_tree_oid(get_commit_tree_oid(parent),
 			      oid, "", &opt->diffopt);
 		log_tree_diff_flush(opt);
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 67886a4ff8..a7e1938b8a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2154,8 +2154,8 @@ int merge_recursive(struct merge_options *o,
 		read_cache();
=20
 	o->ancestor =3D "merged common ancestors";
-	clean =3D merge_trees(o, h1->maybe_tree, h2->maybe_tree,
-			    merged_common_ancestors->maybe_tree,
+	clean =3D merge_trees(o, get_commit_tree(h1), get_commit_tree(h2),
+			    get_commit_tree(merged_common_ancestors),
 			    &mrtree);
 	if (clean < 0) {
 		flush_output(o);
diff --git a/notes-merge.c b/notes-merge.c
index 1d3edc8942..4a73a2169b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -600,14 +600,14 @@ int notes_merge(struct notes_merge_options *o,
 			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
 		base_oid =3D &bases->item->object.oid;
-		base_tree_oid =3D &bases->item->maybe_tree->object.oid;
+		base_tree_oid =3D get_commit_tree_oid(bases->item);
 		if (o->verbosity >=3D 4)
 			printf("One merge base found (%.7s)\n",
 			       oid_to_hex(base_oid));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
 		base_oid =3D &bases->item->object.oid;
-		base_tree_oid =3D &bases->item->maybe_tree->object.oid;
+		base_tree_oid =3D get_commit_tree_oid(bases->item);
 		if (o->verbosity >=3D 3)
 			printf("Multiple merge bases found. Using the first "
 				"(%.7s)\n", oid_to_hex(base_oid));
@@ -634,8 +634,9 @@ int notes_merge(struct notes_merge_options *o,
 		goto found_result;
 	}
=20
-	result =3D merge_from_diffs(o, base_tree_oid, &local->maybe_tree->object.=
oid,
-				  &remote->maybe_tree->object.oid, local_tree);
+	result =3D merge_from_diffs(o, base_tree_oid,
+				  get_commit_tree_oid(local),
+				  get_commit_tree_oid(remote), local_tree);
=20
 	if (result !=3D 0) { /* non-trivial merge (with or without conflicts) */
 		/* Commit (partial) result */
diff --git a/packfile.c b/packfile.c
index 3eb9c4a36e..88ba819151 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1925,7 +1925,7 @@ static int add_promisor_object(const struct object_id=
 *oid,
 		struct commit *commit =3D (struct commit *) obj;
 		struct commit_list *parents =3D commit->parents;
=20
-		oidset_insert(set, &commit->maybe_tree->object.oid);
+		oidset_insert(set, get_commit_tree_oid(commit));
 		for (; parents; parents =3D parents->next)
 			oidset_insert(set, &parents->item->object.oid);
 	} else if (obj->type =3D=3D OBJ_TAG) {
diff --git a/pretty.c b/pretty.c
index 42095ea495..15997f5e01 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1161,10 +1161,11 @@ static size_t format_commit_one(struct strbuf *sb, =
/* in UTF-8 */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
 	case 'T':		/* tree hash */
-		strbuf_addstr(sb, oid_to_hex(&commit->maybe_tree->object.oid));
+		strbuf_addstr(sb, oid_to_hex(get_commit_tree_oid(commit)));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		strbuf_add_unique_abbrev(sb, commit->maybe_tree->object.oid.hash,
+		strbuf_add_unique_abbrev(sb,
+					 get_commit_tree_oid(commit)->hash,
 					 c->pretty_ctx->abbrev);
 		return 1;
 	case 'P':		/* parent hashes */
diff --git a/ref-filter.c b/ref-filter.c
index 783a3ee6cf..e201bf60c6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -815,7 +815,7 @@ static void grab_commit_values(struct atom_value *val, =
int deref, struct object
 		if (deref)
 			name++;
 		if (!strcmp(name, "tree")) {
-			v->s =3D xstrdup(oid_to_hex(&commit->maybe_tree->object.oid));
+			v->s =3D xstrdup(oid_to_hex(get_commit_tree_oid(commit)));
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->value =3D commit_list_count(commit->parents);
diff --git a/revision.c b/revision.c
index 7d66e32e83..496db63b4b 100644
--- a/revision.c
+++ b/revision.c
@@ -440,8 +440,8 @@ static void file_change(struct diff_options *options,
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit)
 {
-	struct tree *t1 =3D parent->maybe_tree;
-	struct tree *t2 =3D commit->maybe_tree;
+	struct tree *t1 =3D get_commit_tree(parent);
+	struct tree *t2 =3D get_commit_tree(commit);
=20
 	if (!t1)
 		return REV_TREE_NEW;
@@ -477,7 +477,7 @@ static int rev_compare_tree(struct rev_info *revs,
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *co=
mmit)
 {
 	int retval;
-	struct tree *t1 =3D commit->maybe_tree;
+	struct tree *t1 =3D get_commit_tree(commit);
=20
 	if (!t1)
 		return 0;
@@ -615,7 +615,7 @@ static void try_to_simplify_commit(struct rev_info *rev=
s, struct commit *commit)
 	if (!revs->prune)
 		return;
=20
-	if (!commit->maybe_tree)
+	if (!get_commit_tree(commit))
 		return;
=20
 	if (!commit->parents) {
diff --git a/sequencer.c b/sequencer.c
index 3b2823c8b5..a5798b16d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -499,8 +499,8 @@ static int do_recursive_merge(struct commit *base, stru=
ct commit *next,
 	o.show_rename_progress =3D 1;
=20
 	head_tree =3D parse_tree_indirect(head);
-	next_tree =3D next ? next->maybe_tree : empty_tree();
-	base_tree =3D base ? base->maybe_tree : empty_tree();
+	next_tree =3D next ? get_commit_tree(next) : empty_tree();
+	base_tree =3D base ? get_commit_tree(base) : empty_tree();
=20
 	for (xopt =3D opts->xopts; xopt !=3D opts->xopts + opts->xopts_nr; xopt++=
)
 		parse_merge_opt(&o, *xopt);
@@ -561,7 +561,7 @@ static int is_index_unchanged(void)
 			return error(_("unable to update cache tree"));
=20
 	return !oidcmp(&active_cache_tree->oid,
-		       &head_commit->maybe_tree->object.oid);
+		       get_commit_tree_oid(head_commit));
 }
=20
 static int write_author_script(const char *message)
@@ -1118,7 +1118,7 @@ static int try_to_commit(struct strbuf *msg, const ch=
ar *author,
 	}
=20
 	if (!(flags & ALLOW_EMPTY) && !oidcmp(current_head ?
-					      &current_head->maybe_tree->object.oid :
+					      get_commit_tree_oid(current_head) :
 					      &empty_tree_oid, &tree)) {
 		res =3D 1; /* run 'git commit' to display error message */
 		goto out;
@@ -1216,12 +1216,12 @@ static int is_original_commit_empty(struct commit *=
commit)
 		if (parse_commit(parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
-		ptree_oid =3D &parent->maybe_tree->object.oid;
+		ptree_oid =3D get_commit_tree_oid(parent);
 	} else {
 		ptree_oid =3D the_hash_algo->empty_tree; /* commit is root */
 	}
=20
-	return !oidcmp(ptree_oid, &commit->maybe_tree->object.oid);
+	return !oidcmp(ptree_oid, get_commit_tree_oid(commit));
 }
=20
 /*
diff --git a/sha1_name.c b/sha1_name.c
index 26b22cb628..0f408e9143 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -896,7 +896,7 @@ struct object *peel_to_type(const char *name, int namel=
en,
 		if (o->type =3D=3D OBJ_TAG)
 			o =3D ((struct tag*) o)->tagged;
 		else if (o->type =3D=3D OBJ_COMMIT)
-			o =3D &(((struct commit *) o)->maybe_tree->object);
+			o =3D &(get_commit_tree(((struct commit *)o))->object);
 		else {
 			if (name)
 				error("%.*s: expected %s type, but the object "
diff --git a/tree.c b/tree.c
index dbc5e0be54..dec53f3eca 100644
--- a/tree.c
+++ b/tree.c
@@ -109,7 +109,7 @@ static int read_tree_1(struct tree *tree, struct strbuf=
 *base,
 				    oid_to_hex(entry.oid),
 				    base->buf, entry.path);
=20
-			oidcpy(&oid, &commit->maybe_tree->object.oid);
+			oidcpy(&oid, get_commit_tree_oid(commit));
 		}
 		else
 			continue;
@@ -248,7 +248,7 @@ struct tree *parse_tree_indirect(const struct object_id=
 *oid)
 		if (obj->type =3D=3D OBJ_TREE)
 			return (struct tree *) obj;
 		else if (obj->type =3D=3D OBJ_COMMIT)
-			obj =3D &(((struct commit *) obj)->maybe_tree->object);
+			obj =3D &(get_commit_tree(((struct commit *)obj))->object);
 		else if (obj->type =3D=3D OBJ_TAG)
 			obj =3D ((struct tag *) obj)->tagged;
 		else
diff --git a/walker.c b/walker.c
index 1d5f3059a2..f51b855872 100644
--- a/walker.c
+++ b/walker.c
@@ -87,7 +87,7 @@ static int process_commit(struct walker *walker, struct c=
ommit *commit)
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
=20
 	if (walker->get_tree) {
-		if (process(walker, &commit->maybe_tree->object))
+		if (process(walker, &get_commit_tree(commit)->object))
 			return -1;
 		if (!walker->get_all)
 			walker->get_tree =3D 0;
--=20
2.17.0

