From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add to gitk an --argscmd flag to get the list of refs
	to draw at refresh time.
Date: Sun, 22 Jul 2007 17:49:03 +0200
Message-ID: <20070722154903.GM23229@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070712220411.31743.83101.stgit@gandelf.nowhere.earth> <18083.19607.236048.797818@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 17:50:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICdhF-0002VH-Ob
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753725AbXGVPty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 11:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXGVPty
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 11:49:54 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48787 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbXGVPtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 11:49:53 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2BAC65A11B;
	Sun, 22 Jul 2007 17:49:51 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id AC7761F162; Sun, 22 Jul 2007 17:49:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18083.19607.236048.797818@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53275>

On Sun, Jul 22, 2007 at 10:24:55PM +1000, Paul Mackerras wrote:
> Yann Dirson writes:
> 
> > This new version causes the command to add its revs to the litteral
> > ones from command-line instead of overriding them, and allows to
> > edit the command in the view editor.
> 
> Is it actually useful to use both the --argscmd flag and some literal
> revisions on the command line?  Why would you use both?

I tend to mostly use --all each time I use gitk (or stg-gitk, for that
matter), so my personal way of using gitk does not need it.  However,
it could be useful if someone launched, say, 'stg-gitk master', thus
using --argscmd, and later wants to edit the view, eg. to add "origin".

> Instead of the --argscmd flag, maybe we could have a convention that
> an argument starting with "|" is a command to run rather than a
> literal revision.  Would that suit?

If we go that way, a final "|" could be more intuitive.

However, a final "|" would run into a limitation of the view editor,
which is already a bit annoying with long command lines: the limited
size of the text field would by default hide the important final char.

>  It would seem to simplify the
> patch by eliminating the requirement for an extra entry field, as well
> as removing the need for the separate viewargscmd array.

Sure, but at the same time, it does not make the code that more
complicated, and it makes it obvious that there are 2 ways to specify
the revs.


> > Disclaimer: I'm no tcl/tk expert, feel free to flame my style :)
> 
> There are a couple of things I think should be done differently, in
> fact. :)

Eh :)

Best regards,
-- 
Yann
