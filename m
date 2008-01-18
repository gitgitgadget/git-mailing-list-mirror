From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 13:30:36 +0300
Message-ID: <20080118103036.GD14871@dpotapov.dyndns.org>
References: <478E1FED.5010801@web.de> <200801180205.28742.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org> <200801181042.37391.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pedro Melo <melo@simplicidade.org>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoVe-0007wm-UT
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbYARKao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 05:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbYARKao
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:30:44 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:59032 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427AbYARKan (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:30:43 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id 822F41870BD7;
	Fri, 18 Jan 2008 13:30:39 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-154.pppoe.mtu-net.ru [85.141.191.154])
	by smtp03.mtu.ru (Postfix) with ESMTP id EE8201870B4B;
	Fri, 18 Jan 2008 13:30:36 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFoUe-0005Pz-P7; Fri, 18 Jan 2008 13:30:36 +0300
Content-Disposition: inline
In-Reply-To: <200801181042.37391.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70992>

On Fri, Jan 18, 2008 at 10:42:36AM +0100, Robin Rosenberg wrote:
>=20
> I just had to investigate this a bit, so on a Vista machine I started=
 a cmd
> prompt and typed mode con: cp select=3D65001, selected the lucida fon=
t and then
> echo =E5 >x.txt and opened it in notepad and it was UTF-8 encoded.=20

Yes, but have you tried to run any batch file? At least, on WinXP
all batch files silently stopped working after choosing 65001, and
I don't know what else gets broken, because Microsoft C library
does not work with encoding that requires more than two bytes per
character.

> So there might
> be some hope after all. I don't know how to change the encoding for n=
on-console
> apps. I leave that as an excercise for the list.

It is not difficult to change the current encoding in any Windows
application, the real issue is that neither Microsoft C library nor
Cygwin library does not work correctly with UTF-8. There is a patch
for Cygwin though...

Dmitry
