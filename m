Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07CD1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKIRXY (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 12:23:24 -0500
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:53218
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728042AbeKIRXX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Nov 2018 12:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1541749441;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=LteZiyG4GvnRbfmbT6nR+Yr3mGsc4eQ0DTIRWP4awT0=;
        b=oN0IZOJ4nM7hb7BOX6OezSI7zw3jvZz7JcCe3HVKlwPsuilfwqbVSv+9xGogsi7P
        642qfYxkrhX713RO4sREJ3VLkfcyEt8R0G6nRpdO8HZB47N5NHZJosLMnYDQZpzvJwB
        UiER54URsNwB5kfrDdJNw2uNFSm0KfKMvD2NJosE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020166f76d84c0-b00f024c-db52-45d4-b973-3107576a3860-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
References: <01020166f76d845f-1a02a31e-5094-4b27-974d-a23811066c58-000000@eu-west-1.amazonses.com>
Subject: [RFC PATCH 2/5] ref-filter: add tests for objectsize:disk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 9 Nov 2018 07:44:01 +0000
X-SES-Outgoing: 2018.11.09-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test new formatting atom.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 t/t6300-for-each-ref.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 97bfbee6e8d69..097fdf21fe196 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -83,6 +83,7 @@ test_atom head push:strip=1 remotes/myfork/master
 test_atom head push:strip=-1 master
 test_atom head objecttype commit
 test_atom head objectsize 171
+test_atom head objectsize:disk 138
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -124,6 +125,8 @@ test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
+test_atom tag objectsize:disk 138
+test_atom tag '*objectsize:disk' 138
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)

--
https://github.com/git/git/pull/552
