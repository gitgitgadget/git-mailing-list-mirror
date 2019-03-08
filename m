Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F8520248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfCHKRi (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:17:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43469 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCHKRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:17:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so13822265pfh.10
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goXMijjF+qnAClQVMFRO/PNYHQhi+Zx9hWyCzTAAaW4=;
        b=TBpyFzy6xeDgM/d6xOUCw8wAEoK/v1PPC3uyRyTsawFAr1XK9zzN6vW6zW7n97oPzv
         T7us7eaD3+L+jV/re4shmGlIKkg9dJmjFYBYI+H7qiGqlwH9aq+hf8O5EP4EGoD9p6VR
         UsPt2g7RiPj0z2F337uRZBuO6BLkMDzaCN9bKumvZZJu1thKdInSoDdUAwDLKtPBIEAR
         1qrVk692hSRkuj4FIOM9761SVnNXB8F0riDKmOkdaa5MKS+wyzS7pjAlDxkSOp8yHXNn
         9Tv8PjkqMX52BN5eJnAAh04MctETPgD2A2V/2LfI35682OP01O++CAhWoECSclsmNOBX
         P3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goXMijjF+qnAClQVMFRO/PNYHQhi+Zx9hWyCzTAAaW4=;
        b=iviGKPqfcY6eW42AokdrlYPh+bhb2OO13CYG6D3VJxkbz8IOhVQnezU1goTzgDbw7P
         +0Gz9Kb+WoZrz9HD5pV3dK6b9nDF3PFztQucz2OGuUHscdoNptUaKPMVS+R7SqcNDeG7
         YZVoFg5JDCoOsIwFduqcP1i3UFGjref5wCJjFBpnCbyMvVP6AI0PBxj8Ll3xKRDDL9RF
         42tPKYNT9oUL21zbRGUaijtryqpCmgtpKyR7oi98ZaRMzYeSFeNanPXf+CEnLkUYpHE4
         OTU1R8sRQbneJHD8gLGbsmcFbNd9V9th9AgAfwlAEGtYPzHHvoF/dcIYmMfIMAOxsKHI
         PGFQ==
X-Gm-Message-State: APjAAAWeBACeu0BGLb3tD3pOpkmbEfSecijWv8+/G3tqa/3jDUe8rjFd
        QpzHWDbW+Gn2N/gb8LIi2LV+OV26
X-Google-Smtp-Source: APXvYqzF44a1J1Fx0TDH4Y95a9PRP1lcgVBpG2ZKN/9s4SPikBlhz1WFGgpVFmzwwWQyHqn0jLCFjw==
X-Received: by 2002:a63:3f48:: with SMTP id m69mr16137830pga.207.1552040257329;
        Fri, 08 Mar 2019 02:17:37 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id c13sm26811030pfm.34.2019.03.08.02.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 02:17:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 17:17:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v1 07/11] restore: default to --source=HEAD when only --index is specified
Date:   Fri,  8 Mar 2019 17:16:51 +0700
Message-Id: <20190308101655.9767-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308101655.9767-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git restore --index" does not make much sense since we're told to
restore the index from the (by default) index. Set default source to
HEAD in this case. This is basically the same as "git reset -- <paths>".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 07b431be51..f06439dbeb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1426,6 +1426,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
+	/*
+	 * convenient shortcut: "git restore --index" equals
+	 * "git restore --index --source HEAD"
+	 */
+	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
+		opts->from_treeish = "HEAD";
 
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
-- 
2.21.0.rc1.337.gdf7f8d0522

