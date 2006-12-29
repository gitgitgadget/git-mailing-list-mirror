From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] xdl_merge(): fix a segmentation fault when refining conflicts
Date: Thu, 28 Dec 2006 23:16:26 -0500
Message-ID: <20061229041626.GA12072@spearce.org>
References: <20061227041644.GA22449@spearce.org> <Pine.LNX.4.63.0612271214120.19693@wbgn013.biozentrum.uni-wuerzburg.de> <87fyb11ouy.fsf@wine.dyndns.org> <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 05:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H09Ai-00084I-HX
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 05:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbWL2EQf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 23:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbWL2EQf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 23:16:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60505 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbWL2EQf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 23:16:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H099r-000712-Sd; Thu, 28 Dec 2006 23:15:51 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 48BA120FB65; Thu, 28 Dec 2006 23:16:27 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612281710350.19693@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35578>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 	Thank you Alexandre! I looked for the bug for quite some time, but 
> 	was never close to the real culprit.

Thanks for fixing this!
 
> +<<<<<<< orig.txt
> +=======
> +Nam et si ambulavero in medio umbrae mortis,
> +non timebo mala, quoniam TU mecum es:
> +virga tua et baculus tuus ipsa me consolata sunt.
> +>>>>>>> new5.txt

As a side note I lately have noticed that xdl_merge is producing a
conflict like the above when one branch added the lower half and
the other branch didn't change anything in the area.

I haven't spent any time to try to reproduce it, or to see if RCS'
merge utility would automatically merge the file without producing
a conflict.  But right now it does seem like xdl_merge is producing
conflicts when I didn't think it should be.

-- 
Shawn.
