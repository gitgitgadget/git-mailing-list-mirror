Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1BAE1F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIOViO (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:14 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:40607 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOViO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:14 -0400
Received: by mail-lj1-f177.google.com with SMTP id j19-v6so9841884ljc.7
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=oW9mfAihNuxnCDQHXEronSCetAIkJuke4nnveaesWERkl3KeNfwo78KkMQECtJBDI8
         BJrf5H/Q7FitYvtjrc9uC7vPqkEGpsWTvsht7qxwKkaqMWBn3peTPsWaJ8Dyi1+yl6Ye
         kZe71hKCI/kx61kEDD2Nr8TSeM+zb8ht2JMpcDBJEFUCjeze8PUzgKC8dCWHzM12DO8k
         fQIkYFkF51n0rUUQt+aCAeJqf+bUfdogjygLNELLP7lMUYR6hXXhlUuwoOemUqOmMmaq
         ZDeKRVIXCqnm2SrUpe7LvFpZTQL2fmldwzIirN1MRrWFhy5iTKO7juvw2IKRrQWiCykO
         ApsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCHO1Mbm6XXhoAeo7cGOonXxLrOWJeQM0VzBOeAzNYg=;
        b=SqU40OT8vnsO0o76sBg7uYyMOcXUEcWM00a69xh9fYiEDsWqlPlsNqKoS5wpRosccC
         gU/I3xeCahiE9yCJDX3AVh1XoOj66+msH4xw2cD6RHf5BH6bgpF1dxJiHerOHdfbqYG8
         TasCmzg0sbkbnKQJ+leSS+BLQ1MdQrtIlybmmhwKjtr6LOBvrAxoQWGNBdqb65Z4rbYc
         /eTW+yURk0IlAO35TCi05kSZtlURw9kE2G3K8sJl3yi/gAvI65A4J6lZP8yIH505FaU5
         INniLzTJYTuYwAnv2SQrRQei0RJV/KOZqdAfUZpVghnz+RhyY9UXaHnMScjXYLGYLL2d
         8gtQ==
X-Gm-Message-State: APzg51Aeph+wCoq/xMMPwwXd9XVxBOPR2N4nNfFIf8LsTDrGSGCLKTj8
        X6t4YdO8mEXgjiJYjTaNi3xsb45p
X-Google-Smtp-Source: ANB0VdYrXhqdGD/5y29nUOmCEKSI7gtY7yGzKpdBe6GvOX3J1jc3dTXlXCdNWYi9UZBzfUtymB3jFg==
X-Received: by 2002:a2e:380d:: with SMTP id f13-v6mr11463382lja.74.1537028322547;
        Sat, 15 Sep 2018 09:18:42 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:41 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 04/23] combine-diff.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:40 +0200
Message-Id: <20180915161759.8272-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 combine-diff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index de7695e728..4fa7707b57 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1054,7 +1054,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			if (is_file) {
 				struct strbuf buf = STRBUF_INIT;
 
-				if (convert_to_git(&the_index, elem->path, result, len, &buf, global_conv_flags_eol)) {
+				if (convert_to_git(rev->diffopt.repo->index,
+						   elem->path, result, len, &buf, global_conv_flags_eol)) {
 					free(result);
 					result = strbuf_detach(&buf, &len);
 					result_size = len;
-- 
2.19.0.rc0.337.ge906d732e7

