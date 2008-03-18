From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Tue, 18 Mar 2008 19:24:21 +0100
Message-ID: <20080318182421.GI17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4CZ-0002JK-Rk
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927AbYCSTmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757905AbYCSTmI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:42:08 -0400
Received: from brick.kernel.dk ([87.55.233.238]:26261 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755319AbYCSTmC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:42:02 -0400
Received: by kernel.dk (Postfix, from userid 51)
	id 55A86258778; Wed, 19 Mar 2008 20:41:05 +0100 (CET)
Received: by kernel.dk (Postfix, from userid 500)
	id A53C7258780; Tue, 18 Mar 2008 19:24:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080318181948.GH17940@kernel.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77519>

On Tue, Mar 18 2008, Jens Axboe wrote:
> On Tue, Mar 18 2008, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 18 Mar 2008, Jens Axboe wrote:
> > > 
> > > Could we please PLEASE kill this auto gc thing? I've complained about
> > > this in the past and disabled it through the gc.auto config entry,
> > > however now git seems to be happily auto running gc even with gc.auto=0.
> > > So there's probably some new magic I need to know.
> > 
> > Do you do something odd with your repositories? I don't even touch autogc 
> > on my systems, but I have never had that thing trigger, even when I apply 
> > series of patches from Andrew with hundreds of messages.
> 
> Not to my knowledge, I haven't changed anything in my setup or behaviour
> in ages.
> 
> > So what is it that you do to even get this behaviour in the first place?
> 
> The last few times it was:
> 
> $ git checkout master
> $ git branch some-test-branch
> $ git checkout some-test-branch
> $ git pull . some-devel-branch

axboe@carl:~/git/linux-2.6-block> git count-objects
901 objects, 6448 kilobytes

xboe@carl:~/git/linux-2.6-block> git pull
remote: Counting objects: 320, done.
remote: Compressing objects: 100% (43/43), done.
remote: Total 214 (delta 171), reused 214 (delta 171)
Receiving objects: 100% (214/214), 31.78 KiB, done.
Resolving deltas: 100% (171/171), completed with 68 local objects.
From ssh://git.kernel.dk/data/git/linux-2.6-block
   bde4f8f..f920bb6  master     -> origin/master
Updating bde4f8f..f920bb6
Fast forward
Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
^C

So 901 objects, pulled 68 objects. And auto gc kicks in. WTF? The git
before was from probably a week ago, this above run was done with git
just updated.

git version 1.5.5.rc0.6.gdeda

-- 
Jens Axboe
