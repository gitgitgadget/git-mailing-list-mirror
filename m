Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDD120248
	for <e@80x24.org>; Mon, 15 Apr 2019 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfDOTYD (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 15:24:03 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:44962
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729566AbfDOTYC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Apr 2019 15:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1555356240;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=0N6qF9zWXsJG/yzZhR1wIpaO+biPqLLUqezUjX34ACg=;
        b=fHxl1mu2lcPp4qXGGAxBEiGARfd7Tf0Qd8oyYr1WcbVgwhuK7M4mS3fK5G4OBhA4
        E4r+TWp5ORXhMDTytzziGOBE9mQ4EzKkgiLoeWXTt4Aox5omrZlZiVfU6lJd71JIzoJ
        gxhUp+iIGZNvXP98ZE6SwBnRzjwRzK3iAI5dA6iA=
From:   Philippe Blain <philippe.blain@canada.ca>
To:     git@vger.kernel.org
Message-ID: <0102016a2274c90f-3dbf792f-5b0a-4da4-ada0-9a163a14e68d-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-submodule.txt: mention that 'git submodule update'
 fetches missing commits
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Apr 2019 19:24:00 +0000
X-SES-Outgoing: 2019.04.15-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git submodule update' will fetch new commits from the submodule remote
if the SHA-1 recorded in the superproject is not found. This was not
mentioned in the documentation.
---
 Documentation/git-submodule.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ba3c4df550acf..026ee07a2b641 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -128,7 +128,8 @@ update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--forc
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
