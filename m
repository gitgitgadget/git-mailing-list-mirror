From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Mon, 3 Dec 2007 21:34:40 -0500
Message-ID: <20071204023440.GD14735@spearce.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203040108.GS14735@spearce.org> <Pine.LNX.4.64.0712031146520.27959@racer.site> <20071204015108.GV14735@spearce.org> <Pine.LNX.4.64.0712040211270.27959@racer.site> <20071204022020.GA14735@spearce.org> <Pine.LNX.4.64.0712040224080.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNcn-00074L-Jj
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbXLDCeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXLDCep
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:34:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52423 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbXLDCep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:34:45 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IzNcF-0007xy-P7; Mon, 03 Dec 2007 21:34:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2088120FBAE; Mon,  3 Dec 2007 21:34:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712040224080.27959@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67000>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 3 Dec 2007, Shawn O. Pearce wrote:
> > Actually <n> wouldn't be so bad.  We could do something like:
> > 
> > 	GIT_INHERITED_LOCKS="<ref> <depth> <ref> <depth> ..."
> 
> I am somewhat wary of using environment variables in that context, since 
> the variables could leak to subprocesses, or (even worse), they could be 
> set inadvertently by the user or other scripts.

Sure.  But as bad as it is, its still more secure than the
"repository of record" that my day-job uses for its source code
tree (no, it doesn't use Git, and I wish it was as good as Visual
Source Suck).  </bad-joke>

I'd suggest also using something like getppid() to check the pid
against a pid in the env, and *gasp* maybe do a SHA-1 hash in there
or something to make it challening enough to fake that the average
user won't set it unless they really understand what they are doing.

-- 
Shawn.
