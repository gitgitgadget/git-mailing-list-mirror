Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8E181F462
	for <e@80x24.org>; Mon, 29 Jul 2019 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfG2J7Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 05:59:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53876 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfG2J7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 05:59:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so53248026wmj.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gadOBgrFAJFE4fKJnpQMT/rQZaywiVVd6cta9jK91uc=;
        b=oBel67Gh79uW1klaKUo7MvZmRzBd7w1Sqq9ztOJXk3wyTSaLOI+Veeh+sNcQKzNrtQ
         yI7mgl4v9J3pdFvd7QJqZv7n5HIhkRD6MffqxoIwx0uj3T9j4mxG2LXoDDDWqp0okVrP
         HwFj9tRCARI5mDgfXXfuhNDkqIx+HqEtNIdneLuEBmxfEbNOIx1SV4Ay/QIw1/0nhqzu
         bQQue5+UECjCs194rW05htzPZgxSdjijI1QTl74cpUIy23w1KH8AkrsUXyFaRwISPqTR
         PahFYwdFLviN/1ZEpA4r3v1S5jEUj8l/wNrtwRgEQZliJwjxkTaFj2GG8aW6A91v8gNI
         qTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gadOBgrFAJFE4fKJnpQMT/rQZaywiVVd6cta9jK91uc=;
        b=eZ7Ih/BOsqCyvJBZQq8BE+laDcdEF/zs8AyjzZIrX7Qb1uRBKhEdqYae4lEdd+Gops
         5z2pbM5jMMDsDgJzKCS6yT2dU0CvAdPSZHgSN8p/8nIQJOQ8c3EBxc/kkjTCKjVJZ35y
         E+8dvm9OkCqnsJTKcERK6inoB5JYMnvBk95ziILSUw37lG4s+YkCYelQmwuSyop6YjZc
         2spHIL4A4rB7ACLRFX3t24x9CdTLi85xp16GF07UBQC8/10HdLDWicjTcOI7HEvuRDIm
         HDyO1uT4g/qHp9TBtDUQM1wT/LSjZe5UN96SBtTDtZPRPyF6EE6sl5+MzFOvFApPeStB
         SHcA==
X-Gm-Message-State: APjAAAVBpYsiI1JGTS9/tE/ipIKMtP6xeK/7gLaG8T7CpvuEPW7yr3mV
        NC4IyLfxfQbsnUeVeSUFmsI=
X-Google-Smtp-Source: APXvYqwlNcwPvkHY56hRxpUeTay87x56vqxmWnEXx1bLxP6d+rsr3qYuIouqMF+efCZ35fbidNcTBg==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr58595333wmj.133.1564394360910;
        Mon, 29 Jul 2019 02:59:20 -0700 (PDT)
Received: from localhost.localdomain (x4dbd8f4e.dyn.telefonica.de. [77.189.143.78])
        by smtp.gmail.com with ESMTPSA id x20sm139724737wrg.10.2019.07.29.02.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jul 2019 02:59:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Olivier Bornet <olivier.bornet@puck.ch>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Documentation/git-fsck.txt: include fsck.* config variables
Date:   Mon, 29 Jul 2019 11:59:14 +0200
Message-Id: <20190729095914.30573-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.22.0.924.g7c03687a56
In-Reply-To: <20190729093928.GP20404@szeder.dev>
References: <20190729093928.GP20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'fsck.skipList' and 'fsck.<msg-id>' config variables might be
easier to discover when they are documented in 'git fsck's man page.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-fsck.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index e0eae642c1..d72d15be5b 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -104,6 +104,11 @@ care about this output and want to speed it up further.
 	progress status even if the standard error stream is not
 	directed to a terminal.
 
+CONFIGURATION
+-------------
+
+include::config/fsck.txt[]
+
 DISCUSSION
 ----------
 
-- 
2.22.0.924.g7c03687a56

