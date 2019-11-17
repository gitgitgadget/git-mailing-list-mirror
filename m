Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081E71F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 13:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfKQNkJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 08:40:09 -0500
Received: from mout.web.de ([212.227.17.12]:49239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfKQNkI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573998006;
        bh=0x6Ybp9liSgP5isKjOHBX0Gyo/XnN8IZIaIrTrOi13I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M/hkrUMgeXiz5WMNpm+lAHNBOtuTEHKyYCHrsI3d6AlPKeNpdMAqYkCRhmUUyV3zg
         A2mq7zpD0mXmLDRM3Rh3BuA2DJwwTiKm95UkRJCudn36+aFOKxP2lrhMg/bmTRm+0n
         sPVbfMsNVkAyD59vLeILJClgZpW2ovHLS46hCOhA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJkt6-1iXQiA0hM4-00196G; Sun, 17
 Nov 2019 14:40:06 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
 <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
 <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <37c84512-ba83-51ce-4253-ea0f7bd41de0@web.de>
Date:   Sun, 17 Nov 2019 14:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6y56hHUAisoR7q+AScvylazVN1+1BDxVmSwXOHSCl+fuj0x36J3
 RSI/PZ1hTAFxs9JkDz3Ej2zr4E091Q2L0w6yn1FRLua/XtLYu4RX932gTEPnY/eKbvC+EbW
 XnoCgmQ/OrMvYSEI0jGN9nxWnAz5YiZTguZW1G5blViFyivaWOxGFEqJlVJ4YfSkpFameC5
 t+OjgU+FjMJnyQ8qY8NJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bxPsIXIqo0s=:2rFltEmM31jpQKLTGljDYL
 rNRAdGEdav2AdEZlqHGSap4kZNCyupJuXXqQh4CWYfiAGTYC8btXrUkBtPFB+hUFe4pteR3nx
 cVeRrrwind0cOoS8l2X3MTELCqnUZSdUY04//iO+acxqVPgYofw6NbcV2N1pqekQX0CWDmHrx
 THzWjx6AL5PGg5ub7YzR5v+aF/bGC8eaI2oUqPVqE3sZIe4ZIMoKdyF86nICXJB+3D85JrSPL
 MzR5I+ym5gdCqKYjN0cCIsjAi+Dj3kzae7rNnzS48JiIV+ki4a3ZvzqCQNGMwWixg4HAl8df9
 B9VxYJrGqmZ1Km+NdodXXKERyAMabs7558Gu/2avm2IUz61D8w209s5KXeBYXhQ31FafHHqQz
 Q3ZKzIzgCVXbREPgSrAS3gcceukZaEko5V+akJxz2yknG07iSngtn1nL0rhK8Ovfh6t2KptU0
 XEzOV5NjEhaE1CDLda0gNgoauh8NEYz+EL/zH7t367lJ0ppA54DlWfY4q78qbW23Ic1RxqXXW
 KGH+FX/doR3IJoNxJb1FRnlM1VbALJHr1Tzn00dT+0LTSaAuXC3gphg+ZdkQJCh4c3O8XPejt
 OJnoeGmFjHEOi28bbpnkfM7vrbRis/uB8nv4fu8HSwF9WavF4/MqN8hbQDEqw7NuV96j2y7WC
 okLPCkJiees9XANmaMoiR3gIn0Mh0ZLmokBub0fbd6YyzFHHRO4FJfglT2rqb5Y1tWK1deEnX
 fOQWFlvYQvPGrSTlnB0d6DGC+IDUURwwnvEJ85VHXb7lpetD/K/g+ZLOzNfelJRsIRVyn+/+w
 9VDxeyfbUn9u57UkS4lN5l9AkhaTOCiAvE0UtmkyazUdwDopRQBi0t1L8eVSwF3IsK0eb6C7Q
 stibhkrBXDF/LsXLwnyZ4VdAl9i8Ds1DaU4JGqezGOT5VSOfHi636pfN1N16bsrrAsIf99OuX
 +JC3dxAmsZTyCltD3Rh3v3+KPdzkFzfxQ5UWotyJa3k+/zARzrEfbFRUXbmXgSgCytqJI1oe0
 WyBQFqHV2TnQytrNWM8tJpexdpfp6aHGAmKD2nru7mp4erpyMhTHHPuBnliT6QeQknHd2a/Dm
 63EWxrBqIMts9o4t1GJWgNUih/LbKZiJrWaAaIlurPyGOFHwPZX8eb448S0RAyhkCDJ2e8nwy
 0v5AAfN2Dx22kidMTK+zbgB5UurrAlqJ2IXej8vl21f1/MUOJxYle2KRHWZSMrjJfMZuRWc6s
 rq8QFgWtYuUgLpgUYQPCIL4GDqWICdp5lR4DcZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 08:56 schrieb Markus Elfring:
>>> @@
>>> expression dst, src, n, E;
>>> @@
>>>  memcpy(dst, src, sizeof(
>>> +                        *(
>>>                            E
>>> -                           [...]
>>> +                         )
>>>                          ) * n
>>>        )
>>
>> That's longer and looks more complicated to me
>
> I point another possibility out to express a change specification
> by the means of the semantic patch language.
> How would you think about such SmPL code if the indentation
> will be reduced?

Whitespace is not what makes the above example more complicated than the
equivalent rule below; separating the pieces of simple expressions does.

>> than what we currently have:
>>   @@
>>   expression dst, src, n, E;
>>   @@
>>     memcpy(dst, src, n * sizeof(
>>   - E[...]
>>   + *(E)
>>     ))

>>> @@
>>> type T;
>>> T *ptr;
>>> T[] arr;
>>> expression E, n;
>>> @@
>>>  memcpy(
>>> (       ptr, E, sizeof(
>>> -                      *(ptr)
>>> +                      T
>>>                       ) * n
>>> |       arr, E, sizeof(
>>> -                      *(arr)
>>> +                      T
>>>                       ) * n
>>> |       E, ptr, sizeof(
>>> -                      *(ptr)
>>> +                      T
>>>                       ) * n
>>> |       E, arr, sizeof(
>>> -                      *(arr)
>>> +                      T
>>>                       ) * n
>>> )
>>>        )
>>
>> This still fails to regenerate two of the changes from 921d49be86
>> (use COPY_ARRAY for copying arrays, 2019-06-15), at least with for me
>> (and Coccinelle 1.0.4).
>
> Would you become keen to find the reasons out for unexpected data proces=
sing
> results (also by the software combination =E2=80=9CCoccinelle 1.0.8-0000=
4-g842075f7=E2=80=9D)
> at this place?

It looks like a bug in Coccinelle to me and I'd like to see it fixed if
that's confirmed, of course.  And I'd like to see Debian pick up a newer
version, preferably containing that fix.  But at least until then our
semantic patches need to work around it.

> But this transformation rule can probably be omitted if the usage
> of SmPL disjunctions will be increased in a subsequent rule, can't it?

Perhaps, but I don't see how.  Do you?

>>> @@
>>> type T;
>>> T* dst_ptr, src_ptr;
>>> T[] dst_arr, src_arr;
>>> expression n, x;
>>> @@
>>> -memcpy
>>> +COPY_ARRAY
>>>        (
>>> (       dst_ptr
>>> |       dst_arr
>>> )
>>>        ,
>>> (       src_ptr
>>> |       src_arr
>>> )
>>> -      , (n) * \( sizeof(T) \| sizeof(*(x)) \)
>>> +      , n
>>>        )
>>
>> That x could be anything -- it's not tied to the element size of source
>> or destination.  Such a transformation might change the meaning of the
>> code, as COPY_ARRAY will use the element size of the destination behind
>> the scenes.  So that doesn't look safe to me.
>
> Would you like to use the SmPL code =E2=80=9C*( \( src_ptr \| src_arr \)=
 )=E2=80=9D instead?

That leaves out dst_ptr and dst_arr.

And what would it mean to match e.g. this ?

	memcpy(dst_ptr, src_ptr, n * sizeof(*src_arr))

At least the element size would be the same, but I'd rather shy away from
transforming weird cases like this automatically.

>>> @@
>>> type T;
>>> T* dst, src, ptr;
>>> expression n;
>>> @@
>>> (
>>> -memmove
>>> +MOVE_ARRAY
>>>         (dst, src
>>> -                , (n) * \( sizeof(* \( dst \| src \) ) \| sizeof(T) \=
)
>>> +                , n
>>>         )
>>> |
>>> -ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
>>> +ALLOC_ARRAY(ptr, n)
>>> );
>>
>> memmove/MOVE_ARRAY and xmalloc/ALLOC_ARRAY are quite different;
>
> These functions provide another programming interface.

Huh, which one specifically?  Here are the signatures of the functions
and macros, for reference:

  void *memmove(void *dest, const void *src, size_t n);
  void *memcpy(void *dest, const void *src, size_t n);

  COPY_ARRAY(dst, src, n)
  MOVE_ARRAY(dst, src, n)

>> why would we want to jam transformations for them into the same rule
>> like this?
>
> Possible nicer run time characteristics by the Coccinelle software.

How much faster is it exactly?

Speedups are good, but I think readability of rules is more important
than coccicheck duration.

>> Handling memmove/MOVE_ARRAY and memcpy/COPY_ARRAY together would make
>> more sense, as they take the same kinds of parameters.
>
> Would you like to adjust the SmPL code in such a design direction?

I can't find any examples in our code base that would be transformed by
a generalized rule.  That reduces my own motivation to tinker with the
existing rules to close to zero.

>>> Now I observe that the placement of space characters can be a coding s=
tyle
>>> concern at four places for adjusted lines by the generated patch.
>>> Would you like to clarify remaining issues for pretty-printing
>>> in such use cases?
>>
>> Ideally, generated code should adhere to Documentation/CodingGuidelines=
,
>> so that it can be accepted without requiring hand-editing.
>
> But how does the software situation look like if the original source cod=
e
> would contain coding style issues?

The same: Generated code should not add coding style issues.  We can
still use results that need to be polished, but that's a manual step
which reduces the benefits of automation.

> It seems to be possible to specify SmPL code in a way so that even quest=
ionable
> code layout would be preserved by an automatic transformation.

That may be acceptable.

Ren=C3=A9
