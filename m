From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] support older versions of libcurl
Date: Fri, 29 Jul 2005 12:23:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507291220350.5849@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507281648390.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll3qqrhu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 12:29:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyS78-0006nw-8F
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 12:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVG2KXn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 06:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVG2KXk
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 06:23:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60133 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S262555AbVG2KXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 06:23:30 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6C74EE25B8; Fri, 29 Jul 2005 12:23:27 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5025D9143D; Fri, 29 Jul 2005 12:23:27 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3D7F2913E7; Fri, 29 Jul 2005 12:23:27 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 268D3E25B8; Fri, 29 Jul 2005 12:23:27 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll3qqrhu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Some newer features of libcurl are used which are not strictly necessary
> > for http-pull. Use them only if libcurl is new enough to know about them.
>
> Do you need to check against that many versions?  Especially
> cleanup and init not depending on the same version number looks
> really suspicious.

I investigated the issue using curl's CVS. The different version numbers
are easily explained: While curl_global_init is defined starting from
0x070704, CURL_GLOBAL_ALL is only defined starting from 0x070800.

> Assuming that the answer is still yes, how about doing things
> this way instead?

Looks better.

Ciao,
Dscho
