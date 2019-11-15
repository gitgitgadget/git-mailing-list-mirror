Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36CF41F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfKOBBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36262 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfKOBBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id b19so5484685pfd.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b0EVTjwMaQlT1E002U27ok5hZF+oTyo6yxdE5sj6S5Y=;
        b=F4YJueJyt/mbovoNotXbPk3kSRZcF52zD4winKmGgmav1o8t4b5M05mSrFU7lyH40O
         M682dU50tvSO8t9PEr0Eq5IvX4ay/Lj7CoQc4pIjJKfCRtrR/Hk1Ouv+WSYnaZ5NV3Mt
         tKWlPEVI+atMA/RZEJhxK1yh/5jSoh0WzmCLuNJaHW4b6jtRm1HFqOx2Ab16pSiPGSsC
         QtD8ElvgIVcQEFudrPT9vHKltngOu5iT1B8azeuOONMoMXkI/MB7yOqatwNR3WOPcHpp
         96Q5H7hjZKy9Xb6vFrPWirtFH8VIZV/rYrapyC8LFpl7kj3GuN7L33n4+Yx/GDrYgNWk
         QRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b0EVTjwMaQlT1E002U27ok5hZF+oTyo6yxdE5sj6S5Y=;
        b=YbQtas9eI7ERcWZW40IeJ5iRVZWOvbSVa5ALrA3BxpzK+hlJwoiASNCAqYfTPZtYhw
         krX32L2i7JvuP6651vmqNGrlkGK4xiRbSTdzrCcL65Z9PnmID7YWmByF4LkYodXxALzE
         7uHn6703GdD5E15Q/mCRMtCB8JeB1pXEhfC0K4VQWxfR7yZWvJhc4nXmQkGlxrohnuOQ
         XVZoQlQtOLHflh1xTY32ZxeVBAgVfLHkUpqeAYyvIYPOJqiJQ1SKrYp9Eq+saKwlnf3L
         JC9C1cpwoIzbuvDAOHYkFHqbVpjKnIP+zAhHKRYs/hUpaiegaC69b6gkQKCNhrJ82Est
         9wGw==
X-Gm-Message-State: APjAAAXJOulh5+n7T/exdogZj6+tyjj46GljBgQi1fkWAlkwQQ8sJKyU
        1d6+UfBieukVji2t/cz09sB9hZYW
X-Google-Smtp-Source: APXvYqyoJhzTcMhOmygb+3mk1y224Ja0lgaZ8ytnoVozf7egJ1IZg7v5hlK219o94QBzWYXtdnTcgg==
X-Received: by 2002:a62:180a:: with SMTP id 10mr14526929pfy.40.1573779683938;
        Thu, 14 Nov 2019 17:01:23 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id s18sm8405178pfm.27.2019.11.14.17.01.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:23 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 22/27] t0090: mask failing grep status
Message-ID: <0f3d1c04a1283675db0c6704bbdd2566d405163e.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we plan on running tests with `set -o pipefail`.
However, since grep can return failure in the case that no lines are
matched, this can trigger a failure in a pipe in the case where grep is
being used as a filter.

Use test_grep_return_success() instead of grep so that we don't fail
even if we have no matching lines.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0090-cache-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 5a633690bf..b0f3b69d1d 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	git ls-files >files &&
-	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
+	subtrees=$(test_grep_return_success / files|cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
 	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
-- 
2.24.0.399.gf8350c9437

