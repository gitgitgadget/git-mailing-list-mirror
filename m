From: David Kastrup <dak@gnu.org>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Sat, 12 Jan 2008 00:10:07 +0100
Message-ID: <85abnc6jsg.fsf@lola.goethe.zz>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
	<alpine.LSU.1.00.0801112127040.31053@racer.site>
	<34F43A68-6041-42BE-85BD-3EF971875C0F@sb.org>
	<alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 00:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDT0E-00081C-Rx
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 00:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760792AbYAKXJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2008 18:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761102AbYAKXJD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 18:09:03 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:41287 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759057AbYAKXJA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 18:09:00 -0500
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 702B31F5576;
	Sat, 12 Jan 2008 00:08:59 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 589B428EDE8;
	Sat, 12 Jan 2008 00:08:59 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-051-108.pools.arcor-ip.net [84.61.51.108])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 2E1FD103A7C;
	Sat, 12 Jan 2008 00:08:59 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 709401C4F929; Sat, 12 Jan 2008 00:10:07 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0801111356000.3148@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 11 Jan 2008 14:08:35 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5478/Fri Jan 11 16:39:22 2008 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70219>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I do agree that we could/should do something to help with case-insens=
itive=20
> filesystems.
>
> I absolutely *detest* those things, and I think that people who desig=
n=20
> them are total morons - with MS-DOS, you could understand it (people=20
> didn't know better),

Ah, those young whippersnappers who think they are so smart...  there i=
s
a history to that, you know.  Early character sets (like those on punch
cards) had just capital letters.  Even when lowercase letters were
introduced, those tended to use more space (12 instead of 6 bit) and be
harder to print (and the line printers who churned out 40 lines per
second did not bother with such finesse, anyway).  But capital letters
are not designed for readability of long lines.  So when printing or
even screen terminals came into use, one tended to prefer writing in
lowercase letters.  Which actually had the uppercase code points
usually.  Some early microcomputers (for which CP/M was designed)
actually were hooked up with a "standard" 50 or 110 Baud teletype as I/=
O
device, and those tended to have only lowercase letters, too, in their
basic incantations.  So CP/M, not knowing which kind of input device
would be used and whether it would prefer (or offer exclusively) upper
or lower case, had case-insensitive commands, and consequently also
case-insensitive file names.  And QDOS (whence MSDOS) was basically
intended to be a CP/M ripoff.

> but with OS X?

OS X has an Apple inheritance, Apple has the same inheritance as other
microcomputers which includes a case-insensitive BASIC interpreter
(BASIC again coming from old teletype times).  It is, again, a decision
to drag along old history.

But actually, there is more to it nowadays: two file names containing =FC=
,
but one with a single letter and one with combining accent, look exactl=
y
the same.  If they don't act exactly the same, one opens up quite a hol=
e
for spoofing attacks.  Well, probably hard to avoid (since things like
uppercase Alpha and uppercase A look the same and need to be different
code points, too).  But one also opens a can of worms for confusion.  S=
o
the problem of canonical file names does not go away just with case
sensitivity.

> But considering that they exist, we should probably offer at least
> *some* help for people who didn't realize that you could make OS X
> behave better.

It is not like Linux does not support some case-insensitive file system
types, too.  So the same problems can be had there as well.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
