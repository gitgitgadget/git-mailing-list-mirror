Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C061920A28
	for <e@80x24.org>; Wed, 20 Sep 2017 14:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdITOwj (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 10:52:39 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:49783 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbdITOwi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 10:52:38 -0400
Received: by mail-pg0-f42.google.com with SMTP id m30so1804970pgn.6
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 07:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AGLlI/S5gkZH/gyKhz5HR3BWk/73OERPuSgvKSFVkx4=;
        b=uYgGUQTpQJHf3+jB+4qrBITbQn51qlKOEBlYz7GbCOM/BmhTZDUX62JUUXMJO/x+z0
         Egjic7gzV2m49FI9Flb0z2EM8vnLSgiS7F2TuZQ4InuG9W+xom/Y4UWfcoJbX36BrGUu
         ctGdgK9j+ezNMH4Zo+Bwt8bx86Su3AKVA7t9UbZ70YE5SuAWH+6oroF1hya54/xuEDWI
         5rv5I+gaMPbbtzyv2Q220cMpQoOzZgtG4Kyykavlcrk4Rhr5DUGw2/ZHyF61qrwSij8A
         LwuqgfiWGC9hBmIPZzzani00GgcvpBAzmPzsYc477DP9FfxWn0/CvM4jfJ/y0ieW3qXU
         m7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AGLlI/S5gkZH/gyKhz5HR3BWk/73OERPuSgvKSFVkx4=;
        b=uZlOHzwiRcR/0X5M1X+/ai5IILMfVcI2B2l6hVuen4ttlNM+19XTvg2QCpezCKCzNp
         5px72wouMP4bQJvlLIC0QDUIY22WG8l+DuR4e/JfResH6iauFJZxgz7ykXKr97ij1Mcj
         6GTK8DnnHHJR5aZo0qV1b1fcGAuGyhY8EXZCEM1+d6XJgAy08AWWfR/JYdEgxVxXY6I9
         KfphMuoDkQy/rSq58M5YGYZ82/VuD7c9LGqAtA/Ld0Ms1UWHQOn2MHkUa+TOzv+VaJ2H
         IRbtQK7roHiEugDqf0XahSG2pvAC6knIvbjB7QTDy1pAxgOCXZwUqLKpOCOqWG4C0EuN
         c9Mg==
X-Gm-Message-State: AHPjjUjMv3E8zIPaQfuEJrI9hgGRQJF187RO8UTrA+z6JGIYWqvTS6I6
        L7CXzP0ONZ8RsZAUbYiLJ5U1QSQ6
X-Google-Smtp-Source: AOwi7QD/Y5UJ7BP85iyCrQ4YgEeimSX6pXMx/hRGAgzYchZfmFIz0QUA/jXwpVadg5+kUnzYJjh0kw==
X-Received: by 10.98.163.13 with SMTP id s13mr2464553pfe.22.1505919157572;
        Wed, 20 Sep 2017 07:52:37 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id 89sm8589857pfn.75.2017.09.20.07.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Sep 2017 07:52:36 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] branch: cleanup branch name validation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-4-kaarticsivaraam91196@gmail.com>
 <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <aaffe492-75bc-c898-1ab2-271f9f8c9e17@gmail.com>
Date:   Wed, 20 Sep 2017 20:22:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi9qngq9.fsf@gitster.mtv.corp.google.com>
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

On Wednesday 20 September 2017 09:50 AM, Junio C Hamano wrote:
> Also I'd avoid "could", which can be taken as an optimization hint
> (i.e. "you usually do not have to worry about this thing to already
> exist, but I am telling you that for this one call that is not the
> case and you need to be a bit more careful by spending extra cycles
> to see if it is and deal with the situation accordingly if it indeed
> is"), and use "ok" as part of the name for the parameter (or flip
> the meaning of it and say "create_only" or something).

Consider I'm gonna replace 'force' with a parameter that has the flipped
meaning. Does 'shouldnt_exist' seem to be a good name for this new
parameter?
