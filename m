From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:27:47 -0400
Message-ID: <20060920212747.GB24415@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org> <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:28:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9bm-00087c-4P
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWITV1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWITV1v
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:27:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22229 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932128AbWITV1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:27:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ9bY-00068p-9L; Wed, 20 Sep 2006 17:27:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7EAFF20E48E; Wed, 20 Sep 2006 17:27:47 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609202321390.19042@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27407>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 20 Sep 2006, Shawn Pearce wrote:
> 
> > Of course an update hook finally took care of the problem, but having
> > non fast-forward pushs be permitted on a shared, bare repository
> > by default is interesting to say the least.  :-)
> 
> Unfortunately, it is send-pack making the decision on the client side, not 
> receive-pack on the server side, the latter of which knows if the server 
> side is shared or not.

Huh?

The server side update hook is given the old and new value of
the ref by receive-pack; if it exists with a non-zero status the
update fails.

The server side could also check if the current value in the ref
(if it exists) is contained within the new value of the ref.  Yes,
I know it doesn't today, but the point is it could.  And I was
saying maybe it should when there is no update hook present.

-- 
Shawn.
