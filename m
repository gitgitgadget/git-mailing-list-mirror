Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60C6E1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbeISVxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:53:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51602 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732154AbeISVxP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Sep 2018 17:53:15 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGEcJT016698;
        Wed, 19 Sep 2018 09:14:38 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mgyxh7en7-1;
        Wed, 19 Sep 2018 09:14:38 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 0A4B92175D48;
        Wed, 19 Sep 2018 09:14:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/4] Cleanup of merge_*() functions in merge-recursive
Date:   Wed, 19 Sep 2018 09:14:30 -0700
Message-Id: <20180919161434.3272-1-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.12.gc6760fd9a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=383 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on a series to make file collision conflict handling
consistent, I discovered a latent bug in merge_content()...and several
opportunities for cleanup.  This series fixes that bug, deletes the
merge_file_special_markers() and merge_file_one() functions, and
renames a pair of functions to make them have a better description.

Elijah Newren (4):
  merge-recursive: set paths correctly when three-way merging content
  merge-recursive: avoid wrapper function when unnecessary and wasteful
  merge-recursive: remove final remaining caller of merge_file_one()
  merge-recursive: rename merge_file_1() and merge_content()

 merge-recursive.c | 144 ++++++++++++++++------------------------------
 1 file changed, 51 insertions(+), 93 deletions(-)

-- 
2.19.0.12.gc6760fd9a9

