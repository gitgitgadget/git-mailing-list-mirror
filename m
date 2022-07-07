Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA9C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiGGXCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiGGXCE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:02:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC4661D61
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:02:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n10so2968371wrc.4
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=UNEbkqZrK1rGHQWtMDCXUb8SDnBcBCCbcCapbeoVoDADoH78JVW5NO1J6gueJXeNJJ
         zeLmpiXrjABeZmf9cPkwzy+BKrpigE8OlGxT6vbp/rnR1ngUIJ9EsXsSN1ZO5iMtAHFz
         PXdl/ioJB6IMWAq9pzvGqxaNlagjft90O7t5Q2pwuFAlK0u7I2A9Zco20F1qnjxUekLU
         lzMpwWwVZwYR6wKDCSEOTDGFIHt9tzXZ0oxonV9dZwYjXoi8BastU0TOyFCUfBUs4Pzf
         /5J8/GIqy6R8+aYyBdlrpKHUsHPbn13VG6O3SEQkhxlmwBxGjSltgpX5b6KcPyHRaRu+
         4OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vK/cK2CsYvziF+h6RxKNGee1lI7W8gvh+Wi2KpMeAJo=;
        b=w3Zf5ion5vhqweoes9UfvNVlxDPGROwwz/46H7s1A087SMp8G4e8Hyth7s6+cdgyVj
         XGUn61LFWMwhYis43Dg1DjolkRbZQVxqnazcC0xtxOQxd6MYywARS77uQrML+zIC4i4W
         EB3PA6XG7hSUr6vX5/UFHMo5JaXw9clgWx0GSenrX75fI0l0efE8RDEAQHm0HXoSmS9B
         6cYJdgM9t1Jto2tagAocWyM956SU08pdapI8qntNOOkFrQH8MOmr1HxY2fILBw7/gn9f
         m585RCKb7QwfFjYDN/2gvI8ohLDXRL48oKJ9OZztkyTxnMkLTc+CmvgKZS5T1DGqXWni
         ld7w==
X-Gm-Message-State: AJIora+5xnb0RaAjSFQfiqXoS6ZxnO0jdzEOq4KyXlZd7dNjdB8iOpYX
        EurCFjK1kpQOpCV4zJueltJ2VfBEcqk=
X-Google-Smtp-Source: AGRyM1vom6pSLDeaIaRV2721znrDNisMfkeirbNNuC0g5guj1rxw8LbWiGt7y6booDeY0HibnEwz4Q==
X-Received: by 2002:adf:f20e:0:b0:21d:8aa6:69da with SMTP id p14-20020adff20e000000b0021d8aa669damr263785wro.66.1657234921462;
        Thu, 07 Jul 2022 16:02:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t7-20020adfe447000000b0021d83071683sm3469011wrm.64.2022.07.07.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:02:00 -0700 (PDT)
Message-Id: <6394818ffd84928910273eedcd9f84e7e47f9dce.1657234915.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 23:01:53 +0000
Subject: [PATCH v7 4/5] safe.directory: use git_protected_config()
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

