From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH] gitweb: Remove forgotten call to git_to_hash
Date: Thu, 31 Aug 2006 21:32:45 +0200
Message-ID: <20060831193245.G22a7ca6b@leonov.stosberg.net>
References: <200608272343.14653.jnareb@gmail.com> <7vac5px1ic.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 21:33:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIsHS-00075x-NY
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 21:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHaTcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 15:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWHaTcs
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 15:32:48 -0400
Received: from kleekamp.stosberg.net ([85.116.201.130]:43138 "EHLO
	kleekamp.stosberg.net") by vger.kernel.org with ESMTP
	id S932322AbWHaTcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 15:32:47 -0400
Received: by kleekamp.stosberg.net (Postfix, from userid 500)
	id ABDDBF4D7E; Thu, 31 Aug 2006 21:32:45 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac5px1ic.fsf@assigned-by-dhcp.cox.net>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26273>

On Aug 27th, Jakub Narebski sent a patch which removed the git_to_hash()
function and this call to it. The patch did not apply cleanly and had to
be applied manually. Removing the last chunk has obviously been forgotten.

See: commit  0aea33762b1262d11fb43eda9f3fc152b5622cca and
     message <200608272345.26722.jnareb@gmail.com>

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---
 gitweb/gitweb.perl |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9324d71..68f40bd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2778,10 +2778,6 @@ sub git_blobdiff {
 			@difftree
 				or die_error('404 Not Found', "Blob diff not found");
 
-		} elsif (defined $hash) { # try to find filename from $hash
-			if ($hash !~ /[0-9a-fA-F]{40}/) {
-				$hash = git_to_hash($hash);
-			}
 		} elsif (defined $hash &&
 		         $hash =~ /[0-9a-fA-F]{40}/) {
 			# try to find filename from $hash
-- 
1.4.2
