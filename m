Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272D21F597
	for <e@80x24.org>; Mon, 23 Jul 2018 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeGWPic (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 11:38:32 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36794 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeGWPic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 11:38:32 -0400
Received: by mail-qt0-f193.google.com with SMTP id t5-v6so823331qtn.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9gCtnXUs+BVrBY5D2gpu/SQUeC1lRSgXmxNQ4yIEfV0=;
        b=e+Q7jehmpoM9ebQ2Yw1e9uue93oSFkvbE1Gbrk6lBggz97ntoLFYcPxta0xylFdovK
         KqFgtMWvbYOqLxw3jgTH2tF/rfPJP7lRsub7iWz0HroTwLH/KoaglHmnrqqaHeMzGll5
         ZvZlmf4hmCmIQiZFlVJ+jMEpXXTJg6dgJAwGGVH3kMpyH4uuAw8i0lM5Pf3O7/N0Ms/F
         ZyImhqX8L6mxgU43MpZlzZiVFtcoHgeHCuBq574l4G9MbjAbGFtlKCtEXFsEWAz63K9A
         nqBsmMvw/GouhhQ68FDNuzO7CVST8PiuCus3ZHWpSPky7DIFwMyFCMECtucBtGAj/ABq
         mKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9gCtnXUs+BVrBY5D2gpu/SQUeC1lRSgXmxNQ4yIEfV0=;
        b=tPR4+9XxbFOEgHT+fURf3lJaCTxD7bjYwRt1OoIOdEntamfEDwpysoK6iAfDjLYIk4
         n4WdRxAMa61E5EAS8G7OQ5NJxIS/4zv3ErIxreF9xSmu4r23QQBxWiy1WjDWvapTHVnA
         dX92pBY73+jWRDLbg9vSbwFvwPmglgdvrtyGJk76sV7p8V0465lQE6zrJigJCWuTW7TD
         MFX4C0BQCnwrbrNNCaRCYTmQFpBfWfp3MlSnyNayH7cBZKu6t1UXC8TnQaPowksIkrtX
         LmEqvvAl3m0r3hk29AwC0FAwnLvX9GFdo8O8WmOxwkIhb5LkzS89+/CmEjNKPSnoxMqi
         LoOQ==
X-Gm-Message-State: AOUpUlEtnw6r390n3zUgR1JvP4IthdkRItV7wCMz4BFa2IUDYXHxHou1
        0wooV2w4nlXMxTr0eVd+zzA=
X-Google-Smtp-Source: AAOMgpedqnJHt9N4nQThGci96iHqpho8SeYwKApJ4KR4heLxCuLBBfxYlR3uyiBiNnJFJxHVkdgcTg==
X-Received: by 2002:a0c:f791:: with SMTP id s17-v6mr11394099qvn.194.1532356618817;
        Mon, 23 Jul 2018 07:36:58 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79ea:539c:969d:bb3c? ([2001:4898:8010:0:6320:539c:969d:bb3c])
        by smtp.gmail.com with ESMTPSA id v4-v6sm7067657qth.23.2018.07.23.07.36.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:36:58 -0700 (PDT)
Subject: Re: [PATCH 1/5] coccinelle: mark the 'coccicheck' make target as
 .PHONY
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180723135100.24288-1-szeder.dev@gmail.com>
 <20180723135100.24288-2-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0023a8c0-9239-d8d7-4187-922f9305449b@gmail.com>
Date:   Mon, 23 Jul 2018 10:36:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180723135100.24288-2-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2018 9:50 AM, SZEDER Gábor wrote:
> The 'coccicheck' target doesn't create a file with the same name, so
> mark it as .PHONY.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   Makefile | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index e4b503d259..27bfc196dd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2685,6 +2685,8 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
>   	fi
>   coccicheck: $(patsubst %.cocci,%.cocci.patch,$(wildcard contrib/coccinelle/*.cocci))
>   
> +.PHONY: coccicheck
> +
>   ### Installation rules
>   
>   ifneq ($(filter /%,$(firstword $(template_dir))),)

I did not know about phony targets [1] so thanks for teaching me 
something today.

[1] https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html

