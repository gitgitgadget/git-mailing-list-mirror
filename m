From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/6] Add set to IntList
Date: Mon, 4 May 2009 07:55:06 -0700
Message-ID: <20090504145506.GV23604@spearce.org>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org> <200905030907.02287.robin.rosenberg.lists@dewire.com> <20090504142231.GS23604@spearce.org> <alpine.DEB.1.00.0905041649570.5553@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 04 16:55:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0zZe-0006Z5-Jw
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 16:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbZEDOzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757193AbZEDOzH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 10:55:07 -0400
Received: from george.spearce.org ([209.20.77.23]:41865 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbZEDOzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 10:55:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7C4F738195; Mon,  4 May 2009 14:55:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905041649570.5553@intel-tinevez-2-302>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118246>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 4 May 2009, Shawn O. Pearce wrote:
> 
> > Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > l?rdag 02 maj 2009 04:08:42 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> > > > Some applications may wish to modify an int list.
> > 
> > OK, as it turns out, this is used by code which Dscho wrote but I 
> > haven't packaged up as patches yet.  And I don't think that even uses 
> > the weird set(size(), ...) expands the list rules I implemented. So drop 
> > this patch for now from the series and I'll respin it at a later date.
> 
> Indeed, my code only needs add(int i), which should expand the array on 
> demand (i.e. after a clear(), it should _not_ blindly resize the array).

Really?  When I was starting to bring your code in and moved from
IntArray to IntList I had compile errors on set calls, so I added
it to IntList.

Huh.  Well, add(int) is already there, and clear() resets the size
to 0 but doesn't resize the internal array, so future adds up to
the prior capacity are free.

-- 
Shawn.
