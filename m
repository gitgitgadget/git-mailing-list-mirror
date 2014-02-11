From: Joachim Breitner <mail@joachim-breitner.de>
Subject: git-note -C changes commit type?
Date: Tue, 11 Feb 2014 17:23:27 +0000
Message-ID: <1392139407.12790.7.camel@kirk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5wJajMjS7UWj+QTRQO09"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 11 18:46:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDHPd-0007J4-05
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 18:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbaBKRqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 12:46:10 -0500
Received: from hermes.serverama.de ([78.47.178.158]:60931 "EHLO
	hermes.serverama.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbaBKRqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 12:46:06 -0500
X-Greylist: delayed 1352 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2014 12:46:06 EST
Received: from [10.254.1.12] (helo=kirk)
	by hermes.serverama.de with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDH3Q-0008K7-Mm
	for git@vger.kernel.org; Tue, 11 Feb 2014 18:23:31 +0100
Received: from jojo by kirk with local (Exim 4.82)
	(envelope-from <mail@joachim-breitner.de>)
	id 1WDH3P-0003wt-K2
	for git@vger.kernel.org; Tue, 11 Feb 2014 17:23:27 +0000
X-Mailer: Evolution 3.8.5-2+b1 
X-Spam-Score: -7.6 (-------)
X-Spam-Report: Status No, score=-7.6 required=5.0 bayes=0.0000 tests=ALL_TRUSTED=-1,BAYES_00=-6.599 autolearn=ham version=3.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241950>


--=-5wJajMjS7UWj+QTRQO09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

judging from the documentation I got the impression that I can pass any
git object has to "git note -C <hash>" and it would stored as-is. But it
seems the objects gets mangled somehow...

(I want to attach a commit object as a note, to reference the history of
a feature before the final cleanup rebase. For that I turn the reflog
into a series of commits, and the final commit is the one I want to
store there.)

$ mkdir foo
$ cd foo/
$ echo foo > a
$ git init
Initialisierte leeres Git-Repository in /tmp/foo/.git/
$ git add a
$ git commit -m 'A commit'
[master (Basis-Commit) 3d7de37] A commit
 1 file changed, 1 insertion(+)
 create mode 100644 a
$ echo foo2 > a
$ git commit -m 'A commit 2' -a
[master e1bfac4] A commit 2
 1 file changed, 1 insertion(+), 1 deletion(-)
$ git notes --ref history add -C 3d7de37 e1bfac4
$ git ls-tree notes/history
100644 blob 5b73d5152e6207e3a2b67e57ca3a2cb94d12061e e1bfac434ebd3135a3784f=
6fc802f235098eebd0

I was expecting 3d7de37 to be referenced here.

Is that a bug, or is storing commits as notes not supported?

Thanks,
Joachim


--=20
Joachim =E2=80=9Cnomeata=E2=80=9D Breitner
  mail@joachim-breitner.de =E2=80=A2 http://www.joachim-breitner.de/
  Jabber: nomeata@joachim-breitner.de  =E2=80=A2 GPG-Key: 0x4743206C
  Debian Developer: nomeata@debian.org

--=-5wJajMjS7UWj+QTRQO09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlL6XI8ACgkQ9ijrk0dDIGx6iQCfRMw30Zhn0VLUv3KgWxiEGqU+
iPcAoICpAAbs2tDGwzHxwMP87/BP5/J3
=DaYU
-----END PGP SIGNATURE-----

--=-5wJajMjS7UWj+QTRQO09--
