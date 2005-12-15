From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 23:41:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512152339530.4962@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vacf2p320.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 23:44:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En1n1-00042K-00
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 23:41:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVLOWl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 17:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLOWl2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 17:41:28 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:24525 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750757AbVLOWl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 17:41:28 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2267513C882; Thu, 15 Dec 2005 23:41:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0B05D9DE1B; Thu, 15 Dec 2005 23:41:27 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EAAB89DDBD; Thu, 15 Dec 2005 23:41:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D52DD13C882; Thu, 15 Dec 2005 23:41:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacf2p320.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13713>

Hi,

On Thu, 15 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +		/* do not allow "HEAD" as ref name */
> > +		if (ch == 'H' && (!strcmp(cp, "EAD") ||
> > +					!strncmp(cp, "EAD/", 4)))
> 
> Why forbid HEAD in the middle, like "refs/heads/HEAD/frotz"?
> Confusion avoidance?

Exactly.

> We might want to forbid anything that matches /^.*_?HEAD$/ to catch
> ORIG_HEAD for example, though.

Okay, I think this is what *I* would want to be illegal:

HEAD,
ORIG_HEAD,
FETCH_HEAD
MERGE_HEAD

Others? Or should I really test for just *anything* ending in _HEAD 
besides HEAD itself?

Ciao,
Dscho
