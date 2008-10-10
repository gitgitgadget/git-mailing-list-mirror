From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge hook
Date: Fri, 10 Oct 2008 12:07:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810101204540.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081010072148.GB303@Mac2.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Colson <eco@ecocode.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 12:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoEpY-0006bl-NR
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 12:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbYJJKBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 06:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYJJKBQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 06:01:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:58081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752609AbYJJKBP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 06:01:15 -0400
Received: (qmail invoked by alias); 10 Oct 2008 10:00:43 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 10 Oct 2008 12:00:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zZ1FfZl5zx/TvUqE9HEOSSmJ4q4vS2K9edNfAGY
	38mhvCV6wyxhoi
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081010072148.GB303@Mac2.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97921>

Hi,

On Fri, 10 Oct 2008, Erik Colson wrote:

> Is it possible to launch a custom script on all files involved in a 
> merge to master ? If yes, is it then also possible to reject the merge 
> if the script returns an error ?

>From Documentation/githooks.txt:

-- snip --
prepare-commit-msg
------------------

This hook is invoked by 'git-commit' right after preparing the
default log message, and before the editor is started.

It takes one to three parameters.  The first is the name of the file that 
the commit log message.  The second is the source of the commit message, 
and can be: [...] `merge` (if the commit is a merge or a `.git/MERGE_MSG` 
file exists); [...]

If the exit status is non-zero, 'git-commit' will abort.
-- snap --

To see which files are affected, you'd just need to ask "git diff 
--name-only --cached".

I guess that you want to disallow merging in changes from people who 
changed files that are none of their business?  If so, it would be nice to 
contribute the hook as a patch to contrib/.

Ciao,
Dscho
