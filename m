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
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF7A1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 13:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfKQNkr (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 08:40:47 -0500
Received: from mout.web.de ([212.227.17.11]:41955 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfKQNkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 08:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573998046;
        bh=13G9WpUMzinO0/PTzSTVIOlDwokJa948B7LL/FExcH0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OQcWfe0V5d4mTdS/lvbBJTmpDFIlLO+J20yb/s7fUuigBlPjgfXnJr6S1gwGJiZvN
         dlq41GidOUAP6GBHjLNdOnnYjTSdkrFuU/2dNNdxxcDgrbrsCEYdw1r+/OE4vFLUPu
         h7fkbE/fV/0z7EhpAm9mdOXKJTXbkIwDdLEtNYsw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQKW-1iFlJS1Mzk-00Imt2; Sun, 17
 Nov 2019 14:40:46 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
Date:   Sun, 17 Nov 2019 14:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SqcOPCWQv26jfW6Xc2HrUvDw6/+KIdaREWBDoBvBZPiFm2Wjpiu
 XYtoC0WefhIlCr/XKV4SzrmtBv2S13r7NUV3HR4/Unp0zlZHJXfrm5HsF2zrbgrU4gfjZIN
 ZX8WzsiFY9usJHNc03p8MYsMUn0HSHW5XnGi6+v3oQpV3AJL0g+IBEtWGf+HZXCQVxv+f+M
 xb2Gam2xGN/ySGIwzbDcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JZR3MTrh/Nk=:UXVJ8Q1dUn8ez4lFgGToBF
 w2M0N8K2Q10zih5xqS2kQXI8mkNygZCRFRt+cuKoIMFd++BNgq8A6FmGwO+xNtY0yGqBrqgr8
 0sFIditnJi9hBMddStC3JLOJcLmOG7ps+48wK5Z2KFL81Ytn5BHWnbF5I40bnMzAwDqHaZ38z
 ZCc1Li0+GrEumEAKYYqjpsZXigfpjeipvBzbKfEJknwDMO1A/AWX4fcJ0fIhDzrYVZgD/QZF8
 FbfocIHjuhT7l1SkvFquOxsfBq8rfklHamzXJL5B1YoIeq9/dLtYOfvQQQH5UwtN1SpWV9AWg
 23zg3KhjrauGjiiBLLuGSXrmcegSKb3VGHcu9xDwtavUQl0PtGH6YxkkYaY3IJsVJlwAfg+t0
 kYzwcVk/ABzFZm7ckMxAJhfcYXXT5FM9wXCBQqB6fq1sCEP7D/Jf7ZIVu/r4i6e2ND14xvGjt
 biUV8UFkyQCFroobQ0JUXtduArlBj6yLE26wAg9x035vZppMxag77Nwrfc3SiP8DxOoa5f9e5
 i9Zluzvo3N0jCRWmVxZF/jMl7AsuWxsCHqc7uDWuq9X0EJrqerJkcaTLF6YrdHdnhjQ4/HrEO
 dWkENqGx0OqLPnOmOuEgud996x5NIpOVq68cgxcd9rRHLZm/VG2zpZpHDxlZLrYo/xig/hAAy
 aRnjBZ4wR4cRlqCaxdcI2wL4MOfrmr9UNlAyqFn9uFkC1rpGb9kIz5YqQJ+EBlL4fzkAk6B9R
 dMnnGnLxHHfpfI5oIFuuUt/z+YhL+QNDBVZdd3B7cHTTEKl/e66fFCI5kOOTvX33CIp2L+ttG
 VFT2HENk/c3EgTYb64r/9Zd/EuD0eqJMJKhmi4cc/VhV2CgnpBcU2YxL8VkZdOu+bOEcFHyCe
 TA1ngvHncFrGd856U3oGb+t33rGT2IWVY+jY8QmC4OGgJSZPHZadAXe5vF41o2Gu3MURLfG6f
 LPTO3SoJhIqkHD3b6jP3U6iCVF+GrIQmdY4VZwKR7LWHN3Lwbwn2f2GGgfg3ePaz3r22L4X25
 sHXjoxsrl33/VkQfvc/d96iZZnEd6+nttU5C8LLN6f9zOrh9A4lBaZ1QKyVZY/9KSxSYpC2bK
 Z8GYTDO7kzNjuS1XqvO/szIZ7pgPCH2xtFSla9lA4T/hl4Y4srWyxNsn3TKEkNE9Rx6XT649+
 MA1nuE8DIBTFC1otZL7c21i/0Z8DuyOhvRRgDoTqVi1leuqRHpA2EtkZ6Xh8wv/jKbruSgia2
 AxckAWMJOj8XhsfoQRtqVwgpbXSqP4V02arVAiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.11.19 um 09:19 schrieb Markus Elfring:
>> Which transformation rules are questionable and why?
>
> It was chosen to transform source code fragments (pointer expressions)
> by two SmPL rules so that the search pattern =E2=80=9Csizeof(T)=E2=80=9D=
 would work
> in the third rule.

Ah, right, it would be nice to get rid of those normalization rules,
especially the second one.  I don't see how, though, without either
causing a combinatorial explosion or loosening up the matching too much.

>> Matching sizeof of anything (with the x) can produce inaccurate
>> transformations, as mentioned in the other reply I just sent.
>
> Would you like to apply any further SmPL code fine-tuning?

I guess that's a question for Junio, and his reply in
https://public-inbox.org/git/xmqqa790cyp1.fsf@gitster-ct.c.googlers.com/
seems relevant.

Ren=C3=A9
