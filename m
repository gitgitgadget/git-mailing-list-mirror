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
	by dcvr.yhbt.net (Postfix) with ESMTP id 82CE11F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfKQSTo (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 13:19:44 -0500
Received: from mout.web.de ([217.72.192.78]:42223 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQSTn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 13:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574014781;
        bh=mt6xHDV5EM3fKorsqCKcKqJ0dskbEVwwktn9KP7p/WU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RlmVumj+YRs7tj2PvbRHsLXGlqPENEULr0PNbaHOLpWF3OcvEnB4tWk/0WtUZ+5rs
         NTdsRq4smZIdas54W+twb5vgrrubCngW1j6hMELNuHjzdXUdBm8AIr4Ab2o+qitwVN
         AS8SnZ+oIUMZu65EaQ2pO4hCWEZRvwBIxsMDuZA0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNLS1-1iTwAO2n1d-006sFE; Sun, 17
 Nov 2019 19:19:41 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <75b9417b-14a7-c9c6-25eb-f6e05f340376@web.de>
 <fc56b970-4ca1-7734-c4bb-f57cae7a273f@web.de>
 <57b5d1c9-72c1-6fff-a242-90f5f24f0972@web.de>
 <37c84512-ba83-51ce-4253-ea0f7bd41de0@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <eff19da9-3f9f-0cf0-1e88-64d2acdbabcd@web.de>
Date:   Sun, 17 Nov 2019 19:19:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <37c84512-ba83-51ce-4253-ea0f7bd41de0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zUi306fAk55q7InCGwPncKQGzanpcDHzX7NXiCVGug8wOBWNyQr
 qFw8t85ydLQvqOxo47VYNZMZaB1ADjr+IcB5ojac4Ceoiwyw88wgALDAr5PVmJVDAXTvV8i
 sx6qhyYoVh2sCA1UZjRrUqEwpf2RjjSKaXF0jtSLNJ+I6CIcb57BNQ4JaEDhHyO6i+a7mta
 LiX0F0CRtpMvmQc9877xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TGZ7opnhIwA=:+IfHjKoW/O5/PjbBVPClEV
 vn/F8SKcAdQhYM1VuVXEoFVakeFBJPH1gof/HPmU9GH0yjOlYGcA2vuP0VDybQDwOId6pcJpG
 JHL33SnSmgaSKouNEc/XVMsIB0K1iVIYTxZlLWnAVjuhzKZjSqRZADgUPA+nHRVrYGyi+nWFt
 3m2AB4Kcf5MW6q7PGRg6eYtl8OsegAOCWxzuWC8jO9N5O0myr228qJ9Lb8abyKui6713DuLkf
 3J6Q32N5/B43fKC1iVTIcv8sCs38jOSOnw81q1XPBJb7BiK9soH1wpKaMTYi9d3FSFLOv3w0X
 NZm7WE3EFHawzeVrvs89Pq3PDhzKuyYxA7ugWiozCMqenV8Emas3YR+0SMxU0Q4opDnqky1rs
 c51gyarmjpvhLvVK7rRiTBFvu2IcQGrdKFTqQt9NFl4ekc9gAH9Y40y9vDiTxlrZY8uYKJaWG
 +ulHzLdx8SbH1fP0R9ercUe0xWT+ZICnT70f5Avzu8nrtqgpYakmhKrzwzbxmMbkWc+0iQmPA
 9QeMfcp6En/285HndUTGlXsXK5cAN+W3V4zh5p22rW1NXWaioVzTvWOkBityumBQ0u3F1lqLm
 0aSmnYEGquj6twj79ZnZbJtjIRpWEFbGWSUHXkrrTpuI41jHroNY+Sa0fR/NoBuxt5o7fZiAa
 VLb/CsEPGUUSph18VB6CigKP1jrx3ZWCNvclXje4t5BzEcEwEKGbXIohGUpV5f88UcIZ4PWcj
 U/+LI7h7FRI0ipRuo1a1Uu/A/otYafe6qJTylHNUfPkD51InaNBRtGAVjfykIS7IsJpYTwPAF
 k30zgqLHuOxQ/uw1hyqtXQTyaZej2/0qn3Me6Oez2byGtXzR8LSTVv5kTwXZ26qSje6FYjip9
 O+nbx+9UChrMExQNNWuMVUPkItNSVSaup//gk009Maf+pzFI6diHcH8LyYLUYNT+LHBcqlcQH
 BfnGc8I8Yz35QVlrPHiyNveFOW0mnN3qWRzxNfa1fsBHEGYFSoUmobeqK7r4JQmWgAYb4y/Nk
 qJU3iqOEcUGxTt7plgnS7xgOjcm7AJiZL9O363TlV82nQUpbTtM00oVgtih+cEOYmBLtF2KNc
 5CWtgSRCEBmuXezBa/pcnP3ZwNIh5N4nRd8zdFJ+CAxsYbPWHixnU61KTUd1T5pNUQTh6JpRb
 kMk7yfQ+iBUeiMqmL+0ICEfNQON12IQQHCQ51GsKdXLuujXfBDSB9HoDtIjj45X3LI90RLv5m
 sw3NgD+lhdNzN8XyNg99BtYirkoEYFJ/x6b6Wed//CI4DYyg/txZLa1GYwXM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Whitespace is not what makes the above example more complicated than the
> equivalent rule below;

A different code layout might help in a better understanding for such
change specifications.


> separating the pieces of simple expressions does.

Will there occasionally be a need to change only the required source code =
parts?


>>> than what we currently have:
>>>   @@
>>>   expression dst, src, n, E;
>>>   @@
>>>     memcpy(dst, src, n * sizeof(
>>>   - E[...]
>>>   + *(E)
>>>     ))

Are any circumstances to consider where only the essential implementation =
details
should be touched by an automatic software transformation?


>>>> @@
>>>> type T;
>>>> T *ptr;
>>>> T[] arr;
>>>> expression E, n;
>>>> @@
>>>>  memcpy(
>>>> (       ptr, E, sizeof(
>>>> -                      *(ptr)
>>>> +                      T
>>>>                       ) * n
>>>> |       arr, E, sizeof(
>>>> -                      *(arr)
>>>> +                      T
>>>>                       ) * n
>>>> |       E, ptr, sizeof(
>>>> -                      *(ptr)
>>>> +                      T
>>>>                       ) * n
>>>> |       E, arr, sizeof(
>>>> -                      *(arr)
>>>> +                      T
>>>>                       ) * n
>>>> )
>>>>        )
>>>
>>> This still fails to regenerate two of the changes from 921d49be86
>>> (use COPY_ARRAY for copying arrays, 2019-06-15), at least with for me
>>> (and Coccinelle 1.0.4).
>>
>> Would you become keen to find the reasons out for unexpected data proce=
ssing
>> results (also by the software combination =E2=80=9CCoccinelle 1.0.8-000=
04-g842075f7=E2=80=9D)
>> at this place?
>
> It looks like a bug in Coccinelle to me

We might stumble also on just another (temporary) software limitation.


> and I'd like to see it fixed

Would you like to support corresponding development anyhow?


> if that's confirmed, of course.

I am curious if further feedback will evolve for affected software areas.


> And I'd like to see Debian pick up a newer version, preferably containin=
g that fix.

I assume that you can wait a long time for progress in the software
distribution direction.


> But at least until then our semantic patches need to work around it.

Would another concrete fix for the currently discussed SmPL script
be better than a =E2=80=9Cworkaround=E2=80=9D?


>> But this transformation rule can probably be omitted if the usage
>> of SmPL disjunctions will be increased in a subsequent rule, can't it?
>
> Perhaps, but I don't see how.  Do you?

Obviously, yes (in principle according to my proposal from yesterday).
https://public-inbox.org/git/05ab1110-2115-7886-f890-9983caabc52c@web.de/


>> Would you like to use the SmPL code =E2=80=9C*( \( src_ptr \| src_arr \=
) )=E2=80=9D instead?
>
> That leaves out dst_ptr and dst_arr.

How many items should finally be filtered in the discussed SmPL disjunctio=
n?


> And what would it mean to match e.g. this ?
>
> 	memcpy(dst_ptr, src_ptr, n * sizeof(*src_arr))

The Coccinelle software takes care for commutativity by isomorphisms.
https://github.com/coccinelle/coccinelle/blob/19ee1697bf152d37a78a20cefe14=
8775bf4b0e0d/standard.iso#L241


> At least the element size would be the same, but I'd rather shy away fro=
m
> transforming weird cases like this automatically.

Do you mean to specify additional restrictions by SmPL code?


>   void *memmove(void *dest, const void *src, size_t n);
>   void *memcpy(void *dest, const void *src, size_t n);
>
>   COPY_ARRAY(dst, src, n)
>   MOVE_ARRAY(dst, src, n)

Can the replacement of these functions by macro calls be combined further
by improved SmPL code?


>> Possible nicer run time characteristics by the Coccinelle software.
>
> How much faster is it exactly?

The answer will depend on efforts which you would like to invest
in corresponding (representative) measurements.


> Speedups are good, but I think readability of rules is more important
> than coccicheck duration.

I hope that a more pleasing balance can be found for the involved
usability factors.


>> But how does the software situation look like if the original source co=
de
>> would contain coding style issues?
>
> The same: Generated code should not add coding style issues.

Such an expectation is generally nice. - But target conflicts can occur th=
ere.


> We can still use results that need to be polished, but that's a manual s=
tep
> which reduces the benefits of automation.

I am curious how the software development practice will evolve further.

Regards,
Markus
