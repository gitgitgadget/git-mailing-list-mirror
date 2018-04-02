Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC1381F404
	for <e@80x24.org>; Mon,  2 Apr 2018 03:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeDBDXW (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 23:23:22 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38706 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeDBDXV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 23:23:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id u3-v6so18870095lff.5
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 20:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WEmkmDa3E1XmEMsBXRSqOeh5jhJaLq9jJtgWr8j7xxk=;
        b=ErAcxVaipl8S+VGgbVdk1RclqDju3/ZUa+GNTRmjmKeHVJQdYn++xAkgXW+xdxfZ+1
         NhWinnm6t/cxLssFveZ9Vd5KcxBmH6wA7sqfzF9gMNGtveVodj/TgJYdsRdnX6YKhx17
         2FIWsx0f55l2QVChD3UgMiqeHCsCu96oI5K3OXeb8Z7POkwZWM02Kh7LVUjZRuqW44AH
         LJr9x/qSKOdgCuiI4Anfa0vNXJo6OrmrYfXTqB+52FajWkZ01r5VWk8iYHj3+krikBLN
         4g/qaWSa1Ky8Fp68hhgWCzPRnuSbUDzaM1JrnRmuAcQih+wwpUeL/3EStyXZmSndrSGZ
         kP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WEmkmDa3E1XmEMsBXRSqOeh5jhJaLq9jJtgWr8j7xxk=;
        b=ODmG+dZgRtyl1lAtkoopUQ0yvWXtSAEC3ZliesLbsTRmnHi4xo96wFn+Fl94PCAmxs
         EGyiHMbwRx/VJtC4VSvgNDZGDQk9qAUogWsQfX688091k12lhaRPugNLWIsMbcaL9ZZT
         KzG8yez1pEOP6ZiSqvkr2/RUjwLNLKXXOzUCnoV6DKdW/PpG+mNjMn2UioVK+Xr5/7vk
         YpCoHIdkL7I9Tu1xVVZXI/0dRAf6Czepnj97Mev5rj9IgLvXXat5wd/QABJ0i7fxyUqc
         xkxA2OHFJe/7D2cdcU365dYiyQlNnXNDZHhG2u/TVZgYWT4g8T+o5WXOBk5FYgrDa/jz
         vfxw==
X-Gm-Message-State: ALQs6tAY4AorNfvgTrLZcRGVPOWhLTG8/D0JTMBKoNcJw1140KjeZvw/
        ULbdyaVT4kUdTaQXxFwWAWBVv9Lm
X-Google-Smtp-Source: AIpwx48hgw4xeiIUQ2NX/q8wvgHfcDQMUr6U/3eoTR3XN/DK5TlXTLmBSN+Y+qiVg2S6AnuLU7jSGg==
X-Received: by 10.46.23.70 with SMTP id l67mr4610760lje.132.1522639399973;
        Sun, 01 Apr 2018 20:23:19 -0700 (PDT)
Received: from localhost.localdomain (c-5eea2412-74736162.cust.telenor.se. [94.234.36.18])
        by smtp.gmail.com with ESMTPSA id i89-v6sm2792940lfk.12.2018.04.01.20.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Apr 2018 20:23:19 -0700 (PDT)
From:   Harald Nordgren <haraldnordgren@gmail.com>
To:     git@vger.kernel.org
Cc:     Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 2/2] ls-remote: create option to sort by versions
Date:   Mon,  2 Apr 2018 05:23:00 +0200
Message-Id: <20180402032300.85020-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <[PATCH] ls-remote: create option to sort by versions>
References: <[PATCH] ls-remote: create option to sort by versions>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updating tests and documentation

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-ls-remote.txt |  5 +++++
 t/t5512-ls-remote.sh            | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5f2628c8f..81c518a90 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -30,6 +30,11 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+-V::
+--version-sort::
+	Sort ref names by version semantics, so that refs/tags/v1.2 is sorted
+	before refs/tags/v1.10.
+
 --refs::
 	Do not show peeled tags or pseudorefs like HEAD	in the output.
 
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 02106c922..680a31223 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -10,6 +10,9 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m initial &&
 	git tag mark &&
+	git tag mark1.1 &&
+	git tag mark1.2 &&
+	git tag mark1.10 &&
 	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
 	(
 		echo "$(git rev-parse HEAD)	HEAD"
@@ -39,6 +42,17 @@ test_expect_success 'ls-remote self' '
 	test_cmp expected.all actual
 '
 
+test_expect_success 'ls-remote --version-sort --tags self' '
+	cat >expect <<-\EOF &&
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	EOF
+	git ls-remote --version-sort --tags self >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'dies when no remote specified and no default remotes found' '
 	test_must_fail git ls-remote
 '
@@ -131,7 +145,7 @@ test_expect_success 'Report no-match with --exit-code' '
 
 test_expect_success 'Report match with --exit-code' '
 	git ls-remote --exit-code other.git "refs/tags/*" >actual &&
-	git ls-remote . tags/mark >expect &&
+	git ls-remote . tags/mark* >expect &&
 	test_cmp expect actual
 '
 
@@ -178,6 +192,9 @@ test_expect_success 'ls-remote --symref' '
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/HEAD
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/remotes/origin/master
 	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.1
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.10
+	1bd44cb9d13204b0fe1958db0082f5028a16eb3a	refs/tags/mark1.2
 	EOF
 	git ls-remote --symref >actual &&
 	test_cmp expect actual
-- 
2.14.3 (Apple Git-98)

