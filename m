Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D5C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 04:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbiCDEcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 23:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiCDEco (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 23:32:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5861795F7
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 20:31:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so4403411wmp.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 20:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Llz1/Y6KRqvNqR1sw3AlCX5fARmXABCDMcFNaQX5GQ4=;
        b=HZ+unWnzV2Djsi4mhiiW5qk0yBR4MrSo7e0xkRC2Sue6L8cjTjxgU4BScxUc6yFwwE
         ZnmmCGmVKNehXafJuY4t55He7qZQ8sbmGW5xGZVewB5eUULfQZXd2pIZ47G3UZIARNjz
         xXFqFaP2iVsr7MdSYkX0bCuBqerhkB7fZqRWoLZ/LRGLckfC4XoJ0QYXxR5UfEN0UKVd
         RjYIAfeiG8jDf850AYwdbIcNXick5hLporse/5YKEPKR+rNSSjH1lqkEVYjoWXASVFyA
         6i3hoKynoZU2spVr8luE6MvclaNkFnr6CkJLT7d4B1qc9dCBwCYotRq8GbNmKNaf5x2+
         n6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Llz1/Y6KRqvNqR1sw3AlCX5fARmXABCDMcFNaQX5GQ4=;
        b=dphTwiWoldCNB9GnjSuGEEu5qD6BvcgaEKCZXFyft6EIsIwGDh4ImxufKE2ZLNmZ8J
         q765H0ZKusSd7VZ6tonvrnPTtRBHWpf616kSx2zQPVhtdloZueWGLsvI7mmXEPGi6aKh
         EmRe3vyHqHAJxFekD9B2L154FfJvakc7w+FMQOCK3M2hxnNjLzYxRD/Un3kDihWDakT3
         2P8Vss5wwUJNHTISM0DUUuPbf2rE58hbQqpPlpeRSLPC4/XcteXVfwLnMkSCRq8a++zI
         NTxQFdA+n8UfqjlOjU14TgcnETE26QhSlWGIKnm3BBx98l7+IOfHfLx7Xqaf1NQ63MhQ
         /z4A==
X-Gm-Message-State: AOAM533RJ3CEUejO93owuhyLEn+o72Jxms7ClTvHmt9XgbQTX8nA50bH
        9hYNvKvUgQqfNC+vrWR0iFAiqrxvLU4=
X-Google-Smtp-Source: ABdhPJy5xVG7SqtXwZY1wyO0F+s2x9ZanYE8ZrNlPteqx6iUy+wjaMr8zmzwboqZZogk3QhbtHSkZg==
X-Received: by 2002:a05:600c:4e89:b0:37b:bc9a:4618 with SMTP id f9-20020a05600c4e8900b0037bbc9a4618mr5875759wmq.160.1646368315252;
        Thu, 03 Mar 2022 20:31:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o204-20020a1ca5d5000000b0038331f2f951sm12429451wme.0.2022.03.03.20.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:31:54 -0800 (PST)
Message-Id: <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com>
In-Reply-To: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
References: <pull.1220.git.git.1645853661519.gitgitgadget@gmail.com>
From:   "Matheus Felipe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 04:31:53 +0000
Subject: [PATCH v2] fix: include the type flag in the cli docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Matheus Felipe <matheusfelipeog@protonmail.com>,
        Matheus Felipe <matheusfelipeog@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matheus Felipe <matheusfelipeog@protonmail.com>

The usage help for --type option of `git config` is missing `type`
in the argument placeholder (`<>`). Add it.

Signed-off-by: Matheus Felipe <matheusfelipeog@protonmail.com>
---
    fix: include the type flag in the cli docs
    
    When the git config --global --help command is invoked, the cli
    documentation is shown in the terminal with a small error in one of the
    values of the Type group, which is the absence of the type flag in the
    --type argument:
    
    image
    [https://user-images.githubusercontent.com/50463866/155674905-01fcdf18-8f67-488a-b367-985040dfe57d.png]
    
    In the web documentation and man page:
    
    image
    [https://user-images.githubusercontent.com/50463866/155675353-4a39965a-875c-475c-829d-7849a982f5b9.png]
    image
    [https://user-images.githubusercontent.com/50463866/155675437-7283dbac-fff2-44b7-8733-7d5af375bce4.png]
    
    ------------------------------------------------------------------------
    
    Changes since v1:
    
     * Added a better commit message (as suggested by Bagas Sanjaya
       <bagasdotme@gmail.com>)
    
    ------------------------------------------------------------------------

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1220%2Fmatheusfelipeog%2Ffix%2Fgit-config-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1220/matheusfelipeog/fix/git-config-docs-v2
Pull-Request: https://github.com/git/git/pull/1220

Range-diff vs v1:

 1:  7bc0abde8ff ! 1:  1550d29f5da fix: include the type flag in the cli docs
     @@ Metadata
       ## Commit message ##
          fix: include the type flag in the cli docs
      
     -    When the `git config --global --help` command is invoked,
     -    the cli documentation is shown in the terminal with a small
     -    error in one of the values of the Type group, which is the
     -    absence of the type flag in the `--type` argument.
     -    This commit fixes that.
     +    The usage help for --type option of `git config` is missing `type`
     +    in the argument placeholder (`<>`). Add it.
      
          Signed-off-by: Matheus Felipe <matheusfelipeog@protonmail.com>
      


 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 542d8d02b2b..2aea465466b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -151,7 +151,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),

base-commit: dab1b7905d0b295f1acef9785bb2b9cbb0fdec84
-- 
gitgitgadget
