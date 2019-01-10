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
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D881F803
	for <e@80x24.org>; Thu, 10 Jan 2019 06:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfAJGcY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 01:32:24 -0500
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:45648
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727269AbfAJGcS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Jan 2019 01:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1547101936;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=LteZiyG4GvnRbfmbT6nR+Yr3mGsc4eQ0DTIRWP4awT0=;
        b=Q7KLjE+2yTy1QQ4SNXtQVqleV59j69MpmYE7WQOJS+wWSa3dDpCZCksYqS3c2dc/
        W4OT1amdWj+/AiQq/vMjd3gfPomfhOqBpeiOQ4XietfI5w8ahlV71WN1YkEIxzxc49M
        nNUHvvtIuf1r8NUMJBHBaXwf5JSPlUQXEc2ExfKc=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016836761c52-72d7257e-c341-40e7-8e29-216af7b219f9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
References: <0102016836761b8b-8616fc01-3489-4e53-a5b7-cd4b52e20e01-000000@eu-west-1.amazonses.com>
Subject: [PATCH v3 3/6] ref-filter: add tests for objectsize:disk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Jan 2019 06:32:16 +0000
X-SES-Outgoing: 2019.01.10-54.240.7.18
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
