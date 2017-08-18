Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16AC20899
	for <e@80x24.org>; Fri, 18 Aug 2017 02:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdHRCks (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 22:40:48 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36058 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbdHRCkr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 22:40:47 -0400
Received: by mail-pg0-f54.google.com with SMTP id i12so54787322pgr.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4e2DnUhQhcK6/efv4RzXDGNofXSGrokO+CPSJKERzyY=;
        b=D+nKcw4R9VOEZsqPRHMZHyGvdOHdT6ASRkJ9rg3duvNEw0RdZbIwOMrWUYxANLrqfd
         HmztNXDcC9OGJyHks1p209OwdhWV9D3c9xgsVgWBIrJJOwmb+rzH0OR/8N6r1Aw3Ul5N
         joIlAGIm0kAFpuvarLDLd/i6zVDqt39fNi6/F1aN9jGD/9Lg7VuzQdRO/QS1riWpNfTf
         F7aAer8jlNeZHt35tw4TZfFlzWVLJhowaLVdRGkK8tGuydyX0o3RrNl9toeMHrRJ22v/
         BMAmEUUXGgt9rcW5ijCtr863KCu9pQq0NRPfMKBlhxRiSKxRaVOXyAZqoRbMy3lCIabw
         KXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4e2DnUhQhcK6/efv4RzXDGNofXSGrokO+CPSJKERzyY=;
        b=N4t7UhFKtOec2v0m345dVidMi3pxSo/vCYwQ7fc8gO3b/CDMOQwAKrIgQLYhRxoiXT
         H4Td765rrAKr1PD51G6gjZw8lGJTOly8lO9A+qjCdfzTB2mjO6kahaQwrozHM9OfSWKO
         fPbCstNk3hRtVrk41v3QQkUeBy8Sy16HeCv69WaWnkEEj3HxWYw60wABDJQzBXmxZZNS
         lQDyBM3xINiHOlXNXZ7Dwe3cTBGDb77PDuNqte/Q394ptNYdq0LJ4CNsT1Rz4bgvxQdP
         TVaz6GiD2A52nZgEbua018oV0b10AC85O27CSP+BzZbTJAw5mrAVPwOZnXfYXhs7guq4
         xkgA==
X-Gm-Message-State: AHYfb5jaIZ/3+2vnAvKe3eXzeaXrxJVWvN+WehLvvJ5MnFBe8JefbqXN
        zru/ic7dxM2o16GYK8M=
X-Received: by 10.98.30.7 with SMTP id e7mr7322522pfe.329.1503024046598;
        Thu, 17 Aug 2017 19:40:46 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id l8sm7378504pgu.63.2017.08.17.19.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Aug 2017 19:40:46 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
 <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
 <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
 <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
 <xmqqshgqezox.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <42219b51-8232-e1ee-9c48-f67ccdcbb4c8@gmail.com>
Date:   Fri, 18 Aug 2017 08:11:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqshgqezox.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday 18 August 2017 01:25 AM, Junio C Hamano wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
>
>> On 17 August 2017 at 04:54, Kaartic Sivaraam
>> <kaarticsivaraam91196@gmail.com> wrote:
>>> Helped-by: Martin Ågren <martin.agren@gmail.com>,  Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> I didn't expect a "Helped-by", all I did was to give some random
>> comments. :-) I'm not so sure about the comma-separation, that seems to
>> be a first in the project.
> I didn't either ;-)
>
> The line looks odd so I'll remove it while queuing.
>
> Thanks for noticing.
I should have been better with my wordings :) How about converting that
line into two 'Suggestions-by:' or 'Reviewed-by:' ?


---
Kaartic
