From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 08:02:27 -0700
Message-ID: <20081014150227.GC4856@spearce.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810131546180.19665@iabervon.org> <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 14 17:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KplR1-0004R6-S1
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 17:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbYJNPC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbYJNPC3
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 11:02:29 -0400
Received: from george.spearce.org ([209.20.77.23]:60433 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYJNPC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 11:02:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C06363835F; Tue, 14 Oct 2008 15:02:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98189>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 13 Oct 2008, Daniel Barkalow wrote:
> 
> > On Mon, 13 Oct 2008, Johannes Schindelin wrote:
> > 
> > > I actually understand now why the tests started failing: the change from 
> > > resolve_ref() to get_branch() as requested by Daniel are at fault: 
> > > get_branch() does not check if the branch has an initial commit.
> 
> So, my vote is to revert back to resolve_ref(), even if it needs more 
> lines.

Yes, I agree, resolve_ref() is the best thing to be using here,
even if it is more code.  get_branch() validates the commit and we
don't want that.  We really just want to know if the current branch
is going to be updated, we don't care to what/why.

-- 
Shawn.
