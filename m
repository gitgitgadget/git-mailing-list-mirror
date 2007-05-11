From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Using StGIT for tweaking already-committed stuff
Date: Sat, 12 May 2007 00:43:25 +0200
Message-ID: <20070511224325.GA13310@diana.vm.bytemark.co.uk>
References: <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070510200253.GD4489@pasky.or.cz> <20070510222347.GB12366@diana.vm.bytemark.co.uk> <20070511204016.GH19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	catalin.marinas@gmail.com, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat May 12 00:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmdqX-0004Rr-9N
	for gcvg-git@gmane.org; Sat, 12 May 2007 00:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbXEKWoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 18:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbXEKWoQ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 18:44:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4353 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbXEKWoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 18:44:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hmdpe-0003yI-00; Fri, 11 May 2007 23:43:26 +0100
Mail-Followup-To: Yann Dirson <ydirson@altern.org>,
	Petr Baudis <pasky@suse.cz>, Carl Worth <cworth@cworth.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, catalin.marinas@gmail.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070511204016.GH19253@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46994>

On 2007-05-11 22:40:17 +0200, Yann Dirson wrote:

> On Fri, May 11, 2007 at 12:23:47AM +0200, Karl Hasselstr=F6m wrote:
>
> > But you can kind of do it today. Just commit with git (my favorite
> > here is the emacs modes) and "stg assimilate"!
>
> Well, that's arguably a non-orthodox way of doing things, I like the
> idea your "stg new" patch much better :)

It's only unothodox if you expect git and stgit to not always mix so
well. But if we have the ambition that they should interoperate as
near to seamlessly as we can make them, this kind of workflow becomes
very natural.

It shouldn't be necessary with a manual "assimilate" step. If stgit
finds that there are unadorned git commits on top of the patch stack,
it should do the assimilation automatically. With that in place, "stg
new" and "stg refresh" would be nearly superfluous, since git-commit
with and without --amend does the same thing -- the only thing they
won't do is give the user the option of manually choosing the patch
name.

I believe this sort of integration is the way to go. It'll be
beneficial for git users who want to occasionally use some stgit to
rebase their patch series, since they'll not have to learn more than
two or three new commands in addition to the git they already know.
Heavy stgit users will benefit from having the much larger git
community maintaining a large subset of the porcelain they use,
instead of having to duplicate the effort and always lag behind.

This is no binary choice, of course. One could certainly imagine a
compromise where stgit becomes much easier to mix with git than today,
but still retains the current command set.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
