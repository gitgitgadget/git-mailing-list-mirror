From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 29 Jul 2005 19:11:36 -0700
Message-ID: <7vslxx6o13.fsf@assigned-by-dhcp.cox.net>
References: <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<1122068634.7042.35.camel@localhost.localdomain>
	<7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	<1122108098.6863.38.camel@localhost.localdomain>
	<20050723093035.GB11814@pasky.ji.cz>
	<1122114452.6863.72.camel@localhost.localdomain>
	<20050728194748.GD24948@pasky.ji.cz> <tnxfytyey1j.fsf@arm.com>
	<20050729111056.GR24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Bryan larsen <bryanlarsen@yahoo.com>,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 04:19:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dygw5-0001zz-VI
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVG3CSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVG3CN1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11688 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262767AbVG3CLi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021126.MGMH8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:26 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Jul 29, 2005 at 11:55:52AM CEST, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> told me that...
>> Petr Baudis <pasky@suse.cz> wrote:
>> > The committer field generally identifies the committer "physically", and
>> > isn't usually overriden. You'll find <xpasky@machine.sinus.cz> in my
>> > committer field, e.g.
>> 
>> I thought GIT_COMMITTER_{NAME,EMAIL} were added to be able to override
>> the defaults like username@localmachine.
>
> Yes, but IIRC only for rather special cases like recommitting older
> commits, importing from other VCSes, etc.

My recollection coincides with Catalin.  Special case is when
you set it to somebody else, "logically" different from you, as
you say.  Fixing GECOS fields and mailhost settings as Catalin
says is another.

Setting it to something "physically" different but still the
same you, for example using your work e-mail address when you
are on your home machine, is not special case at all, but is
also a valid use.  However when you start to do that, it may
become unusable as a valid e-mail address you can use for From:
and/or Sender: fields.

>> The latest StGIT snapshot uses, by default, the committer's details
>> for the From: line when sending patches by e-mail, assuming that this
>> is a valid e-mail address. One can define his own e-mail template and
>> use a different From: line but I thought it would be simpler to
>> provide some defaults based on this.
>
> Why don't you rather use the GIT_AUTHOR_* variables?

I tend to agree.  When forwarding somebody else's commit as a
patch, you would want to name that author on From: line and make
yourself Sender:.  Of course, in that case Sender: should be a
valid e-mail address for the originating machine; otherwise
bogus-mail-relay prevention would block your e-mail.  In that
sense, using COMMITTER to identify you "physically" (meaning:
tied to your identity with that particular machine) would work
better.
