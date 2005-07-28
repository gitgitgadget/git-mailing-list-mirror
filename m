From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Thu, 28 Jul 2005 17:57:07 +0200
Message-ID: <20050728155707.GB17952@pasky.ji.cz>
References: <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <tnxmzobutsf.fsf@arm.com> <7vk6jelkty.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507251306420.6074@g5.osdl.org> <7vll3uk4w7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org, Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:01:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAoW-00043U-5X
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVG1QAW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVG1P6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 11:58:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22031 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261572AbVG1P5K (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 11:57:10 -0400
Received: (qmail 19712 invoked by uid 2001); 28 Jul 2005 15:57:07 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll3uk4w7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jul 25, 2005 at 10:27:36PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Mon, 25 Jul 2005, Junio C Hamano wrote:
> >> 
> >> I personally do not have preference either way, but am slightly
> >> biased towards the "cumulative" behaviour the patch attempts to
> >> implement, which was what Pasky said he wanted to have.
> >
> > I think that makes sense.
> >
> > Imagine, for example, that you have separate subdirectory structures for 
> > Documentation and for source - maybe you'd put the "*.o" rule in the 
> > source directory, and a "*.1" rule in the Docs subdirectory.
> 
> I imagined it, but it appears to me that this is a bad example.
> My understanding of what Catalin and the proposed patch
> disagrees is whether the patterns in .gitignore at the top level
> should govern files under ppc/ and mozilla-sha1/ subdirectories;
> Catalin thinks they should not.

They should. If you don't want them take effect in most of the
directories, you would add them as ./pattern in the parent directory,
while if you want them to take effect in most of the directories, you
would exclude them in the ones you don't want the pattern to take effect
in (if you accept my proposal for ! semantics change).

> What I meant by "cumulative" (now I realize I might have
> misunderstood what Pasky wanted to mean by that word, though)
> was not just .gitignore in subdirectory being added, but the
> effect of patterns being added so far, either from the command
> line or by parent directories, last while in the deeper
> directories.

Yes, that's what I meant.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
