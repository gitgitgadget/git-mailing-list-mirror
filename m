Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01A12022C
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbcKHUMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:54 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36521 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933244AbcKHUMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:51 -0500
Received: by mail-pf0-f195.google.com with SMTP id n85so20693377pfi.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cShw6xWPWnuWLeYqW03EIQLJL2dGoi+vIfQbjk2bAzI=;
        b=W8GmzEIH4DQoSYupbKynRhbzBsvwslbinmdN9BMTks+puUbp0Kda+qfpfwCXbbd2xO
         dNQ/Zj9qONSZEqsAdP52UXxUW05KfagTaLS/1EWSatRg0c/OCLPDq4L+omOOjIGFkPZV
         rG4qtWRFfztt+FaV4CqvZVlmT305yMQiCA2359MLHwEJdB2wCpaSt0ydHDDIPGpwgqK1
         vYjwnYUk/481YG/VqiZifXn8NyZwEQ2SoZF5grlXV4KGui1l95PWb4LGFDQ2MMHabCqR
         5oQHsaFW79KiPkvRgLNKs28FhxmQZ7qwq1MygxaxSVNke62JnbzWaKgGZTrR14SEH7f8
         xRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cShw6xWPWnuWLeYqW03EIQLJL2dGoi+vIfQbjk2bAzI=;
        b=YlkLXyBQcilNlxeUbgGoIEv2n1KNZMM80ZZe1PaMyOGxAi8ZXinIfDpy6UKPFh/aJz
         tKhliDDks9nKGbZXSHHkdyxmMN7wXNacld3wpxyPOcsF9P00qu2Jn6qoxheC9pncWgtR
         KQnCnfkvk+PJmSz7YLAHZleApH2k/Zm7zqjJOif9Mkp2TM6ljab3An0v9YFkhEGgR6Qm
         89Ajkp7uYnEGIYLIsf/LYCimccOmxTSEz3YnTP8kTFsffRdr+1WvIICCVfDGx5WLyq9u
         HupkjcbPYYimxig/3JxyB3b2V6qo9auN5Hyv9q7yWuwtlUGuZYjQVWO4jsrZ+opbgvqI
         8JYA==
X-Gm-Message-State: ABUngvdPs4RsaYwQ2d7bjTOJZuvvBsb9jLbqCU5TGzh/v/+uWPFX7/6A/A7ibHcb1VoyjA==
X-Received: by 10.98.35.5 with SMTP id j5mr26202970pfj.91.1478635965224;
        Tue, 08 Nov 2016 12:12:45 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:44 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 15/17] branch, tag: use porcelain output
Date:   Wed,  9 Nov 2016 01:42:09 +0530
Message-Id: <20161108201211.25213-16-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
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
index be9773a..dead2b8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -656,6 +656,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..a00e9a7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -373,6 +373,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.10.2

