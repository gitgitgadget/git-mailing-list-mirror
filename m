Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79622205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933117AbdABPfy (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:54 -0500
Received: from mout.gmx.net ([212.227.17.22]:62165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933079AbdABPfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:52 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1cCUrt20kM-00Bbrd; Mon, 02
 Jan 2017 16:35:43 +0100
Date:   Mon, 2 Jan 2017 16:35:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 35/38] sequencer (rebase -i): suggest --edit-todo upon
 unknown command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <42517ba8f64410dd81fac7b7b31f855c1a3e9c7a.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:s6bs+ve0M4roCQFcyPxC0IL/nT9ZDpIKTsm3dNURTeFs8oG5nsJ
 HFqBjXx6uA8fyrcEBBMVk/wsDV/daEmHrJ8Uff6EkT3Llqj06mF6RtjePK6jJFwcyjjVggX
 41q4hiNEYbmXrNPOWVyVYgftrWA2d6XF4Kh9ZL5aEqpFZJW8qDLYXttfcNB6kv1W4KmeAIk
 JZCaqVjt5rkVzLeg/y97A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U2vXKWRzOCc=:gtawDPxLbRmssTpUz1Ddqn
 PCmKWTByMslqocAfrb/Su0f+0FeCvWdtDILy0TBYzYtyUVOK+tyqbkISuKGeG2+A3iEslfgtM
 EJYjgCTBEPBXKNGcKqpK6bdREOLlgZvr5vSW/pel47vLi8QYgNHbpO2qm8+bDj3LVEwNWx47b
 qPyHEmwBqWMUsBHk4M8d49Ls9HAJlByvwi2V4H1DW4Dt2pcoz/TOTcOqPgckJ0w1PC2XCEC25
 +YbojIRvL2t+uPO+6EPdFFgG3NB9NlUvjeF+4EocmYJxvxo0ni4Y9PiZ1KlUkFbKsuulq6hXP
 GfhJpVQZKaEd2EGQ/yiUoZnXgtqa4fqigkmXe8CoM18R9xm1yHqVgZ8Pr/eY47IfEB7X9QdJo
 uDSdc/EE7ICHH/Wvz3OpR2R0EkPdMtEDhbPhi5rV027PcXGcrkjO2gFtX75mFV1/m9QhnsYm1
 gYDecEeNsVgi7Nf9xJGa3HcGNdVFvtWdJ9l01/DyDaH3drVP3rP20yJW5XRhC5j6H7O5+U6cL
 Mih23x8snVEFbemmwhWXa8hMZpRybqR1/egGyGB+OWByDvSBCtOl+/wgWuqBgYfS5Hg0R6gmK
 ejB5OwnaQ8lZsLyjjsI4VL4T+2jCQtDHHvvEMp2r/aS8vnWBkjzPQ0Ix+qFI0Lc3uqy0989F+
 Z8udszqrXcwwX4z5YWejqpjz7hBKgCzVmqPYXHdJpgSqoj+JNgg+fbmir624nu1ToOzeEys74
 6lKEpNuLqshmx/88WuFVbYjFpDO4qZXV/3VVwg0mQLgrbUwVctOxahSyTVoQ43v2yzcZJ3VBk
 pNX+NC2HFDyW+xOg/i+Sfb4Qd8Tlaym2c2GHEkuyN0vjUM+h1PR1MtFpBVokcafD9qetDmoWH
 pA9KsnvrB8lwja88v0wLHSMdGp+DqczI3BYTbIwxwCbvPJ5RXyBepsnUMUPl5tFDD3SzQDyFw
 KQ9dEuPz1cSguuUeEuVZ5Zt7ijbjvxHfvhMRRPYWBE8CdK1l7F9hSkFC6BJSL+hwYUI8D76Mp
 oBlHbBkkCVeXp/C67Eu0of7fFiABEDf6MWQFyKr/lEtL3T755cisuAQmLavXUd82Aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the same behavior as known from `git rebase -i`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 4f37ba8d33..4792a3de3b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1314,8 +1314,12 @@ static int read_populate_todo(struct todo_list *todo_list,
 	close(fd);
 
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
-	if (res)
+	if (res) {
+		if (is_rebase_i(opts))
+			return error(_("please fix this using "
+				       "'git rebase --edit-todo'."));
 		return error(_("unusable instruction sheet: '%s'"), todo_file);
+	}
 
 	if (!todo_list->nr &&
 	    (!is_rebase_i(opts) || !file_exists(rebase_path_done())))
-- 
2.11.0.rc3.windows.1


