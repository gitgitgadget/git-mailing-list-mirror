From: =?ISO-8859-1?Q?Antonio_P=E9rez_Barrero?= <apbarrero@gmail.com>
Subject: Failed to find remote helpers after install from source
Date: Wed, 12 Feb 2014 12:59:39 +0100
Message-ID: <CAB-r6f-ZJcnP_2_pySFQC1Xx+__=g7fzmSfST_8Wh-4bMyWhJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 12:59:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDYTi-0007bz-B7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 12:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaBLL7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Feb 2014 06:59:41 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43105 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaBLL7k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Feb 2014 06:59:40 -0500
Received: by mail-qa0-f46.google.com with SMTP id k15so370636qaq.19
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 03:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=F6I/DwzqwDcbo4yaCJAY9hfLdtiPiZfS8g1K9vQOd9M=;
        b=T1r/ejTWPZ4ncLv+7w2lXObXinzFBW0hCd+YqsymILbdXd4bEhJ3pWVPtcRvKCngPt
         MO07z2KUjmsn0izD6laJ4WqlQtsldpS5M3naGrFhZdMmctSi7dH80cF/pTliNhmMUKTW
         NWJDrgJaEaVvjCB4wYIah4S1hievoWS0kj+aqwtIm/JS5Vg7TqfaT6IJnYTVD2uZ6VKc
         t0eu7nVv79U+u1QywOVxlxixY3zQLQnMxLjLIBT56gl8ZBg2LUFyPhK+AD7iCTriHq5f
         IGjoU5cgJfeiI7jQiYSZDKEYsPbRA4apGqsluHEUKhWrVcrh7QXS5L5VTMBwbnDErMb1
         wcxg==
X-Received: by 10.229.189.65 with SMTP id dd1mr35078263qcb.5.1392206379463;
 Wed, 12 Feb 2014 03:59:39 -0800 (PST)
Received: by 10.140.92.69 with HTTP; Wed, 12 Feb 2014 03:59:39 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241985>

Hi,

I installed git 1.8.5.4 from source under $HOME/bin. My system is SUSE
Linux Enterprise Server 11 SP1 (x86_64). I followed instructions and
just run make && make install.

After installation I cannot clone repos from https urls, getting the
following error:

$ git clone https://github.com/apbarrero/pyrad.git
Cloning into 'pyrad'...
fatal: Unable to find remote helper for 'https'

I checked that git is properly compiled against libcurl-devel and
libexpat-devel packages. Then I tryed using git-remote-https installed
under $HOME/bin/libexec/git-core/ and it worked fine to connect to the
same remote:

$ $HOME/libexec/git-core/git-remote-https https://github.com/apbarrero/=
pyrad.git
capabilities
fetch
option
push
check-connectivity

list
@refs/heads/master HEAD
9599cf833354793b81d2a47504826332473bcb12 refs/heads/master
1f8f2b995bb5ab55e6c6f1051ccb44875ab1e60d refs/tags/0.6
68552227901d377b513884c70d9582da0329a270 refs/tags/0.6^{}
e0cd958edc5b3aad7e31435990674e2cff4e3b7e refs/tags/0.7
c50213b2d4213f3574c1a6b454e6887a529de340 refs/tags/0.7^{}
6085deb4ee37862d65f4a26f472fa2d1894a4331 refs/tags/0.8
33902c5b3da1272a4f5930815f561b8068315ba3 refs/tags/0.8^{}
5a45639faaf1cbf7622fe47e2795d6f5a0ee6658 refs/tags/0.9
edd69b9014d7e5bbf9da203d7db9a26587756aa4 refs/tags/0.9^{}
6e3b16ed19b329be944bd1b10aa17d02eb473009 refs/tags/1.0
30beedc5c4e56a15f4025d25331515aa2a917234 refs/tags/1.0^{}
dacf4bd37aaddd3872faeb8a77c801fe3c8550cb refs/tags/1.1
4c3e2d6700947ca6ea7b3319ff52abb7029bf3be refs/tags/1.1^{}
9a7f5a4e9fe19ef9f45db4e28a7d4648a011cc9b refs/tags/1.2
ee7ec8f2b37da5e84bf0fbb83e214a8bd3cfdf70 refs/tags/1.2^{}
e16af24d814e8d8c83b172ca6103fd3ab93b08db refs/tags/2.0
ce4a625caf5c6d892e020ec150373043a203366e refs/tags/2.0^{}

I looked at this post in stackoverflow and use strace to find out git
clone is trying to look for remote helpers under
$HOME/bin/libexec/git-core, but make install left the libexec/git-core
directory under $HOME, instead of$HOME/bin.

=2E..
[pid 675896] execve("$HOME/bin/libexec/git-core/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("$HOME/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("$HOME/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("$HOME/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("$HOME/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/local/bin/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("/bin/git-remote-https", ["git-remote-https",
"origin", "https://github.com/apbarrero/pyr"...], [/* 88 vars */]) =3D
-1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/bin/X11/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/X11R6/bin/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/games/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/lib64/jvm/jre/bin/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/lib/mit/bin/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
[pid 675896] execve("/usr/lib/mit/sbin/git-remote-https",
["git-remote-https", "origin", "https://github.com/apbarrero/pyr"...],
[/* 88 vars */]) =3D -1 ENOENT (No such file or directory)
=2E..

Creating a soft link under $HOME/bin/ to ../libexec got it working.

So it look like it is rather an installation issue or a bug in the
directory list where git looks for binaries under libexec or I missed
some parameter to pass to make.

Regards,

--=20
   Antonio P=E9rez Barrero
   apbarrero@gmail.com
