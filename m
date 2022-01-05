Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43ADAC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 20:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbiAEUDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243815AbiAEUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 15:02:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F3C061201
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 12:02:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k18so413346wrg.11
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=fe6zN4tyHnmhQTycg3R+CPF07juxxhw1mNdBOEhgCb1lfYbSszpuomYqFbpBYavnXx
         fe5AdTAkTLpGSK3ptqU75Hjeda8biuIc9clbPd4Oc/3ChpZ7d8YHc7jF7kbUVWrKV4Yi
         L90OlfEKt3G19049cgnsIqPpnDUL1at5VVqNsj/R6c+vAYryr8BCz1hXxykQcMktBrGp
         sUfJMFcouPOVcIeQJSF5yfPjSnVUWtyRCeMdyQ1ujz4ZQ9oUQIiyCV2WsQIqL+ao1hFx
         d1MHXi6G/S4ehzrAlCW8A2iqnz2ZojngKq9hhGzRXgVo7gHVdKyBUKPGWzyCqa5Rvp24
         BT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=qOjI/PQBhs3ukI1GSIEcUbKjolPndpOYYm6yXpIlL9NKpNU1Qz1BOVQYSBceZYgpAO
         1wsOcrw7088aoJCUkVRvMyfA+rHaaUHPYPFJO3lUPDrrhD5M0ipN6B5hKjHMKwQpkpiP
         vT73+pyuGP6t/QhhUrKT3Sda4PFAZQuCiU2biTk+mXTVTC4RE6toK6dCFNfcq4okxqKe
         Zlc/SVJDugw3YIUIZY9kY7FxgUm/ZBUXEPiP1O9WonGIe2pq7XhXp78j1BqfR9DpiwqK
         Vd1rQFoTzDIgqyMCuFdnRoKAjva7AZ+7hhVUkoBVsVNWs4A+J+Ty5Cm0oxAKGQpAmURW
         ENDw==
X-Gm-Message-State: AOAM5334yRhTXtWqXsfhuV/swRMx1rAvE/QP5R8XnVkb8K93i1uOnJda
        cw7vYw9uPkDKzjqJ1ML4AM577j7L/qQ=
X-Google-Smtp-Source: ABdhPJwCLy6mEAxT01C8rmAM+FOlcA7B+4LEI8upTOpaT0Rt2FqDJAXpE/t8my34JxzCQ2EAMWxVdA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr46674011wrs.633.1641412953444;
        Wed, 05 Jan 2022 12:02:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm44107712wrs.28.2022.01.05.12.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 12:02:33 -0800 (PST)
Message-Id: <226c105559ce5f524131212076aa00b595be2492.1641412945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
References: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
        <pull.1088.v5.git.1641412944.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 20:02:23 +0000
Subject: [PATCH v5 10/11] i18n: ref-filter: factorize "%(foo) atom used
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

