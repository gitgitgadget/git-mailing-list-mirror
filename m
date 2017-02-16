Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAAD20136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbdBPLtY (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:24 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35714 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754941AbdBPLtW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:22 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1484857pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evfGn8o94DEvpV0zQGPapG7RSgKBGjkAXfX14m8kLAI=;
        b=uk5LyLXdCPMKMNkUlcTlXy908q16Hf0Ejj6WAiWwAbw75svcaKVZtiUX6Rt0UIEew/
         LcFrD7VEVgYoCSvx7pWQQ0AZWXVpNpgl0q5EYakJhAhitXUKyM5uBAX+YOfBtE6e5qmz
         l0y7QOqayc6lUT0c4Yf8q4FGzOJhztskb/u6aY1Oi2blFhLHxPaSjp1TN6gnChKApL0t
         Swsu7eFRDCQYVsuv3xhpslRDtBmGhTGofZG7MJMx65b0radrLuDu3Vi43HKY5kj516tI
         2vgHUBlE/AD3WeNxEJqWwzoC4qp606U2SC1je2DMUZJBO8bXESdtEpzA2qYX/9CA9XPG
         ssNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evfGn8o94DEvpV0zQGPapG7RSgKBGjkAXfX14m8kLAI=;
        b=hRg2TAyoJg0nNAi1w/pFeqTzLCrK3N7dsMbc3SnZ6Gh0qrHcpxlRw+PTC5kETaK3VT
         aNKfey9G1l8jyOv6GAcN6WwC6meP2PJ9DEAbLq/HZYqYo9uc+l8zz9Qoht3J57DkfgNE
         KVLiK9dlrFthuV4y20lTqw0DlES1p/f3EPCZ/gENXnZOj3RmxpRkdR0t6jCxVn9PBozO
         +kla5o5JjQ+nh+pNmUw5Vi0a7t7KIRlUG8z3ijcVLVJIRiJiSp5Tw6MBReCpbxujWLTd
         YptFrtyaEHDEzwVelLWky/B2YNjuA9fSSulkGQGJJJ1PIzIGejhuVUQ7mMTPlHVSsl0b
         FyeA==
X-Gm-Message-State: AMke39koO3CrOamgytMi6lxLH27gCyPhW2lz+O0jiHtvlPdfB4ulxopo8TPY3CSfyZVqXA==
X-Received: by 10.99.213.81 with SMTP id v17mr2279818pgi.130.1487245761527;
        Thu, 16 Feb 2017 03:49:21 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 67sm13248754pfd.120.2017.02.16.03.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 05/16] refs.c: share is_per_worktree_ref() to files-backend.c
Date:   Thu, 16 Feb 2017 18:48:07 +0700
Message-Id: <20170216114818.6080-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c               | 6 ------
 refs/refs-internal.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4f845798b..7a474198e 100644
--- a/refs.c
+++ b/refs.c
@@ -489,12 +489,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 	return logs_found;
 }
 
-static int is_per_worktree_ref(const char *refname)
-{
-	return !strcmp(refname, "HEAD") ||
-		starts_with(refname, "refs/bisect/");
-}
-
 static int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 59e65958a..f4aed49f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -651,4 +651,10 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 				    int resolve_flags,
 				    unsigned char *sha1, int *flags);
 
+static inline int is_per_worktree_ref(const char *refname)
+{
+	return !strcmp(refname, "HEAD") ||
+		starts_with(refname, "refs/bisect/");
+}
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.11.0.157.gd943d85

