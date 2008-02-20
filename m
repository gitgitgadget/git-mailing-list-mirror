From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 16:52:43 -0800
Organization: Vyatta
Message-ID: <20080219165243.7de6cbf5@extreme>
References: <20080219140604.04afc91f@extreme>
	<20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
	<20080219152357.5ab397cf@extreme>
	<alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<20080219161517.34fd5878@extreme>
	<alpine.LFD.1.00.0802191635010.7833@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, skimo@liacs.nl,
	skimo@kotnet.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRdDI-0004p7-72
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761524AbYBTAw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761206AbYBTAwz
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:52:55 -0500
Received: from mail.vyatta.com ([216.93.170.194]:46652 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764548AbYBTAwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:52:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 511284F8051;
	Tue, 19 Feb 2008 16:52:49 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.332
X-Spam-Level: 
X-Spam-Status: No, score=-2.332 tagged_above=-10 required=5 tests=[AWL=0.167,
	BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qRv07izH7K8g; Tue, 19 Feb 2008 16:52:46 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id 797B34F804D;
	Tue, 19 Feb 2008 16:52:45 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802191635010.7833@woody.linux-foundation.org>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74487>

On Tue, 19 Feb 2008 16:47:15 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> > 
> > Don't be stupid, I am not trying be obstreperous, just fix the problem.
> 
> Umm. Stephen - this is the first time you even *describe* the problem.
> 
> Your previous emails were just "hey, submodules don't work, fix it".

No I abused a submodule and broke it, it isn't git's fault directly.

> Why do you then call Dscho stupid for pointing out that you never even 
> bothered to reveal any details of what your problem was?

The cause was a accidental push of the wrong tree up into a public
repository. So I manually went back and moved the original tree aside
and replaced it with a new tree that was at the point before the errant
push.

> 
> But it's not clear how you even got into that state to begin with. How did 
> your index get that confused? You said "I had to rewind one project back 
> to a known good state", but considering the output, it looks like you 
> didn't actually rewind it, but left it in some half-way state. 
> 
> A "git reset" should have reset the index, or you could probably have done 
> something like "git add <submodule>" to basically force the index entry 
> for just that submodule to the current state it had.
> 
> At a guess, it *looks* like you reset the submodules themselves, but never 
> reset the superproject.
> 
> 		Linus

The submodule is okay shape but the superproject isn't.
