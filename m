From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] git-svn: sort the options in the --help message.
Date: Sat,  3 Nov 2007 19:53:34 +0100
Message-ID: <1194116014-13964-1-git-send-email-tsuna@lrde.epita.fr>
Cc: gitster@pobox.com, normalperson@yhbt.net,
	Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 19:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoO8I-00024N-61
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 19:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756202AbXKCSxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 14:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755565AbXKCSxp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 14:53:45 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:61826 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755442AbXKCSxo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Nov 2007 14:53:44 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id 105CEC27039; Sat,  3 Nov 2007 19:53:34 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63299>

	* git-svn.perl (&usage): Sort the various options.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
It always annoys me when I read the output of git svn <cmd> --help that the
options are printed in no particular order.

 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 22bb47b..4900f57 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -252,7 +252,7 @@ Usage: $0 <command> [options] [arguments]\n
 		next if $cmd && $cmd ne $_;
 		next if /^multi-/; # don't show deprecated commands
 		print $fd '  ',pack('A17',$_),$cmd{$_}->[1],"\n";
-		foreach (keys %{$cmd{$_}->[2]}) {
+		foreach (sort keys %{$cmd{$_}->[2]}) {
 			# mixed-case options are for .git/config only
 			next if /[A-Z]/ && /^[a-z]+$/i;
 			# prints out arguments as they should be passed:
-- 
1.5.3.4.398.g859b
