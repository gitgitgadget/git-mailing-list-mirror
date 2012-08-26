From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: t9020 broken on pu ?
Date: Sun, 26 Aug 2012 22:03:14 +0200
Message-ID: <1518108.91xN7nanEh@flomedio>
References: <5032A483.4000009@web.de> <3012698.d22asrojOq@flomedio> <503A79EA.4070206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:04:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5j42-0007Rl-PH
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 22:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab2HZUDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Aug 2012 16:03:20 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46759 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2HZUDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Aug 2012 16:03:20 -0400
Received: by bkwj10 with SMTP id j10so1024404bkw.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 13:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=5ltK7LH5dPHqsLw2zQZMJKl6mFOO+XuqRXvlbP51xzI=;
        b=gYlBTbgBZnnZGJZosWJo2WUoPMfJPBlzrgqJuBkGc2reqb4YR1JG3o9fYkJYb6C3S4
         MVIvS33gIqBsCXx7M/I/xOfea5fix9W22Zd9LIM+iqNo7TmvIs5vJPPWNwWmJqNfb/I1
         2Y9a5Yhdi49gSGN2jIkuTEFNMu/cxV+JXYJsiiAm+iuZREgjlXfdset6bmHyh/g5s5Ml
         9p638cf5XRUZQZh7mGRztCxXBTx7FUJRup473Sgzsa9GjhKAh670OMeZrRIvBat5iXyJ
         08D5r2hEQ3iucjqT/TXNVKZp0IbN4uriobv85klwxtviT1MC1a2RnTgDOBSdGWD/ZC+X
         xhxg==
Received: by 10.204.151.81 with SMTP id b17mr3359734bkw.95.1346011398792;
        Sun, 26 Aug 2012 13:03:18 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id t23sm9369786bks.4.2012.08.26.13.03.16
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 13:03:17 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-25-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <503A79EA.4070206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204313>

On Sunday 26 August 2012 21:32:58 Torsten B=C3=B6gershausen wrote:
> > The reason is that contrib/svn-fe, where remote-svn is in,  is not =
yet
> > built automatically by the toplevel makefile, so the remote helper =
can't
> > be found. If you build it manually it should work.
> > Working on it ..
>=20
> Hi Florian,
>=20
> the compilation as such is started, but gives problems on Mac OS X:
>=20
>     CC remote-testsvn.o
> remote-testsvn.c: In function =E2=80=98check_or_regenerate_marks=E2=80=
=99:
> remote-testsvn.c:142: warning: implicit declaration of function =E2=80=
=98getline=E2=80=99
>     CC vcs-svn/line_buffer.o
>     CC vcs-svn/sliding_window.o
>     CC vcs-svn/fast_export.o
>     CC vcs-svn/svndiff.o
>     CC vcs-svn/svndump.o
>     AR vcs-svn/lib.a
>     LINK git-remote-testsvn
> Undefined symbols:
>   "_getline", referenced from:
>       _cmd_import in remote-testsvn.o
>      (maybe you meant: _strbuf_getline)
> ld: symbol(s) not found
> collect2: ld returned 1 exit status
> make: *** [git-remote-testsvn] Error 1

Seems you also don't have getline on Mac OS X. Others already reported =
that=20
this function may not be available on some platforms. Will be replaced =
in the=20
next reroll.
Thanks for your reviews!

I'm still hesitating to send a new version out, as long as new fixups c=
ome in=20
continuously.

--=20
=46lorian
