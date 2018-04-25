Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6581F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753845AbeDYM2j (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:28:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:41457 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753712AbeDYM2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:28:37 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M1FAK-1eMnLQ1lP6-00t9j9; Wed, 25 Apr 2018 14:28:28 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v9 02/17] sequencer: make rearrange_squash() a bit more obvious
Date:   Wed, 25 Apr 2018 14:28:25 +0200
Message-Id: <a555a3b1d1c2360bf44c7b859bef4ef21c1e32ca.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:07IhRCP6Z65ByzoEweghhsBvsW4R1VeQ3m/4As0PqgDFh02GsW+
 n54gr/I7hE0ennbP1Y2T8bNEzZbU4NZ8yBRz5Ry17D194nulhSsSLhHNNbCpJqlZ7SoXsIz
 pvj5VR/KyTSwoxkGWQwGzJ0wIljVlWItibTFbUjPWCXUY8epF9T74hEfMCNbSXSUR5jiGsh
 SSaAgQqFK60OFUoyze3/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6WsDG2EpX/Y=:hre+dELRpErszbelyPUbVA
 hjgVWnkxpGjVLVEYTV2LveMMnIgO7qa6P9N+Oi74JHH2Pm86fT9slQWLtIryO0Pzk43FOAvsX
 M9i6rrzm4gPLfwzSmY8MCcLS2bYfnA/aNa7iNMjjkh6TMO+/qb6TVAxzCAqpyoiAsviqORIUf
 KFE+7pSuOEP/pZegAzVRbopVpCijTQgoCCEXWvzJHewVLrittcCl5g/v6iPD9DGsDuzn0c14N
 iVyR3/uTUqwCK+SDD03ZJtgMVmXTz/maoYBY3J+N6od0b2rnMMX6MPE8h3sy2Coa5adVaYW3m
 jupAkuNk2Dr7OyuiAOtcS4GEk+WsUn3A3lnke5lBCzAbeWURZvLEQKl+yG9FOFwGvTktdbZ+L
 6Z1i7YKlPAzQYgrFYniv0GK4J8dJxiwcCUTLQLzV64ueZMPYXzrpV8VXEff4Q8b1s8vxe5A/L
 bvd792g5ppMU+Hb3P2KddKkSYHYG5kqAzZiuusibtG6YYjeKTDdQzvyYA5Rm2FQXLhXn2Gf4O
 GPZz1ENVs8zwSW3Gs0arRFxGHc5KSeOrbOA3BMZornhze9TqtSB0hr87rTGXEz7cvgoUfz9uJ
 gAgtZiVoghhUCluwXU1gIveeAQFzg/LVibbVC43tLvTUP4Co6OO/dlmcrUCEOhO7MK73/nZfd
 jN+9KJQX2x5YM0pF7jVUMSC8fCDSIjfKREwDq0U8e3aUjsWgcbGtkJpAmCK2izjZ91Mw7UBCf
 uuhKai9AJiB5EhrwJ//MHt0r+SnAWHT6BidyTR2wQXMkv4sUTU0XxO++Pr26VgNOSa969CfPU
 c3+vELxUorofIBdWkziS56UdOMGLOwY1TjQjf1WVeCbF+gqToC0vn3KbNTCXpG2XloxYeWm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are some commands that have to be skipped from rearranging by virtue
of not handling any commits.

However, the logic was not quite obvious: it skipped commands based on
their position in the enum todo_command.

Instead, let's make it explicit that we skip all commands that do not
handle any commit. With one exception: the `drop` command, because it,
well, drops the commit and is therefore not eligible to rearranging.

Note: this is a bit academic at the moment because the only time we call
`rearrange_squash()` is directly after generating the todo list, when we
have nothing but `pick` commands anyway.

However, the upcoming `merge` command *will* want to be handled by that
function, and it *can* handle commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 674e26bf826..c131e39fa93 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3403,7 +3403,7 @@ int rearrange_squash(void)
 		struct subject2item_entry *entry;
 
 		next[i] = tail[i] = -1;
-		if (item->command >= TODO_EXEC) {
+		if (!item->commit || item->command == TODO_DROP) {
 			subjects[i] = NULL;
 			continue;
 		}
-- 
2.17.0.windows.1.33.gfcbb1fa0445


