From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 17:29:56 -0700 (PDT)
Message-ID: <20061017002956.79736.qmail@web31807.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcqI-0002dY-31
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJQA37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422974AbWJQA37
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:29:59 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:4245 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422986AbWJQA36 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 20:29:58 -0400
Received: (qmail 79738 invoked by uid 60001); 17 Oct 2006 00:29:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XqLjp52OvoXdh9juYXJ58Zn+XKiSKzaKK3yn6Odjjnz2yhO5TUlOlo3JbvQ7yiX8JLixTJyiEX0KsqKrUoASqarmwiZSPRibZc1RLJeCsqP4FOyDUEj/lVY/R+AtB/5LLllrUdEma2AElw1TmghWZVG4kY4gKiUSF9bNwlFN4Jg=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Mon, 16 Oct 2006 17:29:56 PDT
To: Linus Torvalds <torvalds@osdl.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29005>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> Well, in the git world, it's really just one shared repository that has 
> separate branch-namespaces, and separate working trees (aka "checkouts"). 
> So yes, it probably matches what bazaar would call a checkout.
> 
> Almost nobody seems to actually use it that way in git - it's mostly more 
> efficient to just have five different branches in the same working tree, 
> and switch between them. When you switch between branches in git, git only 
> rewrites the part of your working tree that actually changed, so switching 
> is extremely efficient even with a large repo. 
> 
> So there is seldom any real need or reason to actually have multiple 
> checkouts. But it certainly _works_.

It does work, very well at that.

I have a directory for each separate branch and simply use
cd(1) to change the current working directory to that branch.
So, instead of "git checkout <branch>", I do "cd ../<branch>".

One only needs to watch out when one updates the repository.
If there had been updates in those branches, then one needs
to git-reset the "branch" directory... (you know what I mean)
(For example when I come to work in the morning an sync up
 with home from my usb key...)

The script is called:
Usage: git-mkdir-of-branch <original-directory> <branch> <new-directory>
  where <branch> is the name of an existing branch in <original-directory>/.git/refs/heads

and uses simple symbolic links and some git plumbing to do the
job.  It can be found in my git trees.  I never bothered to send
it out to Junio, since it could be considered heretic. ;-)

     Luben
