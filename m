Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657D7C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiCaSwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbiCaSvy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:51:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D616F6FB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j18so1036330wrd.6
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WPpANUWFRgXIb3oDOZk37EOayhXJtam8+1zzZzqOzRY=;
        b=ZPrHilYACx8BGgJTrDyAB3xkfNh1rkrT123o73bhJx9fAFYPNUx/NxBM6ynNKmxYFL
         IXv5RW/Ixgz7zh06Z7rM6mZZR4Z/p5bciGP5jxh5JJAMI1mfHIRdymPAFZ9koFzY35ov
         4s7vYYA3XJrMBwzgIMiSJCm2UojhJdR+uUdR559raR70hDtkcwpQ5eex5NO2jJjp5Joo
         lykArJwqfD+8zBXEsxe52AFBSYA8YkYJikKWZQTDKbhkAnDYSPRgD5nlL4T3BZ+k49wg
         vkgTkylObnSQDzCTY8sWvIgjRMyFLRgDNiIYLIJIqmSHHJ+ulNNdw1NZ4HNfG+6rbV6N
         FPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WPpANUWFRgXIb3oDOZk37EOayhXJtam8+1zzZzqOzRY=;
        b=FMkpwjIcNbLcBl71wq4vImdciCeW8NDjUpgw8RA/4dH4Xjomk5wudWz0Vhy/bRNYMg
         XvBodedlK53QNY+d0TVd7Kjy3JWG3E1oZDDyfdXx+bE7BTYK/bDqTmNBLj0cn2v6UiRd
         E/zRzFcpZjMb5cQmyL6C2N+4g+iDiBFqeu+JWPazxglzYHlYLrbY8iSvdS1cpZO2nO7I
         pt3NMBzCRgbj68iGypz27K1dK0XcgsTmp2lD54LAW1c343KD+qG11b8X41Rr1LP3VVCo
         8vXTJjDHRU32shtP2YNjNc0ui3haut/BOEuFOYDERtq/IKkywWVtqlB3xbuhYW0wex6g
         sxVw==
X-Gm-Message-State: AOAM532XDIDNvm5NrXBpsCGceXcZT2gv3gJdxt84S5evCN15xAtLVhuS
        Ma1fxGHhXYgw7Otn7p5ctEJE09FVvcA=
X-Google-Smtp-Source: ABdhPJyMC5zNTzLWjer+S+0MNnf+opkpGaH6qCPUV+vGufCUKwJLW2JKIF09pPiwNoRI+yu0XtepNA==
X-Received: by 2002:a5d:6d8a:0:b0:204:8aa:309f with SMTP id l10-20020a5d6d8a000000b0020408aa309fmr5041255wrs.38.1648752604692;
        Thu, 31 Mar 2022 11:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b0038d0d8f67e5sm8157992wms.16.2022.03.31.11.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:50:04 -0700 (PDT)
Message-Id: <74b839bfc4e9503f8b2c62aeab44ba5c07f09f0c.1648752601.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
References: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
        <pull.1190.v2.git.1648752601.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 18:49:59 +0000
Subject: [PATCH v2 2/4] branch: give submodule updating advice before exit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Fix a bug where "hint:" was printed _before_ "fatal:" (instead of the
other way around).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index aac24591d22..1252b17b980 100644
--- a/branch.c
+++ b/branch.c
@@ -607,11 +607,13 @@ void create_branches_recursively(struct repository *r, const char *name,
 	 */
 	for (i = 0; i < submodule_entry_list.entry_nr; i++) {
 		if (submodule_entry_list.entries[i].repo == NULL) {
+			int code = die_message(
+				_("submodule '%s': unable to find submodule"),
+				submodule_entry_list.entries[i].submodule->name);
 			if (advice_enabled(ADVICE_SUBMODULES_NOT_UPDATED))
 				advise(_("You may try updating the submodules using 'git checkout %s && git submodule update --init'"),
 				       start_commitish);
-			die(_("submodule '%s': unable to find submodule"),
-			    submodule_entry_list.entries[i].submodule->name);
+			exit(code);
 		}
 
 		if (submodule_create_branch(
-- 
gitgitgadget

