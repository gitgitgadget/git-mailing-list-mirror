From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Sun, 25 May 2008 21:49:05 -0400
Message-ID: <20080526014904.GZ29038@spearce.org>
References: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl> <7vskw7jh7c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 26 03:50:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Rr4-0006oa-6m
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 03:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbYEZBtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 21:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbYEZBtP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 21:49:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47235 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYEZBtO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 21:49:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0RpX-0006Hw-Mp; Sun, 25 May 2008 21:48:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4C1720FBAE; Sun, 25 May 2008 21:49:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vskw7jh7c.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82888>

Junio C Hamano <gitster@pobox.com> wrote:
> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
> > According to the git-fast-import man-page, you can only put a single
> > committish per merge: line, like this:
> >
> >   merge :10
> >   merge :11
> >
> > However, git-fast-export puts all parents on a single line, like this:
> >
> >   merge :10 :11
> >
> > This may be fine with git-fast-import,...
> 
> Is it fine for even git-fast-import?  fast-import.c: parse_merge() seems
> to suggest that it also wants one parent per "merge " line.

fast-import wants the same as bzr-fast-import; one parent per
merge line.  If git-fast-import was doing anything with multiple
per line it was probably dropping everything after the first.  :-(

This was a bug in fast-export; I'm glad Pieter has fixed it.

-- 
Shawn.
