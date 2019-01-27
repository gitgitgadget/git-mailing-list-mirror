Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523CD1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfA0AhN (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:37:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33400 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfA0AhN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:37:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so5700698pgu.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7/yffbZEYRhL1j5hnz2u6xv+0/q5E6LNrZ0OYhcoug=;
        b=b+zhc68nrODG+cv5inSwWYKPEyMLIDXMQeYmSfVi1V3Wz4xF0B8G+1Kz+u7I9Kt4pS
         wEl4XDYfd6NX6nIahms1FnTqu9vL9EFPyD8uABubTaQFNdQcVL6rKM3QRP1ql16XPlzG
         ZtShaYqZsoc0/+BMf/OwRO9TnICYTgEPnGJyAhL0sOReiaKq0ofsrnltGnquZCrfS/LA
         W9aVZBRNakl3Wu2T0F4qfW2p35ombEd4ZRhf01d5JJ7133CppHyJuPRU/CiT19auYL9+
         JUi1pvIh0qVutyyoaXfiGx+DcuhuP/H5nccbK36EHFKxOpS6o0/PiveDuZpToG2ILKbh
         byUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7/yffbZEYRhL1j5hnz2u6xv+0/q5E6LNrZ0OYhcoug=;
        b=VQvoNZ9UQxW1aZW62+qQxlnMhd5uHAtpq4Y/bjv1eMAsOlCHG88I0UkoXxuhSHI41C
         7lVTMCv7R5ZOZgeZZVtZKQuP4ff+nkwDHCOIpWBZL4LvWWfo9urXtsKpt/ateRTR+0UK
         leL3QT0nRPvjY8RHq48onBtUTbkUcoAt0QUwemLOlmPleR1m/Rh9hST8vxzKSGmAkvvm
         0BTiE+PGEqP0KZF6fT1sOeK8eemgoqr9ByXz9eZ0cvP8/1r8NbQlmlDBvtgFXmn5lkt7
         K1054IgRtIG4x80U9eEjgSHY3PvHN69ASeWtTINMNGiUK4LbIxsFxviNbQqGw9l7EdIx
         s69Q==
X-Gm-Message-State: AJcUukfsST4BI8O5knKWWpgEAIeVKBGAXawGby6zliVHU88UIRw+lKwZ
        IZFd7tfvQczOiqzLlXBYXIlXWIt0
X-Google-Smtp-Source: ALg8bN5rBUQlSnrQEC3d6PvuXGqjAqW+CLFCfU5S75H1jnwhZqYfGadS21UgyA4O6VMGF49RgclBDw==
X-Received: by 2002:a63:da14:: with SMTP id c20mr14266784pgh.233.1548549432163;
        Sat, 26 Jan 2019 16:37:12 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g136sm38121759pfb.154.2019.01.26.16.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:37:11 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:37:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/14] diff.c: convert -W|--[no-]function-context
Date:   Sun, 27 Jan 2019 07:35:34 +0700
Message-Id: <20190127003535.28341-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190127003535.28341-1-pclouds@gmail.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 093158244e..8f70101362 100644
--- a/diff.c
+++ b/diff.c
@@ -4896,6 +4896,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
 			       PARSE_OPT_NONEG, diff_opt_unified),
+		OPT_BOOL('W', "function-context", &options->flags.funccontext,
+			 N_("generate diffs with <n> lines context")),
 		OPT_END()
 	};
 
@@ -5212,12 +5214,6 @@ int diff_opt_parse(struct diff_options *options,
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if (!strcmp(arg, "-W"))
-		options->flags.funccontext = 1;
-	else if (!strcmp(arg, "--function-context"))
-		options->flags.funccontext = 1;
-	else if (!strcmp(arg, "--no-function-context"))
-		options->flags.funccontext = 0;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
-- 
2.20.1.560.g70ca8b83ee

