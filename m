Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38F681F461
	for <e@80x24.org>; Thu, 29 Aug 2019 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfH2UIZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 16:08:25 -0400
Received: from mout.web.de ([212.227.15.3]:53703 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbfH2UIY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 16:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567109299;
        bh=jhu+uEKd56I7zCa28ax/KaFKgYVKR1/uZYRwwDLThrI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mv2w1Z6mfmACnjsQGYs6AhUTBlgnQgrQoYQphQiXDtL+N4ia2dYUsL3+Es1/KquY5
         XKjWzB74y7oF4Wp9JLcM/NM3JzyQy69bumWgUT0/2gwyX0hXyz0qDo99yNYOF44TN0
         PxupJCShCdV3upDo3wbDpW/kEggtIWb7Fr6ohkvE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LjaVE-1iaZbv20RE-00bb1l; Thu, 29
 Aug 2019 22:08:19 +0200
Subject: Re: [PATCH] help: make help_unknown_ref() NORETURN
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <d0606d19-0900-3908-2962-ceb24015f753@web.de>
 <CAN0heSp4bdJt4NKELOkvdpoygbkNZVn-96FrZnu9ymE5UNOSag@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bde881b6-7c23-6f4e-5cb0-a793a5e4f5d7@web.de>
Date:   Thu, 29 Aug 2019 22:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSp4bdJt4NKELOkvdpoygbkNZVn-96FrZnu9ymE5UNOSag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u1TM6sYaPgiA8f22V69ZYqI6iuN06TmYQOPODNQ5Fq8nzMSKSmj
 WofbZSmRou5Lkk8LQhU/0YmjFp/hUU36Ehr+tfVHuLrG0mR0QLxiqn1ph9GtbddQpZL3GuO
 eIlegkvacQSj07hEoRW2aS1ZM2q7hIJIjeEAWnvV5ATTu7jeKjEl7PKyEGl7eXTsf2f9OqD
 +nUbpcT1rQy/yQsMrhGZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lxRGJYO1xtM=:9Fx3JLJjB6FDslSId5OyWR
 cYjWvCDE9fz/BVCLQnftUwFI2cWuVXUU04nEKjDVrFk7WUg1taEwXu5B8ZwIS/HTRcakN9pW2
 aQ6yNG35zjDBEv11hB5LQiOK6gpUzopki6SOfilEVlU2Idweo+lV1ppo/TNWUB9tm0UXNtL6Q
 W3bqEHmQ6HfVN5cZHcoh5p+7Uw8itlgnKc1xuM1ASnow8sKnH4cx+FkrhvlMqmP9pdR+z4ojg
 fsgus9kSrefRWHkPGVCxD/GsI3ZmvKM8FKfV+SB2epCLrd1j/nswvFCsocF0XUXTAngHSNv+X
 WWSoHUoxz2HJvq+nTLiNbJntxSErRHLfTVc6GC5bPUqhCz5DefTdWiD5kll6DITV+SoolbG91
 cPxrQ7C5bEW61+/nZaRS0yKYDAl5CDXgD+OCqKE0vTXDsjLwNSBtIsy7tO9fp5uWrtp1MPTjd
 GDg0Vzk+6Q95vTEjHVuXiLrWHTaJlrfn+KwoxRrEcRhZVnz2TBoI51a1aobYNiSFtSN4PE59E
 ABhA3rQgGDhfyFl3SGFUcyWGtFXqz/KkwKiEmEZiCKsJNOgjitu4sXIi0e9Qs0IQgLZ3cDBob
 spuYcH0s2pHtok9w9w0gQGjj6JJHQK8rLGd5FgsGReryqxG2UQ/8+EnjUx2VmpqKQr7UZJNon
 AVHxUkjyyOPuowHmKpvnTguEwaXqBns1P56W4PY5k7fHInkWEOWWjF3GiVoGsbkzfJ65RpeS8
 6lerv4V5o9p5qJ6Li+nv+rM7GgxzVf4LyDtQSC6wEkhzkvv+cJYGptX4Z7PkH4LboAlT3O8M0
 KQqAKZFdbTlOhPzGXphKJr7qgOFdxdK4q3cwn/An3w0QvOH9b1AFKwU0KsFlbxifPtVpkcWtd
 NPxvBmrACEOGrAe/Zm/ECe9yEsB+5dlhFN5NaYPoeMglB7lWGEYqfDVvZ76APF+zw2b0e7sSs
 9DRwuqmVavCcMNf7sqLQ4avXCXJ8P4sZPKwOMWkrAOZPIgea72huFHej5Lyr3gHxul204WPqu
 +CCQ887Vnk+tvXxd3PttND6Hs06osIKB0Wm8RdRcojZ0HEB4nSdx9SOyGAZWvlG8f9aj4NOPR
 NnuPI4vLxHZrPsmi6V46UuV6Z0g9bxWd6EHKO/15BFNAMxHS6ptFJOsUVX0WDiLg7OUavzrId
 7ta09n2RkEgW6cMyTWmQ/ofL0OpyM8mRa7rNowcVUmjxgh4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.08.19 um 21:40 schrieb Martin =C3=85gren:
> On Thu, 29 Aug 2019 at 21:15, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> diff --git a/help.h b/help.h
>> index b8780fbd0f..7a455beeb7 100644
>> --- a/help.h
>> +++ b/help.h
>> @@ -42,8 +42,8 @@ void list_commands(unsigned int colopts, struct cmdna=
mes *main_cmds, struct cmdn
>>  /*
>>   * call this to die(), when it is suspected that the user mistyped a
>>   * ref to the command, to give suggested "correct" refs.
>>   */
>> -void help_unknown_ref(const char *ref, const char *cmd, const char *er=
ror);
>> +NORETURN void help_unknown_ref(const char *ref, const char *cmd, const=
 char *error);
>
> Funny how this claims we'll call `die()`, when we'll actually call
> `exit(1)`.

Ah, I didn't even notice that.

> If we actually did call `die()`, I suppose the compiler
> should/could figure out by itself that this function, too, won't ever
> return.

The compiler can figure it out with exit(), too; system headers (at
least for glibc, but it's probably common) assign it the noreturn
attribute.  But there is no way to transmit that information to callers
across compilation units  if not for the header file, right?

> I wonder whether the real bug here is that the implementation calls
> `exit(1)`, not `die()`. That is, the exit code is wrong (1 !=3D 128) and
> we're missing out on the flexibility offered by `set_die_routine()`. If
> not that, then I'd say the documentation is buggy. Hm?

This inconsistency has been present since e56181060e ("help: add
help_unknown_ref()", 2013-05-04).  Using die() is going to be difficult
due to the multi-line suggestions printed by the function.

Ren=C3=A9
