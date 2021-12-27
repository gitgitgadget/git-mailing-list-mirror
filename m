Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A0C433F5
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhL0XYQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhL0XYH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E750EC061759
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so5777228wmb.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=U6SRImApnNntTfJ4KViCZdsY5rAPbJ7ZMN0rLZUYb1cNtXcQ2jvvFmqW0yu2pz2Xx6
         hRJmVjQafJZr/ASuM89rLkxhU58m86r93beQtp5cZdghgMkAPgruraKcSd1OA0yL/mqP
         SsIB9wnOEiK+sFxQgoyRGiZUXj2jW5N3xn8wzJgrubAzsyXi7DjK8KgSDPw0ul4zzQZT
         k++usNIpjhqrHVnyGEuBwBJddKU/etDc0YkPG2Kl/dllYgNQs6OCnhCnGWz3Ia4t7FuJ
         IIFr7r1JP95y3dQZD0bccIXBiAiuoWngWFjd5Tjy9tRXwa9m0iVRAVYdrGYWqvcKjNmR
         VCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rP4kEq8FF2OINWVr/x+I8nI+cifT9FovCOINQK1WOY0=;
        b=KfKSbeCDxVSM9nIO/x2ukIHJDdCSh93bgc3aDAM8DUGvXSCYxd+VOWknYPvogriTyz
         QcbPnL7ZyKloHqjcwGzh1GLKbgxavY68bLHTwnpQkA66XtphFXzCjkice8RxMMMwR+wX
         6gCTgDAQ7FeMWydxBHA9dnjlK6a0KII3yAz0DEziLiz2kONab4zEAsT0Q+cZEHj7pYrV
         zHgZbx22tCEsdwceswqY01vZu9qInN2VjkJ8aZOWIEPkHRhEROwczPy65nSmhMC2Dmne
         qClv29YjO3nVfQ2J89P3Fy7lIF7xEs+6nMAsAfl9svJVrYN8R7WmDPq5KioycNmJ5PDm
         u29Q==
X-Gm-Message-State: AOAM531Egsp3qCuWZLGoPZqg+f2vCMsC7C7XJlo0p4Sz9ivrBvcQfU2a
        RWe0lGZuM9HcB/fSuzS8YhVpauvWNoA=
X-Google-Smtp-Source: ABdhPJwYbIcHIRFB791hqda3XB3t4ufdqU3AjNWBUsYma7MkiZPBmOMf6wv9pWSF8aRTJVXJx7jZQw==
X-Received: by 2002:a05:600c:4f8d:: with SMTP id n13mr14677050wmq.43.1640647445458;
        Mon, 27 Dec 2021 15:24:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm15671552wrb.2.2021.12.27.15.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:05 -0800 (PST)
Message-Id: <a575f566f2a7a852473516c8f705ee6e8a74fbe7.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:56 +0000
Subject: [PATCH v2 10/11] i18n: ref-filter: factorize "%(foo) atom used
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

