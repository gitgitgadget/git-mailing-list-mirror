Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093821F404
	for <e@80x24.org>; Thu, 28 Dec 2017 11:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbdL1LEw (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 06:04:52 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34574 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1LEv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 06:04:51 -0500
Received: by mail-vk0-f50.google.com with SMTP id j192so24426110vkc.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 03:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fb6RVhwzWnUTy4NjXxsUQnOnSJlk99OPPKezQtFxpJw=;
        b=fmRRQ4ghkeDrRFnWi+vN8n8ZXxRz12r7vGXZAm1F/7PzjeuMHBBiIFgJ3QpOmQYwca
         PCOI8ME7kjYF1pQnPJdw6qaJi5MTWhvwel162cCgg2vMvFUocTULVHCEn5c9OjWBkQVo
         /YBJtKa6HvdO45TA2Sy4TZoNtVBt9/AkjRTSp5BxiUQGYAjQCeP4yjTczxq1WOijZVJE
         tvv0te23yQFrTfQGCHnhDxy7AgEZ4vboBh+r46x+m3Cc0qv5pejcgLwhZX8skWRYke28
         G9eXhUav5tGjT1NmZLZiqAFuhCXQzeS3zisjb0p+Kt4T2xU6iWJ+a9c3xBPPBS0k7721
         bFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fb6RVhwzWnUTy4NjXxsUQnOnSJlk99OPPKezQtFxpJw=;
        b=ULY6nyl+EZHbF5pl9GYDtRF89BSzZpwCELTORDofCxPhHu7NJFxoFcIBVITH45LmsJ
         VFrEZB87E6cAwyye14NtAzL48n/+2ZHQNDcio4xxOtQa58NX7JI2VQ6Kfr5lvg8MvtgX
         WQNeQyx57BL7HYxzE2j+UeH+RFZRPHFcNnGO7QkscFLZIPbCwtBjogaKPQjrtsbUOLPT
         t9kPENcDycnXq8xi2x109aQNzlOZ8H8cQT9dwublp+UzOHaFrJatDeaD/GMEce6Xoew1
         uXmNpl8AoQVuvL1TXeQmXwM70QQkFCRjkC96+TqxPu71FJ5rrsmIg+V7BUNcGX8+htb1
         PRAQ==
X-Gm-Message-State: AKGB3mLsN2oOfXQkevqau+ZjsB3wynDcqnwr2AQutBHk5qk38S1Smfnq
        RYGEiRz4Ymr4ba2mwRKLjRc0WATwJU7n4q8HnQE=
X-Google-Smtp-Source: ACJfBovRx4SHYDF9O5FgnC35JOBBe8QIav3dlwEpeMqAiXGgrXhnKlW05s55eEz6XFZIbOpxvk4sILegkB/C03Fazjg=
X-Received: by 10.31.139.201 with SMTP id n192mr20188609vkd.132.1514459091053;
 Thu, 28 Dec 2017 03:04:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Thu, 28 Dec 2017 03:04:50 -0800 (PST)
In-Reply-To: <20171227194601.GA181628@aiede.mtv.corp.google.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-2-szeder.dev@gmail.com>
 <20171227194601.GA181628@aiede.mtv.corp.google.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 28 Dec 2017 12:04:50 +0100
Message-ID: <CAM0VKjm+TBerXFzrqVmKdoVk=hWpnN2m62a-v-_Yrp8Onidu1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] travis-ci: don't try to create the cache directory unnecessarily
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 8:46 PM, Jonathan Nieder <jrnieder@gmail.com> wrote=
:
> SZEDER G=C3=A1bor wrote:
>
>> Travis CI creates that directory for us anyway, even when a previous
>> cache doesn't exist for the current build job.
>>
>> In itself it doesn't hurt to try, of course, but the following patch
>> will access the Travis CI cache much earlier in the build process, and
>> then creating the cache directory this late might cause confusion.
>>
>> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> ---
>>  ci/run-tests.sh | 1 -
>>  1 file changed, 1 deletion(-)
>
> Is this behavior documented anywhere?
> https://docs.travis-ci.com/user/caching#Arbitrary-directories doesn't
> say anything about it.

No, I'm afraid it isn't explicitly mentioned.
I seem to remember an example implicitly relying on it, though, but
can't find it anymore, so either misremembered or misunderstood one of
the examples.
OK, then I'll move this 'mkdir' to 'ci/lib-travisci.sh', to ensure that
the cache directory exists in all build jobs.

G=C3=A1bor
