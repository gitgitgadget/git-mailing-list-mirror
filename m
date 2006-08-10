From: Willy Tarreau <w@1wt.eu>
Subject: Re: What's in git.git, and announcing GIT 1.4.2-rc4
Date: Thu, 10 Aug 2006 07:42:11 +0200
Message-ID: <20060810054211.GA28387@1wt.eu>
References: <7vy7txxts5.fsf@assigned-by-dhcp.cox.net> <20060810033448.GH8776@1wt.eu> <7vu04lxjsv.fsf@assigned-by-dhcp.cox.net> <7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 07:59:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB3Ze-0005FV-5o
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 07:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWHJF7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbWHJF7O
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 01:59:14 -0400
Received: from 1wt.eu ([62.212.114.60]:47885 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161048AbWHJF7M (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 01:59:12 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyg5xi02.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25155>

On Wed, Aug 09, 2006 at 10:43:57PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Willy Tarreau <w@1wt.eu> writes:
> >
> >> I encountered a problem in 1.4.1 and 1.4-git about 2 weeks ago
> >> (I've not tried 1.4.2-rc4 yet). When applying a git patch which
> >> contains a symlink, the symlink created on the filesystem sometimes
> >> has a wrong name with some chars appended to its end.
> >
> > Thanks.  I can reproduce this, and am looking into it.
> 
> Found it.  The patch application mechanism uses a counted string
> (char *buf with ulong size) to hold the result, and the code
> stupidly threw the buf to symlink(2), without making it NUL
> terminated.

Excellent ! That means that under some circumstances, it might even have
corrupted the very first link, and not necessarily only the second and
other ones. Thanks for having fixed it that fast.

Cheers,
Willy
