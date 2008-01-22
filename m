From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Coping commits from one branch to another
Date: Tue, 22 Jan 2008 16:03:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801221601570.5731@racer.site>
References: <8e04b5820801220745m3736686exf631f31c9e6d785a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 17:04:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHLbb-0002Fm-5U
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 17:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYAVQDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 11:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbYAVQDR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 11:03:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752534AbYAVQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 11:03:17 -0500
Received: (qmail invoked by alias); 22 Jan 2008 16:03:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 22 Jan 2008 17:03:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/azO4LvlTaoCHzD0Ir7jJhAKaP4dwInO+qkXiLG9
	L4HBK9XkuyQ51X
X-X-Sender: gene099@racer.site
In-Reply-To: <8e04b5820801220745m3736686exf631f31c9e6d785a@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71459>

Hi,

On Tue, 22 Jan 2008, Ciprian Dorin Craciun wrote:

>     Hello all!
> 
>     My question is how can I use git-rebase -- or a similar command --
> to actually copy the commits from one branch to another.
> 
>     For example I have cloned the linux kernel repository and I have
> the following branches:
>     -- v2.6.22-stable
>     -- v2.6.23-local
>     -- v2.6.23-stable
>     -- v2.6.23-local
> 
>     The difference between v2.6.x-stable and v2.6.x-local are just a
> few minor patches (which are not in the default kernel tree) and some
> script files added to make the compilation and deployment easier for
> my setup. Thus v2.6.x-local is an ancestor of v2.6.x-stable. Now when
> v2.6.24 will arrive I would like to "copy" the commits from
> v2.6.23-local to v2.6.24-local.
> 
>     One solution would be to use:
>     git rebase --onto v2.6.24-local v2.6.23-stable v2.6.23-local
> 
>     But this will not copy the commits, but actually move them. (And I
> do not see anything about this case in the git rebase documentation,
> or pointers to other commands similar to rebase.)

Very easy.  Do this before rebasing:

	git checkout -b v2.6.24-local v2.6.23-local

then proceed with

	git rebase --onto 2.6.24-stable v2.6.23-stable

Hth,
Dscho
