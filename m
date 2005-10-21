From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-fetch: retrieve missing commits with a smarter optimization
Date: Fri, 21 Oct 2005 14:47:11 +0200
Message-ID: <20051021124711.GG30889@pasky.or.cz>
References: <11298726913836-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 14:49:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESwIy-0004fC-KP
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 14:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVJUMrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVJUMrQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 08:47:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:9922 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964930AbVJUMrO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 08:47:14 -0400
Received: (qmail 24177 invoked by uid 2001); 21 Oct 2005 14:47:11 +0200
To: Martin Langhoff <martin@catalyst.net.nz>
Content-Disposition: inline
In-Reply-To: <11298726913836-git-send-email-martin@catalyst.net.nz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10431>

Could you please resend your patches signed off? Thanks.

Dear diary, on Fri, Oct 21, 2005 at 07:31:31AM CEST, I got a letter
where Martin Langhoff <martin@catalyst.net.nz> told me that...
>  + will check tagrefs, trying to ensure it actually has the relevant
>    commits. If the commits are missing, it'll go out and fetch them.

I'd prefer the approach to throw away the tag. Otherwise we get into
problems when we want to grab only a single branch from multi-branch
repository.

>  + if the tagref points to a blob and we have it, it'll skip it

The problem is that the ^{blob} syntax is not in 0.98, so this would
make Cogito depend on a yet unreleased GIT version, which is
troublesome.

So I guess this patch will end up in my post-0.99/1.0 queue for now.
But by that time, this part of cg-fetch will be probably already totally
rewritten. ;-)

> This isn't a complete solution for cg-fetch -- git-fetch is actually
> much smarter now, and cg-fetch should perhaps be a thin wrapper
> around it, dropping all the duplicate code.

I'm still thinking about it. I will certainly try to at least somehow
reuse git-fetch's remote parser, if not anything else - reimplementing
that would be just stupid.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
