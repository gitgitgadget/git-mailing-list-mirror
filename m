From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug in git-fsck-cache?
Date: Wed, 31 Aug 2005 19:21:02 -0700
Message-ID: <7vacix5y0h.fsf@assigned-by-dhcp.cox.net>
References: <20050831161529.327a7957.git@ozlabs.org>
	<7v4q959857.fsf@assigned-by-dhcp.cox.net>
	<20050901120226.54547107.git@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 04:22:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAehU-0004YA-E1
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 04:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVIACVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 22:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbVIACVI
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 22:21:08 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:26043 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965021AbVIACVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 22:21:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901022102.KQIO8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 22:21:02 -0400
To: Stephen Rothwell <git@ozlabs.org>
In-Reply-To: <20050901120226.54547107.git@ozlabs.org> (Stephen Rothwell's
	message of "Thu, 1 Sep 2005 12:02:26 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7988>

Stephen Rothwell <git@ozlabs.org> writes:

>> Stephen Rothwell <git@ozlabs.org> writes:
>> 
>> > The commit c594adad5653491813959277fb87a2fef54c4e05 is shown as
>> > "connected" (in Linus' tree, not one of my patches) by gitk, so I am happy
>> > that git prune did not get rid of it, but why does fsck-cache report it as
>> > dangling?
>> 
>> Hmph.  You ran fsck-cache by hand without --full (i.e. you told
>> it not to worry about objects already in packs); 'git prune'
>> runs it with '--full' to do the full connectivity analysis.  I
>> think that's where the difference comes from.
>
> ok, with '--full' nothing gets reported as dangling.  That commit is not
> in a pack, but is in an object directory referenced through
> objects/info/alternates.

Ahh.  Yes, it is the same thing.  I said "not in the pack", but I
should have said "exists locally unpacked".
