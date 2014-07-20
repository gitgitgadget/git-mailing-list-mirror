From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 3/3] use xgetcwd() get the current directory or die
Date: Sun, 20 Jul 2014 17:21:57 +0200
Message-ID: <53CBDE95.7050105@web.de>
References: <53CBA59C.8050901@web.de> <53CBA65B.7090504@web.de> <CACsJy8CX5iDejuKZSEoeP_mNCyGzpZ+vQteYfQosw6x6aBJvbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 17:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8swa-0001md-04
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jul 2014 17:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaGTPW2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2014 11:22:28 -0400
Received: from mout.web.de ([212.227.15.14]:50979 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbaGTPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2014 11:22:27 -0400
Received: from [192.168.178.27] ([79.253.172.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MEqOg-1XJLBz1y1K-00Fztm; Sun, 20 Jul 2014 17:22:17
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8CX5iDejuKZSEoeP_mNCyGzpZ+vQteYfQosw6x6aBJvbw@mail.gmail.com>
X-Provags-ID: V03:K0:xmueNbuMJ1Ota8qfhTatV8LqLsAcupIZkl14kkJ7Y+fsEnsjEuc
 5G+qM6CCF9ajq9B4tjToIwbdiVLAQQOL72gVSKk5NrD1lZGoPcGlNR7QQmdTBKZdFzLZVq0
 mcIRx7iqLFrB/NkGck4+5Pg2c7+ooUg0TWQHK3POfTVvzkjFBfkOw8OyHgDnExrbU4O6sZZ
 rIY3wENSG4uaOSdrtfc+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253927>

Am 20.07.2014 14:45, schrieb Duy Nguyen:
> On Sun, Jul 20, 2014 at 6:22 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> Convert several calls of getcwd() and die() to use xgetcwd() instead=
=2E
>> This way we get rid of fixed-size buffers (which can be too small
>> depending on the used file system) and gain consistent error message=
s.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   builtin/init-db.c   | 17 ++++++++---------
>>   builtin/rev-parse.c |  6 +++---
>>   dir.c               | 12 ++++++++----
>>   trace.c             |  7 ++++---
>>   4 files changed, 23 insertions(+), 19 deletions(-)
>
> There should be a 4/3 to replace the remaining getcwd with
> strbuf_getcwd. But I guess we could add that to the low hanging fruit
> list.

I left out the cases with the go-there-then-come-back pattern on=20
purpose, as they hopefully can be changed to cease using getcwd() in th=
e=20
first place.  But I'll include another example (in addition to=20
xgetcwd()) in the reroll.

Ren=C3=A9
