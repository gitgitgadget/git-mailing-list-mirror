Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15BBF1F404
	for <e@80x24.org>; Tue, 26 Dec 2017 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdLZV71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 16:59:27 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:46095 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdLZV7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 16:59:17 -0500
Received: by mail-wm0-f65.google.com with SMTP id r78so36945233wme.5
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQMzNmG0YBDNkB8u5ZwCM2QvbdJf0psCt6Igy2Xhvvk=;
        b=gsY5gswulJhctNAPYGf86mEbc4qvlHPYKLIJg77VbHqCQY3e5OViEbO+4o9bv1TQ40
         9MrGVwif2sbm54W6IdioJtMsKHKF9e9w4CNe+/kN5wLkXutLviHWYwS63Xy0DzkTtosJ
         wsMwk6k43+FRSFdcSNQ5gT7ztpailFmL0RuN/rJP93sVrXvy8PMI6FHwoGz+YGrsbF8n
         n0SZJ9K9pG2YdMJVJwfu2MZ4uD7fxKOiIKiECgEjPKDfp7nlgLsM1WE1fy7+susx9UU+
         qAqVr73OfKr/mhgsDrzMd6YwyDQ9f3TaXoCsHSCb6AhJIUbGGUSMpZK39MomglLFo4m6
         r8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KQMzNmG0YBDNkB8u5ZwCM2QvbdJf0psCt6Igy2Xhvvk=;
        b=T1pg2K2VZfAGTEt5mD2Fd9mUmaxGw8HQ3sn/Rpv1zo//ZC766AhZMoQSmy1mf//YoH
         fufUqj6Lq8YinpMtG6AhIP9ZH+pI8Eiy8gzp2/4z7rNus7Phm7a+1JHhnRwj9WLZIi/b
         +iqwtlHA6EgkFn7xG9zFl6xe0R/dSOG8PEDWagv9qoi4RZds49YU0r2yKU3/G3ZsmTgh
         IenfOmskhfwkBZ7z685zgplQJb0xhHQ9Bfhh/oJJO3Mr0O3CJsd0dJgjpJwnuLJ3YkU8
         mbfz90GUEiWLrZVwziNHzbUIqPgkABeqw7Mn00jVJ8yJLcMPeh2JbvRkJAH/x5/AQxE/
         cOVQ==
X-Gm-Message-State: AKGB3mKf/1x7QbNWMigDliv1Y8Ig7QiM2UHNVWchx+VSyZAGP/9SxffJ
        G6VfOHPgW+RXUSJojKL9UG1rb8sd
X-Google-Smtp-Source: ACJfBovGsAqVONpMOk9PbjGZWY5Np4r0Vd+5oa2T0bE4tL2tmVLrjQMjfjeW2IhMhODMqMORJ8gl6w==
X-Received: by 10.28.152.85 with SMTP id a82mr13069183wme.16.1514325555899;
        Tue, 26 Dec 2017 13:59:15 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id d71sm24516204wma.7.2017.12.26.13.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Dec 2017 13:59:15 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 4/7] perf/run: add conf_opts argument to get_var_from_env_or_config()
Date:   Tue, 26 Dec 2017 22:59:05 +0100
Message-Id: <20171226215908.425-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org>
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's make it possible to use `git config` type specifiers like
`--int` or `--bool`, so that config values are converted to the
canonical form and easier to use.

This additional argument is now the fourth argument of
get_var_from_env_or_config() instead of the fifth because we
want the default value argument to be unset if it is not
passed, and this is simpler if it is the last argument.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 43e4de49ef..214d658172 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -105,7 +105,8 @@ get_var_from_env_or_config () {
 	env_var="$1"
 	conf_sec="$2"
 	conf_var="$3"
-	# $4 can be set to a default value
+	conf_opts="$4" # optional
+	# $5 can be set to a default value
 
 	# Do nothing if the env variable is already set
 	eval "test -z \"\${$env_var+x}\"" || return
@@ -116,18 +117,18 @@ get_var_from_env_or_config () {
 	if test -n "$GIT_PERF_SUBSECTION"
 	then
 		var="$conf_sec.$GIT_PERF_SUBSECTION.$conf_var"
-		conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+		conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 		eval "$env_var=\"$conf_value\"" && return
 	fi
 	var="$conf_sec.$conf_var"
-	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+	conf_value=$(git config $conf_opts -f "$GIT_PERF_CONFIG_FILE" "$var") &&
 	eval "$env_var=\"$conf_value\"" && return
 
-	test -n "${4+x}" && eval "$env_var=\"$4\""
+	test -n "${5+x}" && eval "$env_var=\"$5\""
 }
 
 run_subsection () {
-	get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" 3
+	get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" "--int" 3
 	export GIT_PERF_REPEAT_COUNT
 
 	get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
-- 
2.15.1.361.g8b07d831d0

