From: "=?utf-8?q?Jean-No=C3=ABl?= AVILA" <avila.jn@gmail.com>
Subject: Re: t9902 fails
Date: Sat, 19 Jan 2013 11:23:37 +0100
Message-ID: <201301191123.37404.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <201301182323.55378.avila.jn@gmail.com> <50FA316E.8060807@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 11:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwVaw-00064W-TO
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 11:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab3ASKXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 05:23:54 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:54114 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723Ab3ASKXx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 05:23:53 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id A307B4B01AA;
	Sat, 19 Jan 2013 11:23:39 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc4jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <50FA316E.8060807@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213968>

Le samedi 19 janvier 2013 06:38:54, Torsten B=C3=B6gershausen a =C3=A9c=
rit :
> On 18.01.13 23:23, Jean-No=C3=ABl AVILA wrote:
> > Le vendredi 18 janvier 2013 21:15:23, Junio C Hamano a =C3=A9crit :
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>> How about doing something like this and set that variable in the
> >>> test instead?  If STD_ONLY is not set, you will get everything, b=
ut
> >>> when STD_ONLY is set, we will stop reading from "help -a" when it
> >>> starts listing additional stuff.
> >=20
> > I tried both of your propositions but none made test 10 of t9902 pa=
ss.
> >=20
> > Am I supposed to run "make install" before running the test?
>=20
> No. The test suite could (and should) be run before you make install.
> So a typical sequence could be:
> Run test suite, and if that passes, install the binaries on my system=
=2E
> This could look like this on the command line:
> make test && sudo make install
>=20
> Jean-No=C3=ABl,
> would it be possible to run
> "git status"
> and share the result with us?
>=20
> And did you try Jonathans patch?
>=20
> /Torsten


Hi all,

My workdir is clean.=20


jnavila@cayenne git (master)]$ make
    GEN perl/PM.stamp
    SUBDIR gitweb
    SUBDIR ../
make[2]: =C2=AB GIT-VERSION-FILE =C2=BB est =C3=A0 jour.
    GEN git-instaweb
    SUBDIR git-gui
    SUBDIR gitk-git
make[1]: Rien =C3=A0 faire pour =C2=AB all =C2=BB.
    SUBDIR perl
    SUBDIR git_remote_helpers
    SUBDIR templates
[jnavila@cayenne git (master)]$ git branch -vv
  attr_pattern   3cb6a4c Add directory pattern matching to attributes
  fix_test_t9902 02f55e6 Merge git://bogomips.org/git-svn
  maint          611fa18 Add directory pattern matching to attributes
* master         02f55e6 [origin/master] Merge git://bogomips.org/git-s=
vn
  next           82c5000 [origin/next: ahead 157, behind 550] Merge bra=
nch=20
'jc/doc-diff-blobs' into next
  pu             25f269c [origin/pu: ahead 68, behind 137] Merge branch=
=20
'mp/diff-algo-config' into pu
  todo           70e0e3e [origin/todo: behind 1] What's cooking (2013/0=
1 #06)
[jnavila@cayenne git (master)]$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       gitk-git/gitk-wish
nothing added to commit but untracked files present (use "git add" to t=
rack)
[jnavila@cayenne git (master)]$ ls -l | grep git-check
-rwxr-xr-x 108 jnavila jnavila 7677476 janv. 19 10:30 git-check-attr
-rwxr-xr-x 108 jnavila jnavila 7677476 janv. 19 10:30 git-checkout
-rwxr-xr-x 108 jnavila jnavila 7677476 janv. 19 10:30 git-checkout-inde=
x
-rwxr-xr-x 108 jnavila jnavila 7677476 janv. 19 10:30 git-check-ref-for=
mat


If I move git-checkout-branches out of /usr/bin, the test passes. So so=
mehow=20
GIT_EXEC_PATH is not what is expected.
