From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Fri, 25 Feb 2011 22:54:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1102252251140.15247@pacific.mpi-cbg.de>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com> <20110225090544.GA3783@tugrik.mns.mnsspb.ru> <alpine.DEB.1.00.1102251208380.1561@bonsai2>
 <20110225192455.GA7130@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 25 22:54:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt5cd-0003VM-KX
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932759Ab1BYVyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 16:54:43 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:51431 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932105Ab1BYVym (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 16:54:42 -0500
Received: (qmail invoked by alias); 25 Feb 2011 21:54:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 25 Feb 2011 22:54:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JoXB2f+eJ/VnNyvEdxvGggbs/kSsoevoF7mHtyr
	9s5/Wdd4Rm9r1A
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20110225192455.GA7130@tugrik.mns.mnsspb.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167947>

Hi,

On Fri, 25 Feb 2011, Kirill Smelkov wrote:

> On Fri, Feb 25, 2011 at 12:11:59PM +0100, Johannes Schindelin wrote:
> 
> > On Fri, 25 Feb 2011, Kirill Smelkov wrote:
> > 
> > > Johannes, can we please try my patch[1] for msys.dll not to load 
> > > user32.dll for every msys program (i.e. sh.exe too)? Combined 
> > > together with 3 clipboard functions removal (details in [2]) from 
> > > sh.exe, I bet this will result in significantly faster shell 
> > > startup, configure runs, etc...
> > > 
> > > This days I have lack of access to windows machines, only wine, so I 
> > > desperately need someones help to at least first rebuild msys.dll.
> > > 
> > > [1] http://repo.or.cz/w/msys/kirr.git/commitdiff/f7d7efebd35e8e5bf6d685ff4f1197941984be04
> > > [2] http://repo.or.cz/w/msys/kirr.git/commitdiff/a97bed5d22f9c05f39776d8ea7856db4ce572dc5
> 
> For [1] please do
> 
> git://repo.or.cz/msysgit/kirr.git ks/no-user32-in-msysdll       # into msys

Too late. I already did the work.

> > Three things:
> > 
> > [2] does not apply cleanly, so I am still desperately trying to find some 
> > time to finish it off (the patches are to msys.git, not the 'msys' branch 
> > of msysgit.git, so I had to find a quarter an hour in order to put them 
> > there in the first place, taking up all the Git time budget I wanted to 
> > allow myself for this week).
> 
> For [2] please do
> 
>     git pull git://repo.or.cz/msysgit/kirr.git ks/xser32.dll    # into devel

Again, too late. I already did the work.

> > Further, I think that my beloved Shift+Insert will no longer work with 
> > your [2].
> 
> Probably yes,

In my experiment after rebuilding msys-1.0.dll, it still works.

> > And lastly, in [2] you claim that you cross-built msys-1.0.dll. I 
> > would like to have a script doing that in msysgit.git.
> 
> This is in progress. Preliminary stuff (cross-built msys.dll no longer needs
> mingwm10.dll), is here:
> 
> http://repo.or.cz/w/msys/kirr.git/shortlog/refs/heads/x/kirr
> http://repo.or.cz/w/msysgit/kirr.git/shortlog/refs/heads/ks/crossmsys

Thanks, I will try to find some time to test this next week.

The problem for now is that when I time /share/msysGit/run-tests.sh, there 
is hardly any gain from your patches:

Old:


real    18m1.031s
user    6m17.861s
sys     19m25.257s

New:

real    17m54.500s
user    6m12.319s
sys     19m28.567s

Ciao,
Dscho
