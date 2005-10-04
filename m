From: Dan Aloni <da-x@monatomic.org>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 10:12:13 +0300
Message-ID: <20051004071210.GA18716@localdomain>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 09:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMgud-0004E7-Qa
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVJDHI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJDHI3
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:08:29 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:19432 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932452AbVJDHI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 03:08:28 -0400
Received: from bzq-82-80-223-232.red.bezeqint.net
	([82.80.223.232]:34239 helo=callisto.yi.org ident=karrde)
	by noname.neutralserver.com with esmtpa (Exim 4.52)
	id 1EMguV-000748-7n; Tue, 04 Oct 2005 02:08:23 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9664>

On Mon, Oct 03, 2005 at 04:16:27PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 3 Oct 2005, Junio C Hamano wrote:
> > 
> > This reminds me of one patch:
> > 
> >     From: Dan Aloni <da-x@monatomic.org>
> >     Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
> >     Date: Sat, 1 Oct 2005 21:39:42 +0300
> >     Message-ID: <20051001183942.GA2099@localdomain>
> > 
> > I'd appreciate it if you had a chance to take a look at it and
> > comment on it.
> 
> I personally hate it.
> 
> It adds horrible patches to fairly core stuff, all because the prefetching 
> is not limited.

Well it can be reworked to be more clean...
 
> As far as I can tell, it should be much easier to just limit the 
> prefetching to some reasonable limit (say, a few objects deep), which 
> guarantees that the prefetching doesn't fill up the write queues on the 
> fetching side.

I'm not sure how this will be completely reliable, even if you limit the
prefetching to one object.

Suppose that this one object's size is larger than the receiving queues of 
the receiving end (like 1 MB?) and the bandwidth is high, wouldn't that 
break?

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
