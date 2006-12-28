From: SungHyun Nam <goweol@gmail.com>
Subject: t9200-git-cvsexportcommit.sh failed on CYGWIN
Date: Thu, 28 Dec 2006 12:23:22 +0900
Message-ID: <459338AA.8000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 28 04:23:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzlri-0002qz-GF
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 04:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWL1DX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 27 Dec 2006 22:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWL1DX3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 22:23:29 -0500
Received: from relaygw3.kornet.net ([61.74.75.198]:36699 "EHLO
	relaygw3.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbWL1DX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 22:23:28 -0500
Received: from [211.48.62.137] ([211.48.62.137]) 
          by relaygw3.kornet.net ([61.74.75.198]) 
          with ESMTP id 2006122812:23:23:700017.14446.125500336
          Thu, 28 Dec 2006 12:23:23 +0900 (KST) 
Received: from [211.221.139.50] ([211.221.139.50]) 
          by relay9.kornet.net ([211.48.62.137]) 
          with ESMTP id 2006122812:23:23:569191.21689.87382960
          Thu, 28 Dec 2006 12:23:23 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35517>

Hello,

Below is the test messages.

BTW, I hope I can define 'NO_CVS_TESTS' to skip this test.

Thanks,
namsh

$ ./t9200-git-cvsexportcommit.sh
Initialized empty Git repository in .git/
Created initial commit 15322570c631afb497138bc0c3d155f793535d35
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 empty
*   ok 1: New file
*   ok 2: Remove two files, add two and update two
*   ok 3: Fail to change binary more than one generation old
*   ok 4: Remove only binary files
*   ok 5: Remove only a text file
*   ok 6: New file with spaces in file name
*   ok 7: Update file with spaces in file name
* FAIL 8: File with non-ascii file name
        mkdir -p
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6 &&
              echo Foo
>=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=
=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt
&&
              git add
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt
&&
              cp ../test9200a.png
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png
&&
              git add
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png
&&
              git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
              id=3D$(git rev-list --max-count=3D1 HEAD) &&
              (cd "$CVSWORK" &&
              git-cvsexportcommit -v -c $id &&
              test "$(echo $(sort
=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=
=A4/=C3=B6/CVS/Entries|cut
-d/ -f2,3,5))" =3D "g=C3=A5rdets=C3=A5g=C3=A5rdet.png/1.1/-kb g=C3=A5rd=
ets=C3=A5g=C3=A5rdet.txt/1.1/"
              )
*   ok 9: Mismatching patch should fail
*   ok 10: Retain execute bit
* failed 1 among 10 test(s)
