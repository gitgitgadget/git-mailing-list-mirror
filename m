From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 13:53:27 +0100
Message-ID: <20070316125327.GC4489@pasky.or.cz>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSBw8-00058n-Sf
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 13:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608AbXCPMxb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 08:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933612AbXCPMxb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 08:53:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33453 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933608AbXCPMxa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 08:53:30 -0400
Received: (qmail 23276 invoked by uid 2001); 16 Mar 2007 13:53:27 +0100
Content-Disposition: inline
In-Reply-To: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42357>

On Fri, Mar 16, 2007 at 06:30:46AM CET, Junio C Hamano wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > But other areas die when they get given a bad SHA-1 (for example).
> > If the library caller can supply that (possibly bad) SHA-1 to an
> > API function, that's just mean to die out.  ;-)
> 
> That's a real problem, but on the other hand, perl or whatever
> wrapped ones can do the dying (or not dying) before calling into
> libgit, so it may not be such a big issue.

At least you can catch the die from the library caller using
set_*_routine(). ;-)

> >>     o Documentation (eg, doxygen)
> >>     o Unit-tests
> >>     o Add prefix (eg, git_*) to public API functions
> >
> > Yes.  But which functions shall we expose?  ;-)
> 
> Before going into that topic, a bigger question is if we are
> happy with the current internal API and what the goal of
> libification is.  If the libification is going to say that "this
> is a published API so we are not going to change it", I would
> imagine that it would be very hard to accept in the mainline.
> Improvements like the earlier sliding mmap() series need to be
> able to change the interfaces without backward compatibility
> wart.
> 
> In other words, I do not know what idiot ^W ^W who listed the
> libification stuff on the SoC "ideas" page, but I think (1) it
> is premature to promise stable ABI, and (2) if it does not
> promise stable ABI a library is not very useful.

I disagree, it can live in the "zero major version" realm and already be
very useful for language bindings (say whatever is bundled with git
itself) and other nifty stuff.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
