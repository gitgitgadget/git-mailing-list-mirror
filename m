From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 10:44:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171042330.14959@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
 <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:45:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZjs-0004jN-OM
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbYAQSov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 13:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbYAQSou
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:44:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55845 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752670AbYAQSot (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 13:44:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIihwC020700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 10:44:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIihC9006988;
	Thu, 17 Jan 2008 10:44:43 -0800
In-Reply-To: <6E1A0E9A-34D7-4D85-BD4B-CF56CE3927CA@simplicidade.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70900>



On Thu, 17 Jan 2008, Pedro Melo wrote:
>=20
> On Jan 17, 2008, at 6:09 PM, Mark Junker wrote:
>
> > IMHO it would be the best solution when git stores all string meta =
data in
> > UTF-8 and converts it to the target systems file system encoding. T=
hat would
> > fix all those problems with different locales and file system encod=
ings ...
>=20
> +1.
>=20
> And I would suggest the use of RFC 3454 as the guidelines for UTF-8
> normalization.

The problem is that there is no way to know what the "target system=20
encoding" is.

And it wouldn't actually solve the bigger problem on OS X anyway: as lo=
ng=20
as you are case-insensitive, you'll have all the same problems (ie the=20
insane OS X filesystem presumably thinks that "M=C4RCHEN" and "M=E4rche=
n" are=20
also identical, because they are "equivalent" names).

			Linus
