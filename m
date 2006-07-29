From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Sat, 29 Jul 2006 00:08:19 -0400
Message-ID: <20060729040819.GD28128@spearce.org>
References: <20060728063620.GD30783@spearce.org> <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx> <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net> <20060729033214.GA28128@spearce.org> <1154145355.26378.35.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 06:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6g7p-0003ja-Gr
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 06:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWG2EIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 00:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWG2EIZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 00:08:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55259 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161436AbWG2EIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jul 2006 00:08:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6g7i-0004Sz-Sy; Sat, 29 Jul 2006 00:08:23 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 25BF320E433; Sat, 29 Jul 2006 00:08:20 -0400 (EDT)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1154145355.26378.35.camel@dv>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24413>

Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2006-07-28 at 23:32 -0400, Shawn Pearce wrote:
> 
> > Hmm.  My website is known to return 200 OK status codes on missing
> > files with HTML pages rather than proper 404 Not Found.  I guess
> > I need to get that fixed.
> 
> Maybe git-http-fetch could treat MIME type text/html like error 404?
> It's not like any valid file git requests can be in HTML format.

This has been discussed to death on the list, mostly due to my pg
repository causing the same error (its on the same server).

The solution turned out to be rather good in my opinion: if an
object is corrupt we log it, and skip to pack downloading.  At the
end the bad object is logged and the user is encouraged to run
git-fsck-objects to verify there's no corrupt objects or objects
which are missing things they point at (e.g. ancestor commits
or trees).

Of course the real solution here is for me to fix my server.  :-)

> > I just compiled and installed `next` (1.4.2.rc1.g802da) and it can
> > clone this repository just fine over HTTP, despite my broken server.
> > So I'm not really sure what is going on.
> 
> Sorry, I was unclear.  I can clone the repository, I was just concerned
> that something was missing from it.

git-http-fetch recommends running git-fsck-objects to be sure,
but yea, usually its complete even though you get the error.

-- 
Shawn.
