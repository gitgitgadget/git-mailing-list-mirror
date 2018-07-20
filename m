Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78C2E1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbeGTRWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 13:22:15 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:17920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387828AbeGTRWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 13:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqTi2o8GPnxYKq1zy4w2Nv5cQtHIZK8qyEgqqNzvuoA=;
 b=cE8b4cKiQYwM+UJGaIIKo7fqQUQaElguw58FH0szAb6WGBi8upAC289pwXQpWyx0X2PpDmyTh+8biUh7ByU6tM3F8X85uOARgQEqTtlp1F53wRNopMejHkjLGjTSD/90/Z7Fyy6j1Ji3NaMakfqokAkJxus+xdOFGfAW89FctiE=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0929.namprd21.prod.outlook.com (52.132.20.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.1; Fri, 20 Jul 2018 16:33:04 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::5072:9195:b05b:ed05%2]) with mapi id 15.20.0995.008; Fri, 20 Jul 2018
 16:33:04 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "sbeller@google.com" <sbeller@google.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 02/18] commit.h: remove method declarations
Thread-Topic: [PATCH v2 02/18] commit.h: remove method declarations
Thread-Index: AQHUIEdVZg7YS95AJUutishLMHIOew==
Date:   Fri, 20 Jul 2018 16:33:04 +0000
Message-ID: <20180720163227.105950-3-dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0084.namprd02.prod.outlook.com
 (2603:10b6:405:60::25) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0929;6:5RLdapJZPEDpr/wKNWg4NUMpTkdJXYuMVMXWePzx9lM8sWEoNokmz0Ixk4sXsxilU1YVMMqqWHQqKqwSUpO/67AyJeQNDtiK+2FQZS3ouKEfw/cvJ3gUQ+Ds05E+xrC83SfI/GJAGl31pdAznmxPteLPMRcl9jMhQY4tkbIWnolws5kssWhmxQzilU5VLVqOQ7f/06Q+2vPez+fkPQvAMxZc/Zg2l0Rnh20xDnFQ1w+X5fH/htkpyKYSq0Sy97s7rDb72/8YEtSdKSbIMyhsXkGVv8eSU1XSe5P8eSUdYAfQfy1CrRHNjFexiXStAygvOxrLSHW9NltAIy5C5GhSYnOBe4IYo/Ex3VPqeXYYsJ8lUyM8gKJ/mU7e8/j59mzF/k+dnTQeiHT9/ILa2KNcuSuAYytU0qkLD4V6CExLQopO2Ahqi14eXxGOuof0L+SHzm2LmgpHAGGDekNFJOIM8g==;5:teIlpYM384iohBtsiEaJAWltgqeN3Um3FOvmXhEpYPh24AIBibnmkwO4Q6mZZtUKoC/zqX0Y/vBPGJz8dNkCpZ7AhUAM/IIA+eD2SZHRW3Go/UKBVgqhQv1CWAolvTng8OWBxyj/6IjxxXdDXBIInGh+h2DtN3Xz8aKgpC19Vfo=;7:PDEX944QVyGaCla96TwjzsUWtLES6vJ33JjFdId86jL1eQmCtfzCD9oW0SKrI9yV7NSe/BRnj220lUFdLzSnOi9YaFaJ03RDS4p5jg51Be2ymgca3OyQ4dUcuKba0f5F7UfrlN6hnnteARlKhkuShK48s2k4/LzTteNVCa4JuZxpNq8oNjhiNWv6cQwwra7GLzthMaCklZ5nn9Jiv9DhsTghCPcLPFhPAsgfflSp6jiJpNDy3bwvOs8u7rD+Kw3d
