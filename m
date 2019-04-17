Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7337620248
	for <e@80x24.org>; Wed, 17 Apr 2019 14:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbfDQOdH (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 10:33:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55290 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbfDQOdG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 10:33:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so3655181wml.4
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=21Qog8pZirIkeGAb1gZg7FJQ0I7Py6Ff4WG4LddQpFk=;
        b=p9JQlHgSzNR/efQOd0CEKN5FudZIzyl8SgbBhHqnLlVwBLKxkbx/Kgzhc5fseTGIHG
         0wqM8IN/aTCQhkfw7N3l6wHlFd/e5CxYL1+7Pbjz4Ezw/XllW5ks5bU+qkZyjNuFbx9F
         2T5mwdeMew2x+BjIcSWddFd/i+DL2rMRPvcHYMd3aQ6YJZpX6stCpYzye/QQbBSBuO8h
         KCiF7Yus/t2bBRKMdeQ28HZPMDhh3Xp57lKV37nImSnR/sPccl2u+r5DeaN7uo8jXguj
         jXH4naNdKb8QncfIo3XWHj2LIo5h9tJV0WlUR/3ECTaMGPIUMRAQYb4TsacTPCNPRC5S
         0L9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=21Qog8pZirIkeGAb1gZg7FJQ0I7Py6Ff4WG4LddQpFk=;
        b=ZmbYmcERhL1c8IqaATtsrRuSQZAFeVoQnknGon3H/RxptP+8Wp5bzz4TAM9eYYN+DY
         lGvOxjkBJZghv2PJohTEuiYruDOLyb7NH8mz/F7ENi/yY1dJGPyW09BdOUtTfISsAM2Z
         EInBkpNS8228GdmUs3NjIC5tN3MkiQRbCAB97mKzm8yAtAhlm2dJDAioP6kZhykQQH1M
         7DA2OTmLspZhnSYNVz0X1rdRzSf+vkFqFoLADmDiQY/7w5vDdWo+6YfSx5cRn/pnp+Qc
         q+8w9mGUOwfOOGJbhY0i920nF1Rfp8p9x21i/WBOpfKcI29R8P6vooi0Fmhmw1cEpuV2
         zktw==
X-Gm-Message-State: APjAAAVbG41s6mxBdehqXnR7s2xkRsme/mmosUnAu+JAshbNC6+ALLJX
        GARaN+6dpkOy4fzKyCA+TshPlb9Kans=
X-Google-Smtp-Source: APXvYqwUY2C3pz51L5PV+xmxF3qZ1Q3aFvTkZ77u9IgmDVECq7M8K3VSWyIc9WJE7EWGw/qfZcsvxQ==
X-Received: by 2002:a1c:9c03:: with SMTP id f3mr32593362wme.67.1555511584353;
        Wed, 17 Apr 2019 07:33:04 -0700 (PDT)
Received: from localhost.localdomain (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id t17sm52127726wrr.26.2019.04.17.07.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 07:33:03 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 06/12] rebase -i: remove duplication
Date:   Wed, 17 Apr 2019 15:30:38 +0100
Message-Id: <20190417143044.17655-7-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190417143044.17655-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
 <20190417143044.17655-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

path_state_dir() and merge_dir() refer to the same path so remove one of
them.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 57a3c9caf1..610b67827b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -37,7 +37,6 @@ static char const * const builtin_rebase_usage[] = {
 	NULL
 };
 
-static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
 static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
 static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
 static GIT_PATH_FUNC(apply_dir, "rebase-apply")
@@ -182,8 +181,8 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 {
 	FILE *interactive;
 
-	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
-		return error_errno(_("could not create temporary %s"), path_state_dir());
+	if (!is_directory(merge_dir()) && mkdir_in_gitdir(merge_dir()))
+		return error_errno(_("could not create temporary %s"), merge_dir());
 
 	delete_reflog("REBASE_HEAD");
 
-- 
2.21.0

