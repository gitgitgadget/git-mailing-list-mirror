From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] remote show: fix the -n option
Date: Mon, 9 Jun 2008 21:19:13 -0400
Message-ID: <20080610011913.GA11793@spearce.org>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer> <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr+ml.git@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5sWz-0002TT-Aa
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 03:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309AbYFJBTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 21:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYFJBTT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 21:19:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46911 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYFJBTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 21:19:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K5sVs-0004uN-Q9; Mon, 09 Jun 2008 21:19:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0C09320FBAE; Mon,  9 Jun 2008 21:19:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84468>

Junio C Hamano <gitster@pobox.com> wrote:
> At least I care enough to point out that I think you are wrong in this
> case.  "show -n" in the scripted version was never about "dry-run" but
> was about "no-query".
...
> I am CC'ing Shawn who authored 859607d (Teach 'git remote' how to cleanup
> stale tracking branches., 2007-02-02) to give him a chance to point out
> why I am wrong in saying "prune -n" is nonsense.  Maybe there is a valid
> use case for that option, even though I do not see one.

I agree with you Junio.  "prune -n" is nonsense.  You cannot know
what to remove locally that the remote no longer advertises without
querying the remote.

So "prune -n" is nonsense and should issue an error.  "prune --dry-run"
is different and means "query, show what you would delete, but don't
actually delete".

Likewise "show --dry-run" is nonsense.  What does it mean to show
what would show without showing it?  Just show it.   :)

-- 
Shawn.
