From: Ryan Anderson <ryan@michonline.com>
Subject: Re: sending changesets from the middle of a git tree
Date: Mon, 15 Aug 2005 02:35:02 -0400
Message-ID: <20050815063502.GD7001@mythryan2.michonline.com>
References: <42FEBC16.9050309@austin.rr.com> <20050814040233.GC6844@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 08:35:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4YZ0-0000uu-Ij
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 08:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVHOGfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 02:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVHOGfF
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 02:35:05 -0400
Received: from mail.autoweb.net ([198.172.237.26]:25044 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932098AbVHOGfE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 02:35:04 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E4YYp-000648-BY; Mon, 15 Aug 2005 02:35:03 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E4YYo-00013D-00; Mon, 15 Aug 2005 02:35:02 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E4YYo-0001z9-Qq; Mon, 15 Aug 2005 02:35:02 -0400
To: Steve French <smfrench@austin.rr.com>
Content-Disposition: inline
In-Reply-To: <20050814040233.GC6844@mythryan2.michonline.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 14, 2005 at 12:02:33AM -0400, Ryan Anderson wrote:
> On Sat, Aug 13, 2005 at 10:35:50PM -0500, Steve French wrote:
>
> > 2) There is no way to update the comment field of a changeset after it 
> > goes in (e.g. to add a bugzilla bug number for a bug that was opened 
> > just after the fix went in).
> 
> No, a commit is immutable.  You can use "git format-patch" to rebase things if
> you need.  I prefer to use "git format-patch --mbox", edit what I need
> to, then use git-applymbox to rebase it all against a clean tree.

Note (and I should have said this at first), doing it this way gives you
the opportunity to combine a few changes if you want.

Use git-format-patch-script to pull out what you want, delete the diff
from the bottom of the file, manually diff what you need using
git-diff-script, and stick that back at the end of the file
git-format-patch-script created.

This seems to be the easiest way to clean up your change history.

-- 

Ryan Anderson
  sometimes Pug Majere
