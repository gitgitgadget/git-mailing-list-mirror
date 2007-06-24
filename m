From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svnimport: added explicit merge graph option -G
Date: Sun, 24 Jun 2007 10:44:27 +0200
Message-ID: <20070624084427.GA7715@xp.machine.xx>
References: <7vk5tt25n7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stas Maximov <smaximov@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 10:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Nhx-0000of-KP
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 10:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904AbXFXIoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 04:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753724AbXFXIoc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 04:44:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:43134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752970AbXFXIob (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 04:44:31 -0400
Received: (qmail invoked by alias); 24 Jun 2007 08:44:29 -0000
Received: from p54AA8EA2.dip0.t-ipconnect.de (EHLO localhost) [84.170.142.162]
  by mail.gmx.net (mp041) with SMTP; 24 Jun 2007 10:44:29 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19qRkdlcGFqkm6b+D+2OpyeHgkuzvYuTLt0D90Phz
	DKrNNdSDc4TYVx
Mail-Followup-To: Stas Maximov <smaximov@yahoo.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7vk5tt25n7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50779>

On Sun, Jun 24, 2007 at 12:06:20AM -0700, Junio C Hamano wrote:
> From: Stas Maximov <smaximov@yahoo.com>
> Date: Sat, 23 Jun 2007 09:06:30 -0700
> 
> Allows explicit merge graph information to be provided. Each line
> of merge graph file must contain a pair of SVN revision numbers
> separated by space. The first number is child (merged to) SVN rev
> number and the second is the parent (merged from) SVN rev number.
> Comments can be started with '#' and continue to the end of line.
> Empty and space-only lines are allowed and will be ignored.
> ---
> 
>  * Stas, please give a "Signed-off-by" line, and get in the
>    habit of always CC the list.
> 
>    I received a format-patch output as attachment from Stas.  As
>    I cannot comment on the patch in that format, I am making a
>    verbatim forward to the list.
> 
>    I'll comment on the patch separately when I am through it,
>    but would appreciate comments from people who were involved
>    in git-svnimport in the past, and still use it.
> 
>    "You should use git-svn instead" people can repeat that as
>    usual, but at the same time it might be worth realizing that
>    there are people who maintain git-svnimport being better for
>    one-short importing.
> 

[exchanging To:/Cc: as Junio just forwarded the message from Stas]

Not commenting on the patch per se, but wouldn't it make more
sense to have such functionality in a history rewriting tool like
e.g. git-branch-filter?

I had an svn import (git-svn) where I wanted to give correct
branch/merge points, too, and so I manually created a grafts file
annotating all the svn merges. Having such a thing as a _generic_ tool
which operates on grafts would be much more usefull because you get one
implementation which could be used for each and every importer out
there. Sure, you have to transform the native revision specifieres into
the GIT commit id's if you only have e.g. "merged r4711:4720 into trunk",
but these functionality is much more common to have in importers
than whats implemented in the above mentioned patch.

Another bonus point of using the grafts mechanism you'll get for free is
that you could _look_ at the commit graph in gitk *before* doing the
often expensive reimport of your project, so could be sure you haven't
forgotten to mark a merge.

-Peter Baumann
