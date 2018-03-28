Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 819D21F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbeC1Wfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:35:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44174 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeC1Wfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:35:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id m68so1812243pfm.11
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KLwCagjSpPEUboe0YTjYrxIlGmE3Mhdcvbq+CC304mY=;
        b=wPgw0/CJ5Ju+qfMTOuGG1BCw1wBVQhQSi+LQmdq49yFXH1nfV6zlRZQTHZtqlmsI3A
         JDd3cwIdJ87vVkeHNnYj9k7UFWUqfRtNrnPBYhjEfHOpErDOB3jFpUXv/Hk8tfARc6RQ
         n1T4fmAsZZJ3BJFHbbp9Ka8PEO01AMC7ynROWiB1Ov23jh8Y3OBwa7cIGkyECLc/YX+j
         EfPZod/bg2dH8M73pnjTn7YMzZZmDybqoVJltN54V3GgW2bdaNhL2NzHKTBxDkhgXpGx
         NShO0K5yEQHoPkuAR8UulERyj9SEkf2veyBnJyDvkutfoapW/4N3qJXQCLYQGs42eKlF
         NmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KLwCagjSpPEUboe0YTjYrxIlGmE3Mhdcvbq+CC304mY=;
        b=Ix83fjdZhVqpkixvGajU2gvtny0C/N0OgY7hunWDAXa+MS+L2/TM0IdFkfGChhlDGg
         rWRchPj0WdycRCtgz50VswWSq2ftg0cCbCKqrh1ugLr0Qb0Kz0afHmVJkZJGHynutXE4
         CH4awIOyRNeMWVYj7B7nGZuNl2+4VubuA51gshtOk3t4afvcGu/dC+fYe5FVr/J+NN1r
         0rS130W5nIsCfZYl6+vFyQ6Nq4qZMtHp16PHongqTjJxQcw6AgrnjsooTo0hHPi24GSa
         wEN2zSkorv/ewGfaJuI+o5+8YpJVyfGmSco+hLQa4FGVQuWWjXEZwV7BjLLfGIsxziEz
         nkWw==
X-Gm-Message-State: AElRT7EBnJEUxleAG6v453MDLB7nNZSAFNRjZ5LeYZ7OobcmGmxdky2e
        3+irOEpnjOh5djM8qhk4qiQqMA==
X-Google-Smtp-Source: AIpwx49KG7S+xntTgROVmBojdazDLQmkJ4SwJJIXZXPps7FRIZsWdky5/oipqVHuM7goJxc41089qQ==
X-Received: by 10.98.108.69 with SMTP id h66mr4308841pfc.43.1522276536258;
        Wed, 28 Mar 2018 15:35:36 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id k70sm8377806pga.72.2018.03.28.15.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 15:35:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        hvoigt@hvoigt.net, sbeller@google.com, seanwbehan@riseup.net
Subject: [PATCHv3 1/6] submodule.h: drop declaration of connect_work_tree_and_git_dir
Date:   Wed, 28 Mar 2018 15:35:26 -0700
Message-Id: <20180328223531.241920-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <20180328223531.241920-1-sbeller@google.com>
References: <20180328105416.3add54858bac92573d7d1130@google.com>
 <20180328223531.241920-1-sbeller@google.com>
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
index b9b7ef0030..b6130e6287 100644
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

