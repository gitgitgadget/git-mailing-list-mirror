From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] We need to check for msys as well as Windows in add--interactive.
Date: Fri, 11 Jul 2008 18:52:42 +0200
Message-ID: <1215795162-1174-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Mike Pape <dotzenlabs@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:00:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLyy-0005lt-QF
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbYGKQ7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754107AbYGKQ7f
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:59:35 -0400
Received: from mailer.zib.de ([130.73.108.11]:59583 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754124AbYGKQ7e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:59:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BGqgYn027970;
	Fri, 11 Jul 2008 18:52:48 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BGqgUR010573;
	Fri, 11 Jul 2008 18:52:42 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88145>

From: Mike Pape <dotzenlabs@gmail.com>

Signed-off-by: Mike Pape <dotzenlabs@gmail.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-add--interactive.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Nobody has commented on this patch, nor has it been applied.

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 903953e..78a64e6 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -42,7 +42,7 @@ sub colored {
 my $patch_mode;
 
 sub run_cmd_pipe {
-	if ($^O eq 'MSWin32') {
+	if ($^O eq 'MSWin32' || $^O eq 'msys') {
 		my @invalid = grep {m/[":*]/} @_;
 		die "$^O does not support: @invalid\n" if @invalid;
 		my @args = map { m/ /o ? "\"$_\"": $_ } @_;
-- 
1.5.6.1.282.gd8a0d
