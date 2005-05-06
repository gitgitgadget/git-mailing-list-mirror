From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: tool to diff cache <-> working directory
Date: Fri, 6 May 2005 05:13:16 +0200
Message-ID: <20050506031316.GB11506@cip.informatik.uni-erlangen.de>
References: <20050506002347.GU20994@cip.informatik.uni-erlangen.de> <7vhdhhf88u.fsf@assigned-by-dhcp.cox.net> <20050506020759.GA11506@cip.informatik.uni-erlangen.de> <7vy8atdq7i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 05:07:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTtAy-0002Tl-Fs
	for gcvg-git@gmane.org; Fri, 06 May 2005 05:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVEFDNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 23:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEFDNW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 23:13:22 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:12007 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262199AbVEFDNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 23:13:18 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j463DGS8027141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 03:13:17 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j463DGI2027140
	for git@vger.kernel.org; Fri, 6 May 2005 05:13:16 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy8atdq7i.fsf@assigned-by-dhcp.cox.net>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Are you using pure GIT, without any Porcelain layer like Cogito?

no, I actually write a porcelain layer myself in perl. For several reasons:

	- I want something that runs on Solaris without gnu-utils
	- I want to understand the git internals.
	- I don't need branches and refs in .git

> Cogito has "cg-status" that shows something like "cvs -n update"
> output.

I just finished implementing my 'git status' command which does the
following:

	(faui01) [~/work/git/git] git status
	 + 1
	 ? 2
	 - COPYING
	D* Makefile
	 * commit.c
	D  export.c

	+/-/* -> add, rm, mod
	?     -> orphan (not under revision control)
	D     -> dirty -> was explicit modified in cache but cache doesn't match working copy

I also have a ignore list for known orphans:

	(faui01) [~/work/git/git] cat .git/ignore
	\.o$
	git-cat-file
	...
	git-write-tree
	libgit.a

Sincerely,
	Thomas
