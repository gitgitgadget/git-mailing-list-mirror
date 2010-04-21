From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 0/2] git-svn: Allow certain refs to be ignored
Date: Wed, 21 Apr 2010 07:18:00 +0000
Message-ID: <20100421071759.GA15680@dcvr.yhbt.net>
References: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Stoakes <tim@stoakes.net>, Sam Vilain <sam@vilain.net>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 09:18:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4UCG-0002nH-UI
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 09:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab0DUHSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 03:18:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59531 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab0DUHSA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 03:18:00 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67FC71F4ED;
	Wed, 21 Apr 2010 07:18:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <o2xc8b3bef91004201430m10bbe060q7d8ebd3a1ac4c3bd@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145412>

Michael Olson <mwolson@gnu.org> wrote:
> This change allows certain refs to be ignored while importing svn
> history.  This is useful for:
> 
>  - Performing overlapping transforms from svn's branch namespace into
>    git's namespace.  The overlapping refs can be ignored.  It might
>    potentially be a better idea in this case to make git-svn assign
>    precedence according to the order in which the branch patterns are
>    specified, perhaps with an option to trigger that behavior (which
>    is out of scope for this patch series).
> 
>  - Avoiding some refs that represent bad svn operations which cause
>    git-svn to take a very long time.  Example: copying one module
>    accidentally into another module's branch namespace.

Hi Michael, these are definitely good things to have.  Thanks!

> A new config directive called "ignore-refs" implements this feature by
> means of a regex of refs to ignore.  I haven't written the necessary
> git-svn documentation updates for it yet.

See Junio's and my other email.

> In addition, I ran across a problem where git-svn would die if a
> parent ref did not exist.  This might possibly have been exposed as a
> result of the first patch.  I threw an eval around the offending code,
> and that seems to work, though some review would be appreciated.

I'm cc-ing Sam for this one.  It looks good to me given the first patch
would cause more refs to not exist.

-- 
Eric Wong
