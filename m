From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Thu, 16 Feb 2006 02:24:28 -0800
Message-ID: <7vbqx7bnz7.fsf@assigned-by-dhcp.cox.net>
References: <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com>
	<20060214100844.GA1234@diana.vm.bytemark.co.uk>
	<43F1F5CB.10402@citi.umich.edu>
	<20060214160747.GA6350@diana.vm.bytemark.co.uk>
	<43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz>
	<43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org>
	<20060215041142.GA21048@fieldses.org>
	<20060215065411.GB26632@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 11:27:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9gJc-0003CR-0I
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 11:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWBPKYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 05:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWBPKYb
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 05:24:31 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36230 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751222AbWBPKYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 05:24:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060216102159.ERFK17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Feb 2006 05:21:59 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060215065411.GB26632@spearce.org> (Shawn Pearce's message of
	"Wed, 15 Feb 2006 01:54:11 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16290>

Shawn Pearce <spearce@spearce.org> writes:

> I think I'm almost there with pg.  One of my next tasks is the
> patch log ripping code.  This is really only complicated because GIT
> won't let me store the base of a 3 way merge as part of a commit;
> all I can store is the set of parents.  If I had the base in the
> commit (and specifically marked as such so I can tell it from the
> end points) then I could easily walk through the log to extract all
> commits relevant to a patch and seek forward and backward over it.

I think I know what you are talking about.  Maybe you might be
interested to take a look at TO script in my todo branch [*1*]?

Also there is a sample hook script templates/hooks--pre-rebase 
that uses the same idea used in the said script.  These are what
I use to manage the "next" branch (an aggregation of topic
branches being cooked).

By the way, please do *not* do this:

    Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
            Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,...
	    ...

I wanted to reply to *you*, but by having the header you robbed
about 30 seconds from me, forcing me to edit the "To:"
addressee.


[Footnote]

*1* todo branch does not have *any* ancestry relationship with
my primary branches, so please do not try to merge it in your
primary repository (unless you know what you are doing).  Make a
clone into a separate directory and running "git checkout todo"
there is the cleanest way to peek into it.
