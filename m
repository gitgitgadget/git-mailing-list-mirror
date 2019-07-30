Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C491F462
	for <e@80x24.org>; Tue, 30 Jul 2019 23:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfG3XFo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 19:05:44 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53543 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfG3XFo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 19:05:44 -0400
Received: by mail-wm1-f54.google.com with SMTP id x15so58792698wmj.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GEuvDlT8LJrzbb5uyvo8n8eyjHhVneb7PKXkOaYCy3s=;
        b=dYuobAdVdR27qoHUr3qiXfdidzeML+9cuKgpyVQAP7cD44yLzr/VIH/ZGDm/YRepIe
         Zh1r3rvaS/ScTviRR0UA24+HPDmPCkIkyJ0+IUqkStF4AvQBejs96QCsthkAQBOl5z1a
         cEYkrUjYiPIe8RzQdPCYuCmHM3qbk1Sbr/hz8Hv1NMrCKbFBhnt2px8bh5uk30m0gPSD
         7+9xuEfM4Qh/vDjunS9I3WvtIO84x6f9Tz13GLTGwjxDMCrDMYlUtCM5sE03/ZigGGsO
         DxdlxXXJOdLNc0Kj2wA94SDVY/cDpaoE3q+4uy/2nejhhBHmruaQRFAubw92q3yzG+Im
         ypkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GEuvDlT8LJrzbb5uyvo8n8eyjHhVneb7PKXkOaYCy3s=;
        b=UcTgWXq+AdStvmOkbZNWlBI3cMRuicCa75hnX4a9VLL76zJpTUjxMzsuRBRq+z5tVH
         8rI+yWKT9JhAQ92uVcjWb/N5KW7rpn3N0kP3GDcjiXWpynvyDMzcRmxvG39UPfRJwnTt
         NHJdWNvb87EGmh8tymJkAZeoGU13f0YXzx0vWCg60+sBJh1ZzWIMgARZ7Wb9Elbxc9EK
         eb12faPvj9LY81yOctEvyr82t/GBuOCqpAlJRS/6i0oeWAfUA7QVoaYX8fwKpIcwJLXC
         C0wzMIGJcGY773ePpdz1Oao0B6UJGkd13NTjnztcq+FKl3DWRSIEX17zCZRRTzcop7mX
         hEtQ==
X-Gm-Message-State: APjAAAULjVJnqB+MLToJcbq/XN2m9H7iOwRZD2D+vCVQZhWh95CLW4zA
        cZn9Df3qhlrPGk6o9zA//GNNfn0E+0fII6Zw6/P0e015Qs9cK9Cv0Hmkpt9EO8Ms0EqFgQGxORA
        e7KPXtLgnZalMk64d0eeoOhof5TJ52dlUrAvFnptmoHLOU3PTaref4Iu1oPUcF8svqRbabpi28K
        CT+cyKeBFg5Q==
X-Google-Smtp-Source: APXvYqxKhiaz4jwTvxa0Y1mcUFNTxYdy9HFKxutQF8nJESVubpPJqJqJaUjFLCVntX5bBcUWHTB11Q==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr103511795wmc.126.1564527941379;
        Tue, 30 Jul 2019 16:05:41 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r123sm59368166wme.7.2019.07.30.16.05.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 16:05:40 -0700 (PDT)
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
References: <20190730203327.30958-1-dima@arista.com>
 <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <5775af07-f425-8192-3f2b-a45f21981407@arista.com>
Date:   Wed, 31 Jul 2019 00:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 7/30/19 11:13 PM, Junio C Hamano wrote:
> Dmitry Safonov <dima@arista.com> writes:
> 
>> I was almost certain that git won't let me send the same patch twice,
> 
> Why?  And more importantly, does it matter to readers of this
> message what you thought?

I see the point of putting description in impersonal, technical way.
Probably, was irritated after sending 50 patches instead of 37.
Also I've seen that in `git log | grep ' I '` over the project,
not that it justifies using it in the discussed patch.

> 
>> but today I've managed to double-send a directory by a mistake:
>> 	git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
>> 	    --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`
>>
>> [I haven't noticed that I put the directory twice ^^]
>>
>> Prevent this shipwreck from happening again by asking if a patch
>> is sent multiple times on purpose.
>>
>> link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
> 
> What does "link:" mean?

It's a tag, usually used to point URL for more information.
Maybe not that common in git-ml, but often it shows an example of what
can go wrong without a patch.

> 
>> Cc: Andrei Vagin <avagin@openvz.org>
> 
> What's the significance for this project to record that this patch
> was CCed to Andrei?

I've felt like I need to give credit to my friend with whom I was
working on the patches set; which I've failed to send properly.
Maybe it's a thing of more opensource-friendly communities like lkml.

> 
>> Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> 
> I think "Helped-by:" is a lot more appropriate, viewing the exchange
> on v2 from the sideline.
> 
>> Signed-off-by: Dmitry Safonov <dima@arista.com>

To be honest, I don't feel like going on with v5.
I've underestimate how welcoming some communities are to foreign patches.

If you feel like it's still worth to have the feature, please carry-on
with the tag
Abandoned-by: Dmitry Safonov <dima@arista.com>
and don't drop Cc tag.

[..]
Thanks and sorry for waisted time,
          Dmitry
