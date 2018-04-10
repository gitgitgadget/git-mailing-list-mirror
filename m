Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683A81F404
	for <e@80x24.org>; Tue, 10 Apr 2018 19:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeDJTfO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 15:35:14 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:39668 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDJTfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 15:35:13 -0400
Received: by mail-pl0-f53.google.com with SMTP id e7-v6so6159172plt.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=f0D5ZiQ8Ab7ImQoKOwvQmA2F3PnnanIqGIMwA3w9+8U=;
        b=mBu1pOHrHYJ8XlX87gPd+xFEXkkVPjN7vcsyK9tR1Tx3kySM7ceFXm33/xc0b70/3G
         SkmeksHx6tL3ksD61xRgqQO529wYK+itEKw1e4y52LTbZ+eoAU3CFAGZoq5SJVSafslT
         kfasNIjjMxZKFPz1757NbiR47QXWcEEdWtWPv3Gbub7XX8XPnw8JaRIZGrNORyukCD+p
         ScvkHoaKTaxryNzkLX6AgOjHwkAeVjzelBIIR8e1j92dN/xD7q81YrrUSa0LjmcRMx+x
         TvK0gmrDljSUOeYhmns5iyh9uioWzhGANvYjLGbwSyVCuKRp4Xv7nGa5uIvEeB+NIf3g
         UWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f0D5ZiQ8Ab7ImQoKOwvQmA2F3PnnanIqGIMwA3w9+8U=;
        b=nNWDL/Ww8FafdOQ+MLPOQXSu+mZRYedjcpnOBi60186oiwv/WLtym1xvEx7sS+3m6h
         nh2aXIo+9lov8PRU124clPW8k/T31THPuQN/oH0AJNvLC191DVv/odc4xXxFvlqPvkod
         HKwVbDlULtH1NckHP5+Ckk4sGJgyW9pCxdYLhSon6ZaVoYGxeUJAMpUmoecMqCZs9PBD
         8p2x7DJ/I6bXG04qg1qSXaumuIQmDwoWImtssb6oq8XeBI8+ue067tSP0PIu2/VBx45y
         jGU9Rl4qm6xhkKOFDZwG7qxdRbFRrITDdw8iAkEnI3sZTWY8wj3Hrz4OY8OKLV96L81W
         G3vw==
X-Gm-Message-State: ALQs6tC4WCD3pbdalnK6H6p8aJIATbFxT3QOaRjhU6oCvf+0ToygDB37
        lb4QOU/MXbB5RSef6BO8JT9MrCo9
X-Google-Smtp-Source: AIpwx4/wkJ1WAPIgnsU9MPBwgti3mfeyvZv3vWtch57sqHn4wJDHPCz6XI6i/P517wDon0fQ15IG4g==
X-Received: by 2002:a17:902:28e3:: with SMTP id f90-v6mr1771342plb.250.1523388912613;
        Tue, 10 Apr 2018 12:35:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u7sm6712553pgc.71.2018.04.10.12.35.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 12:35:11 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
 <98394864-ece6-5112-0274-b2399087f207@gmail.com>
 <bba6e3ba-ab28-8cda-eab3-91ec3591bcb5@ramsayjones.plus.com>
 <xmqq4lkk58y0.fsf@gitster-ct.c.googlers.com>
 <b7644afa-3f5f-4caf-59dc-4ffc8ab0695a@gmail.com>
 <73f2f53d-b73a-bdbe-01a5-8ed1d4fe6b00@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f9f5ead8-52c8-0ac4-750c-6d4dc324164d@gmail.com>
Date:   Tue, 10 Apr 2018 15:35:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <73f2f53d-b73a-bdbe-01a5-8ed1d4fe6b00@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 3:21 PM, Ramsay Jones wrote:
>
> On 10/04/18 13:57, Derrick Stolee wrote:
>> On 4/9/2018 6:08 PM, Junio C Hamano wrote:
>>> I guess we'd want a final cleaned-up round after all ;-)  Thanks.
>> v8 sent [1]. Thanks.
> I just tried to 'git am' this series and I could not get it
> to apply cleanly to current 'master', 'next' or 'pu'. I fixed
> up a few patches, but just got bored ... ;-)
>

In my cover letter, I did mention that my patch started here (using 
'format-patch --base'):

base-commit: 468165c1d8a442994a825f3684528361727cd8c0


This corresponds to v2.17.0.

Thanks,
-Stolee
