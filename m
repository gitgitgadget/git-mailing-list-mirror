From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 12:22:53 -0800
Message-ID: <7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112190031.GH14196@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 21:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex8yI-0003Ww-FD
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 21:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWALUWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 15:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWALUWz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 15:22:55 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10143 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161165AbWALUWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 15:22:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112202049.OQMV26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 15:20:50 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060112190031.GH14196@ca-server1.us.oracle.com> (Joel Becker's
	message of "Thu, 12 Jan 2006 11:00:31 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14585>

Joel Becker <Joel.Becker@oracle.com> writes:

> On Thu, Jan 12, 2006 at 09:37:00AM -0500, sean wrote:
>> Use the author name and email information given as the 
>> first line of the commit message in the form of:
>> 
>> From: name <email>
>> 
> 	If we do this, can we have it populated up front?  That is, when
> the edit opens, the current idea of author is in the comments as "From:"
> so I can see what the author would be if I changed nothing.  This would
> catch surprises where I'd forgotten to set AUTHOR_*, etc.

Committing somebody else's changes by hand ought to be a rare
event.  Otherwise that is an indication that there needs to be a
"git am/applymbox" equivalent for the mythical transport medium
(other than e-mail) that feeds you somebody else's changes to
you and have you commit.  If something is a regular event in a
workflow, we would want to be able to automate things, and
having the user type in whom the changes have come from is not
the way to do it.

Most of the time when I use "git commit", I'll be committing my
own changes; I do not want to see "From: me" every time I
commit.

"Populate upfront, only if it is different from yourself" is
perhaps acceptable, but that is probably hard to arrange.  There
is no reliable way to know what is "yourself", and that was why
we have GIT_AUTHOR_* environment variables to override things to
begin with.
