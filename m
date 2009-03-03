From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: More on "fast foward"
Date: Tue, 3 Mar 2009 18:53:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031851090.6399@intel-tinevez-2-302>
References: <450196A1AAAE4B42A00A8B27A59278E709F0769A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:55:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeYpv-0000nJ-Df
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZCCRx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 12:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbZCCRxz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:53:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750968AbZCCRxz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 12:53:55 -0500
Received: (qmail invoked by alias); 03 Mar 2009 17:53:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp033) with SMTP; 03 Mar 2009 18:53:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eR7UOmu1epx2P/EhjkPYjqXeL0UEpQUsDZNanRG
	iXfmWeijoS8kEi
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F0769A@EXCHANGE.trad.tradestation.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112136>

Hi,

On Tue, 3 Mar 2009, John Dlugosz wrote:

> After I merged the release fixes back into the development branch, I was 
> surprised that push complained that it was not fast-forward.  I thought 
> someone must have added something since I looked, but no, my repository 
> matches exactly.  My new dev branch label is the immediate descendant of 
> the old one.  My new node has another ancestor as well, but so what? The 
> same changes, not recorded as a merge, would work without complaint.

I can only assume that something went wrong with the merge.  To be 
absolutely sure that your new tip of the branch is a descendant of the 
current tip on the remote side, do this:

	$ git show-branch $BRANCH $(git ls-remote $REMOTE $BRANCH)

where $BRANCH and $REMOTE are determined by your push command which should
look something like this:

	$ git push $REMOTE $BRANCH

The show-branch command should show you what Git assumes happened on both 
branches (the local and the remote one) since the branch point.

Ciao,
Dscho
