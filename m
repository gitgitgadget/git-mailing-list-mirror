From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 01:10:53 +0200
Message-ID: <20050529231053.GD12290@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505271248450.17402@ppc970.osdl.org> <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org> <20050527192941.GE7068@cip.informatik.uni-erlangen.de> <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net> <20050527195552.GA6541@cip.informatik.uni-erlangen.de> <7vu0kowho9.fsf@assigned-by-dhcp.cox.net> <20050527203227.GA11139@cip.informatik.uni-erlangen.de> <20050529230240.GB12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:09:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcWte-00046B-6Y
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVE2XLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVE2XLG
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:11:06 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:5305 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261376AbVE2XLC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:11:02 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4TNArS8001357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 May 2005 23:10:53 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4TNAr59001356;
	Mon, 30 May 2005 01:10:53 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050529230240.GB12290@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
one obvious fix:

> 			$message .= "<= ${current_url} (nothing to merge)\n";
> 			$message   .= "<= ${current_url} (bringing head ahead)\n";

the parents of such 'merges' should *not* be referenced in the commit
object E.g. this is wrong: 'git-commit-tree -p nothing_to_merge -p
just_bringing_head_ahead'. Leaving the message in the log section of the
commit object could be useful, maybe. Thoughts?

And I should doublecheck if more than 16 parents show up in
git-commit-tree when doing the commits and throw an error.

	Thomas
