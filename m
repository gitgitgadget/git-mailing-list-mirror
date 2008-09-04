From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 19:04:30 -0600
Message-ID: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 03:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb3IK-0006hF-49
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 03:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYIDBEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 21:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYIDBEc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 21:04:32 -0400
Received: from suse104.zenez.com ([198.60.105.164]:17774 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbYIDBEb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 21:04:31 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id BBE82A7C92F; Wed,  3 Sep 2008 19:04:30 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id ABE03A7C92E
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 19:04:30 -0600 (MDT)
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94875>

Hello,

I just noticed that setlinebuf is coming back as undefined when trying to 
build the lastest version.

on UnixWare 7.1.4 I get

     LINK git-var
     CC daemon.o
UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
     LINK git-daemon
Undefined                       first referenced
symbol                              in file
setlinebuf                          daemon.o
UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
gmake: *** [git-daemon] Error 1


and on OpenServer 6.0 I get

     LINK git-http-push
     CC daemon.o
UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
     LINK git-daemon
Undefined                       first referenced
symbol                              in file
setlinebuf                          daemon.o
UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
gmake: *** [git-daemon] Error 1

So the new behavior breaks things.  On UnixWare 7.1.4 there is a 
/usr/ucb/cc but when I use it much more breaks.  It is better to use the 
/usr/bin/cc.

Can we please revert the patch that breaks this or provide a better fix. 
The older methods at least worked.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
