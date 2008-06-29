From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/2] Convert "stg refresh" to the new infrastructure
Date: Sun, 29 Jun 2008 15:46:54 +0200
Message-ID: <20080629134654.GB5098@diana.vm.bytemark.co.uk>
References: <20080625042337.6044.53357.stgit@yoghurt> <b0943d9e0806290242q1bc8aa67qb3523221b3db70e2@mail.gmail.com> <20080629102147.GA5098@diana.vm.bytemark.co.uk> <b0943d9e0806290407h5eecd27bg510dd09e0188abca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 15:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxG5-0002hW-De
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 15:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbYF2NrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 09:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbYF2NrE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 09:47:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3091 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbYF2NrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 09:47:03 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KCxF0-0001vh-00; Sun, 29 Jun 2008 14:46:54 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806290407h5eecd27bg510dd09e0188abca@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86801>

On 2008-06-29 12:07:42 +0100, Catalin Marinas wrote:

> 2008/6/29 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-06-29 10:42:32 +0100, Catalin Marinas wrote:
> >
> > > Does it make sense to refresh an unapplied patch? Maybe adding a
> > > new file to the patch but I don't really see a need for this.
> >
> > But no, I don't have a strong sense that this is super useful. It
> > was just easy to allow, so I allowed it.
>
> It seems harmless, unless someone finds some unusual behaviour. What
> is the conflict behaviour? Is the refresh aborted? For unapplied
> patches, it is more complicated to let the user solve the conflict.

=46irst, the refresh is stored in a temp patch. Then, that patch is
popped. Then we try to coalesce the temp patch and the target patch;
if this fails due to conflicts that we can't represent because we have
no index and worktree to work with for unapplied patches, we just
leave the temp patch in the stack for the user to deal with. (E.g. by
trying to apply the two patches and sort out the conflicts, by keeping
the temp patch separate, or by coalescing it with a different patch.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
