Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36236208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 16:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeHHSvl (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 14:51:41 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47924 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727706AbeHHSvk (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Aug 2018 14:51:40 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78GSepC020272;
        Wed, 8 Aug 2018 09:31:09 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2kr1kwg827-1;
        Wed, 08 Aug 2018 09:31:09 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7980D2290351;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 67D6D2CDEB1;
        Wed,  8 Aug 2018 09:31:09 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 5/5] t7406: avoid using test_must_fail for commands other than git
Date:   Wed,  8 Aug 2018 09:31:07 -0700
Message-Id: <20180808163107.12329-6-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.556.g1604670984
In-Reply-To: <20180808163107.12329-1-newren@gmail.com>
References: <20180807164905.3859-1-newren@gmail.com>
 <20180808163107.12329-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=617 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808080168
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 24aa732312..815b60cb59 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -606,7 +606,7 @@ test_expect_success 'submodule update - update=3Dnone=
 in .git/config but --checkou
 	 git diff --name-only >out &&
 	 ! grep ^submodule$ out &&
 	 (cd submodule &&
-	  test_must_fail compare_head
+	  ! compare_head
 	 ) &&
 	 git config --unset submodule.submodule.update
 	)
--=20
2.18.0.556.g1604670984

