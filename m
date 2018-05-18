Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F721F42D
	for <e@80x24.org>; Fri, 18 May 2018 09:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeERITR (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 04:19:17 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:59766
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752972AbeERITL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 18 May 2018 04:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1526631549;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=YjeysnzsMJoW6FqupgDY8Pr01+hJNjqh+ItsA7hREyc=;
        b=atQOPHbOGqvxAtpfZ6Q+3BB5rg00v5mk1QtjLt4Tvap6q6W7ARhPz3jCIgvBOipK
        nJPti99x05kT1w/4Og/ZOYwdgHtENDnn3FVK9fVVp68c5vcpoeic7JsaVlZAhL9/23h
        1ajEcLrBTGBxcHAVHpFmDRVLid/Gm9+xsfCA3pmg=
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
To:     git@vger.kernel.org
Message-ID: <010201637254ca06-74d231ce-8927-4928-964c-5170b1a919f8-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
References: <010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com>
Subject: [PATCH RFC v2 3/4] ref-filter: add tests for objectsize:disk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 May 2018 08:19:09 +0000
X-SES-Outgoing: 2018.05.18-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for %(objectsize:disk) atom.

Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
---
 t/t6300-for-each-ref.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 295d1475bde01..570bb606045d7 100755
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
@@ -124,6 +125,7 @@ test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize 154
+test_atom tag objectsize:disk 138
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
 test_atom tag objectname:short $(git rev-parse --short refs/tags/testtag)
 test_atom head objectname:short=1 $(git rev-parse --short=1 refs/heads/master)

--
https://github.com/git/git/pull/493
