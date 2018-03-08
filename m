Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5978C1FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935224AbeCHLFf (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:05:35 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:46504
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754837AbeCHLFe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2018 06:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1520507132;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=uQXpZnDPZgJGchPNoKfT6UldAelS6sxrzLjRnzt4Uy4=;
        b=AXyc7SQw/+Rvb1JD/3X3lIqWTXjjmCZAlUpqUIRwvzwgWtcpIXDqGAP2haHV3YAl
        K9lFSADBPEH6PfZtldKe8oZ2wHo2SC/q5Y9P+50CZXNtx0DMXwlZxXodXVaQ0sI9MkI
        V706qGPsAytrknMeNmE49dbGZoLCLof5W6ifpzpI=
From:   Thomas Levesque <thomas.levesque@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016205499aff-6779e882-12d1-481e-8594-c02d72aa7165-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAPig+cTPMqf1hN-fsaAkdZwCEH94ZPYJbfSE_rcjFCoSobxK5Q@mail.gmail.com>
References: <CAPig+cTPMqf1hN-fsaAkdZwCEH94ZPYJbfSE_rcjFCoSobxK5Q@mail.gmail.com>
Subject: [PATCH] userdiff.c: Add C# async keyword in diff pattern
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 8 Mar 2018 11:05:32 +0000
X-SES-Outgoing: 2018.03.08-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently C# async methods are not shown in diff hunk headers. I just
added the async keyword to the csharp method pattern so that they are
properly detected.

Signed-off-by: Thomas Levesque <thomas.levesque@gmail.com>
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
