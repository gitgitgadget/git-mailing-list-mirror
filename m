From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to pick a commit from another git tree?
Date: Sun, 7 Oct 2007 22:10:48 +0200
Message-ID: <20071007201048.GA2765@steel.home>
References: <000101c80907$d461a810$04ac10ac@Jocke>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sun Oct 07 22:11:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IecT7-00089H-VR
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 22:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbXJGUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 16:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756063AbXJGUKz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 16:10:55 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:44525 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641AbXJGUKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 16:10:54 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo6) (RZmta 13.4)
	with ESMTP id z00c66j97HmqRZ ; Sun, 7 Oct 2007 22:10:50 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 698CB277AE;
	Sun,  7 Oct 2007 22:10:50 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6020EC502; Sun,  7 Oct 2007 22:10:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <000101c80907$d461a810$04ac10ac@Jocke>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60214>

Joakim Tjernlund, Sun, Oct 07, 2007 19:31:00 +0200:
> This is probably a somewhat stupid question but I havn't had a need until now so here goes:
> There is a commit in David Millers tree:
> http://git.kernel.org/?p=linux/kernel/git/davem/bak-net-2.6.24.git;a=commit;h=bbb4c0c35a4c2aed5e025b668c8dfc99c5b74cff
> that hasn't made it into 2.6.23, but will go into 2.6.24. 
> I need this fix on top of 2.6.23(once it is released).

$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/davem/bak-net-2.6.24.git
$ git cherry-pick bbb4c0c35a4c2aed5e025b668c8dfc99c5b74cff

> Now I wonder how to best add this fix to my tree. Once this fix hits linus tree and I pull
> linus tree, I don't wan't a conflict as I already have this fix in my tree.

Depending on the state the Davids tree ends up when it is merge into
Linus' tree you may or may not get a conflict. It is not in your hands
either way.

> Should I just pull Davids tree? Or should I cherry-pick this one commit?
> Or something else?

I would just cherry-pick it, and revert it (or hard-reset my tree to
Linus' tree) if it conflicts later.
