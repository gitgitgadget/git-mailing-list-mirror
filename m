Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 598541F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfKPQdi (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 11:33:38 -0500
Received: from mout.web.de ([217.72.192.78]:52533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfKPQdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 11:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573922016;
        bh=fIGj3B8UjdS/x1Yu3pxpwBjJGUjlaMCR2rrfytYM16U=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=q2NzPVCV1VvNpMyfxhzV1dQQFnNpS3Koi6x/zva8/j6r4gK0FI7fJue+n4JSlDJVE
         JZr32eDMyT+VYlmSn4ThRjT6TVZ1NN4FKSJ+8Igq/HHdwyUkNhqS/Fyes2UHPqwXSP
         gzK0QOheQTYvAJbGVe4rUi0UAa+YZMzkqP6yt+XE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.152.34]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M0ymZ-1hjYYa3HuJ-00vA8I; Sat, 16
 Nov 2019 17:33:35 +0100
Subject: Re: coccinelle: adjustments for array.cocci?
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <05ab1110-2115-7886-f890-9983caabc52c@web.de>
Date:   Sat, 16 Nov 2019 17:33:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:6X6BbMfkyFD5bTQgTL4+0BKrU9hDu4v9aVTTt82xlllCl9Salzu
 0ZyABn4fjvq4oPTe10SlAp1c41RLEdfD+XpLo8mPrbZkfM9nLLvkWnS5U16jmUYkC+qXX58
 rxEjHuAcf7A7NI6ZkGrSIsNyF7PWrwAbhI6YfTk0J7GqJT1OUvQ0JCiZNr7Rjgn+9BfK8BD
 Tojsh4kMY7tZ1FRhi2q3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Q9VHKihQyE=:8vjwd59JhskGrQjko6YjEL
 leISWabqZxhS1bvCbEDGOGtaPjXFx12TlW9fYtprT8JGkTdYyR1kqCvpoB8KPAcMUtMDcFHwk
 qE515/Qbac8vshHb7nsz9NbQ2atLMgeq020PWGnBXm+YLyrht4qzr2pUQx22D4DLgQ/kX7lxV
 L9BBqv9fqYA9XWsenItTZ5vX2K/qAJOVKlNqqFscQmLGeXBJhN4zeVOvUZkGuHEfBH+VdgvAs
 1PenEjYpSr3dX/+cG2Y+kah9SoDIiFDd/XOVUK8E9PAgHeR04dT7o6BcemBtszBBxvUxiFVfx
 fY5V2UBqi0GTgaOQklSj+4SRPPDsEh/r9QWdLFfudGuK+6vEkaRv7eBx5XRpAi/sBlGfe96GW
 ng3Wo0ZR832T8xQ3Rcx2Jz9qtg5HyuPb4/bNEEZFS6/VwXQIUeI8+4hL1YOEg0mOacWrCB8dX
 tbRi1nYhg/y25XmXUsw9WxWLyw2TSUAu9QEiAl0t64bhpI/UwzlJgTbyL6PgX2KgElIQRgMFP
 LNXKyyOahQRdRQELQ2rHuKcUNTtxaz6jSX1lTq2y9Utpl/A+ZkJ0SJDXlBrWBq+T1gM01/ZTJ
 Fzxi2VDIEgWAKXbhLQ0BgClmsOJH+QVdFSw5ssbaaExO4u53zoN57qD0W9mNa+UBrpq5ayVX6
 nNYt25jESTgJQJeWCI8M9R7fZ4qBQLnKLCMzqKsdB5TXD5z5g4rKvhAhiTiZxe3y3NqARwsrG
 5LxpOwN/GFG7qqs1tVU/0WZbw5VPn6eHIjpaSU551ZY7w9hmoUH0hq1OXlwwoxBN46hxpUR5L
 1aJmNjtlO51U0P1cswXk2mPpwkPbT4lZTv/SthRfugbKtAS16DcvR/2cqpDnMv8Zp4FZLEpJm
 ZvW56KtEnes4wMYI6EzDEJlOisoA3yCT79wT2GP82Xu1RV0seTiRCbUbhoV+5FxoI+uoQI6EK
 FCEpSN1JBZph+bVH/zsDtJV7ypHBzP47zo0No2V/GmO3nIrPEwPRzjVEFbwo4j7511F7oy52j
 ug5tHRiLpnQBVfRLvfRm812aPwP3tfilrTbMOEUfg2FeSEvOflB6JnQLb5YuUBiqU264Zwx/T
 pdDY9/7GgVaEsJBxTSBpSpSBj8CbO1bjQIxTjhurdEox2Dye30k/iJCHLsKLXrMVIpZDmUOhC
 IBH+/dA9fUOwm8IFJIHFQF6DKEqadwrx3lhYIIpRGX7nXlz8LgydZswPBd1ZMDTjMf9Nq6oMW
 t2Twq1wk3Rjmx24QRQuB/5/b7WVJ8WDsULViPTQqSPykFdYklXZ54MKwCD/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This reduces duplication in the semantic patch, which is nice.  I think
> I tried something like that at the time, but found that it failed to
> produce some of the cases in 921d49be86 ("use COPY_ARRAY for copying
> arrays", 2019-06-15) for some reason.

I propose to integrate an other solution variant.

* How do you think about to delete questionable transformation rules
  together with increasing the usage of nested disjunctions in this script
  for the semantic patch language?

* Can a single transformation rule become sufficient for the discussed
  change pattern?


@@
type T;
T* dst_ptr, src_ptr, ptr;
T[] dst_arr, src_arr;
expression n, x;
@@
(
-memcpy
+COPY_ARRAY
       (
(       dst_ptr
|       dst_arr
)
       ,
(       src_ptr
|       src_arr
)
-      , (n) * \( sizeof(T) \| sizeof( \( *(x) \| x[...] \) ) \)
+      , n
       )
|
-memmove
+MOVE_ARRAY
        (dst_ptr,
         src_ptr
-               , (n) * \( sizeof(* \( dst_ptr \| src_ptr \) ) \| sizeof(T) \)
+               , n
        )
|
-ptr = xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
+ALLOC_ARRAY(ptr, n)
)


Would you like to clarify remaining challenges for pretty-printing
in such use cases?

Regards,
Markus
