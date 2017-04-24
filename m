Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9531FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 09:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166903AbdDXJjL (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 05:39:11 -0400
Received: from mout.web.de ([217.72.192.78]:63592 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761082AbdDXJjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 05:39:10 -0400
Received: from [192.168.88.106] ([194.47.243.242]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBHO-1cdmzv40ti-00PtUC; Mon, 24
 Apr 2017 11:38:34 +0200
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
 <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
 <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
 <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
 <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
 <xmqq60hu1mhq.fsf@gitster.mtv.corp.google.com>
 <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <18ee407c-db3b-16a2-4822-0ff302045b27@web.de>
Date:   Mon, 24 Apr 2017 11:39:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170424075241.ybbq2cpvbmwtdwz7@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vwExpe28qSnSrrZNwwv/8yKHtbq2qQdUL8/a3A9bm+C+KwyTCnt
 WWCMSwX7XP7rod0InueV0FAOGamMShCET3mr2T8C1YRBFQq9Y5mI1yatWBz/p0UDEGobikH
 +CfGcx2+6qomm7L5jfiQPpKOSrCaZP7IhQkffsGxG/vE8YMxODO/zXYudvlv3T2L55ZqoL+
 52+sbU3NcIP39bfIOH82A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:95oYAw7BiFI=:sdWIeE02rnu+7KtDde6Ii6
 eaILM9PttswzpJ72QRuet7i63ak+3FgQethRpHQLQukK8eedteSNwlgEY2HgIejpLxTT/iyG/
 bwfEzpyllQNPKljr6Nsh/OoV4gAdmy/Qmipdw5n8mp46ixKa1c30z3bALZLId5JgGz+bnXgSW
 ebu1Gl9N7uu9RgiQ7Xcg3Dk9xWRH10+XH889gpgi3CHnGQ4GIPCh/GIo8iXTipRWbuLrZsZVi
 zkCBGb02/0ay5umwxm5K/4TpixKyT4GFvGMngtxYsYW4vizvbM9p1QbM2emJcJtqhbGX9XEvF
 0iKYsUMgS0idMhVwEJUan21se7K4u2yIawCGULO7ikVs6UKZD8n9Lnoosoe9iSxm9mZf4vpyO
 mWqE6TgSKbau7c4e8dxzOOmt4JC+Z3bTLrItseddPl11Qv92sLVd1t0C7srQt6jngEQCmDhV6
 SFegwiAR643UrJnxsdLyLnln2iHTudwU6wTUQ+dBDfdcdUh/gDqvLXuI+HW5IidlODvPOBtjt
 ZrL2ug6pQ1Znys00Tx15S6OWQXBFYs3IunniOKdmdhgPDUh3SnbhKmweBiVunR9AHyUgKFoui
 NvIiWt8SRmKpHfFzYqTqGCjBNXyLQl3XgOgQsNuoglx7/032vaqY+rV9NYqUQs+iuXMnkmqh4
 u156DHgLQ4R2ZdQ077vSG1AE3c2wKqWNl1LhODcFD77ZYD80xR/2SZ6emKE+/Dk4VnoKmY1t0
 hfS3ChoeGYDAaZA5ujUHolzTfynrrL8FMfCoVp+Vq44DgK0hXnHy8g0Y0Mle5D7rP6CXdHO9M
 Vgw7VrX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]
>>
>> -		cd "$(dirname "$remove_trash")" &&
>> -		rm -rf "$(basename "$remove_trash")" ||
>> -		error "Tests passed but test cleanup failed; aborting"
>> +			cd "$(dirname "$TRASH_DIRECTORY")" &&
>> +			rm -fr "$TRASH_DIRECTORY" ||
>> +			error "Tests passed but test cleanup failed; aborting"
>> +		fi
>
> Yeah, that looks good to me.

Does it ?
Checking the error code of "rm -f" doesn't work as expected from the script:
rm -rf DoesNotExist ; echo $?
0

I think it should be

>> +			cd "$(dirname "$TRASH_DIRECTORY")" &&
>> +			rm -r "$TRASH_DIRECTORY" ||
>> +			error "Tests passed but test cleanup failed; aborting"





