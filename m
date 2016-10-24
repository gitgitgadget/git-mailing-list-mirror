Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01CF320193
	for <e@80x24.org>; Mon, 24 Oct 2016 21:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941211AbcJXVHM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 17:07:12 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39952 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941144AbcJXVHL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 17:07:11 -0400
Received: by mail-qk0-f178.google.com with SMTP id i68so8330145qke.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IYrl+KuFvLT2BMbdiJghJK4HbiwngjD9f75j37Lela8=;
        b=PLb96OWXUZcyi1jXG1MGOiALz95L4iYcBeHyFA8Qyw3xnFdgcAZOTQ8Xpa2gesUseg
         dEm5kIJHeG4WtzCtEOec4zAEdJ6dT48chIXAgcnjk1VOmfAV/ieTEArlJZBBhHld+1kk
         m/9u31a+11ST8M00W5lWh64L61Y5hGb0U5fs+5y8ixe2w+dhzd7CV0ebUMfmQWHvOXXL
         cYRxRiUstLKhcbmcyPA0lYxmP/xdS2nCkVgDyBqckntYqhK7g1+MhudrnSzkEBFsSRyT
         TJ6cRR/vOM3e+oUC8qj9sGu6/zU9bmbYNeDzYBrHoQr+KXrag+R8qsnU1fpWsIu6Fnzr
         azCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IYrl+KuFvLT2BMbdiJghJK4HbiwngjD9f75j37Lela8=;
        b=latrGoZsS3k+v1AI/y26gAe/7yT1CQSQWwts4i4fke87JTUvyg3o2hpQrKRQrp0Cdk
         AClQSrv4hiblLnQJpswb+xDQyIkSHQmYq4/V7UIu61tLYggE5HSELBMm72X9vy+JIw12
         FEY3mChr5FT9Exj3AQcCJK39z0U01ZHubHhuY9oidrjiNZUlmTtKnx78NQxAALJm8b6q
         vz5hzJxb70I7/W+wiXLWZgTmNjwNP8D+qk8Dr0UL5DUPeL2jKGdJx+vlXIr2smlpLfsh
         Org6z4iX72eg39XafJc70UZyCNuDmiL9OWzBvPHWA5lXTAw5APcOIu0fHAB9Rw2zzzwm
         DmOQ==
X-Gm-Message-State: ABUngvfXk4HV1QrVIwSEInLW0pXN0Ftc/RHDA/f3wB1UngWTXwnZcT2cEuNr/puGyJ9MHPs+PerVVJ/0gMe6EJpK
X-Received: by 10.55.129.1 with SMTP id c1mr15482194qkd.53.1477343230652; Mon,
 24 Oct 2016 14:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 24 Oct 2016 14:07:09 -0700 (PDT)
In-Reply-To: <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-18-sbeller@google.com>
 <0425fea3-3419-c265-b964-f5a309b867fa@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Oct 2016 14:07:09 -0700
Message-ID: <CAGZ79ka_zr_NXKoxC45swFrj168fP6S7_nQ1jjcfPOtTN4Jd1A@mail.gmail.com>
Subject: Re: [PATCH 17/36] attr: expose validity check for attribute names
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 8:07 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 23/10/16 00:32, Stefan Beller wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> Export attr_name_valid() function, and a helper function that
>> returns the message to be given when a given <name, len> pair
>> is not a good name for an attribute.
>>
>> We could later update the message to exactly spell out what the
>> rules for a good attribute name are, etc.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> [snip]
>
>> +extern int attr_name_valid(const char *name, size_t namelen);
>> +extern void invalid_attr_name_message(struct strbuf *, const char *, int);
>> +
>
> The symbol 'attr_name_valid()' is not used outside of attr.c, even
> by the end of this series. Do you expect this function to be used
> in any future series? (The export is deliberate and it certainly
> seems like it should be part of the public interface, but ...)
>
> In contrast, the 'invalid_attr_name_message()' function is called
> from code in pathspec.c, which relies on 'git_attr_counted()' to
> call 'attr_name_valid()' internally to check for validity. :-D

Yeah, I am taking over Junios patches and do not quite implement
what Junio thought I would. ;) So I guess it is a communication mismatch.

git_attr_counted is a wrapper around attr_name_valid in the way that
it either returns NULL when the attr name is invalid or it does extra work
and returns a pointer to an attr.

So I think for API completeness we'd want to keep attr_name_valid around,
as otherwise the API looks strange. But that doesn't seem like a compelling
reason, so I'll drop it from the header file and make it static.

Thanks,
Stefan
