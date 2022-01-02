Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1744BC433EF
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiABRQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiABRP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F312C061799
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v10-20020a05600c214a00b00345e59928eeso13494183wml.0
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=G8ZhOFK+rEhV7Td11+8kJU8F2Q1pbsu8pd39C1O/2uM=;
        b=dT2DrsbHY/4bWFcvFwBi6+yzcoa6nC0D2KHLXI33TFrSQPD+iW/OCTV21kn2yuyXCB
         S861OUP5RT00QvLXGVgtufnuMvsUIz6lEu+EjL9M0gxCw270LRydnzfgS78+TvkYfg51
         21zJk/kiNJJUqMY7eiEyp0F38MtxKK46Pag/Caj277Gf+RMyxN3w3eqfjpzOz0WUcuEB
         9WnJRAYlcZczIeo7wisVMLqJ5K1qzrzjivifR6rAC2gxN89XXSrLkaaCv0rij7l3yLdR
         kFQqop1cMVUklfETsO+ZlJrCe8af6u4bu3ESYCC2Da6UVxJPlLU7OxmpkNSz1qf19ZMK
         M7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=G8ZhOFK+rEhV7Td11+8kJU8F2Q1pbsu8pd39C1O/2uM=;
        b=bxgCfZaz5DDV/r1R0jBUlwLjpN73ha3tRD4IaqMNvbKN3hkNm0MEnBAy2JHLCrCzQC
         g8hEmzAtdav3D3b6iGOfYYl9WbFLFU7lX+UgeFn+0TEtsWKJaL7IqstdJ5dofchlQElb
         cn8FJiTW6RnO87Ta3NPyuj688x3fhu3CnsRKZdW4Uc5J/Yx99Zpe9DyAMN+vHIsNGjOn
         AXrUtrjS9xq9S+k6Cq80OcLrMx9ev4liVFv0D4yJ8sesMdIRVe0RiR2JaoV57jy4EAw5
         GaEdgVj+77o9nr6jXNaba7zvmKsnRTQ3gA4vhn1aLfsIdwL/Mf9+gkMGPFPEWon/G8Uf
         cCvA==
X-Gm-Message-State: AOAM532mkd3s1XjCF2olWbA1YGJluH7qLoefRR2E0ssCRwxywsWc/JEJ
        R1YrHhCm1cMkF/h+5RVxoyCcpptDU3M=
X-Google-Smtp-Source: ABdhPJxbOV4X6z3S9Ywdbbwi1Fgqf2+ODVveLCXYCfsPJeXGIiOhCpLVabzCLqIoE2j+4xcqX5Gigw==
X-Received: by 2002:a1c:9851:: with SMTP id a78mr35835455wme.181.1641143756078;
        Sun, 02 Jan 2022 09:15:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm37710271wrp.34.2022.01.02.09.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:55 -0800 (PST)
Message-Id: <39e375c68ab551f199fcb3bb97ad2e40bafa2753.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:43 +0000
Subject: [PATCH v4 09/11] i18n: factorize "--foo outside a repository"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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
index 609814e9708..b86f8d201a9 100644
--- a/apply.c
+++ b/apply.c
@@ -136,7 +136,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 		return error(_("options '%s' and '%s' cannot be used together"), "--reject",  "--3way");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			return error(_("--3way outside a repository"));
+			return error(_("'%s' outside a repository"), "--3way");
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject) {
@@ -147,10 +147,10 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		return error(_("--index outside a repository"));
+		return error(_("'%s' outside a repository"), "--index");
 	if (state->cached) {
 		if (is_not_gitdir)
-			return error(_("--cached outside a repository"));
+			return error(_("'%s' outside a repository"), "--cached");
 		state->check_index = 1;
 	}
 	if (state->ita_only && (state->check_index || is_not_gitdir))
-- 
gitgitgadget

