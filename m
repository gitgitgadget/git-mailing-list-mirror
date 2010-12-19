From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Basic Git Questions
Date: Mon, 20 Dec 2010 00:15:16 +0100
Message-ID: <201012200015.17203.trast@student.ethz.ch>
References: <AANLkTiki2e4-YD0P9kb7g-WbLTPhAXQ22R2jCAXVtjN1@mail.gmail.com> <20101219230839.GM3264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	<git@vger.kernel.org>
To: Parag Kalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 00:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUSTM-0005UR-N9
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 00:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537Ab0LSXPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 18:15:20 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40035 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932479Ab0LSXPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 18:15:19 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 20 Dec
 2010 00:15:10 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 20 Dec
 2010 00:15:18 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101219230839.GM3264@localhost.localdomain>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163974>

Konstantin Khomoutov wrote:
> > 2. Also sometime when the code is committed, I realize that I have
> > forgot to change or add a file. Is there a way we can we commit a file
> > to existing commit number with git log showing only the old git commit
> > number and not creating a new one for the last commit.
> `git commit --amend` does exactly that -- amends the last commit
> (pointed by the HEAD ref).

Let me add that you can fundamentally not edit any git object in any
way without its ID (hash, sha1, whatever you call it) changing.  All
methods of "changing" commits, like amend, rebase, filter-branch
etc. always create a new object.  The trick is that, especially with
amend, the branch is also changed to point to the new one, so unless
you have already merged or pushed that commit, this is as close to
"changing" as it gets.

Tv put this more eloquently as: "you can never change; you can only
rewrite and forget".

If you *have* merged or pushed the commit, you shouldn't rewrite
history.  It's not that hard to fix up your local merges, but if you
have pushed the history and others have started working with it, it's
*very* annoying for them.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
