From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: auto gc again
Date: Tue, 18 Mar 2008 19:19:48 +0100
Message-ID: <20080318181948.GH17940@kernel.dk>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:45:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4Ca-0002JK-HX
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbYCSTmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757899AbYCSTmE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:42:04 -0400
Received: from brick.kernel.dk ([87.55.233.238]:26255 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869AbYCSTl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:41:58 -0400
Received: by kernel.dk (Postfix, from userid 51)
	id 3C43D2587FE; Wed, 19 Mar 2008 20:41:14 +0100 (CET)
Received: by kernel.dk (Postfix, from userid 500)
	id E85CE25877F; Tue, 18 Mar 2008 19:19:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77522>

On Tue, Mar 18 2008, Linus Torvalds wrote:
> 
> 
> On Tue, 18 Mar 2008, Jens Axboe wrote:
> > 
> > Could we please PLEASE kill this auto gc thing? I've complained about
> > this in the past and disabled it through the gc.auto config entry,
> > however now git seems to be happily auto running gc even with gc.auto=0.
> > So there's probably some new magic I need to know.
> 
> Do you do something odd with your repositories? I don't even touch autogc 
> on my systems, but I have never had that thing trigger, even when I apply 
> series of patches from Andrew with hundreds of messages.

Not to my knowledge, I haven't changed anything in my setup or behaviour
in ages.

> So what is it that you do to even get this behaviour in the first place?

The last few times it was:

$ git checkout master
$ git branch some-test-branch
$ git checkout some-test-branch
$ git pull . some-devel-branch

and after that pull, I get to sit around waiting git gc. Well I don't
since I ctrl-c it because it's inconvenient.

But freshly pulled repo, git auto gc is enabled. And that is my main
annoyance, I just don't think that type of policy should be in there.
Print the warning, include info on how to run git gc or even how to turn
it on automatically. But I'll bet you that most users will NOT want auto
gc. Ever.

-- 
Jens Axboe
