From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin,
 submodules
Date: Mon, 4 Feb 2008 21:49:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042149030.8543@racer.site>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site> <47A68C01.9000600@gmail.com> <alpine.LSU.1.00.0802041443420.7372@racer.site> <30e4a070802040924g550671ccsb11108c71c99e378@mail.gmail.com>
 <7vbq6wjxx1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802042027470.8543@racer.site> <7v1w7sjt7n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:50:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9DA-0000b1-Jy
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbYBDVuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbYBDVuL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:50:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:43759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753643AbYBDVuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:50:09 -0500
Received: (qmail invoked by alias); 04 Feb 2008 21:50:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 04 Feb 2008 22:50:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RZxtVr3URB7aN7lH9LqwqlR7UYJBJcc3+OhGnpd
	eyF2ZRn1eLktF4
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1w7sjt7n.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72576>

Hi,

On Mon, 4 Feb 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > AFAICT "clone -o" was meant _only_ for this scenario:
> >
> > You have a slow connection, but someone can provide you with a thumb 
> > drive, having the current repository.
> >
> > You clone it from the thumb drive, but of course you want to use your 
> > (slow) connection for subsequent updates (i.e. you want to have a 
> > different default remote).
> >
> > What you do is
> >
> > 	$ git clone -o thumbdrive /media/usbdisk/that-repository.git/
> >
> > Then, to be able to update from your preferred remote quickly, you add 
> > the proper remote:
> >
> > 	$ git remote add --fetch origin git://git.kernel.org/shlub.git/
> >
> > In my understanding, this scenario is the only reason to live for 
> > clone's -o option, and it would be actively wrong for it to change the 
> > _name_ of the default remote to "thumbdrive".
> 
> Then we should fix "git-clone".
> 
> If you do the first command, I am reasonably sure that you would get:
> 
> 	[branch "master"]
>         	remote = thumbdrive
> 
> in your .git/config.  You may want to occasionally go back to thumbdrive 
> for sneakernetting, so I do not think we should remove [remote 
> "thumbdrive"] section the clone would leave, but the above "master 
> branch would interact with thumbdrive repository" should not be there.
> 
> And that corrected behaviour and the intended use of -o should be 
> documented.

Fully agree.  It is now point 38 on my ever-growing TODO list.

Ciao,
Dscho
