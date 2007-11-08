From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 8 Nov 2007 03:04:46 -0500
Message-ID: <20071108080446.GJ14735@spearce.org>
References: <20071107024118.GA11043@spearce.org> <7vsl3iefoj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Nu-0005K9-0c
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbXKHIEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXKHIEu
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:04:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60900 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbXKHIEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:04:50 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq2Nb-0008Mu-0G; Thu, 08 Nov 2007 03:04:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0104320FBAE; Thu,  8 Nov 2007 03:04:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsl3iefoj.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63953>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Back in e3c6f240fd9c5bdeb33f2d47adc859f37935e2df Junio taught
> > git-fetch to avoid copying objects when we are fetching from
> > a repository that is already registered as an alternate object
> > database.  In such a case there is no reason to copy any objects
> > as we can already obtain them through the alternate.
> 
> The regression the patch fixes should be testable with a
> script.  Please have a new test for it.

Hmmph.  t5502-quickfetch should have covered this.  It obviously
wasn't testing the right thing here.  I'll figure out why and post
a patch to fix t5502.

-- 
Shawn.
