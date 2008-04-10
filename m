From: Pedro Melo <melo@simplicidade.org>
Subject: [PATCH] Force the medium pretty format on calls to git log
Date: Thu, 10 Apr 2008 17:05:21 +0100
Message-ID: <1207843521-8492-1-git-send-email-melo@simplicidade.org>
Cc: Pedro Melo <melo@simplicidade.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 18:14:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjzOo-0006xC-DZ
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbYDJQMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757234AbYDJQMO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 12:12:14 -0400
Received: from mail.sl.pt ([212.55.140.13]:57138 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755589AbYDJQMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 12:12:13 -0400
Received: (qmail 31226 invoked from network); 10 Apr 2008 16:05:30 -0000
Received: from unknown (HELO localhost.localdomain) (melo@[195.23.56.60])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Apr 2008 16:05:30 -0000
Received-SPF: none (mail-sl: domain of melo@simplicidade.org does not designate permitted sender hosts)
X-Mailer: git-send-email 1.5.5.23.g2a5f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79236>

If a user as set a format.pretty in his config, git-svn rebase will fail with:

Unable to determine upstream SVN information from working tree history

We need to force the medium format to obtain the needed information from the log.

Signed-off-by: Pedro Melo <melo@simplicidade.org>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 81afb5c..b864b54 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1120,7 +1120,7 @@ sub cmt_metadata {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my @args = ('log', '--no-color', '--first-parent');
+	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
 	my ($fh, $ctx) = command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
-- 
1.5.5.23.g2a5f
