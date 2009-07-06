From: Nick Woolley <nick@noodlefactory.co.uk>
Subject: [PATCH 1/2] Remove archaic use of regex capture \1 in favour of $1
Date: Mon, 06 Jul 2009 14:33:07 +0100
Organization: Noodle Factory Ltd
Message-ID: <4A51FD13.3030708@noodlefactory.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 16:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNovZ-0001UO-OE
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 16:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbZGFOMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753906AbZGFOMD
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 10:12:03 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:57359 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbZGFOMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 10:12:03 -0400
X-Greylist: delayed 2342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2009 10:12:02 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nick@noodlefactory.co.uk>)
	id 1MNoJb-0006cz-Hs
	for git@vger.kernel.org; Mon, 06 Jul 2009 14:33:03 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122788>

Using it will generate a perl warning "\1 better written as $1".

Signed-off-by: Nick Woolley <git.wu-lee@noodlefactory.co.uk>
---
 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index a36df33..d509468 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -299,7 +299,7 @@ foreach my $f (@files) {
 	while (<FILTER_IN>)
 	{
 	    my $line = $_;
-	    $line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$\1\$/g;
+	    $line =~ s/\$([A-Z][a-z]+):[^\$]+\$/\$$1\$/g;
 	    print FILTER_OUT $line;
 	}
 	close FILTER_IN;
-- 
1.6.3.3
