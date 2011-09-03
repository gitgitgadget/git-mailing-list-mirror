From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] send-email: add option -h
Date: Sat, 3 Sep 2011 19:06:13 +0200
Message-ID: <20110903170612.GA3536@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 19:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzthy-0001Nu-IV
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 19:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab1ICRIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 13:08:35 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:29856 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753095Ab1ICRIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 13:08:35 -0400
Received: from localhost (p5B22F905.dip.t-dialin.net [91.34.249.5])
	by bsmtp.bon.at (Postfix) with ESMTP id 1FECA13004E;
	Sat,  3 Sep 2011 19:08:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180662>

Most other git commands print a synopsis when passed -h. Make
send-email do the same.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 git-send-email.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..4ac6931 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -275,7 +275,9 @@ $SIG{INT}  = \&signal_handler;
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
-my $rc = GetOptions("sender|from=s" => \$sender,
+my $help;
+my $rc = GetOptions("help|H|h" => \$help,
+		    "sender|from=s" => \$sender,
                     "in-reply-to=s" => \$initial_reply_to,
 		    "subject=s" => \$initial_subject,
 		    "to=s" => \@initial_to,
@@ -313,6 +315,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "force" => \$force,
 	 );
 
+usage() if $help;
 unless ($rc) {
     usage();
 }
-- 
1.7.6.1
