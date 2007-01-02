From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 20:08:16 -0500
Message-ID: <20070102010816.GB4253@thunk.org>
References: <20070101131726.GA21933@thunk.org> <926020.70066.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 02:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Y8n-0005HI-G1
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 02:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbXABBIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 20:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXABBIV
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 20:08:21 -0500
Received: from THUNK.ORG ([69.25.196.29]:40729 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932566AbXABBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 20:08:20 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1H1YCu-00072l-1J; Mon, 01 Jan 2007 20:12:48 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1H1Y8W-0007q9-SF; Mon, 01 Jan 2007 20:08:16 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <926020.70066.qm@web31802.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35759>

On Mon, Jan 01, 2007 at 03:56:05PM -0800, Luben Tuikov wrote:
> > Currently, today, if you type:
> > 
> > 	git fetch <non-URL>
> > 
> > ... it will look up "<non-URL>" in a single global namespace, which
> > (using only the new config scheme) is looked up in remote.<non-URL>
> > and remote.<non-URL>.{url,fetch} is used to control the operation of
> > git-fetch.
> 
> I'm talking about more in terms of git-merge, but since git-pull
> is a git-fetch and git-merge, I've been using git-pull for completeness.

Well, yes; since git-pull is implemented in terms of git-fetch
followed by a git-merge, that's why I talked about git-fetch.  It is
git-fetch which uses remote.<non-URL>.{url,fetch}, not git-merge or
git-pull (since it just passes those arguments over to git-fetch).

> More specifically,
> branch.<branch-match>.<symbolic-ref match>.{fetch,merge}.

What do you mean by <branch-match> and <symbolic-ref match>?

Are you assuming some kind of glob match?  If so, what are the
specific rules of the match that you are proposing?

> branch.<branch-match>..{fetch,merge} is allowed and defalts
> to already implemented "git-pull".

What do you mean by ".." here?   

> Think of "git-pull", not just of "git-fetch".  As well as think
> of a setup where there are more than one branch implementing
> software dependency, resolving to a software product.

git-pull is implemented in terms of git-fetch.  So if we make the
change to git-fetch, the changes naturally follow to git-pull.  Or are
you proposing to change that?

						- Ted
