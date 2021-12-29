Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAE4C4332F
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhL2Sz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhL2SzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB56C061747
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a9so46051108wrr.8
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HJowCI4wG8/H+dbje6h72gIFs/0u9CrYeRicZUF2+Ao=;
        b=loPkZZf6Oz/SAce7tfc0T/jgKBCZR6NN6+eB1WUmJ1hXTlLpoBvRiFpDg8gREAbbFJ
         HmywbResZAxrQke82PdZQHq01hKUF+YTRGTJZKfrPAoMbPJfg+RfwgiJfLxatJrndE/Y
         0ptpwhFbsidTbvbhVvWPLN9Aj+FET0gMmmcQq+BHlLwQGdc4McCLV4PP6Tfy0wtzsX8E
         JyjCa0DpbpFEWkhmgZdiWA+zvHuPyQUm5vmuulHIdIjDOJyqBJXnMdpenUnu6+7zAlIs
         IEtqHm2NzDx+XGDjQp2wnvMaF+DTpek+s4EQqcCjFuBJLIkNX1Mm6aMM66RDnlIvUcpJ
         1mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=HJowCI4wG8/H+dbje6h72gIFs/0u9CrYeRicZUF2+Ao=;
        b=tF4IYPfyB6Uz8A4YefGDLyJHSGPvSBay/t2soKsA1ukglQR152jNScLw9hr0ctijQf
         qs5Ykrq4hlFFnWMBTR6rJH+CJWseHOZmpc4gOMET6PWIz51OQjoOoJCTCccHZ2si+Fsr
         Fc8mT5LZQAOHkP8syVQ5iqM+S2uakSkngoPVQ7ilgyR0X6erllG+jBVAdnTbO6NIVbqL
         1Vfu8coK/eBp8P9f3L6FyzVFv2JsT+AgKpxEyhFF+ZL/UVciH5SghyA25bNwUp/QBKy6
         ehSSO9JqvXyTmdC01v/xcqAM4YR0DbYHDOEiyqHqdiqCaMbX6YE8ppZk7NSMVbCEjMo6
         bR1A==
X-Gm-Message-State: AOAM531Epxp6eqOqm5iBXpp6YbMbi4/rrul2cc6hu/b27czk4pu1lLzT
        APEOZwRc+Z597UrYMH+FGjndeiuA/xs=
X-Google-Smtp-Source: ABdhPJxCo1WPokGWjYmDbBpx5sZpdav6K1x22n+mH+/TtBPfnNfsG8NXhUHE5L4fMafzPueW9470xg==
X-Received: by 2002:adf:f24e:: with SMTP id b14mr21603261wrp.612.1640804115307;
        Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm22054806wri.115.2021.12.29.10.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Message-Id: <44d715a224cce812d224d419117bc5a07bf3e614.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:05 +0000
Subject: [PATCH v3 09/11] i18n: factorize "--foo outside a repository"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 000f2a9b1b3..8fd2ac2cfca 100644
--- a/apply.c
+++ b/apply.c
@@ -136,7 +136,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 		return error(_("options '%s' and '%s' cannot be used together"),"--reject",  "--3way");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
+			return error(_("%s outside a repository"), "--3way");
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject) {
@@ -147,10 +147,10 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
+		return error(_("%s outside a repository"), "--index");
 	if (state->cached) {
 		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
+			return error(_("%s outside a repository"), "--cached");
 		state->check_index = 1;
 	}
 	if (state->ita_only && (state->check_index || is_not_gitdir))
-- 
gitgitgadget

