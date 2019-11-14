Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE7341F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfKNRa2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 12:30:28 -0500
Received: from mout.web.de ([212.227.15.14]:51387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNRa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 12:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573752625;
        bh=/5UuygtXsNRBpw99DCx5rnmPjlndpWtJmn6pnk6fVoA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LStnIcftUGFHIr5fqPD5xFNBThv/yIqor1oMlLoKIZXp859Ss3ZVKtMleQGCx6ROy
         EJOZRHBE6i2hHxMgaRIrAkUDVWmLaGb1CsG91+a2U8uWqE3Phf/shHnZ8NQxmFPv/R
         ll4dOHjSPp3vmo+z2LAX0SnXIdITPihRjmJmMLCo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmLac-1hwWA70U0A-00a0AJ; Thu, 14
 Nov 2019 18:30:25 +0100
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
To:     =?UTF-8?Q?G=c3=a1bor_Szeder?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
 <20191112175926.GA41101@generichostname>
 <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
 <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
 <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
 <1d08b49e-1f41-4290-a64b-dad9fd2288de@web.de>
 <20191114163527.GT4348@szeder.dev>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <751e4cc2-e6d0-edfb-b206-4204443a5c62@web.de>
Date:   Thu, 14 Nov 2019 18:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191114163527.GT4348@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hl+41IJl3179Hue6Cjj2B8CvtKAhAs23H9HkMV1gYS9Op7exETz
 cgE2RXi2YdeXxm0GLQq+yUan/bDjZlBf/M90C4DbhXruALPWRh8/GxIqEvUmEybuTWj+lOu
 7ehTbN3ooo/Vjf+HJPV5uaaq5zs1FOqWAVZkjnbsIxvUBjB2fpEEdJk8vjg298qh1hvep+7
 cImKcCcxFJA962f2GH/jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/xQAU4R/aM=:QmvcOp/gOPeVLRdhXlgMCt
 jo9ycOcbmH4srligAxMFUDljjtUgp9/KbLlSuXSkR8k8QPw5Xlw5w3SVWsw9WCheTPdYqgxFm
 hL05isenay6ZHWBAu1aHUwH+mP3+MGT+BhYiNd97Th1WQJzb0+eI/zmiQRFnhf2OEFFuUgtrl
 QOXMFOrXcRe7Veqnss5Pj81xHMSxIkr9RlabrvavjRzG9ef5X7Lzy3GwYn1UyJQcOCq3hWi9a
 itQV6oQQDtdQXE3T6O4+BNFsNC7XMMlz6kc/uBHLDpIPODlFSIq3YhQKu6FgJ1Ce9aKzy/0qf
 F/S0F6XS5HpJ86Sm8igpQ+Oa/2D5nGJ0UpMIuP9bObres6sTYXZj9YUePC6ClGoWspfQX9EBy
 ZJrTwzhNDWO4nmBvBlX/4/gWFmuzg+LNh5uPKnM0vbAM7HIstHJ3W7YbPc2UyWGMt9uxHc6Po
 vPWtusPuoGWjStxswVewirw1e4JdetP6BDWZKOui4NYGCkiyB8m9lAj8NvXUvfDzBjQBHBc01
 ZVjna21YIeJeJKeaFEC7hcYvYkPNwWpbLRx+4VxMOJzEPN2P6ZOvoGj4RU1WlDxc0ZdmKBoSG
 Efo5sEYjXeApnxMSFE4HysPmTUPAyDUT3oEKM4wNfS7N/abqccatzeuDn0hSWMGv88dergDi1
 mqqrK/CrmMuh96Pq5rpGlRlZnHwgXtA3ZZeSlPMPIFiWAAuXwgKSpEZqkABK8YKlx+dYILjjl
 3XhkgothHJi9Jw4LI8j6L/A6IRrqas4RMBOvJOH0WD1OTOnhh04B5JOl+ryx5c10WLJi2ZJOI
 viGyTptr0ra7aVo+Ti+KRyihj+ChjlXYuRiHxkK50OBJskdHjH/1wcEJB3mwaBMIpLB1EhAfN
 uOFBj5n6ue+4lYimNLgNGu4cYLIiR4RDn51En72zJKY2hueTE4u0Bba6ll6XEKuKv8RjAA/p4
 MgwZyM+43J6nLhL5HF/bOQdD9ZLW+b4Vw+69G+D57jOGQcsgAg4Ka0mPPAuyR49IR6RpNT4l2
 hv3a8HATmCBnArqQxNcz8e0XhvwNWxWinTuPWx0WsYgD0nIlu5qbA2cF310FCYcf2cGdcSUfd
 wS2a+0g4oh5LfdG5IB1zic7rTqKzOUJ+L4QKVmiCtGqEaf0r0SfDpx98DFkNCpwFkk929rIMB
 yzd4320nmcrChLkX4ryhxIaV2hgxsqsTHbcW/s4Vg+Ve7Xav0xCOmhdDpSn4VBfx5Fg19C7g8
 LC8Z69r52IBEYUiQiVgKQNeX1tXKSrjobi9W7dDe1M/782bpdIrK5igvg6xQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Does any test infrastructure (or benchmarks) exist which you would trus=
t for
>> corresponding comparisons of software run time characteristics?
>
> Yes, just run:
>
>   make cocciclean
>   time make contrib/coccinelle/flex_alloc.cocci.patch

Thanks for this suggestion.


> before and after your changes, and include the timing results in the
> commit message if there is a notable difference.

The measurements from my test system might not be representative enough.


> FWIW, I did just that with your "coccinelle: merge twelve rules from
> object_id.cocci" patch [1], and the runtime went down from 2m48.610 to
> 2m34.395, a bit over 8% speedup. (with Ubuntu 16.04's Coccinelle
> 1.0.4)
>
>
> [1] https://public-inbox.org/git/6c9962c0-67c1-e700-c145-793ce6498099@we=
b.de/

These numbers seem to be nice.
Would a direct reply have been more helpful for the referenced patch
than the current subject?

Regards,
Markus
