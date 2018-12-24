Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C33120A1E
	for <e@80x24.org>; Mon, 24 Dec 2018 13:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeLXNYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Dec 2018 08:24:32 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:37554
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbeLXNYc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Dec 2018 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1545657870;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ImRxXuYDUEWle310kt75qYmF/rXx2XuFAAHDRp4yavA=;
        b=u5ujpw9S+w//pe+PoOsKpw6dhWUIo32zf5as2Byi+d6yrbItc1Yub7Uvgyp5Gjgz
        tJtlsW93G+2dgpyDXBVUYdii9FojVeVomE+x1B+Yj/qFocFMdKNWYpFIKUO3eCbNXAB
        9FhKkSDyifBL9ajMaXPIao7vIIu04kyjf2TeUpBE=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020167e06368ee-092ccd7f-6f37-425b-9eb3-bdd9b1cb8358-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
References: <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 5/6] ref-filter: add tests for deltabase
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Dec 2018 13:24:30 +0000
X-SES-Outgoing: 2018.12.24-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test new formatting option deltabase.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 t/t6300-for-each-ref.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 097fdf21fe196..0ffd63071392e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -84,6 +84,7 @@ test_atom head push:strip=-1 master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectsize:disk 138
+test_atom head deltabase 0000000000000000000000000000000000000000
 test_atom head objectname $(git rev-parse refs/heads/master)
 test_atom head objectname:short $(git rev-parse --short refs/heads/master)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)
@@ -127,6 +128,8 @@ test_atom tag objecttype tag
 test_atom tag objectsize 154
 test_atom tag objectsize:disk 138
 test_atom tag '*objectsize:disk' 138
+test_atom tag deltabase 0000000000000000000000000000000000000000
+test_atom tag '*deltabase' 0000000000000000000000000000000000000000
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)

--
https://github.com/git/git/pull/552
