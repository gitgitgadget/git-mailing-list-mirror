From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Git branching & pulling
Date: Sun, 20 May 2007 22:30:24 +0200
Message-ID: <200705202230.24362.Josef.Weidendorfer@gmx.de>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com> <7vveepxr7m.fsf@assigned-by-dhcp.cox.net> <d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Wink Saville" <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:13:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq31Z-0006Jc-6I
	for gcvg-git@gmane.org; Mon, 21 May 2007 10:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755251AbXEUINm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 04:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbXEUINm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 04:13:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:38067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755251AbXEUINm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 04:13:42 -0400
Received: (qmail invoked by alias); 21 May 2007 08:13:40 -0000
Received: from p5496B42B.dip0.t-ipconnect.de (EHLO noname) [84.150.180.43]
  by mail.gmx.net (mp038) with SMTP; 21 May 2007 10:13:40 +0200
X-Authenticated: #352111
X-Provags-ID: V01U2FsdGVkX1+dUIh6IzuddIcs9Ck543MhQe0Nw3VKD3FfnObfJ5
	YztURLanhfZpGN
User-Agent: KMail/1.9.6
In-Reply-To: <d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47993>

On Saturday 19 May 2007, Wink Saville wrote:
> wink@ic2d1:~/testgit-clone$ git-checkout -b test master
> Switched to a new branch "test"
> wink@ic2d1:~/testgit-clone$ git-pull .
> Already up-to-date.
> wink@ic2d1:~/testgit-clone$ git-pull . master
> Already up-to-date.
> wink@ic2d1:~/testgit-clone$ git-pull
> Warning: No merge candidate found because value of config option
>          "branch.test.merge" does not match any remote branch fetched.
> No changes.
> wink@ic2d1:~/testgit-clone$
> 
> Why did last git-pull generate the warning, this seems wrong?

Because git does not know what to merge; there is no config entry
for "branch.test.merge", as the warning says. How would you reword
this warning to make it easier to understand?

But from your question, I assume that you expected git to have a
"branch.test.merge" setting.
What do you expect it to do? And why?

Is my assumption correct that you want the last command to be equivalent
to "git-pull . master"? And my further assumption, that you want this
because you expect "git pull" to default to merging changes from its
upstream (also when the upstream is local)?

Creation of a branch from another local one never has created
"branch.x.remote" or "branch.x.merge" entries. I am not even sure
that setting "branch.x.remote" to "." is working in the current version.

BTW: There was some old behavior of "git pull" to always pull the master
branch from remote "origin" without any further parameters. I suppose that
you did not want this to happen in your example above ?!

Josef
