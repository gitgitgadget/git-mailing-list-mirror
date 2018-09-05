Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE4341F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeIEV5C (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:57:02 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58450 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbeIEV5C (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Sep 2018 17:57:02 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w85HO5YR021020;
        Wed, 5 Sep 2018 10:25:52 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2m7rmkf86x-1;
        Wed, 05 Sep 2018 10:25:52 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 3705722E02A1;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 2EA742CDEB1;
        Wed,  5 Sep 2018 10:25:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     brad.king@kitware.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] update-ref: fix type of update_flags variable to match its usage
Date:   Wed,  5 Sep 2018 10:25:49 -0700
Message-Id: <20180905172550.11621-2-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2
In-Reply-To: <20180905172550.11621-1-newren@gmail.com>
References: <20180905172550.11621-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=951 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809050174
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ref_transaction_*() family of functions expect a flags parameter
which is of type unsigned int.  Make the update_flags variable, which
is passed as that parameter, be of the same type.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/update-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4fa3c0a86f..54fac01f21 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,7 +14,7 @@ static const char * const git_update_ref_usage[] =3D {
 };
=20
 static char line_termination =3D '\n';
-static int update_flags;
+static unsigned int update_flags;
 static unsigned create_reflog_flag;
 static const char *msg;
=20
--=20
2.19.0.rc2.2.g1aedc61e22

