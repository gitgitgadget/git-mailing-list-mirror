Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ABA41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfBGKfK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBGKfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so4577937plm.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1VmexvKxBbBWVk5htuHDqVzeD2tHkBYJj/3Y/hfdgY=;
        b=rb8Y75m7Jj9VYB3hq6uLLnZrvW8EtMXIY5uq0ufy4roMwmbNDLn+8brdwKYnzcvqba
         Hn/ZSvqeZHpZyiKd1Ht+4mMAhFWP0CLJq1wPj4Dd42QDi+gMI50tK8QoJchKi7LcrBEb
         andeXYtvNA6QzWzWZ4xdJnHxzoSBluPgI+2VoLQn50358MOuP4LvOTSlAbpmB01UmSwt
         553HgrfuUphjOXaeKXn24r3HhaFJcsVlNblLfjY+F2Xbu0/OsMuq1V4zo+yj3Wka7Wsa
         UI9pIB41t3Mk4LLoxX5PS6H+fryP6TOrZfRntQqDdTp/SaY1EqLH26Qd/hZxUCZswHNK
         2TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1VmexvKxBbBWVk5htuHDqVzeD2tHkBYJj/3Y/hfdgY=;
        b=oTUJk78pn41BagI3COWFd3MBqS8WeiwvS79CPPNZHWC5ZaRncRQTXrJjHdQ9Et5b2M
         KJeVFH/3F90QydJwUIuhZi21mK84Z0L+xGCo4vg84La4u/64y+IcEnUfYZQQxSNircuA
         WCeq4GIocc7eYkq5AeedL7h+0095QvjOoS5hYwFvtwkD1r+SAj8Z7bEI8DYwhe3xf5h/
         6kTbqNPBl7s34hx1CuPa51g14of8Ygb4hwJ8PFvGTyIZ0Ydj3opwYnSW0Pkmo1nDaD4h
         aXKzeqBUaesldQqdK1rPaW4QotvXfHmKDsJfN0Ckjl08DfmR6jsFWtSYqQyuwfvjLdKK
         mrlQ==
X-Gm-Message-State: AHQUAuYW1dSNnJ/ylazM9ZFbDN4GN/I6wZObR/WSZ2VUq4EGZDbTx+XW
        vL/9kdVBkjnccPbkpZRr7Be+7MfV
X-Google-Smtp-Source: AHgI3IYiOLsEC4YlO2NleSOk8fhyqrRAewpIN1THCokmYLMRxzvcY59dQs9FpKvg7371+MhIurwwdA==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr15776931pls.259.1549535709054;
        Thu, 07 Feb 2019 02:35:09 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g20sm7111426pfg.85.2019.02.07.02.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:08 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:35:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/21] diff.c: convert --find-copies-harder
Date:   Thu,  7 Feb 2019 17:33:22 +0700
Message-Id: <20190207103326.10693-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--no-find-copies-harder is also added on purpose (because I don't see
why we should not have the --no- version for this)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 35bac115cc..abb1566f95 100644
--- a/diff.c
+++ b/diff.c
@@ -5085,6 +5085,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect copies"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_copies),
+		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
+			 N_("use unmodified files as source to find copies")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5191,8 +5193,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--find-copies-harder"))
-		options->flags.find_copies_harder = 1;
 	else if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-- 
2.20.1.682.gd5861c6d90

