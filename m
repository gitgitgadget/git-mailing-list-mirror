From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 23:42:42 +0200
Message-ID: <200709022342.42733.robin.rosenberg.lists@dewire.com>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 23:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRxBz-00048N-Ee
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 23:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbXIBVlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbXIBVlL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 17:41:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19175 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753025AbXIBVlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 17:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A9665802866;
	Sun,  2 Sep 2007 23:33:15 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01600-10; Sun,  2 Sep 2007 23:33:15 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3BDED802849;
	Sun,  2 Sep 2007 23:33:15 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0709022133190.28586@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57391>

s=F6ndag 02 september 2007 skrev Johannes Schindelin:
> Hi,
>=20
> On Sun, 2 Sep 2007, Robin Rosenberg wrote:
>=20
> > s?ndag 02 september 2007 skrev Marius Storm-Olsen:
> > > (Also, since Windows doesn't really handle symlinks, it's fine th=
at stat just uses lstat)
> >=20
> > It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.=
aspx
>=20
> Oh?  *goes and tries to create one on a USB stick* No.  Besides, IIRC=
 you=20
Set core.symlinks =3D false for working on a broken file system

> cannot even create symlinks to another partition.  Copying a symlink =
will=20
That is not the normal use for symlinks. It is a case where it breaks, =
but symbolic
links in a git repo that points outside the repo is probably not a good=
 idea, especially
if it is a cross platform project. It is far less broken than today any=
way.

> copy the _linked_ file.  So to call this "symlink" is a little... uhm=
=2E..=20
> preposterous.

$ ln -s Makefile x
$ cp x y
$ ls -ld x y
lrwxrwxrwx 1 me me     8 sep  2 23:36 x -> Makefile
-rw-r--r-- 1 me me 32164 sep  2 23:36 y

Same behaviour as on linux.

> Plus, on a page linked from the link you posted, it says that it is=20
> only supported from Vista onwards.  So you must be kidding me.

core.symlinks =3D false if ithey aren't supported. You actually need
admin privileges too, but I don't know any windows developer who
hasn't got that.

-- robin
