Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC13C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 16:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbiCDQRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 11:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240815AbiCDQQw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 11:16:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BCE1CBAA3
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 08:16:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x15so13390385wru.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/BnN03yjX1v494Zmmg+nqu4b3PQV31xPAcC3MavOxBs=;
        b=Rt5fQYMVgiZ0/YfUaFfQO7JhrwrQI2ImCo/jhdofpdjCLot2BqBTE1f0jALs00z6Yg
         YTxUkwF14zvjFqu3a7n0x5is98gVLrtQ8cgOE5ZbuZV+BqVAoRWh9TTNPTdmwzX0M4yI
         kzdmBQf8mhQZgEDe+2+UtH0TZe/R13dt8n8FX1g5A0SklXIXz2Q1eb+UA9ytbo7l+5iX
         d8nA/Ao9h2EncE+RLuvEsdNaeOLH/8rFyzqMOPu8S3XDFp9sLsypfgO2WPF2fXjq7hJF
         T5Ol6sMrH4T39+QBDyxpBO/P0zqfStOiAy3HF5P0DnpxMRGDI726AujyCPz1LcTIsxeP
         UPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/BnN03yjX1v494Zmmg+nqu4b3PQV31xPAcC3MavOxBs=;
        b=o5xMGkze3J/ZgFcuHSiMFhxElillT4zEA2K7ZXLsm68gslEbirqcG1sFoDTr2Oqm7E
         EDMpbfLFaqdv8p4iFG7Z3h5fqb3CzBWnPSYz/xJoKOnahaRO3ebUws8X4ThM+lUtkqNW
         YrlZmJ1lltb9c2LA/inNpNJpbMN9U9Z+RkHKIdqT3t+iibSdZfTkCvJa51uTWalPHfQK
         N9bUx2ZD6SfPfQfKiWufWYmhIWvOaNBBrGb2UcnW6K3iLzaaRozb8vbd5tPheUeKRZxj
         U7SXGgNtNOcLybE9r74HHD3raAoIIXvrzM5Ae2w60SCeOfg7Ip7DgK9RKsuq8btWyuEx
         nzdA==
X-Gm-Message-State: AOAM532JXEBkv5MSygNLzmDuX9M9j2uvHnZ1mL6DIT4pZkmVXxyIo8MG
        87yX71UkTlEiNdjmwmEGuCADUmX+OdA=
X-Google-Smtp-Source: ABdhPJy3cOLpbG4yITeWm+ZePu8u4bvwc6DjqRKWvfIJtCaNRlq+sItKOIYIL6d3FvEmyxMP8t7K7A==
X-Received: by 2002:adf:a109:0:b0:1ed:c2bd:8a57 with SMTP id o9-20020adfa109000000b001edc2bd8a57mr30026934wro.612.1646410558780;
        Fri, 04 Mar 2022 08:15:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q23-20020a1cf317000000b003815206a638sm12140915wmq.15.2022.03.04.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:15:58 -0800 (PST)
Message-Id: <pull.1220.v3.git.git.1646410557888.gitgitgadget@gmail.com>
In-Reply-To: <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com>
References: <pull.1220.v2.git.git.1646368313714.gitgitgadget@gmail.com>
From:   "Matheus Felipe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 16:15:57 +0000
Subject: [PATCH v3] config: correct "--type" option in "git config -h" output
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
    config: correct "--type" option in "git config -h" output
    
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
     * Improve the title of the commit, to make it more explicit when viewed
       with git shortlog --no-merges (as suggested by Junio C Hamano
       <gitster@pobox.com>)
    
    ------------------------------------------------------------------------

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1220%2Fmatheusfelipeog%2Ffix%2Fgit-config-docs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1220/matheusfelipeog/fix/git-config-docs-v3
Pull-Request: https://github.com/git/git/pull/1220

Range-diff vs v2:

 1:  1550d29f5da ! 1:  f0fff5f3597 fix: include the type flag in the cli docs
     @@ Metadata
      Author: Matheus Felipe <matheusfelipeog@protonmail.com>
      
       ## Commit message ##
     -    fix: include the type flag in the cli docs
     +    config: correct "--type" option in "git config -h" output
      
          The usage help for --type option of `git config` is missing `type`
          in the argument placeholder (`<>`). Add it.


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
