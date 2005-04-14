From: Christopher Li <git@chrisli.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 18:30:39 -0400
Message-ID: <20050414223039.GB28082@64m.dyndns.org>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 03:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMFlw-0002XG-12
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 03:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVDOBkt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 21:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDOBkt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 21:40:49 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:61392 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261713AbVDOBkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 21:40:41 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc13) with ESMTP
          id <2005041501404101600arqp5e>; Fri, 15 Apr 2005 01:40:41 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 780553F1EF; Thu, 14 Apr 2005 18:30:39 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 05:58:25PM -0700, Junio C Hamano wrote:
> 
> I do like, however, the idea of separating the step of doing any
> checkout/merge etc. and actually doing them.  So the command set
> of parse-your-output needs to be defined.  Based on what I have
> done so far, it would consist of the following:
> 
>  - Result is this object $SHA1 with mode $mode at $path (takes
>    one of the trees); you can do update-cache --cacheinfo (if
>    you want to muck with dircache) or cat-file blob (if you want
>    to get the file) or both.

Is that SHA1 for tree or the file object? If it is tree it don't
need the $mode any more.  If it is file you might need to emit
entry for it's parent directory, including the modes of directory.

> 
>  - Result is to delete $path.
> 
>  - Result is a merge between object $SHA1-1 and $SHA1-2 with
>    mode $mode-1 or $mode-2 at $path.
>
> Would this be a good enough command set?

And of course error/command for the files that unable to perform
auto merge. including information of both revisions. That needs
to be defined as well.

Chris

