From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Importing from a patch-oriented SCM
Date: Fri, 19 Aug 2005 10:29:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508191023570.11916@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <46a038f9050819000417ed436e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 10:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E62G5-0004ln-4Y
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 10:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbVHSI3m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVHSI3m
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 04:29:42 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:62956 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932472AbVHSI3l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 04:29:41 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D791B13DCA4; Fri, 19 Aug 2005 10:29:40 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BE7B899D3B; Fri, 19 Aug 2005 10:29:40 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ACBE399CF4; Fri, 19 Aug 2005 10:29:40 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5D3BB13DCB9; Fri, 19 Aug 2005 10:29:40 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050819000417ed436e@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 19 Aug 2005, Martin Langhoff wrote:

> Each patchset has a unique identifier, and can carry metadata with the
> identifiers of the patches it "includes". If you are using gnu arch,
> when you merge across branches, it'll know to skip a particular
> patchset if it has been applied already. AFAICT there is no such
> concept in GIT, and I wonder what to do with all this metadata about
> merges.

You should include the metadata in the commit object. If the information 
is about parents, they should be parents in git, too. If the information 
is something else, you should convert it to readable text and put it in 
the comment part of the commit object.

> If I remember correctly, Junio added some stuff in the merge & rebase
> code that will identify if a particular patch has been seen and
> applied, and skip it even if it's a bit out of order.

The usual way of git is to use a 3-way merge: given a common ancestor, try 
to apply the changes between the ancestor and the second branch to the 
first branch. And yes, this does not take history into account. 
Originally, I wanted to write an "intelligent" merge, which turns the 
history into patches and tries to merge these, but ultimately I got 
convinced that this is too complicated to be worthwhile.

Ciao,
Dscho
