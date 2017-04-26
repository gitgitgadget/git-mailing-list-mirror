Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB47207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032542AbdDZXNP (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:13:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32960 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032526AbdDZXNK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:13:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so847940wmh.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzqxJGkJcq8KxZeYylA0M+CycgJbZUSyZKY8sgKge8k=;
        b=SAG+gMrO0fZ6AiHuJrYHUNpxMmhI9BWIxmX5ulcOZBliNF0t9W0YkAV0sXJ0qslr/s
         ZASRoM1M6wCM8RAgWm0lBA4+G8GqFrB6vtKxylu7I4PiIvPIpbSaxHG2A5jU0MRD8kK0
         5N2S//b7XUsDjn4UmxoqAxOnqcClhV2MaeR96VJZB8r7prk2V//IdpIRke2vLcr7GWm0
         pBjBiSESGwmxI+0UzWX6T2yd1FH1/IVgIBZ4tskCwy4uC9APYFiww/T17BldK4mhQf6h
         g4IEQc+FTbSA4PW2DJbCQ0gnlt0vMfcU5ShJQPhNdqu9pz7Z0f1VWykBNfLadzi41Qep
         7vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzqxJGkJcq8KxZeYylA0M+CycgJbZUSyZKY8sgKge8k=;
        b=HCVtzfqnmT7o79coukKIRTZsj3hjiiV2cjo279AMs2sCmF7floLUqEWr41x6n58RBR
         oPfUj4CtcaTSk2jxqy1H1Ci1NYCqB+hxGr56cMqjv+W0ALxOzHPrFGTCEzK2M4P7iAHh
         OSvL15ZV0Y/1unyo4drxuDHpYNKgR88W2IFuR1lcuEwMJRWBfHmAS7Z+wZFNtYhcRQtb
         m5ftsS7VlP68G5sj5qNdJZ/U3AiyooEGVOVkqcD1hYmy6hIZTzTnwUS91hCE84UocYoE
         hjoaOPuQPhPrnjVfwe5cSj85PBR/DFqeZbfoYQA4/PSZ2gu8/pf+daHpde/BGz8a/6DH
         vc+w==
X-Gm-Message-State: AN3rC/6Zw8NBpHjgvJiV1MNDTCFrS/eLENdbFCrX9PseMi02GM+Urbw2
        +brhMBadB3uIjpy80G4=
X-Received: by 10.28.7.137 with SMTP id 131mr153378wmh.49.1493248387918;
        Wed, 26 Apr 2017 16:13:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:13:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH v3 5/5] WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config
Date:   Wed, 26 Apr 2017 23:12:36 +0000
Message-Id: <20170426231236.27219-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --no-recommend-tags option & support for
submodule.NAME.tags=[true|false] config facility. This does for
--no-tags what --no-recommend-shallow & submodule.NAME.shallow does
for --shallow-submodules.

This is almost exactly the same code change as in Stefan Beller's
commit abed000aca ("submodule update: learn `--[no-]recommend-shallow`
option", 2016-05-26) & 37f52e9344 ("submodule-config: keep shallow
recommendation around", 2016-05-26).

The difference in the configuration facility is that setting
submodule.NAME.tags=false will turn on --no-tags, i.e. "false" means
"don't give me tags", with "true" being the default.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-submodule.txt        |  8 +++++++-
 builtin/submodule--helper.c            |  7 +++++--
 contrib/completion/git-completion.bash |  1 +
 git-submodule.sh                       |  9 ++++++++-
 submodule-config.c                     |  8 ++++++++
 submodule-config.h                     |  1 +
 t/t5616-clone-submodules-tags.sh       | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 74bc6200d5..9a431a833d 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -159,7 +159,7 @@ instead of deinit-ing everything, to prevent mistakes.
 If `--force` is specified, the submodule's working tree will
 be removed even if it contains local modifications.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [--[no-]recommend-tags] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -416,6 +416,12 @@ for linkgit:git-clone[1]'s `--reference` and `--shared` options carefully.
 	`submodule.<name>.shallow` as provided by the .gitmodules file
 	by default. To ignore the suggestions use `--no-recommend-shallow`.
 
+--[no-]recommend-tags::
+	This option is only valid for the update command.
+	The initial clone of a submodule will use the recommended
+	`submodule.<name>.tags` as provided by the .gitmodules file
+	by default. To ignore the suggestions use `--no-recommend-tags`.
+
 -j <n>::
 --jobs <n>::
 	This option is only valid for the update command.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index caa4d252ee..424ea7a680 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -736,6 +736,7 @@ struct submodule_update_clone {
 	int progress;
 	int quiet;
 	int recommend_shallow;
+	int recommend_tags;
 	struct string_list references;
 	const char *depth;
 	const char *recursive_prefix;
@@ -753,7 +754,7 @@ struct submodule_update_clone {
 	int no_tags;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
-	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, -1, STRING_LIST_INIT_DUP, \
 	NULL, NULL, NULL, \
 	STRING_LIST_INIT_DUP, 0, NULL, 0, 0, 0}
 
@@ -855,7 +856,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow == 1)
 		argv_array_push(&child->args, "--depth=1");
-	if (suc->no_tags)
+	if (suc->no_tags || suc->recommend_tags == 0)
 		argv_array_push(&child->args, "--no-tags");
 	argv_array_pushl(&child->args, "--path", sub->path, NULL);
 	argv_array_pushl(&child->args, "--name", sub->name, NULL);
@@ -996,6 +997,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
 			    N_("whether the initial clone should follow the shallow recommendation")),
