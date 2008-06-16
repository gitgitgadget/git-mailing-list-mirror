From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mercurial to git converter.
Date: Sun, 15 Jun 2008 22:24:35 -0400
Message-ID: <20080616022435.GS11793@spearce.org>
References: <1168537766.22649.19.camel@localhost.localdomain> <loom.20080614T101342-542@post.gmane.org> <alpine.DEB.1.00.0806141648020.6439@racer> <m3wsksotdq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nick Andrew <nick@nick-andrew.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 04:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K84Q8-0001f3-N1
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 04:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbYFPCYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 22:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbYFPCYm
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 22:24:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42146 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbYFPCYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 22:24:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K84OQ-0002ga-3A; Sun, 15 Jun 2008 22:24:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 171C120FBAE; Sun, 15 Jun 2008 22:24:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <m3wsksotdq.fsf@localhost.localdomain>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85158>

Jakub Narebski <jnareb@gmail.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > FWIW I switched my local mercurial2git conversion to the hg-fast-export 
> > solution from 
> > 
> > 	git://repo.or.cz/fast-export.git
> >
> [...] 
> > Originally, I did not try it because I thought it cannot operate in 
> > incremental mode, but it can.
> 
> It can, or it can recently thanks to --export-marks / --import-marks
> work?

The recent --export-marks/import-marks work you speak of was adding
these options to git-fast-export, making it easier to perform an
incremental _export_ from Git to another SCM.  I believe Dscho
is speaking about an Hg->Git conversion, which would rely on
git-fast-import's previously existing --export-marks/import-marks
feature.
 
> It is nice that SCM-to-SCM converters seems to standarize on using
> fast-import language as intermediary.  

Turns out the little format we knocked together for this is able
to represent most conversions for SCMs.  I'm just happy users are
easily able to convert into Git.

> IIRC fast-import by Shawn O. Pearce started as fast backend for first
> cvs2git (unfortunately fork and not extension of cvs2svn) by Jon Smirl
> (?) around time when Mozilla looked for SCM to move to from CVS.  (In
> the end they choose Mercurial, mainly because of better Windows
> support, and I think also better Windows GUI; I wonder how it works
> for them now?).

Your history is correct.  The current version of cvs2svn also
supports cvs2git, and may also support cvs2bzr by using the
git-fast-import backend and bzr-fast-import as the parser.

-- 
Shawn.
