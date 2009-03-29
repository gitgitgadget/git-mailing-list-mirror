From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
	SVN
Date: Sun, 29 Mar 2009 15:16:42 -0700
Message-ID: <20090329221642.GA16507@dcvr.yhbt.net>
References: <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> <1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> <1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com> <1238328537685-2552369.post@n2.nabble.com> <fabb9a1e0903290535y59cd3a1fvd5a7d3476dff45bc@mail.gmail.com> <1238331203288-2552470.post@n2.nabble.com> <fabb9a1e0903290555o3503b58ie097f8f8336c4401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 00:18:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo3Kc-0008So-2e
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 00:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZC2WQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 18:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZC2WQp
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 18:16:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60314 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbZC2WQo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 18:16:44 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE6C1F79C;
	Sun, 29 Mar 2009 22:16:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0903290555o3503b58ie097f8f8336c4401@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115042>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
> 
> On Sun, Mar 29, 2009 at 14:53, jamespetts <jamespetts@yahoo.com> wrote:
> >
> > "Unable to determine upstream SVN infromation from working tree history".
> >
> > Have I done something wrong...?
> 
> I'm afraid this is where my git-svn knowledge is no longer sufficient
> :(. I have had the same problem myself, and I don't know how to fix
> it, perhaps Eric has a moment to enlighten?

What does "git log" in your working tree say before you run "git svn
rebase"?

Then, what does "git log <ref_of_svn_remote_you_reset_to>" say?

"git svn rebase" relies on the "git-svn-id:" line in the log message
as well as the stored checksum to determine how to rebase the
current HEAD.

However, "git svn fetch" should always work[1] and not touch the current
HEAD.  You can run "git svn fetch" to get the new updates and then
push your remotes out as heads by setting up your pushes to github
like this .git/config (totally untested):

[remote "github"]
	url = user@github.com/foo/bar.git
	push = refs/remotes/*:refs/heads/*


[1] - at least on POSIX, I don't know if git-svn is still broken
in Windows and can't help if is.

-- 
Eric Wong
