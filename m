From: Francis Galiegue <fg@one2team.net>
Subject: Re: JGIT: discuss: diff/patch implementation
Date: Mon, 10 Nov 2008 19:11:19 +0100
Organization: One2team
Message-ID: <200811101911.19603.fg@one2team.net>
References: <200811101522.13558.fg@one2team.net> <200811101716.29029.fg@one2team.net> <200811101759.03864.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzbGA-0007Ik-BQ
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYKJSL4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 13:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754538AbYKJSL4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:11:56 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:36703 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbYKJSLz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 13:11:55 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-75-3.w90-20.abo.wanadoo.fr [90.20.62.3])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id E002E92C003;
	Mon, 10 Nov 2008 19:11:44 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811101759.03864.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100541>

Le Monday 10 November 2008 17:59:03 Robin Rosenberg, vous avez =E9crit=A0=
:
[Sorry if this is offtopic for the git mailing list...]

> >
> > Well, this API has a problem from the get go, since it does... Char=
 by
> > char comparison. Ouch.
> >
> > I'll try and hack it so that it does line by line, but given my Jav=
a
> > skills, uh...
>
> We might want a byte-oriented version. Converting to char first is wa=
y
> too slow.
>

Well, AFAICT, here is how the current git code detects whether a file i=
s=20
binary or not:

----
#define FIRST_FEW_BYTES 8000
int buffer_is_binary(const char *ptr, unsigned long size)
{
	if (FIRST_FEW_BYTES < size)
		size =3D FIRST_FEW_BYTES;
	return !!memchr(ptr, 0, size);
}
----

Easy enough to be coded in Java, hey, even I could do it :p

So, provided binary files are dealt with already, what penalty is left =
for=20
Java to deal with?

--=20
fge
