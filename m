Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23141F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 17:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbdIFRlf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 13:41:35 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33974 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752471AbdIFRld (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 13:41:33 -0400
Received: by mail-yw0-f172.google.com with SMTP id r85so8683303ywg.1
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 10:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9RNZOQcLQYQoTJyD0SlErf2Pu2EedexOSGoi7PEjxjk=;
        b=V0b6ez7C2/R6htr/fSVBUnQ2eyyP1VeCwyDM/N9Ww97WUFlNZWVftmH0USDfQx5L7h
         tixr4+yrGjLoQMXXj6LbG3mm5SyMXTPcETm/rpm8N11kthoDz1ywynAdMiNsn/+ImAFX
         FgsVweJmtx9Y+1bRcwVf0F/KhTSc2GcOdQ/A9etCnpwExQK1PDhKFOzYpbbl1oQunt3Q
         m4DhtCmorsabIvgYWEL4NV+U55kQA2cH5NMrb3//DiwJc39Pg6YK0BYBMiJ7voMYSYwS
         KYVdpT197dqOzOHEJtlNQb/te26rY8I3UqzLW4pxSQ1YsT72Cgz1zuXDhHFvvbjf2bA7
         iERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9RNZOQcLQYQoTJyD0SlErf2Pu2EedexOSGoi7PEjxjk=;
        b=mD+spxEpcJ6N2JmLon+ufvoUrYrHtb1FdrpliWyQ9evFyDLY3KGq7VHCsXOfKpJHXo
         toWW3H40UunRPYn20GC9te3LN3LXzQfZSKuWnqRVT09KYsvi6ce2R8FodP7Vh7xKqNKg
         xk99phngvqiXXmXPpo8Tm7J7s9i1mKn36PQiksv+c3GHQ5x+E1XGEDDH99Q2I+NpMdBQ
         E8zqrV8lkk03MBniYQIWeixNoRKSA9IOlgtcgwzLBwmKhVruwNOEJGjb/YuDItH5w7Ye
         d7uQ/WBDvMX2em4JJ6NbDCVlCV04f39UaKA2BsV29rrEjAmawl9OndUdqTLu/2lHNHGn
         tCCw==
X-Gm-Message-State: AHPjjUhl4PDYXEGimgvjbUHlYQltOaA6KGeHIAMcIs6tQyHefNLgASyZ
        LLN0Jspa6UtqB1NYBOLMSBxWS1uUYhmD
X-Google-Smtp-Source: ADKCNb4MF4wyUfTT/kBCYns8JvwX3YLzAdRFQnUNqfVO4rmJBXnHcDPeXzYrVGezSfPswtWppHWlxVixErPv18h1ljw=
X-Received: by 10.37.160.66 with SMTP id x60mr2812131ybh.305.1504719692407;
 Wed, 06 Sep 2017 10:41:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 10:41:31 -0700 (PDT)
In-Reply-To: <CACsJy8A0x-PJsO+uhv8=mdfeKLEBPfT3sq3_Fi2_HffeexDeAw@mail.gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-3-pclouds@gmail.com>
 <CAGZ79kbvKZXGy80RCU3zkdm0S3M-tGB=LAJYiY=o+YwUB9RNHA@mail.gmail.com> <CACsJy8A0x-PJsO+uhv8=mdfeKLEBPfT3sq3_Fi2_HffeexDeAw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 10:41:31 -0700
Message-ID: <CAGZ79kagZOmTDhsHr7-t42xoecW3rXUOU7Ss5B13Jyfk6PT24Q@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] refs.c: use is_dir_sep() in resolve_gitlink_ref()
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 4:08 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Aug 24, 2017 at 2:14 AM, Stefan Beller <sbeller@google.com> wrote=
:
>> On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> The "submodule" argument in this function is a path, which can have
>>> either '/' or '\\' as a separator. Use is_dir_sep() to support both.
>>>
>>> Noticed-by: Johannes Sixt <j6t@kdbg.org>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>>
>> Immediate questions that come to mind:
>> * Could this go in as an independent bug fix?
>
> It probably could. But it may depend on other submodule changes in this s=
eries.
>
>>   -> If so do we have any test that fails or stops failing on Windows?
>
> It was spotted during the review [1] so I guess no test fails on
> Windows (not that I would know because I can't run tests on Windows)
>
>>   -> If not, do we need one?
>
> Since I don't use Windows, I don't particularly care. And I can't add
> one anyway because I can't run it.
>
> [1] https://public-inbox.org/git/%3Ca74cf309-fb16-2f45-8189-d1d0c655dea4@=
kdbg.org%3E/

IIRC I asked these questions as I was genuinely confused,
I do not mind too much either.

>
>> * Assuming this is not an independent bug fix:
>>   Why do we need this patch in this series here?
>>   (I thought this is about worktrees, not submodules.
>>   So does this fix a potential bug that will be exposed
>>   later in this series, but was harmless up to now?)
>
> The series could probably be split in two. The first part is about
> using the new refs_* API in revision.c. This helps clean up refs API a
> bit, all *_submodule() functions will be one. Not strictly needed to
> be part of this, it's just a continuation of my previous series that
> introduces *_refs. Since submodule code is touched, this is found.
>
> The second part is actually fixing the prune bug.
>
> Should I split the series in two? I think I separated two parts in the
> past (maybe I misremember) at least in the description...

I had to reread the coverletter
https://public-inbox.org/git/20170823123704.16518-1-pclouds@gmail.com/
to get that part. I would not be opposed to splitting the series, but
I'll review an unsplit series as well.

Thanks,
Stefan

> --
> Duy
