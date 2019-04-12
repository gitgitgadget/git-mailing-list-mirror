Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD01D20248
	for <e@80x24.org>; Fri, 12 Apr 2019 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfDLKIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 06:08:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40799 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLKIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 06:08:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so4970946pgl.7
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lExEc/IfXdMoFfWYKHF5YsiVbWs1A5Rq6r+0FpMZBV8=;
        b=kr79xNVHg3+tFU/lFWbS8vhYNrPi53rn08uiQqGx73g8HlpTgcOFVmS6O23zgglmI2
         nORstC4MbUcmok71BRmR1nB8YN7JfPPGqTzAjBL8nk8yt/gLYfV83wt7wl7S/zXK7M8T
         zgZjTSoMQK4WKc8QXJ5I9QhUhyiNDhw5fF3arpc46JMc4zZSA9kelvewIojr1xVnussF
         3WZnpwDqn1miYNuQVA0DvW7h0j93xuUd2azmehnLuKXAfUWWQAWVFG10UZs5UYsU56TB
         zbCcYPwE1StsJSFefEVAUqmjFKbcHUL0OvC9QdBsPxU4yYl0mg8UI4FBdA+7cLtreeXB
         YHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lExEc/IfXdMoFfWYKHF5YsiVbWs1A5Rq6r+0FpMZBV8=;
        b=Ww4ndGXahN5QQa1iJeh2k8iMXZdzIESbRWzFOxAcrx8FgRY0DYiiUMIFn9Vn7I78Ok
         fWBnoKCFdNYZx0wDySHNtrF1aSTSeJ99/jpHGCt/2X81TV9Vuxc9ywxBmAQPL0xos7Wq
         ZQzGkjV0MfAzErCbkyR9WgvvaUUiIa/Vg96Iz78cFs8HSAwa9R4MqBqHOww2X9WFK0m2
         FJDVg4qDnCsAZkShQjN8VFZjqTpFzG+QA1tNZGBgIcFSJkF4gujcWR1DZ/FSU+Zf1OMz
         UFBG8O+3WBDPa2U/e2x7XwxFigsoe82raAPohFB7MtnLMUCzndXDtDi4kvNEXKEdzH94
         n7qQ==
X-Gm-Message-State: APjAAAUoPJyMxvxcI9+lPzwGA4VzekXM5LBlK62U9w9oJmAFTftQKU01
        fJfcA+ysIc5xqm8d7X2D9oJcH5s1
X-Google-Smtp-Source: APXvYqywADxSE2HYjhLRLq4kNnRhv1NbkE9iouC4bfhZpT7K++E/H4Q32JgA8Dnuvk61lW3chn9jlw==
X-Received: by 2002:a63:20f:: with SMTP id 15mr51826744pgc.90.1555063710417;
        Fri, 12 Apr 2019 03:08:30 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id k65sm90980427pfb.68.2019.04.12.03.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 03:08:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 12 Apr 2019 17:08:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     robbat2@gentoo.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] submodule foreach: fix "<command> --quiet" not being respected
Date:   Fri, 12 Apr 2019 17:08:19 +0700
Message-Id: <20190412100819.24863-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
References: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin reported that

    git submodule foreach --quiet git pull --quiet origin

is not really quiet anymore [1]. "git pull" behaves as if --quiet is not
given.

This happens because parseopt in submodule--helper will try to parse
both --quiet options as if they are foreach's options, not git-pull's.
The parsed options are removed from the command line. So when we do
pull later, we execute just this

    git pull origin

When calling submodule helper, adding "--" in front of "git pull" will
stop parseopt for parsing options that do not really belong to
submodule--helper foreach.

PARSE_OPT_KEEP_UNKNOWN is removed as a safety measure. parseopt should
never see unknown options or something has gone wrong. There are also
a couple usage string update while I'm looking at them.

While at it, I also add "--" to other subcommands that pass "$@" to
submodule--helper. "$@" in these cases are paths and less likely to be
--something-like-this. But the point still stands, git-submodule has
parsed and classified what are options, what are paths. submodule--helper
should never consider paths passed by git-submodule to be options even
if they look like one.

The test case is also contributed by Robin.

[1] it should be quiet before fc1b9243cd (submodule: port submodule
    subcommand 'foreach' from shell to C, 2018-05-10) because parseopt
    can't accidentally eat options then.

Reported-by: Robin H. Johnson <robbat2@gentoo.org>
Tested-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 I'm not trying to fix "git pull --rebase --quiet" (or "git rebase
 --quiet" in general) in the end, since that looks like a whole other
 can of worms.
 
 Not only git-rebase--preserve-merges.sh needs to respect --quiet (but
 which case? I don't have enough experience to say) but sequencer.c
 may need to be scanned too.

 builtin/submodule--helper.c  |  8 ++++----
 git-submodule.sh             | 11 ++++++-----
 t/t7407-submodule-foreach.sh | 10 ++++++++++
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bcc4f1bd7..59570b5e87 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -566,12 +566,12 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] <command>"),
+		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
-			     git_submodule_helper_usage, PARSE_OPT_KEEP_UNKNOWN);
+			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
 		return 1;
@@ -709,7 +709,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<path>]"),
+		N_("git submodule--helper init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -2096,7 +2096,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper embed-git-dir [<path>...]"),
+		N_("git submodule--helper asorb-git-dirs [<options>] [<path>...]"),
 		NULL
 	};
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 2c0fb6d723..d33f5d8bb4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -346,7 +346,7 @@ cmd_foreach()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 #
@@ -377,7 +377,7 @@ cmd_init()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet}  "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet} -- "$@"
 }
 
 #
@@ -413,7 +413,7 @@ cmd_deinit()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
 is_tip_reachable () (
@@ -542,6 +542,7 @@ cmd_update()
 		${depth:+--depth "$depth"} \
 		$recommend_shallow \
 		$jobs \
+		-- \
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
@@ -934,7 +935,7 @@ cmd_status()
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} -- "$@"
 }
 #
 # Sync remote urls for submodules
@@ -967,7 +968,7 @@ cmd_sync()
 		esac
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper sync ${GIT_QUIET:+--quiet} ${recursive:+--recursive} -- "$@"
 }
 
 cmd_absorbgitdirs()
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 77729ac4aa..706ae762e0 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -411,4 +411,14 @@ test_expect_success 'multi-argument command passed to foreach is not shell-evalu
 	test_cmp expected actual
 '
 
+test_expect_success 'option-like arguments passed to foreach commands are not lost' '
+	(
+		cd super &&
+		git submodule foreach "echo be --quiet" > ../expected &&
+		git submodule foreach echo be --quiet > ../actual
+	) &&
+	grep -sq -e "--quiet" expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.21.0.682.g30d2204636

