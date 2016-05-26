From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] xemit.c: fix a [-Wchar-subscripts] compiler warning
Date: Thu, 26 May 2016 04:22:04 +0200
Message-ID: <57465DCC.9080809@web.de>
References: <57462FF3.4010705@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 26 04:22:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5kwS-0006zN-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 04:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbcEZCW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 22:22:27 -0400
Received: from mout.web.de ([212.227.15.14]:51178 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbcEZCW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 22:22:26 -0400
Received: from [192.168.178.36] ([79.237.57.138]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M5Oql-1bScPM3g9X-00zX7J; Thu, 26 May 2016 04:22:11
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <57462FF3.4010705@ramsayjones.plus.com>
X-Provags-ID: V03:K0:qRZBHOnpoJDNjyXjp7jot6m7kbb+FkQ0lrQV7oqMRv6SMBTKsKZ
 pVUUYegk4en5Fp390hBieqzdmvxPt0JmD4l9kP08+S6f9O3EflNckim0zSK6WvJI9mtEA78
 gXYjNIThwvLLuemHmT/W0qQ1C7Ph+xT6fNEoR4SONY7Hs0xXK+yi3KFD9Phe8UBXMF8dpv+
 K0Yq2xCs9vaq45L316paQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AJ+9TrYhGXg=:Cw/Dvti4KEpD/CGJ3Lssw6
 /0XlS6yU1uWOCQQTrc5uuTScCoRmoaUqiIoc7jwXCOzMSDIZoTMnYtqZLomiH6uClqwvMOH3w
 BFIhcFEQxsCFV8OGu3ruxwmQDfgDZkdDXZfBkSZbHO0YowIrPcfMmcQqXjpBufkH5FdCITf3F
 8+H65na22Y15afpLV6Dx0R8FCSKm+hMYRWqjPqxpyE/10ZTpywfVjYq4ULZ82geTQz6Hipg4P
 M3nvjMjNvWVgNII2YWIJZ2pqIEJlZ3wowdOGL2H6nIzMRU2sCNcj0EEDK/HmXasFtrk+x0qqr
 xrWS43SFdxaW1aJ5yT8n9NI/Mnnuqt8zBm61qNCU8Qbz9bx1Nm3Gh2KKU42T9n8kC+davEgdM
 T1fvcMmHxelNkSUy42c9lXtUGxfO4Oo6pepW33Xc9JdXt7Wk02VeYSHrO54fHkqTOBTz/i0kJ
 tLsuHnIMem5CqMCuKPWxTT1z6mrsZhK/a/vfsIxYk/bbgpqzIHQqIJelGIUjU30IsUiU451sd
 jQW83NJup/MGb+7cSbyY6bqeXGX4TMDfAn/tE2r/uUB3BKrARkS0LZgRjYz1P1s6FGwPisr5k
 MQ19T6Em6ZKJwGVEt1cLcTzEidgrnEg4O5+anuB7HkmeGNeL7XZw9SQBW/qvZKAa3PVh9m1MP
 rIDbvF11QjzbKPQmR4epc7bJJER6B7Memztp6vTbrwnknzxB5vL8wOseno+ObILbYLiUhp7sq
 vj9AVYYSWWjWy6qqINKOWc03o4tQ8cVHm8z1LVFKndu35YRUxPKeVrLcI96Ycc9lJmgf9Wv+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295627>

[sorry for duplicate]

Am 26.05.2016 um 01:06 schrieb Ramsay Jones:
>
> While compiling on cygwin (x86_64), gcc complains thus:
>
>        CC xdiff/xemit.o
>    xdiff/xemit.c: In function =E2=80=98is_empty_rec=E2=80=99:
>    xdiff/xemit.c:163:2: warning: array subscript has type =E2=80=98ch=
ar=E2=80=99 [-Wchar-subscripts]
>      while (len > 0 && isspace(*rec)) {
>      ^

Ah, it's not using our own isspace(), which works fine with signed=20
chars, because it doesn't include git-compat-util.h.  I'm spoilt by=20
those char classifier macros that can be actually used with chars..=20
Thanks for catching!

Ren=C3=A9
