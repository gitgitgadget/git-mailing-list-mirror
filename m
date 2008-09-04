From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: latest clone/pull of git.git problems with setlinebuf.
Date: Wed, 3 Sep 2008 19:10:47 -0600
Message-ID: <alpine.LNX.1.10.0809031907540.12887@suse104.zenez.com>
References: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 03:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kb3O6-0007tn-Vt
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 03:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbYIDBKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 21:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbYIDBKt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 21:10:49 -0400
Received: from suse104.zenez.com ([198.60.105.164]:5723 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIDBKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 21:10:48 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id B077BA7C931; Wed,  3 Sep 2008 19:10:47 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 98705A7C92F
	for <git@vger.kernel.org>; Wed,  3 Sep 2008 19:10:47 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.10.0809031858570.12887@suse104.zenez.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94876>

On Wed, 3 Sep 2008, Boyd Lynn Gerber wrote:
> I just noticed that setlinebuf is coming back as undefined when trying to 
> build the lastest version.

I did

git clone git://git.kernel.org/pub/scm/git/git.git git

cd git/
gmake configure
CC=cc CXX=CC ./configure

And then I get the errors.

> on UnixWare 7.1.4 I get
>
>    LINK git-var
>    CC daemon.o
> UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
>    LINK git-daemon
> Undefined                       first referenced
> symbol                              in file
> setlinebuf                          daemon.o
> UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
> gmake: *** [git-daemon] Error 1
>
>
> and on OpenServer 6.0 I get
>
>    LINK git-http-push
>    CC daemon.o
> UX:acomp: WARNING: "daemon.c", line 485: end-of-loop code not reached
>    LINK git-daemon
> Undefined                       first referenced
> symbol                              in file
> setlinebuf                          daemon.o
> UX:ld: ERROR: Symbol referencing errors. No output written to git-daemon
> gmake: *** [git-daemon] Error 1
>
> So the new behavior breaks things.  On UnixWare 7.1.4 there is a /usr/ucb/cc 
> but when I use it much more breaks.  It is better to use the /usr/bin/cc.
>
> Can we please revert the patch that breaks this or provide a better fix. The 
> older methods at least worked.

I really hate getting everything working only to then have another 
break-age from master on a pull.  Can we please try to keep some 
compatitbility with other non linux OS's.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
