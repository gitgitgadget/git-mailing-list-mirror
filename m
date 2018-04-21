Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883021F424
	for <e@80x24.org>; Sat, 21 Apr 2018 10:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeDUKcG (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 06:32:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:44833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeDUKcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 06:32:05 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LiTrM-1eZght3RTo-00cipW; Sat, 21
 Apr 2018 12:31:57 +0200
Date:   Sat, 21 Apr 2018 12:31:41 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v8 04/16] sequencer: offer helpful advice when a command was
 rescheduled
In-Reply-To: <cover.1524306546.git.johannes.schindelin@gmx.de>
Message-ID: <b768f1bbfdc5c8b03d7bd67bf6915549d18934f2.1524306546.git.johannes.schindelin@gmx.de>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WDEi0wzvtRnoYL+NDKKRf1j6SS39MIvswFH71ouozdsz1Efc4tZ
 AWr+rCPOfmeCCmicSn0r4+rw2M4R9lPPy6gpwMjqdFSjInLJ5veY+AcStv3tKYykGkpuwAe
 7Yu7SZjSYknI7l1/5dngIN7P7i4oqI7xDmwpTd/CwhfAARe9w/aYlsdqsTN4lGyrTcjMMNV
 88QNZaGXpP8xoolq2vkgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QeFuJs2Mzvw=:+gsbm6oLgarGAPBKlT/XaZ
 H+9uy0XGUc21w00zgCFFMjuV9WwBgH46o9pEB88wEzXWrHFecWYU2Co4r2R8VWgYZOKoZNejH
 AgoGJ8NkT+cAtdfLozXNJSgJyKUSskc2U5u0o8coYXf1ljRZTjCu0KaEMPr0y37LdnslB73/m
 TUne7uX6hGhiH5QT1TKxdQksWKgVGcdRYiQrXDihgg5s3Xc8JIgpatxZpd3egJvA+IF8M6YJy
 fhp9sWafvLtnuW8P0N6FilE6DxuZd/tK3ZirZSrfnGm26bZ3KriWoUup5kRwCy+rFTmz2wnDy
 V3uRfM3qbybHg+UnDUKaEvco399h1jm/3wiqWwVhT8t5Gzs9JS0PjexOiO9I+O9aZoLYjRsrB
 SQVG1Y/QVST8ArDQLYUF9LiYaiVxkzk5s/xkx2x6e6uPOC5mjYuCslsGFbrD+v7soZOL2M2td
 s59e3647EMwPXLnlRT/BURd3GSHohdoKXCHKIsM0GROGj0txZ5kPQUWyKJqG2B1fvtvN5I3rP
 CwZKDiVvqaxnDzns8D6tthYynvI9406SC5YW2wBgb5np0RktFAgr6lQ1F26Wkrja1L2htgT5f
 24AVgP/HSH/Q0oqI7Yvxm/isI1eMCxqZCStQcmb7Hwe6NMTHK8DvwNnT9yuQ/mtnLS9oVILRK
 OPCv7MeU3QOc3Kq+IFdnV/eIiwf1sJDAT82fZO7WAdiR8c2nyGs8cr+R63eCALkavI7QHs9u+
 GucuceJz4+8hnZpB+8TTqyHyBPGPsahKJivYGe9EwuadNzofqwlyFKhuOXMoqCSIs1T/ci9zQ
 lKwtVQyMJx7x97Big7rv4KlOBNlplaTdPHipWDxRXasoHe17jQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we did that just magically, and potentially left some users
quite puzzled. Let's err on the safe side instead, telling the user what
is happening, and how they are supposed to continue.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 3d0a45ab25a..01443e0f245 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2555,6 +2555,17 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static const char rescheduled_advice[] =
+N_("Could not execute the todo command\n"
+"\n"
+"    %.*s"
+"\n"
+"It has been rescheduled; To edit the command before continuing, please\n"
+"edit the todo list first:\n"
+"\n"
+"    git rebase --edit-todo\n"
+"    git rebase --continue\n");
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -2600,6 +2611,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					opts, is_final_fixup(todo_list));
 			if (is_rebase_i(opts) && res < 0) {
 				/* Reschedule */
+				advise(_(rescheduled_advice),
+				       get_item_line_length(todo_list,
+							    todo_list->current),
+				       get_item_line(todo_list,
+						     todo_list->current));
 				todo_list->current--;
 				if (save_todo(todo_list, opts))
 					return -1;
-- 
2.17.0.windows.1.15.gaa56ade3205


