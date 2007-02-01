From: Bill Lear <rael@zopyra.com>
Subject: Re: Fetching from peer's public repo
Date: Thu, 1 Feb 2007 10:10:36 -0600
Message-ID: <17858.4348.498027.613657@lisa.zopyra.com>
References: <17858.1586.41833.597819@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 17:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCeWL-000532-7r
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 17:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXBAQKm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 11:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbXBAQKm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 11:10:42 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61876 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbXBAQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 11:10:41 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l11GAen31155;
	Thu, 1 Feb 2007 10:10:40 -0600
In-Reply-To: <17858.1586.41833.597819@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38367>

On Thursday, February 1, 2007 at 09:24:34 (-0600) Bill Lear writes:
>My fetch from a peer's public repo seems to be failing:
>
>% git --bare fetch git://source/public/project topic:topic
>remote: Generating pack...
>remote: Done counting 48 objects.
>remote: Result has 34 objects.
>remote: Deltifying 34 objects.
>remote:  100% (34/34) done
>remote: Total 34, written 34 (delta 22), reused 24 (delta 12)
>Unpacking 34 objects
> 100% (34/34) done
>* refs/heads/topic: not updating to non-fast forward branch 'topic' of git://source/public/project
>  old...new: 1c332f5...f3b18ff
>
>I assume that is because his public repo does not contain changes I
>have pushed into my public repo.  So, I asked him to pull from
>my public repo into his.  He did, and said that git blathered that
>there were 12 changed files, etc.

Ok, I think I have discovered the cause...  Sorry for wasting time.
My pal did a git pull from my public repo's topic branch into his
master branch by mistake.  My fetch of his topic branch of course
failed, as he did not update it.

You know, some training wheels for git might be nice...

Such as a git config variable:

[newbies]
	please.god.save.me.if.I.try.to.merge = true

Which would cause git-pull, git-fetch, git-merge (whatever) to prompt
you:

  Hey Nimrod, you're about to MERGE something from one branch to
  another --- are you sure you really want to do this? (y/n)

I myself have shot several repos in the head by doing this by mistake.
Once this is done, and you pull it into your private repos, the infection
spreads, and you have to go back to each and repair them...

We'll get this right soon...


Bill
