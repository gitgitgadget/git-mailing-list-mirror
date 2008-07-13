From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-bisect: use dash-less form on git bisect log
Date: Sun, 13 Jul 2008 08:19:24 +0200
Message-ID: <200807130819.24206.chriscool@tuxfamily.org>
References: <1215792089-27201-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 08:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHusx-0004p9-4w
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 08:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYGMGPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2008 02:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbYGMGPi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 02:15:38 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:41364 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124AbYGMGPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 02:15:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4A2D61AB2D4;
	Sun, 13 Jul 2008 08:15:35 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E55FE1AB2C6;
	Sun, 13 Jul 2008 08:15:34 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1215792089-27201-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88287>

Le vendredi 11 juillet 2008, Miklos Vajna a =E9crit :
> Given that users are supposed to type 'git bisect' now, make the outp=
ut
> of 'git bisect log' consistent with this.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Fri, Jul 11, 2008 at 08:39:14AM +0200, Christian Couder=20
<chriscool@tuxfamily.org> wrote:
> > Wouldn't it be better if bisect_replay could read old logs?
> >
> > Maybe with something like:
> >
> > +     while read git bisect command rev
> >       do
> > -             test "$bisect" =3D "git-bisect" || continue
> > +             test "$git $bisect" =3D "git bisect" -o "$git" =3D
> > "git-bisect" || continue
> > +             if test "$git" =3D "git-bisect"; then
> > +                     rev=3D"$command"
> > +                     command=3D"$bisect"
> > +             fi
>
> You are right, here is an updated patch.

Your patch looks good. But there is also the problem that new bisect lo=
gs=20
will not be understood by old git. So I wonder if a patch to only read =
the=20
new log should be first commited to the "maint" branch.

And sorry but I will be on vacation without Internet access for one wee=
k=20
starting really soon now, so I will not be able to do anything soon, no=
r=20
answer to any mails.

Thanks,
Christian.
