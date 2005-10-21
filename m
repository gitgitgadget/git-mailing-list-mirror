From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 21:44:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510212134570.5542@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwtk6vlqz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 21:47:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET2oR-0005Dp-Pi
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 21:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVJUToQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 15:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbVJUToQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 15:44:16 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4500 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965128AbVJUToP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 15:44:15 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 427C013F215; Fri, 21 Oct 2005 21:44:14 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 212DD9EF87; Fri, 21 Oct 2005 21:44:14 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C48379EF72; Fri, 21 Oct 2005 21:44:13 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7790513F1D1; Fri, 21 Oct 2005 21:44:13 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtk6vlqz.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10443>

Hi,

On Fri, 21 Oct 2005, Junio C Hamano wrote:

> We send "haves" in order, without 2^n skipping nor binary search
> backtrack.  Instead, add a logic in upload-pack to see if a
> newly arrived "have" is a direct child of anything that we have
> already heard about, and mark to ignore them.  We need to add
> that MAX_HAS counting to fetch-pack side for this to work.

Yes. This makes it more simple, and is very efficient in the common case. 
How about increasing MAX_HAS to 64?

Adapted patch for fetch-pack coming soon.

Ciao,
Dscho
