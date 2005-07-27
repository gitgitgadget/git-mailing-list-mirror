From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Linux BKCVS kernel history git import..
Date: Wed, 27 Jul 2005 10:40:38 +0100
Message-ID: <1122457238.3027.37.camel@baythorne.infradead.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 11:41:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxiPi-000064-V5
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 11:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVG0Jkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 05:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVG0Jkz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 05:40:55 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:64186 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S262080AbVG0Jkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 05:40:49 -0400
Received: from localhost.localdomain ([127.0.0.1])
	by baythorne.infradead.org with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1DxiP1-00005n-1V; Wed, 27 Jul 2005 10:40:39 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-07-26 at 11:57 -0700, Linus Torvalds wrote:
> If somebody adds some logic to "parse_commit()" to do the "fake parent"
> thing, you can stitch the histories together and see the end result as one
> big tree. Even without that, you can already do things like
> 
>         git diff v2.6.10..v2.6.12

That's a bit of a hack which really doesn't belong in the git tools.
It's not particularly hard to reparent the tree for real -- I'd much
rather see a tool added to git which can _actually_ change the
1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 commit to have a parent of
0bcc493c633d78373d3fcf9efc29d6a710637519, and ripple the corresponding
SHA1 changes up to the current HEAD.

Note that the latter commit ID I gave there was actually the 2.6.12-rc2
commit in Thomas' history import, not your own. Thomas has done a lot of
work on it, and it has the full names extracted from the shortlog
script, full timestamps, branch/merge history and consistent character
sets in the commit logs. I'd definitely suggest that you use that
instead of the import from bkcvs.

http://www.kernel.org/git/?p=linux/kernel/git/tglx/history.git;a=summary

-- 
dwmw2
