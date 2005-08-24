From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 14:01:34 -0600
Organization: Hewlett Packard
Message-ID: <20050824200134.GB693@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <7vu0hfdwql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 22:03:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E81RL-0006mk-5j
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 22:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbVHXUBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 16:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbVHXUBf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 16:01:35 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:40123 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751515AbVHXUBe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 16:01:34 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id 4A1309BA3;
	Wed, 24 Aug 2005 16:01:34 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 1E0C441DFDA; Wed, 24 Aug 2005 20:01:34 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 0E1E32CE99; Wed, 24 Aug 2005 14:01:34 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0hfdwql.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7726>

On Wed, Aug 24, 2005 at 11:18:42AM -0700, Junio C Hamano wrote:
> Carl Baldwin <cnb@fc.hp.com> writes:
> 
> > Attached are the two scripts.  Comments and criticism are welcome.
> 
> An obligatory non-technical comment.  I would have liked to see
> this not in a MIME multipart format, which made commenting on it
> a bit harder than necessary.
> 
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: attachment; filename=git-undo-script
> >
> > #!/bin/sh
> >
> > . git-sh-setup-script || die "Not a git archive"
> >
> > if [ -n "$(git-diff-files)" ]; then
> >     echo The following files should be updated!
> >     echo
> >     git-diff-files | awk '{print $6}'
> > fi
> 
> There is nothing wrong with the above, but I would have written
> it like this (I think you forgot to exit after showing the list
> of files):
> 
>     git-update-cache --refresh || exit

I'll take this.  This is what I was going for but being new to git I
didn't know all that was available.  A good reason to request comments
:-)

> Also nice to learn here is "git-diff-files --name-only".

Also good to know, thanks.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
