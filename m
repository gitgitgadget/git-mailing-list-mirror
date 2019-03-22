Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC9C202BB
	for <e@80x24.org>; Fri, 22 Mar 2019 18:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCVSld (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 14:41:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:60551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfCVSld (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 14:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553280081;
        bh=fxXp2Djt2lcOJbqh+cE/oNiPRoPAl9Ps2Yth3xlKyBs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FTq/244v9/PhiZNPg9S/PEIE1t0u1aA8JX2XhXW1d2cK0t2Fk9/kmgdgjjfbF6dFG
         Q2vy3B6xAk0sHjdQaCs1kSaPz1hWltHwuHJrxxOsQDpqUYkQ1Y/AQc5/IliqsBp9s8
         Izlfs8vWBepomgVTgqrphz/y8W389jXfaqdRxYk0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.67] ([84.118.159.3]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1hPstg0QG5-00LDWp; Fri, 22
 Mar 2019 19:41:21 +0100
Subject: Re: [BUG] Cloning with git HEAD fails for some repositories
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>
References: <7e4a2f1d-2b3a-eb83-d3f1-9ac63d68991b@gmx.de>
 <20190322005107.GL9937@linaro.org>
 <017964a9-bd75-5e36-0de7-57d4467d6a7e@gmx.de>
 <20190322071231.GA26114@sigill.intra.peff.net>
 <20190322082114.BC19924013C@gemini.denx.de>
 <20190322093132.GA17498@sigill.intra.peff.net> <20190322165034.GA23124@dcvr>
 <3d8e8de3-9ae6-94be-7739-cb8ea79b228e@gmx.de>
 <20190322180922.nghzdmvqz7wsxcb3@dcvr>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 mQINBE2g3goBEACaikqtClH8OarLlauqv9d9CPndgghjEmi3vvPZJi4jvgrhmIUKwl7q79wG
 IATxJ1UOXIGgriwoBwoHdooOK33QNy4hkjiNFNrtcaNT7uig+BG0g40AxSwVZ/OLmSFyEioO
 BmRqz1Zdo+AQ5RzHpu49ULlppgdSUYMYote8VPsRcE4Z8My/LLKmd7lvCn1kvcTGcOS1hyUC
 4tMvfuloIehHX3tbcbw5UcQkg4IDh4l8XUc7lt2mdiyJwJoouyqezO3TJpkmkayS3L7o7dB5
 AkUwntyY82tE6BU4quRVF6WJ8GH5gNn4y5m3TMDl135w27IIDd9Hv4Y5ycK5sEL3N+mjaWlk
 2Sf6j1AOy3KNMHusXLgivPO8YKcL9GqtKRENpy7n+qWrvyHA9xV2QQiUDF13z85Sgy4Xi307
 ex0GGrIo54EJXZBvwIDkufRyN9y0Ql7AdPyefOTDsGq5U4XTxh6xfsEXLESMDKQMiVMI74Ec
 cPYL8blzdkQc1MZJccU+zAr6yERkUwo1or14GC2WPGJh0y/Ym9L0FhXVkq9e1gnXjpF3QIJh
 wqVkPm4Two93mAL+929ypFr48OIsN7j1NaNAy6TkteIoNUi09winG0tqU5+U944cBMleRQOa
 dw+zQK0DahH4MGQIU0EVos7lVjFetxPjoKJE9SPl/TCSc+e0RwARAQABtChIZWlucmljaCBT
 Y2h1Y2hhcmR0IDx4eXByb24uZ2xwa0BnbXguZGU+iQI4BBMBAgAiAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVAqnzgAKCRDEgdu8LAUaxP7AD/9Zwx3SnmrLLc3CqEIcOJP3FMrW
 gLNi5flG4A/WD9mnQAX+6DEpY6AxIagz6Yx8sZF7HUcn1ByDyZPBn8lHk1+ZaWNAD0LDScGi
 Ch5nopbJrpFGDSVnMWUNJJBiVZW7reERpzCJy+8dAxhxCQJLgHHAqPaspGtO7XjRBF6oBQZk
 oJlqbBRFkTcgOI8sDsSpnsfSItZptoaqqm+lZpMCrB5s8x7dsuMEFaRR/4bq1efh8lSq3Kbf
 eSY59MWh49zExRgAb0pwON5SE1X9C84T2hx51QDiWW/G/HvJF2vxF8hCS7RSx0fn/EbPWkM6
 m+O1SncMaA43lx1TvRfPmYhxryncIWcez+YbvH/VqoLtxvz3r3OTH/WEA5J7mu5U1m2lUGNC
 cFN1bDsNoGhdlFZvG/LJJlBClWBWYHqHnnGEqEQJrlie9goBcS8YFUcfqKYpdmp5/F03qigY
 PmrE3ndBFnaOlOT7REEi8t3gmxpriTtGpKytFuwXNty1yK2kMiLRnQKWN7WgK70pbFFO4tyB
 vIhDeXhFmx6pyZHlXjsgbV3H4QbqazqxYOQlfHbkRpUJczuyPGosFe5zH+9eFvqDWYw2qdH+
 b0Nt1r12vFC4Mmj5szi40z3rQrt+bFSfhT+wvW9kZuBB5xEFkTTzWSFZbDTUrdPpn2DjYePS
 sEHKTUhgl7kCDQRNoN4KARAA6WWIVTqFecZHTUXeOfeKYugUwysKBOp8E3WTksnv0zDyLS5T
 ImLI3y9XgAFkiGuKxrJRarDbw8AjLn6SCJSQr4JN+zMu0MSJJ+88v5sreQO/KRzkti+GCQBK
 YR5bpqY520C7EkKr77KHvto9MDvPVMKdfyFHDslloLEYY1HxdFPjOuiMs656pKr2d5P4C8+V
 iAeQlUOFlISaenNe9XRDaO4vMdNy65Xrvdbm3cW2OWCx/LDzMI6abR6qCJFAH9aXoat1voAc
 uoZ5F5NSaXul3RxRE9K+oWv4UbXhVD242iPnPMqdml6hAPYiNW0dlF3f68tFSVbpqusMXfiY
 cxkNECkhGwNlh/XcRDdb+AfpVfhYtRseZ0jEYdXLpUbq1SyYxxkDEvquncz2J9urvTyyXwsO
 QCNZ0oV7UFXf/3pTB7sAcCiAiZPycF4KFS4b7gYo9wBROu82B9aYSCQZnJFxX1tlbvvzTgc+
 ecdQZui+LF/VsDPYdj2ggpgxVsZX5JU+5KGDObBZC7ahOi8Jdy0ondqSRwSczGXYzMsnFkDH
 hKGJaxDcUUw4q+QQuzuAIZZ197lnKJJv3Vd4N0zfxrB0krOcMqyMstvjqCnK/Vn4iOHUiBgA
 OmtIhygAsO4TkFwqVwIpC+cj2uw/ptN6EiKWzXOWsLfHkAE+D24WCtVw9r8AEQEAAYkCHwQY
 AQIACQIbDAUCVAqoNwAKCRDEgdu8LAUaxIkbD/wMTA8n8wgthSkPvhTeL13cO5/C3/EbejQU
 IJOS68I2stnC1ty1FyXwAygixxt3GE+3BlBVNN61dVS9SA498iO0ApxPsy4Q7vvQsF7DuJsC
 PdZzP/LZRySUMif3qAmIvom8fkq/BnyHhfyZ4XOl1HMr8pMIf6/eCBdgIvxfdOz79BeBBJzr
 qFlNpxVP8xrHiEjZxU965sNtDSD/1/9w82Wn3VkVisNP2MpUhowyHqdeOv2uoG6sUftmkXZ8
 RMo+PY/iEIFjNXw1ufHDLRaHihWLkXW3+bS7agEkXo0T3u1qlFTI6xn8maR9Z0eUAjxtO6qV
 lGF58XeVhfunbQH8Kn+UlWgqcMJwBYgM69c65Dp2RCV7Tql+vMsuk4MT65+Lwm88Adnn6ppQ
 S2YmNgDtlNem1Sx3JgCvjq1NowW7q3B+28Onyy2fF0Xq6Kyjx7msPj3XtDZQnhknBwA7mqSZ
 DDw0aNy1mlCv6KmJBRENfOIZBFUqXCtODPvO5TcduJV/5XuxbTR/33Zj7ez2uZkOEuTs/pPN
 oKMATC28qfg0qM59YjDrrkdXi/+iDe7qCX93XxdIxpA5YM/ZiqgwziJX8ZOKV7UDV+Ph5KwF
 lTPJMPdQZYXDOt5DjG5l5j0cQWqE05QtYR/V6g8un6V2PqOs9WzaT/RB12YFcaeWlusa8Iqs Eg==
Message-ID: <78963dea-9ac8-8fd3-c3cc-6237eee6f974@gmx.de>
Date:   Fri, 22 Mar 2019 19:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322180922.nghzdmvqz7wsxcb3@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVkjyG05QnS3PHwW8contPql43z14b/qFkzLo3u8rxP0qdwwvWN
 x8DTe4VfcFU2T87tNO5tOkZPeOibr1AoQ8R+NVCDKpoWbWFswdJZAASthMswxvndjqpWZze
 hU+Z0OwQoPwTG7kyN6paYyA6q1bR8EURXPE9gFZtVRZtpglhq2hbI77f3J+yzoWoRXDIQL9
 +dPIagEqmLEimBqw2ZE7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DPcszxozsrk=:EV+yA3BSx+Un14CEvxgecA
 j5+3N2mJDSU13M4encmia8z4yREhx2N4B6TNhoFHrNPDGPvllJUgNuC7t6LmCHd2MVFD2weZ1
 fnkK5duxncpPMKJ09p3OPHFyCDeOZGJ1yLgSaH8uSPo4LZEH+ggT7yHc9yLzBunprEKuhxepN
 hLWNMUrfrkwwypzzT19EvwmGzf7kssXVXH3juWG3NZGeEx60ma8g6JFfXJQ3pkh1B1JR7q2et
 TcvofZ6iIqgwlqPZ3932SfqlrxTgOx7m2X5eaFGCTEaNujv0vmOnaweIAB8u+/JikiDIsBRUM
 +gdcB+zTXxcIs8hPFgfpYnFKzA6vdB6p/xO4w8dUiePszNjM5o6L9Vv2E+Q95slSKvOx3h8KX
 EL5tpe6UsdhnRHrG883dPuHvaZYms1oHoHfN0Ph5+6LZgAxpJo58IvvLZDLSmhb4VGdIwjbWy
 B6EBgcUfb4xcnr8G4BYdw9solua9TgXYbg13vb0YRS9vvSzDa43qK+P3Rw/cjeD4qPNoPbq4W
 eUz4gnud1EedXftlLuQ60jgmu+tTdI6hhFKIICesHLbDCJn0a1b+fZ1Gf6u1QNKIRMLL9zeLM
 x/dVNhu35uvlwcbopGQPe5KXyHm8L2cXuM4YLoygWrce58Ncw3RGi/RGMc4hmfvI86EJCiwa7
 OC6kAwEN8y3wqSvnSr9VCgUDO/g0i7SCJRX+wxUZfCONHg8rri5cGT363RqNKAFcSWD5pWrxx
 UyEAuHonznyi+6EPl8KgdXVEgURWgF7xd6xrbew7AWS5E2GplaQ/gdU10F/MLAu9Ft28D1vOS
 EA+2Ip59yAGMPP/TXNA3gttBKp3FwMqqG8PcDlwdDUfCmJ39kn99mWGj9Vo9eqrlBiXs9OJFv
 CbKdVoVhn+EaqabSZ5YCYZm7uK00k/nBpMvARbR3UdI+P9cXihtXkENlBgCAy2VZWlVjhlkXC
 SUZH6Kq4xTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/22/19 7:09 PM, Eric Wong wrote:
> Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> On 3/22/19 5:50 PM, Eric Wong wrote:
>>> I couldn't reproduce an error after porting your patch to
>>> master (commit 041f5ea1cf987a40 "The third batch"):
>>> https://80x24.org/spew/20190322163449.25362-1-e@80x24.org/raw
>>>
>>> So you might've hit an ephemeral error (bad connection,
>>> HTTP server restarting, etc).
>>>
>>> GIT_CURL_VERBOSE=3D1 git \
>>> 	-c http.maxRequests=3D1 -c http.followRedirects=3Dtrue clone \
>>> 	http://git.denx.de/u-boot-efi.git
>>>
>>
>> I applied the patch to https://github.com/git/git origin/HEAD.
>>
>> But unfortunately it does not solve the issue:
>>
>> $ git --version
>> git version 2.21.0.197.g3845f293e6
>> $ git clone http://git.denx.de/u-boot-efi.git
>> Cloning into 'u-boot-efi'...
>> warning: alternate disabled by http.followRedirects:
>
> It looks like you need to enable http.followRedirects
> (see the command-line I used above)
>
>> http://git.denx.de/u-boot.git/
>> error: Unable to find a00d15757d7a513e410f15f2f910cb52333361a3 under
>> http://git.denx.de/u-boot-efi.git
>> Cannot obtain needed object a00d15757d7a513e410f15f2f910cb52333361a3
>> error: fetch failed.
>>
>> In Wireshark I see a lot of '404 Not found' codes.
>

Yes, git HEAD + said patch works with this command:
git -c http.followRedirects=3Dtrue clone http://git.denx.de/u-boot-efi.git

http.followRedirects is documented in man 1 git-config.

Why would git prior to  17966c0a63d25b1cc2dd1e98d30873e643bd581f~1 work
without this redirect parameter?

That following redirects is not secure is already described in
https://github.com/git/git/blob/master/Documentation/RelNotes/2.12.3.txt

Best regards

Heinrich
