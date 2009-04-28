From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Tue, 28 Apr 2009 22:30:40 +0200
Message-ID: <20090428203040.GD15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 22:40:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyu6J-0005T4-Sl
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 22:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbZD1UkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZD1UkN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 16:40:13 -0400
Received: from quechua.inka.de ([193.197.184.2]:57438 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbZD1UkM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 16:40:12 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Lyu65-0002Ii-KU; Tue, 28 Apr 2009 22:40:10 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 7E6C02CC7C; Tue, 28 Apr 2009 22:30:40 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090427201251.GC15420@raven.wolf.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117808>

On Mon, Apr 27, 2009 at 10:12:51PM +0200, Josef Wolf wrote:

[ ... ]
> give me the desired outputs.  Now I do
> 
>     git checkout svn-first
>     git merge -s ours svn-second
>     git checkout svn-second
>     git merge -s ours svn-first
> 
> to tell git that the branches are in sync.
> 
> But now, when I try to
> 
>     git checkout svn-second
>     git svn rebase
> 
> I get lots of conflicts.  When I inspect the .git/rebase-apply directory
> and the conflicts, it looks like "git svn rebase" tries to re-apply all
> the commits from svn-first.  When I omit the "git merge -s ours svn-first"
> command, it does not re-apply those commits.  So it looks like the
> "git merge -s ours" wipes some information that git-svn needs to know
> what was already merged.
> 
> What am I missing?  I thought the "ours" strategy is meant to tell git
> that everything from that branch was merged, either manually or by
> cherry-pick.

After lots of RTFM, I get the impression, that cherry-pick is the only
operation I can do to sync a git-svn branch with other (git or git-svn)
branches.  merge/pull should be avoided.

But then, how do I mark cherry-picked commits as "already synched"?
