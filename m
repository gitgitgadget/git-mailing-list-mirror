From: Jeff King <peff@peff.net>
Subject: Re: tags and patches
Date: Wed, 13 Jun 2007 22:19:40 -0400
Message-ID: <20070614021939.GA18325@segfault.peff.net>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com> <Pine.LNX.4.64.0706131313550.4059@racer.site> <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com> <Pine.LNX.4.64.0706140201400.4059@racer.site> <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 04:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyevp-0006r2-Iy
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 04:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbXFNCT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 22:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXFNCT1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 22:19:27 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4296 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbXFNCT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 22:19:27 -0400
Received: (qmail 18605 invoked by uid 1000); 14 Jun 2007 02:19:40 -0000
Content-Disposition: inline
In-Reply-To: <93c3eada0706131905i1cd43fd2xcc44ce47dca8ce00@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50159>

On Thu, Jun 14, 2007 at 11:35:35AM +0930, Geoff Russell wrote:

> I'm trying to work out if I want to use git to manage a software
> distribution problem. I distribute release v1.0 to people then later I
> want to email them a patch to take them from v1.0 to v1.1.  I can
> probably live without the tags, but am just surprised that patches
> don't send them.

Patches represent differences in _content_, but they don't show history.
So while git supports a somewhat extended patch format (supporting
things like renames and file modes), patches don't know anything about
branches, parent commits, or tags.

If you are trying to take people from v1.0 to v1.1, the best way depends
on their setup:

  - If they are all running git, then you can have them 'pull' from your
    repository
  - If you don't like that for some reason, you can send them a bundle,
    which is the moral equivalent of pulling (except that you've pushed
    through a non-interactive medium, but the end result in their
    repository is the same)
  - If they aren't running git, then you can use git to prepare the
    patch by tagging your own repository, and then creating either a
    patch series (git-format-patch v1.0..v1.1) or a single big patch
    (git-diff v1.0..v1.1). But either way, what would it mean to have a
    tag in the patch, since they don't have a tagging system at the
    other end?

I'm not really sure what you're trying to accomplish; if you can be more
concrete, we might be able to offer more concrete solutions (or maybe
the answer you were looking for was simply, "you want bundles, not
patches").

-Peff
