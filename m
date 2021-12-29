Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FFFC433EF
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhL2Sz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhL2SzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A33C061748
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so6492480wme.2
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=KU0T6fQHjC2g/2QjI/45PQQ+Trq6waD0iuiSVGPVewHt13GJBnkf9g9WH/vu8JHqJY
         natsNnO8wHix7LAzRA33uyxhfatwyX/LcRDhZFAcBSDK9ukIhll9T0P1Dd36F7ruECYA
         XN71L2EiDwK0VUSVYBquZDuONeRma1sPvYxml6CfoJSdsY+FrNRIJ8XRSJtfzVOtlSih
         DTldUPz7dor2ACpUPHp6bNETRYSvOTNYOKoh/SW6HmxV6unerivpOiOIGK4ETI+iS9Oj
         AVVKZEzDizSG8qZqS07StICPOrGK7cT8LRLRSzOgzB45HUqas9N8gt4H/9pCSwsPKLTn
         SOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=Y3U7e4EZ9p2dJ4H0eD7xJ8DwfdeQSbvTfsjrNbjnQg5Ik+OcXOFMy5/GqAmXHtCudE
         vnUd5RdRR9usYiI1box/xYMcv5eIsBSLNjTLPurMXz0MMCk45/w/gNoAg9qXvLRfsHbJ
         5vAXnnFQhRMmekQJHOfyG/VOqNDLIHWLAVjMCqUTS11a8bVQ+XZYm6iwnX4Y5GrqpoHp
         p3w2leGntw+TtZWYuzCot2Ec/CHjS8ss86VP4LJzPxPp5+snDdjMKwJ76kw5Mi5YUW38
         5qRL5VixVzcci1Ah9JeffyuH1c/g+GI7zyOlrWcnnxqgmFRp4GWV3DYhQqLWmR0tKl++
         dH4A==
X-Gm-Message-State: AOAM532LY7b/7GNTJOjUG63xYudVnnDAV08Hy3eGUaBQAqLrw5sqPQrR
        9/t9q6649qh3yIvPST9QxXTo5gyeTI8=
X-Google-Smtp-Source: ABdhPJxH14JKVTMbMSLA3oe5oMgOPZW/z4h5kP6F4W3El/trHJHlPABQuzcH8lVCDuJNtMVzxy6nEQ==
X-Received: by 2002:a7b:c087:: with SMTP id r7mr23287969wmh.17.1640804115884;
        Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o38sm20373876wms.11.2021.12.29.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Message-Id: <03a880d534b50ab1a6c2e45746c75806ff6e9f4c.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:06 +0000
Subject: [PATCH v3 10/11] i18n: ref-filter: factorize "%(foo) atom used
 without %(bar) atom"
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

