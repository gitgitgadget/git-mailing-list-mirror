Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB5ED211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 02:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfALCOZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 21:14:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36612 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfALCOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 21:14:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so7069031pgm.3
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 18:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3XJww+mjn2ekowxHM8wGMtE76Q7IY3qj021KCmxoEqM=;
        b=pjsh8CqGWRj4mBLL26uLewm/RyJGdbQNoLuap7TgguyXT8jWrsnveO0srxGdb0MLtv
         a7jFrBRkE+3X/FmX8b4+IWf7zIvpgQQzQqBjOzwJDQhhd3fezIdW/Y1RlhU4aeWuXf2y
         pFIrYdQlW1TB8GN2cKd811itro3N/ZSSChgeR99+seAkNOBb/J1jiFXtGZeFJRo7gnR+
         kXtI/c6ZKmOEJea+/ktqQtic4Vq4raAr20JNhgdXrNeQQTMtxDuP+MW4WnouXKQhB7Pz
         neAIHQXgW/qhgq76gay6t9Uh+5b42Ox3/KVcV3OaxZkGAqH4Jn+m8eQe7fA5jwVVckcy
         jY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XJww+mjn2ekowxHM8wGMtE76Q7IY3qj021KCmxoEqM=;
        b=mv9d1wVjh1uAoUTMQVigR90QzgJl/wl7Pk6o+ZTs7F/YlwObksBCkkVbuHt6+7oOs3
         SUh4r9iy8gdTwVsK1V5NY5NB741NfsZKrU/eJDGNeH63ia02hqxTLTVoJGiu+f/8m716
         Nb/udiNlby8ErL1z/09I64QOEXYeb5xswBS8QJsqh3wsRs5zBQcnjGWAP3gPI4iJxBKi
         89gdxQB6IPiVdulvjKkp4h0xhf6dl+83Sh70IPXRDx/zN/gtNrr2iOm05F/7y6AXwU4f
         5bCFioUtjH3wr7EjTMfLaJUyWC2b5ysiVHxoulZGBd+KUq+8aDXOeXVLpsiXTLJeiaHP
         u2Zg==
X-Gm-Message-State: AJcUukdoSZFBxVIBnZX2hoGdHepnzES5+nIGLXhPUvXWjtLX18pT5zdJ
        aF2UftEXB+lX5MZjkZhva92fmyEv
X-Google-Smtp-Source: ALg8bN7bCI0zeMS+7T1dfLW8/11OTPvJHd4FXIqb/9CxtspaxyqpIGjnhFScemsZqvpRq2PDi2MHxQ==
X-Received: by 2002:a63:920a:: with SMTP id o10mr15013949pgd.141.1547259264774;
        Fri, 11 Jan 2019 18:14:24 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id v72sm65180110pfd.163.2019.01.11.18.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 18:14:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Jan 2019 09:14:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/11] checkout: avoid the_index when possible
Date:   Sat, 12 Jan 2019 09:13:25 +0700
Message-Id: <20190112021332.11066-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190112021332.11066-1-pclouds@gmail.com>
References: <20190105055153.3256-1-pclouds@gmail.com>
 <20190112021332.11066-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 08b0ac48f3..1b672a9fd9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -284,7 +284,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		return run_add_interactive(revision, "--patch=checkout",
 					   &opts->pathspec);
 
-	hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
 	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("index file corrupt"));
 
-- 
2.20.0.482.g66447595a7

