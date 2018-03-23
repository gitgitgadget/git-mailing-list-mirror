Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47AF1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 15:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeCWP4B (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 11:56:01 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36033 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWP4A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 11:56:00 -0400
Received: by mail-lf0-f66.google.com with SMTP id z143-v6so19019347lff.3
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaFz1XnIdARnY1OWGqcSf3Dk5wi1ow+lc3PiZLOF2zE=;
        b=GlPFhFCjENksqelm/5Z0JD0D5qs5UveW7rUTHpPa/vUHrcJwjFV+cDmHa4Bbp4w50v
         QkPFo3ZCKwhpPUWGqUU3OeM1dnK1SkqOljCSZqJePWYLtIJdZWlDoLBbPqKf+gYfDVhf
         QFcJ4xFFlQIi0Tw8DHzO3XbkHZpa6aAfHpLAlpB879WWfaX5EVSSOI1D5d1jBBevyrp/
         WJe9satVb8wTQvDmHkwtMATC9Tp2QeJgFK7BWIWxPR9Hl8qXObXHtHIWt9V4Jtt3jN9P
         tGYV2gqTOuOloq9Ov8d6i4ZJ/HWtbFdvnQodSxpEzEdcVjEAsjxvxvN6RAI5o1O8jdPh
         B+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaFz1XnIdARnY1OWGqcSf3Dk5wi1ow+lc3PiZLOF2zE=;
        b=Rbst+Y7igZOzOGzo8uJFrUuvqphGSgususTyc5smglVYCGGP60yZOzeIMfUIB4F5xF
         4kNrwXPr7W1DwihBpBQQgEGkSy+15nR9uSTNq/Lr/3rWtr79ekFm5HS0btj8gx1PVCtq
         qCW+QwEsgv4TVJWv7Nae46oMCm0Ovu5gXimFNuuZxdViwlcnySArhbLKP7029FKSXOje
         pFqw3DbxPuD3n3JEfwmbAHgPhjn6zo2NTonovcfW+HgSqRpyP8HEZ6EZ+QI63sC3ruSb
         gyeUc6c4P7U/lAiOFf1ion4d66c/WQG0gNHCXmFczAPisUZKOMebzzbV467NzZMipgN7
         sBpA==
X-Gm-Message-State: AElRT7H0b5Z2c0zo4sqG+KdSYEDGFJKEmunjxGwk2WAr8HmCUSMpvHQN
        6hY/a6V6J1PUUcd4P/1hi94=
X-Google-Smtp-Source: AIpwx4/a2n36fxodT15wLblsHa+EsyuGxZxu/yRpy72K/TXe2/BGDlT/z6D3VuDFnHQufrcTvKcP+g==
X-Received: by 2002:a19:5750:: with SMTP id l77-v6mr5690614lfb.10.1521820559384;
        Fri, 23 Mar 2018 08:55:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g192-v6sm2248963lfg.86.2018.03.23.08.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 08:55:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/1] repository.h: add comment and clarify repo_set_gitdir
Date:   Fri, 23 Mar 2018 16:55:23 +0100
Message-Id: <20180323155523.22269-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323155523.22269-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323155523.22269-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument name "optional" may mislead the reader to think this
option could be NULL. But it can't be. While at there, document a bit
more about struct set_gitdir_args.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/repository.h b/repository.h
index e7127baffb..f21fd93f72 100644
--- a/repository.h
+++ b/repository.h
@@ -82,6 +82,10 @@ struct repository {
 
 extern struct repository *the_repository;
 
+/*
+ * Define a custom repository layout. Any field can be NULL, which
+ * will default back to the path according to the default layout.
+ */
 struct set_gitdir_args {
 	const char *commondir;
 	const char *object_dir;
@@ -92,7 +96,7 @@ struct set_gitdir_args {
 
 extern void repo_set_gitdir(struct repository *repo,
 			    const char *root,
-			    const struct set_gitdir_args *optional);
+			    const struct set_gitdir_args *extra_args);
 extern void repo_set_worktree(struct repository *repo, const char *path);
 extern void repo_set_hash_algo(struct repository *repo, int algo);
 extern void initialize_the_repository(void);
-- 
2.17.0.rc0.348.gd5a49e0b6f

