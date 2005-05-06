From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/5] git-tar-tree: add symlink support
Date: Fri, 6 May 2005 22:55:29 +0200
Message-ID: <20050506205529.GA19518@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 22:49:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU9l8-0000Qx-TR
	for gcvg-git@gmane.org; Fri, 06 May 2005 22:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVEFUze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 16:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVEFUze
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 16:55:34 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:25019 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261232AbVEFUza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 16:55:30 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 1C7B4307; Fri,  6 May 2005 22:55:29 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since symlinks can be stored inside GIT, git-tar-tree should properly
handle them, too.  The first three patches do a bit of cleanup to make
adding symlink support easier.  The fourth patch actually dirties the
code, also to make the fifth one easier. :)  I just couldn't think of a
better way to split the changes and a combined patch of 4&5 did too much
at once.

If a link target is longer than 100 chars than an extended header is
created.  Because of the way git-tar-tree handles extended headers that
means the sum of path and target of a symlink must be less than about
490 chars.  This is not a limitation of the archive format, so we can
fix it later.

Rene
