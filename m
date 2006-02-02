From: Junio C Hamano <junkio@cox.net>
Subject: Re: The merge from hell...
Date: Thu, 02 Feb 2006 02:41:28 -0800
Message-ID: <7v7j8erqjr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<e5bfff550602012325s7d0a799ct5bfabbce2c579449@mail.gmail.com>
	<Pine.LNX.4.64.0602012356131.21884@g5.osdl.org>
	<cc723f590602020007s43f89d10i4529d118ade7c764@mail.gmail.com>
	<Pine.LNX.4.64.0602020027400.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:42:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4buH-0002y3-8o
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 11:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423097AbWBBKlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 05:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423440AbWBBKlb
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 05:41:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:21640 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1423097AbWBBKla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 05:41:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202104015.GJNT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 05:40:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602020027400.21884@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 00:44:35 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15501>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 2 Feb 2006, Aneesh Kumar wrote:
>> 
>> Ok i tried using --cc. But then as per the man page if the
>> optimization makes the all the hunks disapper then commit log is not
>> show unless -m is used.
>
> Ahh. You're mis-using git-diff-tree.
>
> git-diff-tree will _never_ show the commit log if the diff ends up being 
> empty.

True, I should fix the documentation.

It _might_ make sense for certain users like gitk and gitview if
we had a single tool that gives --pretty and its diff even if
the diff is empty.  Having said that, the flag --cc -m is too
specific.  If some uses want to see the commit log even for an
empty diff, that flag should not be something only --cc honors.
