Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A2C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606A8206D3
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 18:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fKi/joQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfLISKV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:10:21 -0500
Received: from mout.web.de ([212.227.15.4]:49453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfLISKV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 13:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575915011;
        bh=gIaC5wmofMwhYJTT7dnj94KVT2DZmCtsCOyDFAprAlM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fKi/joQwMBGtdp0Wq33ptXpkx0xGA1ByhdN7uMO5dLN48tm4+wyJzdJwGSZnuN5xg
         4UxAGAdMydee8xZm5SgySrqb8vwl/fR4kgdEbUy7tAPho6OYZYpKg0kTcCq9izaloL
         QhzwKoUqn6nL1hwCBLiiiYXj26i1mKK40+QlOtFE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M1noI-1hkkjB0fsI-00tiKw; Mon, 09
 Dec 2019 19:10:11 +0100
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
To:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
 <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
 <CAPig+cTrAsn64S0Qm7PdJVFhsquVA3+ugwngLpo1S4yUjMcrGA@mail.gmail.com>
 <58a3e2c4-4c5a-e276-f74e-128438f2ab40@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a9c2c409-778c-48e2-e6d5-229eab45a707@web.de>
Date:   Mon, 9 Dec 2019 19:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <58a3e2c4-4c5a-e276-f74e-128438f2ab40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l+fOpjv3KHskv4eftL7s0Tr18Hl7YkSZsiapmhgkRFfickZalNe
 qOrh1/n3oM8m8ojFymaOAnHdHCP/+n/F8V2uQKcxNQ1RNyffsTGoW0LEgblhDcRGRtdj7H+
 uFCsOredhLoI5ZKEnc1ngDQgai4j8JEjgabK6lnBdtgcv9wluwyoGnYtvPqAdFyWo4IDxZT
 /20vQh2B/rRTzAkZR7k+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y0LGj3eibR4=:0cgCCVY25W+cxJGsU3EWyn
 aY5ilUPNYc73y80T8A/Zb3B0EnfFDahNrdSzWbhtkc+SE+B+T/hT2nEsa3SW740cco/kZ1uyL
 dSP0jJ37i0aaLmaYKHyP9+nk7920WY6Ey+YjhBq1fEpcXe2dV6QY2+/LNCJDJ3NHY+nUnesFG
 sOctVwCZsHkNmtYxpLzVZz/GUO1gNH9O3XFxIvG7ZOgqfunkt/3jsnPkBy1ofLWSeH/sjX5oW
 gnaYvP0OCiw6iu1SvIHm6DXug1S88IJamqlbjw9cwqKbaVNDDGQKdNb+XWLjRCJ8YeAlelbeU
 Mr4EDJldMWb9kNXvta+CMmWVf21urPgn6ewY71nPrv3Njsz1j4h4G/k7/I0J7oPuuDpyxCCsR
 S1y7ArYVnvixCqg/V7OLrxKWFJ2JMwsI2bUCrrv8i8eGdbTaXJmDmT3ccuQqPtEZYT3tnsYsC
 Jk8kkE0D0NgNkeI1XSdltDSlSmw4FMPrDZwL8lTuc1e5N2Ng4qoMhWwgV9r79i2dv2ifKrpzn
 whlUELwwhd9vem7AES2bqDi9p01W1qnQkG2mA46WCE8a9cYMU5GpNndZF2zNrl7BZgUg2KZWn
 chVOovSTmjeMPN6+iiyG9P410ss8KrrIwCMMq/eBiLfBTAvcRVMLYhgSNf5CfjxlnXolWRPJL
 r4U76/mv1pO+VNQRhVA+dWedi+TOcP18i49Lec2DrkywnJWG/ZCYT0hDZgBUmeLONkdENZujg
 pbhHGt85Cf7cNGcE2xBr8hUZImeNrMghHKK5x0TcDl0nBkQWuNPIYu9ZuL3sUh1aLzpy/cDmb
 IJCcXyPmGLbcVEmr0JulFMuvFFZRikbpIa5L8BoI414niUdfXYN7iCIxBVPAFAXzhHgmhdiAY
 hQTODEEijqvCUq0Lm68X5Wo5lK5H2KcOCVpa7tCouKRD3/HQmIE3h0l2j2pqJhommUKqMrgs6
 qDcjV3322Ws3SXMBsIhAZXTlX2KhncGwdZQiRQt69UbjbALH9n2Wfg4oSljOk3IaOvu75JExe
 oHSqkHxn7/3QBnRKTqMkw3mPdc8dkNXWfZoKTrXdRPdlTC+NQBA3CPBgHOiLxu08eKD+2ql9y
 cANl+kX1GlcDnyEbcrL/RHPWLUMv1zklulIMr6MfzoA3xXVlk9UvkMDqvCbvT16Qdj97vtT5g
 VVgsKbD53qC6Aqa0RI0s1ZYF2t/pLs0yjUCpzYSDdTL0OAnJMNDSpvkyALlAKNhZGuyThIdkm
 8YROmvct0wAnBNOqEAOQfkt7rAghJqctpjioEFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.19 um 18:44 schrieb Derrick Stolee:
> On 12/9/2019 12:19 PM, Eric Sunshine wrote:
>> On Mon, Dec 9, 2019 at 12:11 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Am 09.12.19 um 16:36 schrieb Derrick Stolee:
>>>> Ren=C3=A9 Scharfe  0bb313a5 xdiff: unignore changes in function conte=
xt
>>>> xdiff/xemit.c
>>>> 0bb313a5 223)        xchp->i1 + xchp->chg1 <=3D s1 &&
>>>> 0bb313a5 224)        xchp->i2 + xchp->chg2 <=3D s2)
>>>> 0bb313a5 225) xchp =3D xchp->next;
>>>
>>> Hmm, line 223 *is* exercised by t4015.85.
>>
>> This, along with Dscho's[1] review of an earlier coverage report,
>> makes one wonder if there is some off-by-one error in the reporting
>> logic, such that it is reporting the wrong lines as not covered.
>
> This is definitely possible. I'll see if I can locate the bug in
> my report-generation code.
>
> However, line 222 is here [1]
>
> 	while (xchp !=3D xch &&
>
> So if this is always false, then the rest of the while condition
> will not be tested, nor will the body (line 225: xchp =3D xchp->next;).

0bb313a5 also added lines 228 and 229, which are not in the report, so
xchp !=3D xch must be true at least once (it is, in t4015.85).

222)				while (xchp !=3D xch &&
223)				       xchp->i1 + xchp->chg1 <=3D s1 &&
224)				       xchp->i2 + xchp->chg2 <=3D s2)
225)					xchp =3D xchp->next;
226)
227)				/* If so, show it after all. */
228)				if (xchp !=3D xch) {
229)					xch =3D xchp;

> If it's just an off-by-one error in either direction, then line 224
> still is definitely not covered (which would imply that 225 is not
> covered, either).

Right, hence the patch for t4015 I sent with my first reply.

Ren=C3=A9
