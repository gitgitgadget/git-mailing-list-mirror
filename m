Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF1C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiF3SOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbiF3SOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:14:10 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD81403C1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v14so28455720wra.5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=YWv/4lVajihzRbJNmhWPtwzTPBN6my82HPzbM4MsjL0NXO/xKIzkctrYwhlVSn2MoK
         dG24awj15fpWJDehNvb6pyO+P6oMLCqq6USshqlDOns1JqmInWaB8hPSHFK5MnDkiw8/
         /3FlsB1UMjd7nRhMowQL2QNUkYFpF8ArC0H/p+VP+yLgMoYhW7ItwQ2iO1fks+PgqhBD
         m10FCB4uAG0mHz/kIDW8wGodk7dSZdcA58n3z1JTuIqFRY5UusnFc1IEZb7JQJb9lRoS
         hXXchujXc35uV80HN1hjODHNjsxddigIIWRjGn6Q2Jwh6OV9kGJ1sJY7pjDfco9srOed
         mQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=R8+ookfiZqrua8Dq6K2O9r4dwX6DM037EFhoTyoOWwRPTG9A+OYCxXAVx2YEFJY+Jf
         2+beAyZ0Ygr4frmALR3KYg508s6FqhZa/atibsW8CjUalWbBN0Gb2RYJhL6d5SYrWqkZ
         mXFd1MpOJ8pT5zRI+fnOfvncCsJpib9kWlrR6DTo2QrTmkNzPThyV+zibrnASXGs/KGJ
         bvsQRaAP709BV6tZsXOgXU7RqtRZcagYHAVcL87VQrbJL70geBRMtDKnTaBUJm0bdlDo
         fLDyJi5J7KUu5NiTeRxwrsKf+7egU1USCkna0DXJ1BjweBb4HBVYEf6mZtbafpMjWaBj
         x1Hw==
X-Gm-Message-State: AJIora8bb9SrS31aqrvDTPTW3/RLi9jg/UonAmlD8y7QfoXV7EAoR7b2
        9wT9QFcwadlzqKeQQt8prpblzVE3KWM=
X-Google-Smtp-Source: AGRyM1v2m+wo/Mq4p/IkbFVIGrrMyO32AlJSOZVyjv3Rh9kRCzpUNoolKzpEEyC2RfcoDDwFtHvsmg==
X-Received: by 2002:a5d:664c:0:b0:21d:2d0d:e729 with SMTP id f12-20020a5d664c000000b0021d2d0de729mr8805873wrw.585.1656612846153;
        Thu, 30 Jun 2022 11:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a1c4605000000b0039db31f6372sm3445922wma.2.2022.06.30.11.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:14:05 -0700 (PDT)
Message-Id: <ec9258234142c4d1d164cbf475cb86e7b826bb8f.1656612839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
        <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 18:13:58 +0000
Subject: [PATCH v6 4/5] safe.directory: use git_protected_config()
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
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Use git_protected_config() to read `safe.directory` instead of
read_very_early_config(), making it 'protected configuration only'.

As a result, `safe.directory` now respects "-c", so update the tests and
docs accordingly. It used to ignore "-c" due to how it was implemented,
not because of security or correctness concerns [1].

[1] https://lore.kernel.org/git/xmqqlevabcsu.fsf@gitster.g/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/safe.txt |  6 +++---
 setup.c                       |  2 +-
 t/t0033-safe-directory.sh     | 24 ++++++++++--------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index fa02f3ccc54..f72b4408798 100644
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
index faf5095e44d..c8e3c32814d 100644
--- a/setup.c
+++ b/setup.c
@@ -1137,7 +1137,7 @@ static int ensure_valid_ownership(const char *path)
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

