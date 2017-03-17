Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E7820951
	for <e@80x24.org>; Fri, 17 Mar 2017 15:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdCQPNd (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 11:13:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59928 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751049AbdCQPNa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 11:13:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E6A420A2D;
        Fri, 17 Mar 2017 11:12:35 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 11:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc:x-sasl-enc; s=fm1; bh=4326dU871pVXdzevD9Mriy8+IfU=; b=
        InhkIbwf6sy9jXBqZg0kfwuh11u3/e9/dMuvKTgAJ03PDlqvHqvXlZq2mEmOvhF3
        gD4HSHWrsJAZhkm55MMJt5u/VEnmccedjQk/rvnsi/UKQ1yigzUbm3ANBgMrDiLh
        KODLHgp3fxY8VasHORSVuAtwjWyiabQY2pqzoLk9AU9TMtPdfOGriRwiwRF7/lL6
        C0DRaGBGcBBauJWf8UTGOPvilIMt9wHw3CWgSmxN46wLVzE4YQ9RnvohtxE+2383
        L7ImigfkpGeI7YY0ZwSqb8nBlPQHQMXi7zBBNOxmJOXCYAjOTPa+64WQhWegkm3N
        I9HVS1vmJttMGTcvqfM1OQ==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=4326dU
        871pVXdzevD9Mriy8+IfU=; b=nvh4pJeRhy2F3ru439AzmmAnxE5uC4GCNAw/ct
        L/O7vjbS56v+2H//SjiDLev1ctvEVm6iIsIyk6SuLJiDQpfrN1gUMDQDDH+KdNjQ
        ftr4fTDBrkwH9cG1AFHwqta8j45niZBNS7HBlc/+6TYYcA/JoERA9/eInNlMbsbF
        lqEwf/gAMVRIlbFNS38hbWdk9j/26c4jj4PtnsCd35m/4TWfta1Gy+Q2tmcLfb6Q
        BZjGmJd34fFLoTH/28+qqg4J/nd+UflA/pmVYFpp1DhYJSg0K6rR6jusxYrJjfoG
        qyKjP90iBKOiBmlmII7cHvWE3/+kWRwH6Jdzs3VD350vkj5A==
X-ME-Sender: <xms:4_zLWKO7VB03_jfUP_nxtVjeksRT0S-KBLKxd2vb9WaP15SuKGLQMw>
X-Sasl-enc: qvf25DzTCXvq6I67efo0TkWx91baCwNu4yDD0ynXnxQ4 1489763555
Received: from localhost (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FFDF244D9;
        Fri, 17 Mar 2017 11:12:35 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 1/2] describe: localize debug output fully
Date:   Fri, 17 Mar 2017 16:12:32 +0100
Message-Id: <105f48ad2ae1aa9c88ce6088e6b304294bec0835.1489763302.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.12.0.484.g92f9ab2bc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git describe --debug localizes all debug messages but not the terms
head, lightweight, annotated that it outputs for the candidates.
Localize them, too.

Also, increase the width of that field to create room for the translated
terms.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Ralf: this is just the context for the following l10-de patch

 builtin/describe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 76c18059bf..1a760c16f9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -49,7 +49,7 @@ struct commit_name {
 };
 
 static const char *prio_names[] = {
-	"head", "lightweight", "annotated",
+	N_("head"), N_("lightweight"), N_("annotated"),
 };
 
 static int commit_name_cmp(const struct commit_name *cn1,
@@ -396,8 +396,8 @@ static void describe(const char *arg, int last_one)
 	if (debug) {
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-11s %8d %s\n",
-				prio_names[t->name->prio],
+			fprintf(stderr, " %-15s %8d %s\n",
+				_(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
 		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
-- 
2.12.0.484.g92f9ab2bc1

