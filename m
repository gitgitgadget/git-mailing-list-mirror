Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BA21F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDUHfl (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:35:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:38523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbeDUHfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:35:41 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MO7Ca-1f6Vo527bI-005Zqc; Sat, 21
 Apr 2018 09:35:37 +0200
Date:   Sat, 21 Apr 2018 09:35:21 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 2/4] rebase -i: Handle "combination of <n> commits" with
 GETTEXT_POISON
In-Reply-To: <cover.1524296064.git.johannes.schindelin@gmx.de>
Message-ID: <f3ed66a2790cb290e065537a4fdf1f401e6ac835.1524296064.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8Par3C9IxzhHNegE8/yTVlVe+nPTZYWqBGufzySboEjqPXAGk8D
 wP045MaOgnwXBpTvXGz1g+FBQJ4sUhzFWm9L8ZFz0GEkHP4m+NyBRfi1X4AvudFFonqdRVk
 orCEDvm2dj1xYmnByRKq/FXij9nQ7wdVFJESFaan5LJJWZ/QJG194NyxmnbrNjGmsH8u5QT
 O0wur8CXikP5h8y99ITeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dFk3WDIIvI8=:c95MCk/MrYJ9vFh15Wszkx
 nCmqdnx3rhGZdkyPe6CqzhI9ALnHxj1Aub0SMCjekNz8o6738p78I2rpJShcFKCUgpZCrlz1N
 VWGd8xxFecTbzeQWsIcjMIOJfd7hy5HS++xLMgnU4CgEeFhPxcccBL1OErHCLXo4KMVan6EEi
 SEUz746dZj/CPyOPuiy7gYpj0DNzxDAIrRJVl3IXWkrKnyrX6JmIXAP6h+Qrje6H27Lr2gmUs
 FR8NMMV4h/CiNucjr6Yg7qKVeggjNGm3MhrukM5ghx43h+cM1Q8muQljy7sOwP9JEtUGTynaw
 oJ93GtGHm0tGmmyxmRTw36Vhtcsq56BbGndRFw+kXkWER6Ur5mRFol4V380zowQMOzTiuNK17
 9W7LrL3Ra+MlMJH2kts6qT8cmF1uhV2cU/lbEPw2a7WIHXySpXfY7kylef5Cur7I/sMD6k7Q1
 VO5giFqYPFLHOsLV87RJWO4ya6wxVJIr7wV+HXf9jGXM7UmLQkZjgvbrlGMCAT0GXlkt9jWBH
 7ZGyP0M2Nq1WC3Jd5MVmx1Vg6URAQtxPh0/79qZGDy0XjsLyO0GP//Y3c7q4JXNScPTojinqK
 61Blcyu9o5UJ5saTslGZEKA1jvHhixTAYoZpd279hz7K1YrtHdBW1US/03Xy2RVFfgAzM8NjI
 7jQpOYdEb7E1QRVl60WT7LL7rdPRPKjGqccQAu+jE0aFc48Z7IusnG5z86uBCI0aFnlaw04Ui
 sOgEw8S49gL/XJ6fphVE1zhRZVSvaA4Xi/XVn4ecr2wUa97B7rs54ACmpUzKR/dHX4Xo6Iac6
 6joyB9ga5jV3QhrT0wCmr5H09/sedOcUwrpJngOO75gwL6Q0xI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We previously relied on the localized versions of

	# This is a combination of <N> commits

(which we write into the commit messages during fixup/squash chains)
to contain <N> as ASCII.

This is not true in general, and certainly not in GETTEXT_POISON, as
demonstrated by the regression test we just introduced in t3418.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 667f35ebdff..dc482e76a28 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1343,19 +1343,18 @@ static int update_squash_messages(enum todo_command command,
 		eol = strchrnul(buf.buf, '\n');
 		if (buf.buf[0] != comment_line_char ||
 		    (p += strcspn(p, "0123456789\n")) == eol)
-			return error(_("unexpected 1st line of squash message:"
-				       "\n\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
-		count = strtol(p, NULL, 10);
-
-		if (count < 1)
-			return error(_("invalid 1st line of squash message:\n"
-				       "\n\t%.*s"),
-				     (int)(eol - buf.buf), buf.buf);
+			count = -1;
+		else
+			count = strtol(p, NULL, 10);
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header,
-			    _("This is a combination of %d commits."), ++count);
+		if (count < 1)
+			strbuf_addf(&header, _("This is a combination of "
+					       "several commits."));
+		else
+			strbuf_addf(&header,
+				    _("This is a combination of %d commits."),
+				    ++count);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
@@ -1398,13 +1397,22 @@ static int update_squash_messages(enum todo_command command,
 	if (command == TODO_SQUASH) {
 		unlink(rebase_path_fixup_msg());
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is the commit message #%d:"), count);
+		if (count < 2)
+			strbuf_addf(&buf, _("This is the next commit "
+					    "message:"));
+		else
+			strbuf_addf(&buf, _("This is the commit message #%d:"),
+				    count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
-			    count);
+		if (count < 2)
+			strbuf_addf(&buf, _("The next commit message will be "
+					    "skipped:"));
+		else
+			strbuf_addf(&buf, _("The commit message #%d will be "
+					    "skipped:"), count);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
-- 
2.17.0.windows.1.15.gaa56ade3205


