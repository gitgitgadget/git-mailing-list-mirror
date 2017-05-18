Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175F6201CF
	for <e@80x24.org>; Thu, 18 May 2017 13:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754521AbdERNmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 09:42:13 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:22484 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbdERNmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 09:42:11 -0400
Received: from lamlash.localdomain ([92.22.40.87])
        by smtp.talktalk.net with SMTP
        id BLgjddP0lxR4bBLgudCZFu; Thu, 18 May 2017 14:42:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1495114929; bh=NxHHaVtGrVCLbqhgPUP2kFuIRod7d5N4PJyzKO7um04=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=ejTl0mg/8iZWxxqt4hLvqzYtf/6qn/a8ICGhNMZ1W7qadYFJt2O4hLnjbjNSA1pPb
         7oj0mafjT51ixPQxV2s3Mr7boxcjWmbYBgkMnOLZz/9jzIPKgbtG79lE3vjobKJWMw
         dZl06KUuFxWhFXC628rbvDdA6jFD0ch5wRp22C04=
X-Originating-IP: [92.22.40.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=Uk7VDCfhaeB8IHNEy8al/Q==:117
 a=Uk7VDCfhaeB8IHNEy8al/Q==:17 a=evINK-nbAAAA:8 a=S_-o_t9VBCyMV-C0xAUA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] rebase -i: Add missing newline to end of message
Date:   Thu, 18 May 2017 14:41:54 +0100
Message-Id: <20170518134154.12771-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNT5dwWFHcs8s5fzRUTt6ppVkN/LeI7muvrVYLIroHHDpp+TIp39zaXsfRe+JFAeIdy+6q0ETw3pwb2KS0ww0D8HDsotkFTfUdr7EwCczcFG6qaHaV3y
 Vp+r450lDlc4jjE9Hnc7mYxVY4WGdHnQjdZsqbDhfGGvyQ7NRQnQPepNX5gD/aSGQFJ7AZ2qCKjhNUugQlg9I1C3btUJRQ9ET+2mocnhr9dAATEsD3UCr/4I
 J1HeZ/24z37N3oJbliE30VeXrikbmA3CZ44Pqf5Rgfo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The message that's printed when auto-stashed changes are successfully
restored was missing '\n' at the end.
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 311728a14..4dcf9c8be 100644
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

