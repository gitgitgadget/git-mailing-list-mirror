From: Junio C Hamano <junkio@cox.net>
Subject: Re: Check for differents trees
Date: Sun, 06 Nov 2005 10:09:34 -0800
Message-ID: <7vy841y7fl.fsf@assigned-by-dhcp.cox.net>
References: <20051106153830.18963.qmail@web26312.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 19:10:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYoxd-0006EY-OA
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 19:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVKFSJg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 13:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVKFSJg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 13:09:36 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10372 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750829AbVKFSJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 13:09:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106180915.ZBDQ1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 13:09:15 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051106153830.18963.qmail@web26312.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sun, 6 Nov 2005 07:38:30 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11219>

Marco Costalba <mcostalba@yahoo.it> writes:

> What I use now is:
>
> git-diff-tree -r --name-status sha1 sha2
>
> An then I parse the output for 'A' or 'D' as first char of
> each line. When I found one of that two chars I kwnow trees
> have different files set.
>
> The problem is that if sha1 and sha2 correspond to very
> "distant" revision the output of git-diff-tree can be very
> long and also usless as long as I stop searching at first
> match.

Perhaps

	$ git-diff-tree -r --name-status --diff-filter=AD sha1 sha2

would help you somewhat?  This would not make the diff
generation part quicker, but at least you do not have to parse
other types of changes.
