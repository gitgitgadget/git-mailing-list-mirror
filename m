From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why can't git-rebase back up?
Date: Fri, 17 Feb 2006 23:39:26 -0800
Message-ID: <7vhd6xru8h.fsf@assigned-by-dhcp.cox.net>
References: <20060217153434.26359.qmail@science.horizon.com>
	<43F5FA10.5020605@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux@horizon.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 08:39:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAMgw-0005we-8w
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 08:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWBRHj3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 02:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWBRHj3
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 02:39:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:5779 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750978AbWBRHj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 02:39:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218073746.WTYM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 02:37:46 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16397>

Andreas Ericsson <ae@op5.se> writes:

> The order of precedence works as such:
> .git/<anchor-name>
> .git/refs/<anchor-name>
> .git/refs/tags/<tag-name>
> .git/refs/heads/<branch-name>
> sha1, with git magic to allow abbreviations
>
> This is why you can't sanely have a branch named HEAD.

Actually, you should be able to sanely have a branch named HEAD.

When git barebone Porcelain tools _expect_ branch name from the
user (not just a random committish), they _ought_ to prefix
"refs/heads" in front of it, exactly in order to help
disambiguate things.

Otherwise you have spotted a bug, so please send in a fix.

It is however a different story if you can keep your sanity if
you created a branch called HEAD.  You have to remember to
explicitly say refs/heads/HEAD, where a command wants any
committish or treeish.
