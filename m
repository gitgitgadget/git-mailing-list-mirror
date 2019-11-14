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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6351F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 08:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfKNIPv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 03:15:51 -0500
Received: from mout.web.de ([212.227.15.3]:44243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfKNIPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 03:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573719348;
        bh=Yjq0F3Qx1hmdo/9Wm+sSRRsIkDgCuiLk00npVwO3P+4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kH3kZJTHm4fMx2OKa7T2ACbOgGDOvEUz+/m/H3s5iXBSHcc35XD+tiHxKEdZ8CwdD
         VuatFHXVcFka9QzOlp4Y3ywIYiEWePPvg/KXlhYMqCZkpYcUnuHSwfa21gpbsDqYek
         hHZgppav9CmnzqdT1NBeOfgvZ2dxtIoU/sqpgJJ0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MarZy-1iBykY0VeU-00KOVF; Thu, 14
 Nov 2019 09:15:48 +0100
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
 <20191112175926.GA41101@generichostname>
 <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
 <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
 <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1d08b49e-1f41-4290-a64b-dad9fd2288de@web.de>
Date:   Thu, 14 Nov 2019 09:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:b55C4gwUDs1HcIh3yAffIf50ca5sKeXH1LqyWsIYYluv80fKfvd
 7uYH+gDAlk3CMVPzScwxgP3BEZeikX1veZ9vhjJq0KopXh1c3RcJf0yaL/6PqXl93Zy5gkD
 cssO/3X+/Rrhs2/3avBl5Am9wkpx7ECjJmElG7xiO5F5ezZdgEeh1IRJ7cCZSm8jkEQpN3u
 8rwq8sxMn1PuHAV7+IRpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qmno9zNcegQ=:xja0xk+nYqiE5v2d1YZch5
 s1D83HO9fpuEXFGy0QfiV2PgkONaNxPDTLtzPWFRitx8DFKThbr7gCRf1uQBZsIw4XdEemW7c
 sM6DD1ht7toN0vqda2HeJpkIINUgj8NVaZaBlbIZHeYShgwIXeUdKl1+ixiONtHbq1Tca1oQi
 VCv9y0Jja1Hc5qAT0YRnxhjlbrWOA2fVkj6GSdiB87mJkP3zhaw/12zTrz4XKV/S3NgNePOjA
 Yhu+2CZu4hC8eLo2YV1cOOQDrXRt+a92A6yqf7M7xevMQbpOr4ODRVqCcL401GSWDwUphYgtn
 3eWCwwWoBDanPCbZByZIXLlDjHtU13iU5yww1sgCQm5a2O07DTmTiZnR93i4DlIavcKesWlQB
 qL1uOjQe7LXBm9ADEGX5JU3dE63KXPDemOp9dNwgR21tCJhtYcj3Qtr3QKn8puuYlKctOnq64
 CVJ61D9OPsD7rnEknLYd+y9OIlZcPc6jx7REOxUN8sMDagYWomjaPv6Rq4SUj1U2zncTLGE3z
 XE0dWTGGntPUoVYubLIn9U1sgKIj2TUzMT3iP5IY4hh1BFfDI7FSyD9qfR5VnQwzRfZzRUr+L
 H3tJwV9HR0EQPoe5UbHefFBhfK/h7FveOwCP/kRHNRBL7u5PjUSduiwlcUPCCr/ChSjW+xMlm
 Q80tJ+DNKNPKeBmPpNgzI9cB/g8YKuxA9aIqNMYM0SovUI1gq6q0XDYF5oc40RyjEt4Vf1zsL
 H+xW6lDz+LLOTWlo0cjR+j99TFg+VhHemZHgMsSOslODYlqEvw61+K+EWSLhZphOQFDtklAaN
 TPcFl00t8xOjjL61tkZlyII3ydn1xcM5yFQTq3JmogC6OrU+fgvKG2zNY0O82NneoTd0deriN
 5PqB8HUcjfptp5nBDwCGVFvJSO3yyZLPm18qvQ62Z4dAfBs7+94shVbrHcIuJip/gigDrdfHz
 3ccAtPOfE8TelazI4iXx7TzNMcBH+3iarHb2BajIbK3d32aIngaYLBJxIjtlKbtv5BxiWjKnQ
 6W1HAoRDcCab7NEuy9fWE2zxn4akB3yUqJJ+P3HkgcMp18WFqJL0KQk2kcX/QnCnWrOziaQt7
 w3tXijyWkfJnUZjN82WO7ALjH3TEQv502SzBfXYxMRRGp+X2xrTTRp9HriCjSN4AgbAH4hqqs
 Qdl7Qft9icGpgI+a/aex4znldpxcaf5WYTL/FwvCGKKxC2/x0WC83d4PcS5I1Zn2cLNq2uoLU
 SgnsmaD5punMqbnetSIyP0yCTgG/0UoOnxXZ3Qkg5UQRpQAzyX2zPHedVyNQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If you could have some before/after numbers, that would be cool.

Does any test infrastructure (or benchmarks) exist which you would trust for
corresponding comparisons of software run time characteristics?


> If you collect your patches into one series, you could at least do measurements
> before/after the series.

How do you think about to check possible improvements by each presented patch
according to affected SmPL scripts individually?


> Or if you could make some other sort of claim around "this shouldn't
> affect this-or-that because so-and-so".

I try to avoid such claims.
But I provided specific information in my patch descriptions.
Do you find any details reasonable there?


> Do you mean whether I would like to clarify the risks I see, or do you
> mean whether I would like you to clarify which you see?

Both. - The discussion will depend also on your change acceptance and desire
to extend development in the shown software design directions.


> I've tried to clarify the one I see -- based on passively observing cocci-related
> patches floating around this list.

Thanks for your interest.


> If you see other potential risks, feel free to mention them.

I would prefer a more optimistic view while my software development
experiences can influence this considerably.


> You seem to know lots more than I do about these things.

This can be. - But I hope that you can get further inspirations and ideas
if you would find any of the published development activities interesting enough.

Regards,
Markus
