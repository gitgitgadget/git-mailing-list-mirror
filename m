From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Compiler warning under cygwin/mingw (was: fix for 50a6c8e)
Date: Mon, 29 Feb 2016 11:40:59 +0100
Message-ID: <56D4203B.1030708@web.de>
References: <56D3E56A.5010608@web.de>
 <20160229092816.GA23910@sigill.intra.peff.net> <56D415C6.2040203@web.de>
 <20160229100258.GC2950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 11:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaLGO-0001jC-LH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 11:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbcB2KlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 05:41:12 -0500
Received: from mout.web.de ([212.227.15.4]:57067 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbcB2KlL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 05:41:11 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lzate-1Zogdq3w0Y-014nDT; Mon, 29 Feb 2016 11:41:01
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <20160229100258.GC2950@sigill.intra.peff.net>
X-Provags-ID: V03:K0:IYR6LDUM4Vqk7APKbAppGSaSPbqL4HHVTWFq35QoESXb7cB/Rn0
 T3UY//Ddbl4zD4NAw10q+xKI3rtDeA5ochJBTUFUkMd/mr8pNl/Ei41t4KHaRskByRcxhhM
 prLDfMFDzb5liB2Ug8DmAzXK1FitaxsVXFkq2mdC/pPYnu7pC+Xz0NSjDHYFNnMyrsvIO0m
 poPtwk7Fx0jDi0tHpDxvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eq6izWHp778=:VN9Gt30y8BUWphHtDPKIHq
 hpOJg/EUMA76BnL+h46BElofEno5kk8NdNX7YDO5Lj6yQpJNrbuExsmkbHeFm4BpGARpGDziU
 XnULSQCbrDn5/nnQkDvWCD/AvIR694zpQkBIhM2NUF1JRrnnmF3Ij+BYrOGQHaDkbFKcvtMUX
 UWAGASDyFalHJoSbe+In0qDJQQfJx3aj0qluMKg9scEc/OSL6iKuPXbrXXlxc//CUZ+97/9qc
 cbXChzsvIYdO3WBwSb+udDI66r28GiQ9EBgSQmBf3kiy1vXva2uKn7dLfZEHDwbO/yFkhRixh
 4W9BMrMU5f/s9rwMYQ46zmATsffmXwzDIDnH7L4hcSxW9V4lAfP3t4nk8KmDOJ/CTmhCO4KG6
 I1sy1n/hjiWu+UiM/P+iE6IpDJlOrQZQ94gPfMA8LW0ECF5vG7ToyTrjtzeC7nOW2sBrWB5Cl
 5dZl0vQl6gFnkkPvV27KMjTJ1dohOx9PLcvs0zQK5XTZhRlpjTjt0QZxeaBmJD673RT5F2izg
 F4ZHyQaQ3Xy0c7LWeLFZVVF+KB0+nMG4+OUPBMtYjD7Unz6j9cGoysF1cKC0cl4+htNPyKCNk
 mv+3KosnpDB2MegoxkuROPQYHlUk2NpWtO32qpIh8PwRiEBJYyyaQ4rKz/ziKi306CsLFJWCD
 wkOgGrsEU63hbsVVa5pBWxAyUdHwvcaidPSkN9avWTiJ+FiyUS8+3d7aiX8vZCx9O+UeCmuOf
 Hkt7uMFL7nAnuBRr6C2vweJc1ckPVoadIKEkblAn5ka13stglRY6u6KYqKciXmTNa5K67WaJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287821>

That compiles OK, thanks.


Sorry for high-jacking this thread, but while compiling under CYGWIN,
found one warning:

    LINK git-credential-store.exe
     CC daemon.o
daemon.c: In function =E2=80=98drop_privileges=E2=80=99:
daemon.c:1136:15: warning: implicit declaration of function =E2=80=98in=
itgroups=E2=80=99=20
[-Wimplicit-function-declaration]
   if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
                ^

t9115 doesn't pass,  NTFS doesn't like the non-UTF filenames, it seams.
Probably the same problem as under Mac OS /HFS+-
-----------------------

And MINGW is not happy for other reasons:

builtin/rev-parse.c: In function 'cmd_rev_parse':
builtin/rev-parse.c:775:12: warning: implicit declaration of function=20
'realpath' [-Wimplicit-function-declaration]
        if (!realpath(gitdir, absolute_path))
             ^
     CC builtin/revert.o


     CC builtin/write-tree.o
     LINK git.exe
builtin/rev-parse.o: In function `cmd_rev_parse':
C:\Users\tb\projects\git\tb/builtin/rev-parse.c:775: undefined referenc=
e to=20
`realpath'
collect2.exe: error: ld returned 1 exit status
Makefile:1725: recipe for target 'git.exe' failed
make: *** [git.exe] Error 1
