Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430CB1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 09:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeAEJNO (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 04:13:14 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37883 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeAEJNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 04:13:00 -0500
Received: by mail-wr0-f194.google.com with SMTP id f8so3794759wre.4
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 01:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tg0BSyH6gd7g8kzQV6SJY50NnbhVIJ+VAv4iAOMGjtw=;
        b=k62K+GdDYmKd9xirmd8sWvDAEnlsgdE+/fovYzxSXfTGLz2utKyUlMz0pvJewLRAGk
         FPgeaWAlbrkTtnnVvwC3J8dxI4Fk+v6nKLWchKs0Ei9tSn+ffYmVZGmO9YAEWiXcsrpt
         BKh4vFLqVOY1upyUyEQpukkIjaSxyH1qxKAfG0L35aMDmCinFLHUWofTb49G6k+AFQDo
         y1A7wRynEBizuyf2Ntfig4AwXNiqV2c9j0X5c6zn5Z3Dl6D32v9DDAw89ScPxMEwNpT/
         t82x88gQPI2gAvGfWrJ6pSLpFmaP1ko8L5/U/c+2KwW1OhM9hSu2WObyqHPEGu0TFvxJ
         Qdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tg0BSyH6gd7g8kzQV6SJY50NnbhVIJ+VAv4iAOMGjtw=;
        b=rqMiQi2HWO41xnW8J4xPJb2PsnsiFqdmRt+l5AJmtmi/09p3PuxZ4FYg1eKAeU8oQE
         gD5w6nG8cD+fypcvVSsMSapJIGz3xwQpgMh1UUG77We7+e4zGPSmlAnHtIL06uV2PVys
         uj4nMELDzpiqGyCXSi5DxQgiIVP1zBl/qlXFRugUC4d1n/3VjFw5BfI7HhyqT1GwlroU
         BY153kcYVEa0gZyu8PESQo5S4ppCQW+McWB217vNTeWnSVQy3Mz+ftJwlGfhlBvPMcyO
         d0xB+bYg74oofxCNtTHRIxpDm2O1qqfpA731zKOpeHDORXhszeHivzNjp2vB77uMIl/E
         mj3A==
X-Gm-Message-State: AKGB3mJwvQ8vcNokk5xaDN9yY8XNSeogakYORGJMZUott9Ro9Lp9Cjw9
        bQ4PGcXsQPQOBH2F8KmJ35aeUIt2
X-Google-Smtp-Source: ACJfBotvRW7GG9F0+ZWf7C8sFQsLAbSxwosWu9Y3JwW4HE/joZuHojpL3UcYjExbJ2p+rKoXsr+W8g==
X-Received: by 10.223.143.12 with SMTP id p12mr2050316wrb.215.1515143578495;
        Fri, 05 Jan 2018 01:12:58 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id y42sm7903531wrc.96.2018.01.05.01.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2018 01:12:57 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 4/7] perf/run: add conf_opts argument to get_var_from_env_or_config()
Date:   Fri,  5 Jan 2018 10:12:23 +0100
Message-Id: <20180105091226.16083-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.40.gbe5e688583
In-Reply-To: <20180105091226.16083-1-chriscool@tuxfamily.org>
References: <20180105091226.16083-1-chriscool@tuxfamily.org>
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
2.16.0.rc0.40.gbe5e688583

