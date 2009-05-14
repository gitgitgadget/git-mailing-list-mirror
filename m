From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for  git clone
Date: Thu, 14 May 2009 14:50:10 +0200
Message-ID: <200905141450.13057.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <7v8wl0xkcu.fsf@alter.siamese.dyndns.org> <81b0412b0905140145i4093e742x9f8c762e2bf32624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 14:51:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4aPS-0003vK-Au
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 14:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761417AbZENMvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 08:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761327AbZENMvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 08:51:16 -0400
Received: from mx01.qsc.de ([213.148.129.14]:36241 "EHLO mx01.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761376AbZENMvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 08:51:15 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx01.qsc.de (Postfix) with ESMTPA id B488B3D656;
	Thu, 14 May 2009 14:51:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905140145i4093e742x9f8c762e2bf32624@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119187>

Am Donnerstag, 14. Mai 2009 schrieb Alex Riesen:
> 2009/5/14 Junio C Hamano <gitster@pobox.com>:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> >
> >>> What's the point of this change, now that you have a fix in 1/2? =
=C2=A0Who are
> >>> you helping with this patch?
> >>
> >> Without this the _automatically_ generated names for cloned reposi=
tories
> >> have all the whitespace around them.
> >
> > Even if it has whitespace around its name, that's what you got from=
 the
> > upstream (a valid source of clone), and wasn't it you who said some=
thing
> > about UNIX tradition of allowing LF and others in the filename?
>=20
> Yes, when user explicitely asked a program about that. This here
> (clone with only URL as argument) is not the case, I think.
>=20
> > If clone reports "ok we created this new repository" so that the ca=
ller
> > can capture it, then the whole process should be able to cope with
> > automatically generated names with or without the patch, shouldn't =
it?
>=20
> No, don't think so. You're not always able to capture the output of g=
it clone
> (Windows again), and BTW - init-db output is not designed to be captu=
red
> unambiguously.
>=20
> > Or are you trying to help a human user who gives a pathname ridden =
with
> > excess whitespaces to "git clone", and that pathname _happens_ to w=
ork as
> > a valid clone source, creating a new repository whose name is ridde=
n with
> > excess whitespaces the same way as the input pathname?
>=20
> Not really. I just try to make the _generated_ output, which the user=
 cannot
> predict anyway (nor does the user care much about it) to be less
> problematic. Yes, I did say that LF-anything in UNIX filenames is a n=
ormal
> thing. That does not mean that such names are so very convenient to u=
se.
> They do cause problems, even if just through scrambling terminal outp=
ut.
> They are "inconvenient". If our users don't expect precise output any=
way,
> we can be a little more adhering to usual practices in choosing names=
=2E
>=20
> > ... After all, the
> > user deliberately gave them to us, and the repository we cloned fro=
m had
> > these excesses in its name (iow, without the excess whitespaces the=
 clone
> > itself wouldn't have worked). =C2=A0In such a case, is it really he=
lping him to
> > remove these whitespaces as excesses?
>=20
> I think yes. Otherwise the strict form of git clone could have been u=
sed,
> which involves absolutely no guessing and mangling.
>=20
This discussion began with the problem I encountered during a git clone=
=20
operation applied to an url which accidentally included a linefeed. It =
partly=20
went through although the remote side did not include that character.=20
After Alex Riesen fixed the git part by escaping linefeeds, the linefee=
d=20
left over in the top level directory name still caused a linux kernel=20
make to fail (which really is not problem of git or GNU make itself).=20
Elsewhere in this thread, Daniel Barkalow proposed to apply the HTTP=20
RFC to the whole url. If accepted,  this would cope with the problem in=
 a=20
standard way.=20
