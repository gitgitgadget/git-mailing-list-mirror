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
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E5F1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKOBBM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:12 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43874 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so4870757pgh.10
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ec0JRC1t+f1XBdO8obEydFFVrQbRdt5jlQ69Rgyj01c=;
        b=soG/vpnDP3g9IDGIWNQKoe7P+aJnRWEOGms+CwY3ViOZ184nOhaETsLEFcCMwC501K
         vv49ncwKgrbMrnWrollCMXKg6+tLSqEj4/u0FYc9L5T7zxoNSDkH2z3hoertnIrWO2Si
         sHXPOKr8iN3P0i32rtENxM5IW5pqNRgxc72rRAxC+f2qOqady2MeUr/BqV3sJOo1NdLC
         v57TMwhWU688o7bVMjWw7vWDUNLZSFZOjHmCqcm4GJMvN1YRU8kEnGJnlOyjBD657npk
         LWrZzylOxcC0MSQ4jEC4j3mybz5/ZNyghqfOYAbJV12V4DJ1+CPXEDpCH4GddqhqFWQk
         k/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ec0JRC1t+f1XBdO8obEydFFVrQbRdt5jlQ69Rgyj01c=;
        b=FJfqnKqfi3u5uIrv3cP8r85JOMGJfCw+FK2Unll2sq9JxQD2+do2t2O04oRkINSHoO
         zU5+OyFZniCgXYbYnhLif9UQisKbd5J6os3797iB2yr6xNQfUA5WBBtAxiX/v4blFO84
         NyAf1n2k4JrKicDh3OzjhK3HLSgKO8lnyBi3pZAZADUu2ZQeNaRW27/DZmw5eXKPexK8
         pyPuoOX3BQfjr94/aFO3f/YW3Y/zd3+SO9wmiStaQ/wER6oaGcRaNWfLLSNzSIsqVrIN
         188bDRev5pDrsyZUvoyrIgREHlY8h51dWepVtCB0C+6mpOEcrxP+MudlD1JJmvFSLBaE
         V1YQ==
X-Gm-Message-State: APjAAAVqC+hHqlrLkidJ1uJ53kxszNWYpkGq8ud/2M/YuCXyaToOZQmS
        QEdxZY7ZvIwbE8uGGhRvbx4WY4kX
X-Google-Smtp-Source: APXvYqwU+hwHmEoO3ZN5ALce1FA0t8nvNXN61SRX/8R0LJptGZ8hz1/ZYBuMslNgzTuld1SrsdM/hQ==
X-Received: by 2002:a63:c103:: with SMTP id w3mr6557221pgf.275.1573779670529;
        Thu, 14 Nov 2019 17:01:10 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id j20sm7479763pff.182.2019.11.14.17.01.09
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:09 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 16/27] t7700: drop redirections to /dev/null
Message-ID: <f1bf3355143d787d708fe9367c04c41530f8568a.1573779465.git.liu.denton@gmail.com>
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

Since output is silenced when running without `-v` and debugging output
is useful with `-v`, remove redirections to /dev/null as it is not
useful.

In one case where the output of stdout is consumed, redirect the output
of test_commit to stderr.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 4e855bc21b..e1a689d6a9 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -5,7 +5,7 @@ test_description='git repack works correctly'
 . ./test-lib.sh
 
 commit_and_pack() {
-	test_commit "$@" >/dev/null &&
+	test_commit "$@" 1>&2 &&
 	SHA1=$(git pack-objects --all --unpacked --incremental .git/objects/pack/pack </dev/null) &&
 	echo pack-${SHA1}.pack
 }
@@ -19,7 +19,7 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	# Create two packs
 	# The first pack will contain all of the objects except one
 	git rev-list --objects --all | grep -v file2 |
-		git pack-objects pack > /dev/null &&
+		git pack-objects pack &&
 	# The second pack will contain the excluded object
 	packsha1=$(git rev-list --objects --all | grep file2 |
 		git pack-objects pack) &&
@@ -235,7 +235,7 @@ test_expect_success 'incremental repack does not complain' '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
 	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
-	bitmap=$(ls bare.git/objects/pack/*.bitmap 2>/dev/null || :) &&
+	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
 
-- 
2.24.0.399.gf8350c9437

