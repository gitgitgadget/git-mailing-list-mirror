From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: New way of tracking remote branches -- question
Date: Fri, 5 Jan 2007 16:39:21 -0800 (PST)
Message-ID: <386533.4292.qm@web31809.mail.mud.yahoo.com>
References: <7vmz4xcacr.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zao-0000Ba-5H
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXAFAjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbXAFAjW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:39:22 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:30030 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751025AbXAFAjW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 19:39:22 -0500
Received: (qmail 4515 invoked by uid 60001); 6 Jan 2007 00:39:21 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=atNPalXswb7SaHkT/P8lJQh3an/449PDlbaSGQenEWU2KcxYA6Kh3sJrhM0Gp1npZbPa5wYymcGMfKotu25uUq+GiM6tCTbS3x6pNRIdj3SuOL81LYiUKJxH4uI1UQ0qOjqL48214Z+BwrIyV8yANBZ1BJMEH5bzDXh6t3Vsp84=;
X-YMail-OSG: 65SV4_wVM1ns.Rq6eBT0M0eJryL4Bj1ttRt39VfVklyN0jC_4nb9BI9v1oAwVM3aPM1PKkYfNjtW6U1qHgVOL43b07I6E6tM3EckBwUXMEDt5NsryJbrMhWjyZ36KxVgp04tSklOXu7l7BUlEWTJmkUDW4PhsswT2ipUTl1I8aeFwJvGKMQN5s8O
Received: from [64.215.88.90] by web31809.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 16:39:21 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4xcacr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36061>

--- Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> I can see that the remote heads are where they are supposed to be
> >> but no local tracking heads are created (by default).  I had
> >> to do this manually.
> >>
> >> Old behavior was that git did that for you automatically.
> >> So I suppose this is another newbie protection.
> >
> > A very fuzzily stated question which is hard to answer, but I do
> > not think it is another newbie protection, if it apparently is
> > actively hurting you.  Also the documentation may need to be
> > updated to teach you enough about how to achieve what you want.
> 
> Can you state the problem you observed about the recent git in a
> way that is easier to debug?
> 
> For example, you could state:
> 
> 	With older git (I verified that v1.3.0 still works like
> 	this), I used to be able to just say:
> 
> 		$ git fetch
> 
> 	(this is the exact command line -- I am not giving a URL
> 	nor even "origin" after "git fetch").  When the upstream
> 	created a new branch 'blah', the above command created a
> 	new local branch 'blah' automatically for me.  With the
> 	tip of 'master' (e27e609), this does not happen anymore.
> 
> 	My configuration is that I have .git/remotes/origin file
> 	whose contents is ....  I do not have any remote.*.url,
> 	remote.*.fetch, nor branch.*.remote configuration variables.
> 
> to be more helpful.
> 
> I am not dismissing your message as whining.  You probably have
> hit a regression while we adopted the BCP to encourage separate
> remote layout, and I would like to understand the issue.

And I'm not whining.  It just that when I've done something 1000
times and all of a sudden I do the same thing and didn't see the
expected behaviour, I posted.

"git-pull" didn't "create" the branches in the place I was
expecting.  I.e. while they are in .git/refs/remotes/origin/
they are not in .git/refs/heads.

Then I manually created the heads in .git/refs/heads
and manually added that to .git/config, i.e. the [branch]
part.

I was hoping I wouldn't need to do that at all, as old
git-pull exposed remote branches, or I was expecting to
at least find a git command to do this 2nd additional
manual step for me.

    Luben
