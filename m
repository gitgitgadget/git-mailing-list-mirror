From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git reveals a bug in (some versions) BSD diff
Date: Fri, 12 Aug 2005 18:04:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508121801310.26333@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508121424500.24891@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vd5ojxiny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 18:06:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3c1A-0003Ik-5q
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVHLQEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVHLQEV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:04:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44194 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751212AbVHLQEU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:04:20 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7A44FE2513; Fri, 12 Aug 2005 18:04:19 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 63EA59CC79; Fri, 12 Aug 2005 18:04:19 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 50FFB9972E; Fri, 12 Aug 2005 18:04:19 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4428FE2513; Fri, 12 Aug 2005 18:04:19 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ojxiny.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 12 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Note the missing "\ No newline at end of file". The same happens on 
> > sourceforge's compile farm's OS 10.1 server, but not on its OS 10.2 
> > server.
> >
> > How to go about that? Silently ignore the missing line in apply.c? Force 
> > users to update their diff to a sane version?
> 
> Hmph.  We could tackle this two ways.  We probably _could_
> special case the trailing newline case if this problem is
> widespread, but a more general solution would be to teach
> git-apply '--fuzz'.  On the other hand, we could configure to
> use gdiff (or whatever GNU diff is called on those hosts with
> broken diff command) at the build time.  Probably it would be
> the bast to have an explicit option --fuzz to git-apply.

I'd prefer to deprecate that diff program by telling so in the test. 
Something along the lines "blabla. If this fails, chances are you have a 
borked diff. Try GNU diff..."

Ciao,
Dscho

BTW: On my system, gdiff does not exist.
