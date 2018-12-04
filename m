Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F9E211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbeLDXRU (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 18:17:20 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48870 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbeLDXRU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Dec 2018 18:17:20 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wB4ND61h012342;
        Tue, 4 Dec 2018 15:17:14 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p3r2s4dje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 04 Dec 2018 15:17:14 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 4 Dec 2018 18:17:12 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 4 Dec 2018 18:17:12 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 4331C2212700;
        Tue,  4 Dec 2018 15:17:11 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <j6t@kdbg.org>, <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section Behavioral Differences
Date:   Tue, 4 Dec 2018 15:17:09 -0800
Message-ID: <20181204231709.13824-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.2.gca0e531e87
In-Reply-To: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812040199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 4, 2018 at 1:53 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.12.18 um 22:24 schrieb Elijah Newren:
> > +....  The am backend sometimes does not because it operates on
> > +"fake ancestors" that involve trees containing only the files modified
> > +in the patch.  Without accurate tree information, directory rename
> > +detection cannot safely operate and is thus turned off in the am
> > +backend.
>
> Directory rename detection does not work sometimes. That is, it works
> most of the time. But how can that be the case when it is turned off?

Gah, when I was rebasing on your patch I adopted your sentence rewrite
but forgot to remove the "sometimes".  Thanks for catching; correction:

-- 8< --
Subject: [PATCH v2] git-rebase.txt: update note about directory rename
 detection and am

In commit 6aba117d5cf7 ("am: avoid directory rename detection when
calling recursive merge machinery", 2018-08-29), the git-rebase manpage
probably should have also been updated to note the stronger
incompatibility between git-am and directory rename detection.  Update
it now.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 41631df6e4..ef76cccf3f 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -569,8 +569,12 @@ it to keep commits that started empty.
 Directory rename detection
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The merge and interactive backends work fine with
-directory rename detection.  The am backend sometimes does not.
+The merge and interactive backends work fine with directory rename
+detection.  The am backend does not because it operates on "fake
+ancestors" that involve trees containing only the files modified in
+the patch.  Without accurate tree information, directory rename
+detection cannot safely operate and is thus turned off in the am
+backend.
 
 include::merge-strategies.txt[]
 
-- 
2.20.0.rc1.2.gca0e531e87

 
