Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756991F404
	for <e@80x24.org>; Wed, 15 Aug 2018 04:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeHOHqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 03:46:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39864 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOHqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 03:46:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id w14-v6so42615plp.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 21:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pIYJpmYzemLoLZEoQcfBrvcpVQjWLG5eq3TFKk9X/UU=;
        b=k6tTB6kIGY3jrrh7qWyDiNu5OhZBK8xkx2eughaIYHobNZCfOIFfwLeX+3AU1f9Ip2
         VGDXn0/BCj80PVqIdibwcGKpsjIWmAJKfO+35gnux/rvu2VmGPeiE4XddAbnydIQ+f4C
         f3EKpP1ztWez5KA17Mv7NYBpppd9VwrB3T3/6EMw7s2mrkVuqMzC27L6HaC0RB7q77tz
         A6aM5k/emiPIPnZvlE01dLAFw957PLCRvgW0quJG2mr3JzHbfiuvD8jn09Vy6GPEktvH
         Y5RIoC9SnigGQBWfJ53M8f1hxaFhJFYHke2ZsGxW0FcSNz5EUdSg9ImvD5ucTrWAZv+A
         OInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pIYJpmYzemLoLZEoQcfBrvcpVQjWLG5eq3TFKk9X/UU=;
        b=UW+wqD11REbvNDeRDpBCr7q4nDlIrGUQqrhQGPIaX7GH/Po0MZ9eo01zWNE0ArHGWj
         c6jRMpPbkuSbentP0l33Q7W7ktUxpfMTfaqd0ij7H202TQ/l9Dp30oV8ypGlligJqoBK
         Mn34YtN4vJtKPFgErtT59U+P54Ock+ccOtdIQ2Apk6J6dCY2fImEPvwWPlvo7IDBr9YA
         TA6jOh7ShmRkGuI8fIFKlpforngfytsPRDE05BJ/GxNQ3pRMrEK//iIJEymSGVvqm0xe
         Jlkf7VBwp83r3o+Cd+FobjcNhdNASQOIKnNgPA5dJf0xeyyRWag2Fpn45QHpn3oYSqll
         T+OA==
X-Gm-Message-State: AOUpUlHIwzrmHk8EtD+NqvoEssp3zc5rkg35MDzyirm+XJAivjD8YqvE
        NHsC0oRtCUkic3FW5lFOqtw=
X-Google-Smtp-Source: AA+uWPwVRa/LPdGD7u9VCL42qKr2dxwwmwpu2q6lSUZ9AtmESON8l8rqX5xqO/vqxNWz6kl8G220Ng==
X-Received: by 2002:a17:902:b28c:: with SMTP id u12-v6mr22518967plr.16.1534308946143;
        Tue, 14 Aug 2018 21:55:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id n9-v6sm37232758pfg.21.2018.08.14.21.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 21:55:45 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:55:43 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
Message-ID: <20180815045543.GA32543@aiede.svl.corp.google.com>
References: <20180811043218.31456-1-newren@gmail.com>
 <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
 <20180811173406.GA9119@sigill.intra.peff.net>
 <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
 <20180815013825.GA12178@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815013825.GA12178@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Aug 13, 2018 at 11:24:37AM -0700, Junio C Hamano wrote:
>> Jeff King wrote:

>>> So I think the better test is a two-line .c file with:
>>>
>>>   #include "git-compat-util.h"
>>>   #include $header_to_check
>>
>> But until that tightening happens, I do not actually mind the
>> two-line .c file started with inclusion of cache.h instead of
>> git-compat-util.h.  That would limit the scope of this series
>> further.
>
> I can go either way on this. Using cache.h makes Elijah's current series
> a bit more focused. But I think we'd eventually want to go there anyway.
> I don't have a strong opinion on doing it now or later.

For what it's worth, I'd been assuming that any header that is not
self-contained after a #include of "git-compat-util.h" is a bug.

It's true that many .c files include git-compat-util.h via cache.h,
making such a bug harder to notice.  But the moment you write a source
file that doesn't include cache.h you'd run into that problem, so it's
worth fixing ahead-of-time anyway.

Thanks,
Jonathan
