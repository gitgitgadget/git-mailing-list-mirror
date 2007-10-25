From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Feature request: Limit git-status reports to a directory
Date: Thu, 25 Oct 2007 10:55:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710251050390.25221@racer.site>
References: <ffofbm$lmc$1@ger.gmane.org> <46dff0320710241914t7d93aae1t991fbcaacde77046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michel Marti <mma@objectxp.com>, git@vger.kernel.org
To: Yin Ping <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkzSF-0006Cu-II
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 11:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759570AbXJYJzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 05:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759126AbXJYJzp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 05:55:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:53870 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759517AbXJYJzo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 05:55:44 -0400
Received: (qmail invoked by alias); 25 Oct 2007 09:55:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 25 Oct 2007 11:55:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JEJdbFc0JlE90VxQj7x9wKS0Bsi3kAEeG+jphVi
	jqscC6/H7upw7Z
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320710241914t7d93aae1t991fbcaacde77046@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62289>

Hi,

On Thu, 25 Oct 2007, Yin Ping wrote:

> On 10/25/07, Michel Marti <mma@objectxp.com> wrote:
> > I am sometimes interested in only seeing the status for a specific 
> > directory (and its sub-directories), but git-status is no help in this 
> > case - passing a directory does some sort of "git-commit --dry-run". I 
> > first thought that this is a bug until I saw in the man-page that this 
> > is actually a feature...
>
> It's also painful for me. IMHO, the behaviour of "git-status" should 
> keep consistent with "git-diff" and "git-log" which allow for the path.

I am not so sure.  In other SCMs, "git status" may be a way to do "git 
diff --name-only" or "git ls-files", but not in git.  Here, it strictly 
means "what would be happening if I were to commit _right_ _now_?".

> Another point, It will be helpful to add a config item to change the 
> default behaviour for 'git-diff" and "git-log". For example, 
> 'diff.defaultcurrentpath=true' to let git only show difference in 
> current directory instead of difference in top directory when typing 
> 'git-diff'

IMHO it is not asking users too much when you say "git diff ." is for the 
current directory, and "git diff" is for the whole working tree.

Besides, we cannot really change the default behaviour, since some 
porcelains use "git log" (and certainly there are some which use "git 
diff", too).  They would suffer from this unexpected -- and indeed 
inconsistent, since the setting can differ between repositories -- output.

Hth,
Dscho
