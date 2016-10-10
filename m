Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2074B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbcJJR0a (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:57320 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbcJJR0V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:21 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MZCUG-1baryA0zHw-00KzB0; Mon, 10 Oct 2016 19:26:18
 +0200
Date:   Mon, 10 Oct 2016 19:26:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 19/25] sequencer: left-trim lines read from the script
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <18eb2ccecb17b05b0742bde38cd10a9719f5a199.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uUfwn2jqoX5yuMA41ibl7HU8UcEd9jhncZWTX1u+voONwoMWtSf
 MU4WZ4v6vMAgoqdO/hHszWw2R/MuzJrEwIo3hKYfrJx/SjdJ1G4rtkN5D8kWyyQDhyvXynf
 hBw8JVQK+eABbk8dU88CO4MZelTgX8WETXNEODAvY+Oc9ipbqKd32oG71BXAt0oCZb5v2OS
 APcUCrsD6y465vyEPmQ7Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:snppbOMNlp4=:6658EH4CmrvbasVkRSg6VA
 6SWHL52r3Pl1MRmhSVS3owaZ8SSZya4KYP8C2N+wRL+aX2lmA6CCROmDJyeEgNygRUW3Jzumy
 vArWIiyantD9uKY51ScNcADYrDpJNhvksPPx4k9QMUURtMloVl67Sc8VqlYsn9UFC6dUut+/3
 j88NNjL2QVAFr9X6K5NmiNd6mZvtApJm2RpLMUAWhB33EgXccRSXldEivQ9+KZzQ74d3K2JMR
 5lXYpjfoKHgmRwyw+1ZUfbrlVnQdDGKsTia8NrytRTP34bNLX/+V2upxyyojkvnZUEuymBqxt
 Emyru3F7mNHq4JcUE6CzlMp+2c7ERDvaN2plNMhYXUnHNg2cyGwQIGXmmkDJ9WvvPqaoQqvMB
 YWgkcidlzdxUPpAPTxZKSLNTkylQv5hm7X/fyn/dUH7Qps92AcevTBr6XeX47Nyx6JmqJ1s52
 uIV3Z/rMMMWTkl2wdZ8YpGNCCNO0wZJIcjvHZfbKeKIaUbs3tU8xxq4tBRKK4Mdbm24r2oX2z
 vtCYHmn2eWnJXMpYCv/5TFUaVkoF1n2iyN1P5G2UusRDfjHADj068VjyrIdXrMXdfN346cFE/
 hG5UsqXZxKCMUXOelQ3XoSBLGTh+ywJqfb6AD5BSn0FNpO2J0RJ64r5m5R8TO2PBT7nckl1sA
 6wdY7EX9jrIToM5e7NFFVFa/GJINutNyPgt6Kw2iIcNH49IX/03YApaBiuKS3nFRtQxmOYhrl
 feRK+IMnZRla8lwYypeZ1DDfsJ755eMw4P+3aZqWmrsFTWUgRLvjXXYcFeUI8wqj0dC+z1XhT
 /9Dh9eS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase's scripts may be indented; we need to handle this
case, too, now that we prepare the sequencer to process interactive
rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 23fe7db..45a3651 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -873,6 +873,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	/* left-trim */
+	bol += strspn(bol, " \t");
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
-- 
2.10.0.windows.1.325.ge6089c1


