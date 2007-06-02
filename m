From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Sat, 2 Jun 2007 21:04:29 +0200
Message-ID: <20070602190429.GA6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070504081021.14786.77675.stgit@yoghurt> <20070506122116.GA18883@diana.vm.bytemark.co.uk> <20070506131554.GF19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070506133909.GG19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070506142233.GA20017@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 21:04:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuYtx-0002jz-UE
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 21:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831AbXFBTEc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 2 Jun 2007 15:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758669AbXFBTEc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 15:04:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55010 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757831AbXFBTEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 15:04:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5829F5A19B;
	Sat,  2 Jun 2007 21:04:29 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 5DC3D1F01B; Sat,  2 Jun 2007 21:04:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070506142233.GA20017@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48948>

On Sun, May 06, 2007 at 04:22:33PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-06 15:39:09 +0200, Yann Dirson wrote:
>=20
> > Well, this case clearly falls in the category of "actions outside
> > stgit that make it possible to rebase without a loss". But then it
> > is also clear that the action of tagging makes the committed patch
> > reachable, and thus the rebase loss-less.
> >
> > The safety check could be possibly be rewritten as "check if curren=
t
> > base is reachable without using any refs from current series".
>=20
> Yes, I like that idea _much_ better. That's what we _should_ be
> testing for, given that the objective is to keep all commits
> reachable.
>=20
> So, how can we do that? gitk displays, when you view a commit, the
> heads through which that commit is reachable. How does it compute
> that? Hmm, it seems like this type of construct works for selecting
> only those commits that are only reachable through a given ref:
>=20
>   gitk origin/pu --not $(git show-ref | grep -v refs/remotes/origin/p=
u| cut -f 1 -d ' ')
>=20
> Of course, one could use git log instead of gitk if it turns out to b=
e
> too hard to write an x-windows parser for stgit. :-)

Indeed, gitk calls git-rev-list with those arguments, so the check can
be easily rewritten :)

Best regards,
--=20
Yann
