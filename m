Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B5CCA486
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382691AbiFHA0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451388AbiFGXMh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:12:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E9B3A15DD
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:57:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q26so15362991wra.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Eexds/wtUWaNlzD4CckNK+1vjkrUR5m5mCaAu4Jc1A=;
        b=XIILYelvghoJss8Wr7Z+Q7jufK/dtCFoqkS6shIRf+jT/nnAGGWd+Ctf9I2ai6sX7G
         eQ4EXktpEzk2Ogq3Ie6mO8IQyWG3Vnjzca391uuzlL4xnerE7MwJBwT2WwK96rnG/Dzr
         D1Dlf0gPV6vwxiZCP28o6lZzY/Wqtn6MiANt26FSfqL6jfU/+ZrmTioAmAN2fVcxf90Z
         8tlR0bYqb17DeaakRDwymjJhHTVole7qM1qeJL9gxaU2QjjhhO4cwP7S5aQwWFNn39wq
         uyqBA7u8gEO9x12S5zecI421ClW54JTqDoMK4dy9q9JdPT+1R+NRgcxv1c6QVYQJdm5y
         gs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Eexds/wtUWaNlzD4CckNK+1vjkrUR5m5mCaAu4Jc1A=;
        b=xfUIGceBz4QyVFXz81ICW3zJpOstm97heqqMz8gdkov8P5mFBGkU1f0jnLJq1kzhee
         4BS1UjWzun92xK/62mtWj5WRml0nOr271tX85CVnB3KdDsmi2m1PIg1gjNngsfNLdfeN
         Yt7eqxA5Of+mtrdDVulINhluj+QoQMt8xCb6x3SHQDH1QXhHw0z0rCc+6dt7cTVOOlOK
         UvA+umWt2CQLrln/SQJXQIYqcW+U4TVj2MaHsrpgmHIcDQldgwzacqU/rjlVlq2O6SED
         FaCt0J8vlUZVh9GAagYcCPtkug9/DtDxR45Gx0g4MQZAF5KSTVQSI9cn6rTI5rjvjjjq
         vMNg==
X-Gm-Message-State: AOAM532LSfBnqPnZ2qjcVcnSF4pfH1JiV+eHdwH0X/Mwzn64A1B+bv1E
        qhW1bT2lDQ6AOt1jNdFpigvsLlQKRi6sG6pZ
X-Google-Smtp-Source: ABdhPJxgL9x0uShpNQK8CfOircCzgzb9sToZFrNn3xR/gTXSQin9JClLvswVBplS8PGCtyrwFO0FPA==
X-Received: by 2002:a5d:47a1:0:b0:218:423a:de8f with SMTP id 1-20020a5d47a1000000b00218423ade8fmr11684058wrb.420.1654635439478;
        Tue, 07 Jun 2022 13:57:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2-20020adff1c2000000b0020c5253d8dcsm18084468wro.40.2022.06.07.13.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:57:18 -0700 (PDT)
Message-Id: <156817966fa87e0e3b94a1e8468ecfc6683b1946.1654635432.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:57:11 +0000
Subject: [PATCH v4 4/5] safe.directory: use git_protected_config()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Use git_protected_config() to read `safe.directory` instead of
read_very_early_config(), making it 'protected config only'. As a
result, `safe.directory` now respects "-c", so update the tests and docs
accordingly.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/safe.txt |  6 +++---
 setup.c                       |  2 +-
 t/t0033-safe-directory.sh     | 24 ++++++++++--------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index ae0e2e3bdb4..2a7d2324250 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -12,9 +12,9 @@ via `git config --add`. To reset the list of safe directories (e.g. to
 override any such directories specified in the system config), add a
 `safe.directory` entry with an empty value.
 +
-This config setting is only respected when specified in a system or global
-config, not when it is specified in a repository config, via the command
-line option `-c safe.directory=<path>`, or in environment variables.
+This config setting is only respected in protected configuration (see
+<<SCOPES>>). This prevents the untrusted repository from tampering with this
+value.
 +
 The value of this setting is interpolated, i.e. `~/<path>` expands to a
 path relative to the home directory and `%(prefix)/<path>` expands to a
diff --git a/setup.c b/setup.c
index f818dd858c6..847d47f9195 100644
--- a/setup.c
+++ b/setup.c
@@ -1128,7 +1128,7 @@ static int ensure_valid_ownership(const char *path)
 	    is_path_owned_by_current_user(path))
 		return 1;
 
-	read_very_early_config(safe_directory_cb, &data);
+	git_protected_config(safe_directory_cb, &data);
 
 	return data.is_safe;
 }
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
index 238b25f91a3..5a1cd0d0947 100755
--- a/t/t0033-safe-directory.sh
+++ b/t/t0033-safe-directory.sh
@@ -16,24 +16,20 @@ test_expect_success 'safe.directory is not set' '
 	expect_rejected_dir
 '
 
-test_expect_success 'ignoring safe.directory on the command line' '
-	test_must_fail git -c safe.directory="$(pwd)" status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory on the command line' '
+	git -c safe.directory="$(pwd)" status
 '
 
-test_expect_success 'ignoring safe.directory in the environment' '
-	test_must_fail env GIT_CONFIG_COUNT=1 \
-		GIT_CONFIG_KEY_0="safe.directory" \
-		GIT_CONFIG_VALUE_0="$(pwd)" \
-		git status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory in the environment' '
+	env GIT_CONFIG_COUNT=1 \
+	    GIT_CONFIG_KEY_0="safe.directory" \
+	    GIT_CONFIG_VALUE_0="$(pwd)" \
+	    git status
 '
 
-test_expect_success 'ignoring safe.directory in GIT_CONFIG_PARAMETERS' '
-	test_must_fail env \
-		GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
-		git status 2>err &&
-	grep "unsafe repository" err
+test_expect_success 'safe.directory in GIT_CONFIG_PARAMETERS' '
+	env GIT_CONFIG_PARAMETERS="${SQ}safe.directory${SQ}=${SQ}$(pwd)${SQ}" \
+	    git status
 '
 
 test_expect_success 'ignoring safe.directory in repo config' '
-- 
gitgitgadget

