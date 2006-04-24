From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 21:21:33 +0200
Organization: M38c
Message-ID: <20060424192133.GA6446@nospam.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain> <20060424151901.GA2663@adacore.com> <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 21:21:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY6d3-0000mB-FO
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 21:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWDXTVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWDXTVp
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 15:21:45 -0400
Received: from post-23.mail.nl.demon.net ([194.159.73.193]:37837 "EHLO
	post-23.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751146AbWDXTVo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Apr 2006 15:21:44 -0400
Received: from wingding.demon.nl ([82.161.27.36]:37304)
	by post-23.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FY6cs-000Dk7-L0; Mon, 24 Apr 2006 19:21:39 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FY6cn-0007dZ-Sw; Mon, 24 Apr 2006 21:21:34 +0200
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19103>

On Mon, Apr 24, 2006 at 11:57:38AM -0400, Nicolas Pitre wrote:
> On Mon, 24 Apr 2006, Geert Bosch wrote:
> > 
> > The comparison is a bit between a O(n^2) sort that is fast on small
> > or mostly sorted inputs (but horrible on large ones) and a more
> > complex O(nlogn) algorithm that is a bit slower for the simple
> > cases, but far faster for more complex cases.
> 
> Indeed.  And since the primary goal for GIT is to manage relatively 
> small files with relatively few differences then we have to optimize for 
> that case while trying to simply limit the dammage in the other cases.

Like others (the large-Maildir-storage thread comes to mind), I am
looking into storing more diverse data (say, $HOME) into git repo's
and I would mind the O(n log n) instead of O(n^2) where the constant
factor of the first is larger than the constant factor of the second.

...but then again, I'm just a user ;)


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
