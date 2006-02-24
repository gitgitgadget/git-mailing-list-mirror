From: Eric Wong <normalperson@yhbt.net>
Subject: Re: FYI: git-am allows creation of empty commits.
Date: Fri, 24 Feb 2006 05:19:22 -0800
Message-ID: <20060224131922.GA19401@localdomain>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com> <7v1wxtgv02.fsf@assigned-by-dhcp.cox.net> <m18xs1dmp3.fsf@ebiederm.dsl.xmission.com> <7vy8019d44.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Fri Feb 24 14:19:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCcr2-0001Nj-7i
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 14:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWBXNTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 08:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWBXNTZ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 08:19:25 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54668 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751004AbWBXNTY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2006 08:19:24 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id AB6487DC020;
	Fri, 24 Feb 2006 05:19:22 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Feb 2006 05:19:22 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy8019d44.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16700>

Junio C Hamano <junkio@cox.net> wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Is this something that we always want to test for in the porcelain
> > or do we want to move a check into git-commit-tree?
> >
> > For getting a reasonable error message where you have the test
> > seems to be the only sane place, but having the check deeper
> > down would be more likely to catch this kind of thing.
> 
> I think 99.9% of the time it is a mistake if a single-parented
> commit has the same tree as its parent commit has, so having a
> check in commit-tree may not be a bad idea.

This would break importers, more than 0.1% I think...  Arch definitely allows
empty commits for getting log messages in.  SVN forbids them from their POV, but
they also have things that we can't see when we import (properties like: mime,
externals, eol-style) causing us to write the same tree twice.  Not sure about
CVS...

Maybe a flag such as --force could be added.

-- 
Eric Wong
