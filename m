From: Petr Baudis <pasky@suse.cz>
Subject: Re: sparse fetch, was Re: [PATCH 08/12] git-clone: support --path
	to do sparse clone
Date: Fri, 25 Jul 2008 02:42:10 +0200
Message-ID: <20080725004210.GO10151@machine.or.cz>
References: <20080723145718.GA29134@laptop> <20080724171952.GB21043@sigill.intra.peff.net> <alpine.DEB.1.00.0807241837441.8986@racer> <20080724185332.GQ32184@machine.or.cz> <bd6139dc0807241201v50cd5ef2m58ee7efc05119e20@mail.gmail.com> <alpine.DEB.1.00.0807250210090.4140@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Jeff King <peff@peff.net>,
	Nguy?n =?iso-8859-2?Q?Th=E1i?= Ng?c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBOr-0003uV-VK
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYGYAmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 20:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYGYAmN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:42:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43076 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753538AbYGYAmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:42:13 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6278A393A2DD; Fri, 25 Jul 2008 02:42:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807250210090.4140@eeepc-johanness>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89983>

  Hi,

On Fri, Jul 25, 2008 at 02:12:31AM +0200, Johannes Schindelin wrote:
> On Thu, 24 Jul 2008, Sverre Rabbelier wrote:
> 
> > On Thu, Jul 24, 2008 at 8:53 PM, Petr Baudis <pasky@suse.cz> wrote:
> > >  I don't follow how these two issues arise, if the server will do the 
> > > pruning for you. It will just skip entering some tree objects when 
> > > doing object traversal; why opening the git protocol or faking 
> > > commits? This would be a simple extra capability in the protocol.
> > 
> > Wouldn't that be as simple as passing a pathspec to git-rev-list? Not a 
> > lot of overhead there I reckon.
> 
> So the server would _not_ have to deflate the objects to inspect them?  I 
> thought you knew more about Git's object database.
..snip..
> You'd still have to inspect the objects, which is way more work than the 
> current code has to do.  Remember: in the optimal case, upload-pack does 
> not more than just serve the existing deltas/base objects.

  then right now, exactly how does the server decide that the blob
7a7ff130 should be served along git.git HEAD? I still see upload-pack.c
calling traverse_commit_list() that does process_tree() on every tree,
etc. But the code is not straightforward, maybe I'm missing some
shortcut?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
