From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Completion: Hint whether amend is the right thing to do.
Date: Wed, 28 May 2008 19:16:22 -0400
Message-ID: <20080528231622.GL30245@spearce.org>
References: <200805281608.02000.robin.rosenberg.lists@dewire.com> <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1UtU-0007uf-JG
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbYE1XQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303AbYE1XQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:16:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36995 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbYE1XQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:16:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K1UsQ-0000Sx-EA; Wed, 28 May 2008 19:16:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9D56A20FBAE; Wed, 28 May 2008 19:16:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v63sywhkr.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83144>

Junio C Hamano <gitster@pobox.com> wrote:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > When you get a conflict during interactive rebase the next
> > thing to do is not to amend, but to continue the rebase.
> > With this change you get a reminder in the prompt.
...
> Does this mean that it would help reduce mistakes if "git commit --amend"
> noticed the presense of .dotest-merge but absense of .dotest-merge/amend
> and refused to operate, I have to wonder?

Yea, even though rebase and commit are two different tools we
don't want the user to amend in the middle of a failed conflict
from rebase.  Adding the safety valve to commit --amend makes
more sense to me than teaching bash to show you the state.  Not
all of our users use bash.  Not all of our bash using users use
the bash completion package, or the _git_ps1 function we ship.
Etc.

I'd rather see the amend safety net than the bash prompt change.

-- 
Shawn.
