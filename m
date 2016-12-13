Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ECA2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933448AbcLMPdt (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:33:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:57967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932575AbcLMPdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:33:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhQxO-1bvQb62ldq-00McxB; Tue, 13
 Dec 2016 16:32:47 +0100
Date:   Tue, 13 Dec 2016 16:32:44 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 32/34] sequencer (rebase -i): show the progress
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <9e48dffa8e58183debb79f29413afa81af174475.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9FiICUW0InMlJN+PjUJbFmz6RkPDCri8LAyrGi62O7dyPhpxJHQ
 98qbNsHTZ3z0/kPpLosRKmOOYtcPJYWpJxsIafUwRjVNo/As7t5dzFfBUfT5TZ5H9vZxQ6B
 xeD1vEZsTWBxFm/Ev106FJWKGC/mFeEioPgQwCs/Z0DUjFJtHhYsc06D5BYTPDdvYUphLdB
 eJKiPgjxTC0d7lu733hgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/0va6S4U2P8=:uNWljp9WxxK/dbC9QkImFp
 PKsVueKdpJB15EkbB5Hrk5np42/4U34Rc6RC8XRIcjQ20Be/qOZm9zlE0rT7evbMPT7ILNwy9
 Avdcg0tdow1Pr+OL6u23taGMOyNgxDpP32wRf+8tfY7HS1i9nkAVDevJ161cTGbV0QT8jk7qE
 bNv0BqyJKrUkIWTs+2XdHHBr++lYxxwBKZzzKt5joCAGKFkgUl08u+Pm7/mC0m9Rg4eQ85LwD
 13GSd/VbtkV40bRV+kP+JjIv3Bfx2X0wuEwxtpCCXHw8TJbzWOd2/tJlNS6Pv727X6A7b2h4y
 0yxpIIychBFv/jL2r+cKI7zLFRwNGys8PCWhC04WCBZPDT0SQXes3aViQhLHIjLy2aekzDPVu
 00nfT5ecaeEIncwiNo6osT0gEF/O8SxCppMo/VZ7lryB5ZAFy9w5LSHpFlgUgBWxIDZAKOilb
 fMwaAAvpO1FrKUMOMKSJt8gln0/bxWIGfTkJiK+Z62pEHlGqr77qLfQMsrN2Y88HSJ3ak/V4C
 hmKK20VB+H7iwH8FgTs2KU2EaNANjVAMRut5YT4WoqwkSiMsuG7fyonylUFeB/av3olFSVvLu
 4kCFNtW2teoqyNAIk+PIKBkvaLw+Q8ENFgiFYhoKFECladiRoD6hRg5QPviWFmkclN5gxKf7Q
 QQIuv8hFq/oe34nFpNblmdzdYGihdYmyDYWTUSBLpmCTBZumglUeCfPlAwGK2Eix02lYcFBy9
 8UMtjwU8i3B85LaNJ5pOHTn3t/BsXxjSrodY/G+dCYf2oqXXXlqSLTYq9MKAokiUJ/se52ntY
 PmT76EB
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
index 498dd028d1..35d5ef4ef6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1221,6 +1221,7 @@ struct todo_list {
 	struct strbuf buf;
 	struct todo_item *items;
 	int nr, alloc, current;
+	int done_nr, total_nr;
 };
 
 #define TODO_LIST_INIT { STRBUF_INIT }
@@ -1338,6 +1339,17 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
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
@@ -1380,6 +1392,21 @@ static int read_populate_todo(struct todo_list *todo_list,
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
 
@@ -1928,6 +1955,11 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
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


