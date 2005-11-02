From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: cvsps should be quiet too
Date: Wed, 2 Nov 2005 13:53:23 +1300
Message-ID: <11308928033950-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Nov 02 01:50:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6oa-00074d-PS
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 01:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVKBAtS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 19:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVKBAtS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 19:49:18 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:64214 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932099AbVKBAtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 19:49:17 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1EX6oU-0007Yd-VU; Wed, 02 Nov 2005 13:49:15 +1300
Received: from mltest ([127.0.0.1])
	by mltest with smtp (Exim 3.36 #1 (Debian))
	id 1EX6sV-0001sC-00; Wed, 02 Nov 2005 13:53:24 +1300
In-Reply-To: 
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10986>

Tell cvsps to be quite, unless we've been told to be verbose.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsimport.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 3b008080b6ab6077e6dd2178c01dee4efed8ef42
720675e4ad1e4efcda6af41461cf264617194ffc
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 0144670..7bd9136 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -491,6 +491,7 @@ unless($pid) {
 	my @opt;
 	@opt = split(/,/,$opt_p) if defined $opt_p;
 	unshift @opt, '-z', $opt_z if defined $opt_z;
+	unshift @opt, '-q'         unless defined $opt_v;
 	unless (defined($opt_p) && $opt_p =~ m/--no-cvs-direct/) {
 		push @opt, '--cvs-direct';
 	}
---
0.99.8.GIT
