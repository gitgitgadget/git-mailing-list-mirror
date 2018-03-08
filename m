Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 432851FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 10:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755674AbeCHKEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 05:04:06 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:37144
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755618AbeCHKEF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2018 05:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1520503443;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=tt5g3i1HQYsJWJgbx+5QpC5PXx88iGmocGAI+OXjhE0=;
        b=RQsufprlTx7c5I9cUOCXUgPuz2GxbNrvKGLGjCao3kYTthi9BjCO3/OSgTA2WpHt
        VzoB1EYD9IH4RyjcENoFuFhlSepqW6TU3JM/lIsfytv4M+SXaanjHeCitPnAFxQm2Gl
        6xIAPDrIh2NtYJOfxi/UdZJkiwSOgbRixnpk5C2g=
From:   Thomas Levesque <thomas.levesque@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016205115067-f3cdd5f1-2d69-4464-a665-db3a28360260-000000@eu-west-1.amazonses.com>
Subject: [PATCH] userdiff.c: Add C# async keyword in diff pattern
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 8 Mar 2018 10:04:03 +0000
X-SES-Outgoing: 2018.03.08-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently C# async methods are not shown in diff hunk headers. I just
added the async keyword to the csharp method pattern so that they are
properly detected.
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index dbfb4e13cddce..b92caf42b27be 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -138,7 +138,7 @@ PATTERNS("csharp",
 	 /* Keywords */
 	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
 	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
 	 /* Properties */
 	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
 	 /* Type definitions */

--
https://github.com/git/git/pull/464
