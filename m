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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C84E20248
	for <e@80x24.org>; Mon,  1 Apr 2019 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDAQC5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:02:57 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53498 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfDAQC5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Apr 2019 12:02:57 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31Frtf5021178;
        Mon, 1 Apr 2019 09:00:23 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2rkfhxgh6j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 01 Apr 2019 09:00:23 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 1 Apr 2019 09:00:14 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 1 Apr 2019 09:00:14 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 328B922595FB;
        Mon,  1 Apr 2019 09:00:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        David Barr <david.barr@cordelta.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/5] git-fast-import.txt: fix wording about where ls command can appear
Date:   Mon, 1 Apr 2019 09:00:08 -0700
Message-ID: <20190401160011.20678-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.5.gde71272ddd
In-Reply-To: <20190401160011.20678-1-newren@gmail.com>
References: <20190220225846.10658-1-newren@gmail.com>
 <20190401160011.20678-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=778 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010106
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
2.21.0.1.g0a561c1dbd

