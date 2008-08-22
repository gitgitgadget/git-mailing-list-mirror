From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/4] Simplify and micro-optimize
	WorkingTreeIterator.ENTRY_CMP
Date: Fri, 22 Aug 2008 16:07:05 -0700
Message-ID: <20080822230705.GO3483@spearce.org>
References: <1219352258-15431-1-git-send-email-spearce@spearce.org> <200808222245.08814.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:08:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfjm-00071R-N7
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbYHVXHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYHVXHG
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:07:06 -0400
Received: from george.spearce.org ([209.20.77.23]:57431 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbYHVXHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:07:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 5827438375; Fri, 22 Aug 2008 23:07:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808222245.08814.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93394>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> torsdagen den 21 augusti 2008 22.57.35 skrev Shawn O. Pearce:
> > We already did this simplification work to AbstractTreeIterator's
> > pathCompare method, and this is based upon that same structure.
> 
> I noticed we have very bad code coverage in unit tests in this area of the code. 
> Maybe we should increase the coverage before optimizing. I'll accept the patches
> anyway and pray they are ok.

Yea, I didn't go into here just to optimize the code.  But I looked
at it and said "WTF was I smoking when I wrote that?  Must have
been some good quality stuff!".

I was in there studying the method because I wanted to call it
from someplace else, and then realized how crappy it was.  So as I
simplified it, I noticed we didn't have to do as many compares to
come up with the same result.

I'm working on improving test coverage.  Slowly.  But I am trying
to spend at least a few hours a week on it.  I know we are really,
really bad here.  It will get better.

-- 
Shawn.
