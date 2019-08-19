Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 078EE1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHSJLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:11:43 -0400
Received: from mut-mta1-se01b-zose1-fr.yulpa.io ([185.49.22.247]:38631 "EHLO
        mut-mta1-se01b-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfHSJLn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Aug 2019 05:11:43 -0400
Received: from mut-zose1-mta-hub-out01-fr.yulpa.io ([185.49.20.54] helo=mut-zose1-mta-hub-outmua01b-fr.yulpa.io)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <git@matthieu-moy.fr>)
        id 1hzdhJ-000CLc-Vy; Mon, 19 Aug 2019 11:11:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 4CDC61020AB;
        Mon, 19 Aug 2019 11:11:28 +0200 (CEST)
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2lOZyjGVuFhq; Mon, 19 Aug 2019 11:11:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTP id 945331020B0;
        Mon, 19 Aug 2019 11:11:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mut-zose1.yulpa.io
Received: from mut-zose1-mta-hub-outmua01b-fr.yulpa.io ([127.0.0.1])
        by localhost (mut-zose1-mta-hub-outmua01b-fr.yulpa.io [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CZgVk2nLupxp; Mon, 19 Aug 2019 11:11:26 +0200 (CEST)
Received: from moylip.lip.ens-lyon.fr (dhcp-13-233.lip.ens-lyon.fr [140.77.13.233])
        (Authenticated sender: matthieu.moy@matthieu-moy.fr)
        by mut-zose1-mta-hub-outmua01b-fr.yulpa.io (Postfix) with ESMTPSA id 432AB1020AB;
        Mon, 19 Aug 2019 11:11:26 +0200 (CEST)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     git@vger.kernel.org, matthieu.moy@univ-lyon1.fr
Cc:     corentin.bompard@etu.univ-lyon1.fr, gitster@pobox.com,
        nathan.berbezier@etu.univ-lyon1.fr,
        pablo.chabanne@etu.univ-lyon1.fr,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: [PATCH v2] pull, fetch: add --set-upstream option
Date:   Mon, 19 Aug 2019 11:11:20 +0200
Message-Id: <20190819091120.15862-1-git@matthieu-moy.fr>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0
In-Reply-To: <86a7c5cykq.fsf@matthieu-moy.fr>
References: <86a7c5cykq.fsf@matthieu-moy.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: 185.49.20.54
X-yulPa-Domain: mut-zose1.yulpa.io
X-yulPa-Username: 185.49.20.54
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.54@mut-zose1.yulpa.io
X-yulPa-Outgoing-Class: ham
X-yulPa-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0YiRRkpbHZ8F3zevhEShTfypSDasLI4SayDByyq9LIhVn7hgg8iP8ijS
 F+4rABFRX0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3K/ul8EzZFK7PjxbL6TZ5y/ABn
 Bx2qQbdL1/YP7F9FT18R74xqT0ZUtArmRSbxpjsFVbNiDoRVAi1uIJx5hODtLHI7vtBXWEq8QtPk
 gbiwp8pIJb9212px10C3TdL9EtOWlm0qUmsuKi3RJj9knUTJti3CueNfqMJBYzPoh8qXShBU6C1I
 zYUzQVV3UCXOcMrgj0EZBWlS7yxT2d6NX4GqC9q9Uvxs027xYD32j0KG+ezAnai31M7dF8usmm8O
 3+jwcV+LFnRWXC73hV4kmTQ96+KVse1sVhWabI0/+PN3sIJkYWvWNZaZ0U+2WAj4Iohtz9+0obOQ
 /4Au5swlnGadp6CRlU8C1WnyUnLVFToIQvrIrxLCZp9Sd4tds0J6Y5wJwEr229KB/6clHODM7k6D
 iKYNZ1uK2CRFUd80lC+BinR7adGiiPHrMlYIVkH60xZhKEyo7eGOk4CYU1DDb9mhHHyNorheeibm
 3WriJmfuZ98L+ZOSbzjImTn25GTijHwfVObthVmcSa2zH/eZl+9MwJT7qmWzK4Bx1WIeFtGbNIt7
 vMDcwLqLGB+xDtP7BtE8Hz0bzpJl/jutim/hvpmAa6SoOE974E0u5C4r82NtIfvEaZWzla67okw5
 +LTnA9hhPBHH57cLkN8Bd0wm8jqRC7iK9ree+gUyHwXcNW6nr8Boh9VoIekQHpwUfpYnEThmEGxS
 Fp15maAKnluaxCcVQS6OEx1CThXglRZxaMInFD+veM3VoQwUTrV2yHX8t3FjxOtvpADbLjUx/vmK
 /Pr5BbCophMACiHsRlf8t4qYyg2yFAyQLbDKYkHQign4W6SCvRKnzt0jxNZYu4WrfbbZmjFtbEyn
 2P4u4n4ZEouAXty96lTl15RD5tA1v8q+kirKCHQC9gWc/ZNdDYukLAlaS2FCV6JLEkABjWP4C0cH
 6OPMcZj3HQJxbCt8p+07Wd6qy7etE50//vdIE+/r79PaJyPbaAeFrOWFYLyGyjW8koxgJYzB1qHm
 ab5b47wBJGXTmx3sX1QMTGj9cMllOHwI+G+1+ao5IFxjNz+fNkr2BedL0iD8CBN6Nyboe0elXlPy
 26NJ4nFxT6fDKMo/x2MtXquDnONeMVij5A2eZiW1A6cHoD+Lq/Kh4BKeITbvYbQd9KHbyJYnqURN
 xchfgcTIikVcTYiIgVJZ+JgMHCV2GtAxL7hrJSk60SF3F6RYOYr2
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>

Add the --set-upstream option to git pull/fetch
which lets the user set the upstream configuration
(branch.<current-branch-name>.merge and
branch.<current-branch-name>.remote) for the current branch.

A typical use-case is:

    git clone http://example.com/my-public-fork
    git remote add main http://example.com/project-main-repo
    git pull --set-upstream main master

or, instead of the last line:

    git fetch --set-upstream main master
    git merge # or git rebase

This is mostly equivalent to cloning project-main-repo (which sets
upsteam) and then "git remote add" my-public-fork, but may feel more
natural for people using a hosting system which allows forking from
the web UI.

This functionality is analog to "git push --set-upstream".

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
Patch-edited-by: Matthieu Moy <git@matthieu-moy.fr>
---
Only style fixes and slightly improved commit message since v1.
Interdiff below:

  diff --git a/builtin/fetch.c b/builtin/fetch.c
  index 5557ae1c04..54d6b01892 100644
  --- a/builtin/fetch.c
  +++ b/builtin/fetch.c
  @@ -51,7 +51,8 @@ static int fetch_prune_tags_config =3D -1; /* unspeci=
fied */
   static int prune_tags =3D -1; /* unspecified */
   #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
  =20
  -static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity, deepen_relative, set_upstream;
  +static int all, append, dry_run, force, keep, multiple, update_head_ok=
;
  +static int verbosity, deepen_relative, set_upstream;
   static int progress =3D -1;
   static int enable_auto_gc =3D 1;
   static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
  @@ -1377,12 +1378,14 @@ static int do_fetch(struct transport *transport=
,
   		struct ref *source_ref =3D NULL;
  =20
   		/*
  -		 * We're setting the upstream configuration for the current branch. =
The
  -		 * relevent upstream is the fetched branch that is meant to be merge=
d with
  -		 * the current one, i.e. the one fetched to FETCH_HEAD.
  +		 * We're setting the upstream configuration for the
  +		 * current branch. The relevent upstream is the
  +		 * fetched branch that is meant to be merged with the
  +		 * current one, i.e. the one fetched to FETCH_HEAD.
   		 *
  -		 * When there are several such branches, consider the request ambigu=
ous and
  -		 * err on the safe side by doing nothing and just emit a warning.
  +		 * When there are several such branches, consider the
  +		 * request ambiguous and err on the safe side by doing
  +		 * nothing and just emit a warning.
   		 */
   		for (rm =3D ref_map; rm; rm =3D rm->next) {
   			if (!rm->peer_ref) {
  @@ -1396,17 +1399,17 @@ static int do_fetch(struct transport *transport=
,
   		}
   		if (source_ref) {
   			if (!strcmp(source_ref->name, "HEAD") ||
  -				starts_with(source_ref->name, "refs/heads/")) {
  -				install_branch_config(0, branch->name,
  +			    starts_with(source_ref->name, "refs/heads/"))
  +				install_branch_config(0,
  +						      branch->name,
   						      transport->remote->name,
   						      source_ref->name);
  -			} else if (starts_with(source_ref->name, "refs/remotes/")) {
  +			else if (starts_with(source_ref->name, "refs/remotes/"))
   				warning(_("not setting upstream for a remote remote-tracking branc=
h"));
  -			} else if (starts_with(source_ref->name, "refs/tags/")) {
  +			else if (starts_with(source_ref->name, "refs/tags/"))
   				warning(_("not setting upstream for a remote tag"));
  -			} else {
  +			else
   				warning(_("unknown branch type"));
  -			}
   		} else {
   			warning(_("no source branch found.\n"
   				"you need to specify exactly one branch with the --set-upstream op=
tion."));
 =20

 Documentation/fetch-options.txt |   7 ++
 builtin/fetch.c                 |  51 ++++++++-
 builtin/pull.c                  |   6 ++
 t/t5553-set-upstream.sh         | 178 ++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+), 1 deletion(-)
 create mode 100755 t/t5553-set-upstream.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-option=
s.txt
index 3c9b4f9e09..99df1f3d4e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -169,6 +169,13 @@ ifndef::git-pull[]
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=3Dno` option).
=20
+--set-upstream::
+	If the remote is fetched successfully, pull and add upstream
+	(tracking) reference, used by argument-less
+	linkgit:git-pull[1] and other commands. For more information,
+	see `branch.<name>.merge` and `branch.<name>.remote` in
+	linkgit:git-config[1].
+
 --submodule-prefix=3D<path>::
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 717dd14e89..54d6b01892 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "branch.h"
=20
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
=20
@@ -50,7 +51,8 @@ static int fetch_prune_tags_config =3D -1; /* unspecifi=
ed */
 static int prune_tags =3D -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
=20
-static int all, append, dry_run, force, keep, multiple, update_head_ok, =
verbosity, deepen_relative;
+static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int verbosity, deepen_relative, set_upstream;
 static int progress =3D -1;
 static int enable_auto_gc =3D 1;
 static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
@@ -123,6 +125,8 @@ static struct option builtin_fetch_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "all", &all,
 		 N_("fetch from all remotes")),
+	OPT_BOOL(0, "set-upstream", &set_upstream,
+		 N_("set upstream for git pull/fetch")),
 	OPT_BOOL('a', "append", &append,
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
@@ -1367,6 +1371,51 @@ static int do_fetch(struct transport *transport,
 		retcode =3D 1;
 		goto cleanup;
 	}
+
+	if (set_upstream) {
+		struct branch *branch =3D branch_get("HEAD");
+		struct ref *rm;
+		struct ref *source_ref =3D NULL;
+
+		/*
+		 * We're setting the upstream configuration for the
+		 * current branch. The relevent upstream is the
+		 * fetched branch that is meant to be merged with the
+		 * current one, i.e. the one fetched to FETCH_HEAD.
+		 *
+		 * When there are several such branches, consider the
+		 * request ambiguous and err on the safe side by doing
+		 * nothing and just emit a warning.
+		 */
+		for (rm =3D ref_map; rm; rm =3D rm->next) {
+			if (!rm->peer_ref) {
+				if (source_ref) {
+					warning(_("multiple branch detected, incompatible with --set-upstre=
am"));
+					goto skip;
+				} else {
+					source_ref =3D rm;
+				}
+			}
+		}
+		if (source_ref) {
+			if (!strcmp(source_ref->name, "HEAD") ||
+			    starts_with(source_ref->name, "refs/heads/"))
+				install_branch_config(0,
+						      branch->name,
+						      transport->remote->name,
+						      source_ref->name);
+			else if (starts_with(source_ref->name, "refs/remotes/"))
+				warning(_("not setting upstream for a remote remote-tracking branch"=
));
+			else if (starts_with(source_ref->name, "refs/tags/"))
+				warning(_("not setting upstream for a remote tag"));
+			else
+				warning(_("unknown branch type"));
+		} else {
+			warning(_("no source branch found.\n"
+				"you need to specify exactly one branch with the --set-upstream opti=
on."));
+		}
+	}
+ skip:
 	free_refs(ref_map);
=20
 	/* if neither --no-tags nor --tags was specified, do automated tag
diff --git a/builtin/pull.c b/builtin/pull.c
index f1eaf6e6ed..d25ff13a60 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -129,6 +129,7 @@ static char *opt_refmap;
 static char *opt_ipv4;
 static char *opt_ipv6;
 static int opt_show_forced_updates =3D -1;
+static char *set_upstream;
=20
 static struct option pull_options[] =3D {
 	/* Shared options */
@@ -243,6 +244,9 @@ static struct option pull_options[] =3D {
 		PARSE_OPT_NOARG),
 	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 		 N_("check for forced-updates on all updated branches")),
+	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
+		N_("set upstream for git pull/fetch"),
+		PARSE_OPT_NOARG),
=20
 	OPT_END()
 };
@@ -556,6 +560,8 @@ static int run_fetch(const char *repo, const char **r=
efspecs)
 		argv_array_push(&args, "--show-forced-updates");
 	else if (opt_show_forced_updates =3D=3D 0)
 		argv_array_push(&args, "--no-show-forced-updates");
+	if (set_upstream)
+		argv_array_push(&args, set_upstream);
=20
 	if (repo) {
 		argv_array_push(&args, repo);
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
new file mode 100755
index 0000000000..81975ad8f9
--- /dev/null
+++ b/t/t5553-set-upstream.sh
@@ -0,0 +1,178 @@
+#!/bin/sh
+
+test_description=3D'"git fetch/pull --set-upstream" basic tests.'
+. ./test-lib.sh
+
+check_config () {
+	printf "%s\n" "$2" "$3" >"expect.$1" &&
+	{
+		git config "branch.$1.remote" && git config "branch.$1.merge"
+	} >"actual.$1" &&
+	test_cmp "expect.$1" "actual.$1"
+}
+
+check_config_missing () {
+	test_expect_code 1 git config "branch.$1.remote" &&
+	test_expect_code 1 git config "branch.$1.merge"
+}
+
+clear_config () {
+	for branch in "$@"; do
+		test_might_fail git config --unset-all "branch.$branch.remote"
+		test_might_fail git config --unset-all "branch.$branch.merge"
+	done
+}
+
+ensure_fresh_upstream () {
+	rm -rf parent && git init --bare parent
+}
+
+test_expect_success 'setup bare parent fetch' '
+	ensure_fresh_upstream &&
+	git remote add upstream parent
+'
+
+test_expect_success 'setup commit on master and other fetch' '
+	test_commit one &&
+	git push upstream master &&
+	git checkout -b other &&
+	test_commit two &&
+	git push upstream other
+'
+
+# tests for fetch --set-upstream
+
+test_expect_success 'fetch --set-upstream does not set upstream w/o bran=
ch' '
+	clear_config master other &&
+	git checkout master &&
+	git fetch --set-upstream upstream &&
+	check_config_missing master &&
+	check_config_missing other
+'
+
+test_expect_success 'fetch --set-upstream upstream master sets branch ma=
ster but not other' '
+	clear_config master other &&
+	git fetch --set-upstream upstream master &&
+	check_config master upstream refs/heads/master &&
+	check_config_missing other
+'
+
+test_expect_success 'fetch --set-upstream upstream other sets branch oth=
er' '
+	clear_config master other &&
+	git fetch --set-upstream upstream other &&
+	check_config master upstream refs/heads/other &&
+	check_config_missing other
+'
+
+test_expect_success 'fetch --set-upstream master:other does not set the =
branch other2' '
+	clear_config other2 &&
+	git fetch --set-upstream upstream master:other2 &&
+	check_config_missing other2
+'
+
+test_expect_success 'fetch --set-upstream http://nosuchdomain.example.co=
m fails with invalid url' '
+	# master explicitly not cleared, we check that it is not touched from p=
revious value
+	clear_config other other2 &&
+	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com=
 &&
+	check_config master upstream refs/heads/other &&
+	check_config_missing other &&
+	check_config_missing other2
+'
+
+test_expect_success 'fetch --set-upstream with valid URL sets upstream t=
o URL' '
+	clear_config other other2 &&
+	url=3D"file://'"$PWD"'" &&
+	git fetch --set-upstream "$url" &&
+	check_config master "$url" HEAD &&
+	check_config_missing other &&
+	check_config_missing other2
+'
+
+# tests for pull --set-upstream
+
+test_expect_success 'setup bare parent pull' '
+	git remote rm upstream &&
+	ensure_fresh_upstream &&
+	git remote add upstream parent
+'
+
+test_expect_success 'setup commit on master and other pull' '
+	test_commit three &&
+	git push --tags upstream master &&
+	test_commit four &&
+	git push upstream other
+'
+
+test_expect_success 'pull --set-upstream upstream master sets branch mas=
ter but not other' '
+	clear_config master other &&
+	git pull --set-upstream upstream master &&
+	check_config master upstream refs/heads/master &&
+	check_config_missing other
+'
+
+test_expect_success 'pull --set-upstream master:other2 does not set the =
branch other2' '
+	clear_config other2 &&
+	git pull --set-upstream upstream master:other2 &&
+	check_config_missing other2
+'
+
+test_expect_success 'pull --set-upstream upstream other sets branch mast=
er' '
+	clear_config master other &&
+	git pull --set-upstream upstream other &&
+	check_config master upstream refs/heads/other &&
+	check_config_missing other
+'
+
+test_expect_success 'pull --set-upstream upstream tag does not set the t=
ag' '
+	clear_config three &&
+	git pull --tags --set-upstream upstream three &&
+	check_config_missing three
+'
+
+test_expect_success 'pull --set-upstream http://nosuchdomain.example.com=
 fails with invalid url' '
+	# master explicitly not cleared, we check that it is not touched from p=
revious value
+	clear_config other other2 three &&
+	test_must_fail git pull --set-upstream http://nosuchdomain.example.com =
&&
+	check_config master upstream refs/heads/other &&
+	check_config_missing other &&
+	check_config_missing other2 &&
+	check_config_missing three
+'
+
+test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD'=
 '
+	clear_config master other &&
+	git pull --set-upstream upstream HEAD &&
+	check_config master upstream HEAD &&
+	git checkout other &&
+	git pull --set-upstream upstream HEAD &&
+	check_config other upstream HEAD
+'
+
+test_expect_success 'pull --set-upstream upstream with more than one bra=
nch does nothing' '
+	clear_config master three &&
+	git pull --set-upstream upstream master three &&
+	check_config_missing master &&
+	check_config_missing three
+'
+
+test_expect_success 'pull --set-upstream with valid URL sets upstream to=
 URL' '
+	clear_config master other other2 &&
+	git checkout master &&
+	url=3D"file://'"$PWD"'" &&
+	git pull --set-upstream "$url" &&
+	check_config master "$url" HEAD &&
+	check_config_missing other &&
+	check_config_missing other2
+'
+
+test_expect_success 'pull --set-upstream with valid URL and branch sets =
branch' '
+	clear_config master other other2 &&
+	git checkout master &&
+	url=3D"file://'"$PWD"'" &&
+	git pull --set-upstream "$url" master &&
+	check_config master "$url" refs/heads/master &&
+	check_config_missing other &&
+	check_config_missing other2
+'
+
+test_done
--=20
2.20.1.98.gecbdaf0

