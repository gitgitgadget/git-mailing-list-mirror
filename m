From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 07:50:47 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711300745330.8458@woody.linux-foundation.org>
References: <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org>
 <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net> <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
 <20071130152942.GA22489@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi B?jar <sbejar@gmail.com>, Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:53:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy8At-0002yM-Tz
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 16:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932878AbXK3PwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbXK3PwX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 10:52:23 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58110 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935034AbXK3PwW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 10:52:22 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAUFomZM025195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Nov 2007 07:50:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAUFolLV013398;
	Fri, 30 Nov 2007 07:50:48 -0800
In-Reply-To: <20071130152942.GA22489@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.689 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,TW_QG
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66647>



On Fri, 30 Nov 2007, Jeff King wrote:
>
> On Fri, Nov 30, 2007 at 04:28:21PM +0100, Santi B=E9jar wrote:
> > > But I am not opposed to having some "git foo" form for gitk.
> >=20
> > In mercurial "hg view" is actually an old version of gitk modified =
for hg.
> >=20
> > And as "git view" it could be added to the "git help" list.
>=20
> Unfortunately, there is already a "gitview" program similar to gitk,
> although it never made it out of contrib/.

Well, different people will want different viewers *anyway* (ie some wi=
ll=20
prefer qgit etc), so how about making "git view" be something that=20
literally acts as a built-in alias that just defaults to running gitk (=
if=20
for no other reason than the fact that gitk is the one that ships with=20
git, and simply has most users).

There's a few other things that I think we could consider to be good=20
built-in aliases: things like "git cat" being an alias for "git -p=20
cat-file -p" etc.

The only difference between a "built-in alias" and a "built-in command"=
=20
would be:
 - the alias has never even had the "git-xyz" format, and never will
 - the alias can be overridden by user aliases unlike "real" git comman=
ds

Hmm?

That way we can hide away gitk too (although I do suspect that we might=
 as=20
well just leave gitk in the path - it's different in naming from all th=
e=20
git-xyz commands anyway)

		Linus
