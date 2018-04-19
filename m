Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE941F404
	for <e@80x24.org>; Thu, 19 Apr 2018 12:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeDSMUO (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 08:20:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:52733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeDSMUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 08:20:13 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhiPD-1eo39S1XSF-00Mp8N; Thu, 19
 Apr 2018 14:20:05 +0200
Date:   Thu, 19 Apr 2018 14:19:48 +0200 (DST)
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
Subject: [PATCH v7 04/17] sequencer: offer helpful advice when a command was
 rescheduled
In-Reply-To: <cover.1524139900.git.johannes.schindelin@gmx.de>
Message-ID: <b768f1bbfdc5c8b03d7bd67bf6915549d18934f2.1524139900.git.johannes.schindelin@gmx.de>
References: <cover.1523362469.git.johannes.schindelin@gmx.de> <cover.1524139900.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kJFBvvnboixY7TaojfJJOYF1e1wn9E3AsxNFk4JtG2OZoPCeT4F
 gMfsgT/0HCRKMwGgj1wO2awMPgmgsIjifBroEyS7cw1LHOAI1xTEUf2/6WxsBztwLeRR3lg
 9w7AmeBA/5TkKOrbTgtK8EghHtDgWUvOgu5Z/AK8F7CA8CVRyZAdebo91l5jaT/SAltUdJa
 Dw44sAGXlSKjqXZWbZ2oQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uv2ZAURnoOM=:8jZA6RaEMF2vBo6zjZN/z+
 p2n5qtOM/bK6hMbPEjCpY35tbz4p2NGTt8/+MpzK+ZsJ7izOasnBAraG9i8u8WgJlEjAHZUDE
 V7LeKwI7trxwpK/Gk+nGtTLe7Vg0+hfoxndKeKA/SDAoOEUhHHbMxqRJ+EGWHbkmZZOkz4Z9Q
 zE1NFAxzuMqp0aLccWujQLew+Yh15yNOEQQtqdFRtxaYTFBFJXIkltJU+VLpDxvQpaRGEzipF
 ZICEZg3FnJKyjuiNykkBz8XLaDqmbLMTf5CaOOjkjTkJbIAsS+gYcjLLTI8NM5zIHfJ7usYIC
 SNXWWDawyQnqUS5E0nbhpCqj4hjUhr8HBx9LtB/eCgjjbVjNnyX4q796son4kkCBy+SnveVWd
 phMOlpYUgOLk/TCQlGZHpx90Nq/z8rBuv7yQEubCO1M9Ea1cuANfkdL4Exjk+r5NAy9PExLtC
 PEE6ZzHSIsV815ZE6wfzVd6rVp5pMJRsJO3TTSNEB3EISSzdCAIxQADRlJdi4SIEEtJIqgwAU
 f6BBReZ8sJqwanygdonvJGr//AUXYp8yNIOuSTdzPFbxJB6UPznzFIv+zMxwxiPcpuaCrk6D+
 AjSHvYylvUcde1rmcPhDlyS5tIvnHefCzG1hHpSv5aDp+XLOdryoRIsKXgzOsIXI03Y7g5cUi
 01DgaR14eM3gvbbb5rjxk7IBux4NOENsYOJOpXT1w33r3tiSwxQtK0cBBU4/UqWBpB67rBFB4
 ii1uh+KbXzQ2/A7ZogZatQ5GFyGwGXetmvnPaQHLxzowtfovCVSHWAD4zRaws1TtnXXw58BkI
 sumRjsWzUvYuBGR371Py1QeS6kD1ltDLZeCoBqAG/cJtzn09WI=
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
2.17.0.windows.1.4.g7e4058d72e3


