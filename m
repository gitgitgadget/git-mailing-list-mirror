Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D001F406
	for <e@80x24.org>; Sat,  6 Jan 2018 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeAFPFk (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 10:05:40 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:40623 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeAFPFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 10:05:39 -0500
Received: by mail-io0-f174.google.com with SMTP id v30so8689768iov.7
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qWjwAIWvJt5PX4+KluQXf+fvDcPLF+xXJCkSES5eFGg=;
        b=XhY/jh3FHGyzNkS0DH1gwm0pikl3VK0QfBLa5zNDANeMjuERetqb8fJ8F4JcUnug52
         LXbfnxYEw+TNMgfYqrWqv7Xb57vTZP2gQePAZHKIuoutFJspPmhWH6Nl/IIieIWHjwlF
         G3iBQUeB6GZ6bqWrYXLuZMIyZ42uD1mU6Ekx+nBqIJDvQAiT4sh2sybBbeWWwwbjsIzA
         Fz3YjNjvb5YjP+CaVgSQlu5OZFeUdE1zAzylPRC7sE+M6pfsPZ6DUUK58BJNodqA2xOC
         ZtD3kGjfqAtrt8uBSxvVEBV8HvNJGBkr9JFcKlOMqjlyp8x8O9RQh4sCuzb0jgaXsCHz
         BZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qWjwAIWvJt5PX4+KluQXf+fvDcPLF+xXJCkSES5eFGg=;
        b=SbB54BMNzOATZ2CzG/BbYENSWykLhxW/Y7R3NiQk4EBcRsvsJm5jrG8P8Vwoa4iBHs
         7UFffY0S9z52KEmgDuabAU8zMaVArGjkO2paFLl5h/CMtX8oNrpj68ZKaOx1DZ9eXOfN
         BRsl2Fjmcl/PN7uLF+FtL7xQD85rhEKaOMTHhIBBguaEK3pxklKvci7e7R7WAZDznAg2
         peVsheW+7YAWJjWd0g8b/aO//ajB/YESZTGLw7ArzC0n9Z+bfS7DMMgshAz7T98cIDou
         tYHHpb87/8a6A+rL0N2m1vKlh/I/4pQyVRIE4Wl6HOeg9npMME3ju94PUm/v1oEy0NUE
         gjaA==
X-Gm-Message-State: AKwxyte1Q22MaI0rMlSDF4fGb7vCts9aD+jBjMP9guRYmzCSt0g2zu/p
        s2UwCnT+YpWORpgGD0W9OQj7JDJXNJ8aBdL0LQA=
X-Google-Smtp-Source: ACJfBouIeKMoasaulYtbcY0o3W5M1o9tV6Jp4gOsrBfSsngi0MoRG7Ibl/1tostIc4TNq+TNv5tnpjReW96loUCNgo4=
X-Received: by 10.107.188.197 with SMTP id m188mr6605017iof.67.1515251138273;
 Sat, 06 Jan 2018 07:05:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Sat, 6 Jan 2018 07:05:37 -0800 (PST)
In-Reply-To: <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com> <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 6 Jan 2018 16:05:37 +0100
Message-ID: <CAP8UFD03-EPxQQk51RZgb9Osdb4P=B67CLU6PrEP0O9chcHOCw@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yasushi,

On Sat, Jan 6, 2018 at 3:27 PM, Yasushi SHOJI <yasushi.shoji@gmail.com> wro=
te:

> best_bisection_sorted() seems to do
>
>  - get the commit list along with the number of elements in the list
>  - walk the list one by one to check whether a element have TREESAME or n=
ot
>  - if TREESAME, skip
>  - if not, add it to array
>  - sort the array by distance
>  - put elements back to the list

Yes.

> so, if you find TREESAME, you get less elements than given, right?

Yes.

> Also, if you sort, the last commit, which has NULL in the ->next,
> might get in the middle of the array??

Well, first the array is just necessary to sort the items pointed to
by the list. It is freed at the end of the function. We are mostly
interested in getting a sorted list from this function, not a sorted
array.

Also the array contains only items (commits) and distances, not list
elements, so the elements in the array don't have a ->next pointer.

About items in the list, when we put them back into the list we only
change p->item, so p->next still points to the next one. Only for the
last one we set p->next to NULL (if p is not NULL). So we don't
actually sort the list elements, we sort the items pointed to by the
list.

> # BTW, is it really fast to use QSORT even if you have to convert to
> # an array from list?

It is easier and probably faster to just use qsort, which we get from
#include <stdlib.h>, as it is hopefully optimized, rather than
reimplementing our own list sorting.

>>>> Since nobody noticed it since 7c117184d7, it must be a rare case, righ=
t?
>>
>> Right, you marked a commit both good and bad. That's probably not very
>> common. But it obviously happens. :-)

Yeah, mistakes unfortunately happens :-)

>> Thank you for providing a script for reproducing this. It helped me come
>> up with the attached patch. The patch is based on ma/bisect-leakfix,
>> which includes =C3=86var's patch.
>>
>> I think this patch could be useful, either as a final "let's test
>> something previously non-tested; this would have caught the segfault",
>> or simply squashed into =C3=86var's patch as a "let's add a test that wo=
uld
>> have caught this, and which also tests a previously non-tested code
>> path."
>
> Do we really need that?  What is a practical use of a commit having
> both good and bad?

It is not practical, but it is a user mistake that happens.

Thanks for your reports and test cases,
Christian.
