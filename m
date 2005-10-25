From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Convention for help in git commands?
Date: Tue, 25 Oct 2005 23:35:47 +0200
Message-ID: <200510252335.47917.Josef.Weidendorfer@gmx.de>
References: <200510251508.43552.Josef.Weidendorfer@gmx.de> <7vfyqpe87x.fsf@assigned-by-dhcp.cox.net> <46a038f90510251324s50911b88pb5eabb304644bcad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 23:38:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUWSU-0002v7-Lq
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 23:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVJYVfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 17:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVJYVfr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 17:35:47 -0400
Received: from pop.gmx.de ([213.165.64.20]:54202 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932396AbVJYVfr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 17:35:47 -0400
Received: (qmail invoked by alias); 25 Oct 2005 21:35:45 -0000
Received: from p5496A126.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.161.38]
  by mail.gmx.net (mp012) with SMTP; 25 Oct 2005 23:35:45 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <46a038f90510251324s50911b88pb5eabb304644bcad@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10621>

On Tuesday 25 October 2005 22:24, you wrote:
> On 10/26/05, Junio C Hamano <junkio@cox.net> wrote:
> > > * For commands which need at least one argument, the usage
> > > is also printed, if the command is run without argument
> >
> > This is slightly debatable.  I'd rather see it error out for one
> > thing, and we might want to do a sane default given no arguments
> > later.
> 
> This could lead to subtle bugs when git is used by porcelains. If
> there are going to be changes in default behaviours, let's have them
> soon-ish ;-)

What is the difference for a porcelain between error out,
presumable with an error message, and printing the usage alone?

Is there any dependency of porcelains to the fact the e.g.
"git-rev-list" currently does nothing if not called with a
commit-id? Somehow I think "git-rev-list" should give an error,
as the usage string (with lots of options on a line of its own ?!)
requires a commit-id as argument.

BTW, the error message of "mv" is:
===
mv: missing file operand
Try `mv --help' for more information.
===
What about something similar to this? Mentioning the command
which triggered the error is probably a good idea.

And I would add as another convention:
* "git-cmd -h" always should give the usage, and not error out
with "fatal: Not a git repository" before.

Josef
