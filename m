Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852CC43217
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhL0XYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhL0XYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:07 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60168C061401
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q16so34902669wrg.7
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=HJowCI4wG8/H+dbje6h72gIFs/0u9CrYeRicZUF2+Ao=;
        b=YqT1exGSQhURw+U/pnmG282ZIParPUrMsncjdUPi0hz/L+P/MEZOOrCRzg5bltDTQQ
         0yXGwIek7SB2LFmAbNkpRs9UUprATVtrgH0l67UQf5pvqfSKQnRuM4cZ6QNCrbcrDGhY
         ZXuzG/yZE8nK/Fo+kKBOjRSwKM/MrjyYFQjqaJD00Yv7sjTFKNMVhP776uHYcjs4YYGP
         9DeFlO+HSca3cU4Rwc2kMCqpIusaCZsqf2bupRSQ4cihFnfMtASFkqYMSZf/6qYrWVq6
         W2EXob8cz04zK2OC2MCUQbwY+8VuNM39XDq2kvqobKUZUEhvCgW4z4v2Lq/MVwIjWtoc
         b8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=HJowCI4wG8/H+dbje6h72gIFs/0u9CrYeRicZUF2+Ao=;
        b=ezSPcwSAauCiu62PrkASdD8MfSkyrZtjyOqLk+Wh/4p8nfOrJlhmQOFxYu4h6iABPH
         CyfsDmMIaYX7fGL1bqtS2KOaQr4IHOUaPxj5fKUSTi1qD6MwS5ZmRi3058CeZNYE/gfQ
         27j+di7KgTY9rNIcm7LcfXE1jTaNkg8etZeX9qokAuHapsuc6R+8ce+k4Y+rBaIHh1tq
         7raS6jWzNjGjr0Cl3o6Ka5+OGeLI6k5zKD1gIm4TXnyP6zv29GGqlRbn5BKCxg0FbZZx
         e8bEeE9W36k1QWkyQYIvK1KJmfKrbcXCR2krQsdSbJ8iERokuSuP0nWrar4FhKCNglF3
         I0iQ==
X-Gm-Message-State: AOAM532xYZV/sZMJpFvgU9DflDoCilgOsALWi2Hc0HgmIi3pZmIT6Cp8
        vb10GhOw3iyv6X+01Sd8EteOR4cNe8Q=
X-Google-Smtp-Source: ABdhPJwEXIQ3ARyhs53wST7XxTiEtF14yfHDA6IggXEggxKNtcC3XsdpA7XKLnHtx6PNYTwkbKvGIQ==
X-Received: by 2002:a05:6000:186a:: with SMTP id d10mr14372947wri.347.1640647444856;
        Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u12sm16287648wrf.60.2021.12.27.15.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:04 -0800 (PST)
Message-Id: <9dd53960c425ee82bd5541850f7ebc21fa8efed4.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:55 +0000
Subject: [PATCH v2 09/11] i18n: factorize "--foo outside a repository"
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

