Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61AD120A93
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbdAJIti (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:38 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34643 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932452AbdAJItg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:36 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so6873819pfb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hDKPDz4iCPto48jv1zmuUao+kXf4A23y6MIG+eWTkp0=;
        b=kCR+UQA2S9JErwYxyxnYszzhTYFzBT2BYybmXYw492VlYsuln/g9IX6sEET1GhXmA4
         A33MR01+B5o5FaaAHZiRRuRrqcdxX19knwfubYWpY83HsRMhO6izXeXGxwVnI5IYtshh
         bsZDvTcw2JoplvptTBaz+gho7yQzKyIHF/2teKoh1bM4Wm9aTgcETan2jRGGoOGpgIZU
         UbdkjUxOn5hQLdLgKjx0Gr1wUH7rl8wAr3Vw4jDC6y4+HPMLBXpMoH6BOFSNDY7b3bjR
         sOS1QPufxHdABVhCgmHIdFuGpEaVmqe3Xx3226HzXfMSPPzRDmspVS1RtX4aj/xU7fIQ
         482A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hDKPDz4iCPto48jv1zmuUao+kXf4A23y6MIG+eWTkp0=;
        b=rCKSOJvt7p7X5rot1tReip+iYoQK0dxUXgRH8x8KMz3rY6WvAtk3gXIT4QafpqFyEv
         fQ8dN9Zs8wQWMTmyTcBTX4Y4GlQTjzQLDZ2UEzDP6XYzmnzXdclguwMlLNkW4eFF492V
         ZXb4fZJ9YLzIdSA+XDwnFy6+JBVFZnWs4kWj/DQ7mwD7f65gxKCOLlj5S8wx3Gg3y77A
         DyBetDhh9aJjbknp62O4+UfhiSDdILe1EAfSEd083FuG4QqE3W0MWcyUMH3P8BNqSFM3
         oS1tI8mHAjMhdH/pimwZPBEdNEy97cvefhqoX7EU0C7cx2DKRSKN0AGojzgEfzJSe0yq
         NHtA==
X-Gm-Message-State: AIkVDXJLAPryuDw6M4hzW/WwPK3nVziz02bYzl1QF06Wxojrr6Evw1rKdxG+zf0SW5ffww==
X-Received: by 10.84.193.131 with SMTP id f3mr3358980pld.26.1484038175372;
        Tue, 10 Jan 2017 00:49:35 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:34 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 18/20] branch, tag: use porcelain output
Date:   Tue, 10 Jan 2017 14:19:51 +0530
Message-Id: <20170110084953.15890-19-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
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
index 6423ebce5..34cd61cd9 100644
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
index b4789cec4..8a1a476db 100644
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
2.11.0

