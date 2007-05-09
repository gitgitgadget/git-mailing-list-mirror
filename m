From: David Miller <davem@davemloft.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 15:02:56 -0700 (PDT)
Message-ID: <20070509.150256.59469756.davem@davemloft.net>
References: <7vvef2t36n.fsf@assigned-by-dhcp.cox.net>
	<20070509.130614.15589957.davem@davemloft.net>
	<7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu May 10 00:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluFR-0006kI-58
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbXEIWC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbXEIWC4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:02:56 -0400
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59218
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752694AbXEIWCz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 18:02:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 8F5C6290133;
	Wed,  9 May 2007 15:02:56 -0700 (PDT)
In-Reply-To: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46797>

From: Junio C Hamano <junkio@cox.net>
Date: Wed, 09 May 2007 14:48:38 -0700

> > + no_checkout=yes
> > + use_separate_remote=
> > + test -z ''
> > + origin=origin
> > ++ get_repo_base ../torvalds/linux-2.6.git
> > + base=
> 
> This part puzzles me.  The only way I could reproduce this was:
> 
> $ ls -F victim victim.git
> ls: victim: No such file or directory
> victim.git:
> ./   HEAD	config	 description	       hooks/  lost-found/  refs/
> ../  branches/	config~  gitcvs.master.sqlite  info/   objects/     remotes/
> $ mkdir j
> $ cd j
> $ git clone --bare -l -s -n ../victim new.git
> 
> That is, I did not have ../victim but I did have ../victim.git/
> repository, and I gave the former to "git clone".
> 
> But that suggests that you do not have ../torvalds/linux-2.6.git
> directory but instead have ../torvalds/linux-2.6.git.git/ which
> sound a bit insane.
> 
> Puzzled...

This deeply puzzles me too.

I'm just not going to go into my git directory using that
symlink in my home directory any more. :-)
