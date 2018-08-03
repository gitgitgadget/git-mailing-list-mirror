Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D521F597
	for <e@80x24.org>; Fri,  3 Aug 2018 22:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeHDAWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 20:22:32 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:49785 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbeHDAWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 20:22:32 -0400
Received: by mail-qk0-f202.google.com with SMTP id a70-v6so6613582qkb.16
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 15:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=BjzIzH1XLKXYzzaRR3YQWMkcioJUB+UC92Q3zQftqFs=;
        b=KUINFizZDzaCKrAN3qydMBE3jn0d5XhqIOZQjzK2cDS4ORrGQWvrcLQuBGC3kwRrze
         vMsOWbb1XIuPnimfzND2TjttB4v2FcvcewbLecxX+ey+Cfl8s2sSKuB/eyhfGN9w9krJ
         QdEL2XN1G4FH7OIG4HpSeNhmsFFBMlpv/5qQK/3DYSUnwReAZUfv2Qr5nbU2rt07qVQL
         h9WzhY6P1aydCvxsnj738ZXFR9rGeTWhI0FiB5Hr3lVjJutk0lJQMdo3eGUbqKwMkIGM
         JbGX8SpJB/N2slGYyHOsj/6ojXJYiMzY8YuKWEs1+7jQ71cE34Rg056WW8fQ5nMN2yQg
         X5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=BjzIzH1XLKXYzzaRR3YQWMkcioJUB+UC92Q3zQftqFs=;
        b=qu4Rl8Ev5xa1g+ITU1YwSdt/IWVED84MMnHIQ9j8yShSuT+oO4ElFpnudhDPW5v1bx
         gjwVyDy9BqI2Px3XBKg++zxHKMJXl29fzMdwp/JndhWb10vTbjly3JMTspVraEuomMcp
         A+x4aEg2wruLhuz5SYxOKodBgsAx6dIVlaY1dSznwfp9Fvz/u9C6FyP1PPMoVao6FUSU
         c5c4P6rHWZ95H7Vd1UiV3kIJOYXAzHWhBG0pgY8E0We5cY3/hvYrd/tsd+sVJYGI3Xpk
         nxtsZ5Z7kwPTIexdwt/VJS+qgH4cqxq01lXYzxDzTn+FsmoslqDC4B9OtWWBW9J2RsxU
         7PgQ==
X-Gm-Message-State: AOUpUlEiCl0Mb5NTfIcxNXtUYi/56MdTVu0siYyk6j+kZ8kzU3Rvm60W
        Jfu+EDHLKaDcrpmilmZS2yyddnY4+QUn+8hpm5mCqkYtz17AjoSuDKDtmp5KaBLp0HL5e6gXtDu
        oouKBCAz1F1oefJeQ1onq2RpnouHDVhjt7iqx7a3L03160Mkitt63HWkI3wvZ
X-Google-Smtp-Source: AAOMgpdIx5lj5BSRLRiC8gN4wOAlBIyFpqulETXfEHNY3Xs06vowA9kO9diM7oRw7G7+VTkS/xruqyQ9WtMY
MIME-Version: 1.0
X-Received: by 2002:ae9:e116:: with SMTP id g22-v6mr5367022qkm.31.1533335058894;
 Fri, 03 Aug 2018 15:24:18 -0700 (PDT)
Date:   Fri,  3 Aug 2018 15:23:22 -0700
In-Reply-To: <20180803222322.261813-1-sbeller@google.com>
Message-Id: <20180803222322.261813-8-sbeller@google.com>
References: <20180803222322.261813-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCH 7/7] submodule--helper: introduce new update-module-mode helper
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This chews off a bit of the shell part of the update command in
git-submodule.sh. When writing the C code, keep in mind that the
submodule--helper part will go away eventually and we want to have
a C function that is able to determine the submodule update strategy,
it as a nicety, make determine_submodule_update_strategy accessible
for arbitrary repositories.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 61 +++++++++++++++++++++++++++++++++++++
 git-submodule.sh            | 16 +---------
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e7635d5d9ab..e72157664f5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1446,6 +1446,66 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void determine_submodule_update_strategy(struct repository *r,
+						int just_cloned,
+						const char *path,
+						const char *update,
+						struct submodule_update_strategy *out)
+{
+	const struct submodule *sub = submodule_from_path(r, &null_oid, path);
+	char *key;
+	const char *val;
+
+	key = xstrfmt("submodule.%s.update", sub->name);
+
+	if (update) {
+		trace_printf("parsing update");
+		if (parse_submodule_update_strategy(update, out) < 0)
+			die(_("Invalid update mode '%s' for submodule path '%s'"),
+				update, path);
+	} else if (!repo_config_get_string_const(r, key, &val)) {
+		if (parse_submodule_update_strategy(val, out) < 0)
+			die(_("Invalid update mode '%s' configured for submodule path '%s'"),
+				val, path);
+	} else if (sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+		trace_printf("loaded thing");
+		out->type = sub->update_strategy.type;
+		out->command = sub->update_strategy.command;
+	} else
+		out->type = SM_UPDATE_CHECKOUT;
+
+	if (just_cloned &&
+	    (out->type == SM_UPDATE_MERGE ||
+	     out->type == SM_UPDATE_REBASE ||
+	     out->type == SM_UPDATE_NONE))
+		out->type = SM_UPDATE_CHECKOUT;
+
+	free(key);
+}
+
+static int module_update_module_mode(int argc, const char **argv, const char *prefix)
+{
+	const char *path, *update = NULL;
+	int just_cloned;
+	struct submodule_update_strategy update_strategy = { .type = SM_UPDATE_CHECKOUT };
+
+	if (argc < 3 || argc > 4)
+		die("submodule--helper update-module-clone expects <just-cloned> <path> [<update>]");
+
+	just_cloned = git_config_int("just_cloned", argv[1]);
+	path = argv[2];
+
+	if (argc == 4)
+		update = argv[3];
+
+	determine_submodule_update_strategy(the_repository,
+					    just_cloned, path, update,
+					    &update_strategy);
+	fputs(submodule_strategy_to_string(&update_strategy), stdout);
+
+	return 0;
+}
+
 struct update_clone_data {
 	const struct submodule *sub;
 	struct object_id oid;
@@ -2080,6 +2140,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
+	{"update-module-mode", module_update_module_mode, 0},
 	{"update-clone", update_clone, 0},
 	{"ensure-core-worktree", ensure_core_worktree, 0},
 	{"relative-path", resolve_relative_path, 0},
diff --git a/git-submodule.sh b/git-submodule.sh
index 19d010eac06..19c9f1215e1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -537,27 +537,13 @@ cmd_update()
 
 		git submodule--helper ensure-core-worktree "$sm_path"
 
-		name=$(git submodule--helper name "$sm_path") || exit
-		if ! test -z "$update"
-		then
-			update_module=$update
-		else
-			update_module=$(git config submodule."$name".update)
-			if test -z "$update_module"
-			then
-				update_module="checkout"
-			fi
-		fi
+		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
 
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
 		if test $just_cloned -eq 1
 		then
 			subsha1=
-			case "$update_module" in
-			merge | rebase | none)
-				update_module=checkout ;;
-			esac
 		else
 			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
-- 
2.18.0.132.g195c49a2227

