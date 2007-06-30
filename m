From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Correct usages of sed in git-tag for Mac OS X
Date: Sat, 30 Jun 2007 03:03:07 -0400
Message-ID: <20070630070307.GP32223@spearce.org>
References: <20070630064247.GA18041@spearce.org> <7vzm2ic4g8.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 09:03:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4WzB-0000TK-Dj
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 09:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbXF3HDL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 03:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbXF3HDL
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 03:03:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51667 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbXF3HDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 03:03:10 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I4Wz4-0006Yi-Sc; Sat, 30 Jun 2007 03:03:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 446B220FBAE; Sat, 30 Jun 2007 03:03:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vzm2ic4g8.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51198>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > These major Git functions are much more important than
> > saving two or three lines of a simple sed script.
> 
> The size of the script does not worry me.  The number of sed
> processes originally did, but the old code also had two
> invocations of sed, and I do not think you can implement the
> "strip the header, and then emit ${LINES} lines" behaviour
> without doing them in separate sed anyway, so I think this is
> fine.  But it makes me wonder why we are not using awk ;-)

Or perl.  ;-)

But the patch I just sent is sane.  And it all will hopefully go
away when Carlos has his C version complete and passing the very
large test suite he recently contributed.  So not really worth
worrying about now that its working properly.

But yea, I changed the script the way I did to keep the number of sed
processes per tag equal to what we had before.  Its not any better,
but its also not any worse and it at least runs on more systems.

-- 
Shawn.
