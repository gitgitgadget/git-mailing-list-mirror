Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2378C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378799AbhLCHFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378750AbhLCHFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:24 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C453C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:02:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so1530058wmq.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=XZyz9Qqvb+s7RBAh8LCpOU5OHAyNYHhDzL+R9o/OFeE=;
        b=OOFB+eztlRQNl4ILBYZ2p4Qq56enqCg+Vz1SN1/NGCByIk2U5y7H/i682edViE9+yP
         NFtC+Kl6v+SK4NJMZHEUFkIq3OgnX0y7c865EpcgLX6nMpklvT56bvXmM+229YDbPtKI
         /V5TSh5D+fQF5+z4ro82AuqRttznyi1dfC2KcutjfbA+u6W+rUjimgUQm4l81s/+/PaO
         k8QjSID1W2tURLG6ul0yAHpWgIDiClcZ57wHAomifZtwkY1Ruifxsgm3UmW9VkeJi3cP
         4ez/gOpUV1TFoQuypk0CUjLKAgtSdp0rswTAaN55RYfQ41H4GOAsQb6KuDBmkQ0iMvDQ
         ejtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=XZyz9Qqvb+s7RBAh8LCpOU5OHAyNYHhDzL+R9o/OFeE=;
        b=y+2gpR/Ly9J7zkW7I85+tKK4Fq6ln25RVFQQ9E/Dbn4T0pkHY2FGM2WBHTB7i4Gbqu
         AatV12ZQkSSwSEwkd/5DmeovFrvahhDoczYd2Bhhu2HqDMrwWBtI5EIxY8ATjpBWnews
         zWqF29HQPeqE6hCvJ4Arz+A4ZLpTxIfVhgSb6qTQL39NzW31TjgR3rkiQTCeNoto2y6r
         4P+CL+8WxIWHxJEm/C5oBqtKL3+5DwXkniJJPszUJGY/VNdLfJ+RTxg8MDG8rfFCH7Ay
         tuLpczXEPdiyqEZNcNjTIKVB1C5AFgUFLNh6EPe+3NSxyny5mRnllEHXu3E+ob4nU3lD
         80mQ==
X-Gm-Message-State: AOAM531QRizztpiLvlK1uguj5j97uwyzTMTpdeUqlWqWGZam9Xgy8oKB
        jsJXlyn569PeH5mUyhLK1mXBnXH+pjc=
X-Google-Smtp-Source: ABdhPJwz6Iz9YlJLAe2KrV1DRbxlF7Sb1X2G0HDiIlPo9yct0MnJErY9a/1aIH9PmxmsMObIH8eYvA==
X-Received: by 2002:a1c:98ca:: with SMTP id a193mr12991762wme.162.1638514919504;
        Thu, 02 Dec 2021 23:01:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t127sm4262449wma.9.2021.12.02.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:59 -0800 (PST)
Message-Id: <6196bccf086251a390c039b18b4f88fdb9e59dea.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:48 +0000
Subject: [PATCH 09/10] i18n: factorize "--foo outside a repository"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
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
index fefec23f1ec..13b9abafe9d 100644
--- a/apply.c
+++ b/apply.c
@@ -136,7 +136,7 @@ int check_apply_state(struct apply_state *state, int force_apply)
 		return error(_("%s and %s are mutually exclusive"),"--reject",  "--3way");
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

