From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 14:07:40 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110226110740.GA3096@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2> <20110225192455.GA7130@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 26 12:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHyy-0004jo-Lg
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 12:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab1BZLGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 06:06:36 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:46278 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888Ab1BZLGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 06:06:35 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PtHyn-0006L6-Ri; Sat, 26 Feb 2011 14:06:29 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PtHzw-0002WL-A7; Sat, 26 Feb 2011 14:07:40 +0300
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167978>

Hi,

On Fri, Feb 25, 2011 at 10:54:40PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> 
> > On Fri, Feb 25, 2011 at 12:11:59PM +0100, Johannes Schindelin wrote:
> > 
> > > On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> > > 
> > > > Johannes, can we please try my patch[1] for msys.dll not to load 
> > > > user32.dll for every msys program (i.e. sh.exe too)? Combined 
> > > > together with 3 clipboard functions removal (details in [2]) from 
> > > > sh.exe, I bet this will result in significantly faster shell 
> > > > startup, configure runs, etc...
> > > > 
> > > > This days I have lack of access to windows machines, only wine, so I 
> > > > desperately need someones help to at least first rebuild msys.dll.
> > > > 
> > > > [1] http://repo.or.cz/w/msys/kirr.git/commitdiff/f7d7efebd35e8e5bf6d685ff4f1197941984be04
> > > > [2] http://repo.or.cz/w/msys/kirr.git/commitdiff/a97bed5d22f9c05f39776d8ea7856db4ce572dc5
> > 
> > For [1] please do
> > 
> > git://repo.or.cz/msysgit/kirr.git ks/no-user32-in-msysdll       # into msys
> 
> Too late. I already did the work.

Sorry for the confision. This one is ok to stay the way as you did it.

> 
> > > Three things:
> > > 
> > > [2] does not apply cleanly, so I am still desperately trying to find some 
> > > time to finish it off (the patches are to msys.git, not the 'msys' branch 
> > > of msysgit.git, so I had to find a quarter an hour in order to put them 
> > > there in the first place, taking up all the Git time budget I wanted to 
> > > allow myself for this week).
> > 
> > For [2] please do
> > 
> >     git pull git://repo.or.cz/msysgit/kirr.git ks/xser32.dll    # into devel
> 
> Again, too late. I already did the work.

Sorry again, but as done in my ks/xser32.dll this is not tied to msys,
so maybe better please pull my branch into devel instead?


> > > Further, I think that my beloved Shift+Insert will no longer work with 
> > > your [2].
> > 
> > Probably yes,
> 
> In my experiment after rebuilding msys-1.0.dll, it still works.

xser32.dll has nothing to do with msys - it's just a fake stub for
sh.exe. Before testing, have you "patched" sh.exe the way it is done in
my ks/xser32.dll
(http://repo.or.cz/w/msysgit/kirr.git/commit/9d952c74a52f577b2d16d4e4a489541a8fa7fbbd)

?

If not, I'm not surprised it still works :)

> > > And lastly, in [2] you claim that you cross-built msys-1.0.dll. I 
> > > would like to have a script doing that in msysgit.git.
> > 
> > This is in progress. Preliminary stuff (cross-built msys.dll no longer needs
> > mingwm10.dll), is here:
> > 
> > http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> > http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys
> 
> Thanks, I will try to find some time to test this next week.

Please don't - it does not build out of the box from msysgit yet. I just
wanted to show it is not staying stale. When it is finished, I'll let
you know.

> The problem for now is that when I time /share/msysGit/run-tests.sh, there 
> is hardly any gain from your patches:
> 
> Old:
> 
> 
> real    18m1.031s
> user    6m17.861s
> sys     19m25.257s
> 
> New:
> 
> real    17m54.500s
> user    6m12.319s
> sys     19m28.567s

Did you patch sh.exe to link to xser32.dll instead of user32.dll?

This is important because even with rebuilt msys.dll, original sh.exe
still links to user32.dll and this hides all the effort put into
stripping user32.dll from msys.dll.

Also I can't say for sure (hope yet) how sh-intensitive git tests are,
but at least running configure for say gettext or whatever should be
visibly faster, at least on wine.

> 
> Ciao,
> Dscho


Thanks,
Kirill
