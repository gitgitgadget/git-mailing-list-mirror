From: Eric Raible <raible@gmail.com>
Subject: Re: git merge remote branch says
Date: Fri, 22 May 2009 18:08:41 +0000 (UTC)
Message-ID: <loom.20090522T175633-762@post.gmane.org>
References: <2729632a0905211250v4e7537caybe9e703c14361b5f@mail.gmail.com> <20090522074927.GB1409@coredump.intra.peff.net> <loom.20090522T172429-73@post.gmane.org> <20090522175401.GB11640@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 20:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7ZAx-0004Ae-Ay
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 20:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbZEVSIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZEVSIv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 14:08:51 -0400
Received: from main.gmane.org ([80.91.229.2]:60782 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbZEVSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 14:08:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M7ZAp-0007n2-PO
	for git@vger.kernel.org; Fri, 22 May 2009 18:08:51 +0000
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 18:08:51 +0000
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 May 2009 18:08:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119747>

Jeff King <peff <at> peff.net> writes:

> On Fri, May 22, 2009 at 05:29:41PM +0000, Eric Raible wrote:
> 
> > Jeff King <peff <at> peff.net> writes:
> > 
> > > I think doing a "git merge origin/master" is perfectly normal for some
> > > workflows. For example:
> > > 
> > >   $ git fetch origin ;# grab it
> > >   $ gitk origin/master...master ;# check if it is good to merge
> > >   $ git merge origin/master ;# and merge it
> > > 
> > > The final step _could_ be a pull, but there is no point in repeating the
> > > fetch (which might be costly).
> > 
> > My understanding is that if the objects already exist
> > locally then this is not going to be costly at all.
> > The negotiation of what is needed is cheap, isn't it?
> 
> No, it is not terribly expensive. But you do have to talk to the server,
> which may mean making an ssh connection, or the server may be overloaded
> and slow. So it can take a few seconds instead of a few microseconds.
> 
> There is actually another reason not to pull, though: you just inspected
> what is in origin/master, so that is what you are expecting to merge.
> If there is new stuff on the remote, you probably don't want to merge it
> without similarly inspecting it.
> 
> -Peff

I wasn't trying to argue that a pull would be a good idea, but more
that it's not that expensive because of the content-addressable
nature of git's object store.

And saying that is "might be costly" could be misleading to people
who haven't groked how a commit is a commit is a commit.

- Eric
