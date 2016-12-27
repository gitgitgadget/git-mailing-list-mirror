Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07F4B200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932933AbcL0QYI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:24:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34932 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932338AbcL0QX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:58 -0500
Received: by mail-pg0-f67.google.com with SMTP id i5so12840477pgh.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wWt6dDk8VjhVA9CNt8z0nGROjKeHlWxgvc/idG9spcc=;
        b=q0aLCEVuuItNnOhhmMmBsTG8UglIxInuyUUtb8uPHGlNIgUfCqBtA5Rc+wdpE1pwSN
         8I2YOCHLNihRSl9Or4p1gZ/D+OPgFHrdN320SXMNpKoY9GmsiDWiEpVJ+6R7Ob6OXiRr
         uGa6lqfdGWk/eee2ebjA4VGLeo3AhohIxHK3WLEf0Hb/f3tLuqtrh7j8ywTiXdVqPOWE
         w/N6QjWPgPLDlzK9csTmJrfxDf2GZCoQDXftwrQOVux3GOu+Ulupshr8TU63NuVmaLbH
         aFxLO405Aiwhu/jvhhsZwIMkbyq/Q3JAQgtes/xvbOkh4v0wXBpDELnYF15WK/MzbWHW
         QFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wWt6dDk8VjhVA9CNt8z0nGROjKeHlWxgvc/idG9spcc=;
        b=uIqFugQJADbdU/LOSd8PkPTLYJC/RnDiEAREPH+GrYiTFyrDEUkH/5w9gv00xhGBPC
         M5yXFxJRHFiSOwVBKPA4L9TCi5AvA1HH/bEbUYc+/+ygH3gJVO803RJqG9pDfLEvqDv6
         MHlT3JGb3W6wid5tOHq7eL0DVEUM0v9jCxwy4MYR6b8/IIAjCNiU9MSB10+6ZSgLs+Bc
         8k4PO9979X5qEFY/C3xg7MsDX7F0FPj/23qIxo8s6q9FTuGmXYW7FXUwY7lF38TXO5c1
         jl4MZ1s1U+4sag03rm3XUS3t+Zc2GuBV0RbEDlNI6Yd8ugkAfSlnINwNKKWVK1cZbAne
         uYZw==
X-Gm-Message-State: AIkVDXK85puIcuRTJx1FsJ35VjQDP3c/27tPW5Nuhkm7L64MeKw29ZJ0+7lILyQHY3ctLQ==
X-Received: by 10.98.8.137 with SMTP id 9mr30629757pfi.4.1482855837659;
        Tue, 27 Dec 2016 08:23:57 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:56 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 18/20] branch, tag: use porcelain output
Date:   Tue, 27 Dec 2016 21:53:55 +0530
Message-Id: <20161227162357.28212-19-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Call ref-filter's setup_ref_filter_porcelain_msg() to enable
translated messages for the %(upstream:tack) atom. Although branch.c
doesn't currently use ref-filter's printing API's, this will ensure
that when it does in the future patches, we do not need to worry about
translation.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6423ebc..34cd61c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -649,6 +649,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index b4789ce..8a1a476 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -375,6 +375,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.10.2

