Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB29C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245521AbiCWSTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbiCWSTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:19:35 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E52ADC
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1379654wmz.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FAqtUY3aNNSHExO1ET3xShgHTqeDSMfT9ydrGdtkQxc=;
        b=LAgtBgm5V7Fiw+iv9H0S0SESnakM5XvGoLMlMeDrFs+Gl1aBRM/nOWj7jpl18ncXn+
         bP7JSN5DGMRintkgW9LJ6NHF/KgynahGLGbTzryqBQ1PeCeyC4r4oPKErjX2XL4VwnZ1
         Uu1z1Sbq71pa/ZJfhfWIje74MgN/0geXXy3nqZcGFJQAPp/uTratc1j4mC4D7ncpp1ka
         ko3x46Mo9Jhom2O4g2DyS3Hy3JK8+Tr4eo4hr7mv7SHabTLwxuIo9MA6ffUNEGXitYFV
         V/q2+oS+5WRU6/ep5dINLY1FJk5BNclsz7zwk4PnqVVgKXbvIgoNMtMS4d/6TDPExJ7R
         G61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FAqtUY3aNNSHExO1ET3xShgHTqeDSMfT9ydrGdtkQxc=;
        b=f09oRvU7fMqUbM32hVV1+GKR0sMHxf+cSH4TxuSycy6ZF643GuJShXn8q7ljFEvCUr
         QfFtxwPcwdxnIdLoI6lngWP6OcY1v4j+rGjwiLWkjSZw6qVDUX5S/DvEOhLfPK6zHXrg
         JaMbIZX2rHUfehlHsXm6QReDRbyulZJzMp47q4zW0CUsxPD9DaxJ6hHqtomxIg83Gf+l
         75gVjB84qX1nN71oWmdo6l64+0OnrBn8Nrhsyfk3I6ke1fwsO+wFoF3JQl71Dk6mMnMT
         dnbrVU/1lWIQ8D3YilSHHWyTeLDLuGHBdNkSTgpzgft3TogPVrYIuOSvp1oHGNErNRz6
         Zi3w==
X-Gm-Message-State: AOAM530mX1JkaTpDiaGyF7ndkY7k+5PR8H1lm3At2paRgJxI+LRMluaV
        +6qhT66Y2w01rygmhvAoLie1Yiu2uA4=
X-Google-Smtp-Source: ABdhPJzWGMiNXdc+xJyrmgXWYBAADgj9vrS+8+dktu7sm6fm+vtESV/D+KeLoWIWN1LuvW6KObp9RA==
X-Received: by 2002:a1c:f005:0:b0:38c:b6d5:5c2a with SMTP id a5-20020a1cf005000000b0038cb6d55c2amr10786309wmb.89.1648059483243;
        Wed, 23 Mar 2022 11:18:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020adfea10000000b00203e0735791sm485712wrm.39.2022.03.23.11.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 11:18:02 -0700 (PDT)
Message-Id: <a25aff3ac7c5835445b4387c3d4cce82c6c36758.1648059480.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
        <pull.1184.v2.git.1648059480.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Mar 2022 18:17:59 +0000
Subject: [PATCH v2 2/3] reset: remove 'reset.quiet' config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Remove the 'reset.quiet' config option, remove '--no-quiet' documentation in
'Documentation/git-reset.txt'. In 4c3abd0551 (reset: add new reset.quiet
config setting, 2018-10-23), 'reset.quiet' was introduced as a way to
globally change the default behavior of 'git reset --mixed' to skip index
refresh.

However, now that '--quiet' does not affect index refresh, 'reset.quiet'
would only serve to globally silence logging. This was not the original
intention of the config setting, and there's no precedent for such a setting
in other commands with a '--quiet' option, so it appears to be obsolete.

In addition to the options & its documentation, remove 'reset.quiet' from
the recommended config for 'scalar'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config.txt       | 2 --
 Documentation/config/reset.txt | 2 --
 Documentation/git-reset.txt    | 5 +----
 builtin/reset.c                | 1 -
 contrib/scalar/scalar.c        | 1 -
 t/t7102-reset.sh               | 3 +--
 6 files changed, 2 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/config/reset.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f0fb25a371c..43f5e6fd6d3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -495,8 +495,6 @@ include::config/repack.txt[]
 
 include::config/rerere.txt[]
 
-include::config/reset.txt[]
-
 include::config/sendemail.txt[]
 
 include::config/sequencer.txt[]
diff --git a/Documentation/config/reset.txt b/Documentation/config/reset.txt
deleted file mode 100644
index 63b7c45aac2..00000000000
--- a/Documentation/config/reset.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-reset.quiet::
-	When set to true, 'git reset' will default to the '--quiet' option.
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index bc1646c3016..f4aca9dd35c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -105,10 +105,7 @@ OPTIONS
 
 -q::
 --quiet::
---no-quiet::
-	Be quiet, only report errors. The default behavior is set by the
-	`reset.quiet` config option. `--quiet` and `--no-quiet` will
-	override the default behavior.
+	Be quiet, only report errors.
 
 --refresh::
 --no-refresh::
diff --git a/builtin/reset.c b/builtin/reset.c
index 1804d0eeb84..9ce55afd1be 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -423,7 +423,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_reset_config, NULL);
-	git_config_get_bool("reset.quiet", &quiet);
 	git_config_get_bool("reset.refresh", &refresh);
 
 	argc = parse_options(argc, argv, prefix, options, git_reset_usage,
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7db2a97416e..58ca0e56f14 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -152,7 +152,6 @@ static int set_recommended_config(int reconfigure)
 		{ "pack.useBitmaps", "false", 1 },
 		{ "pack.useSparse", "true", 1 },
 		{ "receive.autoGC", "false", 1 },
-		{ "reset.quiet", "true", 1 },
 		{ "feature.manyFiles", "false", 1 },
 		{ "feature.experimental", "false", 1 },
 		{ "fetch.unpackLimit", "1", 1 },
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8b62bb39b3d..9e4c4deee35 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -488,8 +488,7 @@ test_expect_success '--mixed refreshes the index' '
 	# Verify default behavior (without --[no-]refresh or reset.refresh)
 	test_reset_refreshes_index &&
 
-	# With --quiet & reset.quiet
-	test_reset_refreshes_index "-c reset.quiet=true" &&
+	# With --quiet
 	test_reset_refreshes_index "" --quiet
 '
 
-- 
gitgitgadget

