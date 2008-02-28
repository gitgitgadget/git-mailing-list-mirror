From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: [PATCH] cvsimport: have default merge regex allow for dashes in the branch name
Date: Thu, 28 Feb 2008 11:18:21 +0100
Message-ID: <1204193904-3652-2-git-send-email-book@cpan.org>
References: <>
 <1204193904-3652-1-git-send-email-book@cpan.org>
Cc: gitster@pobox.com, "Philippe Bruhat (BooK" <book@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 11:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfrV-0005MG-Ri
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 11:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbYB1KTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 05:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754509AbYB1KTA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 05:19:00 -0500
Received: from zlonk.bruhat.net ([91.121.102.217]:34200 "EHLO
	ks354402.kimsufi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbYB1KS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 05:18:57 -0500
Received: from localhost ([127.0.0.1] helo=plop.home.bruhat.net)
	by ks354402.kimsufi.com with esmtp (Exim 4.63)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfrr-0007ph-3i; Thu, 28 Feb 2008 11:19:59 +0100
Received: from book by plop.home.bruhat.net with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1JUfqU-0000aM-BI; Thu, 28 Feb 2008 11:18:34 +0100
X-Mailer: git-send-email 1.5.4.2.187.gfc276
In-Reply-To: <1204193904-3652-1-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75377>

From: Philippe Bruhat (BooK <book@cpan.org>

The default value of @mergerx uses \w, which matches word
character; a branch name like policy-20050608-br will not be
matched.
---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 9516242..3d013a7 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -164,7 +164,7 @@ if ($#ARGV == 0) {
 
 our @mergerx = ();
 if ($opt_m) {
-	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) (\w+)/i );
+	@mergerx = ( qr/\b(?:from|of|merge|merging|merged) ([-\w]+)/i );
 }
 if ($opt_M) {
 	push (@mergerx, qr/$opt_M/);
-- 
1.5.4.2.187.gfc276
