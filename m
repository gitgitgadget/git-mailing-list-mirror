From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Wed, 30 Jun 2010 20:40:23 +0100
Message-ID: <4C2B9DA7.9000902@ramsay1.demon.co.uk>
References: <4C226520.5080009@ramsay1.demon.co.uk> <20100623210820.GA24242@burratino> <4C264019.6030408@ramsay1.demon.co.uk> <20100626181945.GA13070@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Peter Harris <git@peter.is-a-geek.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU3ya-0007p6-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab0F3Udj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 16:33:39 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:61419 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754947Ab0F3Udi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 16:33:38 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1OU3yS-00067v-bx; Wed, 30 Jun 2010 20:33:37 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20100626181945.GA13070@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149990>

Jonathan Nieder wrote:
> That does make sense.  Perhaps =E2=80=9Ctraditionally=E2=80=9D was no=
t the right word;
> I was just looking at common practice.  I=E2=80=99ve just never seen =
-O put
> into LDFLAGS, for example, and I think most people would expect
> setting CFLAGS=3D-O0 to affect the linker, too.

[This is now a bit off-topic, see below, but what version of gcc are
you using that passes -O to the linker (well, collect2 anyway)?
Do you have to pass -flto? For example "gcc -v -g -O2 hello.o -o hello"
seems to show (for both gcc 3.4.4 and gcc 4.4.0) that neither -g or -O2
is passed to collect2.

Hmmm, the output from gcc 4.4.0 adds a line like:
    COLLECT_GCC_OPTIONS=3D'-v' '-g' '-O2' '-o' 'hello.exe' '-mtune=3Di3=
86'
so, does this imply this is a env. var exported to collect2?
dunno ;-P ]

> I suspect the problem comes from my unfamiliarity with MSVC.

Heh, I'm not an expert user of msvc either!

> Maybe clink.pl should use =E2=80=9Ccl.exe /link=E2=80=9D instead of =E2=
=80=9Clink.exe=E2=80=9D and this
> problem would go away.

I tried this *very* quickly and it didn't work. (It's quite possible
that I could spend some time and get it to work, but ...)

The patch that Peter sent seems like the way to go, since it does not
affect the regular (non-msvc) build - and it works! ;-)

So we can drop this patch. Thanks for your time.

ATB,
Ramsay Jones
