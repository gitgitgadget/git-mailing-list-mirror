From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
Date: Mon, 7 Aug 2006 22:38:09 +0300
Message-ID: <20060807193809.GA24013@mellanox.co.il>
References: <7vd5bc4czr.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 21:37:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAAuI-0007pW-Ls
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWHGTg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWHGTgz
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:36:55 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:55720 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932237AbWHGTgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 15:36:55 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id e4697d44.2458446768.40299.00-016.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 13:36:46 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Aug 2006 22:42:15 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  7 Aug 2006 22:38:09 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5bc4czr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 19:42:15.0609 (UTC) FILETIME=[95E1B290:01C6BA59]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25031>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Subject: Re: Multiple pulls from the same branch in .git/remotes/origin
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > I get remote linus_master properly fetched into local origin.
> > Two questions:
> 
> > 1. Isn't is possible to pull from the same remote branch into multiple local
> >    branches?
> 
> Currently, no.  The underlying git-fetch-pack makes sure you do
> not give the same branches twice on the command line.  I think
> what the code actually tries to do is to make sure each of the
> given refspecs is not ambiguous and matches something, but while
> doing so it marks the remote ref that matched ineligible to
> match again, which ends up showing the error message you saw.
> 
> It might not be too difficult to change it though.  This part of
> the code is relatively old and I do not remember the details
> offhand, other than I remember that the first time I saw it I
> had the same confused "Huh?  we do not let a ref fetched twice?"
> reaction ;-).

At least, fix the error message?

-- 
MST
