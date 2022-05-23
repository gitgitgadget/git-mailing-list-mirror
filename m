Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD46EC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiEWUNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiEWUNq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DCA2072
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:05 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so4267671wrg.12
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=nZ3mJnlbNB8UFUDi/8TsnSbIkVS9IUBMaq91pQwDfAJghZmNEz78eyvLKZezttx5Vh
         sJlDjW+JA+13dZvAxEXJI2bLDogarsn/xJQAEochYC+IPUw7xcaBFo/f0ULG1LFDSQXF
         VVBGkdfx1hWv4dFhrawzsof2DoFu5/zpuJE/k3Z+rlFi+/D1BRkbb+uas7qSU+9jqoiZ
         7123ke3c6J/fWMe8h8NT3J95OynTrABQFrzW3jc+F5yqbUbwdz0o2ytv8DDCZU+GHc8a
         MLy33NBXnBadr/3HMUD7HhcVCvo5fDNZZHJkWapz5+6wQej5JFey+B55JzaWr9sspiP7
         TTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JW5/RT2bZpq4NBqwKIrDN6AyPlqs0iGhc4xOjJM6ksI=;
        b=YLhrNn75R2zISTRWzjSl7N0FqXmNMdrnnejI19dy0f7GalCYx33oPxjWRs5W4UrfYD
         M0RBmv5b74ZzX9u2ntzyyQZdOrg5RwpRKSIwR1UKuN6zAOIRSRsfmytoyjuBMex8OlGk
         k3rRqt8EYWC/6n197q6vljkkrdFv/NCI9S39a0EI8EfM3HyFpsWmhTmj6COTFyHZX0fM
         MUFvlKIokUlInBW8QPqqt/LNt10EgjeFFE220k97qny1YX1u1gOGHcfXaAR+IUeJT9oH
         9WKOKeohkrqbJjkI5CB5k1hAZTP7tS9W5QNNxhspzwDcAEeI27j18CYKyZuErlllSjkn
         NezA==
X-Gm-Message-State: AOAM5316fbi6kgcaaUkz7AiM7nsqMqS3nRSsQ8hauEKUW7tlrD+mF7wz
        AxlZNtiibr4pnRXpYJsQ78CEhT+nkJk=
X-Google-Smtp-Source: ABdhPJxeVCaFZx9Xurtak5m8tOBi/1cp0MI0ykqYQbohyKizEJMvTcTqSgxyECKfcpJDf2C+hckLiA==
X-Received: by 2002:a05:6000:1a89:b0:20f:d0b7:ba98 with SMTP id f9-20020a0560001a8900b0020fd0b7ba98mr8479983wry.208.1653336783514;
        Mon, 23 May 2022 13:13:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adfc5c2000000b0020fcd1704a4sm7113261wrg.61.2022.05.23.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:02 -0700 (PDT)
Message-Id: <aaff000cecb43550e0974bfda117e1c065ab8203.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:26 +0000
Subject: [PATCH v7 11/30] unpack-trees: initialize fsmonitor_has_run_once in
 o->result
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Initialize `o->result.fsmonitor_has_run_once` based upon value
in `o->src_index->fsmonitor_has_run_once` to prevent a second
fsmonitor query during the tree traversal and possibly getting
a skewed view of the working directory.

The checkout code has already talked to the fsmonitor and the
traversal is updating the index as it traverses, so there is
no need to query the fsmonitor.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 unpack-trees.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3a..888cff81f9c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1772,6 +1772,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	o->result.fsmonitor_last_update =
 		xstrdup_or_null(o->src_index->fsmonitor_last_update);
+	o->result.fsmonitor_has_run_once = o->src_index->fsmonitor_has_run_once;
 
 	/*
 	 * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
-- 
gitgitgadget

