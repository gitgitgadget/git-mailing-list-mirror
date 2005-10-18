From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection for single file
Date: Tue, 18 Oct 2005 13:50:54 -0700
Message-ID: <7vu0fepn0x.fsf@assigned-by-dhcp.cox.net>
References: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 22:53:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERyQI-0007FL-Jw
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 22:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVJRUvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 16:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVJRUu7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 16:50:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:2030 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932091AbVJRUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 16:50:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051018205044.CGIU1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Oct 2005 16:50:44 -0400
To: David Ho <davidkwho@gmail.com>
In-Reply-To: <4dd15d180510181256i1c5a82d9ld62acaedb493cf71@mail.gmail.com>
	(David Ho's message of "Tue, 18 Oct 2005 15:56:06 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10232>

David Ho <davidkwho@gmail.com> writes:

> I have a small suggestion to make the diff of a renamed file a bit
> more meaningful.  I have a file that is renamed-edited and commited. 
> git-diff-tree -M -p <commit> shows one result and git-diff-tree -M -p
> <commit> <filename> shows another.  If they both show a rename
> occurred then I think the single file git-diff-tree will be more
> useful.

Sorry, this has vetoed by Linus long time ago.  The <filename>
restricts the paths being passed to the diff machinery upfront,
so once you say <filename>, the rename detection will see only
that path and nothing else to compare and guess which other file
that file in question is a copy of.