+		OPT_BOOL(0, "recommend-tags", &suc.recommend_tags,
+			    N_("whether the initial clone should follow the tags recommendation")),
 		OPT_BOOL(0, "no-tags", &suc.no_tags,
 			 N_("don't clone any tags, and make later fetches not to follow them")),
 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 08fb1319c3..8eb32032a8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2878,6 +2878,7 @@ _git_submodule ()
 		__gitcomp "
 			--init --remote --no-fetch
 			--recommend-shallow --no-recommend-shallow
+			--recommend-tags --no-recommend-tags
 			--force --rebase --merge --reference --depth --recursive --jobs
 		"
 		;;
diff --git a/git-submodule.sh b/git-submodule.sh
index 3371775b0b..5b204a9679 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -9,7 +9,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--[no-]recommend-tags] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -557,6 +557,12 @@ cmd_update()
 		--no-recommend-shallow)
 			recommend_shallow="--no-recommend-shallow"
 			;;
+		--recommend-tags)
+			recommend_tags="--recommend-tags"
+			;;
+		--no-recommend-tags)
+			recommend_tags="--no-recommend-tags"
+			;;
 		--depth)
 			case "$2" in '') usage ;; esac
 			depth="--depth=$2"
@@ -604,6 +610,7 @@ cmd_update()
 		${reference:+"$reference"} \
 		${depth:+--depth "$depth"} \
 		${recommend_shallow:+"$recommend_shallow"} \
+		${recommend_tags:+"$recommend_tags"} \
 		${no_tags:+--no-tags} \
 		${jobs:+$jobs} \
 		"$@" || echo "#unmatched" $?
diff --git a/submodule-config.c b/submodule-config.c
index 4f58491ddb..68fbd9d1f0 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -202,6 +202,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	submodule->ignore = NULL;
 	submodule->branch = NULL;
 	submodule->recommend_shallow = -1;
+	submodule->recommend_tags = -1;
 
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
@@ -385,6 +386,13 @@ static int parse_config(const char *var, const char *value, void *data)
 		else
 			submodule->recommend_shallow =
 				git_config_bool(var, value);
+	} else if (!strcmp(item.buf, "tags")) {
+		if (!me->overwrite && submodule->recommend_tags != -1)
+			warn_multiple_config(me->treeish_name, submodule->name,
+					     "tags");
+		else
+			submodule->recommend_tags =
+				git_config_bool(var, value);
 	} else if (!strcmp(item.buf, "branch")) {
 		if (!me->overwrite && submodule->branch)
 			warn_multiple_config(me->treeish_name, submodule->name,
diff --git a/submodule-config.h b/submodule-config.h
index d434ecdb45..be3c567803 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -20,6 +20,7 @@ struct submodule {
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 	int recommend_shallow;
+	int recommend_tags;
 };
 
 extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
diff --git a/t/t5616-clone-submodules-tags.sh b/t/t5616-clone-submodules-tags.sh
index 3c88265352..caded2fb24 100755
--- a/t/t5616-clone-submodules-tags.sh
+++ b/t/t5616-clone-submodules-tags.sh
@@ -69,4 +69,38 @@ test_expect_success 'tags clone with no-tags submodule' '
 	test_line_count = 0 tags
 '
 
+test_expect_success 'clone follows tags=false recommendation' '
+	test_when_finished "rm -rf super_clone" &&
+	git config -f .gitmodules submodule.sub.tags false &&
+	git add .gitmodules &&
+	git commit -m "recommed no-tags for sub" &&
+	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 0 tags
+'
+
+test_expect_success 'get tags recommended no-tags submodule' '
+	test_when_finished "rm -rf super_clone" &&
+	git clone --no-local "file://$pwd/." super_clone &&
+	git -C super_clone submodule update --init --no-recommend-tags &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags
+'
+
+test_expect_success 'clone follows tags=true recommendation' '
+	test_when_finished "rm -rf super_clone" &&
+	git config -f .gitmodules submodule.sub.tags true &&
+	git add .gitmodules &&
+	git commit -m "recommed tags for sub" &&
+	git clone --recurse-submodules --no-local "file://$pwd/." super_clone &&
+	git -C super_clone for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags &&
+	git -C super_clone/sub for-each-ref --format="%(refname:strip=2)" refs/tags/ >tags &&
+	test_line_count = 3 tags
+'
+
 test_done
-- 
2.11.0

