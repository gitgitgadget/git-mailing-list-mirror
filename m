From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config.c: remove unnecessary header in minimum configuration
 file.
Date: Mon, 5 Dec 2005 22:05:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512052202300.12016@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7jawmkpo.fsf@assigned-by-dhcp.cox.net> <7vu0docrqz.fsf@assigned-by-dhcp.cox.net>
 <4394255D.1030009@op5.se> <Pine.LNX.4.63.0512052124400.4026@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vek4rb6vc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 22:10:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjNXq-0004CR-GR
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 22:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVLEVGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 16:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVLEVGB
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 16:06:01 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1749 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751469AbVLEVGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 16:06:00 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5925213F748; Mon,  5 Dec 2005 22:05:59 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3EE979F55D; Mon,  5 Dec 2005 22:05:59 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2BF6C9DBE3; Mon,  5 Dec 2005 22:05:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F96F13F748; Mon,  5 Dec 2005 22:05:59 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek4rb6vc.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13232>

Hi,

On Mon, 5 Dec 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, you should also remove the header which is generated in init-db.c 
> > when it is determined that the file system does not respect the executable 
> > flag.
> 
> I suspect that code is not there anymore.

Oops. I missed that one (probably because it did not say anything about 
the filemode test in the shortlog).

However, reading the code I am not satisfied. If there is no template for 
the config file, it does not test the filemode at all.

In fact, it reverses my design: I did *not* touch an existing config file, 
but only created one if none existed. And if the filemode was not set, I 
threw the config file away.

Ciao,
Dscho
