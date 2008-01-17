From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 11:08:41 +0100
Message-ID: <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFRgc-0001Er-Mj
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYAQKI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 05:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYAQKI4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:08:56 -0500
Received: from wincent.com ([72.3.236.74]:35422 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbYAQKIz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 05:08:55 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HA8hVm017647;
	Thu, 17 Jan 2008 04:08:45 -0600
In-Reply-To: <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70840>

El 17/1/2008, a las 5:08, Linus Torvalds escribi=F3:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>
>> I believe it exists because HFS+ was created at a time when the Mac =
=20
>> was moving
>> from a multi-encoding world (which was a nightmare) to a Unicode =20
>> world and
>> they wanted to remove ambiguity in filenames. But I wasn't around =20
>> when they
>> made this decision so this is just a guess.
>
> I do agree. And I think starting out case-insensitive (something =20
> they must
> really hate by now) also made it less of an issue.

I hope you're right (about them hating it), but we'll see. They've =20
just opened the source for the ZFS port they're working on. By the =20
time it goes final and becomes the default FS, replacing HFS+, =20
probably within a couple of years, we'll see if they make the same two =
=20
design decisions which cause the kinds of problems being discussed =20
here (case-insensitivity, and ubiquitous FS-level UTF-8 normalization).

I've done a dumb search in the ZFS source code for "CASE" and see that =
=20
it can in theory support case-insensitivity as an optional feature. =20
The potential is there for Apple to use this. I personally hope that =20
they don't, because as has already been pointed out, these little =20
tricks tend to make life more difficult for users rather than helping =20
them (the day I have two files in the same directory called "M=E4rchen"=
 =20
and want to specify one of them on the command line I'll worry about =20
that when I come to it).

http://fuzzy.wordpress.com/2007/06/09/zfsandfilesystemoptions/

Cheers,
Wincent
