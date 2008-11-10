From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/4] git send-email: make the message file name more specific.
Date: Tue, 11 Nov 2008 00:53:59 +0100
Message-ID: <1226361242-2516-2-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1226361242-2516-1-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:55:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzgbY-0003dS-GF
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:55:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbYKJXyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbYKJXyK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:54:10 -0500
Received: from pan.madism.org ([88.191.52.104]:37655 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbYKJXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:54:08 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3FBC53CD81;
	Tue, 11 Nov 2008 00:54:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E862A2A290; Tue, 11 Nov 2008 00:54:02 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.862.g3e9be
In-Reply-To: <1226361242-2516-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100599>

This helps editors choosing their syntax hilighting properly.

Also make the file live under the git directory.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-send-email.perl |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 94ca5c8..aaace02 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -124,9 +124,6 @@ my $auth;
 sub unique_email_list(@);
 sub cleanup_compose_files();
 
-# Constants (essentially)
-my $compose_filename = ".msg.$$";
-
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$author,$sender,$smtp_authpass,$compose,$time);
@@ -149,6 +146,7 @@ if ($@) {
 
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
+my $compose_filename = $repo->repo_path() . "/.gitsendemail.msg.$$";
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-- 
1.6.0.4.859.g7ecd.dirty
