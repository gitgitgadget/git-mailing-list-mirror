From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn dcommit failure
Date: Tue, 5 Jun 2007 03:17:44 -0700
Message-ID: <20070605101744.GA12948@muzzle>
References: <87veecat2k.fsf@mid.deneb.enyo.de> <87d50kas6p.fsf@mid.deneb.enyo.de> <20070529144742.GG1025@.intersec.eu> <87k5ur64hx.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:18:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvW6x-0003bP-LW
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763790AbXFEKRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763818AbXFEKRr
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:17:47 -0400
Received: from hand.yhbt.net ([66.150.188.102]:52396 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763790AbXFEKRq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:17:46 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 177212DC034;
	Tue,  5 Jun 2007 03:17:45 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 05 Jun 2007 03:17:44 -0700
Content-Disposition: inline
In-Reply-To: <87k5ur64hx.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49180>

Florian Weimer <fw@deneb.enyo.de> wrote:
> * Pierre Habouzit:
> 
> > On Tue, May 29, 2007 at 11:35:10AM +0200, Florian Weimer wrote:
> >> * Florian Weimer:
> >> 
> >> > This with git-svn 1.5.1.4-2 on something that is quite close to Debian
> >> > etch.
> >> 
> >> Same issue with 1.5.2~rc3-2.
> >
> >   Are you using ControlMaster in your ssh setup in auto/autoask mode? (I
> > assume your repository is svn+ssh). If yes, then you *have* to start a
> > persistent ssh connection before you do anything else:
> 
> No.  It's svn+ssh (with a custom connect script), but without the
> controlchan extension.  Subversion works fine and lets me commit
> changes.
> 
> After manually committing the offending changes via Subversion, I
> git-svn has begun to work again, too (but I haven't yet tried to
> change the same files).

Would upgrading to 1.5.2 final have helped?

Looking at 6442754d6cc0056cf5b69b43d218f8b6d317e7f5 (which was made
right before 1.5.2 final), the bug it fixed could've actually affected
modification-only commits, too.

If it's a public repository, could I look at the changeset that was
giving you trouble, and the [svn-remote] section of your .git/config
file?  Thanks.

-- 
Eric Wong
