Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD36C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiBVQbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiBVQa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:57 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4C166E31
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p4so1726864wmg.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VcXD2hWLwntQ2CtjTP7AMQ9SvTJ37bqnOMIpNn2C5kY=;
        b=gbeBfEwPQTXCOiXUijZrnFM+0SyRjG+PMcGBve07V+YAhfs7g1co4h7SgGLG5d8xSX
         1LAHEu9xovAwATOXV2y6SRDpSP4klsD4ieXZzEBdeGxP5UAJaUu2uww6L/Rra/iTQFOJ
         6Ac6HGFiw6bHS1VNjM3ysDynO2tw2eegHBuVxOu/FHsmz7q3P6G/nSXm7Z5rn8YnTpEO
         3kcmlhjkLJzdXJgO+2ms6dtcNSnTEo1H7E455sB0JeeCOTRdeoi13Fv4Dd42gpRrY3b0
         XE49SA2tdizQlz2lnjOSVovbCnPX3q+vPGg1s3a0ENr1PSnOUXL8K5YcvOGtm7APv0Xu
         Riiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VcXD2hWLwntQ2CtjTP7AMQ9SvTJ37bqnOMIpNn2C5kY=;
        b=SR6jb4+U7qrkdIeVFELQgnLIUbsusFgVgbEoObO6JWL5VCUKbJdbHPC4+jW8q8pH8O
         8JTCaviOfHIrQzVApAZxseA7AC4gquHLR9SAxmLCscb5sOxd3XPnzAW8boHsMRRm6osb
         lZ20jFz5crQxnpGEF6i0KeWRc9tmaWNzRxWQvRR4+NgDhq/OcPo573t43jafDW7abRLc
         CYQ94UgF1kePBgYevMqoqcT+kyQWyfA9+JS+CDNcLZjzsNWe3AsIViXmvk3AOL5KcZbZ
         REFZcRQJDQV0A2Aye5QDnKw1IMur+Tzmfc6n2e6E7/Ghixv5euuzMBlXbqjf4s/HDf7L
         2gaA==
X-Gm-Message-State: AOAM530HRcu5h0ExOPpl0wY+N6B2WLdm69tH0A628QchWWHiYiSozfW2
        1AxUrHaXoxyzhFaSYNby533PrBm/EVw=
X-Google-Smtp-Source: ABdhPJyGm7bz+9esP+MKpr3bTy41IbKwC6CK5ttRh/ZIrLvkZvX8IDNkwsD2QAoqlbm+N7/yXG/niw==
X-Received: by 2002:a7b:cc8f:0:b0:37b:dcdf:cf40 with SMTP id p15-20020a7bcc8f000000b0037bdcdfcf40mr4056273wma.99.1645547429811;
        Tue, 22 Feb 2022 08:30:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm37108141wrm.3.2022.02.22.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:29 -0800 (PST)
Message-Id: <a345cf3e0e4b92a2a8080ec245315fce6a8888d6.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:15 +0000
Subject: [PATCH v2 06/14] bisect--helper: using `--bisect-state` without an
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
index c7763be2c51..fcddd7444a4 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -856,7 +856,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	struct oid_array revs = OID_ARRAY_INIT;
 
 	if (!argc)
-		return error(_("Please call `--bisect-state` with at least one argument"));
+		BUG("bisect_state() called without argument");
 
 	if (bisect_autostart(terms))
 		return BISECT_FAILED;
-- 
gitgitgadget

