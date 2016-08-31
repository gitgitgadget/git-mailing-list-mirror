Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBB61F859
	for <e@80x24.org>; Wed, 31 Aug 2016 12:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbcHaMcv (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 08:32:51 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:42569 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932516AbcHaMcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 08:32:50 -0400
Received: (qmail 13069 invoked from network); 31 Aug 2016 12:32:48 -0000
Received: (qmail 4250 invoked from network); 31 Aug 2016 12:32:47 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 31 Aug 2016 12:32:45 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 02/11] i18n: add--interactive: mark simple here documents for translation
Date:   Wed, 31 Aug 2016 12:31:21 +0000
Message-Id: <1472646690-9699-3-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark messages in here document without interpolation for translation.

Marking for translation by removing here documents this way, rather than
take advantage of "print __ << EOF" way, makes other instances of help
messages in clean.c match the first two in this file.  Otherwise,
reusing here document would add a trailer newline to the message, making
them not match 100%, hence creating two entries in pot template for
translation rather than a single entry.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index fb8e5de..e11a33d 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -636,25 +636,25 @@ sub list_and_choose {
 }
 
 sub singleton_prompt_help_cmd {
-	print colored $help_color, <<\EOF ;
-Prompt help:
+	print colored $help_color, __(
+"Prompt help:
 1          - select a numbered item
 foo        - select item based on unique prefix
-           - (empty) select nothing
-EOF
+           - (empty) select nothing"),
+"\n";
 }
 
 sub prompt_help_cmd {
-	print colored $help_color, <<\EOF ;
-Prompt help:
+	print colored $help_color, __(
+"Prompt help:
 1          - select a single item
 3-5        - select a range of items
 2-3,6-9    - select multiple ranges
 foo        - select item based on unique prefix
 -...       - unselect specified items
 *          - choose all items
-           - (empty) finish selecting
-EOF
+           - (empty) finish selecting"),
+"\n";
 }
 
 sub status_cmd {
@@ -1573,14 +1573,14 @@ sub quit_cmd {
 }
 
 sub help_cmd {
-	print colored $help_color, <<\EOF ;
-status        - show paths with changes
+	print colored $help_color, __(
+"status        - show paths with changes
 update        - add working tree state to the staged set of changes
 revert        - revert staged set of changes back to the HEAD version
 patch         - pick hunks and update selectively
 diff	      - view diff between HEAD and index
-add untracked - add contents of untracked files to the staged set of changes
-EOF
+add untracked - add contents of untracked files to the staged set of changes"),
+"\n";
 }
 
 sub process_args {
-- 
2.7.4

