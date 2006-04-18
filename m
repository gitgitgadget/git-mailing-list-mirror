From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: Next problem: empty ident  <joern@limerick.(none)> not allowed
Date: Tue, 18 Apr 2006 22:25:25 +0200
Message-ID: <20060418202525.GD25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Apr 18 22:25:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVwlM-0008NS-DX
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 22:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDRUZZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDRUZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 16:25:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52884 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932323AbWDRUZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 16:25:24 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVwlJ-0003mm-00
	for <git@vger.kernel.org>; Tue, 18 Apr 2006 22:25:25 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18876>

After successfully using a central object store with git://... instead
of rsync://... (thanks to Sam and Linus), I've run into the next
problem:

$ env | grep GIT
GIT_AUTHOR_NAME=3DJoern Engel
GIT_OBJECT_DIRECTORY=3D/home/joern/.git
GIT_AUTHOR_EMAIL=3Djoern@wh.fh-wedel.de

$ git pull git://git.infradead.org/mtd-2.6.git
Unpacking 74 objects
 100% (74/74) done
Trying really trivial in-index merge...
Wonderful.
fatal: empty ident  <joern@limerick.(none)> not allowed

Adding this to .git/config solved the problem:
[user]
	name =3D "Joern Engel"
	email =3D "joern@foo.bar"


And now I have some questions:
1. Why didn't the environment variables work?
2. Why is there a check for commit information when I pull from some
tree?

J=F6rn

--=20
I've never met a human being who would want to read 17,000 pages of
documentation, and if there was, I'd kill him to get him out of the
gene pool.
-- Joseph Costello
