Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C7E1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 13:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeFDNjc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 09:39:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34637 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753063AbeFDNjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 09:39:32 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so8618459wro.1
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiMhe2rINtcGBf5Yr1ZjNvg7Q48ScnfZtsJ4NsXFcIk=;
        b=rt8xuk1D72nMLDXkHy4u2CxIWi5OHQ+sWp1FSvwATGNtg0T0pvQUwhrCXsAnCijDY6
         NIJ9MfshnLh/6yiZ3+lBLwQsqzYlq9JRWUd2K1BDwtDMcMjE9KHtTu1+c9W25JGeBqo4
         TzTdL2ywodac4iWXnoQaTxJ5EwE5m6BmNLTafczt2PbDWdhuzbzFq0CS/o9EimZ/+xhe
         wydoMpu2tEsurhrBJEfWDBkF5uB2uCeb+J3UN3lxbB0RDykS3daavh4iQoZy3wMT8w+W
         dsSZVcIGQwFo9VDoZYU+P3Xd3ftvFa5DEmBsvp8JKnbOZHO0Eir5L/GGDR6LiUDvLKvb
         jWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IiMhe2rINtcGBf5Yr1ZjNvg7Q48ScnfZtsJ4NsXFcIk=;
        b=l/QUQIGBZaAT+eYmCYu/4zqsabuVrxQrWTxVn6Ga4LLPI9C2VBoSt6KvLlqmyr3ZDf
         noXFJPTBrOevQV8Narra9CDV+9m0PPvcZd2gwuPjhC2weYo19bO8DE3jhwEiL/29Vlvw
         GbZyeoOvaTL8e0FcDI4B7dGkRF9897LoJJR93W9kJBvtOr16LP7iLNgHh0dgGeRMYh+V
         6e3RNdSw7JZouqtD5Pxs6cWD9EuQw47aOWcNuU4kos6ScP3FSfdsfxRgfRsnzO2cBaj6
         xS8TLo7Xsoj508Gs6HIg8DfnDim7kTzv3k4ilnqJx3xVPzpC7x5GLZfe7wHgx77+IMhq
         uBmA==
X-Gm-Message-State: ALKqPwdjm3sZ9hbcitzF2yUTB/nM9a82UdthTKiXP4LkypMtqHQ7IOAd
        CP3IzJgwfOSlCDFkED+7keA=
X-Google-Smtp-Source: ADUXVKJw9b5a7EcgtRhHlKkBNEgf1mZhYbQ1p5vRqd7aCCjpwwn+kBT7tWutMpTj+Nv7f7DAvGk+wA==
X-Received: by 2002:a50:8b45:: with SMTP id l63-v6mr24389969edl.240.1528119570997;
        Mon, 04 Jun 2018 06:39:30 -0700 (PDT)
Received: from localhost.localdomain (x590cb90a.dyn.telefonica.de. [89.12.185.10])
        by smtp.gmail.com with ESMTPSA id j22-v6sm24970750edq.92.2018.06.04.06.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jun 2018 06:39:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] t7510-signed-commit: use 'test_must_fail'
Date:   Mon,  4 Jun 2018 15:39:25 +0200
Message-Id: <20180604133926.16558-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two tests 'detect fudged signature' and 'detect fudged signature
with NUL' in 't7510-signed-commit.sh' check that 'git verify-commit'
errors out when encountering a forged commit, but they do so by
running

  ! git verify-commit ...

Use 'test_must_fail' instead, because that would catch potential
unexpected errors like a segfault as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7510-signed-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 762135adea..663bf68def 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -145,7 +145,7 @@ test_expect_success GPG 'detect fudged signature' '
 
 	sed -e "s/seventh/7th forged/" raw >forged1 &&
 	git hash-object -w -t commit forged1 >forged1.commit &&
-	! git verify-commit $(cat forged1.commit) &&
+	test_must_fail git verify-commit $(cat forged1.commit) &&
 	git show --pretty=short --show-signature $(cat forged1.commit) >actual1 &&
 	grep "BAD signature from" actual1 &&
 	! grep "Good signature from" actual1
@@ -156,7 +156,7 @@ test_expect_success GPG 'detect fudged signature with NUL' '
 	cat raw >forged2 &&
 	echo Qwik | tr "Q" "\000" >>forged2 &&
 	git hash-object -w -t commit forged2 >forged2.commit &&
-	! git verify-commit $(cat forged2.commit) &&
+	test_must_fail git verify-commit $(cat forged2.commit) &&
 	git show --pretty=short --show-signature $(cat forged2.commit) >actual2 &&
 	grep "BAD signature from" actual2 &&
 	! grep "Good signature from" actual2
-- 
2.18.0.rc0.207.ga6211da864

