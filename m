From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: How to do a reverse rebase?
Date: Mon, 20 Aug 2007 11:49:43 +0200
Organization: eudaptics software gmbh
Message-ID: <46C963B7.7ABF2944@eudaptics.com>
References: <20070820053237.9349.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 11:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN3uY-00066J-BB
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 11:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXHTJu7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 05:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXHTJu7
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 05:50:59 -0400
Received: from main.gmane.org ([80.91.229.2]:42705 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbXHTJu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 05:50:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IN3tu-0005PL-Ol
	for git@vger.kernel.org; Mon, 20 Aug 2007 11:50:23 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 11:50:22 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 11:50:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56203>

linux@horizon.com wrote:
> I don't want to rebase HEAD on *that*, but rather rebase *that*
> on top of the current HEAD.
> 
> Sometimes I have a little debug hack on a branch by itself, and I
> discover that I need it again, so I want to rebase it on top of
> current development.
> 
> But there's been a LOT of development in the meantime.  And if I do
> 
> git-rebase HEAD debug_hack
> 
> git first checks out debug_hack.  This takes a while and, more
> importantly, every file modified in HEAD...debug_hack has its timestamp
> touched and make(1) insists on recompiling it.

Heh. For the same reason I also want 'git merge --into that'.

I often hack on a topic branch until it has the right shape. One of the
changes touches a central file that triggers a complete recompile.

Now I want to merge the topic into master (which did not change this
central file since the merge-base). Currently, I must checkout master,
which touches the file, but if there existed 'merge --into' it could get
away without touching the file.

-- Hannes
