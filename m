From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Thu, 17 Nov 2005 22:44:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511172242390.18285@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511171622450.14287@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 22:48:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrYC-0000fV-98
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 22:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVKQVoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 16:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVKQVoI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 16:44:08 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:38585 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751353AbVKQVoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 16:44:07 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6443213FCD6; Thu, 17 Nov 2005 22:44:06 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 01D38B5231; Thu, 17 Nov 2005 22:44:06 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D3B5CB5215; Thu, 17 Nov 2005 22:44:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8CF9F13FCD6; Thu, 17 Nov 2005 22:44:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0511171622450.14287@localhost.localdomain>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12157>

Hi,

On Thu, 17 Nov 2005, Nicolas Pitre wrote:

> On Thu, 17 Nov 2005, Linus Torvalds wrote:
> 
> > NOTE! The parsing is strictly sequential, so if you do
> > 
> > 	"one day before last thursday"
> > 
> > it will _not_ do what you think it does. It will take the current time, 
> > subtract one day, and then go back to the thursday before that.
> 
> Maybe if you applied the different time units in decreasing size that 
> would do the trick?  e.g. months have precedence over weeks, weeks over 
> weekdays, weekdays over days, etc.

Or even better: make it relative until you find an absolute reference. 
I.e. "one day" will be 1 * 86400, and if you then parse "before", it
will get negative, then "last thursday" will be the absolute reference.

'f course, "one day before last thursday in september" will be a PITA.

Ciao,
Dscho
