From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh
Date: Thu, 8 Aug 2013 14:13:26 +0200
Message-ID: <877gfw4byx.fsf@linux-k42r.v.cablecom.net>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <gitml.jexpert@recursor.net>
X-From: git-owner@vger.kernel.org Thu Aug 08 14:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7P5x-0004pE-W1
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757776Ab3HHMNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 08:13:30 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:25955 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab3HHMN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 08:13:29 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug
 2013 14:13:24 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 8 Aug 2013 14:13:26 +0200
In-Reply-To: <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 13:56:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231873>

gitml.jexpert@recursor.net writes:

> =E2=9E=9C myproject.git git:(master) git fsck
> Checking object directories: 100% (256/256), done.
> error: packed 0f5f33639bfc1a781fe080c31a1f076d9a25c1d3 from
> .git/objects/pack/pack-6a6f5355584a5d71215d5fc867ce09602ceab533.pack =
is
> corrupt
> *** glibc detected *** git: free(): invalid pointer: 0x00007f46a09e90=
10 ***
> =3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=3D=3D
> /lib/x86_64-linux-gnu/libc.so.6(+0x7eb96)[0x7f46d9ebab96]
> git[0x4ddf46]
> git[0x4b4123]
> git[0x431524]
> git[0x405ce8]
> git[0x4050e2]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xed)[0x7f46d9e5d76=
d]
> git[0x405529]
> =3D=3D=3D=3D=3D=3D=3D Memory map: =3D=3D=3D=3D=3D=3D=3D=3D
> 00400000-0055f000 r-xp 00000000 fc:01 12452043
>  /usr/bin/git
> 0075e000-0075f000 r--p 0015e000 fc:01 12452043
>  /usr/bin/git
[...]
> Any hints what to do?

Regardless of any possible fault in git-svn, there's an obvious bug her=
e
with git-fsck.  Can you share the pack (if the project is public) or
compile a git-fsck without optimization and with debugging, and run it
under valgrind, to hopefully get us a backtrace of where the memory
management goes off the rails?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
