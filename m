From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 60/68] prefer memcpy to strcpy
Date: Sun, 27 Sep 2015 15:24:46 +0200
Message-ID: <5607EE1E.4050304@web.de>
References: <20150924210225.GA23624@sigill.intra.peff.net>
 <20150924210818.GE30946@sigill.intra.peff.net> <5607D0A9.4000506@web.de>
 <5607E9E4.4010209@web.de> <5607EB5D.2050706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 15:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgBxJ-0004Xt-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 15:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbbI0NY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2015 09:24:59 -0400
Received: from mout.web.de ([212.227.17.11]:58554 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755637AbbI0NY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 09:24:58 -0400
Received: from [192.168.178.36] ([79.253.148.147]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MaJro-1Zzugr3fa4-00Ju5u; Sun, 27 Sep 2015 15:24:49
 +0200
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <5607EB5D.2050706@web.de>
X-Provags-ID: V03:K0:MMVQQiSjtUPn3Zpcy2hTFbEjTTaam3W9rV77D1q9CL5SMJBtgaQ
 Psdhv7oTQWex6HZ4Aqtb0xs38NUyhcG2M/rnpg96NUD8hlQeEvXTJyVgx6aJf105gJIDBX0
 5yhFVS4WWwPZsyA7qy7Lzp1jnbncSUwr9a79Dz36VBvGys4B9y0hGXGPfa2uuY8Id2UfDN1
 g0Ril3pKPXvYhZta51O4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3HKZO7TFXds=:82xWWuUu9Q9cxsgHzsqgAp
 SG15HLLUcIORvIOrsFqUMI29+S0cESf64zIPacuyN+uCakW8iWpB0LnUBcJLR48FKp03Bb5Wd
 J+XGu/NNkx2yMlqjB4IQhKFaT9FabyPGUqDv1IY26PLgQ4sJ5k6t8l1E/pNHn3MHJebGswAnL
 e1Mj2xvP/a0oLxeGG8XWG/LnJEAEzUjhmytlTPkFtZ6EuVwLqvdwjnvk7rYy140Qyj2pySwx6
 VHU15vh+vj3afkrP2bYLfp1J0VGz8ASDUlWUiTZxYrNfn4lRolrQkEaBJoAey8GRRFTwgsg5e
 T17FuQnwMQ+R/ggTW3fN7QGepkiW0GAYXxpRxNZJI2ry2sZV+uN9nCtsUKqn/TNZiBow4P9fT
 A8y7KMhP9XzG3JA7OlV4ZlUoU5DIt7forK3N/ki+AxVxfXEhCZ8cero+O392Di0mWvYC4myZx
 EncapMhvT3Uq9i4axr/znbu3q/Tuj+hpBvPq7b6ccV7r603EZM1+RYbAN1TUjYVFYY+GNeQCs
 2R4MLjwMefcz2eIdjEf/TpB8eHGq+tTwIAA1fQ94M1p1Vh2cc5c/mi0BtwnN9QB2Um2qEsiNE
 piMDHHnlnn8ZT8/I7yyVmaoxBWDupETYdqFUVw6OrcmMHDTIS6V7feEEshyk8uj6KybGxbwFR
 yBPwDGsDb5u5kfa8bmkMkk0jhfvKrkI8C0Wn1jL+KB/dxmu+uSGnkQ8CIryUnju3FQJKCBLQM
 5SvIozmWrmBwEJuvRVNMm5nnaRbeYSwPbLx4tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278705>

Am 27.09.2015 um 15:13 schrieb Ren=C3=A9 Scharfe:
> Am 27.09.2015 um 15:06 schrieb Torsten B=C3=B6gershausen:
>> On 2015-09-27 13.19, Ren=C3=A9 Scharfe wrote:
>>> Am 24.09.2015 um 23:08 schrieb Jeff King:
>>>> When we already know the length of a string (e.g., because
>>>> we just malloc'd to fit it), it's nicer to use memcpy than
>>>> strcpy, as it makes it more obvious that we are not going to
>>>> overflow the buffer (because the size we pass matches the
>>>> size in the allocation).
>>>>
>>>> This also eliminates calls to strcpy, which make auditing
>>>> the code base harder.
>>>>
>>>> Signed-off-by: Jeff King <peff@peff.net>
>>>> ---
>>>>    compat/nedmalloc/nedmalloc.c | 5 +++--
>>>>    fast-import.c                | 5 +++--
>>>>    revision.c                   | 2 +-
>>>>    3 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/compat/nedmalloc/nedmalloc.c
>>>> b/compat/nedmalloc/nedmalloc.c
>>>> index 609ebba..a0a16eb 100644
>>>> --- a/compat/nedmalloc/nedmalloc.c
>>>> +++ b/compat/nedmalloc/nedmalloc.c
>>>> @@ -957,8 +957,9 @@ char *strdup(const char *s1)
>>>>    {
>>>>        char *s2 =3D 0;
>>>>        if (s1) {
>>>> -        s2 =3D malloc(strlen(s1) + 1);
>>>> -        strcpy(s2, s1);
>>>> +        size_t len =3D strlen(s1) + 1;
>>>> +        s2 =3D malloc(len);
>>>> +        memcpy(s2, s1, len);
>>>
>>> This leaves the last byte uninitialized; it was set to NUL by
>>> strcpy() before.
>>
>> len is =3D=3D strlen() +1, which should cover the NUL:
>>
>> 1 byte extra for NUL is allocated,
>> and memcpy will copy NUL from source.
>> (Or do I miss somethong ?)
>
> No, you're right.  Sorry for the noise.
>
> I fully blame this on lack of coffeine because my electric kettle jus=
t
> broke. O_o

Thinking a bit more about it (slowly): The choice of the variable name=20
might have been a factor as well.  When I see "len" for a string then I=
=20
don't expect it to include the trailing NUL.  "size" would be better=20
because I expect it to contain the number of bytes needed to store an=20
object.

Ren=C3=A9
