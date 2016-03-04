From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Fri, 04 Mar 2016 13:16:12 +0100
Message-ID: <56D97C8C.1060205@web.de>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Alexander Rinass <alex@fournova.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 13:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aboej-0002tI-2H
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 13:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbcCDMQY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 07:16:24 -0500
Received: from mout.web.de ([212.227.17.12]:52417 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbcCDMQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 07:16:23 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LpfC6-1ZzzCK3K1W-00fOM4; Fri, 04 Mar 2016 13:16:14
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
X-Provags-ID: V03:K0:YI1wjM2lfK6UVUFjK4Qr+2+ytVr3bpixyeoJPNQjxWDDriv868L
 E2d1sWirwtKQ/+CRwrEUGp/SKbx0Gd3hBlfur9eA9yyskLSlxzFbpue9C2iyc0W9PeLZIOl
 dPcOEUspAj6j5+ITTZZekyyrLHkMT/E64Ue/ksgh+lhiaxN04C2GorU/YmCQTyAKUZjFCTK
 tuRR8JOYz6gRlK5OstoeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xWE0EGMa25Y=:peSi+h00qpxPrTOVWn9WhZ
 A68/adGJswFsQpt+Yi+h6ZQpTor29/dJ3XgKXEaqCgpgagOTHT7VA0IdA4+fPth5FNQxC6M92
 YbqW3bRJFhe3maAgotGduAPWB19y7KSvPfrzpLacosxNNpfmVSJpGi3TQE5tV1qSZhyNkXweC
 EL0AWWYgiE/2z2zWzKJlKp7EQ33aM7aOr1ftPrhbNYk62JuQDUI6k0SW8q4dVzDUaXV7IJwn2
 4HsPy+SK5Oes3cVUZIFKXr3x9kFRsM793KM8gl+izE0x9AYfiZh7keTqx5VhsZwKtlUDcHowQ
 xj4CxXhHnDh0h2abncSfDr7gCZjXLpem/rvu3wUqzfPyuFJB8s/9BBiyrdOsLgFq48MZkeSqp
 pnkLdK/HGfsiV1RVyZOMJMTKOi6rQJDKbBhVNfJOMgNn9Gyk7UeQm/JVHy5QKw9atRiMSDOFJ
 VFTv8dzR4HfsbGIp5yDptljcwMdnx3Rp/pU7+3tsbaXvbcRrnRJFxAJctC4gl7It5JD9w/ZYG
 Cp48sKnap4taiLP9oYpxkARNEIsR+XPdzOapHc1NF24bhtuObp9Zb4u+tGFGhOVZtcMs9sNMk
 jxIyOvsMqanKeTh+8r8rn2wlj6/ZQlkR5GE5B2W9RnrSuVRGxwRakhS9C5eHlzsrf3w59a/TN
 9MlSoiVgwcuorBUxvvZyRWyyMswnaPStY2PQKCOZEKvD//Zs8XATpMA0qQh/uAT95/bp2kWs7
 aGU4nT1w/JbLF8+l4Dnc4fCig+I9hZA5mHUNrBVyQcAYAl2rU7EJDkZIwt8akvddzprXaiKP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288251>

On 03/04/2016 10:07 AM, Alexander Rinass wrote:
> Hallo,
>
> It appears that the git diff command does not precompose file path ar=
guments, even if the option core.precomposeunicode is set to true (whic=
h is the default on OS X).
>
> Passing the decomposed form of a file path to the git diff command wi=
ll yield no diff for a modified file.
>
> In my case, the decomposed form of the file path is sent by the OS X =
Cocoa framework's NSTask, wich I am using in an application. It can be =
simulated on OS X by using $(iconv -f utf-8 -t utf-8-mac <<< FILE_PATH)=
 as file path argument on the shell.
>
> Git commands like add, log, ls-tree, ls-files, mv, ... accept both fi=
le path forms, git diff does not.
>
> It can be tested with the following setup on OS X (as iconv's utf-8-m=
ac encoding is only available on OS X):
>
>      git init .
>      git config core.quotepath true
>      git config core.precomposeunicode true # (default on OS X)
>      touch .gitignore && git add .gitignore && git commit -m "Initial=
 commit"
>     =20
>      echo "." >> =C3=84
>      git add =C3=84
>      git commit -m "Create commit with unicode file path"
>     =20
>      echo "." >> =C3=84
>     =20
> This gives the following status, showing the precomposed form of "=C3=
=84":
>
>      git status --short
>       M "\303\204"
>     =20
> Running git add with both forms does work as expected:
>
>      git add =C3=84
>      git status --short
>      M  "\303\204"
>     =20
>      git reset HEAD -- =C3=84
>     =20
>      git add $(iconv -f utf-8 -t utf-8-mac <<< =C3=84)
>      git status --short
>      M  "\303\204"
>     =20
>      git reset HEAD -- =C3=84
>     =20
> However, running git diff only works with the precomposed form:
>
>      git status --short
>       M "\303\204"
>     =20
>      git --no-pager diff -- =C3=84
>      [...shows diff...]
>     =20
>      git --no-pager diff -- $(iconv -f utf-8 -t utf-8-mac <<< =C3=84)
>      [...shows NO diff...]
>
> I took a look at the Git source code, and the builtin/diff*.c do not =
contain the parse_options call (which does the precompose_argv call) th=
at the other builtins use.
>
> But I am not really familiar with either C or the Git project structu=
re, so this may not mean anything.
>
> Best regards,
> Alexander Rinass
>
Good analyzes, and thanks for the report.
It should be possible to stick in a

precompose_arrgv(argc, argv)

into builtin/diff.c

Do you you can test that ?
