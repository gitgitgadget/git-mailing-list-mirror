From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] gitk: breaks with both version and file limits
Date: Sun, 16 Apr 2006 13:54:03 +0200
Message-ID: <20060416115403.GS12638@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 16 13:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV5g7-0008MC-41
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 13:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWDPLo2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 07:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWDPLo2
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 07:44:28 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:899 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750723AbWDPLo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 07:44:27 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9FDCF9AA60;
	Sun, 16 Apr 2006 13:44:26 +0200 (CEST)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.61)
	(envelope-from <ydirson@altern.org>)
	id 1FV5pL-0004Cu-Uh; Sun, 16 Apr 2006 13:54:04 +0200
To: Paul Mackerras <paulus@samba.org>, GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18787>

As an example, on a current git tree, the following command triggers
an 'Error: expected boolean value but got ""' dialog when scrolling to
the bottom of the graph, and leaves the bottom of the graph not drawn.
This happens with current master, but not with 1.2.4.

gitk --all ^v1.0.6 -- Makefile 

While checking with git-bisect while limiting to path gitk, I noticed
the amusing detail that "git-bisect visualize" is impacted by this bug.

git-bisect shows that the commit triggering the problem is
79b2c75e043ad85f9a6b1a8d890b601a2f761a0e ("gitk: replace parent and
children arrays with lists" on Apr 2)

Hope this helps,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
