From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add an empty directory?
Date: Sat, 13 Aug 2005 12:45:38 -0700
Message-ID: <7v64u9mxi5.fsf@assigned-by-dhcp.cox.net>
References: <20050813173043.GA25013@hpsvcnb.fc.hp.com>
	<20050813180008.GJ5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 21:46:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E41x0-0006vH-J5
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 21:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVHMTpk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 15:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVHMTpk
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 15:45:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:21420 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932272AbVHMTpj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 15:45:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050813194537.QZNO1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 15:45:37 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813180008.GJ5608@pasky.ji.cz> (Petr Baudis's message of
	"Sat, 13 Aug 2005 20:00:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> the object databases supports it, but the index file does not. But yes,
> it should be supported, I think.

I think if this is done correctly "read-tree -m -u" two-tree
switch could even remove directories that existed in the old
tree but not in the new tree that has become empty.

On the other hand, although I haven't started looking, adding
this to index file might involve a major surgery.  Practically
everybody expects it is does not have an directory entry.  This
includes reading trees, merging two or more stages, finding
directory/file conflicts, etc. etc...
