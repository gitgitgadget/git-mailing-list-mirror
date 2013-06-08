From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Sat, 8 Jun 2013 02:11:47 +0200
Message-ID: <20130608001147.GA32350@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
 <20130607191643.GA31625@goldbirke>
 <7vwqq5snzi.fsf@alter.siamese.dyndns.org>
 <20130607204430.GD31625@goldbirke>
 <7vk3m5si4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6l9-00085R-QV
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab3FHALv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:11:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57292 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FHALv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 20:11:51 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M7nzI-1UP9zn3SQi-00vDnn; Sat, 08 Jun 2013 02:11:48 +0200
Content-Disposition: inline
In-Reply-To: <7vk3m5si4h.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:3QsrGv8t8CPdAi5rNeRdWOVvlQhQXffS6qF/JKtvF4d
 0/QRIPEz/7v0RUxh6H5nsivvptC3v/5L3CgP7IJPeoGzngGx7j
 PTp+n9Hsh2LodM3a+CUr4a7owkSrpWt0IEse5onQgNK8oz+zLw
 KAN4gGCWIXYR0dQtKNoFRdsFGBRM4LFpFFTbmL1NEhuzZZDQm8
 +cvdFK9HKa/jAHPQaNWMJJwbmwyKi9qmNawKc6VtEAQwbb6+MZ
 TMdia1m5oLkw5qMbxFm62e2wNtQj1wZOiDmJsPPhCbpHZ8u1OI
 yrW0lWwkAJmFicsqKoEDD91VcExIrSq5PFl9kqhbGNk2y/TwWb
 5F/XSWaSLr+fZUrpYsVIH+j3CrBUKtMkWLNFTCWNt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226767>

On Fri, Jun 07, 2013 at 02:53:02PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > On Fri, Jun 07, 2013 at 12:46:25PM -0700, Junio C Hamano wrote:
> >> Thanks for a pointer.  I think what I was suggesting was slightly
> >> different in that I was hoping to see a single helper that knows t=
o
> >> complete to object names (possibly including trees/blobs with the
> >> treeish:path notation), ranges, and pathnames (not treeish:path
> >> notation) until it sees a "--" and then complete only to pathnames=
=2E
> >
> > We already got that except the completion of pathnames before "--",
> > and I don't know how that could be done properly for commands takin=
g
> > both refs and paths.
> > ...
> >   git diff git.c
> >   git diff master git.c
> >   git diff master next git.c
>=20
> It is somewhat annoying that "git diff gi<TAB>" stops at expanding
> it to "git diff git" and then upon another "git diff git<TAB>"
> offers tags whose names begin with "git" (e.g. gitgui-0.10.0) but
> the pathname git.c is not included in the choices.  My wish was to
> take the union in such a fairly limited case.  I tend to agree with
> you that "git diff <TAB>" that expands to all refs and pathnames
> would be useless, but so is expansion to all pathnames (or refnames
> for that matter).

=2E.. or trying to complete a branch name starting with a 'v', and then
getting all the vx.y.z tags.

If you know you want git.c, then you can force filename completion
either by entering "--" before hitting tab or by using the Alt-/ Bash
(readline?) keybinding, otherwise you'll get refs.  I think this is
more than adequate, as it brings the best of both worlds: you can
quickly and easily get both ref-only and file-only completion.
Training your fingers to type "--" is perhaps better, just in case
we'll ever do tracked-file-aware filename completion for e.g. 'git log
-- g<TAB>' in the future.


Best,
G=E1bor
