Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB6820281
	for <e@80x24.org>; Sat, 23 Sep 2017 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdIWMRR (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 08:17:17 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:50859 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdIWMRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 08:17:16 -0400
Received: by mail-pg0-f50.google.com with SMTP id p5so1843293pgn.7
        for <git@vger.kernel.org>; Sat, 23 Sep 2017 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZpM/Hup2tY3Adpo2EOjovgEorI4oPuLxJVtG8JrBhtk=;
        b=AdmsY7g6WL2xVuFKd6rTPfkAfM4FzaumyCQiXbWynibGgaYXhIsmCURnpWY/6OMO6o
         SrDFbCV2HwiCAWsCdZQ6E8o7c4BGAMjdJ1LtvRNwQf7P/jtu5sptdoV4FG+QVixJoy3h
         qNqtm831184QuBqqKSes3WmFdr10/k7ZFlRqcU8HPXonhiovm8cXCVJRtCdHCKhgsKk0
         qHR3Ok63jP/Z4kDDTuR5JLX6tV5VHdnISPHTUbdvKE58QoqbtNw257RhO91WgAmIkJBZ
         cQoYrJJraegAe+rr3UwBjCPNJItGoZlRoZpJx9elB3cSPp3P2kAVdVk8pv20VKQUVQpi
         vdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZpM/Hup2tY3Adpo2EOjovgEorI4oPuLxJVtG8JrBhtk=;
        b=ZbM0X4pLaaEwGp+u58AvInoqI6Y9OJpahDpTswVu0i7x3WNYVHci6tk76TT5j2oYKp
         Bx6qv5KJKJcsOwUPABBmVyjxQRCnZwnOfwQkx2tgYTV7Z+ivUBI2r7OywCVW2oFKfbpO
         DHb7Tu3TfJJu0ssBq13e7hO8DNZ1yzpnX3ov4H6AZZokYu6DOfW1tNO7DbepaKuF26lM
         C130YJRScFZExlY15lcnUqn2jsvUFdENeqGyUIyXypxiZVYv2fXZnEbq5lFO4aTgB3aJ
         UXqOg+tKekNcCtFocDh2vRnkts617K59VLjQ+PaBpKqS52oJz1Mn4QoGmZ70jhBdxW6M
         o/Rw==
X-Gm-Message-State: AHPjjUh51Co1rsmnPF7IMqOL1qfCpMHhS+vytgp1buczDcVE6kdklWFc
        j19+ziymM/NNw4D+q2uj0uz0Lu+W
X-Google-Smtp-Source: AOwi7QD8oekz00/0QXKZnmJKtV+rl/QW5YpurkLCXNov0cV0NijCbg4Q/Ua1mFOgDw+77R7PghmDIw==
X-Received: by 10.84.224.206 with SMTP id k14mr2040989pln.317.1506169035332;
        Sat, 23 Sep 2017 05:17:15 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id n19sm4838579pfj.114.2017.09.23.05.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Sep 2017 05:17:14 -0700 (PDT)
Subject: Re: [RFC PATCH 1/5] builtin/checkout: avoid usage of '!!'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-2-kaarticsivaraam91196@gmail.com>
 <xmqq8thaow8f.fsf@gitster.mtv.corp.google.com>
 <e07a613e-8b69-e382-777b-b5797270ecaf@gmail.com>
 <fbe3d3e2-a14c-fe7c-7e5d-c24789b249ca@gmail.com>
 <xmqqlgl8n8fn.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <de378f54-1c6f-327e-3f61-f8b215cfe203@gmail.com>
Date:   Sat, 23 Sep 2017 17:47:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgl8n8fn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 21 September 2017 07:01 AM, Junio C Hamano wrote:
> What does "with arithmetic constructs" mean? Would it refer to
> things like
>
> 	!!i != !!(j + 3)
>
> that unnecessarily obfuscates what is going on?

Thanks that clears the confusion because I haven't seen constructs
like this before (who would even do something like this?)

> The primary reason why !!ptr is good in the code that this patch
> touches is because what is doubly negated is a pointer, not an
> integer or other things.  The called function does *not* limit its
> input to 0 or 1 (it wants 0 for false and everything else for true),
> so we wouldn't be doing !!i if what we are passing is already an
> integer.  But we cannot just pass a pointer to such a parameter
> without getting the compiler upset.
>
>

Done. So I'll drop this patch.

---
Kaartic
