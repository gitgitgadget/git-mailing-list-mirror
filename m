Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD9DC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357835AbiDBQNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357807AbiDBQMz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FFF60AA5
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:11:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso5204962wma.1
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7It6bH5SbEm2fNaRJODy5NYnivF4JboZW01xvzCjn4E=;
        b=WKZj2tkviIKF8B0c1PDU6tLy+yyqV6v1hNQ4peVUuOVBQI3xHqzTTCB5RDGk1XFiqE
         UBqi8E5+GDsUQRHWmw4ucsq3Mw8gvbtnQzIoDq3URDOiSr6F+KFsBJAohUYNKVmblaQa
         vVoEcu9dz2X0yGmLJiMIwCWRpROzhd3ltShsHOIz7ZcRjgpIP976Vjf0pwwodeLJM1Lf
         uIyaKuZVptEdxoWTY8/xhUTUJcmwGhz7Hx2hAJXTpgJSgH7xdtn8/PN+OYukFlNC7TKd
         aZqSsa5P6EWr9D1yyFeAf3V/jhG8KuHpdWhm+UdsxreRSrV9dZfBRWVPqsIrPT873pKG
         qBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7It6bH5SbEm2fNaRJODy5NYnivF4JboZW01xvzCjn4E=;
        b=T0sR/TwF+2z+VUcVNenUnEP1Ot9p31WQjsmDzeDKcFhv8RftZIfmEAgkqwpJA4qfAU
         MWIs9OpNIqvOvAJ4IUahs4DilRJ+eOKDItELWLS+Aih5Wdgv6tUE6zmMJ5a8TDzeAhfS
         9lUn1ah/LudGYEAmBn659HKBFJMimocfmnvixlp2FETsz9bkzf4cwBFSJiaEpQdlvhrE
         wqZIRfsEiAe7LFCqls9DM9SephZgUpiFpHCmpvam8MB6zxLrVCRNAb9/ioSGQjgyHifb
         nHyesfK1Sz5GpCjo01JULq9ELCfs+MbAMkWTtbpL4RG4wi+2gudhns2nkavhVhnpoXxr
         oxDA==
X-Gm-Message-State: AOAM53278ghHV63sJtX9GNep+SXkqVAbsqSDC6JoVkTk+OtFRWgAuQVr
        5W3DbkwqnzDZjfx3tYEPv9ZLq2gCGA8=
X-Google-Smtp-Source: ABdhPJzSrr3vVnwlh5TKSiGEHYPMN0oGHaRaNIQQColTbSdH57tt3MrE55R0xgRQE7k7hnjsG/8Fqg==
X-Received: by 2002:a05:600c:34c5:b0:38c:30e3:1e6c with SMTP id d5-20020a05600c34c500b0038c30e31e6cmr13206793wmq.144.1648915860876;
        Sat, 02 Apr 2022 09:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a7bcbce000000b0038c7776a300sm18149041wmi.0.2022.04.02.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:11:00 -0700 (PDT)
Message-Id: <febe64a8a069dd81523c33a93cfea9553e40c283.1648915853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:53 +0000
Subject: [PATCH v2 6/6] i18n: factorize "bad argument" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

We also quote the placeholders as they replace constant strings.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 builtin/bisect--helper.c | 2 +-
 builtin/commit-graph.c   | 2 +-
 builtin/config.c         | 2 +-
 builtin/env--helper.c    | 2 +-
 builtin/gc.c             | 4 ++--
 diff.c                   | 4 ++--
 grep.c                   | 2 +-
 send-pack.c              | 2 +-
 submodule-config.c       | 8 ++++----
 submodule.c              | 2 +-
 t/t1300-config.sh        | 2 +-
 t/t7900-maintenance.sh   | 4 ++--
 12 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8b2b259ff0d..3ed8a5f40b6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -268,7 +268,7 @@ static int bisect_write(const char *state, const char *rev,
 	} else if (one_of(state, terms->term_good, "skip", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
-		res = error(_("Bad bisect_write argument: %s"), state);
+		res = error(_("bad '%s' argument: '%s'"), "bisect_write", state);
 		goto finish;
 	}
 
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 51c4040ea6c..913478bb029 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -134,7 +134,7 @@ static int write_option_parse_split(const struct option *opt, const char *arg,
 	else if (!strcmp(arg, "replace"))
 		*flags = COMMIT_GRAPH_SPLIT_REPLACE;
 	else
-		die(_("unrecognized --split argument, %s"), arg);
+		die(_("bad '%s' argument: '%s'"), "--split", arg);
 
 	return 0;
 }
diff --git a/builtin/config.c b/builtin/config.c
index e7b88a9c08d..2ac36e4f641 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -106,7 +106,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		else if (!strcmp(arg, "color"))
 			new_type = TYPE_COLOR;
 		else
-			die(_("unrecognized --type argument, %s"), arg);
+			die(_("bad '%s' argument: '%s'"), "--type", arg);
 	}
 
 	to_type = opt->value;
diff --git a/builtin/env--helper.c b/builtin/env--helper.c
index 27349098b07..49790dfa2fb 100644
--- a/builtin/env--helper.c
+++ b/builtin/env--helper.c
@@ -24,7 +24,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 	else if (!strcmp(arg, "ulong"))
 		*cmdmode = ENV_HELPER_TYPE_ULONG;
 	else
-		die(_("unrecognized --type argument, %s"), arg);
+		die(_("bad '%s' argument: '%s'"), "--type", arg);
 
 	return 0;
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index c062d7bceeb..cca6987fcbd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -750,7 +750,7 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
 	*priority = parse_schedule(arg);
 
 	if (!*priority)
