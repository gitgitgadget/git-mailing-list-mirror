Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 172081F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeI0AEF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:04:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeI0AEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:04:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id y13-v6so3289633wmi.1
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9A+gAb4jofpJ3ExtXkT3MDExMX9xA/XMYr3nL4IDzpg=;
        b=f0U8BeQiEXF7tnqMKFDC/DBVsKJlZrzKynUgW65IzxS2J2QPLASUyuH8o6T1LKM0n4
         LfJ001ZuvoobGBhQaeBvKAMT+YcczQKTPyoxIfzyviKpQ5IlrK0bNkNB/yTq8KtZvV11
         FcJQXHznoOnxE2R8ibYckGw9mBjUuo5xYGdLgfkaIVgrV6og8jkaqlOkSPk7OKVpfNta
         oK7RvOxN0no3mV4a0PDQDQrrLT7RIrU7QHwHVDjZve2lASmGKsBfUVmWsDEBy6efOrSo
         9hW37H+T25Vp3DR9vbXb8410zsROPea0JB05SxTnrkSaHYdYo64+AAwArIvkZxGWVh66
         AHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9A+gAb4jofpJ3ExtXkT3MDExMX9xA/XMYr3nL4IDzpg=;
        b=PzdmzwrWH/ADl2RFwHBxnkHJOtPeVLeEdzXTr0Ku/TAkN9TovMcoQy1CC1dyvpi6Xk
         /uB00kOqQisjCNlGpQvN35BGIKJoequrL8fWydy+MqZ7JIYjDBLaEJiv6TbiRnQBhO0e
         BvXREAm/05s0ShjQDPugTheQVlUFjiQAZQSAjwhCMZ1m/2Wa2EMzRf+JDaaBPJ9zbhYn
         iVybChX5O0E4NDkJDnkrih/92GyhpyLTrnZl/+6P6BDawDhOQs3t+Vp/0jdDExQJZl7f
         JFu9bPAllATDM2dBhNrI5i5+YZBNfYNf1Y97P+wDxg+COjtnQ9p+MnS9WQg1M2w2t8Rp
         /sLQ==
X-Gm-Message-State: ABuFfojG7uqob6ABLXv09eQ6KS8bJRtlYeMoWc7JEmxyZLKjgkGpSRkX
        5UmgaSXmgHJusR+MQa+XVh0=
X-Google-Smtp-Source: ACcGV61eH9ti7FIi9Gd0ZGvECWg+h2cSGnMnIBxsgAzWJ6JcWkpudPVeKUQUWwQjMMS0AzkZWKm79Q==
X-Received: by 2002:a1c:4857:: with SMTP id v84-v6mr5057643wma.8.1537984199313;
        Wed, 26 Sep 2018 10:49:59 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id n4-v6sm7063769wrr.21.2018.09.26.10.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:49:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
References: <20180921223558.65055-1-sbeller@google.com> <20180921223558.65055-2-sbeller@google.com> <87h8ihk7sl.fsf@evledraar.gmail.com> <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com> <20180926041517.GA2140@sigill.intra.peff.net> <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 26 Sep 2018 19:49:57 +0200
Message-ID: <87d0t0jghm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 26 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> On Tue, Sep 25, 2018 at 12:26:44PM -0700, Stefan Beller wrote:
>>
>>> On Sat, Sep 22, 2018 at 5:58 AM Ævar Arnfjörð Bjarmason
>>> <avarab@gmail.com> wrote:
>>> >
>>> >
>>> > On Fri, Sep 21 2018, Stefan Beller wrote:
>>> >
>>> > > +/*
>>> > > + * Apply want to each entry in array, retaining only the entries for
>>> > > + * which the function returns true.  Preserve the order of the entries
>>> > > + * that are retained.
>>> > > + */
>>> > > +void oid_array_filter(struct oid_array *array,
>>> > > +                   for_each_oid_fn want,
>>> > > +                   void *cbdata);
>>> > > +
>>> > >  #endif /* SHA1_ARRAY_H */
>>> >
>>> > The code LGTM, but this comment should instead be an update to the API
>>> > docs, see my recent 5cc044e025 ("get_short_oid: sort ambiguous objects
>>> > by type, then SHA-1", 2018-05-10) for an addition of a new function to
>>> > this API where I added some new docs.
>>>
>>> ok will fix for consistency (this whole API is there).
>>>
>>> Longer term (I thought) we were trying to migrate API docs
>>> to headers instead?
>>
>> Yes, please. I think it prevents exactly this sort of confusion. :)
>
> CodingGuidelines or SubmittingPatches update, perhaps?
>
>  Documentation/CodingGuidelines | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 48aa4edfbd..b54684e807 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -358,7 +358,11 @@ For C programs:
>     string_list for sorted string lists, a hash map (mapping struct
>     objects) named "struct decorate", amongst other things.
>
> - - When you come up with an API, document it.
> + - When you come up with an API, document it.  It used to be
> +   encouraged to do so in Documentation/technical/, and the birds-eye
> +   level overview may still be more suitable there, but detailed
> +   function-by-function level of documentation is done by comments in
> +   corresponding .h files these days.
>
>   - The first #include in C files, except in platform specific compat/
>     implementations, must be either "git-compat-util.h", "cache.h" or

Thanks. I had not looked at this closely and was under the false
impression that it was going in the other direction. Good to have it
clarified.
