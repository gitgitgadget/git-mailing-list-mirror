From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix generation of perl/perl.mak
Date: Thu, 25 Oct 2007 23:21:29 +0200
Message-ID: <20071025212129.GB11308@steel.home>
References: <20071025201724.GA11308@steel.home> <Pine.LNX.4.64.0710252140500.4362@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 23:21:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlA9A-0001AE-QR
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 23:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbXJYVVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752351AbXJYVVc
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 17:21:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:38477 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbXJYVVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 17:21:31 -0400
Received: from tigra.home (Fadec.f.strato-dslnet.de [195.4.173.236])
	by post.webmailer.de (klopstock mo49) (RZmta 14.0)
	with ESMTP id Y039a5j9PID9fl ; Thu, 25 Oct 2007 23:21:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C5542277AE;
	Thu, 25 Oct 2007 23:21:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 4509356D22; Thu, 25 Oct 2007 23:21:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710252140500.4362@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ2mEU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62375>

Johannes Schindelin, Thu, Oct 25, 2007 22:42:07 +0200:
> On Thu, 25 Oct 2007, Alex Riesen wrote:
> 
> > Besides, a changed Git.pm is *NOT* a reason to rebuild all the perl 
> > scripts, so remove the dependency too.
> >
> > [...]
> > 
> > -perl/Makefile: perl/Git.pm perl/Makefile.PL GIT-CFLAGS
> > -	(cd perl && $(PERL_PATH) Makefile.PL \
> > -		PREFIX='$(prefix_SQ)')
> > -
> 
> This is not really the dependency triggering a rebuild of all perl 
> scripts, right?

In a way. This rebuilds perl/perl.mak which, in turn, can cause the
rebuild of all perl scripts. The rule you replaced with "[...]" does
the same, but uses perl/Makefile, which generates the perl.mak
 depending on the NO_PERL_MAKEMAKER setting.
