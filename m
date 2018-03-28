Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257551F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeC1RY5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:24:57 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46338 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1RY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:24:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so1240650pfe.13
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4T85SFIzUUxs8//m+Bn7gt56Xtcm+66m/G2z2GrQWcg=;
        b=FMnWK+ln7rD/siHhsIsme4h6e6ANgfZAknCbeB2D82n0cmEORk2BlDPSRvXV/14npU
         PzdPV7xm/ZlDUKf/L33F4NPPkg2sq4x4kBB6npcpSHp4Hz2s88ocIqmQVIsRw3L/TvSH
         0aHn5lxm2zhFztOhizz2xC6eA3EbHeIbb+c90S5PprMgRI6k8xBQVbYljlZ8xnWiOiTn
         QyEdBYRiM6TZpwX6IsGzIara2SgkXiJFOsWGdWaodEFAoT3jyp44W/xmDpEIFaZkqmo0
         duxQvKeZcMtE0Eqxky3D8KzvGHw7cY7gGZW2OtIFVEbXb/Taj7yPIMWO6KsqEydhua0U
         0SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4T85SFIzUUxs8//m+Bn7gt56Xtcm+66m/G2z2GrQWcg=;
        b=a36I5m4stYZcRUc5TkkFAurd5ijK1c2KozPxc2XvGv7rdjUYF5MmVcgugUMAU7kTm4
         vRdi3SQdcgNqgI/3K8rhV/Sw4tgArLTYINorYBk1Ds0KTgGpUX5l2+rdwrDQIVbKNC7G
         DjrX4tRrdnJem8T5lWQhrfUEo6Qcz0n1u/Oyno0fDmcSboYhUJivvlDl2YY+R9OZHWV9
         JC9wYSmzl3v3ZaGR9/+S3lMkqxKit2ETRojmBt0pg9jl3sM/miktMlIRt//pSs8U4vqJ
         tinI4HyvEsJabyX8BlIbG7KJLiISvO778qe4imN6lwBu+v0bU5qi1wNuKT8F5J/wMeAH
         m4xw==
X-Gm-Message-State: AElRT7GjZUAJcwa9A0tF3RSC/hjnQzz3UhdwbIObZoLqxcVrrYSfiPJk
        7N5JrhTUoJ158ILnVuPA45uWMQ==
X-Google-Smtp-Source: AIpwx4+9Nu74bfMVUQMN84/J2y1Pfs8P9hS0fGW1vSH4uwj6AqYx4aXodS2Z3DL8/l6ybQuukv+ZoA==
X-Received: by 2002:a17:902:14cb:: with SMTP id y11-v6mr4751662plg.23.1522257895799;
        Wed, 28 Mar 2018 10:24:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v6sm8478996pfm.2.2018.03.28.10.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:24:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: [PATCH 1/6] submodule.h: drop declaration of connect_work_tree_and_git_dir
Date:   Wed, 28 Mar 2018 10:24:44 -0700
Message-Id: <20180328172449.27012-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328172449.27012-1-sbeller@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function connect_work_tree_and_git_dir is declared in both submodule.h
and dir.h, such that one of them is redundant. As the function is
implemented in dir.c, drop the declaration from submodule.h

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 9589f13127..e5526f6aaa 100644
--- a/submodule.h
+++ b/submodule.h
@@ -105,7 +105,6 @@ extern int push_unpushed_submodules(struct oid_array *commits,
 				    const char **refspec, int refspec_nr,
 				    const struct string_list *push_options,
 				    int dry_run);
-extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 /*
  * Given a submodule path (as in the index), return the repository
  * path of that submodule in 'buf'. Return -1 on error or when the
-- 
2.17.0.rc1.321.gba9d0f2565-goog

