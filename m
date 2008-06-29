From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/2] Convert "stg refresh" to the new infrastructure
Date: Sun, 29 Jun 2008 12:21:47 +0200
Message-ID: <20080629102147.GA5098@diana.vm.bytemark.co.uk>
References: <20080625042337.6044.53357.stgit@yoghurt> <b0943d9e0806290242q1bc8aa67qb3523221b3db70e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 12:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCu3e-0006mP-5b
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbYF2KWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 06:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbYF2KWA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 06:22:00 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3432 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbYF2KWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 06:22:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KCu2W-0001Pa-00; Sun, 29 Jun 2008 11:21:48 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806290242q1bc8aa67qb3523221b3db70e2@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86791>

On 2008-06-29 10:42:32 +0100, Catalin Marinas wrote:

> 2008/6/25 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > And in the process, make it more powerful: it will now first
> > create a temp patch containing the updates, and then try to merge
> > it into the patch to be updated. If that patch is applied, this is
> > done by popping, pushing, and coalescing; if it is unapplied, it
> > is done with an in-index merge.
>
> Does it make sense to refresh an unapplied patch? Maybe adding a new
> file to the patch but I don't really see a need for this.

A change in a different part of the same file should work as well, I
believe.

But no, I don't have a strong sense that this is super useful. It was
just easy to allow, so I allowed it.

> > Also, whenever path limiting is used, we will now use a temporary
> > index in order to avoid including all staged updates (since they
> > may touch stuff outside the path limiters).
>
> I haven't checked but what is the behaviour in subdirectors? It
> currently refreshes everythink unless "." is specified so that it
> will only refresh the current subdirectory.

That's the new behavior as well. Path limiters are taken to be
realtive to the current working directory, and without limiters we
refresh everything.

> The patch looks fine otherwise.

Thanks for the review.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
