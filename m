Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D46E01F424
	for <e@80x24.org>; Wed, 25 Apr 2018 12:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbeDYM2x (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 08:28:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:47997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753205AbeDYM2w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 08:28:52 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Meduu-1f0ElR0olk-00OFlw; Wed, 25 Apr 2018 14:28:45 +0200
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
Subject: [PATCH v9 04/17] sequencer: offer helpful advice when a command was rescheduled
Date:   Wed, 25 Apr 2018 14:28:33 +0200
Message-Id: <06c48bfcfa79b925af339fef04a29bdb0b216f9e.1524659287.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524659287.git.johannes.schindelin@gmx.de>
References: <cover.1524306546.git.johannes.schindelin@gmx.de> <cover.1524659287.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:yC7sYaClbuGAO4BUcsvhSfu++YlCtbeHWCmbrJ1Hh7Fok7jPz1D
 5yVfzVDCQAC3z+mAO0hp+JirIjMFkUFiuCUUeBv8oagiwwroldeIUOHsJKp6K0MXYM66NP1
 fMA5ZWHAV9Dv77WpXHhGpeZ8SLE/Cshgux2Zimgf+1TXsta1/AQsIZeHDWoFk0UflINylOb
 LDE5KLtlsj6eHg7R8k8AA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5c1a9N6tnQE=:pibrJPCOJlBEpRFzSG14o3
 nNGoTzlHyG0CtbM8zeSda24Z5wXcZXV0ZalRZmMG99vPNZ0LoAhlE1eV/UhfOO8KRgykPofmM
 6kRcbf0Yy6ElJ10EvPn4ilciqhDUPmYgvva7oLq+8z44ACfGJZ76VoYJoazVEAA5wt6D20Rie
 OYyh+KHhv2jKqKtVbbR90GLo5Xbg0F1gqgDU8fdoZSPPZSV1p4bChzr/ahoLpk0cQBveH4EjH
 D48xXxutjRsFgetZjbeGd7eNewJYhzosEp8hIEFlcXdA8LIKrym5yhWdh7U5u/dbDuV5LPKZa
 VmtpOz8931kbolHWzPPvaXZkW9TazApdVIUf74QOvKqOLFoF5b2sTD4aIETJAanyRq3GTJNfv
 4h/jgXsilSqlZvDEP42htvWtArCdd/+/qpJqeDlMwjdExU5xcj5jae3B1ppgarIbEtG4if/qc
 /YmV4whuBW2h2taV9FREJ3KhMF8LW7KFlMbVIB4MJ99TdUnIz5Ycob5kcKu46+lYb5nnhFMWk
 R6VJSGNw4WeLdVGZpfsjLOBtmd+8/+W/GTZ6ih9GjMRJdx41xDbm7qBzRgHibK5jq3SdbUldq
 CzsECC4/THo7mDl3sr6pWHd+toqDPIgqlHRUucgXIoqprFamOf1rCNUOguxrmDidNMW/7rBpu
 gf8I9wv3vxVJb5Vrj7j9s9+br4ypn6JRlAvNPMEg5nO3lBMsugoOF/fW5sm4V6K6cbOmjGOIv
 2hL+kfxTMVK5pnn8UbRkg6Xbs694sR74DMPfxaGOPGrWEu1aCGDEbkOQZJFm/Cb6OgU14xq73
 Y0CGbWB32GoFOuewOn0RVjgYmALazmPP8lhw0UBikj9WTmTB42YIyg0oqleUU+RMXsckAZv
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
index eac1c341c1c..f9c1ddb5385 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2561,6 +2561,17 @@ static const char *reflog_message(struct replay_opts *opts,
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
@@ -2606,6 +2617,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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
2.17.0.windows.1.33.gfcbb1fa0445


