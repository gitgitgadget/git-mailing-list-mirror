Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56AE220136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbdBPLt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:28 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35730 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754960AbdBPLt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:27 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so1484988pfx.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=B4jIMmRIgj3NrjAx5SqYvDxoYLiOKEIFoYpC7YgV4UuJG7uxeTbA7ubFs4nQ/Lw60v
         8IMLQwQZ/bEa8xu07Iuf4k7IglBpcM6jNK+xFQ6K1GAYHH1AWy3olfj32vqeDGODIPDX
         p+R5KVxRpkRdaE4Ipq80ksOf4fZa6zIYDKpod19kx7SFvZRqxOozXl2rk+OqPNHvnGWu
         ds0E+gvUchReR3F+txa+iLoMT5KfZREaadMt0B8uL+HHwqwgsnrHVexD2hq86WE0OP0R
         8NDEwOS3IfsyyAaMYo8nnSXtg13j4BWERouQlq/yAYNt2eWzZRPKrDne75SbHSyvQqAl
         oOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiD/H4Nufnbe0cOIQ7LP8avhtOxNo4kDIIKtkQGAKKA=;
        b=fZ320RZv7YFGwHUtI53i7GyaKJ72TRLhOHXH6g50DLXEvcowGxHlQtVGRX6Fb3JinI
         o5aR04rGvVq8Zx+jHkSQbsBlEQsOPlLh5cU3qPfHVQsRNC9MpukJchOR9LeREH015cGz
         s/IDynNFLs0jd95LRmujrPOKl326ioRTkDEInR1xAC2/yXO+4Bz0am6OBzz66pjMR4FS
         8rthjzhaETRjSf37zE/S/00dt0YDWj76mlpjTjNOKRikkK4f8bkdEk3X1x3LPU4An68v
         r689VYKIoZUT1U5wjy3rCxzh/c1jq6g1K4tDZUnRxdb8pNq9lGvpVTUlnCkNkUkDcjEB
         kg6g==
X-Gm-Message-State: AMke39lLvxhrLHVfWHlvhProfbT5q3DmqAxqoChfzC6E/3RLwZxbBiaU9Mb+6N8spQuIjg==
X-Received: by 10.99.116.22 with SMTP id p22mr2284620pgc.161.1487245767014;
        Thu, 16 Feb 2017 03:49:27 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id z29sm2658735pgc.7.2017.02.16.03.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:21 +0700
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
Subject: [PATCH v2 06/16] refs-internal.h: correct is_per_worktree_ref()
Date:   Thu, 16 Feb 2017 18:48:08 +0700
Message-Id: <20170216114818.6080-7-pclouds@gmail.com>
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

All refs outside refs/ directory is per-worktree, not just HEAD.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/refs-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f4aed49f5..69d02b6ba 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -653,7 +653,7 @@ const char *resolve_ref_recursively(struct ref_store *refs,
 
 static inline int is_per_worktree_ref(const char *refname)
 {
-	return !strcmp(refname, "HEAD") ||
+	return !starts_with(refname, "refs/") ||
 		starts_with(refname, "refs/bisect/");
 }
 
-- 
2.11.0.157.gd943d85

