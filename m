From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 11:21:05 -0500
Message-ID: <9e4733910711280821s3872eff5m95073ca6b1b8a689@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	 <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
	 <20071128093403.GB12977@diana.vm.bytemark.co.uk>
	 <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com>
	 <20071128160410.GB19302@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPfH-00075x-1N
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814AbXK1QVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757568AbXK1QVI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:21:08 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:5990 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757908AbXK1QVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 11:21:07 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1126130nze
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LjSIouJkknAjKKGmco6D4f08PnSGHbpu9USBODLNsMo=;
        b=WzbKy2m4AODbBvOjMX2LJuAmkwkRk+nAPxmRfWi3omaXoogTAyYwnnZo54nz0jYcwTYqOuNARx6lerFqVZeWbqgFPO2SZjRnRXpMFU0J9XjqJnf3SxjuUUxmYkNp7bT4140yK8Lo+f3g4+G9/jc6GgahEpbq74IwSro05E1pdBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y1gGdt9izEpo5TPH3lgdKP3cZMabmpA2XYMGFHsV4h1lR69k27Brtoq9aRmkGEzocYS6sxt19VwTQiFiWTHQuOXPI+mTqrCs9aDWBSl8eHLOsCkXZDpyqHiAerb9Pch0DSl0IdgTX+FriK4CV8lv76d5/0lmZVPEHdEuNiKRbKI=
Received: by 10.115.90.1 with SMTP id s1mr387668wal.1196266865735;
        Wed, 28 Nov 2007 08:21:05 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 08:21:05 -0800 (PST)
In-Reply-To: <20071128160410.GB19302@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66368>

On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-28 10:06:57 -0500, Jon Smirl wrote:
>
> > I did this:
> > all pataches were applied
> > git rebase
>
> At this point, a simple "git reset --hard HEAD@{1}" should have fixed
> the problem. Not much use knowing that now, I know, but still ... :-)
>
> > stg repair -- partial repair, some patches empty, half are pushed
>
> Modulo any bugs, this should have adjusted the appliedness of your
> patches to match the new HEAD (patches are applied iff they are
> reachable from HEAD) and made patches of any non-patch commits sittin=
g
> between a patch and HEAD. Nothing else. In particular, it doesn't
> change your existing patches or change HEAD, so those empty patches
> were empty even before the repair. (Modulo any bugs, of course, but
> that kind of bug seems really unlikely.)

I don't know exactly what is going one, but all of my patches are in
commits in front of the rebase. I believe when they were applied
again, git detected that the changes were already in the tree and that
why the patches are empty. Normally stg would have popped all my
patches before doing the rebase.

I have messed the branch up doing manual recover, but the conditions
are easy enough to recreate.


>
> > moved HEAD back in front of rebase
> > stg repair - it show all my patches as popped,
>
> That sounds OK. You reset HEAD to a commit early enough in history
> that no patches are reachable from it.
>
> > but when I started doing command it complain that some commits that
> > stg needed were not there.
>
> That sounds seriously broken. What exactly was the complaint? Missing
> commit objects?
>
> > The complaint was caused by the first repair. The first repair
> > altered some of the stg state to point at commits past the rebase.
>
> Yes. It would have made patches out of some of the rebased commits, i=
n
> order to give you a consistent state. For example, assume you started
> with the following situation:
>
> (cN are commits, pN are commits that are also StGit patches)
>
>    ...---c0---c1---p0---p1---p2---p3---p4:HEAD
>
> You git-rebase, causing a situation like this:
>
>    ...---c0---c1---p0---p1---p2---p3---p4
>                          \
>                           c2---c3---c4---c5---c6---c7---c8:HEAD
>
> "stg repair" at this point will see that p2..p4 should be unapplied
> since they aren't reachable from HEAD, and c2..c8 need to be made
> patches since they are on top of p1.
>
> Generally, what you want to do is to git-reset to the commit you want
> HEAD to be, and _then_ run stg repair.
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
