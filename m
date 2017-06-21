Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927AB20401
	for <e@80x24.org>; Wed, 21 Jun 2017 22:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdFUWkd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 18:40:33 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35833 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdFUWkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 18:40:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id c73so31200573pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GdCLPhsXJYrOqGBLgk5ekOnhwN+uxN/DdayCeE9sDPQ=;
        b=cJMEic6D5oJ8+fwMb6GpLvQm8Jyvh7sEqNt6foeGFkPU60Xd8zZjwW327BcE4gCFcf
         7vFl4892dMaL5EAnymR0l8mxN7YXDKqvonCQU4h0nC5dfrpCLRxboznZwhmF+opITpkM
         /SYaharMGX8mgDCA26cXxN1g5pHgVwda+gOTkMitCALh1MaMqU9iEqYYXb9rwHWvOw6Q
         Cv13+wXMr+SoNfti6OO/H/P/iaD2UnSEo2GFTAFpPVNpNmwqswB/t0g0SW2qUCAFbC1W
         WrSi7/XNmVl8kIdXO/aszkuBOcFyL/WPDLQsnQsrKdb1XPADk0HgwBZbBcGYs4uqDZtz
         a+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GdCLPhsXJYrOqGBLgk5ekOnhwN+uxN/DdayCeE9sDPQ=;
        b=Lft/TjWem8oPky2fm6id2arFGFZSuuruRGWs42kK77iOM6Kjcn4nB5fiKCCQ2xW98c
         +vDbdS3n+H/v6ef0QpP0PJQFB7SEWjtOlubuEaqP9cuLf0Fy8Vq01t6QOVRj1ggBFouM
         q4Tgo27lqij2cLS+HCwAcbfk/ie1ogKv2JJeOm8xB+FJ8NSQlY61C8UpHaa8w9WyKkyq
         18D0p4BIwBZOtPHrThIem3l1am3DO7Q6CYwk6FDlcn1I0S+T8ytsX0Fg9k5Gx9wSMSI1
         gBX/GKCywsl7jTUPIgTXeE3P/a5VzdK1ZIcnYxiiX7l2Q6b3sPVlv1xDi3fHJRCPyTAY
         opkg==
X-Gm-Message-State: AKS2vOyQAf8tDCX/p+BfBbZ+8oY+w4/vOnkFU0HC9VxFrl568Nt+BFTJ
        NPjnKiz8A4miY+iiMTiLpuO5QvxtaRB2
X-Received: by 10.98.85.196 with SMTP id j187mr4796967pfb.19.1498084831853;
 Wed, 21 Jun 2017 15:40:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 15:40:31 -0700 (PDT)
In-Reply-To: <xmqqh8z9m2ed.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-27-sbeller@google.com>
 <20170621215104.GF53348@google.com> <xmqqh8z9m2ed.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 15:40:31 -0700
Message-ID: <CAGZ79kYDBZG4AOueJjvQ61yyC-DQk-8cb5-y18fg2k4JUsQPKw@mail.gmail.com>
Subject: Re: [showing-off RFC/PATCH 26/26] diff.c: have a "machine parseable"
 move coloring
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> On 06/19, Stefan Beller wrote:
>>> =C3=86var asked for it, this is how you would do it.
>>> (plus documentation, tests, CLI knobs, options)
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  diff.c | 15 +++++++++++----
>>>  diff.h |  2 ++
>>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/diff.c b/diff.c
>>> index 7756f7610c..61caa057ff 100644
>>> --- a/diff.c
>>> +++ b/diff.c
>>> @@ -997,6 +997,7 @@ static void emit_diff_symbol_from_struct(struct dif=
f_options *o,
>>>      static const char *nneof =3D " No newline at end of file\n";
>>>      const char *context, *reset, *set, *meta, *fraginfo;
>>>      struct strbuf sb =3D STRBUF_INIT;
>>> +    int sign;
>>
>> should this be a char instead of an int?
>
> Perhaps.  Once we start adding things other than + and -, I think
> they should no longer be called "sign", though.

Well 'sign' is currently meant as a mathematical operation,
but it could also be meant as a street sign?

The empty sign ' ' tells you it is context, and not subject
to bikeshedding whilst reviewing a patch. :)

>
> If Stefan chose '*' as a replacement for '+' because both makes
> things larger (yes, I am a positive person and my numbers are all
> positive), probably the replacement for '-' should be '/' (or '%'),
> not '_'.  But that is just bikeshedding.

I was trying to choose characters that sort of resembled the shape,
but slightly differently. But a machine would not care any ways.

There was also temptation to use bogus signs like 'M' and 'm' for
moved (capital M for + and lower m for -, obviously).

But this is a proof of concept on top of the series showing that
this way with bits set in the flags field we do not need to have
colors. The older series was operating on the colors and by that
figuring out if it was say at a boundary, but here we would just
use the flagbits to come up with a reasonable first character.
(for example: Would the machine parse-able format also care
about dimming? I defer such a discussion in the future.)
