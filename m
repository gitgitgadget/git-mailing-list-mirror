From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: keeping remote branches in sync
Date: Thu, 9 Oct 2008 08:16:36 -0700
Message-ID: <20081009151636.GT8203@spearce.org>
References: <20081009141418.GF18241@morganstanley.com> <eaa105840810090743pba41a98ocdf79b7c06d76e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 17:25:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnxGu-0003r6-81
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 17:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYJIPQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 11:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753747AbYJIPQh
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 11:16:37 -0400
Received: from george.spearce.org ([209.20.77.23]:51953 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbYJIPQg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 11:16:36 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1021E38360; Thu,  9 Oct 2008 15:16:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <eaa105840810090743pba41a98ocdf79b7c06d76e9e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97859>

Peter Harris <git@peter.is-a-geek.org> wrote:
> On Thu, Oct 9, 2008 at 10:14 AM, Kevin Green wrote:
> > After topic branches are merged to master, we do some cleanup by deleting them
> > from the shared repo.
> >
> > One of the issues we have is that _my_ local repos remote branches aren't kept
> > in sync with the shared repo.
> ...
> 
> > I'd like some comment on whether our workflow could use some improvement.
> > Specifically, if there's a straightforward way to handle the issue above, that
> > would be great.  I've been looking through the manual on git-fetch and
> > git-pull and not seeing any options to do this.
> 
> Is "git remote prune" what you're looking for?

I keep meaning to add "git remote prune" logic into "git fetch",
e.g. as a "git fetch --prune" option.  fetch has all of the data
it needs to implement the prune already in memory, it just doesn't
have the loop to do the prune cleanup.

Now that "git remote" is in C it should be easy to share the prune
code between them, and make this more automatic.

-- 
Shawn.
