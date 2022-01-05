Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4837AC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbiAEUDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiAEUCe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB88C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d9so572773wrb.0
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pXWKSago48SUiIPycSF/8IJoON9YEFLRN7skWH994fY=;
        b=aHOewuEO+hpoyput67U8mjyhvcZMCwKarBC6GyT73/hXVG7nfqYWLqbxf+trl78lHO
         9TLFgRsdhMb4Cx+WTPGvHphpWBhU3SgJQV6UVd/e8NHPSXGI6xNzP9AWwAWXmpDztr+L
         g6IxBawrICxS1/kcyN4ExDbxaHap/uzkrwL7/2qRuuk0OlN/3ey//WoWCnSR7xuk78Vz
         lft3LM6vU2R9mOafob/5UCvybVyByAilnQqBB4mGzT7b1kRFW9U2pnKGYVB7+MXdkjc+
         UJEhULQI1gERG1qeAktKMZC3A1OW6dLa9nXI67UM4LpIqxI99yleocHdr3eWOGiVMVgO
         x0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pXWKSago48SUiIPycSF/8IJoON9YEFLRN7skWH994fY=;
        b=eNRI5BMMJOLTZQezXbWj9q1BJlCRnOxCuPqKlCXSm0D/1mgHVmuIfqO49JQIwZUepe
         VMW5qifFmBoo+LMDniEfw6xtrFJfEibyL6DvI6Jm1JxH4bHC1xhzk58VJeOADarg9Ufv
         gI8p/HJDppi1QUKQ49H+jnvF8hvUZbuk22D61rKsaSajwvfSp3FWovdNGwpXEe4966bS
         yHNr2JrUMFLv8qsjVFDpR3jCYXi/W/3eJCoFenM4VQLhA5xIdzjjI5VYP2QS90gXzJFr
         FwwLkertIVNvzUdEdY5SMeDHS7V7g15f+XJAN2IlyPpBXbtDx/oIGxGepDyazEgxlfw/
         3yjQ==
X-Gm-Message-State: AOAM53114izciy1xiLwpncI0SgSbwq/TJG+yRq7AlEUb4adBRhwrDmf7
        VwjC+s4zI4F0+eNA7j/1NECu8tBNmPY=
X-Google-Smtp-Source: ABdhPJwQGT/rQwCTh73vWCgLm5EbtMufR9hUhO7CP/4E6D3D+SpxZgR8j9ACBGdhm3Jo9ojQqy5qOw==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr47849280wrc.29.1641412952698;
        Wed, 05 Jan 2022 12:02:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm3538101wmq.31.2022.01.05.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:32 -0800 (PST)
Message-Id: <7d97ee5dd18d2935c35448fe1989ecba9f5c1fdd.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:22 +0000
Subject: [PATCH v5 09/11] i18n: factorize "--foo outside a repository"
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
index cabcdbe425a..5cd369d5736 100644
--- a/apply.c
+++ b/apply.c
@@ -136,7 +136,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 		return error(_("options '%s' and '%s' cannot be used together"), "--reject", "--3way");
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

