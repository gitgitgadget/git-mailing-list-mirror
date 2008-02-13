From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-archive for files changed in revision range
Date: Wed, 13 Feb 2008 13:37:33 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802131335120.30505@racer.site>
References: <20080213130304.GA19957@grahamcox.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graham Cox <graham@grahamcox.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHoM-0001cZ-ET
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbYBMNh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbYBMNh2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:37:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:58502 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753031AbYBMNh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:37:27 -0500
Received: (qmail invoked by alias); 13 Feb 2008 13:37:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 13 Feb 2008 14:37:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19w5YkVOBdwtQj8Fb+YapPDEL1pp8AWjzDlBq0bbC
	QBNa0PpgFkXFaT
X-X-Sender: gene099@racer.site
In-Reply-To: <20080213130304.GA19957@grahamcox.co.uk>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73790>

Hi,

On Wed, 13 Feb 2008, Graham Cox wrote:

> We have a small project that is being managed in a Git repository 
> (MSysGit to be exact) - mostly for backups and so on. The project is a 
> mod for the computer game Civilization 4. (Actually a mod of a mod, but 
> still...)  As such, to release the mod to other people to actually use 
> the only thing that needs to be released is all of the files that have 
> actually been changed. (The actual git repository contains ~700MB of 
> files, the vast majority of which haven't changed since the initial 
> import and so don't need to be downloaded by people).
> 
> I've managed to make it produce an archive that contains only the files 
> that have changed by using a combination of git-archive and 
> git-whatchanged, along with grep and sed, but it's kinda unwieldly. Is 
> there a better way of doing this?
> 
> The command line I used was something like (This is mostly from memory):
> git-archive --format=zip . `git-whatchanged <start>..HEAD --pretty=oneline 
>   | grep '^:' | sed 's/^.*\t//'` > release.zip
> 
> To produce a zip containing all of the modified and added files for the 
> revision range <start>..HEAD.

Mebbe

	git archive --format=zip HEAD \
		$(git diff-tree -r --name-only --diff-filter=AM \
			<start>..HEAD)

Hmm?

Ciao,
Dscho
