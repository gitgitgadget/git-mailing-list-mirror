From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Tue, 18 Nov 2008 06:56:05 +0100
Message-ID: <200811180656.05324.chriscool@tuxfamily.org>
References: <gfs9hn$hq9$1@ger.gmane.org> <200811172047.03669.chriscool@tuxfamily.org> <alpine.LNX.2.00.0811171350540.4238@x9.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 06:55:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2JYY-0005KQ-MZ
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 06:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbYKRFyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Nov 2008 00:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbYKRFyG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 00:54:06 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:36957 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbYKRFyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Nov 2008 00:54:05 -0500
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D6EBA12B6BE;
	Tue, 18 Nov 2008 06:54:02 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B34C612B6BC;
	Tue, 18 Nov 2008 06:54:02 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0811171350540.4238@x9.ybpnyarg>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101261>

Le lundi 17 novembre 2008, walt a =E9crit :
> On Mon, 17 Nov 2008, Christian Couder wrote:
> > Le lundi 17 novembre 2008, walt a =E9crit :
> > > I'm trying to find a bug introduced somewhere between kvm-69
> > > and kvm-70, so of course I want to git-bisect down to it.
> > >
> > > The weirdness is that when I give git-bisect the good and
> > > bad tags, almost everything in my working directory just
> > > disappears, leaving only the qemu subdirectory behind.
> > >
> > > Can anyone else reproduce this with the kvm.git repo?
> > > (I don't see this problem with the linux.git repo or the
> > > git.git repo, so it seems to be something with the kvm.git
> > > repo itself.)
> >
> > I cannot reproduce this:
> >
> > $ git bisect start kvm-70 kvm-69
> > Bisecting: 846 revisions left to test after this
> > [80bfc25f42db6d4715c7688ae2352c5a8038fe7e] ntfs: le*_add_cpu conver=
sion
> > $ find . -type f |wc -l
> > 24286
> > $ git bisect reset
> > Previous HEAD position was 80bfc25... ntfs: le*_add_cpu conversion
> > Switched to branch "master"
> > $ find . -type f |wc -l
> > 24384
>
> Your numbers are so different from mine I'm wondering if we are using
> different repositories.
>
> $~/src/kvm-userspace find . -type f | wc -l
> 1715
>
> $~/src/kvm-userspace git bisect start kvm-70 kvm-69
> Bisecting: 176 revisions left to test after this
> [06508be8108f785caead849a717c9e6d67da62d7] Un-break MIPS conditional
> moves, by Richard Sandiford.
> wa1ter@k9:~/src/kvm-userspace find . -type f | wc -l
> 1413
>
> $~/src/kvm-userspace cat .git/config
> [core]
>         repositoryformatversion =3D 0
>         filemode =3D true
>         bare =3D false
>         logallrefupdates =3D true
> [remote "origin"]
>         url =3D git://git.kernel.org/pub/scm/virt/kvm/kvm-userspace.g=
it

I cloned this one:

[remote "origin"]
        url =3D git://git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.=
git

Sorry I didn't know which should be used, as I am not a kernel develope=
r.

Regards,
Christian.

>         fetch =3D +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote =3D origin
>         merge =3D refs/heads/master
>
> I track Junio's git.git and it's current as of this morning, but I
> also tried git v1.5.0 (chosen at random) and got the same results.
> What repo are you using?
>
> Thanks.
