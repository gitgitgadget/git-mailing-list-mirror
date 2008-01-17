From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 10:42:11 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZhN-0003kg-K0
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbYAQSmP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 13:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYAQSmP
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:42:15 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751471AbYAQSmO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 13:42:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIgCaG020588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 10:42:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIgBNE006852;
	Thu, 17 Jan 2008 10:42:11 -0800
In-Reply-To: <478F99E7.1050503@web.de>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70899>



On Thu, 17 Jan 2008, Mark Junker wrote:
>=20
> Sorry, but you're using different characters that look the same. But =
Kevins
> point was that it's a different thing if you use two characters that =
look the
> same or the same character with different encodings.

But that's exactly the case he gave - '=E4' vs 'a=A8' are exactly that:=
=20
different strings (not even characters: the second is actually a=20
multi-character) that just look the same.

You try to twist the argument by just claiming that they are the same=20
"character". They aren't, unless you *define* character to be the same =
as=20
"glyph". Of course, if you claim that, then you can always support your=
=20
argument, but I claim that is a bogus and incorrect axiom to start with=
!

Too many people confuse "character" and "glyph". They are different.

See, for example

	http://en.wikipedia.org/wiki/Unicode

and notice the *many* places where they try to make that distinction=20
between "character" and "glyph" clear (and also "code values", which ar=
e=20
the actual bytes that encode a character).

See also

	http://en.wikipedia.org/wiki/Unicode_normalization

and realize that a Unicode sequence is a sequence of *characters* even =
if=20
it is not normalized! Those things are still characters, when they are =
the=20
"simpler" non-combined characters.

You are trying to make a totally BOGUS argument, and you base it on the=
=20
INCORRECT basis that the TWO characters 'a'+'=A8' somehow aren't indepe=
ndent=20
characters. They *are*. They are *different* characters from '=E4', eve=
n=20
though they may be "Canonically equivalent" as a sequence.

The fact is that "equivalent" does not mean "same". Why cannot people=20
accept that?

			Linus
