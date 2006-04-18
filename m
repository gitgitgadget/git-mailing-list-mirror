From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Subject: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 15:38:47 +0200
Message-ID: <20060418133847.GC4720@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Apr 18 15:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVqPu-0005A6-WC
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 15:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWDRNiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 09:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWDRNiv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 09:38:51 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:22733 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751016AbWDRNiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 09:38:51 -0400
Received: from joern by wohnheim.fh-wedel.de with local (Exim 3.36 #1 (Debian))
	id 1FVqPn-00052w-00
	for <git@vger.kernel.org>; Tue, 18 Apr 2006 15:38:47 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18853>

Hi!

I recently noticed GIT_OBJECT_DIRECTORY in the git manpage and wanted
to play with it.  But it looks as if it doesn't work, the
documentation is wrong/insufficient or I can't properly read the
documentation.  So let me figure out, which one it is.

$ set | grep GIT_OBJECT_DIRECTORY
GIT_OBJECT_DIRECTORY=3D/home/joern/.git

$ ls -l /home/joern/.git
total 288
drwxrwxr-x  2 joern joern 4096 Apr 16 01:22 0f
[...]

$ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux-2.6.git foo
[ stored >200M of data under foo/.git/objects ]


The above looks as if new objects are not stored under
/home/joern/.git, as specified by GIT_OBJECT_DIRECTORY.  The manpage
tells me:

       GIT_OBJECT_DIRECTORY
              If  the  object storage directory is specified via this e=
nviron-
              ment variable then the sha1 directories are created under=
neath -
              otherwise the default $GIT_DIR/objects directory is used.

And I would interpret this as "store all new objects under
/home/joern/.git".  So far, things don't seem to imply me being too
stupid.  What went wrong?

J=F6rn

--=20
Why do musicians compose symphonies and poets write poems?
They do it because life wouldn't have any meaning for them if they didn=
't.
That's why I draw cartoons.  It's my life.
-- Charles Shultz
