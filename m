From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Mon, 12 Sep 2005 01:15:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509120113380.10414@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
 <7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0509111153380.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 01:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEb2x-0000a4-2x
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 01:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVIKXPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 19:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVIKXPg
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 19:15:36 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45525 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750985AbVIKXPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 19:15:36 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2FA04E23F7; Mon, 12 Sep 2005 01:15:35 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 10C65B2D18; Mon, 12 Sep 2005 01:15:35 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E36C858FE3; Mon, 12 Sep 2005 01:15:34 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D2CF3E23F7; Mon, 12 Sep 2005 01:15:34 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8339>

Hi,

On Sun, 11 Sep 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 26 Aug 2005, Junio C Hamano wrote:
> >
> >> Johannes, what do you think, as the original advocate of "push in
> >> reverse"?
> >
> > I'm fine with it.
> 
> Wow, blast from the past ;-).

Sorry, I tried to relax for two weeks. That didn't work, though (pun 
intended).

> > Although it might make more sense to check for dirty state, and 
> > fast-forward only for a clean state (together with a checkout of the new 
> > HEAD).
> 
> Yes, but the issue becomes how we can reliably tell if a
> repository is naked or has an associated working tree.  I've
> seen people rsync only .git subdirectory of their live working
> tree to publish to a public repository, which means their pulic
> repository has <project>.git/index file, so it is kind of
> tricky.

I think it is easy to discern the two states "up to date checkout" and 
"dirty checkout or no checkout at all". But then, you're right: git fetch 
should not touch the working copy.

Ciao,
Dscho
