From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/4] Handle non-ASCII filenames
Date: Tue, 3 Jun 2008 11:27:27 +0200
Message-ID: <20080603092727.GA13132@diana.vm.bytemark.co.uk>
References: <200806011046.51872.jnareb@gmail.com> <20080602214212.18768.63775.stgit@yoghurt> <b0943d9e0806030056x588474dcha3e14dd8dca952ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 11:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Sop-0004I6-2L
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 11:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYFCJ1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 05:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYFCJ1o
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 05:27:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2103 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbYFCJ1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 05:27:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K3Snf-0003RX-00; Tue, 03 Jun 2008 10:27:27 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806030056x588474dcha3e14dd8dca952ba@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83629>

On 2008-06-03 08:56:38 +0100, Catalin Marinas wrote:

> On 02/06/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I fixed the first problem, and while doing so noticed that a
> > nearby block of code had exactly the same bug. So I fixed that as
> > well.
>
> That was fast :-). thanks.

Jakub reported the bug right before I was about to start hacking
anyway. :-)

> >  Catalin, this should go on the stable branch, I believe. It
> >  probably warrants a new release too, since anyone rebasing
> >  patches past the point where the "M=E4rchen" file was removed from
> >  git.git is going to hit the same bug Jakub did.
>
> Yes, it will go in both stable and master. There are some more
> patches on stable already, I'll try to release 0.14.3 this weekend.

Splendid. You can pull from my "stable" branch if you like.

> Is the new infrastructure affected? We haven't got to the point of
> converting "rebase" yet (doesn't have all the functionality it needs
> in the new infrastructure).

The problem wasn't actually about rebase. It was about mangling of
diff-index and diff-files output in tree_status(). I think if one were
to look closely, a largish number of commands would be found to be
affected.

The new infrastructure won't have this problem, by virtue of not
having any such calls yet. Plus, I try to use the -z flag whenever I
can from the outset.

> BTW, I created a new lib.git.Branch class as the parent of
> lib.git.Stack and it takes care the extra things used when creating
> a new stack like setting parent and remote branches. I'll post the
> patches in the next few days.

Looking forward to it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
