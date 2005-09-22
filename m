From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Thu, 22 Sep 2005 13:46:55 +1200
Message-ID: <46a038f905092118464b98e149@mail.gmail.com>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org>
	 <7vu0genlc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
	 <20050921.172849.103555057.davem@davemloft.net>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: torvalds@osdl.org, junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 03:48:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIGB0-0003Vf-NV
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 03:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVIVBq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 21:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVIVBq5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 21:46:57 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:37505 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965206AbVIVBq4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 21:46:56 -0400
Received: by qproxy.gmail.com with SMTP id v40so12688qbe
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 18:46:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sdo6R699IvqA/+s0T7i7xc1p10O0xZmReMd99UQXgYSHCYYn64HRCRIeHx+KxcD/VqA+HDvR8QNuu+USRzmlMU4PMoufUlWyyGt4HBBbpWewQOyr/UHMjprnZ+UWunqiQt239t7aC5eG+nVMaqJbabnRkC6/0F4L99P+b1ezB3Y=
Received: by 10.64.204.12 with SMTP id b12mr147681qbg;
        Wed, 21 Sep 2005 18:46:55 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 21 Sep 2005 18:46:55 -0700 (PDT)
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050921.172849.103555057.davem@davemloft.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9091>

On 9/22/05, David S. Miller <davem@davemloft.net> wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> > I often have local changes in my tree that I don't want to commit but that
> > I'm testing out. Havign them interfere with merging other peoples work
> > would mean that I'd have to have a totally separate tree for that, which I
> > could do, but I'm much much happier not having to.
>
> You know, I personally was unaware that this was supported until now.
> I have been always reverting local debugging changes in order to merge
> other people's work in, then reapply the debugging changes afterwards.
>
> I guess I won't have to do that any more. :-)

Using Cogito, we've found a couple of cases where merging on a dirty
tree messed things up. The local changes were lost after the merge.

I didn't bother to investigate further, because I didn't know whether
it was supported "formally", or meant to be supported for long.
Instead, I added a check in cg-merge that refuses to run on a dirty
tree.

I guess I'll take that out, and try and debug any future sightings of
the problem...


martin
