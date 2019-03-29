Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4886020248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfC2Kl3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42506 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfC2Kl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id r15so864770pfn.9
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fB3GdUCe4re/mq5s9vsQLHvelWqepPdXm9M22/8KGt8=;
        b=rG4U9BfceUbXr3+/3vnDK85R9Nvk4yrx1t2kiSNdKeuX4LhArs+bbf+Rpz06ADyJgA
         xpBfFeb2XyYup07h+ylAYtG+lDQIL0+Su7PDEp+wlje1kWAbjhVevOGzGgO9DwrMLRfP
         vfgGXbdlZDQ7aMJiNwE7ctgz1/T5flk8tUPIW9nh8+/UwpzuKyYKlTD4MsVgMVBSKaAc
         qwPg4M84yD18azitWlBZUPELFClyAAv0UmD/kXV3r493mU2d/HDial5dtYPxkVR6329e
         UrRGTwW1gqZmOzEaQdTdBXFPslkxk3QpikQDqhGCNvEKZQz/c3c4yR9klbArMCCC7IoN
         vOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fB3GdUCe4re/mq5s9vsQLHvelWqepPdXm9M22/8KGt8=;
        b=gRsC8OOo8sxNLQPICg74IuC90F/KG5bxeW6G85oe46liXGQMTiQ+rehYB/qs1zHwAD
         ZhueMt0e7j2pbEBsgMEG3iSpHTRMSSgkuyyRW+ag8qZRCWyKN+m08NCOq4yNBKVflhaf
         LHc2vGtCmP7MMc6JKThRBQ81e1t51Q5+wBiINuH4Bsd99L2y8SsyubfzWhkNuPAVC5Sy
         GYknc5InRUz+d58QYwOFF6d5eSD19a7aJmhSFFv2Gy2xx5lCrqM3HYXTpVi4oDnMhEr6
         isFi6MjPavCz7J87C5VNTF7CLjYbKxRlAbH2FcWpH6Kfsal/Xkfv5aDVEtK8qNhpkwTr
         lCsQ==
X-Gm-Message-State: APjAAAXHeDqk65cpspdzDUOZHEuKxzBmQ4Mr6YGNFikxlpWQs8WJ8Ie6
        +GbC/fePt3lFcOtLf7VW1CfewEQG
X-Google-Smtp-Source: APXvYqwX1qoR9djqEZDd39FIqydPTXtwNU9Wp8W+geOuJEqWuk1i1T8Ulhm/PqF1r9Vqh7kb/RjpCA==
X-Received: by 2002:a63:ff66:: with SMTP id s38mr42466799pgk.120.1553856088342;
        Fri, 29 Mar 2019 03:41:28 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id i189sm2441050pfc.71.2019.03.29.03.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 16/27] switch: remove -l
Date:   Fri, 29 Mar 2019 17:39:08 +0700
Message-Id: <20190329103919.15642-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is ancient. Nowadays reflog is enabled by default and
automatically created for new branches. Keep it in git-checkout only.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6d0b2ef565..d63116b686 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1376,7 +1376,6 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
@@ -1579,6 +1578,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_END()
 	};
 	int ret;
-- 
2.21.0.479.g47ac719cd3

