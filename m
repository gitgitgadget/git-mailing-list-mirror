From: Shoichi Kaji <skaji@outlook.com>
Subject: t/t1402-check-ref-format.sh fails with bash-3.0
Date: Sat, 22 Jun 2013 01:59:35 +0900
Message-ID: <BAY167-W78B20F436837AAA12899BA68F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4mT-0006hy-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423492Ab3FURFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jun 2013 13:05:45 -0400
Received: from bay0-omc3-s4.bay0.hotmail.com ([65.54.190.142]:30463 "EHLO
	bay0-omc3-s4.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423404Ab3FURFo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:05:44 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2013 13:05:44 EDT
Received: from BAY167-W7 ([65.54.190.188]) by bay0-omc3-s4.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 21 Jun 2013 09:59:35 -0700
X-TMN: [g6oEc2GrGDYjAVQuPcjEu3axfrzBdXHY]
X-Originating-Email: [skaji@outlook.com]
Importance: Normal
X-OriginalArrivalTime: 21 Jun 2013 16:59:35.0674 (UTC) FILETIME=[B55A4DA0:01CE6EA0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228633>

Hi,

With bash-3.0 (NOTE: CentOS 4's /bin/sh is actually a symlink to bash 3=
=2E0),
t/t1402-check-ref-format.sh failed.
Here is output.

% ~/bash-3.0.16/bin/bash --version
GNU bash, version 3.00.16(2)-release (x86_64-unknown-linux-gnu)
Copyright (C) 2004 Free Software Foundation, Inc.
% cd ~/git/t
% ~/bash-3.0.16/bin/bash t1402-check-ref-format.sh
ok 1 - ref name '' is invalid
ok 2 - ref name '/' is invalid
ok 3 - ref name '/' is invalid with options --allow-onelevel
ok 4 - ref name '/' is invalid with options --normalize
ok 5 - ref name '/' is invalid with options --allow-onelevel --normaliz=
e
ok 6 - ref name 'foo/bar/baz' is valid
ok 7 - ref name 'foo/bar/baz' is valid with options --normalize
ok 8 - ref name 'refs///heads/foo' is invalid
ok 9 - ref name 'refs///heads/foo' is valid with options --normalize
ok 10 - ref name 'heads/foo/' is invalid
ok 11 - ref name '/heads/foo' is invalid
ok 12 - ref name '/heads/foo' is valid with options --normalize
ok 13 - ref name '///heads/foo' is invalid
ok 14 - ref name '///heads/foo' is valid with options --normalize
ok 15 - ref name './foo' is invalid
ok 16 - ref name './foo/bar' is invalid
ok 17 - ref name 'foo/./bar' is invalid
ok 18 - ref name 'foo/bar/.' is invalid
ok 19 - ref name '.refs/foo' is invalid
ok 20 - ref name 'heads/foo..bar' is invalid
ok 21 - ref name 'heads/foo?bar' is invalid
ok 22 - ref name 'foo./bar' is valid
ok 23 - ref name 'heads/foo.lock' is invalid
ok 24 - ref name 'heads///foo.lock' is invalid
ok 25 - ref name 'foo.lock/bar' is invalid
ok 26 - ref name 'foo.lock///bar' is invalid
ok 27 - ref name 'heads/foo@bar' is valid
ok 28 - ref name 'heads/v@{ation' is invalid
ok 29 - ref name 'heads/foo\bar' is invalid
ok 30 - ref name 'heads/foo ' is invalid
not ok 31 - ref name 'heads/foo' is invalid
#
# =A0 =A0test_must_fail git check-ref-format =A0'heads/foo'
#
ok 32 - ref name 'heads/fu=DF' is valid
ok 33 - ref name 'heads/*foo/bar' is invalid with options --refspec-pat=
tern
ok 34 - ref name 'heads/foo*/bar' is invalid with options --refspec-pat=
tern
ok 35 - ref name 'heads/f*o/bar' is invalid with options --refspec-patt=
ern
ok 36 - ref name 'foo' is invalid
ok 37 - ref name 'foo' is valid with options --allow-onelevel
ok 38 - ref name 'foo' is invalid with options --refspec-pattern
ok 39 - ref name 'foo' is valid with options --refspec-pattern --allow-=
onelevel
ok 40 - ref name 'foo' is invalid with options --normalize
ok 41 - ref name 'foo' is valid with options --allow-onelevel --normali=
ze
ok 42 - ref name 'foo/bar' is valid
ok 43 - ref name 'foo/bar' is valid with options --allow-onelevel
ok 44 - ref name 'foo/bar' is valid with options --refspec-pattern
ok 45 - ref name 'foo/bar' is valid with options --refspec-pattern --al=
low-onelevel
ok 46 - ref name 'foo/bar' is valid with options --normalize
ok 47 - ref name 'foo/*' is invalid
ok 48 - ref name 'foo/*' is invalid with options --allow-onelevel
ok 49 - ref name 'foo/*' is valid with options --refspec-pattern
ok 50 - ref name 'foo/*' is valid with options --refspec-pattern --allo=
w-onelevel
ok 51 - ref name '*/foo' is invalid
ok 52 - ref name '*/foo' is invalid with options --allow-onelevel
ok 53 - ref name '*/foo' is valid with options --refspec-pattern
ok 54 - ref name '*/foo' is valid with options --refspec-pattern --allo=
w-onelevel
ok 55 - ref name '*/foo' is invalid with options --normalize
ok 56 - ref name '*/foo' is valid with options --refspec-pattern --norm=
alize
ok 57 - ref name 'foo/*/bar' is invalid
ok 58 - ref name 'foo/*/bar' is invalid with options --allow-onelevel
ok 59 - ref name 'foo/*/bar' is valid with options --refspec-pattern
ok 60 - ref name 'foo/*/bar' is valid with options --refspec-pattern --=
allow-onelevel
ok 61 - ref name '*' is invalid
ok 62 - ref name '*' is invalid with options --allow-onelevel
ok 63 - ref name '*' is invalid with options --refspec-pattern
ok 64 - ref name '*' is valid with options --refspec-pattern --allow-on=
elevel
ok 65 - ref name 'foo/*/*' is invalid with options --refspec-pattern
ok 66 - ref name 'foo/*/*' is invalid with options --refspec-pattern --=
allow-onelevel
ok 67 - ref name '*/foo/*' is invalid with options --refspec-pattern
ok 68 - ref name '*/foo/*' is invalid with options --refspec-pattern --=
allow-onelevel
ok 69 - ref name '*/*/foo' is invalid with options --refspec-pattern
ok 70 - ref name '*/*/foo' is invalid with options --refspec-pattern --=
allow-onelevel
ok 71 - ref name '/foo' is invalid
ok 72 - ref name '/foo' is invalid with options --allow-onelevel
ok 73 - ref name '/foo' is invalid with options --refspec-pattern
ok 74 - ref name '/foo' is invalid with options --refspec-pattern --all=
ow-onelevel
ok 75 - ref name '/foo' is invalid with options --normalize
ok 76 - ref name '/foo' is valid with options --allow-onelevel --normal=
ize
ok 77 - ref name '/foo' is invalid with options --refspec-pattern --nor=
malize
ok 78 - ref name '/foo' is valid with options --refspec-pattern --allow=
-onelevel --normalize
ok 79 - check-ref-format --branch @{-1}
ok 80 - check-ref-format --branch from subdir
ok 81 - ref name 'heads/foo' simplifies to 'heads/foo'
ok 82 - ref name 'refs///heads/foo' simplifies to 'refs/heads/foo'
ok 83 - ref name '/heads/foo' simplifies to 'heads/foo'
ok 84 - ref name '///heads/foo' simplifies to 'heads/foo'
ok 85 - check-ref-format --normalize rejects 'foo'
ok 86 - check-ref-format --normalize rejects '/foo'
ok 87 - check-ref-format --normalize rejects 'heads/foo/../bar'
ok 88 - check-ref-format --normalize rejects 'heads/./foo'
ok 89 - check-ref-format --normalize rejects 'heads\foo'
ok 90 - check-ref-format --normalize rejects 'heads/foo.lock'
ok 91 - check-ref-format --normalize rejects 'heads///foo.lock'
ok 92 - check-ref-format --normalize rejects 'foo.lock/bar'
ok 93 - check-ref-format --normalize rejects 'foo.lock///bar'
# failed 1 among 93 test(s)
1..93

31st test is:
invalid_ref "$(printf 'heads/foo\177')"

I found that bash-3.0 ignores DEL character(\177=3D\x7f) in double quot=
ed string.
% cat test.sh
echo =A0$(printf 'heads/foo\177') =A0| hexdump -C
echo "$(printf 'heads/foo\177')" | hexdump -C
% ~/bash-3.0.16/bin/bash test.sh
00000000 =A068 65 61 64 73 2f 66 6f =A06f 7f 0a =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 |heads/foo..|
0000000b
00000000 =A068 65 61 64 73 2f 66 6f =A06f 0a =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0|heads/foo.|
0000000a

Thus 31st test is just equal to invalid_ref "heads/foo" and fails.

Thanks
--=A0
Shoichi Kaji 		 	   		  