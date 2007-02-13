From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 19:38:15 -0500
Message-ID: <20070213003815.GA31377@spearce.org>
References: <20070211084030.GE2082@spearce.org> <7vwt2oba8s.fsf@assigned-by-dhcp.cox.net> <20070211224158.GA31488@spearce.org> <7v64a782ht.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702130037530.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070212234212.GB30967@spearce.org> <Pine.LNX.4.63.0702130053200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <eqr0v4$rqd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 01:38:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlh6-0000nt-RF
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbXBMAiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbXBMAiV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:38:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47557 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030582AbXBMAiU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:38:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGlgO-0003L1-28; Mon, 12 Feb 2007 19:38:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 56AC720FBAE; Mon, 12 Feb 2007 19:38:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eqr0v4$rqd$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39468>

Jakub Narebski <jnareb@gmail.com> wrote:
> > On Mon, 12 Feb 2007, Shawn O. Pearce wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >>> On Mon, 12 Feb 2007, Junio C Hamano wrote:
> >>>> $ git read-tree --prefix=git-gui/ git-gui/master
> >>>> $ git checkout git-gui
> >>> 
> >>> Didn't you mean "git checkout master" here?
> >> 
> >> I don't think so.  At this point the subdirectory git-gui is known
> >> in the index, so Junio is trying to get checkout-index to process
> >> those paths and create it in the working directory.
> 
> So it is "git checkout -- git-gui" then?

Yes.  But this trick only works once.  After that you cannot use
`read-tree --prefix` to load the index with the git-gui/master
branch, as there already is stuff under git-gui.  Instead you need
to whack the directory's files from the index, then reload it.

Or abuse mktree, as I did in the script I posted.

-- 
Shawn.
