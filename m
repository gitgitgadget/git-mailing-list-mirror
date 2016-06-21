Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B26C1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 11:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbcFULpe (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 07:45:34 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:43590 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751139AbcFULpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 07:45:30 -0400
Received: (qmail 1846 invoked from network); 21 Jun 2016 11:45:28 -0000
Received: (qmail 28846 invoked from network); 21 Jun 2016 11:45:28 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 21 Jun 2016 11:45:24 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/11] i18n: add--interactive: mark simple here documents for translation
Date:	Tue, 21 Jun 2016 11:44:04 +0000
Message-Id: <20160621114413.9467-2-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.9.0.47.g9ba0c31
In-Reply-To: <20160621114413.9467-1-vascomalmeida@sapo.pt>
References: <20160621114413.9467-1-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.6.6