x-ms-office365-filtering-correlation-id: 78e20368-e232-461a-5bce-08d5ee5e776e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:BL0PR2101MB0929;
x-ms-traffictypediagnostic: BL0PR2101MB0929:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0929B4AB52BCABDEDBAE43CCA1510@BL0PR2101MB0929.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0929;
x-forefront-prvs: 073966E86B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(376002)(39860400002)(189003)(199004)(6512007)(305945005)(7736002)(14454004)(5640700003)(6116002)(6436002)(105586002)(54906003)(53936002)(25786009)(52116002)(76176011)(106356001)(2501003)(446003)(46003)(478600001)(68736007)(11346002)(6506007)(2900100001)(2906002)(5250100002)(386003)(186003)(102836004)(2351001)(10090500001)(97736004)(6916009)(8676002)(107886003)(8936002)(1730700003)(81156014)(6486002)(4326008)(486006)(81166006)(10290500003)(39060400002)(5660300001)(86362001)(575784001)(22452003)(1076002)(14444005)(316002)(2616005)(36756003)(256004)(476003)(86612001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0929;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZQaI8vr3/nYcTeltKZX7SVyNCovObrdGSSOH30Q/gBVtGrH0vGyzFbvRpnvJtlnvzp03KUjzjuQDEoOTDTkidVpT4kTp4JzUaLc3uClGLovWr5MJiOJNfz4A0zkOfM60Z/6zqvoWQIBl9x9MHJKra8ixcnNNdygNTUFz6Wv/a5EhNPNr+AeB8Gq8Wfq0/leHWGAaYy/ylK/fMRCW9OxYYc8t+cRqVi1pDefH+sQ+2XasvFHURwV3VfhRsQIFI0PmHepCOuMDqyEAZH25XG3QtRvNuM8MbSBEanBVGuAREQ6hjM7S8DkibD69RCiKeTpcphEAk8GOsZZ4Gfu4oKLAh0WVHGw3YPX/iputiqKzm+I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e20368-e232-461a-5bce-08d5ee5e776e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2018 16:33:04.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0929
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These methods are now declared in commit-reach.h. Remove them from
commit.h and add new include statements in all files that require these
declarations.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 bisect.c                |  1 +
 builtin/branch.c        |  1 +
 builtin/commit.c        |  1 +
 builtin/fetch.c         |  1 +
 builtin/fmt-merge-msg.c |  1 +
 builtin/log.c           |  1 +
 builtin/merge-base.c    |  1 +
 builtin/merge.c         |  1 +
 builtin/pull.c          |  1 +
 builtin/receive-pack.c  |  1 +
 builtin/rev-parse.c     |  1 +
 commit.h                | 29 -----------------------------
 fast-import.c           |  1 +
 http-push.c             |  2 +-
 merge-recursive.c       |  1 +
 notes-merge.c           |  1 +
 pack-bitmap-write.c     |  1 +
 ref-filter.c            |  1 +
 remote.c                |  1 +
 revision.c              |  1 +
 sequencer.c             |  1 +
 sha1-name.c             |  1 +
 shallow.c               |  1 +
 submodule.c             |  1 +
 24 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/bisect.c b/bisect.c
index e1275ba79e..d023543c91 100644
--- a/bisect.c
+++ b/bisect.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "commit-slab.h"
+#include "commit-reach.h"
=20
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
diff --git a/builtin/branch.c b/builtin/branch.c
index a50632fb23..9a787447f4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -23,6 +23,7 @@
 #include "ref-filter.h"
 #include "worktree.h"
 #include "help.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
diff --git a/builtin/commit.c b/builtin/commit.c
index 158e3f843a..b5c608458e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -33,6 +33,7 @@
 #include "sequencer.h"
 #include "mailmap.h"
 #include "help.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_commit_usage[] =3D {
 	N_("git commit [<options>] [--] <pathspec>..."),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f5d960baec..7de234774b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -22,6 +22,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "list-objects-filter-options.h"
+#include "commit-reach.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index ff165c0fcd..7277d557b2 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -12,6 +12,7 @@
 #include "fmt-merge-msg.h"
 #include "gpg-interface.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static const char * const fmt_merge_msg_usage[] =3D {
 	N_("git fmt-merge-msg [-m <message>] [--log[=3D<n>] | --no-log] [--file <=
file>]"),
diff --git a/builtin/log.c b/builtin/log.c
index 55a6286d7f..333d97c692 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -31,6 +31,7 @@
 #include "progress.h"
 #include "commit-slab.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 #define MAIL_DEFAULT_WRAP 72
=20
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 08d91b1f0c..1c92099070 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "parse-options.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
diff --git a/builtin/merge.c b/builtin/merge.c
index d1b547d973..4c601c40a2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -36,6 +36,7 @@
 #include "packfile.h"
 #include "tag.h"
 #include "alias.h"
+#include "commit-reach.h"
=20
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
diff --git a/builtin/pull.c b/builtin/pull.c
index 4e78935392..15ad010968 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -22,6 +22,7 @@
 #include "tempfile.h"
 #include "lockfile.h"
 #include "wt-status.h"
+#include "commit-reach.h"
=20
 enum rebase_type {
 	REBASE_INVALID =3D -1,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 400d31c18c..d8467f9734 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -27,6 +27,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "protocol.h"
+#include "commit-reach.h"
=20
 static const char * const receive_pack_usage[] =3D {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 0f09bbbf65..455f62246d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -14,6 +14,7 @@
 #include "revision.h"
 #include "split-index.h"
 #include "submodule.h"
+#include "commit-reach.h"
=20
 #define DO_REVS		1
 #define DO_NOREV	2
diff --git a/commit.h b/commit.h
index da0db36eba..e2c99d9b04 100644
--- a/commit.h
+++ b/commit.h
@@ -204,13 +204,6 @@ struct commit_graft *read_graft_line(struct strbuf *li=
ne);
 int register_commit_graft(struct repository *r, struct commit_graft *, int=
);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struc=
t object_id *oid);
=20
-extern struct commit_list *get_merge_bases(struct commit *rev1, struct com=
mit *rev2);
-extern struct commit_list *get_merge_bases_many(struct commit *one, int n,=
 struct commit **twos);
-extern struct commit_list *get_octopus_merge_bases(struct commit_list *in)=
;
-
-/* To be used only when object flags after this call no longer matter */
-extern struct commit_list *get_merge_bases_many_dirty(struct commit *one, =
int n, struct commit **twos);
-
 /* largest positive number a signed 32-bit integer can contain */
 #define INFINITE_DEPTH 0x7fffffff
=20
@@ -258,32 +251,10 @@ extern int delayed_reachability_test(struct shallow_i=
nfo *si, int c);
 extern void prune_shallow(int show_only);
 extern struct trace_key trace_shallow;
=20
-int is_descendant_of(struct commit *, struct commit_list *);
-int in_merge_bases(struct commit *, struct commit *);
-int in_merge_bases_many(struct commit *, int, struct commit **);
-
 extern int interactive_add(int argc, const char **argv, const char *prefix=
, int patch);
 extern int run_add_interactive(const char *revision, const char *patch_mod=
e,
 			       const struct pathspec *pathspec);
=20
-/*
- * Takes a list of commits and returns a new list where those
- * have been removed that can be reached from other commits in
- * the list. It is useful for, e.g., reducing the commits
- * randomly thrown at the git-merge command and removing
- * redundant commits that the user shouldn't have given to it.
- *
- * This function destroys the STALE bit of the commit objects'
- * flags.
- */
-extern struct commit_list *reduce_heads(struct commit_list *heads);
-
-/*
- * Like `reduce_heads()`, except it replaces the list. Use this
- * instead of `foo =3D reduce_heads(foo);` to avoid memory leaks.
- */
-extern void reduce_heads_replace(struct commit_list **heads);
-
 struct commit_extra_header {
 	struct commit_extra_header *next;
 	char *key;
diff --git a/fast-import.c b/fast-import.c
index 3ea5781029..4a93df3839 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -171,6 +171,7 @@ Format of STDIN stream:
 #include "packfile.h"
 #include "object-store.h"
 #include "mem-pool.h"
+#include "commit-reach.h"
=20
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
diff --git a/http-push.c b/http-push.c
index 5eaf551b51..91fdc7e1d5 100644
--- a/http-push.c
+++ b/http-push.c
@@ -14,7 +14,7 @@
 #include "argv-array.h"
 #include "packfile.h"
 #include "object-store.h"
-
+#include "commit-reach.h"
=20
 #ifdef EXPAT_NEEDS_XMLPARSE_H
 #include <xmlparse.h>
diff --git a/merge-recursive.c b/merge-recursive.c
index 1dd6ec384d..8155dee9a9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -27,6 +27,7 @@
 #include "dir.h"
 #include "submodule.h"
 #include "revision.h"
+#include "commit-reach.h"
=20
 struct path_hashmap_entry {
 	struct hashmap_entry e;
diff --git a/notes-merge.c b/notes-merge.c
index 76ab19e702..12dfdf6c17 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -12,6 +12,7 @@
 #include "notes-merge.h"
 #include "strbuf.h"
 #include "notes-utils.h"
+#include "commit-reach.h"
=20
 struct notes_merge_pair {
 	struct object_id obj, base, local, remote;
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 953c5dd84d..55bcab907c 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -11,6 +11,7 @@
 #include "pack-bitmap.h"
 #include "sha1-lookup.h"
 #include "pack-objects.h"
+#include "commit-reach.h"
=20
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/ref-filter.c b/ref-filter.c
index 9b2da88392..fca3ad040a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -19,6 +19,7 @@
 #include "wt-status.h"
 #include "commit-slab.h"
 #include "commit-graph.h"
+#include "commit-reach.h"
=20
 static struct ref_msg {
 	const char *gone;
diff --git a/remote.c b/remote.c
index 26b1fbd9a8..8e99b9888a 100644
--- a/remote.c
+++ b/remote.c
@@ -12,6 +12,7 @@
 #include "string-list.h"
 #include "mergesort.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 enum map_direction { FROM_SRC, FROM_DST };
=20
diff --git a/revision.c b/revision.c
index 4dbe406bed..3205a3947a 100644
--- a/revision.c
+++ b/revision.c
@@ -24,6 +24,7 @@
 #include "packfile.h"
 #include "worktree.h"
 #include "argv-array.h"
+#include "commit-reach.h"
=20
 volatile show_early_output_fn_t show_early_output;
=20
diff --git a/sequencer.c b/sequencer.c
index d1d07bed5b..97bdfd48b4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "commit-reach.h"
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
=20
diff --git a/sha1-name.c b/sha1-name.c
index 009faab4ae..7215b30b88 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -12,6 +12,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 static int get_oid_oneline(const char *, struct object_id *, struct commit=
_list *);
=20
diff --git a/shallow.c b/shallow.c
index dbe8a2a290..99fd2d1ba0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -16,6 +16,7 @@
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "repository.h"
+#include "commit-reach.h"
=20
 void set_alternate_shallow_file(struct repository *r, const char *path, in=
t override)
 {
diff --git a/submodule.c b/submodule.c
index 6688dd5d45..6650ed7aa0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "worktree.h"
 #include "parse-options.h"
 #include "object-store.h"
+#include "commit-reach.h"
=20
 static int config_update_recurse_submodules =3D RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names =3D STRING_LIST_INIT_DUP=
;
--=20
2.18.0.118.gd4f65b8d14

