Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2181205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933142AbdABPgI (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:36:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:56262 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933079AbdABPgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:36:07 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLeoF-1cNnP708OJ-000qrj; Mon, 02
 Jan 2017 16:36:02 +0100
Date:   Mon, 2 Jan 2017 16:35:46 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 36/38] sequencer (rebase -i): show the progress
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <56d3adf6a954be4ee52b20cbb1c8957ed66b88c0.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l+1wfeGWiwcUSuN36XqNP6ZgNzPJc3Lh5nbbXKNj1Qv7ZsCynqA
 f93RSWaxjlvvvNqmZdgmGv2Vk9Fee8SRpqkqHkVYViuRdzJU7uJRrv7ABRrhXNT4KlmfJyy
 GRM1/V2wxkD3glFU0W8NtqTVmG2R0xsl9DiLDYqT+scyLdbpL4ref8azF3k5rUSRyu0ki2h
 lW4WcVK/8jDNUeFB09Ing==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q1J/Dfo7JqU=:VRX7RNi2yyvN5GtZHQZ/N0
 vt4Y+F1gQSIuRTqY7F1K4Iiyd6p0XqSvCrrcZZgcSC/Egk93q89iojYUw7usu+wIUitVzDExF
 JYKuT9dV6jdfNWoD0sd+GJb/LIbEtJXm+40oCZd0rsyNQl1j+VsTPs8tIDtL3BIkuOnW1b8Yp
 D8U0JvwHEF0bjMiU/O5ZOCspJHDZTy4Hl50IXH2KrZNkZ20N2gBjL/WZ20Jemjk2bCJu0Opmc
 GyYyDvwnnm/KXuLuD0ViLmGyqS/tnI36Sw7F04DNDWF4yi1TfjyLloRoDlBjKco9DngK1Z6ai
 a9NHIsahqchhdMiT/ksD3fJX735tETbW5G4s12cqcUi/J8e1Q66nF4acYafyfXVhfRibI3Dos
 XKCFSQ8yv4sDiw0oTr7QOpCjAeO/08Hp5r7w8r0PfPjorESK/UPabNVVfnCOenVHMTApXWxtZ
 yPI5vlNXF0vggA5lmAPqIlp1oqXgoICQKExphoI478jbygYK/VKlnpSBSQOaYiko+fRD5Fqkh
 H9qhaszOg68qlMPhUR+Dq2tRameQueeSyxfyjjxA4AH+EAKO5iCCYY4y27iMolMnYx/UqX9qn
 Wq7orNXWkldMtdbsqiMeAng4qnUQsrMRQpDKPyyq/V6zdV1V7ekQjXDoid27V8b29UhD7y78N
 4Rdt0+I3sjGFlM7qw1rkelE8QYurrMJtTdGj80rE75eWvFjSoY/frysgvygXoTDqAoR8mCk/H
 fCiy3lX7gTUV4yUJmCBi0g5JBoIinKOpXNyolK6Gc0N9TT+pNZIA31v/KvaKO2UPLDf+iNnNU
 ZKiMBjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The interactive rebase keeps the user informed about its progress.
If the sequencer wants to do the grunt work of the interactive
rebase, it also needs to show that progress.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 4792a3de3b..2c9c555ab6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1181,6 +1181,7 @@ struct todo_list {
 	struct strbuf buf;
 	struct todo_item *items;
 	int nr, alloc, current;
+	int done_nr, total_nr;
 };
 
 #define TODO_LIST_INIT { STRBUF_INIT }
@@ -1297,6 +1298,17 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 	return res;
 }
 
+static int count_commands(struct todo_list *todo_list)
+{
+	int count = 0, i;
+
+	for (i = 0; i < todo_list->nr; i++)
+		if (todo_list->items[i].command != TODO_COMMENT)
+			count++;
+
+	return count;
+}
+
 static int read_populate_todo(struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
@@ -1339,6 +1351,21 @@ static int read_populate_todo(struct todo_list *todo_list,
 				return error(_("cannot revert during a cherry-pick."));
 	}
 
+	if (is_rebase_i(opts)) {
+		struct todo_list done = TODO_LIST_INIT;
+
+		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
+				!parse_insn_buffer(done.buf.buf, &done))
+			todo_list->done_nr = count_commands(&done);
+		else
+			todo_list->done_nr = 0;
+
+		todo_list->total_nr = todo_list->done_nr
+			+ count_commands(todo_list);
+
+		todo_list_release(&done);
+	}
+
 	return 0;
 }
 
@@ -1920,6 +1947,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
+			if (item->command != TODO_COMMENT)
+				fprintf(stderr, "Rebasing (%d/%d)%s",
+					++(todo_list->done_nr),
+					todo_list->total_nr,
+					opts->verbose ? "\n" : "\r");
 			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
-- 
2.11.0.rc3.windows.1


