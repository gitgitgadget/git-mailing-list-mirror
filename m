From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: create intermediate directories of destination
	repo
Date: Tue, 24 Jun 2008 04:04:38 -0400
Message-ID: <20080624080437.GA2581@sigill.intra.peff.net>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net> <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil> <20080624055022.GC19224@sigill.intra.peff.net> <7v3an3e0xv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Daniel Barkalow <barkalow@iabervon.org>, zuh@iki.fi,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:06:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB3XE-0000Ma-Ou
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYFXIEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYFXIEn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:04:43 -0400
Received: from peff.net ([208.65.91.99]:1106 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbYFXIEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:04:41 -0400
Received: (qmail 857 invoked by uid 111); 24 Jun 2008 08:04:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 04:04:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 04:04:38 -0400
Content-Disposition: inline
In-Reply-To: <7v3an3e0xv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86007>

On Tue, Jun 24, 2008 at 12:39:40AM -0700, Junio C Hamano wrote:

> > The shell version used to use "mkdir -p" to create the repo path, but
> > the C version just calls "mkdir". Let's replicate the old behavior. In
> > this case we can simply create the directories leading up to the git
> > dir. If it's a bare repo, then that is everything that init_db wants
> > ahead of time. If it isn't bare, then the worktree contains the git dir,
> > so we create the worktree.
> 
> Clever ;-)

I am worried that it is too clever. I didn't see an obvious way for
work_tree and git_dir to not have that property, but I think it is still
worth somebody double-checking.

-Peff
