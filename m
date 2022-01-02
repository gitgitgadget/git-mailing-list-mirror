Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF8DC433F5
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiABRQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiABRP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54196C06179B
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:58 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so11537920wme.2
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=J3uAF9cFwlUV63LKN4RwgmUvGUhV+wH0Yg1DIJS6rh2jjcnUXDXZ+9AB8iqTAAcN9W
         ASrQfmoaQOmq3TqoLDh58yMpb9dJ/WBQwav2bfjy+UWpvq/p47d9u7CURHleE3BfDF/m
         3EDgPFrx8L934QHv8MNexC76U0aEB0RnN0G0L4H+iw+ZclwkOa9OZ5JAr7c3tBCFSVYC
         aqgxL4xChR5yTQQVoIXkzGFTZjOWXzsq9gL+2krd1RbEy38sO188mZO/mZ6RnptTy+Zn
         kpi1oCbKpP2wtNFPZEtq3CUZHTWUTHApvmLmeVX2sA9soL9WHS6ibHI/9+gYJiL18RRv
         /OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=q02nQgpfgBwzJxoE/tGbRnoI14YQzTPYA3z1EQ7WLYr9VjBBz/oadxm1opj2yhDwxo
         sOxCOGVThsaxmjPabV6wyihnG0wmHGdbQhpIcge/CnTog/DALUyWHHNoDbiurADNJSla
         fzVgeeUJye2RTpCtIeaYOCZQBXyuGOBQq0urSrueDPvD/zABCUvbNXXY/uXP2D7lPVAh
         oYmfUW/pVIk3BizEihq8k7ysN74NvgLZKsB1Ar46HCbcGAQLIqHMwGhfhG5wDoetZIgu
         z6ubOI5/51EdCfkbeafQHVwSQz81vz2YVXpdWbA8JVGOYHp/vOJwwczHo0J1RYHt/kmR
         CtoA==
X-Gm-Message-State: AOAM531V6NZ2yIqtzYzBqY6n1rpjvQi7Ka98B+32vcbOBoFepbhp5zmj
        JwJjswdWEVL3Ys6wNykKSNNBPWEr6/Q=
X-Google-Smtp-Source: ABdhPJwzA4xyRkmMckmbQmP8auz0AmvgkHA/KO8hGosdC1dTQlhl822ql9S1ugk+nnvXChBU8d59Hw==
X-Received: by 2002:a05:600c:3ca1:: with SMTP id bg33mr36392033wmb.80.1641143756837;
        Sun, 02 Jan 2022 09:15:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6sm37276698wmq.6.2022.01.02.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:56 -0800 (PST)
Message-Id: <c6161bc3f1a3cfb4c4dea1d0260da00cc1324f03.1641143746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
        <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:44 +0000
Subject: [PATCH v4 10/11] i18n: ref-filter: factorize "%(foo) atom used
 without %(bar) atom"
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
 ref-filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index adbcc680812..f7a2f17bfd9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -841,7 +841,7 @@ static void if_then_else_handler(struct ref_formatting_stack **stack)
 	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
 
 	if (!if_then_else->then_atom_seen)
-		die(_("format: %%(if) atom used without a %%(then) atom"));
+		die(_("format: %%(%s) atom used without a %%(%s) atom"), "if", "then");
 
 	if (if_then_else->else_atom_seen) {
 		/*
@@ -907,7 +907,7 @@ static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	if (cur->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)cur->at_end_data;
 	if (!if_then_else)
-		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used without an %%(if) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "then", "if");
 	if (if_then_else->then_atom_seen)
 		return strbuf_addf_ret(err, -1, _("format: %%(then) atom used more than once"));
 	if (if_then_else->else_atom_seen)
@@ -943,9 +943,9 @@ static int else_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	if (prev->at_end == if_then_else_handler)
 		if_then_else = (struct if_then_else *)prev->at_end_data;
 	if (!if_then_else)
-		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used without an %%(if) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "else", "if");
 	if (!if_then_else->then_atom_seen)
-		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used without a %%(then) atom"));
+		return strbuf_addf_ret(err, -1, _("format: %%(%s) atom used without a %%(%s) atom"), "else", "then");
 	if (if_then_else->else_atom_seen)
 		return strbuf_addf_ret(err, -1, _("format: %%(else) atom used more than once"));
 	if_then_else->else_atom_seen = 1;
-- 
gitgitgadget

