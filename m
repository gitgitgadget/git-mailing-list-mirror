Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F781F4BB
	for <e@80x24.org>; Thu, 29 Aug 2019 00:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfH2AHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 20:07:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39223 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfH2AHF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 20:07:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so571387pgi.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kfv7Sfgxk83oFZiO0w8jI525TWVMJCf1Q9r/9ncgK34=;
        b=AsysXheLcc12rKoNBQIAW7mHkKyktNwGey8kWPCHRra6mhjgA1XrdLbFckdiHjM2c8
         QKq98sRhNs1pAJQgEQoUStwLbLmJLRR7xwOGaV45NwLjb0umdIQZFGxnLjNxck7mDeah
         cJAkEAPFHI54QwvPNLQDHBjf8M4otl4zCpH2si0jgUgbUYYTvGKENYkury4C8y2vZnkI
         DZDsQVE/6rB70by7mYAhMc9Jmv+LaDT3zpBtcV14sDwQ80q+stPXoorWZSQ6leuJGTcn
         ciU9hUkvkjLMJTw5N1CZHuQCVQWAvh6FER3i0cOnzglq25wt/ITkuHSKannu/Y1Pz9+C
         g5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kfv7Sfgxk83oFZiO0w8jI525TWVMJCf1Q9r/9ncgK34=;
        b=XrywVVP8ESLDz8s2XwcspeY1M2gcPOyBBW+kUHQf4ul9PId/FoV/89kjBexRjdU3YK
         tnAtpzjTS0fsffZjw7joUWw77GIkzl89P5IksiUPPiFESaYKY9p8si9XI0oyZSqxzk9g
         jWlV6FW62RkB4XgDIyaxvNE1wznHvCwyPM7CBxbWYxDAQrCk2S3VdCT9hkQM23QJ74c+
         FSQDWwCHJ18wqgEl8JN2NppirosqF3b/oprJ2bW4GNaFdl/LgYG+JpZlllvoWh6LbHKi
         RSgLpjjbYxFwjzoOKiLzC4CjVxtx/v8J+E7dWiNzDXh5mfNWxHWFmHWomSmQHXQOA/Jw
         7uxg==
X-Gm-Message-State: APjAAAXNOXPGWP+d+laocW50MFyBVQh0SCafBbM2QZjkG4+OftFtVx7m
        VVRhxGNmX3wO13zkYeZleVKnJ3hK
X-Google-Smtp-Source: APXvYqyQoxW/i2DprC2it2qLS50hDdT4sc/vHNQ0XPH/hYtVZHYL056mjRNq6wzQD4jd7sgOkoK7rA==
X-Received: by 2002:a65:6281:: with SMTP id f1mr5418928pgv.400.1567037224279;
        Wed, 28 Aug 2019 17:07:04 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id m4sm305531pgs.71.2019.08.28.17.07.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 17:07:03 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 1/4] t6006: simplify and optimize empty message test
Date:   Wed, 28 Aug 2019 17:06:54 -0700
Message-Id: <20190829000657.26415-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g59c7446927.dirty
In-Reply-To: <20190829000657.26415-1-newren@gmail.com>
References: <20190828002210.8862-1-newren@gmail.com>
 <20190829000657.26415-1-newren@gmail.com>
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
2.23.0.3.g59c7446927.dirty

