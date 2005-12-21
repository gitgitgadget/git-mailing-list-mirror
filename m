From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 23:20:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net> <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek465cev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 23:20:45 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCJz-000315-0W
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVLUWU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVLUWU2
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:20:28 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:23214 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964832AbVLUWU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:20:27 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ACFA213FC1F; Wed, 21 Dec 2005 23:20:26 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8DF669E26A; Wed, 21 Dec 2005 23:20:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 78F7F9E232; Wed, 21 Dec 2005 23:20:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3AE1C13FC1F; Wed, 21 Dec 2005 23:20:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek465cev.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13906>

Hi,

On Wed, 21 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you don't use git-shell, because the same machine is used for other 
> > purposes, it makes sense to introduce
> >
> > 	[core]
> > 		umask = 0002
> 
> I agree the setting should not be limited to git-shell, but I do
> not think setting "umask" from git configuration is the right
> way either.  For files and directories under $GIT_DIR, maybe
> imposing the policy git configuration file has is OK, but I
> think honoring the user's umask is the right thing for working
> tree files.

As we worked out in another thread, you should not have a working 
directory when you write-share the repository.

So, I tend to say: use core.umask only in shared setups (in which you 
should not checkout files unless you know exactly what you are doing).

Hmm? (I mean to imitate Linus here, not refer to hidden Markov models.)

Ciao,
Dscho
