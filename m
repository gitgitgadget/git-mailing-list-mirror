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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2571F4BA
	for <e@80x24.org>; Wed, 28 Aug 2019 00:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfH1AWT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 20:22:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfH1AWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 20:22:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so345817plr.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+VZXA6LvT0svvSFZ9ODp2Vps+NWoAuQa/FtNtsgVLk=;
        b=PfH/y0PeyGXF1I73/qvrOFBcQf/t1RlfHGFGRYjqoWCK8k7Q6zwNxr21MozgoPzoWi
         /19CNRzHJ1VYKXaJw7A4UO6pf3VkNywbpJDiWZqFPzs1mrFsK9btFWqBwWzljHF4Ar3J
         B3flp++9+W2EX4njJ/z+WVWzJRSuQFy1ygamG93FX/GURb5Z8e5NVhwzbSyuc5zA9xKw
         aN/aCg3/k7uAwQhZfz5016mXJ5EYROAFihIuZjmznlHADtNEbD41qidlCkLIXyzjQb64
         CBtyD8AK8W7OMruGD3PZcU5jfIL531NEJWtRWar8NZ6/pAXg/08x4XvkOC2iCgmWU2G5
         Z0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+VZXA6LvT0svvSFZ9ODp2Vps+NWoAuQa/FtNtsgVLk=;
        b=CPV6CY/aoeb4eR4iUfEH0Qy9U/gAn6Zgbk3GaPCPm8sKZ0HKS/JcDAgPidnPc2q0va
         61uoOu64ZzrOx2Lc3Xlkwg+GieGm/Ftn5h+S+RUdg/J8mxrMKWbJMuLICR/c/gFSPSu1
         LitIu2KEC2cCLCAa3cU2F/F7z3se+dUyOSD+/RxoZbsqjOv4vfq3VP0+iRKT8y2Pvc3W
         yryRxoV5XrqT2ENABLqGYjzIqYEwEqQIHl+wjgKEZJoKio4oJwBb8B82huV2ngklWmh2
         CulUJQmc2bvuQcbJTnG9RxYCQSzgPwLWiTb8DCkznAsQe5MPjv+ekDHBOs2G8C5qUzT5
         oAJQ==
X-Gm-Message-State: APjAAAXxlejFDMyWfRm9b0sLeKdYMjmW3H+mPxHE73tFMxnvkzcQT53e
        WZAaN1K5Xjemh139emndtkgXT/Dq
X-Google-Smtp-Source: APXvYqwl/LGFA+lx0GhzyEMpj5TNWhN/dDPLYVfCqXxQAIid3pEe1+ECqVnjEFsfFdMtsi7lAmnugg==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr1629711plz.83.1566951738350;
        Tue, 27 Aug 2019 17:22:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h17sm495682pfo.24.2019.08.27.17.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Aug 2019 17:22:17 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/4] t6006: simplify and optimize empty message test
Date:   Tue, 27 Aug 2019 17:22:07 -0700
Message-Id: <20190828002210.8862-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.gfc6987be7e
In-Reply-To: <20190828002210.8862-1-newren@gmail.com>
References: <20190826235226.15386-1-newren@gmail.com>
 <20190828002210.8862-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test t6006.71 ("oneline with empty message") was creating two commits
with simple commit messages, and then running filter-branch to rewrite
the commit messages to be empty.  This test was written this way because
the --allow-empty-message option to git commit did not exist at the
time.  Simplify this test and avoid the need to invoke filter-branch by
just using --allow-empty-message when creating the commit.

Despite only being one piece of the 71st test and there being 73 tests
overall, this small change to just this one test speeds up the overall
execution time of t6006 (as measured by the best of 3 runs of `time
./t6006-rev-list-format.sh`) by about 11% on Linux and by 13% on
Mac.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index da113d975b..d30e41c9f7 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
 '
 
 test_expect_success 'oneline with empty message' '
-	git commit -m "dummy" --allow-empty &&
-	git commit -m "dummy" --allow-empty &&
-	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
+	git commit --allow-empty --allow-empty-message &&
+	git commit --allow-empty --allow-empty-message &&
 	git rev-list --oneline HEAD >test.txt &&
 	test_line_count = 5 test.txt &&
 	git rev-list --oneline --graph HEAD >testg.txt &&
-- 
2.23.0.3.gcc10030edf.dirty

