From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Mark win32's pthread_exit() as NORETURN
Date: Wed, 2 Mar 2016 20:10:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603022008240.3152@virtualbox>
References: <69eef72cfc77e62ad7ad17c6df5f2d2396c64991.1456840324.git.johannes.schindelin@gmx.de> <d584d8bdaa8645a406c96f2a11f04febf57b2c25.1456841593.git.johannes.schindelin@gmx.de> <56D5EEE2.3080100@kdbg.org> <xmqqio166l0n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 20:10:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abCAa-0001u6-Ng
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 20:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbcCBTKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 14:10:44 -0500
Received: from mout.gmx.net ([212.227.15.18]:54495 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752458AbcCBTKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 14:10:43 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M936L-1akmXS3dNN-00CPaN; Wed, 02 Mar 2016 20:10:31
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqio166l0n.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:PDs/Tv7lzW5O4q0pplxl+zBX70g6LdrIwrgFefKr9IC+IITyrvn
 bofvWW9w8si7FYHFKelY0kZWbu3pHHlGQXQbLLzihirc45yFpbcaLfI40DLLqJjhN9CiyGY
 JCZESnCWAVp/wCh/pFvVd5DQg4ZA1wlQkB5AqmPpbi5PtrGtN61FViipAqmAascL7khUmFM
 7oW5jth6vQEHBk5GeTusw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TO4GYtym7lA=:GzrilLLdnqXCRJtPM+1ljc
 ua/Rm8saVgtZnoFLWYM4PV4zi/YIsmrf+YAYib1HItVAoN/liujOYt1Wz6VZHvp2eGqF1YoAX
 nay5fAxbGLpnQyCYQfwCgwsmi74j4Q8EfyLzjqWSCEf+SO5dBPLw0X6Gux+qE7y8wNxdMwpwr
 +Q8YVQLbaeXeIAEwDW6hlYKofIU0zwcXK9xbjhepPIaTCxEDLPccZGq8lyTy+xGw4CEQhpkY0
 3+JiBM1OG2sNxXj1LyZGrrdn/YOupeaIT+TdWQxA4yQyj4r6ySi53AW1VufJgZjs9ZACFh2k7
 EJafBGwGL+0OfJmrKN5kMZOIDRBVMLYlXr2FQfv1M+A8p1KU4F5sdanlCz+lQP/UHJLBNA7da
 yHMQBBmZaSW8aUix0ItkzOcDu1H6L98ff9x+/dMpg5JfJKujUiH5kVV2vrOhP7Dnt1suEjnul
 tZ7fnhiEk7oa1ctfkPdJE+Xnkzms4Js98tjhNb0kBVj045u5+igXZhz734OGvvyvTTtHHX6IZ
 Mubj+bssE2YQbuHpjfuWhwqV9lrdNfkXJt3GR2gqfEG3OkxNB8DQVEEdq2B5PvD/7AiR++ZdC
 7UUvYtXrE4hT2P+Rp4l5szXdJRO7zyEu/NReSgrakLxqD/Q6Lpb+8xr1kScM/6kFxl9qlOxBm
 lv3beH2y1SOzcyqxx5gHDK5PwddfILhXxRj8kzTNDmQ4u51XGuN0yrZNSjMs/8EkAcUbT9kS/
 33IpdNo8BtuVD9BdCHGR3Su02N+OCXpn4wN5czHoiV/ht2EgQR/kK925OP+Z2vACLeiA22b5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288146>

Hi,

On Tue, 1 Mar 2016, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 01.03.2016 um 15:13 schrieb Johannes Schindelin:
> >> The pthread_exit() function is not expected to return. Ever. On Windows,
> >> we call ExitThread() whose documentation claims: "This function does not
> >> return a value.":
> >>
> >> 	https://msdn.microsoft.com/en-us/library/windows/desktop/ms682659
> >
> > This is misleading: MSDN marks all functions declared void as "does
> > not return a value," for example, look at EnterCriticalSection:
> >
> > https://msdn.microsoft.com/en-us/library/windows/desktop/ms682608
> >
> > For this reason, I actually prefer your version 1 patch without the
> > explanation.
> 
> ;-)

Well, I really like to have that link so I can find it very easily myself
by simply inspecting the Git log. And the explanation itself was easily
fixed.

> 
> >> -static inline int pthread_exit(void *ret)
> >> +static inline int NORETURN pthread_exit(void *ret)
> >
> > I would have written it as
> >
> > #ifdef __GNUC__
> > __attribute__((__noreturn__))
> > #endif
> > static inline int pthread_exit(void *ret) ...
> >
> > but I can live with your version as long as it compiles.
> 
> Either way, let's make sure that the final version returns "void",
> cf.
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/pthread_exit.html

Fixed, too, in the upcoming v3.

Ciao,
Dscho
