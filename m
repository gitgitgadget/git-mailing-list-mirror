From: Brendan Cully <brendan@kublai.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Sat, 3 Feb 2007 12:06:39 -0800
Message-ID: <20070203200638.GA6888@xanadu.kublai.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<20070202173758.GC10108@waste.org>
	<200702021944.14756.jnareb@gmail.com>
	<200702022056.32791.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Mackall <mpm@selenic.com>, Junio C Hamano <junkio@cox.net>,
	mercurial@selenic.com, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 21:07:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDRAB-00072L-SE
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 21:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbXBCUHF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 15:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbXBCUHE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 15:07:04 -0500
Received: from zakopane.cs.ubc.ca ([198.162.52.68]:40084 "EHLO
	mail.quuxuum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbXBCUHD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 15:07:03 -0500
Received: from zakopane.cs.ubc.ca (localhost.localdomain [127.0.0.1])
	by mail.quuxuum.com (Postfix) with ESMTP id 44AC45C4DA
	for <git@vger.kernel.org>; Sat,  3 Feb 2007 12:06:41 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed; d=kublai.com; h=received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:x-delivery-agent:from:mail-followup-to; q=dns; s=dk; bh=a7wB6qfFxRnKkxdDcaXyVNLa09c=; b=LMaaqDMtl+tQ8yFQJvDYz/enfPInKWjJFZr+iv3EjGm4lR7orr+1cphGe8FGejcJis13ZKnu6b0bOI91lef5WFRA3SBbNcP7L7I0nkKqyEgx9wkS0TxJVdE8IoCVWN89ZDAaMeBPQgHLO5/qdj6bwPubSPoP7Q1b1v47EXOEzqc=
Received: by zakopane.cs.ubc.ca (tmda-sendmail, from uid 103);
	Sat, 03 Feb 2007 12:06:40 -0800 (PST)
Received: from xanadu.kublai.com (xanadu.kublai.com
	[IPv6:2001:5c0:89ec:1:1::2])
	by mail.quuxuum.com (Postfix) with ESMTP id 1E69B5C354;
	Sat,  3 Feb 2007 12:06:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200702022056.32791.jnareb@gmail.com>
X-Operating-System: Darwin 8.8.0 Power Macintosh
User-Agent: Mutt/1.5.13 (2007-01-09)
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Mail-Followup-To: jnareb@gmail.com, mpm@selenic.com, junkio@cox.net,
	mercurial@selenic.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38593>

On Friday, 02 February 2007 at 20:56, Jakub Narebski wrote:
> For example you are on branch 'master', you tag current release
> e.g. v1.3.4, then you checkout branch 'devel'... and you don't have
> v1.3.4 tag available unless you merge in .hgtags from 'master'.
> At least from what I understand of Mercurial tags behaviour.

This would be bad, if it were true.

$ hg up devel
2 files updated, 0 files merged, 0 files removed, 0 files unresolved
$ cat .hgtags
6acda9aa5d8c621b3db2f2daab878d8de726d227 base
$ hg tags
tip                                4:b1f003583d8e
v1.3.4                             2:87e43e86318f
base                               0:6acda9aa5d8c

As mentioned before, hg has local tags which sound an awful lot like
git tags. It also has properly versioned tags. And, by the way, if you
push a branch, you only push the tags that were committed on that
branch. Furthermore, you can push based on a tag name that isn't
committed in the branch you're pushing. I think the "globally global"
nonsense elsewhere in this thread may be a result of not understanding
this.

I'm probably done with this thread too. There's too much ignorant
speculation to make it very productive.
