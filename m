From: "David S. Miller" <davem@davemloft.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 08 Jan 2006 12:35:25 -0800 (PST)
Message-ID: <20060108.123525.41739629.davem@davemloft.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
	<Pine.LNX.4.64.0601081141450.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: martin.langhoff@gmail.com, len.brown@intel.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 21:36:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvhGd-00023g-Ho
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWAHUfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 15:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWAHUft
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 15:35:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47533
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161122AbWAHUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 15:35:48 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1EvhG9-0003os-LB; Sun, 08 Jan 2006 12:35:25 -0800
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.64.0601081141450.3169@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14333>

From: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 8 Jan 2006 11:56:21 -0800 (PST)

> So my suggested git usage is to _not_ play games. Neither do too-frequent
> merges _nor_ play games with git-rebase.
> 
> That said, git-rebase (and associated tools like "git-cherry-pick" etc) 
> can be a very powerful tool, especially if you've screwed something up, 
> and want to clean things up. Re-doing history because you realized that a 
> you did something stupid that you don't want to admit to anybody else.
> 
> So trying out git-rebase and git-cherry-pick just in case you decide to 
> want to use them might be worthwhile. Making it part of your daily routine 
> like David has done? Somewhat questionable, but hey, it seems to be 
> working for David, and it does make some things much easier, so..

The time at which I do the by-hand rebasing the most are the weeks
leading up to a major release.  The reason is to integrate bug fixes
that I know conflict with the 80-odd patches I have queued up for the
next development phase, or that I simply want integrated so that no
_future_ development patches create conflicts.

I think merges with conflicts that need to get resolved by hand create
a lot of noise and useless information and therefore to me they are
pointless.  But this is just my opinion.  It simply works easier to me
to shuffle the patches in by hand and deal with the rejects one by
one.  It's very much akin to how Andrew's -mm tree works.

I think a clean history is worth an extra few minutes of someone's
time.  And note that subsystem development is largely linear anyways.
