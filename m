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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6EA1F4BA
	for <e@80x24.org>; Fri, 30 Aug 2019 05:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfH3F5Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 01:57:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34260 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfH3F5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 01:57:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so2845981plr.1
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 22:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoZwMWW86NtCHLv1N+yMSXbRN1QdUQS49nbGa6FdJKg=;
        b=MEsewd+asZSESYOOpgu0mAwMBL2KvvEtAO2huBPL2iZJtr0qXz1gFsu4dTv36uObSN
         +vxpmbQSclgjN1rg/epqcUVXihqAk/wP9NL4sSWp8PYsfhEOEO+YVFn0AsRwz+E1ekwa
         FeROrz5olUDkC4E5AuYzCeQBSpqnpfL2OE1n8DrXq7nUvVAi+xutKoReTr4kcWjwjCgp
         tntoY/QbBwAM/GJDvkat9UW4JnLvQWng29aL/56wcu6m3VPCw1lI5oE4iJ6eBpfcT5i6
         YfLea0K3aFE8Kbtt04kAR7rtP9xPIfx2ZRylusVrxNU65uY/9/E5aLQHAVaX6oNqV6Ml
         NIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoZwMWW86NtCHLv1N+yMSXbRN1QdUQS49nbGa6FdJKg=;
        b=E3aDnZtpEJGOs2rLS9CoUbNLU1DGEzbQCR/oj/RALqlNeFH+rk0PZPDBJ9abJjDijv
         AYIwATRDMn3pRj8bygd33TffzYJHXO3Sz3m4Yk56wYVYB0s/hHRfIVk8065+OUU0JTeR
         dzhC1q05N6QTjrfq54XMZnZcxTT7KNfDhS77SS16ZBS9Zfswzny/VdamudjPkqnjJOxV
         ZoQ+TAUGKylljoQpRLYGnUunMZXL7nDnWoEmL94m7zeb+vfa6txFycUMOhUT2pF4bTQz
         PijQwrFDjtjv1BO0TfxtSp5pMwr5oMFBK1xaGnZBxHi+uCUKHwqSBuIzw8jYflngQsel
         iwaA==
X-Gm-Message-State: APjAAAXubs5UBUPTIZPxYv7myUMWpt6t9jGWxvJqCTeCa6D5WfrEV8Zq
        4EaHwvTsZaIQDHcBjfFNtbXb8xLjR3g=
X-Google-Smtp-Source: APXvYqzeAoyJGXNahDZ2guOpIPQdEvUIBy1MNnBYCYiRDLZM1pyxEar5P5bFxxFIlfPfcRI2Stua6A==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr14121988plr.301.1567144635142;
        Thu, 29 Aug 2019 22:57:15 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id b136sm5771139pfb.73.2019.08.29.22.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Aug 2019 22:57:14 -0700 (PDT)
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
Subject: [PATCH v4 1/4] t6006: simplify and optimize empty message test
Date:   Thu, 29 Aug 2019 22:57:04 -0700
Message-Id: <20190830055707.7785-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.38.g892688c90e
In-Reply-To: <20190830055707.7785-1-newren@gmail.com>
References: <20190829000657.26415-1-newren@gmail.com>
 <20190830055707.7785-1-newren@gmail.com>
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
2.23.0.38.g892688c90e

