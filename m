Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C08891F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfBTW7F (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:59:05 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:60114 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfBTW7F (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Feb 2019 17:59:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KMrOr5026552;
        Wed, 20 Feb 2019 14:58:50 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qph8rdyus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 20 Feb 2019 14:58:50 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Feb 2019 14:58:46 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 20 Feb 2019 14:58:46 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1229D2216324;
        Wed, 20 Feb 2019 14:58:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/5] git-fast-import.txt: fix wording about where ls command can appear
Date:   Wed, 20 Feb 2019 14:58:43 -0800
Message-ID: <20190220225846.10658-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.5.g8f70af2367
In-Reply-To: <20190220225846.10658-1-newren@gmail.com>
References: <20190220225846.10658-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_18:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The docs claimed `ls` commands could appear almost anywhere, but the
code told a different story.  Modify the docs to match the code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 339b6e7e98..f7e2d330b1 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1016,8 +1016,8 @@ printing a blob from the active commit (with `cat-blob`) or copying a
 blob or tree from a previous commit for use in the current one (with
 `filemodify`).
 
-The `ls` command can be used anywhere in the stream that comments are
-accepted, including the middle of a commit.
+The `ls` command can also be used where a `filemodify` directive can
+appear, allowing it to be used in the middle of a commit.
 
 Reading from the active commit::
 	This form can only be used in the middle of a `commit`.
-- 
2.21.0.rc2.5.g8f70af2367

