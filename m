From: Andrew Keller <andrew@kellerfarm.com>
Subject: Reduced privileges install
Date: Sun, 19 Sep 2010 19:50:59 -0400
Message-ID: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 02:03:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTr9-0002xM-PM
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 02:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab0ITADe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 20:03:34 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:57215 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754917Ab0ITADd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 20:03:33 -0400
Received: from host-210-214.meilvil.clients.pavlovmedia.com ([96.63.210.214] helo=[192.168.0.102])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OxTf9-0002P2-4Y
	for git@vger.kernel.org; Sun, 19 Sep 2010 19:51:15 -0400
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156540>

Hello, all.  Quick question:

I'm trying to build and install git 1.7.2.3 from source on a server at =
school used for my class.
'uname -a' is 'SunOS bloch 5.9 Generic_122300-54 sun4u sparc SUNW,Ultra=
AX-i2'.

There were a few hiccups at first =96 things like CC not being defined,=
 tclsh not existing, the path to python being wrong, etc, but they were=
 all relatively easy to work around.  This last error, however, not so =
much luck.

Because I do not own the server and my account has restricted privilege=
s, I attempted to augment my PATH to include a directory in my home fol=
der, and then install git in there by specifying a prefix at the config=
ure stage.  The configure and the make work, but the make install fails=
=2E  Here's the last section of the log:


$ make install

=2E..

make -C templates DESTDIR=3D'' install
make[1]: Entering directory `/usr/users/students/ak4390/Downloads/git-1=
=2E7.2.3/templates'
/usr/ucb/install -d -m 755 '/usr/users/students/ak4390/.local/share/git=
-core/templates'
(cd blt && gtar cf - .) | \
        (cd '/usr/users/students/ak4390/.local/share/git-core/templates=
' && umask 022 && gtar xof -)
make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git-1.=
7.2.3/templates'
make -C perl prefix=3D'/usr/users/students/ak4390/.local' DESTDIR=3D'' =
install
make[1]: Entering directory `/usr/users/students/ak4390/Downloads/git-1=
=2E7.2.3/perl'
make[2]: Entering directory `/usr/users/students/ak4390/Downloads/git-1=
=2E7.2.3/perl'
Warning: You do not have permissions to install into /usr/perl5/site_pe=
rl/5.6.1/sun4-solaris-64int at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm=
 line 85.
Installing /usr/perl5/site_perl/5.6.1/Error.pm
Installing /usr/perl5/site_perl/5.6.1/Git.pm
mkdir /usr/perl5/site_perl/5.6.1/sun4-solaris-64int/auto: Permission de=
nied at /usr/perl5/5.6.1/lib/ExtUtils/Install.pm line 165
make[2]: *** [pure_site_install] Error 255
make[2]: Leaving directory `/usr/users/students/ak4390/Downloads/git-1.=
7.2.3/perl'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/usr/users/students/ak4390/Downloads/git-1.=
7.2.3/perl'
make: *** [install] Error 2


So anyways, it appears that it is trying to install into a directory in=
 which I do not have write permissions.  But why?  I thought that setti=
ng the prefix to a folder in my home directory would change that.  Is t=
here another parameter I'm forgetting about at the configure stage?

Thanks,
Andrew Keller

PS: not sure if it matters, but just in case...
path to perl: /bin/perl
version of perl: 5.6.1
