From: Junio C Hamano <junkio@cox.net>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 14:00:55 -0700
Message-ID: <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510031522590.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 23:02:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMXQw-0005bx-I6
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 23:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbVJCVBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 17:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVJCVBF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 17:01:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25022 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932385AbVJCVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 17:01:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051003210051.MPYM19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Oct 2005 17:00:51 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510031522590.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 3 Oct 2005 15:43:02 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9652>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Are these all before 1.0, or are some of them supposed to happen 
> eventually but later?

The latter.

>> * Libification.  There are many places "run once" mentality is
>>   ingrained in the management of basic data structures, which
>>   need to be fixed.
>
> I think this should be a post-1.0 thing; I think after 1.0, we should 
> rearrange a lot of the code to make more sense from a programmer 
> perspective.

I agree.

>> * Look at libified GNU diff CVS seems to use, or libxdiff.
>
> I've almost got a suffix-tree-based diff that works reasonably well, 
> that's built as a library, and outputs unified diff. I need to merge it 
> with git, hook up input from trees and blobs, and test it on a wider set 
> of data.

Sounds like fun.

> I'd also like to add:
>
>  * Accept patches to fetch multiple objects by HTTP in parallel.
>
> I think this may be necessary to get good performance without rsync for 
> repositories hosted without specific git support.

Surely.  I'd love to see you work with Nick Hengeveld on this
one, perhaps even before 1.0.  Looking out the fetch.c code, I
think you already have set up a reasonable "work queue" during
the last round, with a lot of simplification thanks to Sergey,
and parallel fetching would be a very nice addition.
