From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 13:33:56 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905221244370.2147@iabervon.org>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>  <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>  <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>  <4A1671E5.4030400@op5.se> 
 <855e4dcf0905220335n367a065fidc65567119c0a5a3@mail.gmail.com>  <4A16822A.2060404@viscovery.net> <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 19:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7YdI-0006ld-To
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 19:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756743AbZEVReG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbZEVReE
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 13:34:04 -0400
Received: from iabervon.org ([66.92.72.58]:41651 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755868AbZEVReD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 13:34:03 -0400
Received: (qmail 9724 invoked by uid 1000); 22 May 2009 17:33:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 May 2009 17:33:56 -0000
In-Reply-To: <855e4dcf0905220436h1b6fa632q7804c98bf09b324c@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119744>

On Fri, 22 May 2009, Tim Uckun wrote:

> >
> > Did test_new contain ignored files?
> 
> No.  I put the entire transcript in the first email. I did not tell
> git to ignore anything and there were no .git directories in the test
> folder.

Obviously, there's more before the transcript started; otherwise, there 
would be nothing to import in the initial commit, and there certainly 
wouldn't be .git directories that came from nowhere. I don't think any 
version control system I know of likes having your initial import be of a 
directory with other working directories for the same system as 
subdirectories. (That is, Mercurial will be fine having git working 
directories in the import, but git won't, and Mercurial wouldn't be happy 
about having Mercurial working directories as subdirectories).

> 
> > In this case, when you checkout the
> > branch that does not have test_new, only the tracked files are removed;
> > the ignored (i.e untracked) files remain. Therefore, after the checkout
> > you still have a test_new directory.
> >
> 
> As far as I can tell all the files are tracked after I do a commit.
> 
> I can understand why it put the original test directory back when I
> changed to the master branch but I don't understand why it's missing a
> subdirectory.  I don't think the test_new directory should be in the
> master branch at all but I guess I can kind of sort of see why git
> might not remove it. What I can't understand at all is why it's
> missing subdirectories.

This tends to happen if, while on a different branch, you editted some 
files and left editor backups or compiled (maybe just-in-time) files in 
that directory. Then there are files in the directory that don't belong to 
any branch, since they're not source files.

It's also highly likely that what's missing is stuff you thought you 
imported initially, but did not actually import due to the confusion with 
it already being a git working directory.

	-Daniel
*This .sig left intentionally blank*
