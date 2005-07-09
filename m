From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 8 Jul 2005 18:16:28 -0700
Message-ID: <20050709011628.GA11253@buici.com>
References: <20050708230750.GA23847@buici.com> <7v4qb46dff.fsf@assigned-by-dhcp.cox.net> <20050709003636.GA26526@buici.com> <7v1x684wgr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:21:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr41F-0007SP-IX
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVGIBT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbVGIBS3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:18:29 -0400
Received: from florence.buici.com ([206.124.142.26]:29418 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263068AbVGIBQ3
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:16:29 -0400
Received: (qmail 11348 invoked by uid 1000); 9 Jul 2005 01:16:28 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x684wgr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 06:08:52PM -0700, Junio C Hamano wrote:
> >>>>> "MS" == Marc Singer <elf@buici.com> writes:
> 
> MS> Does this preclude symlinking .git?  I'd like to keep one .git which
> MS> is mirrored from the net and allow for more than one working
> MS> directory.
> 
> I think people typically do this by symlinking .git/objects, not
> .git/ itself.
> 
> Presumably the reason you would want to have more than one
> working tree is so that you can keep more than one topic of
> development, one for each working tree, and make commits
> independently, right?  Which commit is the latest in each work
> tree is, unsurprisingly, stored in .git/refs/heads/master file
> in each work tree, so usually you would _not_ want to share
> things other than .git/objects/ under .git/ directory across
> work trees.
> 
> One major downside of this, which I was burned once myself
> (which is the reason for me to stop doing it), is that
> git-fsck-cache and git-prune-script would not know anything
> about the objects in the shared .git/objects reachable from
> other work trees, and can happily garbage collect objects
> necessary for other work trees.

Hmm.  Seems, then, that this precludes any sharing at all.  It isn't
so serious with git as it was wth BK.  The latter being disk hungry.

I gather that the approved solution is to have complete replicas of
the git master from Linus for each line of development.
