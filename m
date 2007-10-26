From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: recent change in git.git/master broke my repos
Date: Fri, 26 Oct 2007 09:39:55 +0200
Message-ID: <20071026073955.GB11286@diana.vm.bytemark.co.uk>
References: <86oden6z97.fsf@blue.stonehenge.com> <20071025150107.GB31196@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlJoB-0007M9-C5
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbXJZHk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2007 03:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbXJZHk3
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:40:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3289 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbXJZHk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:40:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IlJnQ-000317-00; Fri, 26 Oct 2007 08:39:56 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710251344220.22100@xanadu.home>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62398>

On 2007-10-25 13:46:04 -0400, Nicolas Pitre wrote:

> On Thu, 25 Oct 2007, Karl Hasselstr=F6m wrote:
>
> > On 2007-10-25 07:32:36 -0700, Randal L. Schwartz wrote:
> >
> > > And when are we gonna get "fast forward only" for git-merge?
> >
> > I'd like that too. For cases when I know I don't have to do a
> > merge, and want git to yell at me if I'm mistaken. For example, in
> > a repository that tracks an upstream so I can build the latest
> > version, but where I don't normally do any development.
>
> Isn't that called a remote branch that gets updated with "git
> fetch'?

Sure, I could use a detached HEAD instead of a local branch. However,
that'll still not warn me that merging in another branch won't be a
fast-forward.

> You can even trick Git into not using the refs/remotes/ namespace
> for them if you wish.

I'm not sure what'll happen if git fetch tries to update a branch that
I've made local changes to, but I don't imagine it's anything
productive. If not forced it'll fail, and if forced it'll lose my
local commits. The former might actually be sort of what I want (git
complains when I have local commits), but I'm rather fond of the
refs/remotes/ stuff, so this solution sounds like a hack to me. What I
really want is an "extra careful" merge that is guaranteed to do
nothing but a fast-forward if it succeeds.

As is, it's a two-line shell script, though, so it isn't that
important.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
