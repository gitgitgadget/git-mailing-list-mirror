From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 11:10:08 +0200
Message-ID: <200507291110.08417.Josef.Weidendorfer@gmx.de>
References: <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <20050729070628.GA24895@pasky.ji.cz> <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 29 11:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQu6-0005pq-Gf
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 11:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVG2JLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 05:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVG2JLC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 05:11:02 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:55994 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S262539AbVG2JKR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 05:10:17 -0400
To: git@vger.kernel.org
User-Agent: KMail/1.8.1
In-Reply-To: <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Friday 29 July 2005 09:48, you wrote:
> Petr Baudis <pasky@suse.cz> writes:
> > So, what do you mean by "clone" here? And what command should I use for
> > pushing then?
...
> Now, A may happen to be on my home machine and B may happen be
> on my notebook, meaning the owner of A and B are both myself.
> But even in that case I would still work by "pulling from A"
> when I am on B, and "pulling from B" when I am on A.  In other
> words, "pulling" is the only patch flow mechanism I would use.

OK, that is your opinion and your work flow. But porcelains perhaps would like 
to allow other work flows, even if it seems confusing for you.

And I think the problem here simple is that send-pack *forces* local and 
remote head names to be the same. This is forcing policy to porcelains, but 
GIT should be only about plumbing.

Perhaps the solution is to allow more flexibility in GIT.
What about introducing an additional environment GIT_REFS_DIR?
When using send-pack, the porcelain would set this variable to a directory 
containing a 1:1 name relationship to the remote repository.

Josef
