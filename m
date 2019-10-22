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
	by dcvr.yhbt.net (Postfix) with ESMTP id 99A721F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfJVKUM (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 06:20:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38471 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVKUM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 06:20:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so10360041pfe.5
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qfqzx5mqRrZHqyQX0fZRcQvFA5/6kzXcWyTpN5QWuFE=;
        b=iRFeBB50zxOzo9ehCIcDq6B/a/cTPfcopEnyBWvBsIdgJB3E2cU28CsSKL5cTeru6r
         OXxONoc4QDOkvTwsyHXFIGpTWJMFXVz5HyPiw67FZCQAAqvt8M6AggiiQIhXcQ1RKYlo
         CDvA4Mp7OoNRMGlHu1T/PA7ZLBtA6gHzyob4SQ4jgpA4rJ8IsTGc8RSY7SG9CpVRfby3
         WXQHnwCIJHKPqLEcDOX8+y/NCgjlcsMtz7e7GfNtx+StWqQalN5fKTXY9xOZNOlWhs86
         Se7Qhw5Ts9BYzVWw29BUjWEA2PMA1/jvO20Eq+Zrusl/T8f/jEvZlHx1u+fUQvvC3u/k
         Sr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qfqzx5mqRrZHqyQX0fZRcQvFA5/6kzXcWyTpN5QWuFE=;
        b=bHB4p2Bh/phqf0jUDbAn8Wr9/mKtR+nVzaFhvVFuRXVaX20biKCvK10cXg2dQ2X7yU
         zRdqyqykCFpvd1uSTs3YwCeWnsUEqjC46FX/UuCxAS7SWykvi6tk1w/aBli5FcutNI3Y
         s6MRkfx1fal6TFlQQKzcdX1KyH02HxHhYgbqMzAtI5Jx5W2avEkQaE3vmgzmoazim5xY
         qwNDzYCtCE/L69+ugozUcwvC5e8tyc4uiSwmiZ76qmo+4Ce2BfbDGBVvT6cMOMcH3ziP
         qux17i+En9col0IvsTWGHp//i+d8Wl4CxxeghK2JrcedWQT67GGV2T+b2NpsE/X2GDaC
         bs+g==
X-Gm-Message-State: APjAAAWnAJBU1L7wlw6NVeAunEAE9hMFofuXogoMugkNCj7MO9vD2QFG
        zsnW/Ixet9EWKkI3OW02EdlQc0j2
X-Google-Smtp-Source: APXvYqzYuh5JqIr3wyFofvUx4yVBuF5ekM1/h6qJ+4gYf3at8N9Ohs6mDr5qXYNVhp4sLTfDdoqpxw==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr3252985pfe.200.1571739610647;
        Tue, 22 Oct 2019 03:20:10 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id k7sm7526984pfk.55.2019.10.22.03.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 03:20:09 -0700 (PDT)
Date:   Tue, 22 Oct 2019 03:20:07 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 06/14] t5520: remove spaces after redirect operator
Message-ID: <d2e49fd990dbed171737786fb345a93dc99be094.1571739459.git.liu.denton@gmail.com>
References: <cover.1571435195.git.liu.denton@gmail.com>
 <cover.1571739459.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571739459.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style for tests in Git is to have the redirect operator attached to
the filename with no spaces. Fix test cases where this is not the case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 004d5884cd..7bb9031140 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -243,10 +243,10 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 
 test_expect_success '--rebase' '
 	git branch to-rebase &&
-	echo modified again > file &&
+	echo modified again >file &&
 	git commit -m file file &&
 	git checkout to-rebase &&
-	echo new > file2 &&
+	echo new >file2 &&
 	git add file2 &&
 	git commit -m "new file" &&
 	git tag before-rebase &&
@@ -542,10 +542,10 @@ test_expect_success '--rebase with rebased upstream' '
 	git checkout copy &&
 	git tag copy-orig &&
 	git reset --hard HEAD^ &&
-	echo conflicting modification > file &&
+	echo conflicting modification >file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
-	echo file > file2 &&
+	echo file >file2 &&
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
@@ -591,7 +591,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
 	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
+	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
 	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
-- 
2.24.0.rc0.197.g0926ab8072

