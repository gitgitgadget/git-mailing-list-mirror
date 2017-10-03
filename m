Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DEA202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdJCNol (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:44:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:59154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751296AbdJCNol (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:44:41 -0400
Received: (qmail 29552 invoked by uid 109); 3 Oct 2017 13:44:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:44:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7949 invoked by uid 111); 3 Oct 2017 13:44:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:44:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:44:39 -0400
Date:   Tue, 3 Oct 2017 09:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 08/12] t3203: drop "always" color test
Message-ID: <20171003134438.fmjc5nziuw24hnot@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for the behavior of "always" changing to
match "auto", we can simply drop this test. We already check
other forms (like "--color") independently.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t3203-branch-output.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 86286f263d..ee6787614c 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -258,12 +258,6 @@ test_expect_success TTY '%(color) present with tty' '
 	test_cmp expect.color actual
 '
 
-test_expect_success 'color.branch=always overrides auto-color' '
-	git -c color.branch=always branch $color_args >actual.raw &&
-	test_decode_color <actual.raw >actual &&
-	test_cmp expect.color actual
-'
-
 test_expect_success '--color overrides auto-color' '
 	git branch --color $color_args >actual.raw &&
 	test_decode_color <actual.raw >actual &&
-- 
2.14.2.1079.gce6b466188