-		die(_("unrecognized --schedule argument '%s'"), arg);
+		die(_("bad '%s' argument: '%s'"), "--schedule", arg);
 
 	return 0;
 }
@@ -2393,7 +2393,7 @@ static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
 
 	*scheduler = parse_scheduler(arg);
 	if (*scheduler == SCHEDULER_INVALID)
-		return error(_("unrecognized --scheduler argument '%s'"), arg);
+		return error(_("bad '%s' argument: '%s'"), "--scheduler", arg);
 	return 0;
 }
 
diff --git a/diff.c b/diff.c
index 6b22946cd0e..c74f6e7b920 100644
--- a/diff.c
+++ b/diff.c
@@ -5010,7 +5010,7 @@ static int diff_opt_color_moved(const struct option *opt,
 	} else {
 		int cm = parse_color_moved(arg);
 		if (cm < 0)
-			return error(_("bad --color-moved argument: %s"), arg);
+			return error(_("bad '%s' argument: '%s'"), "--color-moved", arg);
 		options->color_moved = cm;
 	}
 	return 0;
@@ -5334,7 +5334,7 @@ static int diff_opt_word_diff(const struct option *opt,
 		else if (!strcmp(arg, "none"))
 			options->word_diff = DIFF_WORDS_NONE;
 		else
-			return error(_("bad --word-diff argument: %s"), arg);
+			return error(_("bad '%s' argument: '%s'"), "--word-diff", arg);
 	} else {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
diff --git a/grep.c b/grep.c
index 82eb7da1022..6aabfc58bb3 100644
--- a/grep.c
+++ b/grep.c
@@ -43,7 +43,7 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 		return GREP_PATTERN_TYPE_FIXED;
 	else if (!strcmp(arg, "perl"))
 		return GREP_PATTERN_TYPE_PCRE;
-	die("bad %s argument: %s", opt, arg);
+	die("bad '%s' argument: '%s'", opt, arg);
 }
 
 define_list_config_array_extra(color_grep_slots, {"match"});
diff --git a/send-pack.c b/send-pack.c
index bc0fcdbb000..68205e8a913 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -36,7 +36,7 @@ int option_parse_push_signed(const struct option *opt,
 		*(int *)(opt->value) = SEND_PACK_PUSH_CERT_IF_ASKED;
 		return 0;
 	}
-	die("bad %s argument: %s", opt->long_name, arg);
+	die("bad '%s' argument: '%s'", opt->long_name, arg);
 }
 
 static void feed_object(const struct object_id *oid, FILE *fh, int negative)
diff --git a/submodule-config.c b/submodule-config.c
index 29668b0620d..76264c6e6b6 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -292,7 +292,7 @@ static int parse_fetch_recurse(const char *opt, const char *arg,
 		 * git-completion.bash when you add new options.
 		 */
 		if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
+			die("bad '%s' argument: '%s'", opt, arg);
 		else
 			return RECURSE_SUBMODULES_ERROR;
 	}
@@ -342,7 +342,7 @@ static int parse_update_recurse(const char *opt, const char *arg,
 		return RECURSE_SUBMODULES_OFF;
 	default:
 		if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
+			die("bad '%s' argument: '%s'", opt, arg);
 		return RECURSE_SUBMODULES_ERROR;
 	}
 }
@@ -359,7 +359,7 @@ static int parse_push_recurse(const char *opt, const char *arg,
 	case 1:
 		/* There's no simple "on" value when pushing */
 		if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
+			die("bad '%s' argument: '%s'", opt, arg);
 		else
 			return RECURSE_SUBMODULES_ERROR;
 	case 0:
@@ -376,7 +376,7 @@ static int parse_push_recurse(const char *opt, const char *arg,
 		 * git-completion.bash when you add new modes.
 		 */
 		else if (die_on_error)
-			die("bad %s argument: %s", opt, arg);
+			die("bad '%s' argument: '%s'", opt, arg);
 		else
 			return RECURSE_SUBMODULES_ERROR;
 	}
diff --git a/submodule.c b/submodule.c
index 5ace18a7d94..c08477762d9 100644
--- a/submodule.c
+++ b/submodule.c
@@ -470,7 +470,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	else if (!strcmp(arg, "dirty"))
 		diffopt->flags.ignore_dirty_submodules = 1;
 	else if (strcmp(arg, "none"))
-		die(_("bad --ignore-submodules argument: %s"), arg);
+		die(_("bad '%s' argument: '%s'"), "--ignore-submodules", arg);
 	/*
 	 * Please update _git_status() in git-completion.bash when you
 	 * add new options
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 7dd9b325d90..69cb3af0885 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2215,7 +2215,7 @@ test_expect_success 'unset type specifiers may be reset to conflicting ones' '
 
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
-	test_i18ngrep "unrecognized --type argument" error
+	test_i18ngrep "bad '\''--type'\'' argument" error
 '
 
 test_expect_success '--replace-all does not invent newlines' '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 74aa6384755..c5e62e95533 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -401,7 +401,7 @@ test_expect_success '--auto and --schedule incompatible' '
 
 test_expect_success 'invalid --schedule value' '
 	test_must_fail git maintenance run --schedule=annually 2>err &&
-	test_i18ngrep "unrecognized --schedule" err
+	test_i18ngrep "bad '\''--schedule'\''" err
 '
 
 test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
@@ -529,7 +529,7 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 
 test_expect_success 'start --scheduler=<scheduler>' '
 	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
-	test_i18ngrep "unrecognized --scheduler argument" err &&
+	test_i18ngrep "bad '\''--scheduler'\'' argument" err &&
 
 	test_expect_code 129 git maintenance start --no-scheduler 2>err &&
 	test_i18ngrep "unknown option" err &&
-- 
gitgitgadget
