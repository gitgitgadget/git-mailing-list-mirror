From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Fri, 5 Jan 2007 16:32:30 -0800 (PST)
Message-ID: <234200.4582.qm@web31806.mail.mud.yahoo.com>
References: <7vr6u9cann.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2zUG-0006ts-N5
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbXAFAcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbXAFAcc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:32:32 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:32069 "HELO
	web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750970AbXAFAcb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 19:32:31 -0500
Received: (qmail 5110 invoked by uid 60001); 6 Jan 2007 00:32:30 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LqarncleFkiEkMmpqH51AnV8WXfrkHoikrMZhtnIG62x9foSfZNTksj41wSakomBfTihnI198TAdQZw4yXkfiCiTsSYcwmZm3vVP6rB3Mtq6QOi2J3oH+lCfERqGeQUuWQurUPuR8pOons9tWZFT3uL6KKhllt0RlWDUAXOn3o4=;
X-YMail-OSG: uCwNmC4VM1kuOA.QkZgX0v86JHCJu1VnR4ji7dJzdO4aMVIdZhl8MflxnSqNEkdiwYE4HtTrBVSr5a6rWe7uMzm0ITpkXUnlxmw7rhOBT2hLmAgfawTYgoWs1eZS0ORmRkNR619PebIR7BCu5QQSR7GpXWlEN97J7J8f3gbUGYEveyjP8AyFZ6Rn
Received: from [64.215.88.90] by web31806.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 16:32:30 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6u9cann.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36060>

--- Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> --- Junio C Hamano <junkio@cox.net> wrote:
> >>> 
> >>> Because [remote] is NOT about mapping.  It asks the fetch
> >>> mechanism to fetch from that remote, so the primary thing you
> >>> should look at is .url, not RHS of colon on .fetch lines.  Use
> >>> of tracking branches is strictly optional.
> >>
> >> [remote "origin"]
> >>         url = http://blah/bleah.git
> >>         fetch = +refs/heads/*:refs/remotes/origin/*
> >>
> >> This basically says: "Get it" from such and such url, where
> >> on the repo at that url, i.e. the remote side, you will
> >> find stuff in "refs/heads/", and when you get it here, locally,
> >> put it in refs/remotes/origin/.
> >
> >         [remote "origin"]
> >                 url = http://blah/blah.git
> >                 fetch = refs/heads/master
> >
> > is also fine.  The point is that you do not have to use tracking
> > branches.  ", and when you get it here, ..." part is optional.
> 
> In other words, remote.*.fetch could be spelled as mapping to
> cause them locally stored in tracking branches, but the storing
> in tracking branches is merely a side effect of a fetch, not the
> primary one.  The primary effect is to fetch the necessary
> objects and leave what was fetched in .git/FETCH_HEAD to
> communicate with later 'git pull'.  The side effect is optional,
> so is spelling remote.*.fetch as a mapping.

Oh ok -- I forgot about .git/FETCH_HEAD.

> >> Yeah, but by default "refs/heads/branchA" doesn't exist (see
> >> my previous email).  It doesn't have to, since it specifies
> >> the "remote part", but that has already been handled by
> >> "[remote]".
> >
> > Obviously fetch needs to handle the remote part because that is
> > the only name it exists at the remote.  branch.*.merge is used
> > by pull, not fetch, and fetch communicates with pull by using
> > the remote name, because use of local tracking branches is
> > optional.
> 
> In other words, the remote name is the only thing that can be
> used between fetch and pull to communicate.  Fetch tells pull "I
> fetched these from the remote", and pull uses that information
> to make a merge, and the merge comment says "this merges the
> branch xyz from that repository", using the 'xyz' name used at
> the remote side, not your local tracking branch, which you may
> or may not be using.

Ok.

    Luben
