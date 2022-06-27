Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF2C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiF0Sg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D41186F2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so10314522wrh.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cvAsonS42Tup4hwd7c6iXHefk5sNs59iVXAPJs+zYh8=;
        b=Or/iiq7W+XU44jDvGusWotTmY2/eYzLuGMWrPeeJAqhAFFsUELAfChO143EVz1x3yH
         OaPWB+EEWNpMf0065WlrSRGuzfy7/zvKAtj85+TFaPWfAlrHr0XfqbGQkTWD4DKLOtyN
         rEi7mrMPLOrrzhc/SO1xyAqgNRu+KnbVHvX6xtqVdZPuTVYmTxrUSb+1gOcOxRLkEm01
         lG+4+pWhCHDG1gSW05DzD9uBA9bkVH8knJOKEPJBjT0Ka4FTnvo40XuvdIeEal01Sevo
         9So0uXdZgaAcS2NQiPbHbdIrRFgYh/Hum+p6B7G+S511kcs67dOiyvFtOJhRoJhs3fIW
         a0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cvAsonS42Tup4hwd7c6iXHefk5sNs59iVXAPJs+zYh8=;
        b=bcrE+7Dhq24lt/M9HgPI/CZX+7YnWnz54/iBju+vo+GD0mUDoga0c5xi+H6Y4z+KSk
         hiKJKOef5jXYYZfkni1S3jFOzgSF9tVbDt1K5GD5gbMlLt4a6wbmkExaUiVeKM96wxbz
         kdzgmVT7yyPEO2A2s5LKu/rZyTNy6Fra8DgaOs/CDFze4eEYBX2VqV6IqSdEfRF0ZyZ7
         oLH0Q0oL1FOAbA2Lod3UJQ2Swh39LxnVYZ/RfGti8sQh8IEWGhwVBmOL2MeCJB9PlP2o
         chtCkSRtQfgA7BZH6VClyQ5ot3QjZAunq1QgS+flDUGUbg3d1aU98Ue47o+rJTTVMHMm
         gPeQ==
X-Gm-Message-State: AJIora/k/gfXnLgazhamU/ZM7UdZNYHGvy7S9l5DDGTNmkuo+ghVb5ib
        HexaxRdFxqBOL976VKcIiZBX4nV/S7E+Ow==
X-Google-Smtp-Source: AGRyM1vfuKBgjTq2BSbE3HZqRawzJqShpFFC3hocfHFbUAiUjx65r2g0q54gtpJufWAJHWVj6lTmvw==
X-Received: by 2002:a5d:64ad:0:b0:21b:a83a:e5ce with SMTP id m13-20020a5d64ad000000b0021ba83ae5cemr13429276wrp.701.1656354687506;
        Mon, 27 Jun 2022 11:31:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c1c8800b003a04722d745sm7169041wms.23.2022.06.27.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:27 -0700 (PDT)
Message-Id: <aad3c9a0850d302d6dbdb6ee583db0b61e58981a.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:08 +0000
Subject: [PATCH v4 07/16] bisect--helper: using `--bisect-state` without an
 argument is a bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `bisect--helper` command is not expected to be used directly by the
user. Therefore, it is a bug if it receives no argument to the
`--bisect-state` command mode, not a user error. Which means that we
need to call `BUG()` instead of `die()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 477aba811f0..45983a0a1fc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -900,7 +900,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	struct oid_array revs = OID_ARRAY_INIT;
 
 	if (!argc)
-		return error(_("Please call `--bisect-state` with at least one argument"));
+		BUG("bisect_state() called without argument");
 
 	if (bisect_autostart(terms))
 		return BISECT_FAILED;
-- 
gitgitgadget

