From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack
 extension
Date: Tue, 25 Oct 2005 23:02:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051025204754.GA8030@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Oct 25 23:03:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUVw2-0004Hj-7I
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVJYVCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVJYVCP
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:02:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:39814 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932381AbVJYVCP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 17:02:15 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id CD6E413F1B4; Tue, 25 Oct 2005 23:02:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B11D4B0D40; Tue, 25 Oct 2005 23:02:13 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 82CE6B0CF8; Tue, 25 Oct 2005 23:02:13 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 60B7013F1B4; Tue, 25 Oct 2005 23:02:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20051025204754.GA8030@steel.home>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10617>

Hi,

On Tue, 25 Oct 2005, Alex Riesen wrote:

> Johannes Schindelin, Sun, Oct 23, 2005 03:40:13 +0200:
> > This patch concludes the series, which makes 
> > git-fetch-pack/git-upload-pack negotiate a potentially better set of 
> > common revs. It should make a difference when fetching from a repository 
> > with a few branches.
> 
> This broke git-pull for me (the local one):
> 
>     /d/e/f.git$ git-pull
>     fatal: bad pack file
>     fatal: git-unpack-objects died with error code 128
>     Fetch failure: /a/b/c/.git
> 
> > applies-to: 6b4b7d9acf60aa99d961b599f37d0c824be79e27
> > 9adb6b3971e7daa79221d7dbe05b66327b266b86
> ...
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 3a903c4..57602b9 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> 
> Reverting just fetch-pack.c part of the patch helps.

Could you please try the patch I sent with the subject "[PATCH] 
fetch/upload: Fix corner case with few revs"? Your output looks exactly 
like what I fixed with that patch.

Ciao,
Dscho
