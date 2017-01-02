Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1636205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756377AbdABP2e (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:55494 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754551AbdABP2c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:32 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MH4Os-1cJ4bH3Bju-00Dmqp; Mon, 02
 Jan 2017 16:28:13 +0100
Date:   Mon, 2 Jan 2017 16:28:13 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 22/38] sequencer (rebase -i): set the reflog message
 consistently
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <0080cdee6b77664264961a4f073103cc4b482b00.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QS7hyUBmNtDNjdHYZrW3KtyZWMRMCZOZeGA8Unm1fBTuRhM8qDY
 pm487A8rTKXxyR6uUFctNFw0ryFtpy5JV+29R3i/+snR828cpKXaR1rWHlifI7MRUlHovpB
 YJS7JUE19qHryrkbAhpoMXMVcdYA3VwPSmrEeWfd+KkpfEnI4dvMHw0FdfU+QPWBgCC0Wzx
 xFe8beLu8/+XPBqM8XPww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3TitHcvIHqY=:1XewNpXHHWtuWTC3w5Gk55
 LTu8trZhh/7Urf3dQzp2Ju1mSj0bTeA44oae3NX/KunrgvEk4+5kZRlQW+fWTyzFMwHueK/tB
 9R5YxVmuVzTN/N8BygB2g448zygEVBt7riwEldXWrOvK+FEQ8AQfpIX38L715jJf6ubLySDsr
 K7koya3OZJjtXOLBvnyCKGrkHE4iepRRbxLzIb/yr40KfyE14IkQwGpBaB8zx2XvnZ/AQJ+6K
 rb2nr/voiotwnHZUy01vei2rS1U4Kai9CApjQ3ioTLv0d4OfadzbatHpEzmdAU2uVQB5SfIkC
 UbicGGxVjbVZAYAoiiPSaoF3hIg/9+A/59NYvo4mlXW3pnNyS+usQY4Pov+THPWgN7tAqYcZb
 0WUY5O89U/6FMmzD1uRlWvhE/yHJl8lk/h4kwGq/sYOtLomArzPgFCehBEAg82BZz3fRu8mBm
 npzI/OsQFkiJ/8yvKLO8Xsdb5e5UXDU2toSN3r44PJtp5zkWSSpyPLf/vwlVTXrdwNxXfcLcU
 SgMaze8sZ7sGYWS4gze6bwDYy16+XhhQSrDqo2KBuU2DtS0Itk95ncrPb7FKEhYirz2z9Mf8L
 0vILMEaxiLXpvzhANBSWe2x5B0RkxMiOk0SMhK/s70d+BRtb9u0ZxOD182NAJSyJZO0cftv+P
 F6ZkiTrxE4iLyQVSXtwGicxdWoDJhAnHssSKetYbtWPIid8wlsiAbcn1iHy7F1hzIcD8qIAQz
 QVPVwtzEWmPodLBfzRHTyvP5m8yOt/gmC0WF7LfkqZBvID6DH+puRqmgHVQqP+MEgFxxJpJG7
 n8qduZDXon7HiP+RNHClDo5faGjYALSeGlfqYarB2ERnV2IqvrssdZtQ/EhHXK9XukzRxhbCm
 SgOG+rtbpKwb/WPVSQ5hHpbG/cj3yoYDlmFSMgUZU1fQvci3e2iHn3Q/JQoJ1KP3v1J/TH7jW
 /I0kCB9rnBTpYdAgYbPrmfI256cSib/F0yCVCTsCZ7xMMVGp/lLHGqsyptwtK0Ja7lk7htbjo
 cGELVnbtbrrSPRZV5xcwioGrYipiggQhHLjjdNK1KjNsLdux+lD1IcaNZimR1c9IGw==
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
index 0d8e11f580..95ae4bcd1e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1785,6 +1785,10 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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


