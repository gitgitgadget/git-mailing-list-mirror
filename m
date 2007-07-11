From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn problems with branches containing spaces
Date: Wed, 11 Jul 2007 01:29:07 -0700
Message-ID: <20070711082907.GA29676@muzzle>
References: <3F225D5F64550C4AA5F23286244275D4298C84@srvkrsexc07.nov.com> <20070710134236.2870.qmail@986bac8bfff25d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ewald, Robert" <Robert.Ewald@nov.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 10:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8XZR-0002xi-2Q
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 10:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbXGKI3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 04:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbXGKI3J
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 04:29:09 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40067 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbXGKI3I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 04:29:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C9A132DC032;
	Wed, 11 Jul 2007 01:29:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070710134236.2870.qmail@986bac8bfff25d.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52143>

Gerrit Pape <pape@smarden.org> wrote:
> On Wed, Jun 27, 2007 at 08:53:06AM +0200, Ewald, Robert wrote:
> > As I have reported yesterday on IRC, git-svn has problems with branches
> > containing spaces.
> > I get the following message, when I want to clone from the repository
> > containing a branch with a space.
> > Cloning until the revision the branch is created everything works fine.
> > 
> > fatal: refs/remotes/Modbus Error Limit Fix: cannot lock the ref
> > update-ref -m r1897 refs/remotes/Modbus Error Limit Fix
> > ff0819c8e9c97c24e9865bc868c503fd9b64f980: command returned error: 128
> > 
> > Thanks for your help.
> 
> Hi, the same problem has been reported some time ago through
>  http://bugs.debian.org/430518
> 
> There's a patch attached to the report, but from a first glance, I don't
> think it's the solution.

That patch is definitely not a correct solution.  If another branch came
along with the same name as an automatically renamed one, it would break
things badly.

I started working on a patch that allowed the user to interactively
specify replacement branch names, but never got around to finishing
it:

http://permalink.gmane.org/gmane.comp.version-control.git/45651

-- 
Eric Wong
