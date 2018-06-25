Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3E8D1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeFYQN1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:13:27 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:53472 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752211AbeFYQNX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Jun 2018 12:13:23 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PG9dGN000983;
        Mon, 25 Jun 2018 09:13:10 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jt01ttdq9-1;
        Mon, 25 Jun 2018 09:13:10 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 46514226E7FA;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 3A9212CDE65;
        Mon, 25 Jun 2018 09:13:10 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/9] git-rebase.sh: update help messages a bit
Date:   Mon, 25 Jun 2018 09:12:53 -0700
Message-Id: <20180625161300.26060-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180625161300.26060-1-newren@gmail.com>
References: <20180621150023.23533-1-newren@gmail.com>
 <20180625161300.26060-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=48 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

signoff is not specific to the am-backend.  Also, re-order a few options
to make like things (e.g. strategy and strategy-option) be near each
other.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-rebase.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc4..bf71b7fa20 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -20,23 +20,23 @@ onto=!             rebase onto given branch instead of upstream
 r,rebase-merges?   try to rebase merges instead of skipping them
 p,preserve-merges! try to recreate merges instead of ignoring them
 s,strategy=!       use the given merge strategy
+X,strategy-option=! pass the argument through to the merge strategy
 no-ff!             cherry-pick all commits, even if unchanged
+f,force-rebase!    cherry-pick all commits, even if unchanged
 m,merge!           use merging strategies to rebase
 i,interactive!     let the user edit the list of commits to rebase
 x,exec=!           add exec lines after each commit of the editable list
 k,keep-empty	   preserve empty commits during rebase
 allow-empty-message allow rebasing commits with empty messages
-f,force-rebase!    force rebase even if branch is up to date
-X,strategy-option=! pass the argument through to the merge strategy
 stat!              display a diffstat of what changed upstream
 n,no-stat!         do not show diffstat of what changed upstream
 verify             allow pre-rebase hook to run
 rerere-autoupdate  allow rerere to update index with resolved conflicts
 root!              rebase all reachable commits up to the root(s)
 autosquash         move commits that begin with squash!/fixup! under -i
+signoff            add a Signed-off-by: line to each commit
 committer-date-is-author-date! passed to 'git am'
 ignore-date!       passed to 'git am'
-signoff            passed to 'git am'
 whitespace=!       passed to 'git apply'
 ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
-- 
2.18.0.9.g678597d97e

