From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Statictics on Git.pm usage in git commands (was: [PATCH 2/3]
 add new Git::Repo API)
Date: Sun, 20 Jul 2008 14:33:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807201420500.3305@eeepc-johanness>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807192254.24622.jnareb@gmail.com> <alpine.DEB.1.00.0807201233010.3305@eeepc-johanness> <20080720104935.GB10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 14:34:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKY6w-0000a3-HD
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 14:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbYGTMc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 08:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbYGTMc6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 08:32:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753766AbYGTMc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 08:32:58 -0400
Received: (qmail invoked by alias); 20 Jul 2008 12:32:56 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp065) with SMTP; 20 Jul 2008 14:32:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1DQNXt4z17f/ggXhzgxl8qcVEQMBJ3q4vI6Homu
	306CXxv+7jaM+C
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080720104935.GB10151@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89193>

Hi,

On Sun, 20 Jul 2008, Petr Baudis wrote:

> On Sun, Jul 20, 2008 at 12:38:07PM +0200, Johannes Schindelin wrote:
>
> > Pasky tried to convert all Perl scripts at once IIRC, and my numerous 
> > problems just _making_ the Git scripts led me to rewrite a few Perl 
> > scripts in C, so I could safely exclude the Perl scripts from my 
> > personal fork.
> 
> I don't remember any concrete report of such problems ever reaching me; 
> exactly what trouble are you hitting with the Perl scripts using Git.pm?  
> I will be glad to try to fix it.

They reached you:

http://article.gmane.org/gmane.comp.version-control.git/23153

http://thread.gmane.org/gmane.comp.version-control.git/22764/focus=22778

Yes, those are very old mails, but they _do_ explain why the old Perl 
scripts avoided Git.pm.

> > But your mention of git-add--interactive actually brings up my 
> > pet-peeve: this script is the only Perl script needed for common 
> > operations, i.e. the only reason msysGit has to ship bloated with 
> > Perl.
> 
> _Many_ people seem to be using git-svn, whether we like it or not. ;-)

Well, they will just stop using it on msysGit, since nobody fixes git-svn 
on msysGit.

> Also, isn't git-send-mail rather commonly used? (I wouldn't know, me 
> using stg mail.)

send-mail does not work on Windows.  See 
http://code.google.com/p/msysgit/issues/detail?id=27

Yes, you read correctly.  The issue exists since almost the birth of 
msysGit.  Torgil seems to have stopped working on it altogether.  Two 
other people have "starred" the issue, wanting to be notified of fixes but 
not wanting to work on them.

To me, it seems that either the Windows folk is a lazy bunch of bums, or 
they just do not care enough.  Or both.

Note: I want to express very loudly here that I do not count Hannes Sixt 
as Windows folk.  Even if he seems to like cmd.exe for some perverse 
reason, it is undisputable that his effort, and his effort alone, brought 
the MinGW port to where it is now.

To sum it up, I think we can safely remove Perl from the msysGit installer 
once add--interactive is a builtin.  The download will be substantially 
smaller, and Perl on msysGit was never exactly a speed demon, so it's 
probably a good change from several angles.

Ciao,
Dscho
