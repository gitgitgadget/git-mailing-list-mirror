From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Strange behavior with git rebase (-i)
Date: Sat, 2 Feb 2008 15:42:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802021538300.7372@racer.site>
References: <47A44974.7050907@samba.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stefan (metze) Metzmacher" <metze@samba.org>
X-From: git-owner@vger.kernel.org Sat Feb 02 16:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLKWR-0002Nn-Li
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 16:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbYBBPmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 10:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756372AbYBBPmn
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 10:42:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:40867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755024AbYBBPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 10:42:42 -0500
Received: (qmail invoked by alias); 02 Feb 2008 15:42:40 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp030) with SMTP; 02 Feb 2008 16:42:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jEVZWD9JjMcCF+KbCsbL5eaESLcURHTohGIYtwB
	X1ulynPXHfhGFD
X-X-Sender: gene099@racer.site
In-Reply-To: <47A44974.7050907@samba.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72281>

Hi,

On Sat, 2 Feb 2008, Stefan (metze) Metzmacher wrote:

> [started git rebase -i]
> git commit --amend (again)
> git branch
>  * v4-0-test
> git log
>  (this showed what I wanted)
> git show -p --stat
>  (to really make sure that the top revision is the one I want)
> git push origin v4-0-test
>  And this pushed the top revision BEFORE the rebase!!!
>  Because I forgot a 'git rebase --continue' to finalize the rebase.

I don't believe it.  "git branch" would have shown "* (no branch)" as 
current branch, unless the rebase is finalized.

git rebase -i works on a _detached_ HEAD, for two reasons:

- easier working with reflogs (as the branch's reflog shows before rebase 
and after rebase, but nothing in between), and

- to prevent exactly the scenario you are describing.

Ciao,
Dscho
