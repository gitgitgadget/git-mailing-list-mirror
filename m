From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] git-rev-list(1): group options; reformat; document more options
Date: Fri, 1 Sep 2006 22:33:48 +0200
Message-ID: <20060901203348.GA27515@diku.dk>
References: <20060831223715.GC482@diku.dk> <Pine.LNX.4.64.0608311557470.27779@g5.osdl.org> <20060831230811.GE482@diku.dk> <Pine.LNX.4.64.0608311611440.27779@g5.osdl.org> <7vsljc78m9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Timo Hirvonen <tihirvon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 01 22:34:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJFiH-0005D7-6G
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 22:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWIAUeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 16:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWIAUd7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 16:33:59 -0400
Received: from [130.225.96.91] ([130.225.96.91]:48870 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750849AbWIAUd6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 16:33:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E29A4770075;
	Fri,  1 Sep 2006 22:33:50 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08916-07; Fri,  1 Sep 2006 22:33:49 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1FA4477006C;
	Fri,  1 Sep 2006 22:33:49 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 330D66DF88D; Fri,  1 Sep 2006 22:32:21 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 036C262A06; Fri,  1 Sep 2006 22:33:48 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsljc78m9.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26311>

Junio C Hamano <junkio@cox.net> wrote Thu, Aug 31, 2006:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Fri, 1 Sep 2006, Jonas Fonseca wrote:
> >
> >> [The "-r" and "-t" option] do not seem to make sense for
> >> git-rev-list, however if you pass either to git-log, the output
> >> seems to make room for a diff, adding one extra newline, but
> >> without appending any diff.
> >
> > Ahh. I think that a "-r" without any other request for patches (or
> > "--name-status" or similar) should probably imply "--raw". At least
> > that was how it historically worked..

:set paste

commit 17985627455901b6ae3a471b67d46239463cebb5
Author: Timo Hirvonen <tihirvon@gmail.com>
Date:   Tue Jun 27 16:27:51 2006 +0300

    log --raw: Don't descend into subdirectories by default

    Only do so when -r is given.

> > Anyway, _if_ it ever worked (and I think it did, but I'm way too lazy to 
> > bother checking), this may have been broken by the extensive diff option 
> > cleanups by Timo in June. Timo? Junio?
> 
> I think it did too.  I am kind of surprised that nobody noticed
> and t4013 test (which was done specifically to catch potential
> behaviour change by Timo's patch) did not check for this
> particular case.

commit 0e677e1a6b0d1c0e848ed19d18dda1c3c797c75e
Author: Timo Hirvonen <tihirvon@gmail.com>
Date:   Sat Jun 24 20:25:08 2006 +0300

    DIFF_FORMAT_RAW is not default anymore

    diff_setup() used to initialize output_format to DIFF_FORMAT_RAW.  Now
    the default is 0 (no output) so don't compare against DIFF_FORMAT_RAW to
    see if any diff format command line flags were given.

:set nopaste

So they are working as intended. I'll look into updating the patch.

BTW, --author=timo made this very easy. ;)

-- 
Jonas Fonseca

-- 
VGER BF report: U 0.5
