Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6A91F576
	for <e@80x24.org>; Mon, 12 Feb 2018 08:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeBLIKD (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 03:10:03 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:58624
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932985AbeBLIIz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Feb 2018 03:08:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518422934;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=j3n9vkQi8yyTXI+r61USzwtCgcUKUoASCh7/ePcgnOo=;
        b=FDwI1qdbxeYgHlguHdaQ6uhgzjwXYI2QYi+dB/+AOrkDkE+fMnAHajLmih2c7T70
        RetyHJqfzS5lebnGLlfMQP02n4WCUtnkA5uLz5GcMv1vs4RxMDpkaeVJPKpKIh+pQ3K
        vovh9yA+gDiDkdZ4oiiZu+keCjza6FJraJoOcA/Q=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161890f4391-9f76231a-4768-461b-80b9-02cada27a943-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 23/23] cat-file: update of docs
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Feb 2018 08:08:54 +0000
X-SES-Outgoing: 2018.02.12-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the docs for cat-file command. Some new formatting atoms added
because of reusing ref-filter code.
We do not support cat-file atoms in general formatting logic
(there is just the support for cat-file), that is why some of the atoms
are still explained in cat-file docs.
We need to move these explanations when atoms will be supported
by other commands.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index f90f09b03fae5..90639ac21d0e8 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -187,17 +187,8 @@ linkgit:git-rev-parse[1].
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
 object, with placeholders of the form `%(atom)` expanded, followed by a
-newline. The available atoms are:
-
-`objectname`::
-	The 40-hex object name of the object.
-
-`objecttype`::
-	The type of the object (the same as `cat-file -t` reports).
-
-`objectsize`::
-	The size, in bytes, of the object (the same as `cat-file -s`
-	reports).
+newline. The available atoms are the same as that of
+linkgit:git-for-each-ref[1], but there are some additional ones:
 
 `objectsize:disk`::
 	The size, in bytes, that the object takes up on disk. See the

--
https://github.com/git/git/pull/452
