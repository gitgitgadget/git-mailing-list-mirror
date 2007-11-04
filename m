From: Alex Riesen <raa.lkml@gmail.com>
Subject: gitk graph routing problem
Date: Sun, 4 Nov 2007 11:46:18 +0100
Message-ID: <20071104104618.GA3078@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 11:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iod03-0004yr-6j
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 11:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754979AbXKDKqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 05:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbXKDKqW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:46:22 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:25138 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbXKDKqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:46:21 -0500
Received: from tigra.home (Fc839.f.strato-dslnet.de [195.4.200.57])
	by post.webmailer.de (fruni mo34) (RZmta 14.0)
	with ESMTP id j06ac2jA45YjmL ; Sun, 4 Nov 2007 11:46:19 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D643B277AE;
	Sun,  4 Nov 2007 11:46:18 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 319E556D22; Sun,  4 Nov 2007 11:46:18 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWottyw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63379>

To reproduce, try running in git repo:

    gitk 02f630448e5d48e..06ea6ba9cf46ef5

Than go some pages (around 5) forward. You should notice system load
going up rapidly. Now try paging back - and graph starts stretching
to the right, to the point nothing fits on the screen anymore.

Gitk as of commit 7388bcbc5431552718dde5c3259d861d2fa75a12 in git
repository. Git - v1.5.3.5-551-g02f6304 (terse fetch output and some
*really* unrelated local modifications. Anyway, the gitk is the same).
Bisect points to or around 6e8c87070306a757c4d7fd2c55cca3a90fe140c7
"gitk: Establish and use global left-to-right ordering for commits".
It loops heavily at this commit and looks broken in all subsequent
commits.

Last know good was 3244729aac7515c. The master of gitk repo is ok too.
