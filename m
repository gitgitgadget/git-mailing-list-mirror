From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn branch naming question
Date: Sat, 8 Dec 2007 11:59:01 +0100
Message-ID: <20071208105901.GA2844@xp.machine.xx>
References: <20071208010438.GE3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0xWF-0003Dn-IN
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbXLHLG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbXLHLG1
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:06:27 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:45607 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752439AbXLHLG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 06:06:26 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Dec 2007 06:06:26 EST
Received: (qmail 27646 invoked by uid 0); 8 Dec 2007 10:59:02 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 8 Dec 2007 10:59:02 -0000
Content-Disposition: inline
In-Reply-To: <20071208010438.GE3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67539>

On Sat, Dec 08, 2007 at 02:04:38AM +0100, Miklos Vajna wrote:
> hi,
> 
> i'm using git-svn for projects where i don't just want to commit to
> trunk but to other branches, too.
> 
> for example:
> 
> git-svn clone -s svn+ssh://vmiklos@svn.gnome.org/svn/ooo-build ooo-build
> 
> then i have a local 'master' branch and all the other branches are local
> branches.
> 
> so, when i want to work in the ooo-build-2-3 branch, i do a:
> 
> git checkout -b ooo-build-2-3 ooo-build-2-3
> 
> but when i do a git svn rebase, i get:
> 
> warning: refname 'ooo-build-2-3' is ambiguous.
> 
> what am i doing wrong?

Try using 'git svn rebase remotes/ooo-build-2-3'.

git-svn should produce its branches under refs/remotes/* and your
local branches are under refs/heads/*.

By using 'git checkout -b ooo-build-2-3 ooo-build-2-3' you created
refs/heads/ooo-build-2-3 as a copy of refs/remotes/ooo-build-2-3 and now
using only ooo-build-2-3 is ambigious. (at least in some cases where git
won't take refs/heads/ooo-build-2-3)


> 
> in fact i suspect that in case i would use some other branch name, like
> simply '2-3' then i could get rid of this warning, but that's the
> problem with using the equivalent name of the remote branch when working
> in a branch locally?
> 

See above.

> probably i miss some parameter to git-svn clone so that it would prefix
> the refs with some 'origin'?

Look up  --prefix in the manpage for git-svn.

-Peter
