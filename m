Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2235920986
	for <e@80x24.org>; Tue, 27 Sep 2016 14:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbcI0OKZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 10:10:25 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:46456
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753865AbcI0OKY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 10:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1474985422;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=TMgfLKK8saUXGFL0JpigHXviWsJ+21I4qQQyaFV01No=;
        b=csGvkqFC72kDIHPq1MXic2meUBa4Xb9ud7d9adsiIoN9IcXnqFOm1RAwr5dRIAJV
        YhLKy5BIKyaBbW54jBaurzn8w7Agplq48sR1If52vj0evXj/42OUSg6MfZOmJ7kICx+
        lcwbKMqx9qG0fnllthVU+EmbXi/1/K7wjFdS8hdM=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201576bfb6c7d-0b68228f-9503-4dd1-9721-713477fa2596-000000@eu-west-1.amazonses.com>
In-Reply-To: <201609271240.19759.sweet_f_a@gmx.de>
References: <201609271240.19759.sweet_f_a@gmx.de>
Subject: [PATCH] rev-list-options: clarify the usage of -n/--max-number
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Sep 2016 14:10:22 +0000
X-SES-Outgoing: 2016.09.27-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-n=<number>, -<number>, --max-number=<number> shows the last n commits
specified in <number> irrespective of whether --reverse is used or not.
With --reverse, it just shows the last n commits in reverse order.

Reported-by: Ruediger Meier <sweet_f_a@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
Hey Ruegiger,

The description is a bit inappropriate for --max-count and thus this
patch.

I cannot comment whether --max-count=-n would be a good choice or not
because personally I never left the need of it. I normally use --reverse
so as to review my patches in a branch serially. So for me the current
usage of --reverse seems more appropriate.
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7e462d3..6b7c2e5 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -18,7 +18,7 @@ ordering and formatting options, such as `--reverse`.
 -<number>::
 -n <number>::
 --max-count=<number>::
-	Limit the number of commits to output.
+	Limit to last n number of commits to output specified in <number>.
 
 --skip=<number>::
 	Skip 'number' commits before starting to show the commit output.

--
https://github.com/git/git/pull/296
