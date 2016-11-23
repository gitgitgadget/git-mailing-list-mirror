Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9706120259
	for <e@80x24.org>; Wed, 23 Nov 2016 09:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756447AbcKWJki (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 04:40:38 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35427 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755941AbcKWJjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 04:39:05 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so390797ywh.2
        for <git@vger.kernel.org>; Wed, 23 Nov 2016 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eDzHJA72TV7AJO8rTwfT+SWRhO/BSHoFvcvcFp7GYOI=;
        b=IyO8sJTjJFyhm9aopNYjIjgF8MCRUX67v5FVP7SNvFVzV52J25hueutbjRoAgLUh91
         EphzYlhAMixjdG8MPQJ5bCHLrH4BhHupNYSc0Sl3t0ImUqBRjObbmu/MXRxPDf23/7Bk
         oHcyGxSx9V1whOOIVMbY3IW6Ok7LLBhpVqPqrrPd0YkDCmId068XR6XkzGpgYGi5EGbV
         q35DUN4Q4aZNClrpjFA5Qk1uPJX0Z7qyeqLETiK/I3MMOX+i92pU+tzcA70tS/wH06zW
         FPl3ENln8oI1gqtQK9Q0wOpRrqW3NEd2n2NtbfZFODk318HeoxXb9lf8FLwL4NF9Hqms
         kdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eDzHJA72TV7AJO8rTwfT+SWRhO/BSHoFvcvcFp7GYOI=;
        b=Io87QAD74H1gLTRHL4Mk+TRpVeK9YfO+pMcn9d5cdKmAgTD+DyUx8CUu7rl+SsqDSn
         a9X9JzPyyjEmTtXkDjYKo6DUNC30bluUJQ9ZgxlGdjf6iIF/5wsbV0Zx+oDEx0cd49gd
         Rzcn409L0q7bHN76Z43/KsVTw3c6I8CZqVYAUmLt2dm6w9duEh8i4LYNc+Dvz1QFliwk
         R6FyIEUoZJ7y+hgXU8rBL0Dz+nhO0UuHQVPrmyvXt+Q+m7Y5ocW6eUf8p70m35LGl4RK
         gUMl/trUrb/rVh87jCd2uYQTjDJhMkyGjXZdwqh4tI4wd5YtZyCx8TKVuab7VQCMl9ir
         /PbQ==
X-Gm-Message-State: AKaTC01HH5uDylo3Q82hjynEZycHa8uQ9jS2MtH/Vg275WunIECwx3BWKKgPqMjqHZfbTrXbGfZiCGnV1w8EoA==
X-Received: by 10.13.224.3 with SMTP id j3mr2510091ywe.46.1479893944302; Wed,
 23 Nov 2016 01:39:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Wed, 23 Nov 2016 01:38:33 -0800 (PST)
In-Reply-To: <CAGZ79kYm4LfXK=1j-ayLawt+BojnkyM4h2RLQ=kfpPgMQbdBag@mail.gmail.com>
References: <20161110203428.30512-1-sbeller@google.com> <20161110203428.30512-32-sbeller@google.com>
 <CACsJy8BXjYOza_1mPCJJw+Mk1zksLLJMBNKvbAk8+1-bdAGJMw@mail.gmail.com> <CAGZ79kYm4LfXK=1j-ayLawt+BojnkyM4h2RLQ=kfpPgMQbdBag@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 16:38:33 +0700
Message-ID: <CACsJy8C5K5UyOYeC0wU8_QVz67-+B6O7ydv7w=70se5X=1Ttsw@mail.gmail.com>
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2016 at 12:26 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Nov 22, 2016 at 2:41 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, Nov 11, 2016 at 3:34 AM, Stefan Beller <sbeller@google.com> wrote:
>>> @@ -139,7 +140,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
>>>                        PATHSPEC_LITERAL |
>>>                        PATHSPEC_GLOB |
>>>                        PATHSPEC_ICASE |
>>> -                      PATHSPEC_EXCLUDE);
>>> +                      PATHSPEC_EXCLUDE |
>>> +                      PATHSPEC_ATTR);
>>
>> Hmm.. common_prefix_len() has always been a bit relaxing and can cover
>> more than needed. It's for early pruning. Exact pathspec matching
>> _will_ be done later anyway.
>>
>> Is that obvious?
>
> Yes it is.
> Not sure what your concern is, though.

None really. I was just thinking out loud and trying not to make
assumptions, because I know this code quite well and I don't know how
people see this code anymore :D So all is good then.
-- 
Duy
