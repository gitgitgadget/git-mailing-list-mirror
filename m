Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307A91F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeJMFAU (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 01:00:20 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39094 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbeJMFAU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Oct 2018 01:00:20 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9CLNeXW011256;
        Fri, 12 Oct 2018 14:25:55 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2mxtwhajtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 12 Oct 2018 14:25:55 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.160.10.15) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 12 Oct 2018 14:25:53 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.160.10.15) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 12 Oct 2018 14:25:53 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 12 Oct 2018 14:25:53 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 623BF209F04D;  Fri, 12 Oct 2018 14:25:53 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/4] More merge cleanups
Date:   Fri, 12 Oct 2018 14:25:47 -0700
Message-ID: <20181012212551.7689-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.235.g7c386e1068
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=410 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810120214
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series builds on en/merge-cleanup.  Technically, this could be
broken into three separate topics with only one of them depending on
en/merge-cleanup, but I have a subsequent series that depends on both
en/merge-cleanup and the fixes here, so I'm submitting these four
patches as a set.

Elijah Newren (4):
  t6036: add testcase where virtual merge base contains nested conflicts
  merge-recursive: increase marker length with depth of recursion

    Improving diff3 conflict markers in the face of arbitrarily deeply
    nested conflicts

  merge-recursive: improve auto-merging messages with path collisions

    Simple attempt at wording improvement

  merge-recursive: Avoid showing conflicts with merge branch before HEAD

    Conflict markers are expected to be shown in a certain order

 ll-merge.c                        |   4 +-
 ll-merge.h                        |   1 +
 merge-recursive.c                 |  59 +++++++++--
 t/t6036-recursive-corner-cases.sh | 159 +++++++++++++++++++++++++++++-
 4 files changed, 208 insertions(+), 15 deletions(-)

-- 
2.19.0.235.g7c386e1068

