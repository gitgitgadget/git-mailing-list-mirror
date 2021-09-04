Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67810C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FEF361056
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350973AbhIDJis (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 05:38:48 -0400
Received: from mout.web.de ([212.227.15.3]:60803 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbhIDJis (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 05:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630748249;
        bh=GxeDGVfM6QlNvnyqeYQvCIFfgqg29sw1ntu0m71kzHw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=QogdGqlCkZ5vIbCgIJzcsp71UhfW9EhrUMKSO0H2qRZJaYEEEYLHYKvZKbyeGws7O
         CV6l/eIqq4Q5glPT9cgSAEMUJ/q+pzpLarasAzC0z/SPBhvOFMhZOK6VOEERCve5H9
         ruuHPybMLXWshFqUUVm8CsJ07PRM3nFfsYUxvi6M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MMn8x-1mKUpq2Qql-008Yrd; Sat, 04 Sep 2021 11:37:29 +0200
Subject: Re: [PATCH v3 2/3] win32: allow building with pedantic mode enabled
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        phillip.wood@dunelm.org.uk, sunshine@sunshineco.com
References: <20210901091941.34886-1-carenas@gmail.com>
 <20210903170232.57646-1-carenas@gmail.com>
 <20210903170232.57646-3-carenas@gmail.com>
 <bc4789a0-ae80-c1dd-35b1-86949a807490@web.de>
 <YTKBzi3z5AotirNO@carlos-mbp.lan>
 <e20dc0b7-8925-1ccf-3adf-c52a892cc3f0@web.de>
Message-ID: <5983c238-e926-3b08-ed10-1de1343a8d00@web.de>
Date:   Sat, 4 Sep 2021 11:37:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e20dc0b7-8925-1ccf-3adf-c52a892cc3f0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xfTa6ah+M8H6/e7m3+IiEg/o5fBw3u7CXYTU3o+GChiPopWV0px
 kce20r9ey2+0PjVvKafCSQjkjKzdlDjKnxxL8fXW4222FRjeFaA2/VxUemaFUjanrIGnqaC
 bhps6dlQbilZK/hLbHORYTSCfaQzvkqQQBHUXVTMXpPM5ODH1UEkVb7GBTSYIvKqoj3nVAE
 PgejJVylL32DVAneaKlyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oa+NQnQEveA=:SVs0KxHA8WinfDKK3nEE/t
 gPXpDmbN0VCGzto2gjaRgDH6e07FOJOIOlzbpQCfx4n0rYi2/9mrvpUjHFkL/G9+g48tS5cu+
 o9cR7jWmhusekzvKRASmc7Z1Mgh1IP0iC2K0ioDRpsByn9vqHcki9QvZsmXqFfn/lgAPLQPzT
 m2uI5hqmRSDxsnm3RZsPp7JYl5qQXZMhOFeLPuadQX+Hpby+maIyZXulSa8/2w4uNYTofrOkx
 TKqAKBYjhkSihAos8eUDpYrm9K76NKYA42LIjQmZNDbaFaMueNglr+E6kD7L9zs3x93NMXQR1
 LiGOT7mHdkYz2+QgFkJzQhCXo2Og3uum9pQa5kvffY7QaMUy+6T7Zw9xtk1DS27uTr7XWxY9K
 SGzryVmG8o3df05G5MguJUSyTQLn/1UrKM1e6uYECgpJvAsUNVoDPOZOisShmDxlBUiLbKXHK
 jS0Wp6OoeRN/oh7zWowkorUW6U9ADp7wFQBvUwHs5x0X4VKDROi7IjiHSmPQQ7V7XDEwjJ1In
 DsgYTg0TJ5Ja+PzbGQbnhBEkwhenD1oDo9SAwFVDL9M5tO3Bv9YB298j7WmPksXZnoo4Ii0Oe
 yFvCVexHYG/B3SHRBxx/X/WS2rei1itZ0F/1EtIORySEa3a1lFOAbVjLWFjMo3O2J9q54Wta3
 8pyKOsJSKfNpPU6gKt9HCWV3Lma1xXLGugM6BnL2Pn6/n81DaF+7auTAh+tx0Xhby7hcNrASe
 /iHE47ZlEK25/HnXcO+rMghT+pAe6NSCmQxEUVfHn5foPXE5SbdvyOooaAjOpTuDf/mFsyaF3
 1WbBK1MP9G4L5v0dWfW95MrBs6io7W5FJ95M51mihC6XyWM4/3cgU2XEYREQwnDXTeaBFH0aO
 YaLq1lX7Nu2YDYUycKWj7Z3mXelle0rpica94usgZWHCCnuOGfCrJuJse/93gmTqrnHm7HnRy
 BXdmcAVfpe9UGeJ8slwxfhJu3dNFd8RMEzekvn4J9JZIh7yNngfyX/O3PeZ1aSUWS2IGKHdDf
 F2y3W1aoQVsXxsZ/x9Uq6udCvdkvWRcIJFrTAOIV/IPOAuuBYYl69zhdvGvkHmey2Fy5Z+Vz3
 nv0kz5MztW42U4lhWNnglC1nHQYPTq1hPeo
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.09.21 um 22:38 schrieb Ren=C3=A9 Scharfe:
> Am 03.09.21 um 22:13 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>> On Fri, Sep 03, 2021 at 08:47:02PM +0200, Ren=C3=A9 Scharfe wrote:
>>> Am 03.09.21 um 19:02 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
>>>> diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmallo=
c.c
>>>> index 1cc31c3502..edb438a777 100644
>>>> --- a/compat/nedmalloc/nedmalloc.c
>>>> +++ b/compat/nedmalloc/nedmalloc.c
>>>> @@ -510,7 +510,7 @@ static void threadcache_free(nedpool *p, threadca=
che *tc, int mymspace, void *me
>>>>  	assert(idx<=3DTHREADCACHEMAXBINS);
>>>>  	if(tck=3D=3D*binsptr)
>>>>  	{
>>>> -		fprintf(stderr, "Attempt to free already freed memory block %p - a=
borting!\n", tck);
>>>> +		fprintf(stderr, "Attempt to free already freed memory block %p - a=
borting!\n", (void *)tck);
>>>
>>> This change is not mentioned in the commit message.
>>
>> got me there, I was intentionally trying to ignore it since nedmalloc g=
ives
>> me PTSD and is obsoleted AFAIK[1], so just adding a casting to void (wh=
ile
>> ugly) was also less intrusive.

Expected your [1] to stand for a footnote, and got confused when I found n=
one.
The last commit in https://github.com/ned14/nedmalloc is from seven years =
ago
and this repository is archived, with the author still being active on Git=
Hub.
Seems like nedmalloc reached its end of life.  Has there been an official
announcement?

>> strange, gcc-11 prints the following in MacOS for me:
>>
>> compat/nedmalloc/nedmalloc.c: In function 'threadcache_free':
>> compat/nedmalloc/nedmalloc.c:522:78: warning: format '%p' expects argum=
ent of type 'void *', but argument 3 has type 'threadcacheblk *' {aka 'str=
uct threadcacheblk_t *'} [-Wformat=3D]
>>   522 |                 fprintf(stderr, "Attempt to free already freed =
memory block %p - aborting!\n", tck);
>>       |                                                                =
             ~^                 ~~~
>>       |                                                                =
              |                 |
>>       |                                                                =
              void *            threadcacheblk * {aka struct threadcachebl=
k_t *}

I don't have GCC installed, only checked with https://godbolt.org/z/jc356v=
qb4

Ren=C3=A9
