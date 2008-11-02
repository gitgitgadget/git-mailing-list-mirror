From: Jeff King <peff@peff.net>
Subject: Re: Git remote status
Date: Sat, 1 Nov 2008 23:30:56 -0400
Message-ID: <20081102033056.GA4936@coredump.intra.peff.net>
References: <490CB390.9000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gonsolo <gonsolo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 04:34:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwTjH-0008Cj-K4
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 04:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbYKBDbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 23:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbYKBDbA
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 23:31:00 -0400
Received: from peff.net ([208.65.91.99]:3694 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbYKBDa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 23:30:59 -0400
Received: (qmail 22139 invoked by uid 111); 2 Nov 2008 03:30:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Nov 2008 23:30:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Nov 2008 23:30:56 -0400
Content-Disposition: inline
In-Reply-To: <490CB390.9000206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99801>

On Sat, Nov 01, 2008 at 08:52:48PM +0100, Gonsolo wrote:

> If I switch branches with "git checkout master" git tells me something  
> like "Your branch is ahead of the tracked remote branch 'origin/master'  
> by 39 commits".
> Is there a "git remote status" or git-status switch to get the same  
> information without switching branches?

"git status" will do this automatically in recent versions of git (as of
1.6.0, I believe).

You can also use "git branch -v" to see a summary of how all branches
relate to their tracked counterparts.

> Sometimes it's valuable whether one should push changes (for example  
> before installing a new Ubuntu version ;) ).

For that, I might want to actually _see_ the changes. So I would use:

  git shortlog origin/master..

(or "log" with a variety of formatting options to get as much
information as you like). And if the relationship is more complex (i.e.,
I want to see if I need to push _or_ pull):

  gitk origin/master...

-Peff
