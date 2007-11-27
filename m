From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 12:07:49 -0500
Message-ID: <20071127170749.GA19136@fieldses.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home> <20071127150829.GB3853@fieldses.org> <alpine.LFD.0.99999.0711271013310.9605@xanadu.home> <20071127153411.GA11731@fieldses.org> <alpine.LFD.0.99999.0711271047590.9605@xanadu.home> <20071127164243.GE11731@fieldses.org> <Pine.LNX.4.64.0711271652070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	=?utf-8?B?44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix3v8-0003B5-Ji
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577AbXK0RIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757475AbXK0RIG
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:08:06 -0500
Received: from mail.fieldses.org ([66.93.2.214]:33093 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757564AbXK0RIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 12:08:05 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ix3uX-0005FG-Kw; Tue, 27 Nov 2007 12:07:49 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711271652070.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66242>

On Tue, Nov 27, 2007 at 04:54:18PM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 27 Nov 2007, J. Bruce Fields wrote:
> 
> > If we really want a fetch+rebase script, OK, but call it something other 
> > than pull.
> 
> Why?  pull = fetch + merge only because that was the originally envisioned 
> way to pull remote changes into your local working tree.  However, I do 
> not see why we should be married to pull being a fetch and a merge for 
> eternity.

Two responses:

First, OK, if you want to say "pull" means "fetch something and then
incorporate it somehow into your current branch", that doesn't bother me
quite as much as saying that "pull" always means "fetch + merge", and
that "rebase" is really just a special kind of merge.  It's clearly not
a merge.

Second: "fetch+rebase" will really have very different properties from
"fetch+pull".  It may be possible to make the former behave a little
like the latter in some common cases, but it's going to complicated.
And a lot of git-pull documentation is going to end up with clauses like
"...except if you're running pull in 'rebase' mode, in which case...".
Better to keep the two cases as separate operations with separate syntax
and man pages.  (But share where it makes sense--e.g. any syntax and
documentation of fetch part should be shared.)

--b.
