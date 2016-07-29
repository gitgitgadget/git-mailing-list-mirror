Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AA81F855
	for <e@80x24.org>; Fri, 29 Jul 2016 23:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbcG2Xoq (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 19:44:46 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37279 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcG2Xoo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 19:44:44 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so171032089wmg.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 16:44:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g6IYGcW7dpPFSMqZERrvz04BNbWa+flNQLoFTISJey0=;
        b=Wwl7GDX5DQ7MWxxLFCvAAdMAHai3jLOnvIWEVH5MfnquvAT2kEa1xkuFnSDhKpVHik
         U5KIEb34lJZLDwy7ev8D0eMAoG46sOYZNeA3QWOvBRrvyFWC5gqiOQlBzze+yDMSHSwb
         ctIEa0omgo5J8YQLunx0CMiNwQ1lxkH2kYCUfMfQwrdzVuw4VKYeU4Ecs4d58xq8U193
         MxFGIWQ7dAnemSlPa/whRd9EdsXonLrBvu4lBOXzcOeRr0DB8iLp/9/HMgcWZyAZmUrK
         LVTvDHnxe7yBNtFQRwen/yRVb43ELBTGlqdyX0IMvZWRp0UFYxsMliJQ87sQ65T4CEEY
         a+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g6IYGcW7dpPFSMqZERrvz04BNbWa+flNQLoFTISJey0=;
        b=XhLPM8J0MdHkTmDy0QH4DKfdMRacqGz+TOwVZ/LlZ19m+OMJAPpCPtEV6xGI9DGb0M
         QZSqFEWKe4kMmVjD+2UySK1D6Y9UAMt2O4ysXUroJ1MZ5e6FCbuNHVhujEycS6e8sghC
         K/Lzt+VisPGCHZbW6g8zL7LTIoGTB1WIoqMjk6UEvX/Z9WU++Pwo8usw1SkzgMOduzgX
         flO80chtIlINEgXAQXB66pN5t9TiDI82yNAw/hhKjgAeSWhjCAvvsfZ29lV6nhD7vpi3
         6Drp7/LW5WM04NZIM5vPCQqZ5WierFCxOhcY+3iUeLicGSMRiv8/CfSo8ads8+bLvXqR
         yLaw==
X-Gm-Message-State: AEkooutFw4Te2tHu1A7s6yF5tdw6Ga+YKnuopZKxd8AKJJF7HGGyZ3rYCBf60wd4l7Ky0w==
X-Received: by 10.194.16.65 with SMTP id e1mr12823257wjd.143.1469835883189;
        Fri, 29 Jul 2016 16:44:43 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4145.dip0.t-ipconnect.de. [93.219.65.69])
        by smtp.gmail.com with ESMTPSA id m81sm5184360wmf.1.2016.07.29.16.44.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 16:44:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1a009e19-8830-7dea-2811-d475cf482ea3@gmail.com>
Date:	Sat, 30 Jul 2016 01:44:40 +0200
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Eric Wong <e@80x24.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Transfer-Encoding: 8BIT
Message-Id: <2435ACEE-19BE-4995-B929-BCEF658F278E@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <57994436.4080308@gmail.com> <7F1F1A0E-8FC3-4FBD-81AA-37786DE0EF50@gmail.com> <xmqqshusny86.fsf@gitster.mtv.corp.google.com> <1a009e19-8830-7dea-2811-d475cf482ea3@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 01:11, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-29 o 19:35, Junio C Hamano pisze:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>> I think sending it upfront is nice for buffer allocations of big files
>>> and it doesn't cost us anything to do it.
>> 
>> While I do NOT think "total size upfront" MUST BE avoided at all costs,
>> I do not think the above statement to justify it makes ANY sense.
>> 
>> Big files are by definition something you cannot afford to hold its
>> entirety in core, so you do not want to be told that you'd be fed 40GB
>> and ask xmalloc to allocate that much.
> 
> I don't know much how filter driver work internally, but in some cases
> Git reads or writes from file (file descriptor), in other cases it reads
> or writes from str+len pair (it probably predates strbuf) - I think in
> those cases file needs to fit in memory (in size_t).  So in some cases
> Git reads file into memory.  Whether it uses xmalloc or mmap, I don't
> know.
> 
>> 
>> It allows the reader to be lazy for buffer allocations as long as
>> you know the file fits in-core, at the cost of forcing the writer to
>> somehow come up with the total number of bytes even before sending a
>> single byte (in other words, if the writer cannot produce and hold
>> the data in-core, it may even have to spool the data in a temporary
>> file only to count, and then play it back after showing the total
>> size).
> 
> For some types of filters you can know the size upfront:
> - for filters such as rot13, with 1-to-1 transformation, you know
>   that the output size is the same as the input size
> - for block encodings, and for constant-width to constant-width
>   encoding conversion, filter can calculate output size from the
>   input size (e.g. <output size> = 2*<input size>)
> - filter may have get size from somewhere, for example LFS filter
>   stub is constant size, and files are stored in artifactory with
>   their length 
> 
>> 
>> It is good that you allow both mode of operations and the size of
>> the data can either be given upfront (which allows a single fixed
>> allocation upfront without realloc, as long as the data fits in
>> core), or be left "(atend)".
> 
> I think the protocol should be either: <size> + <contents>, or
> <size unknown> + <contents> + <flush>, that is do not use flush
> packet if size is known upfront -- it would be a second point
> of truth (SPOT principle).

As I mentioned elsewhere a <flush> packet is always send right now.
I have no strong opinion if this is good or bad. The implementation
was a little bit simpler and that's why I did it. I will implement 
whatever option the majority prefers :-)

Cheers,
Lars

> 
>> I just don't want to see it oversold as a "feature" that the size
>> has to come before data.  That is a limitation, not a feature.
>> 
>> Thanks.
>> 
> 

