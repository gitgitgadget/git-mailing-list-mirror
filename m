Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F365420986
	for <e@80x24.org>; Mon, 10 Oct 2016 12:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbcJJM4F (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 08:56:05 -0400
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:37663 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752447AbcJJM4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 08:56:04 -0400
Received: (qmail 11696 invoked from network); 10 Oct 2016 12:56:03 -0000
Received: (qmail 18072 invoked from network); 10 Oct 2016 12:56:02 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Oct 2016 12:56:00 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/14] i18n: add--interactive: i18n of help_patch_cmd
Date:   Mon, 10 Oct 2016 12:54:42 +0000
Message-Id: <20161010125449.7929-8-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.10.1.396.g621fe23
In-Reply-To: <20161010125449.7929-1-vascomalmeida@sapo.pt>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
In-Reply-To: <20161005172110.30801-1-vascomalmeida@sapo.pt>
References: <20161005172110.30801-1-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark help message of help_patch_cmd for translation.  The message must
be unfolded to be free of variables so we can have high quality
translations.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-add--interactive.perl | 54 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index b7d382b..045b847 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1189,15 +1189,53 @@ sub edit_hunk_loop {
 	}
 }
 
+my %help_patch_modes = (
+	stage => N__(
+"y - stage this hunk
+n - do not stage this hunk
+q - quit; do not stage this hunk or any of the remaining ones
+a - stage this hunk and all later hunks in the file
+d - do not stage this hunk or any of the later hunks in the file"),
+	stash => N__(
+"y - stash this hunk
+n - do not stash this hunk
+q - quit; do not stash this hunk or any of the remaining ones
+a - stash this hunk and all later hunks in the file
+d - do not stash this hunk or any of the later hunks in the file"),
+	reset_head => N__(
+"y - unstage this hunk
+n - do not unstage this hunk
+q - quit; do not unstage this hunk or any of the remaining ones
+a - unstage this hunk and all later hunks in the file
+d - do not unstage this hunk or any of the later hunks in the file"),
+	reset_nothead => N__(
+"y - apply this hunk to index
+n - do not apply this hunk to index
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file"),
+	checkout_index => N__(
+"y - discard this hunk from worktree
+n - do not discard this hunk from worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file"),
+	checkout_head => N__(
+"y - discard this hunk from index and worktree
+n - do not discard this hunk from index and worktree
+q - quit; do not discard this hunk or any of the remaining ones
+a - discard this hunk and all later hunks in the file
+d - do not discard this hunk or any of the later hunks in the file"),
+	checkout_nothead => N__(
+"y - apply this hunk to index and worktree
+n - do not apply this hunk to index and worktree
+q - quit; do not apply this hunk or any of the remaining ones
+a - apply this hunk and all later hunks in the file
+d - do not apply this hunk or any of the later hunks in the file"),
+);
+
 sub help_patch_cmd {
-	my $verb = lc $patch_mode_flavour{VERB};
-	my $target = $patch_mode_flavour{TARGET};
-	print colored $help_color, <<EOF ;
-y - $verb this hunk$target
-n - do not $verb this hunk$target
-q - quit; do not $verb this hunk or any of the remaining ones
-a - $verb this hunk and all later hunks in the file
-d - do not $verb this hunk or any of the later hunks in the file
+	print colored $help_color, __($help_patch_modes{$patch_mode}), "\n", __ <<EOF ;
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
-- 
2.7.4

