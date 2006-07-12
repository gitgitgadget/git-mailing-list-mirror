From: Petr Baudis <pasky@suse.cz>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 13:48:05 +0200
Message-ID: <20060712114805.GD13776@pasky.or.cz>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 13:48:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0dCO-00067T-Q5
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 13:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWGLLsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGLLsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 07:48:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25531 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751358AbWGLLsI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 07:48:08 -0400
Received: (qmail 19919 invoked by uid 2001); 12 Jul 2006 13:48:05 +0200
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23778>

Dear diary, on Wed, Jul 12, 2006 at 01:15:03PM CEST, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
> ---

BTW, why people so often want to keep stuff like the following from
commit messages?

> git-commit.sh has only ohne place where perl is used
> and it can actually quite trivially be done in sh.
> git-ls-files without "-z" produces quoted output, even if
> is different from that produced by perl code it could be
> enough. Otherwise I'd better suggest to add another
> quoting style (replacing only \t, \n and backslash)

Of course getting rid of Perl from the "essentials" is an option...

> than having to constantly patch git-commit.sh for binmode
> or perl path (Windows has no stable tool set, and perl
> for instance often resides "somewhere").

...but I would prefer much better if we could actually fix the problem.
I'm not sure what "patching for binmode" takes but it sounds that we
should do it for the other Perl scripts anyway. If Cygwin usually really
doesn't have stable Perl path, you could special-case PERL_PATH in
Makefile for Cygwin to be just "perl" (or perhaps that's the issue only
for non-source packages so you might want to simply set PERL_PATH to
perl when building those).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
