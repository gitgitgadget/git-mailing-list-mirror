From: Pavel Roskin <proski@gnu.org>
Subject: Re: gitk shows an empty line between "Comments" and changed files
Date: Fri, 28 Oct 2005 18:45:03 -0400
Message-ID: <1130539503.10531.43.camel@dv>
References: <1130434230.19641.21.camel@dv>
	 <7vslum3l2w.fsf@assigned-by-dhcp.cox.net> <1130463389.2186.14.camel@dv>
	 <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 29 00:46:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVcyJ-0008WM-48
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 00:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbVJ1WpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 18:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbVJ1WpL
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 18:45:11 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:30411 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751946AbVJ1WpK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 18:45:10 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EVcy9-0007uE-N1
	for git@vger.kernel.org; Fri, 28 Oct 2005 18:45:05 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EVcy7-0006rP-Bu; Fri, 28 Oct 2005 18:45:03 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q72xavz.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10776>

Hi, Junio!

On Fri, 2005-10-28 at 02:13 -0700, Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
> > git-patch-id is only used by git-cherry.  git-cherry writes the second
> > SHA1 to some files in a temporary directory, but it never reads those
> > files, it only checks that they exist.
> 
> I do not oppose dropping the commit-id line from the default
> output, but having it optionally available would be useful in
> one application.  Somebody _could_ write a tool that does
> something like:
> 
>     git-rev-list ^$old_head $new_head |
>     git-diff-tree -p -m --stdin --with-commit-ids |
>     git-patch-id

Sounds good.  Perhaps the commit IDs should have a prefix identifying
them.

Another approach would be to use something slightly more elaborate than
a pipe.  If I understand correctly, the commit ID would be already known
from the git-rev-list output.  Passing commit IDs through patch-id
without actually doing anything with them seems non-elegant.  Maybe we
could teach git-patch-id (or another script) to get patches by commit-id
instead of using stdin?

-- 
Regards,
Pavel Roskin
