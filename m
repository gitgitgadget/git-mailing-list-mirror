From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 09:37:39 +0200
Message-ID: <20070508073739.GA24409@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 08 09:38:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlKHT-0002pH-T3
	for gcvg-git@gmane.org; Tue, 08 May 2007 09:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934410AbXEHHik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934555AbXEHHik
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 03:38:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2587 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934410AbXEHHij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 03:38:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlKGR-0006RO-00; Tue, 08 May 2007 08:37:39 +0100
Content-Disposition: inline
In-Reply-To: <20070508014114.GC11311@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46550>

On 2007-05-07 21:41:14 -0400, Shawn O. Pearce wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I thought "git add -i" was the best thing since sliced bread --
> > until I found the same feature in git-gui, but with a _much_
> > better interface. Just right-click on a hunk in a diff, and you
> > have the option of staging/unstaging that hunk. Pure magic.
>
> "git add -i" has a hunk splitting feature that git-gui lacks. I'm
> thinking of adding features to git-gui to let you select a region of
> a hunk using the text selection, and then stage only that selection.

That would be useful. It's currently possible to split some hunks by
reducing the number of content lines, but if the changes aren't
separated by any unchanged lines at all, that doesn't work.

> I also want to let you revert hunks from the working directory copy.

That would be handy. But unlike stage/unstage, this can lose
information, so there'd need to be some kind of "are you _really_
sure? [Yes] [No]" safety hatch, which would make it less convenient.

> But after reading Junio's comments about "git add -i" being a
> possibly bad idea and instead letting you park everything into a
> shelf, reset --hard your working directory to HEAD and then pull
> things back off the shelf to be staged, I might want to do that
> differently in git-gui... like use a shelf. ;-)

A shelf could be handy. Actually, it could be handy to have more than
one. Then one could go through the mess in one's working directory and
toss changes into one bin for each commit one plans to create --
including one "trash" bin for hunks one would like to revert.

I assume that shelves would be implemented as branches that are
precisely one commit on top of HEAD? If so, I'd just like to point out
that they're exactly like unapplied patches in StGIT.

Hmm. I find it inconsistent to force or strongly encourage the user to
commit precisely the working directory changes and not a subset
thereof, which the shelf idea seems to encourage, while at the same
time not committing straight from the working directory but from a
specific staging area (the index).

> But I'm glad someone else finds the hunk feature useful in git-gui.
> I use it far too often myself.

I don't think it's a bad thing. If I've made several unrelated changes
and want to commit them separately for the sake of readable history,
how exactly is that a bad thing when compared to committing it all at
once? If I care about clean history in the first place, then
presumably I'll test the commits in isolation if I deem it necessary
-- and if I don't, then I probably won't test anyway even if the tool
makes it easy.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
