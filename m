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
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AB61F4BA
	for <e@80x24.org>; Wed,  4 Sep 2019 22:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfIDWct (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 18:32:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38715 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbfIDWct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 18:32:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so328274pfe.5
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 15:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxrufDXcFNfeN2P+bIIOPhCNv5Pda3b93eERy/gV04Q=;
        b=slUDHX4BaU6OygXOjMx9s+Wi7nnDkcts0CFdlaBNlbEW3w4optCTY5zOC6kF56yTHm
         HQjfyvKrng1AUURKt6o8npJgRrNqARFQlDHw6i9J1vPiHSEnJWu6VMS5YMT/jw7EZe1W
         9gQFPRB3KDTLA1rwyYTZoA3gnfozZM0Ug9y0OJ/e9i0If760/gUo3WvEXlRoTIDbdZKx
         MlyoEABuZasJGOWlch/UDf4NLqwQherAL+wUDl22mO8BsC8UQktJ6Ak/z+OMLmLkE5Db
         WR9YPK/hWR9rOXRrL4NP1D2mDy/LNBgtJjTGAVJ8wJpfG6BdnI2leWBS0XiBgB0JZoGy
         BSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxrufDXcFNfeN2P+bIIOPhCNv5Pda3b93eERy/gV04Q=;
        b=Rs87mvXL5iVDyvTb+SZEeYCE5wdKw1mDXeEPVa3EPc7UhGUNOEUJKuIFuOTfkaAssE
         23uNMrhuV7Obp2cHJB0LPOLt8Gf4Fpyql99a3MJUktea+ACQ4KlqrebJyl674ENQ58Kl
         AKR45zLN62n4ACAt6CH9EYSWON0dB2VN0AGqrLy1qc5VPvBAB+bkejS9XFBFnL7QNV6S
         NAqFw6sxtdxVosEy6cWooIHUlC/PJ3Kun8F0F03WlrbNZ4bfVvtgW9PDlNRz3A/+uWLy
         6JxEBykZ0KQ3fdV7zPtsABr1jOT7+TBgaXdG4waI27ToCZUY3U7Rqw9Tcw8TAHQIW89y
         jETQ==
X-Gm-Message-State: APjAAAXt2LTvSjjdD4r0xpHBV9fVKza9XZrOV5efKDTUxb0fHFeFbOf8
        KrMZz23sBQJqF1nQuR8fkrI=
X-Google-Smtp-Source: APXvYqw1CaSEVLu8WOxMdL7Tmijt82wpxIleg8sJMQrThC7tuyT+pBkF2/WgqunieUpEEmRwrNxMvA==
X-Received: by 2002:a65:464d:: with SMTP id k13mr333169pgr.99.1567636368255;
        Wed, 04 Sep 2019 15:32:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v12sm135898pgr.86.2019.09.04.15.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Sep 2019 15:32:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v6 1/3] t6006: simplify, fix, and optimize empty message test
Date:   Wed,  4 Sep 2019 15:32:37 -0700
Message-Id: <20190904223239.571-2-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.3.g19edb94ec2
In-Reply-To: <20190904223239.571-1-newren@gmail.com>
References: <20190903185524.13467-1-newren@gmail.com>
 <20190904223239.571-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test t6006.71 ("oneline with empty message") was creating two commits
with simple commit messages, and then running filter-branch to rewrite
the commit messages to be "empty".  This test was introduced in commit
1fb5fdd25f0 ("rev-list: fix --pretty=oneline with empty message",
2010-03-21) and written this way because the --allow-empty-message
option to git commit did not exist at the time.

However, the filter-branch invocation used differed slightly from
--allow-empty-message in that it would have a commit message consisting
solely of a single newline, and as such was not testing what the
original commit intended to test.  Since both a truly empty commit
message and a commit message with a single linefeed could trigger the
original bug, modify the test slightly to include an example of each.

Despite only being one piece of the 71st test and there being 73 tests
overall, this small change to just this one test speeds up the overall
execution time of t6006 (as measured by the best of 3 runs of `time
./t6006-rev-list-format.sh`) by about 11% on Linux, 13% on Mac, and
about 15% on Windows.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6006-rev-list-format.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index da113d975b..cfb74d0e03 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
 '
 
 test_expect_success 'oneline with empty message' '
-	git commit -m "dummy" --allow-empty &&
-	git commit -m "dummy" --allow-empty &&
-	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
+	git commit --allow-empty --cleanup=verbatim -m "$LF" &&
+	git commit --allow-empty --allow-empty-message &&
 	git rev-list --oneline HEAD >test.txt &&
 	test_line_count = 5 test.txt &&
 	git rev-list --oneline --graph HEAD >testg.txt &&
-- 
2.23.0.3.g19edb94ec2

