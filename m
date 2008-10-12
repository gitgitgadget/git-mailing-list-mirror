From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 11:05:04 -0700
Message-ID: <20081012180504.GD4856@spearce.org>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org> <20081012064512.GA32597@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 12 20:06:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp5Kg-0000tf-1Q
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 20:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbYJLSFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYJLSFG
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 14:05:06 -0400
Received: from george.spearce.org ([209.20.77.23]:45325 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356AbYJLSFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 14:05:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8A9213835F; Sun, 12 Oct 2008 18:05:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081012064512.GA32597@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98041>

Jeff King <peff@peff.net> wrote:
> On Sat, Oct 11, 2008 at 11:41:18PM -0700, Junio C Hamano wrote:
> 
> > And just make it mimic whatever folks accustomed to "svn st" would expect,
> > modulo we would need two status letters to signal difference between
> > (HEAD, index), and (index, worktree).  Perhaps three if you want to show
> > difference between (HEAD, worktree) while at it.
> 
> I remember a long time ago you started on a parallel diff walker that
> could diff the working tree, the index, and a tree at once. Do you
> remember the issues with it?
> 
> I think that would be the right tool here to show each file only once,
> but with multiple status flags. Something like:
> 
>   A M foo

I have a tool that I'll be open-sourcing later this year, but it does
something like that:

  project foo/                        branch master
   Am   foo
   M-   bar
   R-   orig => dest ( 95%)

Line coloring is red on lines with unstaged stuff in the working
directory (3rd column, lower case letters) and green on lines that
are fully staged (3rd column is a '-').

The tool is in Python, but I'm just scraping the output of
`diff-index -M --cached HEAD` and diff-files to get that
display.  The status letters are exactly those given out by
diff-index/diff-files, but the diff-files output is lowercased.

Scott Chacon has seen the tool output and likes it; there's a tech
talk that will be posted on YouTube soon where he and I are sort
of talking about it.

Sorry I can't say too much more about it yet.  But I'm trying to
say that both Scott and I like a denser display like this.

-- 
Shawn.
