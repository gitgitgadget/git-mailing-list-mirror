From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 16:35:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805181634100.30431@racer>
References: <20080518152337.GB3058@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Jeff King <peff@peff.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 17:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxkvu-0001N5-Ey
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 17:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYERPfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 11:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754241AbYERPfc
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 11:35:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:41036 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754220AbYERPfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 11:35:32 -0400
Received: (qmail invoked by alias); 18 May 2008 15:35:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp006) with SMTP; 18 May 2008 17:35:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CcPI/CeVCpIG3AUY7sFF3LAHdv5FZU9mOPzNVV3
	+uDpD5eYaSILrX
X-X-Sender: gene099@racer
In-Reply-To: <20080518152337.GB3058@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82391>

Hi,

On Sun, 18 May 2008, Alex Riesen wrote:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Are you sure that you want the commit message to read "t3701 fails if 
core.filemode disabled"?  Not rather "skip t3701 if core.filemode is 
disabled"?

> ---
> 
> This is on Cygwin, yes. I have the core.filemode disabled in
> ~/.gitconfig. How about stopping the test before the failing portion
> (only the last two fail, below)?
> 
> $ ./t3701-add-interactive.sh -d -v
> ...
> * expecting success:
>         git reset --hard &&
>         echo content >>file &&
>         chmod +x file &&
>         printf "n\\ny\\n" | git add -p &&
>         git show :file | grep content &&
>         git diff file | grep "new mode"
> 
> HEAD is now at ddca8ca commit
> ddca8caf8c92841fca6311cf3ee839dd304f353d
> --
> diff --git a/file b/file
> index 180b47c..b6f2c08 100644
> --- a/file
> +++ b/file
> @@ -1 +1,2 @@

Are you really, really, really sure you want to have that in the commit? 
After all, it is _after_ the "---", and the line  _does_ begin with "diff 
--git".

Ciao,
Dscho
