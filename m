Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7298B20437
	for <e@80x24.org>; Fri, 13 Oct 2017 14:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758301AbdJMOay (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 10:30:54 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:54076 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758239AbdJMOax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 10:30:53 -0400
Received: by mail-qk0-f178.google.com with SMTP id y23so5214943qkb.10
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FHnvVQv03RIsJ50B0c6UkIfAdfwAlKxOMjsPPy8LCqc=;
        b=NI8zACxSDyYVpA4v90lZq0U2KrOuc0U1KNnYfjpUsvAgl6ZG8EClcWHH9wBo6kdqLK
         rFSPXvaMwOvbwk5CAREwQtfNbdC96xNDw6NJUG2h+0qdF6o+ZEyqcqdScAY/9Zfl7tJE
         V+ljHywDvZNWgMh+WpiXYrGOc2QUEt7TnFL8W585mXM6d0Kzjlu/OJzh/1Jyhsb2h+/V
         rgemWBJFzP4DdbqLYBquTRnNB/vJhTd3d7Xb3AGZ0QGsX2NOvCKfaxlRMv+QBKnM0D31
         gPii6eCSknfzbM4Wh+rAT+Wp6V0HDXej6Crg5bpPVwlcQaZ0pP6u732CN5nwHLPbBk6j
         +thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FHnvVQv03RIsJ50B0c6UkIfAdfwAlKxOMjsPPy8LCqc=;
        b=SLXyjzN7ffdjcdHKrH0T/zh0PQFJT/gTDqe7fj63nItu2Jof9wsfX4m0yDeULuR/ul
         owTna6Yp+htAoCQueCLWOBiHFW9egvuybvhK21QObq+FKCdH0FduwnUB2iRXWgvw1aez
         VzXp8Ej2PhTisJrMp+9r7PEvedePR1R0yaPX6P2m3Ek63g7TLd1AD7RHKPholCeWXdKv
         r91n03wUrV+lUXRbBhEE95lx4W9+ZU9fP/FIqg8RlLAf10PEZeiGftxQ9iu3e/e1o8Ae
         Yvx3Qc6dYuIiH8AL9G9b5pMxCgtwmjS+WHRScPLvFf8UP4oqGmHUI9981lsDwGyMpsQC
         vE+Q==
X-Gm-Message-State: AMCzsaU+Qne0y8aXJ5DsV/ucPgD/fR/gmzFIvZxRTPkxV2g50UuA8m8z
        1qBwiJfcrmWcsVJ4pjAy5TgzqugJ
X-Google-Smtp-Source: ABhQp+Q9yLsauIxUyYaq5bcenL7vQE1qSoHyIo/ts4lkQTEu2n7IGzzVSDDMeC+Qy8517DLiDnhxCQ==
X-Received: by 10.55.142.6 with SMTP id q6mr2269791qkd.302.1507905052113;
        Fri, 13 Oct 2017 07:30:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id n76sm597880qkn.85.2017.10.13.07.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Oct 2017 07:30:51 -0700 (PDT)
Subject: Re: git-clone causes out of memory
To:     Jeff King <peff@peff.net>
Cc:     Constantine <hi-angel@yandex.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
 <20171013124456.qsbaol7txdgdb6wq@sigill.intra.peff.net>
 <f35d03b5-a525-87b3-a426-bd892edf0c36@gmail.com>
 <a4ebf552-35d4-d55f-6f08-731afa2cd2de@gmail.com>
 <20171013135058.q7vhufdtin42ddic@sigill.intra.peff.net>
 <53f98311-3c5f-9863-5f6c-bc4f25fad317@gmail.com>
 <20171013135636.o2vhktt7aqx6luuy@sigill.intra.peff.net>
 <20171013141018.62zvezivkkhloc5d@sigill.intra.peff.net>
 <20171013142004.ocxpdkkbcxpi52yv@sigill.intra.peff.net>
 <42cbcb4f-7f9d-df69-f55e-0ba42b931957@gmail.com>
 <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c4b88c7e-7be3-6acb-71f9-fb0185dc0b7d@gmail.com>
Date:   Fri, 13 Oct 2017 10:30:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171013142646.evapso5uxzvh2r2p@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/13/2017 10:26 AM, Jeff King wrote:
> On Fri, Oct 13, 2017 at 10:25:10AM -0400, Derrick Stolee wrote:
>
>> This does appear to be the problem. The missing DIFF_OPT_HAS_CHANGES is
>> causing diff_can_quit_early() to return false. Due to the corner-case of the
>> bug it seems it will not be a huge performance improvement in most cases.
>> Still worth fixing and I'm looking at your suggestions to try and learn this
>> area better.
> Yeah, I just timed some pathspec limits on linux.git, and it makes at
> best a fraction of a percent improvement (but any improvement is well
> within run-to-run noise). Which is not surprising.
>
> I agree it's worth fixing, though.
>
> -Peff

I just ran a first-level folder history in the Windows repository and 
`git rev-list HEAD -- windows >/dev/null` went from 0.43s to 0.04s. So, 
a good percentage improvement but even on this enormous repo the bug 
doesn't present an issue to human users.

Thanks,
-Stolee
