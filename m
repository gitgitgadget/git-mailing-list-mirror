From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Branch metainformation
Date: Thu, 20 Apr 2006 13:41:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604201335070.13022@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e27dqv$u6f$1@sea.gmane.org>
 <Pine.LNX.4.63.0604201131240.9099@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtdkzh1u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 13:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWXXK-0002NE-7k
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 13:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWDTLlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 07:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDTLlT
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 07:41:19 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39580 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750735AbWDTLlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 07:41:18 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B65E6CBC;
	Thu, 20 Apr 2006 13:41:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AA6B1CB3;
	Thu, 20 Apr 2006 13:41:17 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 94E2FBA3;
	Thu, 20 Apr 2006 13:41:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtdkzh1u.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 20 Apr 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, this all depends on my (rejected) patch to move the remotes 
> > information into the config file.
> 
> You seem to keep saying rejected, but IIRC you did not finish it

I had another impression: people seemed less than enthusiastic about it. 
But maybe I misunderstood, and only the automatic rewriting part was 
disliked. I'll try to find time to clean the patch and resend it...

> While we are talking about per branch property, some issues
> raised on the list (and #git) recently would be helped by a
> convention (and perhaps some core side support) for per-branch
> property.  Here is a short list.
> 
>  + When I am on branch X, I would want "git pull" to pull
>    (i.e. fetch and merge) from repository Y, not always "origin".
> 
>  + When I am on branch X, I would want "git push" to push to
>    repository Y (we do not even use "origin" as the default for
>    push).
> 
>  + This branch is not to be rebased (you could do this using
>    custom pre-rebase hook but having a standard "branch property"
>    would make it easy for such a hook to decide.
> 
>  - Do not merge and base your work on this branch -- this is
>    "view only" and unstable (e.g. "pu" in git.git).
> 
> If we were to do a remote to config reorganization (for that we
> need a migration plan and a period that we support both), the
> per-branch configuration should be designed to support at least
> the commonly asked ones.

Hmm. ATM the syntax I use is

	[remote.company]
		url = company.com:gits/daproject
		pull = origin
		push = master

Some bits of your wishes could be written as

	[branch.pu]
		rebase = no
		pull = company

Ciao,
Dscho
