From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 09:23:51 -0700
Message-ID: <20081013162351.GQ4856@spearce.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081013162132.GB20371@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 18:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpQED-00020u-Le
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 18:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756576AbYJMQXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754478AbYJMQXx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 12:23:53 -0400
Received: from george.spearce.org ([209.20.77.23]:43054 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbYJMQXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 12:23:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D3D4C38360; Mon, 13 Oct 2008 16:23:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081013162132.GB20371@leksak.fem-net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98121>

Stephan Beyer <s-beyer@gmx.net> wrote:
> Johannes Schindelin wrote:
> > and I would have expected others to need a lot less arguments 
> > to see it that way, too.
> 
> Despite the fact that I've never used hardlinks in a git repository, I
> would have expected git to keep them.  So I'm one of the "others" who
> thinks this config option is just sane (and should perhaps even be
> enabled by default, if it does not break stuff on file systems that do
> not have a hardlink feature... but ok)

My problem is many users do "cp -rl a b" to clone a->b and hardlink
the working directory.  They expect "cd b && git checkout foo" to
then only unlink the paths that differ.  Updating the original inode
would break repository a.

Its a change in behavior, to some of our oldest users.  So it can't
really be on by default.

-- 
Shawn.
