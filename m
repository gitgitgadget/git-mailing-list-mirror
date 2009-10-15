From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD  was
Date: Thu, 15 Oct 2009 05:54:52 -0700 (PDT)
Message-ID: <m3bpk8g6nj.fsf@localhost.localdomain>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
	<76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
	<alpine.LNX.2.00.0910141509200.32515@iabervon.org>
	<alpine.LFD.2.00.0910141616530.20122@xanadu.home>
	<7v7huxbtbk.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0910141647390.20122@xanadu.home>
	<7vws2xa9lu.fsf@alter.siamese.dyndns.org>
	<20091014230934.GC29664@coredump.intra.peff.net>
	<885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 15:03:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyPz2-0001b1-Fc
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 15:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbZJOM4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 08:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbZJOM4m
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 08:56:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40286 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbZJOM4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 08:56:41 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1926065fga.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2009 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=kVfDHUWL2orOxlR1HhW5HmIw4mP7gnON7MtL0XFpHAc=;
        b=bCUqeTtba5yGEoJVpBfUPKX5SFa+6XFzguOiDiboqulKfTvfa3NxuzGcmJZBp3OBCR
         sKT+rtvcUwDiRwiGsJ8FU0/vcyyGukiSw66F865mDOrwqx+Z66UM8IjLevTxq5A/rUlz
         HZLr4HhNgTodAIhcmX6Q6RJ9eVP0t/NCdH9Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Bv+Ice+bqYc8EZwKMo4qbVBW3b5sZ5giZHQrDz6bEcJ1jSjlSg+tj1skkvsouHpiNE
         8bG7ubT9VdeiAH0RyEMM1mBTEt2MEh11S2WOROoczvpfbmHBUVBvaO7eWVH8SndiFd5G
         x0ToBk2/468QnlHNCqoRsqNdZGeAcTayKLchs=
Received: by 10.86.164.6 with SMTP id m6mr139304fge.42.1255611293227;
        Thu, 15 Oct 2009 05:54:53 -0700 (PDT)
Received: from localhost.localdomain (abvx49.neoplus.adsl.tpnet.pl [83.8.221.49])
        by mx.google.com with ESMTPS id 4sm2151855fge.7.2009.10.15.05.54.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 05:54:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9FCs9fP024476;
	Thu, 15 Oct 2009 14:54:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9FCrado024460;
	Thu, 15 Oct 2009 14:53:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130390>

James Pickens <jepicken@gmail.com> writes:

> How about not detaching the head at all if the user checks out any ref, and
> reject commits if he checked out a tag or remote branch.  For example:
> 
> $ git checkout origin/master
> $ git status
> # On branch origin/master
> $ git commit ;# complain
> 
> $ git checkout v1.0.1
> $ git status
> # On tag v1.0.1
> $ git commit ;# complain
> 
> $ git checkout v1.0.1^0 ;# detach
> $ git commit ;# ok
> 
> I think this would help the newbies and wouldn't cost the experts too much.
> Checking out anything other than a plain ref would still detach the head, and
> commits on a detached head would still be allowed.

I think it is a very good idea.

This makes it easy to checkout remote-tracking branch or a tag for
viewing, something that was (I think) one of problems (use cases) that
lead to invention of detached HEAD... and then it turned out that
detached HEAD (unnamed branch) is scary for newbie git users.  (So the
difficulty of having to create new branch or rewind some branch to
view non-committable ref was replaced by scary detached HEAD concept.)

With this idea there are no problems with git commands that use
detached HEAD such as git-bisect (which uses it in viewing mode, but
then skips through history, so detached HEAD is a good solution here)
or git-rebase (which does committing on detached HEAD for easier
aborting and cleanup).


Let me propose additional feature: "smart" (context sensitive)
warnings, namely that in the following sequence

  $ git checkout origin/master
  $ git status
  # On remote-tracking branch origin/master of remote origin
  # ...

  $ git commit

'git commit' would refuse committing on non-heads ref, and propose,
beside _always_ proposing detaching HEAD and committing on such
detached HEAD (unnamed branch) via "git checkout HEAD^0", or
"git checkout --detach [HEAD]":

1. If there is no local branch which follows 'origin/master'
   (which has 'origin/master' as upstream, which tracks 'origin/master')
   propose creating it before comitting:

    $ git checkout -t origin/master

2. If there is single local branch that follows 'origin/master',
   and it fast-forwards to 'origin/master' propose... 
   errr, something that would mean fast-forwarding this branch
   and making a commit on local branch that has 'origin/master'
   as upstream.
   
3. If there is single local branch that follows 'origin/master', but
   it has changes / diverges from 'origin/master' we are viewing,
   propose... hmmm, what then?

4. If there are more than one local branch that has 'origin/master'
   as upstream, list all those branches in message.

> Perhaps as an additional safety feature, Git could refuse to switch
> away from a detached head if the head isn't reachable from any ref,
> and require -f to override:
> 
> $ git checkout $sha1
> $ git commit
> $ git checkout master ;# complain
> $ git checkout -f master ;# ok
> 
> Maybe I'm missing something and this all can't be done, but it seems simpler
> than the other options I've seen in this thread.

I'm not sure about overloading '-f' option, unless we would require
doubled '-f' for overriding both safety checks: checkout from detached
HEAD, and current meaning of forcing a switch even if index or the
working are differs from HEAD.  So you would need

  $ git checkout -f -f master

if you are on detached HEAD and have uncommitted changes (dirty tree 
or dirty index).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
