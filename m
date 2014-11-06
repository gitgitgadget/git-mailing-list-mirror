From: victor <liwenxi9999@163.com>
Subject: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Wed, 5 Nov 2014 21:19:04 -0800 (PST)
Message-ID: <1415251144220-7620692.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 06:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmFTX-0001iL-L2
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 06:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbaKFFTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2014 00:19:07 -0500
Received: from sam.nabble.com ([216.139.236.26]:51290 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbaKFFTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2014 00:19:05 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <liwenxi9999@163.com>)
	id 1XmFTM-0001W7-7r
	for git@vger.kernel.org; Wed, 05 Nov 2014 21:19:04 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I installed git 2.1.3 on sparc 8 by source code with make install, howe=
ver I
got git core dump during 'git clone'.

I used command as below to compile and install:

=2E/configure --prefix=3D/usr/local/git-2.1.3/ --enable-pthreads
sudo gmake NO_GETTEXT=3D1 install

Below I pasted  the gdb bt full details, does anyone have any idea why =
this
happened?

Thanks very much!
Victor

(gdb) bt full
#0  0xff0332ec in strlen () from /usr/lib/libc.so.1
No symbol table info available.
#1  0xff0866b8 in _doprnt () from /usr/lib/libc.so.1
No symbol table info available.
#2  0xff088ac0 in vsnprintf () from /usr/lib/libc.so.1
No symbol table info available.
#3  0x00137c18 in vreportf (prefix=3D0x190038 "cannot create thread: %s=
",
err=3D0x190038 "cannot create thread: %s", params=3D0xffbef280)
    at usage.c:12
        msg =3D "cannot create thread:
\0d~=E2=96=92=E2=96=92=E2=96=92\201\001\001\0\0\036\rP\0\034=E2=96=92\0=
\0\034=E2=96=92\0\0\036\rP", '\0' <repeats 16
times>,
"=E2=96=92\f\027\004=E2=96=92\f\027\b=E2=96=92\v=E2=96=92=E2=96=92=E2=96=
=92\v=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92\177=E2=96=92=
=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92=E2=96=92\f\027$=E2=
=96=92\v=E2=96=92\b\0\036\rP", '\0'
<repeats 35 times>,
"\001\0\030=E2=96=920\0\0\0\001\0\034=E2=96=92\0=E2=96=92=E2=96=92=E2=96=
=92=E2=96=92\0\0\0/\0\0\0\0=E2=96=92\003=E2=96=92@", '\0' <repeats
12 times>,
"\201\001\001\0\0\036\rP\0\0\0\0\0\0\0\001\0\031\032\220\0\0\0\0\0\030=E2=
=96=920=E2=96=92=E2=96=92=E2=96=92=E2=96=92\0\0\0\0=E2=96=92=E2=96=92=E2=
=96=92=E2=96=92\0\0\0\v",
'\0' <repeats 27 times>...
#4  0x00137f6c in error (err=3D0x196128 "error: ") at usage.c:147
No locals.
#5  0x00112aa0 in start_async (async=3D0xffbef5b0) at run-command.c:727




--
View this message in context: http://git.661346.n2.nabble.com/Installed=
-git-2-1-3-on-sparc-8-but-got-core-dump-during-git-clone-tp7620692.html
Sent from the git mailing list archive at Nabble.com.
