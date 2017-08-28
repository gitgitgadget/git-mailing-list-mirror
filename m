Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0E4C20285
	for <e@80x24.org>; Mon, 28 Aug 2017 04:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbdH1EX1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 00:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750735AbdH1EX0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Aug 2017 00:23:26 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v7S4J12B110919
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 00:23:26 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cm3ueyss1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 00:23:26 -0400
Received: from localhost
        by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <git@vger.kernel.org> from <sam.bobroff@au1.ibm.com>;
        Mon, 28 Aug 2017 14:23:23 +1000
Received: from d23relay06.au.ibm.com (202.81.31.225)
        by e23smtp04.au.ibm.com (202.81.31.210) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 28 Aug 2017 14:23:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
        by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v7S4NL7139518342
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 14:23:21 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v7S4NC9J017660
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 14:23:12 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
        by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v7S4NCK8017648
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 14:23:12 +1000
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 57285A01C4
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 14:23:21 +1000 (AEST)
Date:   Mon, 28 Aug 2017 14:23:20 +1000
From:   Sam Bobroff <sam.bobroff@au1.ibm.com>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: use raw format for notes
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-MML: disable
x-cbid: 17082804-0012-0000-0000-0000025A8DE2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 17082804-0013-0000-0000-000007765473
Message-Id: <334a7be4f61c02db24008181eb1d6c80c95772f7.1503894009.git.sam.bobroff@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-08-28_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=1
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1708280068
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If "--notes=..." is used with "git format-patch", the notes are
prefixed with the ref's local name and indented, which looks odd and
exposes the path of the ref.

Extend the test that suppresses this behaviour so that it also catches
this case, causing the notes to be included without additional
processing.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---

Notes (foo):
    Hi,
    
    I've noticed what appears to be a small cosmetic bug in git format-patch, as
    I've described in the commit message.
    
    I'm not sure if this patch is the right way to fix it (or perhaps it's not even
    a bug), but it should at least help to explain what I'm talking about.
    
    I've used "git format-patch --notes=foo" to prepare this email so that it is an
    example of the issue :-)
    
    Cheers,
    Sam.

 log-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index 410ab4f02..26bc21ad3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -655,7 +655,8 @@ void show_log(struct rev_info *opt)
 		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
 
-		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
+		raw = (opt->commit_format == CMIT_FMT_USERFORMAT) ||
+		      (opt->commit_format == CMIT_FMT_EMAIL);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = notebuf.len
-- 
2.11.0

