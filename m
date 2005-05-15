From: Junio C Hamano <junkio@cox.net>
Subject: Re: git repository for net drivers available
Date: Sun, 15 May 2005 14:46:11 -0700
Message-ID: <7vacmwqi1o.fsf@assigned-by-dhcp.cox.net>
References: <42841A3F.7020909@pobox.com> <4284C54E.3060907@linux.intel.com>
	<4284C7DA.1020707@pobox.com> <20050515200514.GA31414@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 23:46:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXQw8-0003JJ-EB
	for gcvg-git@gmane.org; Sun, 15 May 2005 23:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVEOVqV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEOVqV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 17:46:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:45816 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261261AbVEOVqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 17:46:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515214613.NHVX7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 17:46:13 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050515200514.GA31414@pasky.ji.cz> (Petr Baudis's message of
 "Sun, 15 May 2005 22:05:14 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Fri, May 13, 2005 at 05:29:30PM CEST, I got a letter
PB> where Jeff Garzik <jgarzik@pobox.com> told me that...
>> Looks like cogito is using $repo/heads/$branch, whereas my git repo is 
>> using $repo/branches/$branch.

PB> Would it be a big problem to use refs/heads/$branch? That's the
PB> currently commonly agreed convention about location for storing branch
PB> heads, not just some weird Cogito-specific invention. And it'd be very
PB> nice to have those locations consistent across git repositories.

Since Jeff brought up $repo/branches/$branch, you may also want
to add that $repo/branches/$branch is used to record the URL of
the remote $branch (the information used to be in a flat file
$repo/remotes, branch name and URL separated by shell $IFS, one
record on each line), and is quite different from those 40-byte
SHA1 plus LF files you see in $repo/refs/*/ directory.

I think it is a reasonable one, I also follow the
$repo/branches/$branch convention Cogito uses, and I would
encorage other Porcelain implementations to follow suit.

