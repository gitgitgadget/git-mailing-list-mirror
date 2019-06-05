Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639221F462
	for <e@80x24.org>; Wed,  5 Jun 2019 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfFET03 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 15:26:29 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:51351 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 15:26:29 -0400
Received: by mail-pl1-f201.google.com with SMTP id d2so16682330pla.18
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vBDM7PQbQBN3GWtFL9iJ2l/dj9SpOjlWgDfcpsTG34U=;
        b=aG+3RuxiO/C51ZvfooGp0/pdnicBn43LktLR8Wr3NvYZbG0HNQ3W76fJsOO5pSf7rT
         usDxZbAUDVgHKGTfeuhU+LGrcQ3viqWIfVXpjtrkO28cvLseJbh9l+zN2XEQDJcIXHZK
         v9A8/wuyivO3tdPF+qtgFr9N1AEai0O+gLE3lckG1+FjUYY4XAYzVVIUgpIDPvkOv2uQ
         +xHO6NgAprIh0DFLEbkVetJEl90CC6q+rtFcKDTyzIHE1wRtEFtjkdMZJsNJu9heem1t
         3UvYE2riMX66bt/KD7jvZHaio+29JlPXt9KYcXgEUkMuOtKrfli4EOc8T/Er9esvjLay
         jK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vBDM7PQbQBN3GWtFL9iJ2l/dj9SpOjlWgDfcpsTG34U=;
        b=tc0X9TO2UXhkgZLXZzb8V+6j8bM0VhnHz2iRoDWciT8zN6DKbOvRfMb2ExtMTWngtn
         JwEqwdf4yepPaRPfZPRcC/LtlK8WY3Riv1T7+ZP9Q2dQQp4cqFpYlcL7pI6MNlXPoSLw
         vEp7lsp2Iw2BNZl/+p2wV+vaZEBbA7HjuVzfR8WCQ+tMrjoXzSqPuxqj6U1jBuCJCHKl
         Ah/Xt7iRRicrYCkTzON4R3CSg9PfQ0sEFLza0/bHatSVEEkWRN7p2GQyJhH/ocVCeYnX
         fSpMt8bjpXCs9M2dK+xuNf70mFyWtdaWr5k+BauVwsCLD5r4CRlxKyhusCdmoBq9lS2w
         PV8g==
X-Gm-Message-State: APjAAAWM5OubBe7hmmOBinrAf8aPR4CZP9acV9fm6jJZ9wRvQcXImMTO
        MlL7rh5GlsRGTA301kULux0T+pvSeRWMwyoJzpJdo0jd4W2ZTkHKs48yD1I/MiI0J+USL1hRVow
        16KJovWlDfxzeSqmzckzTolGpYdcxDFeVTPasobcugbQsuhSFFRd+vicBnNwtPf2K+Io/CccuA0
        Nw
X-Google-Smtp-Source: APXvYqywb1IwEDlkD/DSsOgGFrlNKamJHW/VMZdJjigbznbuDiAexGWOCTd9kGdP+Ql3vKG0FG0ugz0zX5/26Aa/Wg3i
X-Received: by 2002:a63:c20c:: with SMTP id b12mr409883pgd.3.1559762788375;
 Wed, 05 Jun 2019 12:26:28 -0700 (PDT)
Date:   Wed,  5 Jun 2019 12:26:24 -0700
Message-Id: <20190605192624.129677-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH] t5551: test usage of chunked encoding explicitly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When run using GIT_TEST_PROTOCOL_VERSION=2, a test in t5551 fails
because 4 POSTs (probe, ls-refs, probe, fetch) are sent instead of 2
(probe, fetch).

One way to resolve this would be to relax the condition (from "= 2" to
greater than 1, say), but upon further inspection, the test probably
shouldn't be counting the number of POSTs. This test states that large
requests are split across POSTs, but this is not correct; the main
change is that chunked transfer encoding is used, but the request is
still contained within one POST. (The test coincidentally works because
Git indeed sends 2 POSTs in the case of a large request, but that is
because, as stated above, the first POST is a probing RPC - see
post_rpc() in remote-curl.c for more information.)

Therefore, instead of counting POSTs, check that chunked transfer
encoding is used. This also has the desirable side effect of passing
with GIT_TEST_PROTOCOL_VERSION=2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
With this change, all tests pass at master with
GIT_TEST_PROTOCOL_VERSION=2.
---
 t/t5551-http-fetch-smart.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index ac74626a7b..aed2d9bb05 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -301,11 +301,10 @@ test_expect_success CMDLINE_LIMIT \
 	)
 '
 
-test_expect_success 'large fetch-pack requests can be split across POSTs' '
+test_expect_success 'large fetch-pack requests can be sent using chunked encoding' '
 	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
-	grep "^=> Send header: POST" err >posts &&
-	test_line_count = 2 posts
+	grep "^=> Send header: Transfer-Encoding: chunked" err
 '
 
 test_expect_success 'test allowreachablesha1inwant' '
-- 
2.22.0.rc1.311.g5d7573a151-goog

