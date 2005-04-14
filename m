From: Petr Baudis <pasky@ucw.cz>
Subject: git merge
Date: Fri, 15 Apr 2005 00:11:28 +0200
Message-ID: <20050414221127.GI22699@pasky.ji.cz>
References: <20050414002902.GU25711@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCVS-000601-8C
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVDNWLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVDNWLf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:11:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49356 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261446AbVDNWLa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 18:11:30 -0400
Received: (qmail 12721 invoked by uid 2001); 14 Apr 2005 22:11:28 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050414002902.GU25711@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  note that in my git tree there is a git merge implementation which
does out-of-tree merges now. It is still very trivial, and basically
just does something along the lines of (symbolically written)

	checkout-cache $(diff-tree)
	git diff $base $mergedbranch | git apply
	.. fix rejects etc ..
	git commit

  It seems to work, but it is only very lightly tested - it is likely
there are various tiny mistakes and typos in various unusual code paths
and other weird corners of the scripts. Testing is encouraged, and
especially patches fixing bugs you come over.

  It is designed in a way to make it possible to just replace the
checkout-cache and git diff | git apply steps with the merge-tree.pl
tool when it is finished.

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
