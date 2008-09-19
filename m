From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Use dashless git commands in setgitperms.perl
Date: Fri, 19 Sep 2008 19:42:34 -0400
Message-ID: <20080919234234.GL2939@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 01:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgpde-0006L4-09
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 01:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbYISXml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 19:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYISXml
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 19:42:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbYISXmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 19:42:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E4F5618E4;
	Fri, 19 Sep 2008 19:42:39 -0400 (EDT)
Received: from inocybe.teonanacatl.org (c-69-248-23-23.hsd1.pa.comcast.net
 [69.248.23.23]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix)
 with ESMTPSA id 04429618E3; Fri, 19 Sep 2008 19:42:36 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Pobox-Relay-ID: A524C3A4-86A4-11DD-A8CD-D0CFFE4BC1C1-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96324>

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/hooks/setgitperms.perl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index dab7c8e..5c1fa91 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -8,14 +8,14 @@
 # To save permissions/ownership data, place this script in your .git/hooks
 # directory and enable a `pre-commit` hook with the following lines:
 #      #!/bin/sh
-#     SUBDIRECTORY_OK=1 . git-sh-setup
+#     SUBDIRECTORY_OK=1 . git sh-setup
 #     $GIT_DIR/hooks/setgitperms.perl -r
 #
 # To restore permissions/ownership data, place this script in your .git/hooks
 # directory and enable a `post-merge` and `post-checkout` hook with the
 # following lines:
 #      #!/bin/sh
-#     SUBDIRECTORY_OK=1 . git-sh-setup
+#     SUBDIRECTORY_OK=1 . git sh-setup
 #     $GIT_DIR/hooks/setgitperms.perl -w
 #
 use strict;
@@ -50,7 +50,7 @@ if ((@ARGV < 0) || !GetOptions(
 			      )) { die $usage; }
 die $usage unless ($read_mode xor $write_mode);
 
-my $topdir = `git-rev-parse --show-cdup` or die "\n"; chomp $topdir;
+my $topdir = `git rev-parse --show-cdup` or die "\n"; chomp $topdir;
 my $gitdir = $topdir . '.git';
 my $gitmeta = $topdir . '.gitmeta';
 
@@ -155,7 +155,7 @@ elsif ($read_mode) {
 	open (OUT, ">$gitmeta.tmp") or die "Could not open $gitmeta.tmp for writing: $!\n";
     }
 
-    my @files = `git-ls-files`;
+    my @files = `git ls-files`;
     my %dirs;
 
     foreach my $path (@files) {
-- 
1.6.0.2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
What a terrible thing to have lost one's mind. Or not to have a mind
at all. How true that is.
    -- Dan Quayle, speaking to the United Negro College Fund
