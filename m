From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Joining a fixed archive with its continuation
Date: Fri, 1 Sep 2006 16:37:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609011634370.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F81FE5.1040509@arces.unibo.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 16:38:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJA9c-0001ZF-Uw
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 16:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWIAOhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 10:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIAOhw
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 10:37:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:29846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932094AbWIAOhw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 10:37:52 -0400
Received: (qmail invoked by alias); 01 Sep 2006 14:37:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 01 Sep 2006 16:37:50 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergio Callegari <scallegari@arces.unibo.it>
In-Reply-To: <44F81FE5.1040509@arces.unibo.it>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26302>

Hi,

On Fri, 1 Sep 2006, Sergio Callegari wrote:

> > P.S.: Of course, if you do not insist on a super clean history, you can fake
> > a merge. Just put <40-hex-chars-old> into .git/MERGE_HEAD and commit. This
> > will pretend that your new head and your old head were merged, and the
> > result is the new head. This _should_ even work with git-bisect, but it is
> > slightly ugly.
> 
> Before I try, can you better explain me what shall go on in this case?
> The man page of commit actually does not say much about commit behavior
> during a merge (i.e. with MERGE_HEAD set).

A merge commit is almost the same as a regulaar commit; the only 
difference is that you provide multiple parents to a merge commit. The 
first parent is always the current head. And the other parents are in 
.git/MERGE_HEAD (one commit SHA1 per line).

So, putting the fixed-master SHA1 into .git/MERGE_HEAD pretends that the 
fixed-master merged with the current master is the current master.

>From a view point of correctness, this is _wrong_. _But_ it would work 
correctly with pull/push/bisect.

Ciao,
Dscho
