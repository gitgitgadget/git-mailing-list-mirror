Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8FF51F462
	for <e@80x24.org>; Thu, 20 Jun 2019 02:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbfFTCJ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 22:09:29 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:54658
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbfFTCJ3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Jun 2019 22:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1560996567;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=QEtYAHCps+Kt/B1nC2bWoYdJtstb3CxC7s0uA4wjXmg=;
        b=lu60Z5/l5IQ08F70YppGbNqj7620DyuR/rccOY4tZvffKfXVcbfU/IM5Sj0i+pHT
        K0hXW6nH67SbARxCK87GethK43Lx24YCRIzWhJC94AHEb9x7X1qL4ASAbY1oYGRvquX
        RGzumuTzmlxQSKUl8QHlQv38m0vB5wYCRlePj2wQ=
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016b72a55a7d-fb4ecdb7-9f2b-4204-b888-0000f209c3ff-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
References: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: mention that 'git submodule update' fetches missing
 commits
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Jun 2019 02:09:27 +0000
X-SES-Outgoing: 2019.06.20-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git submodule update' will fetch new commits from the submodule remote
if the SHA-1 recorded in the superproject is not found. This was not
mentioned in the documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2794e2978021c..930bfcee50e4c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -132,7 +132,8 @@ update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--forc
 +
 --
 Update the registered submodules to match what the superproject
-expects by cloning missing submodules and updating the working tree of
+expects by cloning missing submodules, fetching missing submodule commits
+and updating the working tree of
 the submodules. The "updating" can be done in several ways depending
 on command line options and the value of `submodule.<name>.update`
 configuration variable. The command line option takes precedence over

--
https://github.com/git/git/pull/596
