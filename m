Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B2AC433FE
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 06:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiCSGVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 02:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242252AbiCSGUz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 02:20:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83B9729A
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mz9-20020a17090b378900b001c657559290so9719042pjb.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 23:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdAV1jxgRUDhKFWAFHc9zRhVZngoKKmdhXK71QcIHC0=;
        b=eapLqWCKxvqzMCHhqQYA+5sytwHcDRvPnesygpjI2Jy04pCiK3ozLJh67r1Ro+FCEK
         RowRQgIzmIlzKcPJM/aKFUIKVcmPs3iquHuyWB1fXh1OF7QOQuAeOOmySvvy4Bul4oak
         jmow4+5W+FozHc4Z4WW9kkRbqC9TQAEahPVKKgykM5TBodINqRFRiIOlKLYVlB94OaeV
         6gDuh8X2CmIVGBr1ST0tpNwohSVuH6Y8XjHdDcg0GQfGlOuVmLyNHBliEtZrbp3KWQZW
         sgLCwxxjo+SKRItakPIZPz5rY47cdT6AuZggpj1G+YqVXSZZt+QyezjhzA0fProYjls0
         RS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdAV1jxgRUDhKFWAFHc9zRhVZngoKKmdhXK71QcIHC0=;
        b=JJtNRf9DzHrqnsNWkgTfKItmpRKW/I1yTE8GR2yT4B/k1yMj4v6RjW1tCsX8nICru9
         Gk+Lpx40eVQ2e/GLDp6Oh+Qgf2FnLQZRrOeAJxeQ9GGrml6rQkwyhg4VMqOju+fO8cvb
         bmNNxnbrHOnyLHxqZ2UjO10jehMnnacKItx4bcQg3dozs3awrmwQMFsYa/BC0SixWrUt
         TLnt4R+YbjF8XrvshNOXloiNOzWRW9xHmZFPQC1PPL8PB6bAxyZgSfSkAQAtLWQkwemq
         HSVWEhVHbigJheyPK1sON2QMeaoTIixqVtWBAGwCNYotNFaveB7RXCAOIKog5zJHrQMh
         pq0w==
X-Gm-Message-State: AOAM5330q4GiQRpUMQ/QSqtxqFxpuESwBaI+mOodKK/YNOqiOUgRmMIh
        wetPtvQr3AKSarQEqFnXsKY=
X-Google-Smtp-Source: ABdhPJxKfjimbhh83FJP3NjVxjOnueMIxgvyzUiJsleKSGKQvTcJUg83XoDtIuRAYNiwX3wCH5s0RQ==
X-Received: by 2002:a17:90b:4c8e:b0:1c6:8dfb:3cb6 with SMTP id my14-20020a17090b4c8e00b001c68dfb3cb6mr12045726pjb.72.1647670774357;
        Fri, 18 Mar 2022 23:19:34 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.152.89])
        by smtp.gmail.com with ESMTPSA id b2-20020a639302000000b003808dc4e133sm9235950pge.81.2022.03.18.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 23:19:34 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     gitster@pobox.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v5 4/4] Documentation/git-sparse-checkout.txt: some reword and modifications
Date:   Sat, 19 Mar 2022 14:19:10 +0800
Message-Id: <20220319061910.786850-5-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
 <20220319061910.786850-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Modifications suggested by Junio [1]

* remove redundant part under 'add' command
* fix broken indentation
* remove redundant part under '--[no-]cone' option

[1] https://lore.kernel.org/git/xmqqfsnfb42c.fsf@gitster.g/

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 0178d63f56..482ecfe28c 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -66,11 +66,9 @@ file. See linkgit:git-worktree[1] and the documentation of
 
 'add'::
 	Update the sparse-checkout file to include additional directories
-	(in cone mode) or patterns (in non-cone mode).  By default, these
-	directories or patterns are read from the command-line arguments.
-  These directories or patterns are interpreted the same way as stated
-  above in `set` command, and they can be read from stdin using the
-  `--stdin` option.
+	(in cone mode) or patterns (in non-cone mode). By default, these
+	directories or patterns are read from the command-line arguments,
+	but they can be read from stdin using the `--stdin` option.
 
 'reapply'::
 	Reapply the sparsity pattern rules to paths in the working tree.
@@ -112,10 +110,6 @@ OPTIONS
 '--[no-]cone'::
 	Use with the `set` and `reapply` commands.
 	Specify using cone mode or not. The default is to use cone mode.
-+
-For the `set` command, the option to use cone mode or not changes
-the interpretation of the remaining arguments to either be a list
-of directories or a list of patterns.
 
 '--[no-]sparse-index'::
 	Use with the `set` and `reapply` commands.
-- 
2.35.1

