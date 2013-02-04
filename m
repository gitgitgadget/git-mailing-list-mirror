From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Sun, 3 Feb 2013 18:42:51 -0600
Message-ID: <20130204004251.GA6243@kroah.com>
References: <20130131172805.GC16593@kroah.com>
 <510AB910.5050504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2CeI-0008Cs-SM
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 04:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032Ab3BDDWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2013 22:22:39 -0500
Received: from mail.kernel.org ([198.145.19.201]:49286 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826Ab3BDDWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 22:22:36 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 135AD20265;
	Mon,  4 Feb 2013 03:22:35 +0000 (UTC)
Received: from localhost (1007host2.starwoodbroadband.com [12.108.174.2])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1F32A20268;
	Mon,  4 Feb 2013 03:22:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <510AB910.5050504@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215353>

On Thu, Jan 31, 2013 at 07:33:52PM +0100, Ren=E9 Scharfe wrote:
> Am 31.01.2013 18:28, schrieb Greg KH:
> > I tracked this down to commit 22f0dcd9634a818a0c83f23ea1a48f2d620c0=
546
> > (archive-tar: split long paths more carefully).  The diff of a hex =
dump
> > of the tar archives shows the following difference:
> >=20
> > --- old_git_archive	2013-01-31 17:31:24.466343388 +0100
> > +++ new_git_archive	2013-01-31 17:32:21.509674417 +0100
> > @@ -19239998,8 +19239998,8 @@
> >  125943d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  125943e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  125943f0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> > -12594400:0000 0000 0000 0000 0000 0000 0000 0000  ................
> > -12594410:0000 0000 0000 0000 0000 0000 0000 0000  ................
> > +12594400:7765 7374 6272 6964 6765 2d6f 6d61 7033  westbridge-omap3
> > +12594410:2d70 6e61 6e64 2d68 616c 2f00 0000 0000  -pnand-hal/.....
> >  12594420:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  12594430:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  12594440:0000 0000 0000 0000 0000 0000 0000 0000  ................
> > @@ -19240025,8 +19240025,8 @@
> >  12594580:2f61 7374 6f72 6961 2f61 7263 682f 6172  /astoria/arch/ar
> >  12594590:6d2f 706c 6174 2d6f 6d61 702f 696e 636c  m/plat-omap/incl
> >  125945a0:7564 652f 6d61 6368 2f77 6573 7462 7269  ude/mach/westbri
> > -125945b0:6467 652f 7765 7374 6272 6964 6765 2d6f  dge/westbridge-o
> > -125945c0:6d61 7033 2d70 6e61 6e64 2d68 616c 0000  map3-pnand-hal..
> > +125945b0:6467 6500 0000 0000 0000 0000 0000 0000  dge.............
> > +125945c0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  125945d0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  125945e0:0000 0000 0000 0000 0000 0000 0000 0000  ................
> >  125945f0:0000 0000 0000 0000 0000 0000 0000 0000  ................
>=20
> This is the only directory in the repository whose path is long enoug=
h to
> make a difference with the patch, 105 characters in total:
>=20
> drivers/staging/westbridge/astoria/arch/arm/plat-omap/include/mach/we=
stbridge/westbridge-omap3-pnand-hal/
>=20
> Five characters less and you wouldn't notice a thing.  It contains
> "westbridge" thrice, so I think it's cheating just to reach that
> length, though. ;-)

Yeah, that file path was bad, which is just one reason why it was
deleted from the kernel in newer versions :)

> > Interestingly, the output of uncompressing the tar archives is
> > identical, so the data is correct, but the binary isn't.
>=20
> The path is split differently between two header fields, that's all.

Ok, thanks for the explaination, I didn't realize that.

> > Now keeping binary compatibility of tar archive files isn't really =
a big
> > deal, but, the commit to git that causes this seems a bit odd, is i=
t
> > really needed?  Or can we just fix the version of tar with NetBSD
> > instead?  :)
>=20
> Apart from Junio's suggestion, I can't think of a practical solution.
>=20
> You could downgrade your git to a version before the fix.  A downside=
 is
> that you won't be able to extract the archive on NetBSD without getti=
ng
> an error message (but the contents would be intact, except perhaps fo=
r
> permission bits of the directory above).
>=20
> You could upgrade the kernel.org version of git, but that might cause=
 the
> same problem for other maintainers with long directory paths who in t=
heir
> repositories who still use git without the fix.
>=20
> You could make the path shorter.  Won't help at all with the release =
you
> just did, of course.

What I ended up doing was just to revert your patch, generating a tar
archive that matches what the version on kernel.org.

And originally I now recall that this was something we were worried
about, but we put off dealing with it until it caused problems :)

> I don't know if other tar implementations freak out when they see an
> empty name field.  NetBSD's tar might seem a bit too strict here, but
> overall I think it's right in complaining.

Ok, thanks, I now agree.

> What makes the commit odd, by the way?

Sorry, I was originally thinking that you were working around a bug in
the NetBSD version of tar, not making it "more correct", which is
arguably the right thing to do here.

So I'll work with Konstantine to ensure we both are using the same
version of git in the future, it's our kernel.org infrastructure issue
here, not a git one, sorry for the noise.

greg k-h
