From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 13:59:08 -0400
Message-ID: <20090902175908.GA5998@coredump.intra.peff.net>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <7vljkxdiil.fsf@alter.siamese.dyndns.org>
 <20090902100730.GA18226@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:59:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miu75-0007uC-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZIBR7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbZIBR7J
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:59:09 -0400
Received: from peff.net ([208.65.91.99]:40634 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbZIBR7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:59:08 -0400
Received: (qmail 7933 invoked by uid 107); 2 Sep 2009 17:59:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 13:59:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 13:59:08 -0400
Content-Disposition: inline
In-Reply-To: <20090902100730.GA18226@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127621>

On Wed, Sep 02, 2009 at 03:07:32AM -0700, David Aguilar wrote:

> I agree with all of this but would also add that we can have
> our cake and eat it too with respect to wanting to "keep
> similar things together" and having "unmerged near bottom".

Well, my point was that the "bottom" is not really cake, but I am not
sure anyone else agrees.

> No one has suggested this, so I figured I would.
> What do you think about this layout?
> 
> - untracked
> - staged
> - modified
> - unmerged

What about the current branch? Alternate author info? Tracking branch
relationship? Should those be at the top or bottom?

I dunno. Maybe it is just me being crotchety and hating change, but I
like the current order (though swapping it below "updated" is fine with
me).

> While I've got you guys.. I have a patch for the new 1.7
> status that makes it:
> 
> 	git status [<tree-ish>] [--] [pathspec]
> 	(it adds support for tree-ish)
> 
> I added that because I thought that the porcelain-ish short
> status output could be useful for "what does commit --amend
> do" from a script-writers' pov, and thus adding <tree-ish>
> enables git status -s HEAD^.

If you want to know "what does commit --amend do", then shouldn't you be
using "git commit --amend --dry-run" (which is what "git status" is now,
but will not be in v1.7.0)?

Are there other uses cases for arbitrary tree-ish's?

> BTW is status -s intended to be something plumbing-like;
> something we can build upon and expect to be stable?
> I'm just curious because other commands have a --porcelain
> option and I wasn't sure if this was the intent.

We mentioned a --porcelain option in other discussion, but I don't think
there is a patch. I would be in favor of --porcelain, even if it is
currently identical to --short, because then it gives us freedom to
diverge later (and in particular it gives us the freedom to let user
configuration affect what is shown).

-Peff
