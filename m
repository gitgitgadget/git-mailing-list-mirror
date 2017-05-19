Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98E32023D
	for <e@80x24.org>; Fri, 19 May 2017 14:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754817AbdESOdX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 10:33:23 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:16495 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdESOdW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 10:33:22 -0400
Received: from lamlash.localdomain ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BixrdXTuhgKstBiy0dqpNU; Fri, 19 May 2017 15:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495204401; bh=vD92B9oUk8EBWB3vN78sdumEqX6OTDpomK+DoazJtC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=rxG/6CmGbCxZhpU9zyrqaEqv/6QtGu3TCldlolcMXCrxzl060xsfmZScYPq5iIMe6
         fEWx/bUvI8Sto+u5/0fmFxm7OXyWR7FROeC3G+dSxzWSvRVtPLsUil5ON2LL58SUSD
         gx2EwYttHrx1mD0hGRXHbHlQAM346QZjgdlQymGA=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=evINK-nbAAAA:8 a=S_-o_t9VBCyMV-C0xAUA:9
 a=lHyciEgUYxwQECeY:21 a=ihTzXKAMthZDrVno:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   phillip.wood@talktalk.net
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2] rebase -i: Add missing newline to end of message
Date:   Fri, 19 May 2017 15:32:48 +0100
Message-Id: <20170519143248.22358-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170518134154.12771-1-phillip.wood@talktalk.net>
References: <20170518134154.12771-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfEi5ZILD25vjFGAA95gEMstag32O50/bVG+oGIKDYI+iFXQS1aCYeUib0fPNJVe2H2GaAKeae4EW3kh359grJlngD1mcWjlkpx3x0rq8TRo4522eRwzT
 aJD3JadZJepY2DSfO7G21vyIaf2r01NNyXw3yjWAdR0ADeKRE1qGbCeWDqqghzU9KWR3+zcGfmq+OtaYQ46y37v/73ZnRlxeyeGSXhoXpsGYE6VPOuP+8aBF
 EL1qC01rbWDpfsciPWPfbn/N2RcRiasxulEDpxBnoNr1BQEkKc9M4nYO2FG7v8tN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The message that's printed when auto-stashed changes are successfully
restored was missing '\n' at the end.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
I've added signed-off-by and acked-by lines to the commit message,
otherwise this is unchanged

 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 311728a145dfc66e230334221a2610468239932d..4dcf9c8be044247c6c18a4ec2a4675d9df9953eb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1920,7 +1920,7 @@ static int apply_autostash(struct replay_opts *opts)
 	argv_array_push(&child.args, "apply");
 	argv_array_push(&child.args, stash_sha1.buf);
 	if (!run_command(&child))
-		printf(_("Applied autostash."));
+		printf(_("Applied autostash.\n"));
 	else {
 		struct child_process store = CHILD_PROCESS_INIT;
 
-- 
2.13.0

