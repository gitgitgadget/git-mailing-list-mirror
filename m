From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn is "Unable to determine upstream SVN information..."
Date: Fri, 10 Jul 2009 13:33:22 -0700
Message-ID: <20090710203322.GA18051@dcvr.yhbt.net>
References: <ohrc5510bko329be5ugj3n6bgvhcevd2kg@4ax.com> <20090710033133.GA23082@dcvr.yhbt.net> <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Esben Skovenborg <esskov@oncable.dk>
X-From: git-owner@vger.kernel.org Fri Jul 10 22:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPMmy-0006h0-BZ
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 22:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbZGJUdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 16:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZGJUdX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 16:33:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59697 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbZGJUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 16:33:23 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id D20D51F5FC;
	Fri, 10 Jul 2009 20:33:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5m5e55538tlnq40rup7rci61i2mg16q0dv@4ax.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123082>

Esben Skovenborg <esskov@oncable.dk> wrote:
> On Thu, 9 Jul 2009 20:31:33 -0700, Eric Wong wrote:
> >Are there any weird characters in the URL?  
> 
> No. The only thing 'different' about this svn server is that it uses
> authentication (i.e. asks for name+password). But I suppose that when the
> git-svn fetch goes well, then this is not the problem?  Do the git-svn
> info and git-svn rebase even need to access the svn server?

Yes, rebase (without the -l) option needs it for sure.  I think info can
optionally use it, too.  Does enabling authentication caching (enabled
by default in SVN) help things?  I haven't used the authentication
prompt pieces in ages, they're hard to test in an automated fashion so
they may have bit-rotted since I last looked at them...

> >Off the top of my head I can't think of anything else; I assume
> >you're not allowed to share access to the repo (or to the clone) you're
> >having problems with?
> 
> Right, at least it's something we should talk about off-list.
> 
> Is there any way of asking git-svn *why* it is "unable to determine
> upstream SVN information from working tree history" ?

If you're comfortable with a little Perl, you can sprinkle some debug
statements in working_head_info().  Feel free to email me directly
offlist but my schedule looks pretty hectic today and this weekend
and I may be offline a lot.

-- 
Eric Wong
