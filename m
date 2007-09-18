From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/5] More builtin-fetch fixes
Date: Tue, 18 Sep 2007 04:54:44 -0400
Message-ID: <20070918085444.GN3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:55:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXYrt-0001jx-6r
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbXIRIyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753407AbXIRIyw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:54:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52367 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755859AbXIRIyu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:54:50 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXYqv-00067U-Cd; Tue, 18 Sep 2007 04:54:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87E3120FBAE; Tue, 18 Sep 2007 04:54:44 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58551>

Yet another round of builtin-fetch fixes.  This series fixes the
latest breakage in `pu` for this topic along with an annoying
warning when using the http transport.

The third patch in the series is a behavior change for git-fetch.
The commit message discusses it in detail.  Junio and I kicked this
around on #git earlier this morning.

At this point myself and a few other experienced-with-Git coworkers
are running this builtin-fetch "in production" for all daily tasks.
We don't use *everything* that the tool supports as I did not know
about this breakage in branch.$name.merge until tonight when Junio
mentioned it, but for some of the really common cases we are quite
happy with builtin-fetch.  Especially its performance as we're
seeing speedups of 25x or more on Cygwin/Windows.

I still believe there's work yet to be done on this topic as I'm
quite sure the transfer.unpackLimit is not being honored.  I meant
to look at that tonight but wound up wasting all night and morning on
the 3rd patch of this series.  I will try to work on the unpackLimit
issue Tuesday or Wednesday this week.

-- 
Shawn.
