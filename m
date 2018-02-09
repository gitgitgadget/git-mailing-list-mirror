Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A43531F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeBILCi (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:02:38 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36333 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeBILCh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:02:37 -0500
Received: by mail-pg0-f65.google.com with SMTP id j9so2321304pgv.3
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHAcslOE2MsjZsUCOwhalVEC4N9yPAsB0t05QtHVHJo=;
        b=GrJ3MZta0ZIVOi+A761KF80wsk7SyPG2emeduWfC8bbkINjseHQ2dd7wt0elzvhifr
         FzZcFfGKcGHodjVZHhcVHk0AzerBqjuJDl8f76QRn3VWarHzhlc5HK2+M61wNUfADrcD
         dBaF1HkI0yXlC7cEyj7dCK/YmMFcSxGhsXt4+89pcaebBdfwWuMkW2vFhNnlsvCoiqtp
         BjS+rPK4cMp9YXpqv1UTZyuZ6ghjo0dMUXJtzUvw7IsqBserEZPoHhzDTOfbcVJ3FphQ
         4VtzxZB/F5VkP08toqD8l9+lOvwpTlufCOgKy2GRI50U//9GU6fHfnUcnAGxzxxGJWVf
         +diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHAcslOE2MsjZsUCOwhalVEC4N9yPAsB0t05QtHVHJo=;
        b=rDbHas6pK4kTO0B6r2Tqg6BoSVrezBtDYfKIXe37g0NioS6g7zloBkjXCU1+fKpbwK
         Tr+Lrla1n/i7OYuGtF9xmrNqcVLLfNDJmYVt3s6HdIv7opKkNvXfI44jdEltr1Oej7e2
         R5K9bmp04DAyt1LsO2i+NbOSvPvmeS6aNF5n7ltDo49YHvWKmb7fUp8kMGisHD3HowdM
         NpKLa041NIMfy15G/XHbAcfAKFKZKS5FtKycPI7c+t7oyf+XRHltP/BwfP8JgUN06dwn
         LIOl8zpYCUBG1ZGG5eqg/plwXM40PMMWWzrgIPG/UhXP8GJRvNvgyRtZ8/3Mtne0eSej
         IYdw==
X-Gm-Message-State: APf1xPC1xcT0SgcI7iaU2pJBzu3mMu+rzPqH0DkZfqi68S8CkyhWzQrw
        +aeGin6bga7kFnhkB/DlUn30mg==
X-Google-Smtp-Source: AH8x225bnplX3Y7+zSOUbSEoggrRB0yqHUrcmWqtk5vby6kdzr+KdgBLqxpj7Mk10NjG3+JyFJgvWg==
X-Received: by 10.99.161.26 with SMTP id b26mr2142210pgf.130.1518174156532;
        Fri, 09 Feb 2018 03:02:36 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id k7sm4300593pgt.20.2018.02.09.03.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:02:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:02:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 00/42] Automate updating git-completion.bash a bit
Date:   Fri,  9 Feb 2018 18:01:39 +0700
Message-Id: <20180209110221.27224-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 improves __gitcomp_builtin() function a bit to allows both adding
extra options (to complement --git-completion-helper limitations) and
removing options.

v3 should also fix Mac OS breakage.

The last change in 42/42 is a new configurable variable in
git-completion.bash that allows you to complete _all_ options,
including ones that are filtered out by default. For the record there
are 22 of them with the following counts:

     10 --force
      4 --rerere-autoupdate
      1 --unsafe-paths
      1 --thin
      1 --overwrite-ignore
      1 --open-files-in-pager
      1 --null
      1 --ext-grep
      1 --exit-code
      1 --auto

The first 41 patches should be ok to enter 'next' unless people find
something else. 42/42 may be a bit more questionable (e.g.
configuration variable name, or how we pass options to
--git-completion-helper...) and might have to stay on 'pu' longer.

Interdiff with v2 below. I remove changes that are reverts back to
'master' to reduce the noise a bit.

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index cfd24c5764..0cfa489a8e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -36,6 +36,10 @@
 #
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     completion (e.g., completing "foo" when "origin/foo" exists).
+#
+#   GIT_COMPLETION_OPTIONS
+#
+#     When set to "all", complete all possible options
 
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -284,24 +288,33 @@ __gitcomp ()
 #
 #    __gitcomp "$(git xxx --git-completion-helper) ..."
 #
