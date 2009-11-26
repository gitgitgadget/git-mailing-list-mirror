From: Ingmar Vanhassel <ingmar@exherbo.org>
Subject: git-svn: dcommit --commiturl rebases against fetch url rather than against commit url
Date: Thu, 26 Nov 2009 02:15:16 +0100
Message-ID: <1259198081-sup-3175@cannonball>
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 02:38:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDTIn-00018d-Ak
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 02:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbZKZBhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 20:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbZKZBhd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 20:37:33 -0500
Received: from bach.exherbo.org ([78.47.197.147]:46787 "EHLO bach.exherbo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbZKZBhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 20:37:32 -0500
X-Greylist: delayed 1341 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2009 20:37:32 EST
Received: from [83.101.72.69] (helo=localhost)
	by bach.exherbo.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <ingmar@exherbo.org>)
	id 1NDSx3-00085H-39; Thu, 26 Nov 2009 01:15:17 +0000
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133752>

Hi Eric & list,

I'm using a git-svn setup where svn-remote.svn.url is set to use
anonymouse svn, and svn-remote.svn.commiturl uses my ssh+svn:// login.

I'm using anonymous svn for fetching because this git-svn import is
shared with a few other developers, who don't have commit access, but
who do prefer to use a git-svn import over SVN, for their work. Since I
use anonsvn for the import they can continue my import.

When I dcommit to svn, git-svn happily commits the first commit. When it
tries to rebase after that it fetches from the anonsvn url, which is
synced only ever 5 or 10 minutes. Thus, it doesn't find my commit, and
it aborts, meaning I need to wait until anonsvn catches up, before being
able to do another commit.

Any suggestions on how this could be solved without reimporting with
the rewriteRoot option set?

-Ingmar
-- 
Exherbo KDE, X.org maintainer
