From: Junio C Hamano <junkio@cox.net>
Subject: Re: openbsd version?
Date: Mon, 10 Oct 2005 13:30:15 -0700
Message-ID: <7vll113yjs.fsf@assigned-by-dhcp.cox.net>
References: <8664s5gxl9.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0510100939320.14597@g5.osdl.org>
	<7vvf0542fs.fsf@assigned-by-dhcp.cox.net>
	<864q7pdvcn.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 22:33:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4Hu-0007oP-IQ
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVJJUaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVJJUaS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:30:18 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:395 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbVJJUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:30:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010202956.LKXS24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 16:29:56 -0400
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <864q7pdvcn.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "10 Oct 2005 12:29:12 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9922>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Related question.  I created "mybranch" to do the patch, but how
> can I have my repository now forget that mybranch was ever made?
> Is it sufficient to remove the branch link, and then type some "fsck"
> operation?

Removing non-current branch -- you may need to do -D instead of -d. 

$ git branch -d mybranch

> That's also a question in general... how can I remove a commit,
> knowing that I'd never refer to it again?  Or is disk space so cheap
> that it wouldn't make any difference anyway?

Removing from the tip of the current branch:

$ git reset HEAD^

Removing from the tip of non-current branch:

$ git update-ref mybranch mybranch^
