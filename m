From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sat, 19 Jan 2008 17:04:09 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org>
 <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 02:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGOcq-0005aL-VB
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 02:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbYATBEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 20:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbYATBEx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 20:04:53 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33536 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbYATBEw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 20:04:52 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K14AIs012680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 17:04:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0K149Ar028968;
	Sat, 19 Jan 2008 17:04:09 -0800
In-Reply-To: <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71146>



On Sun, 20 Jan 2008, Wincent Colaiuta wrote:
>=20
> For what it's worth, their choice wasn't entirely "insane" ie. it did=
 have an
> element of rationality: that decomposed forms are a little bit simple=
r to
> sort.

No they are *not*.

In many languages, '=E4' does *not* sort like 'a' at all, and if you th=
ink=20
it does, you'll sort at least Finnish and Swedish totally wrong (=E5=E4=
=F6 are=20
real letters, and they sort at the *end* of the alphabet, they have=20
nothing what-so-ever to do with the letters 'a' or 'o').

The fact that in *some* languages the decomposed forms sort as the base=
=20
letter is immaterial. It's only true in some cases.

So no, sort order is not it. To sort right, you need to use the a real=20
Unicode sort (and the decomposed form is *not* going to help you one bi=
t,=20
quite the reverse).

It may be that a case compare is easier in NFD (ie you basically only d=
o=20
the case-compare on the base letter).

		Linus
