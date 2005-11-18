From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Give python a chance to find "backported" modules
Date: Fri, 18 Nov 2005 14:18:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181415380.28109@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0511160331150.15130@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Nov 18 14:21:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed69L-0000vx-Fy
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 14:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVKRNSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 08:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKRNSu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 08:18:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:2510 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030371AbVKRNSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 08:18:50 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id BD72E13FEE6
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:18:48 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 86958B5261
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:18:48 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 47405B524A
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:18:36 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 27E8E14002C
	for <git@vger.kernel.org>; Fri, 18 Nov 2005 14:18:36 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0511160331150.15130@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12231>

Hi,

On Wed, 16 Nov 2005, Johannes Schindelin wrote:

> python 2.2.1 is perfectly capable of executing git-merge-recursive,

Well, no.

Actually, my tests ran, but only because they were trivial, or next to it. 
In line 477 of git-merge-recursive.py, there is a reference to an __iter__ 
member of a list (the recs object). Python 2.2.1 does not know about that, 
but rather wants to do the iteration over the collection iter(recs). 
However, this does not work, as some of the contained objects have to be 
skipped.

So I bit the bullet, compiled Python 2.4.2, and it works. Sorry for the 
noise.

Ciao,
Dscho
