From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] cvsimport: perform string comparison on "HEAD"
Date: Thu, 30 Jun 2005 16:55:28 +0200
Message-ID: <20050630145528.GA18553@pc117b.liacs.nl>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 16:49:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do0Ll-0001gN-8S
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 16:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVF3O42 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 10:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVF3O42
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 10:56:28 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:18377 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S261265AbVF3O40 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 10:56:26 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id j5UEtSqn029878;
	Thu, 30 Jun 2005 16:55:34 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id C74EF6FEA; Thu, 30 Jun 2005 16:55:28 +0200 (CEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <pan.2005.06.28.19.23.08.307486@smurf.noris.de>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -529,7 +529,7 @@ while(<CVS>) {
 	} elsif($state == 5 and s/^Ancestor branch:\s+//) {
 		s/\s+$//;
 		$ancestor = $_;
-		$ancestor = $opt_o if $ancestor == "HEAD";
+		$ancestor = $opt_o if $ancestor eq "HEAD";
 		$state = 6;
 	} elsif($state == 5) {
 		$ancestor = undef;
