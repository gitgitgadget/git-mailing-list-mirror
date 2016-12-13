Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1812042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934219AbcLMPcy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:59519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933955AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkP8Z-1ctC8T44J1-00cOED; Tue, 13
 Dec 2016 16:31:27 +0100
Date:   Tue, 13 Dec 2016 16:31:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 19/34] sequencer (rebase -i): set the reflog message
 consistently
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <13e2907524d24f5ab393d0203b50dbcca19e7728.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:E4KwXKednGv8e0uxnGMCHNeiBrz/912xshq4GM1at9KddZzCSr9
 Fy4pbF5JmmJ8riULzXnm5lHnN+mgo95UhYBQs3y0Bns4dhCZLeeRs/tfLRXEP5LZMnaaLcM
 wORm9y2IyEJR08kESQBqOLYxxJi4xS+cQdKj6z/q5NpG2aThzuS2TPVq0K8JA9/WsJHltQc
 izZ3npfSI2o33mpsMHNHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7rRgId5iSug=:fwW8yOnzlZPJBIYKnBOqmq
 QcXjhD6Uc52KmaouF/ogKLb9+W2Sf3RHgrtySAnpsxxQ72tjA6vkU0NKt9bedT42sg1KRJZ1b
 tkUjPv08jhyB7W6Ne0Go+bc67nDw1uMGCAIyNTJ7pNk7Wg0uDKhka4AObNFY1Ph1GLmCQC809
 kE2L6KzfjMaR66Z1dwmvF0PcPgJyqN94WPHVjvM4zLklmdrG7BtRb7JOq6XNUFPMcsEp3nDmU
 eQizXBOV8rpNtoIOvE/GCZGGf/PvnJkSPc87EYnpYO0DJ0Dx3E/Bj6+y4pujwTAeJAmWxgXAT
 qysZGiNvyPxcPD7lUJtBnIwcz82JZqOtGzvcPlzsvdawX4g6r6gyNihv47LVrpganZhzsg5Q0
 VeY8lQAhsu7/NaE5gAMhq/JJtMKV1569JX3YrznyfR+WOdF0erV/dBxzLKjI/TrVv3sKr8w+Q
 zNvqDduZrTFYhvS2Ye8fVn2HoN4YOUG+HbbMb99+LW8vOTGIFGa3Vig7/X+KfwqhhQT2jALO9
 HWHinei4Vf+Ojfsl0Ad7iBI7+saogVN9jHgnGHDoFI85Kv/mAfqYIuYfa4xfGYCBq9HW/1AHZ
 qCbD7A4iV/rdmizPqjnN7x3C9mEhAakWbbJB6Rl1v/fafIWMiODrpbrq732cp/WZasO02Gmh1
 FlNzINamgGlu8kX8oaOJuQY9hSwsOq88l4Sn4nO3L/KILJg09Q+YUTlwsqAiyKLgXTnDWYClf
 dc4IUrBCKBG/YglFyTIa3Tt/k5gznKuZKD2s0Ms/TfrlBmcq1QdBffpjopfU8vCFcFECxNA3c
 Qq4YWmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already used the same reflog message as the scripted version of rebase
-i when finishing. With this commit, we do that also for all the commands
before that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index d20efad562..118696f6d3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1792,6 +1792,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			unlink(rebase_path_amend());
 		}
 		if (item->command <= TODO_SQUASH) {
+			if (is_rebase_i(opts))
+				setenv("GIT_REFLOG_ACTION", reflog_message(opts,
+					command_to_string(item->command), NULL),
+					1);
 			res = do_pick_commit(item->command, item->commit,
 					opts, is_final_fixup(todo_list));
 			if (item->command == TODO_EDIT) {
-- 
2.11.0.rc3.windows.1