-# except that the value from $(git) is cached
+# except that the output is cached. Accept 1-3 arguments:
+# 1: the git command to execute, this is also the cache key
+# 2: extra options to be added on top (e.g. negative forms)
+# 3: options to be excluded
 __gitcomp_builtin ()
 {
 	# spaces must be replaced with underscore for multi-word
 	# commands, e.g. "git remote add" becomes remote_add.
 	local cmd="$1"
-	shift
+	local incl="$2"
+	local excl="$3"
 
 	local var=__gitcomp_builtin_"${cmd/-/_}"
 	local options
 	eval "options=\$$var"
 
 	if [ -z "$options" ]; then
-		declare -g "$var=$(__git ${cmd/_/ } --git-completion-helper)"
-		eval "options=\$$var"
+		# leading and trailing spaces are significant to make
+		# option removal work correctly.
+		options=" $(__git ${cmd/_/ } --git-completion-helper=$GIT_COMPLETION_OPTIONS) $incl "
+		for i in $excl; do
+			options="${options/ $i / }"
+		done
+		eval "$var=\"$options\""
 	fi
 
-	__gitcomp "$options $*"
+	__gitcomp "$options"
 }
 
 # Variation of __gitcomp_nl () that appends to the existing list of
@@ -1096,12 +1109,13 @@ __git_count_arguments ()
 }
 
 __git_whitespacelist="nowarn warn error error-all fix"
+__git_am_inprogress_options="--skip --continue --resolved --abort"
 
 _git_am ()
 {
 	__git_find_repo_path
 	if [ -d "$__git_repo_path"/rebase-apply ]; then
-		__gitcomp "--skip --continue --resolved --abort"
+		__gitcomp "$__git_am_inprogress_options"
 		return
 	fi
 	case "$cur" in
@@ -1110,7 +1124,8 @@ _git_am ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin am "--no-utf8"
+		__gitcomp_builtin am "--no-utf8" \
+			"$__git_am_inprogress_options"
 		return
 	esac
 }
@@ -1272,16 +1287,19 @@ _git_cherry ()
 	__git_complete_refs
 }
 
+__git_cherry_pick_inprogress_options="--continue --quit --abort"
+
 _git_cherry_pick ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/CHERRY_PICK_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "$__git_cherry_pick_inprogress_options"
 		return
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp_builtin cherry-pick
+		__gitcomp_builtin cherry-pick "" \
+			"$__git_cherry_pick_inprogress_options"
 		;;
 	*)
 		__git_complete_refs
@@ -2674,16 +2692,19 @@ _git_reset ()
 	__git_complete_refs
 }
 
+__git_revert_inprogress_options="--continue --quit --abort"
+
 _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp_builtin revert "--no-edit"
+		__gitcomp_builtin revert "--no-edit" \
+			"$__git_revert_inprogress_options"
 		return
 		;;
 	esac
diff --git a/parse-options.c b/parse-options.c
index 979577ba2c..5b8b2b376e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -430,14 +430,17 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
  * many options that do not suppress it properly.
  */
 static int show_gitcomp(struct parse_opt_ctx_t *ctx,
-			const struct option *opts)
+			const struct option *opts,
+			const char *arg)
 {
 	for (; opts->type != OPTION_END; opts++) {
 		const char *suffix = "";
 
 		if (!opts->long_name)
 			continue;
-		if (opts->flags & (PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE))
+		if (opts->flags & PARSE_OPT_HIDDEN)
+			continue;
+		if ((opts->flags & PARSE_OPT_NOCOMPLETE) && strcmp(arg, "all"))
 			continue;
 
 		switch (opts->type) {
@@ -498,8 +501,8 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			goto show_usage;
 
 		/* lone --git-completion-helper is asked by git-completion.bash */
-		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
-			return show_gitcomp(ctx, options);
+		if (ctx->total == 1 && skip_prefix(arg + 1, "-git-completion-helper=", &arg))
+			return show_gitcomp(ctx, options, arg);
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
diff --git a/parse-options.h b/parse-options.h
index f63151fbda..0ba08691e6 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -92,7 +92,7 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
- *			   git-completion.bash. This option suppresses that.
+ *			   by git-completion.bash. This option suppresses that.
  *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
  *			 complete an option as --name= not --name even if
  *			 the option takes optional argument.
-- 
2.16.1.207.gedba492059

