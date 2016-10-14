Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F885209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbcJNNUR (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:63805 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755814AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MePcd-1cL4FJ2UnP-00QAxS; Fri, 14 Oct 2016 15:17:54
 +0200
Date:   Fri, 14 Oct 2016 15:17:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 09/25] sequencer: strip CR from the todo script
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <782293991f2ccbc2d0553d2e2e89d70c394901ff.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kMjjqkk6nBBDDPsn0Wbrraqz1eaqt8cVLgDYz8Un2Zlh+E89q+j
 3awMnQ+3Xom43lViSYKxI2ebSiVcgXhj6Qfal4kBHdrfz6x9vcEtFdN2Or2U3Ydr9KmLk0E
 wJlBnaRp13x4mGhMKdtE6YuB49j7Pn54rKP2h7J0haIb8WnI8uiCe+ez1V0fP+4BO/w9Mwd
 3MmnL+jTnXhVJALN2i99A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kERBLthMyk4=:qI9fsZYPXUUpLVFWgfkJ7S
 8jOzLeH8Vs5YlP5YlahKQvihImBSri4+2DW8GuWgbJQTICysU2djoq9rtPCBtQ1b7tOka0faJ
 Ao2sPcab4eR7YhZi3Z/0vk5fIvFkRsqPuBa6TDZYnq2dGNQyYiThh2mWpgTVvNC1DPLR4qXuC
 H36LJDTKNTi38aYbdTfmcfIL5wwuzVZe3Qiq34IuA1xGgwZ7QdZMSD+sYrPJlrRZ76d62XVry
 AVZcK6yxepzU1d/g2Hco19R6hOx/oAvcxM0NEiIxgqtbCe6jFUicWBR5HFi5+4mrCNxXKpMH5
 mNOLSzdTd/4WTKNRpyAwYg24iqU7q1F2wogiuI7so/w11Ox5NF1zhCIM36FflrFX2II4d33+9
 5KQsIhV4RcVnB5tomvgyTiMlDRXNWeNXasBY10ak4jrADrUE4Of8oy4G+vexrpWd6R1uHrVFR
 n8UDmVFxULisZ0hUVL5eQ653QtveuvJ+5Oz+PX4prrQe85R/OzwHlaJRPkLY3w/kbcSJU2fYn
 kKUCo5iRh69CSFl6sNH0tTHPCCpWejlU79igkDjCONRSsnryTj7AqS506BgGrjwj1dSiPz7Us
 VBAJ7rsnrShNnYp6ZAMNuCZCIjcgCLJZ9oj6V5AxEK5Hoy9/531HllIgyU3HcUY8/c/0y2XYa
 S6wSTxvxZPEW1+rJSmNQs807/8NbruMFikJBMf2WF9F9Phy3soDqXKT1UBdu9yt21a2uncWaD
 AJjh38oe77Q/+nih+d21CnrbynweMTRooXDZZeTLTAl8e0VwfffIVrAgvwyLbcN4ALzXAjtdc
 9+dIneD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not unheard of that editors on Windows write CR/LF even if the
file originally had only LF. This is particularly awkward for exec lines
of a rebase -i todo sheet. Take for example the insn "exec echo": The
shell script parser splits at the LF and leaves the CR attached to
"echo", which leads to the unknown command "echo\r".

Work around that by stripping CR when reading the todo commands, as we
already do for LF.

This happens to fix t9903.14 and .15 in MSYS1 environments (with the
rebase--helper patches based on this patch series): the todo script
constructed in such a setup contains CR/LF thanks to MSYS1 runtime's
cleverness.

Based on a report and a patch by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index f797e8a..eac531b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -776,6 +776,9 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 
 		next_p = *eol ? eol + 1 /* strip LF */ : eol;
 
+		if (p != eol && eol[-1] == '\r')
+			eol--; /* strip Carriage Return */
+
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
 		if (parse_insn_line(item, p, eol)) {
-- 
2.10.1.513.g00ef6dd


