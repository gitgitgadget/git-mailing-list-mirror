Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1511F1F42D
	for <e@80x24.org>; Fri, 11 May 2018 07:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752372AbeEKHX1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 03:23:27 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:44301 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbeEKHX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 03:23:26 -0400
Received: by mail-ot0-f175.google.com with SMTP id g7-v6so5182007otj.11
        for <git@vger.kernel.org>; Fri, 11 May 2018 00:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j0c5T1RL19HQn5npdX7B3iSh8YeD+UVVWDkablfnEI4=;
        b=NL6lnO6yA4k9ii7U3mwCDPgIwx0SDn2fqt3VW19woa9XAlqwVuMlOXubEsTeWIIiIU
         prkJdI6to7tA+BNf1Nq0k4lnchW23LKnW26+T+nLYRx/L5yABzsGb6k5HrPWb44mz+MC
         7PUy8NiwaT3A4OAEpsfmXYtckDNMnmSO1aEUr8pFOLaxzWo9C/al5fpamddg8iBSiM0G
         0rHdJlliti3W9j1yqq7y9CNZZBWA75Wam4/74D+bKf3HomkyHNxYSlFYWGRKayGzICBe
         YFWizf253VH4w8pKGgE2KAhZJDxwnH8BTxZ49WRCO/oGqS7mGmzHXtwjHrAj6aDvma54
         0CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j0c5T1RL19HQn5npdX7B3iSh8YeD+UVVWDkablfnEI4=;
        b=ucO1WXMuaTi9/ckPKq3vySyul3AFErdyB05E6L+yBKVRilS98LLWiyB0D4TdrqVZVc
         Mr9vF3rw6KONSHPkLXJ7hctwKJv+hTRFCKtU3mgUDAF5PxGFPBMaYXmqGrXNJnW48tV7
         p7dRPncgK52+Si2Mu+v5hHTGxtk2NjBdN07jsEweUZHVyzVDaALqR9gIYWGeiu7l/3x5
         WVAb1PTgTFehtfAZKw5dE543FbL6KkGAa0WWiCpNARSMgitEoqGafm4UBjaQzvpwXQPm
         k+BscZTMixZr6d8GGHFvOeR2pHsd0+lsAAQld10CiAurVokh0as3J2f+CEWl+D36jG/x
         ZzVQ==
X-Gm-Message-State: ALKqPwdxUUEubf0oWEeRbQE2GMNvaXvoB+nhpUpflxz4YvV0O7UzsbxH
        7aTqqjjv7qmILEI2PlpmV8YBIYTK5/Os4MQdRC66WQ==
X-Google-Smtp-Source: AB8JxZqkzN/lbXax6rtcJGQMQh2G1FluWzS/XU9/t1oenWLSyESHr+xxO69AVoCapPSWNWMn+pAIzfoSw6gxPTQguYQ=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr3165940otr.173.1526023405469;
 Fri, 11 May 2018 00:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 11 May 2018 00:22:55 -0700 (PDT)
In-Reply-To: <CAGZ79kYnzQM-mcAm7Q3C=q+uhvt8MYvWrhkUrsyu1FbM2=1Z8g@mail.gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com> <20180510141927.23590-2-pclouds@gmail.com>
 <CAGZ79kYnzQM-mcAm7Q3C=q+uhvt8MYvWrhkUrsyu1FbM2=1Z8g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 09:22:55 +0200
Message-ID: <CACsJy8AYEbV6niTqaJ4XtVjHpXZ65-=9-vpGtxUHbuXVmc8paw@mail.gmail.com>
Subject: Re: [PATCH 1/9] Add and use generic name->id mapping code for color
 slot parsing
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 7:16 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 10, 2018 at 7:19 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>
>>  7 files changed, 82 insertions(+), 112 deletions(-)
>
> Nice!
>
>
>>
>> +static const char *color_branch_slots[] =3D {
>> +       [BRANCH_COLOR_RESET]    =3D "reset",
>
> In 512f41cfac5 (clean.c: use designated initializer, 2017-07-14)
> we thought we'll do it once and see if anyone complains
> (and it shipped v2.15.0, 2017-10-29), and so far
> nobody complained half a year later. So designated initializers
> are all good now?

I don't know :) but it's worth pushing. I don't think this series
would land on the next release, which gives people a couple more
months to complain about C99. It does save me time and if it causes
problem, removing designated initializers is trivial

> Do we want to mention this decision in the commit message?
>
> If so, the patch looks good!
> Thanks,
> Stefan
--=20
Duy
