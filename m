Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732F91F406
	for <e@80x24.org>; Fri, 11 May 2018 01:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbeEKBAQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 21:00:16 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36007 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeEKBAO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 21:00:14 -0400
Received: by mail-yw0-f196.google.com with SMTP id l15-v6so1117734ywk.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BRJO2+LdkPSMFL9BfvBoTHRhxEYvBH2tNjZ9OloZuLc=;
        b=TJ1FjidHu1pxefUWQ/iPHJt2QduthAe+96HUgaOrE+IQT94yrTRbwvc6p6GcorwK7y
         KJXDT+tM/x6qEWO2YwUee7cosNgJb+3Yb+qpgH/3CDB3yG/J7s05JYTf2dPVB+fR8bVs
         wBG0vu6JTr/VMy4VZhqQVUYh8/6CB7Hxxsw8i3YWR3CSc80sscFEx43SjnoqM3AIPzIi
         ejOPPoN//lIOnfGHxG4dWSDJEyAuW5T5X6mzFlcJwwT7gmpUk189NtLVXGiFk8wJT2kZ
         6m1QNtyOoC3Dk2Oo6FjWgvOopWJYfINpZesGO46uNnJqjk9m3DmZz46OVDeBANT8qvLC
         0pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BRJO2+LdkPSMFL9BfvBoTHRhxEYvBH2tNjZ9OloZuLc=;
        b=fCMYesZw0GR9Rlcnnr24C3SoXHRulgI+CvkjK0kdToJ6f+Ud13MBHpUnGwssBmNT4q
         SJkgVeAxYNL0gzloVq/wVmBgC5rcXpqlLWsnThaMhmtWGgByH2TVZr8xP5+tFx5tmOl1
         2KXrAHbInLc4+F8R5pUHpnmM3yWm7LOnhJ1QSn0GxD07Mwa6cKPqZvYY4/pV2AObNOZ3
         I4Rfs3JNR3qx7KWUhuN/KiJN66DThvqWZmA73yWmgUH4dGxJrIGu6r093RE/IMLn2Hzw
         /x3GoKPOdfdEL0RaltfA6AE9iroDJ4IZZzQVdvy+YK9zQ+VYLnb1jMQRlsDF95pJ1Ztu
         SPeA==
X-Gm-Message-State: ALKqPwfB0BzHKvjXVVdCPmoB89ekpKDszIJ93oniUshyGGnkM1PekmlR
        m7+ObGr993iCXb8MjDvZKsdR6EK06U7n1Vz9CC3QOg==
X-Google-Smtp-Source: AB8JxZqsqrZFj6x0qsBZ+aH36JUlOzI/yXif1QoDadWjpDgLdXbF2jJHDY3nL8ZtvwUy78LcbnMgBo5StWnCdN2bHss=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr1707493ywg.345.1526000413754;
 Thu, 10 May 2018 18:00:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 18:00:13
 -0700 (PDT)
In-Reply-To: <CABPp-BFPaOxokRoiVnAB+KRMt6=NihmjRH+exS_NbGMbdj+k4Q@mail.gmail.com>
References: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
 <20180510211917.138518-1-sbeller@google.com> <CABPp-BFPaOxokRoiVnAB+KRMt6=NihmjRH+exS_NbGMbdj+k4Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 18:00:13 -0700
Message-ID: <CAGZ79kaiFkq20Com7gOLin371D2KhTPG7cqn1mQ6OaFU12kKPQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Submodule merging: i18n, verbosity
To:     Elijah Newren <newren@gmail.com>
Cc:     Leif Middelschulte <leif.middelschulte@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, May 10, 2018 at 5:04 PM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, May 10, 2018 at 2:19 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> Leif wrote:
>>> Sure, let me know what to use instead and I=E2=80=99ll update and resub=
mit the patch.
>>> Sure, but `MERGE_WARNING` prefixes all the messages with "Failed to
>>> merge submodule=E2=80=9C.
>>
>> I thought about replying and coming up with good reasons, but I wrote so=
me
>> patches instead.
>>
>> They can also be found at https://github.com/stefanbeller/git/tree/submo=
dule_i18n_verbose
>>
>> I think these would be a good foundation for your patch as well, as you =
can use the
>> output() function for the desired cases.
>>
>> Feel free to take these patches as part of your series or adapt
>> (or be inspired by) as needed.
>
> This is awesome.  In addition to the good reasons you gave, switching
> merge_submodule() to use output() was one of several things on my todo
> list since I think it'd be needed for remerge-diffs
> (https://bugs.chromium.org/p/git/issues/detail?id=3D12) and might be
> useful for merges in bare repos; thanks for tackling it.

Thanks for the encouraging words!
The one nit I find on that series is that we need to rely on and export
the add_submodule_odb function as I want to get rid of that function
once the object store series has progressed far enough.

>
> Patches look good to me.  Having Leif's patch on top of these two
> would be great.

ok, Let's go with that.

Stefan
