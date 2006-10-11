From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/2] git-svn: -h(elp) message formatting fixes
Date: Wed, 11 Oct 2006 14:53:36 -0700
Message-ID: <11606036173604-git-send-email-normalperson@yhbt.net>
References: <1160603616126-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 23:54:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXm1F-00028j-0H
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161533AbWJKVxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWJKVxh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:53:37 -0400
Received: from hand.yhbt.net ([66.150.188.102]:13196 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1161533AbWJKVxf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 17:53:35 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DA5F37DC091;
	Wed, 11 Oct 2006 14:53:33 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 14:53:37 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.3.rc2.gbe730
In-Reply-To: <1160603616126-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28755>

'graft-branches' is slightly longer than the rest of the
commands, so the text was squished together in the formatted
output.  This patch just adds some more whitespace to make
the text look more pleasant.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4f6e6a3..84d2c58 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -169,11 +169,11 @@ Usage: $0 <command> [options] [arguments
 
 	foreach (sort keys %cmd) {
 		next if $cmd && $cmd ne $_;
-		print $fd '  ',pack('A13',$_),$cmd{$_}->[1],"\n";
+		print $fd '  ',pack('A17',$_),$cmd{$_}->[1],"\n";
 		foreach (keys %{$cmd{$_}->[2]}) {
 			# prints out arguments as they should be passed:
 			my $x = s#[:=]s$## ? '<arg>' : s#[:=]i$## ? '<num>' : '';
-			print $fd ' ' x 17, join(', ', map { length $_ > 1 ?
+			print $fd ' ' x 21, join(', ', map { length $_ > 1 ?
 							"--$_" : "-$_" }
 						split /\|/,$_)," $x\n";
 		}
-- 
1.4.3.rc2.gbe730
