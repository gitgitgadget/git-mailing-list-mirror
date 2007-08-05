From: Sean <seanlkml@sympatico.ca>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 12:40:50 -0400
Message-ID: <20070805124050.c1345ec9.seanlkml@sympatico.ca>
References: <854pjfin68.fsf@lola.goethe.zz>
	<20070804092933.aaec6d52.seanlkml@sympatico.ca>
	<85ejijgzzg.fsf@lola.goethe.zz>
	<20070805100532.GG12507@coredump.intra.peff.net>
	<85172807-B7EB-47DD-813E-FAF5894E1190@zib.de>
	<20070805110200.GA18083@coredump.intra.peff.net>
	<85tzre8b4w.fsf@lola.goethe.zz>
	<20070805115208.GA19734@coredump.intra.peff.net>
	<85fy2y89kb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 18:41:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHjAD-0006lR-RG
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 18:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757291AbXHEQlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbXHEQlG
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 12:41:06 -0400
Received: from bay0-omc2-s19.bay0.hotmail.com ([65.54.246.155]:53070 "EHLO
	bay0-omc2-s19.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756199AbXHEQlF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 12:41:05 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]) by bay0-omc2-s19.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 5 Aug 2007 09:41:03 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 5 Aug 2007 09:41:02 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IHjA5-0000z1-9b; Sun, 05 Aug 2007 12:41:01 -0400
In-Reply-To: <85fy2y89kb.fsf@lola.goethe.zz>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 05 Aug 2007 16:41:02.0816 (UTC) FILETIME=[69246600:01C7D77F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55040>

On Sun, 05 Aug 2007 14:12:04 +0200
David Kastrup <dak@gnu.org> wrote:

> Well, that is pretty much exactly what I find fascinating: that the
> behavior is arbitrary and undocumented enough that one can't deduce it
> either by logic or by recollection or by documentation, but just by
> reading the code.
> 
> Usually code is supposed to implement a design, but here it seems
> rather like the design, if there is any, is to be abstracted from the
> code.

To me it's yet another example of bad UI design in Git.   Git already
had remote-tracking branches, which conceptually were relatively easy
to explain.  Instead of leveraging this foundation, and adding the
ability for local branches to pick a default remote-tracking branch
to use for merging, Git instead implemented direct remote tracking
from local branches.  After having read the thread Jeff mentioned
earlier i'm still at a loss as to how this decision was justified.

To make it even worse, it turns out that this command:

   $ git branch --track  mybranch  remote/branch

Does _NOT_ tell git to setup mybranch to track remote/branch.  Read that
command line again and then scratch your head as to how anyone without
deep Git knowledge is supposed to infer its real meaning without being
told to read previous email threads etc.   This also means the feature
can't be used to say:

   $ git branch --track mybranch  otherlocalbranch

Being a fan of Git, it's frustrating to see that more weight is not
paid to such UI concerns.   Especially when the concern _was_ raised
when the feature was first added.

Sean
