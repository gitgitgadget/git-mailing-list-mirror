Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110801F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJTBaK (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:30:10 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35930 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:30:09 -0400
Received: by mail-qt1-f195.google.com with SMTP id u34-v6so39146425qth.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0ppaOALN/gqElE1CK/hdz4uUS99f+r7Jn4ZssseInhM=;
        b=FXGPJe6obhx7TBL4HkO72IUyhrgdN0t3fsAfK3wGx787o4KJ95slujj71nf7jUQd1X
         /vNiJz4zcPah5JHPZzKT/U3fn76w69cd8evJN0HL2jXYjrqY5lVa8UaYZvYKzunrQ5tl
         uO7p5xSDYClXuCXUnTrx5JsdU/WuHBKEyG4JZwTC5Kb59jkRWz0e74ITmMBSWLa3NOrC
         j4Z4v4Wp5e006spvFisLX5rDoGaYjvgPlgjVQ5cakGv0R3p4HCAAIZDOpHHWETftoGTl
         BLNyK7S1t5Bni1AhvD1+K2xoKa/wvUMN/jge3X7rGMrhinTHdT/7a7vvg59u0l3A6tT1
         TKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ppaOALN/gqElE1CK/hdz4uUS99f+r7Jn4ZssseInhM=;
        b=HZQWR/U231Ekb0W/9sIt3ePBSktfS2EL/WN9L/GnVsPxHzCwanJj/6gSlmrsgoNsRR
         AtNb4vK3U597p+A5oxLdQ8+ueZxN7ctd/01ZdEMUb8nq38i7XZ7JPAJVNL8C+5Jh7GiB
         KloesQ0RzbVykJoEeDU422NSldz2/GJ6VzcmmN5d+PivNSEjld7PSQ+fFBTZJaK+6O1f
         eJZnZ2rNrZtuBYVES/OTLXWeiDrgQDw8L9K1SWPxf1HVE/bNomF53KthFyUiHuTOEisT
         jD5b5yr1REdDA3WfVJWlFaFYdYqns56q/GlVf0GEhwIVMtKUAYwlL5XKabgs2CMo3w2v
         d/uw==
X-Gm-Message-State: ABuFfohEBsPrQ9mP73FVguqB8lQuNdUfjdN4auesdT2xR/EHsMr9gkz7
        +Eb7h7W+NHSxbLREauXdaD0=
X-Google-Smtp-Source: ACcGV62LoUw12oCKwhFE+LFODHOfEYDQUptGLGFcTsJprw80m079S6PNZQRcI8AmsRi5gYVwZqztsQ==
X-Received: by 2002:aed:36a4:: with SMTP id f33-v6mr34752069qtb.367.1539969788275;
        Fri, 19 Oct 2018 10:23:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id r4-v6sm4703694qkk.82.2018.10.19.10.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 10:23:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
To:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com>
 <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
 <20181019164631.GB24740@sigill.intra.peff.net>
 <CAPig+cR7=OpNsuZu+ppdyDvt5HAHMdDj4cBVg2U34B_j2zZ03g@mail.gmail.com>
 <20181019171130.GA20834@sigill.intra.peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <38b9f813-0463-3d15-ad9d-86f64c140043@gmail.com>
Date:   Fri, 19 Oct 2018 13:23:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181019171130.GA20834@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/19/2018 1:11 PM, Jeff King wrote:
> On Fri, Oct 19, 2018 at 01:10:34PM -0400, Eric Sunshine wrote:
> 
>> On Fri, Oct 19, 2018 at 12:46 PM Jeff King <peff@peff.net> wrote:
>>> On Fri, Oct 19, 2018 at 12:36:44PM -0400, Eric Sunshine wrote:
>>>> How does the user reverse this for a particular git-reset invocation?
>>>> There is no --no-quiet or --verbose option.
>>>>
>>>> Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
>>>> builtin/reset.c and document that --verbose overrides --quiet and
>>>> reset.quiet (or something like that).
>>>
>>> I think OPT__QUIET() provides --no-quiet, since it's really an
>>> OPT_COUNTUP() under the hood. Saying "--no-quiet" should reset it back
>>> to 0.
>>
>> Okay. In any case, --no-quiet probably ought to be mentioned alongside
>> the "reset.quiet" option (and perhaps in git-reset.txt to as a way to
>> reverse "reset.quiet").
> 
> Yes, I'd agree with that.
> 
> -Peff
> 

Makes sense.  I'll update the docs to say:

-q::
--quiet::
--no-quiet::
	Be quiet, only report errors.
+
With --no-quiet report errors and unstaged changes after reset.
