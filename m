From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Tue, 21 Feb 2006 23:19:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602212315400.12634@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060220191011.GA18085@hand.yhbt.net> <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com>
 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:19:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfr0-0005Ma-Nd
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWBUWT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWBUWT1
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:19:27 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51171 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1161095AbWBUWT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:19:26 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED2A1146446; Tue, 21 Feb 2006 23:19:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DE84A2C0C;
	Tue, 21 Feb 2006 23:19:25 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0B7D7146446; Tue, 21 Feb 2006 23:19:25 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060221215742.GA5948@steel.home>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16563>

Hi,

On Tue, 21 Feb 2006, Alex Riesen wrote:

> Sam Vilain, Tue, Feb 21, 2006 21:36:50 +0100:
> > >
> > >>* Eric, thanks for the hint.  I have this four-patch series.
> > >>  Could people with perl 5.6 please check them?
> > >
> > >
> > >Does not work here (ActiveState Build 811, Perl 5.8.6):
> > >
> > >$ perl -e 'open(F, "-|")'
> > >'-' is not recognized as an internal or external command,
> > >operable program or batch file.
> > 
> > Portability, Ease of Coding, Few CPAN Module Dependencies.  Pick any two.
> > 
> 
> Sometimes an upgrade is just out of question. Besides, that'd mean an
> upgrade to another operating system, because very important scripts
> over here a just not portable to anything else but
>     "ActiveState Perl on Windows (TM)"
> I just have no choice.

Maybe I am stating the obvious, but it seems that

	open (F, "git-blabla -option |");

would be more portable.

Alex, would this work on ActiveState?

Perl gurus, is the latter way to open a pipe considered awful or what?

Ciao,
Dscho

P.S.: Eric, we rely on fork() anyway. Most of git's programs just don't 
work without a fork().
