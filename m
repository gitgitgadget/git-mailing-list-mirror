From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 4 Sep 2007 15:48:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041547240.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com>
 <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com>
 <46DD0C16.70101@eudaptics.com> <Pine.LNX.4.64.0709041145230.28586@racer.site>
 <46DD433A.5040604@eudaptics.com> <46DD473A.8010602@trolltech.com>
 <46DD63F5.5050002@trolltech.com> <Pine.LNX.4.64.0709041529191.28586@racer.site>
 <46DD6F2B.3060001@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@eudaptics.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 16:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZi1-0001WZ-0I
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 16:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbXIDOsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 10:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbXIDOsq
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 10:48:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:33246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754030AbXIDOsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 10:48:45 -0400
Received: (qmail invoked by alias); 04 Sep 2007 14:48:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 04 Sep 2007 16:48:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oUYk0m10oNdsE+XyRqCIj/jHqV8oilrX7PTYkxe
	JdinpW1eoJbxe4
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD6F2B.3060001@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57585>

Hi,

On Tue, 4 Sep 2007, Marius Storm-Olsen wrote:

> Johannes Schindelin wrote:
> > On Tue, 4 Sep 2007, Marius Storm-Olsen wrote:
> >> Neat, with the custom stat() changes cherry-picked on top of
> >> 4msysgit.git 'devel' branch, I only have one failing testcase 
> >> t6024-recursive-merge.sh when running $ NO_SYMLINKS=1 make -k
> >> 
> >> The rest are passing with flying colors!
> > 
> > Bad news.  I do not know if it was the newest version I tried, but I
> > could no longer fetch... said something about some bad file.
> 
> Then you're missing this patch:
> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=f15974add93bdfa92775c77c00e7c65aefd42127
> 
> I guess the quickest way is to manually apply this patch and recompile.
> (or add the '#undef fstat', and have git_fstat just 'return fstat(fd, buf)')
> 
> The problem is that without this patch fstat(0, buf) would fail with bad
> filedescriptor instead of returning the st_mode = S_IFIFO.

I guessed as much, but could not fetch the patch, since fetch was broken 
;-)

For some utterly strange reason, "git fetch" accessed "git-fetch" in the 
cwd, not in /bin/...  Funny.

Ciao,
Dscho
