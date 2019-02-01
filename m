Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0681F453
	for <e@80x24.org>; Fri,  1 Feb 2019 08:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfBAIgQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 03:36:16 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:49260
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728701AbfBAIgP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Feb 2019 03:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1549010174;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=CoHfwvv806j+WtH2P41exUEKmmn95oem7/2hI5qRUz8=;
        b=aY/HMRzkAkrdihEi4u7YXYOPKG+KDV8GE+IVRGG2rcwekQRUAqz4+YCwl3ivL4Ih
        fLAnEv8e3vbHiVNK6d/uEQR/NXybgiVTCuE7APb5h4k7cbh51EmpPAON8Ikzjw8st5x
        9NbyYA6M0tiAiJlTEw6z5Uj4VbZ4jpLoJBRorWFM=
From:   Shahzad Lone <shahzadlone@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020168a83380fb-ecad8400-915d-497c-841f-096541747cd6-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
References: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
Subject: [PATCH 2/3]  ISO C90 forbids mixed declarations and code
 [-Werror=declaration-after-statement] so fix that.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 1 Feb 2019 08:36:14 +0000
X-SES-Outgoing: 2019.02.01-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 pack-revindex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-revindex.c b/pack-revindex.c
index 202981b39c6b6..40651ec9fac2e 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -186,9 +186,9 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 {
-
+	int pos;
 	load_pack_revindex(p);
-	const int pos = find_revindex_position(p, ofs);
+	pos = find_revindex_position(p, ofs);
 
 	if (pos < 0)
 		return NULL;

--
https://github.com/git/git/pull/572
