Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C055208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbeHFRfQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:35:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:56618 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732386AbeHFRfQ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Aug 2018 13:35:16 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w76FP8o4021043;
        Mon, 6 Aug 2018 08:25:26 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kna0jb78c-1;
        Mon, 06 Aug 2018 08:25:26 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D91812237919;
        Mon,  6 Aug 2018 08:25:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id CFA902CDE73;
        Mon,  6 Aug 2018 08:25:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] Simple fixes to t7406
Date:   Mon,  6 Aug 2018 08:25:21 -0700
Message-Id: <20180806152524.27516-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.550.g7224c72da7
In-Reply-To: <20180803231407.10662-1-newren@gmail.com>
References: <20180803231407.10662-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=618 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060163
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:
  - Simplify multiple tests using diff --name-only instead of diff --raw;
    these tests are only interested in which file was modified anyway.
    (Suggested by Junio)
  - Avoid putting git commands upstream of a pipe, since we don't run und=
er
    set -o pipefail (Suggested by Eric)
  - Avoid using test_must_fail for system binaries (Pointed out by
    both Eric and Junio)

Elijah Newren (2):
  t7406: simplify by using diff --name-only instead of diff --raw
  t7406: avoid having git commands upstream of a pipe
  t7406: make a test_must_fail call fail for the right reason

 t/t7406-submodule-update.sh | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--=20
2.18.0.548.gd57a518419

