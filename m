Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3FFA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJaTr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJaTrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 15:47:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D813F3E
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:47:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w14so17399942wru.8
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXjpn/eMv/WsVZc9a3q6EhFp1JhIMrQO4clr+0E1f4Q=;
        b=NIYpRNe0kbY8p5bXKxQlczRpJatZErVJU8lZV0IKmq7afurQarokuYAuYZUMUTyzat
         7sX1Ob4H7eT3wv4UlAde+EqYWi8o1y3vIbqIwS1XTFrdRRVSwq/Eb/J+ynj1+YyFwzMz
         uwgSWb6Mcv/U42UOZ0kcybYoJRjWlvABN68YZJ+FoPsj350imuwwHXOS+sV0+a7OosYA
         ockjqiEYYB+LFIrTfZ15U4BDw88Ri6paLliqRFEpAc51ZR7vf3V5hvoUgLv/VTtSStW3
         vazT9+MtEM7jlaFiNQtBaNI1Ydg/f3W/iIJdPtJHzCPM+NUvLo7PFeUhA6BZpGhmAMoe
         FOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXjpn/eMv/WsVZc9a3q6EhFp1JhIMrQO4clr+0E1f4Q=;
        b=7lUQllSCojFyFg/1TqJp/Q1s9Br98Gd+MCV1ivSTOh1P33mcuvKpgS70i2wndAYWuu
         cDry0oqDeP7u4aPDKAbuHAhnMZvEaKUXijOzEw5VvM2AWKSBrvocQTZx4N5/eXNue6q3
         fRwkStt3DrpFjQktiTnZPfx7ig/DOglgsxDaN11FhMrTZ/Kb19sqDG3+qo2o1YVsDiYR
         5b4b573Jush8E6u3nq8Tj1BJV+aAH6hn3OpEc0Zms6xVKa6mZBFe1lrlYxBX5JCVJjd/
         s6lQ0bMKstLencZtemY6g3qnxfq80S6uAZmyRCrGcdh3OhYjlwKqbgAmk2anlin+WB8t
         sMjA==
X-Gm-Message-State: ACrzQf2zn28JLSc2unyW3A9fYhGBhAPbLfH2uuC4hcBVid/2YhcnU7ZN
        9yvGaK8bYErzG3aLhXy/TpbJrAB5/hQ=
X-Google-Smtp-Source: AMsMyM6xYkKXZBYLb8zDJaqX8ZlgFC86Z1DmS7sY+ryMYfcGyC2xI4VlesHlD8bouklFREUtKupEGg==
X-Received: by 2002:a5d:5346:0:b0:235:6c05:6272 with SMTP id t6-20020a5d5346000000b002356c056272mr9492940wrv.332.1667245641011;
        Mon, 31 Oct 2022 12:47:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020a056000124600b0022e653f5abbsm7979614wrx.69.2022.10.31.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:47:20 -0700 (PDT)
Message-Id: <25cc0f6d91a9d23eb1b755e1463d672e4958a4e9.1667245639.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Oct 2022 19:47:17 +0000
Subject: [PATCH 1/2] t5516/t5601: avoid using `localhost` for failing HTTPS
 requests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 6dcbdc0d6616 (remote: create fetch.credentialsInUrl config,
2022-06-06), we added four test cases that validate various behavior
around passing credentials as part of the URL (which is considered
unsafe in general).

These tests do not _actually_ try to connect anywhere, but have to use
the https:// protocol in order to validate the intended code paths.

However, using `localhost` for such a connection causes several
problems:

- There might be a web server running on localhost, and we do not
  actually want to connect to that.

- The DNS resolver, or the local firewall, might take a substantial
  amount of time (or forever, whichever comes first) to fail to connect,
  slowing down the test cases unnecessarily.

Let's instead use an IPv4 address that is guaranteed never to offer a
web server: 224.0.0.1 (which is part of the IP multicast range).

Incidentally, this seems to fix an issue where the tests fail in the
Windows jobs of Git's CI builds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5516-fetch-push.sh | 18 +++++++++---------
 t/t5601-clone.sh      | 10 +++++-----
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 79dc470c014..8dd4610a8c2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1854,32 +1854,32 @@ test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
 '
 
 test_expect_success LIBCURL 'fetch warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
+	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
+	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@224.0.0.1 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@224.0.0.1 2>err &&
 	grep "warning: $message" err >warnings &&
 	test_line_count = 3 warnings &&
 
-	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@224.0.0.1 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings &&
 
-	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:@224.0.0.1 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
 
 
 test_expect_success LIBCURL 'push warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow push https://username:password@localhost 2>err &&
+	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
+	test_must_fail git -c transfer.credentialsInUrl=allow push https://username:password@224.0.0.1 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c transfer.credentialsInUrl=warn push https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn push https://username:password@224.0.0.1 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_must_fail git -c transfer.credentialsInUrl=die push https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die push https://username:password@224.0.0.1 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..0b386c74818 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -72,19 +72,19 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 '
 
 test_expect_success LIBCURL 'clone warns or fails when using username:password' '
-	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
+	message="URL '\''https://username:<redacted>@224.0.0.1/'\'' uses plaintext credentials" &&
+	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@224.0.0.1 attempt1 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@224.0.0.1 attempt2 2>err &&
 	grep "warning: $message" err >warnings &&
 	test_line_count = 2 warnings &&
 
-	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@224.0.0.1 attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings &&
 
-	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@224.0.0.1 attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
-- 
gitgitgadget

