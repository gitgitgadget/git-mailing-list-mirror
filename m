From: Francis Galiegue <fg@one2team.net>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 16:58:44 +0100
Organization: One2team
Message-ID: <200811101658.44366.fg@one2team.net>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de> <871vxjoa3j.fsf@erwin.mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal Nazarewicz <mina86@tlen.pl>
X-From: git-owner@vger.kernel.org Mon Nov 10 17:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzZBi-0000FM-Mf
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 17:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbYKJP7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 10:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYKJP7M
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 10:59:12 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:41564 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753000AbYKJP7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 10:59:11 -0500
Received: from erwin.kitchen.eel (unknown [90.63.83.161])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 54E2C92C006;
	Mon, 10 Nov 2008 16:59:01 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <871vxjoa3j.fsf@erwin.mina86.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100528>

Le Monday 10 November 2008 16:48:48 Michal Nazarewicz, vous avez =E9cri=
t=A0:
[...]
>
> The thing is that for some repositories I don't distinguish anything
> like a "release version" of files.

"Git tracks contents, not files".

You have two problems here:
* first, unlike CVS, files don't have revisions;
* second, unline SVN (or even Mercurial), commits are not "ordered", at=
 least=20
not in a natural way (can't tell what SHA1 is more recent).

Git will not track a single file, and I don't think it will ever do so.=
 And=20
then, what about renames?

You have two options there:

1. (requires git modification, I guess) put a $last_modified_date$ magi=
c that=20
expands to the last modification date;
2. (what I do) keep an internal ChangeLog for such files, that you (hav=
e to)=20
fill by hand each time.

The second approach has big advantages:
* you can date your changes;
* you _really_ know the file history;
* git's renaming handle allows you to track this ChangeLog over time!

It requires discipline, though...

--=20
fge
